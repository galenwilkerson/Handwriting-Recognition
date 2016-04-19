import preprocess

filename = "../data/MarieTherese_jul31_and_Aug07_all.pkl"

# preprocess the input file
preprocessed_output = preprocess.preprocess(filename, 10)

#print preprocessed_output

print("data preprocessed")

import cPickle

# save to file
outfile = open("../data/preprocessed_data.pkl", 'wb')
cPickle.dump(preprocessed_output, outfile)
