#import missings nn module
import torch.nn as nn


# function to create a 3 layer neural network torch model
def create_model(input_size, hidden_size, output_size):
    model = nn.Sequential(
        nn.Linear(input_size, hidden_size),
        nn.ReLU(),
        nn.Linear(hidden_size, hidden_size),
        nn.ReLU(),
        nn.Linear(hidden_size, output_size),
        nn.Softmax(dim=1)
    )
    return model

# main
if __name__ == '__main__':
    # create a model
    model = create_model(10, 20, 5)
    print(model)
