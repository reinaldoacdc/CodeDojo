import json

class Evento:

    def __init__(self, transaction_id, timestamp, revenue, store_name, custom_data):
        self.transaction_id = transaction_id
        self.timestamp = timestamp
        self.revenue = revenue
        self.store_name = store_name
        self.custom_data = custom_data

    def atualiza(self, Evento):
        self.timestamp = Evento.timestamp

        if (Evento.revenue):
            self.revenue = Evento.revenue

        if (Evento.store_name):
            self.store_name = Evento.store_name

        self.custom_data.append(Evento.custom_data)

    def to_json(self):

        lista = []
        for item in self.custom_data:
            if item:
                lista.append(item)

        return {
            "timestamp": self.timestamp,
            "revenue": self.revenue,
            "transaction_id": self.transaction_id,
            "store_name": self.store_name,
            "products": lista
        }


    def __str__(self):
        return  (" 'timestamp': {timestamp}, 'revenue': {revenue}"
                ", 'transaction_id': {transaction_id}"
                ", 'store_name': {store_name}"
                ", 'product_list' : {product_list} ").format(timestamp=self.timestamp, revenue=self.revenue, transaction_id=self.transaction_id, store_name=self.store_name, product_list=self.custom_data)

