import json
import os
from lib.colormap import get_color

def get_structure_list():
    structure_list = {}
    for namespace in dirs:
        has_structure = f'{root}/{fol_name}/data/{namespace}/tags/worldgen/biome/has_structure'
        files = [file for file in os.listdir(has_structure)]

        for file in files:
            with open(has_structure + '/' + file, 'r') as f:
                data = json.load(f)
            structure_name = namespace + ':' + file.split('.')[-2]

            for value in data["values"]:
                if "#" in value:
                    tag = value.split(':')[-1] + '.json'
                    if len(value.split(':')) > 1:
                        tag_loc = value.split(':')[0][1:]
                    else:
                        tag_loc = 'minecraft'
                    with open(f'{root}/{fol_name}/data/{tag_loc}/tags/worldgen/biome/{tag}', 'r') as f:
                        biomes = json.load(f)["values"]
                    
                    for biome in biomes:
                        data["values"].append(biome)

            biomes = [value for value in data["values"] if '#' not in value]
            structure_list[structure_name] = biomes

    return structure_list

def cd(namespace):
    #save path to the main text file
    os.chdir(f'{root}/{fol_name}/data/{namespace}/worldgen/biome')

    #search namespace's biome folder
    search(namespace)

    fols = [fol for fol in os.listdir(os.getcwd()) if os.path.isdir(fol)]
    for fol in fols:
        os.chdir(os.getcwd() + f'/{fol}')
        search(namespace)

def search(namespace):
    files = [file for file in os.listdir(os.getcwd()) if os.path.isfile(file)]
    files.sort()
    for file in files:
        with open(textfile, 'a') as f:
            name = file.split('.')[-2].replace("_", " ").title()
            f.write('> ' + name + '\n\n')

        #get JSON data
        with open(file, 'r') as f:
            base_data = json.load(f)
        data = base_data["spawners"]
        
        biome_info(base_data, namespace + ':' + file.split('.')[-2])
        with open(textfile, 'a') as f:
            f.write('\n\n===\n\n')

        with open(textfile, 'a') as f:
            f.write('{{Spawn table')

        #find the spaner data
        for item in data:
            #retrieve respective data from each spawner category
            if item == 'creature':
                if len(data[item]) > 0:
                    with open(textfile, 'a') as f:
                        f.write('\n|passive=')
                    retrieve(data[item])
            
            if item == 'monster':
                if len(data[item]) > 0:
                    with open(textfile, 'a') as f:
                        f.write('\n|hostile=')
                    retrieve(data[item])
            
            if item == 'water_creature':
                if len(data[item]) > 0:
                    with open(textfile, 'a') as f:
                        f.write('\n|watercreature=')
                    retrieve(data[item])
            
            if item == 'ambient':
                if len(data[item]) > 0:
                    with open(textfile, 'a') as f:
                        f.write('\n|ambient=')
                    retrieve(data[item])
            
            if item == 'water_ambient':
                if len(data[item]) > 0:
                    with open(textfile, 'a') as f:
                        f.write('\n|waterambient=')
                    retrieve(data[item])
            
            if item == 'underground_water_creature':
                if len(data[item]) > 0:
                    with open(textfile, 'a') as f:
                        f.write('\n|underground=')
                    retrieve(data[item])
            
            if item == 'axolotl':
                if len(data[item]) > 0:
                    with open(textfile, 'a') as f:
                        f.write('\n|axolotl=')
                    retrieve(data[item])

        #close off the biome
        with open(textfile, 'a') as f:
            f.write('}}')
            f.write('\n\n====================\n\n')

def retrieve(category):
    for item in category:
        #get name, weight, and size
        mob_name = item["type"].split(":")[-1].replace("_", " ").title()
        mob_weight = str(item["weight"])
        if item["minCount"] == item["maxCount"]:
            mob_size = str(item["minCount"])
        else:
            mob_size = str(item["minCount"]) + '-' + str(item["maxCount"])

        #write the data
        with open(textfile, 'a') as f:
            f.write('\n{{Spawn row|{{L2MCW|Page=' + mob_name + '}}|weight=' + mob_weight + '|size=' + mob_size + '}}')

def biome_info(data, biome_id):
    biome_id = biome_id
    biome_category = data["category"]
    biome_temperature = data["temperature"]
    biome_humidity = data["downfall"]
    biome_precipitation = data["precipitation"]
    biome_sky_color = hex(data["effects"]["sky_color"])
    biome_fog_color = hex(data["effects"]["fog_color"])
    if "foliage_color" in data["effects"]:
        biome_foliage_color = hex(data["effects"]["foliage_color"])
    else:
        biome_foliage_color = get_color('foliage', biome_temperature, biome_humidity)
    if "grass_color" in data["effects"]:
        biome_grass_color = hex(data["effects"]["grass_color"])
    else:
        biome_grass_color = get_color('grass', biome_temperature, biome_humidity)
    biome_water_color = hex(data["effects"]["water_color"])
    biome_underwater_fog_color = hex(data["effects"]["water_fog_color"])

    with open(textfile, 'a') as f:
        f.write('{{Biome')
        f.write('\n|biomeid=' + biome_id)
        f.write('\n|category=' + biome_category.title())
        f.write('\n|temperature=' + str(biome_temperature))
        f.write('\n|humidity=' + str(biome_humidity))
        f.write('\n|precipitation=' + str(biome_precipitation).capitalize())
        f.write('\n|rarity=')

        f.write('\n|structures=')
        for structure in structure_list:
            structure_name = structure.split(':')[-1].replace('_', ' ').title().replace('Has ', '')
            for biome in structure_list[structure]:
                if biome == biome_id:
                    if structure.split(':')[0] != 'minecraft':
                        f.write(f'[[{structure_name}]]\n\n')
                    else:
                        f.write('{{L2MCW|Page=' + structure_name + '}}\n\n')

        f.write('|blocks=')
        f.write('\n|mobs=')
        f.write('\n|skycolor={{color|' + str(biome_sky_color).replace('0x', '#').upper() + '}}')
        f.write('\n|fogcolor={{color|' + str(biome_fog_color).replace('0x', '#').upper() + '}}')
        f.write('\n|grasscolor={{color|' + str(biome_grass_color).replace('0x', '#').upper() + '}}')
        f.write('\n|foliagecolor={{color|' + str(biome_foliage_color).replace('0x', '#').upper() + '}}')
        f.write('\n|watercolor={{color|' + str(biome_water_color).replace('0x', '#').upper() + '}}')
        f.write('\n|underwatercolor={{color|' + str(biome_underwater_fog_color).replace('0x', '#').upper() + '}}}}')

#initial vars
fol_name = input('What is the name of the folder (case-sensitive) of the unzipped datapack? ')
dirs = input('Write the namespaces (minecraft, terralith, etc) that you want biome info for. Separate by spaces: ').split(' ')
textfile = os.getcwd() + '/outputs/' + input('What do you want the name of the output file called? Ignore file extension: ') + '.txt'
root = os.getcwd()
structure_list = get_structure_list()

#search both minecraft and terralith biomes
for namespace in dirs:
    cd(namespace)
