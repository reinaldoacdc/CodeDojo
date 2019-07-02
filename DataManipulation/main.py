import json
from evento import Evento

def find_dict(evento, lista):
    for item in lista:
        if (evento.transaction_id == item.transaction_id):
            item.atualiza(evento)
            return True



def parse_json(item):
    revenue = ""
    transaction_id = ""
    store_name = ""
    product_name = ""
    product_price = 0
    timestamp = item['timestamp']

    if ('revenue' in item.keys()):
        revenue = item['revenue']

    custom_data = []
    for custom in item['custom_data']:

        if custom['key'] == 'transaction_id':
            transaction_id = custom['value']
        elif custom['key'] == 'store_name':
            store_name = custom['value']
        elif custom['key'] == 'product_name':
            product_name = custom['value']
        elif custom['key'] == 'product_price':
            product_price = custom['value']

    if product_name:
        custom_data.append({'name': product_name, 'price': product_price})

    return Evento(transaction_id, timestamp, revenue, store_name, custom_data)

def main():
    with open('dados.json') as json_file:  
        data = json.load(json_file)

    lista = []
    for item in data['events']:
        evento = parse_json(item)

        if not lista:
            lista.append(evento)
        else:
            if not find_dict(evento, lista):
                lista.append(evento)

    lista.sort(key=lambda x: x.transaction_id, reverse=True)

    for item in lista:
        #print(type(item))
        print(item.to_json())

if __name__ == "__main__":
    main()        