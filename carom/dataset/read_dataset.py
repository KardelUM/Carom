import pandas as pd
import os
import time
print(os.getcwd())
df_carom = pd.read_csv("caromDataset.csv")

# make training (~500 samples) and test (~100 samples) datasets 
df_train = df_carom.groupby("Target").sample(n=167, random_state=1)

print(df_train.index.to_list())
print(df_carom.shape)
print(df_train.shape)
df_carom.drop(df_train.index.to_list()).groupby("Target").sample(n=33, random_state=2)
print(len(df_train["Target"].unique()))

def split_train_test(filename=None, size=0.8, random_state:int=int(time.time())):
    if filename is None:
        
    df = pd.read_csv(filename)
    Ntarget =  len(df["Target"].unique())
    if isinstance(size, tuple):
        # if size is a tuple, the first is the training size and the second is the testing size
        Ntraining, Ntesting = size
        df_train = df.groupby("Target").sample(n=int(Ntraining/Ntarget), random_state=random_state)
        df_test = df.drop(df_train.index.to_list()).groupby("Target").sample(n=int(Ntesting/Ntarget), random_state=random_state+1).reset_index(drop=True)
        df_train.reset_index(drop=True)
    else:
        df_train = df.groupby("Target").sample(frac=size, random_state=random_state)
        df_test = df.drop(df_train.index.to_list()).reset_index(drop=True)
        df_train.reset_index(drop=True)
    return df_train, df_test


