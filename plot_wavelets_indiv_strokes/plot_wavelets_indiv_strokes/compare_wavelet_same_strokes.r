
## For the "marie" data:

## - load data

## - split into individual strokes

## - for each _unique_ stroke:

## -   plot some examples of that unique stroke on one page, next to each other

rm(list = ls())

library(wmtsa)

infilename <-  "../data/segmented_flat.Rdata"
load(infilename)

param.names <- names(pen.data)[-3:-1]

## we only want acceleration and gyroscope for now:
params.of.interest <- param.names[1:6]
param.names = params.of.interest

##strokes <- split(pen.data, pen.data$Stroke_ID)

##unique_labels = unique(pen.data$label)

unique_labels = c("e", "r")

for (uniq_label in unique_labels) {
    ##uniq_label <- 'e'

    ## strokes having this unique label
    my.strokes <- subset(pen.data, label == uniq_label)

    ## strokes having this unique label
    strokes <- split(my.strokes, my.strokes$Stroke_ID)

    ## grab 4 at random
    num_strokes = length(strokes)
    strokes_sample <- strokes[sample(num_strokes, 4)]

    ## create a figure for placing all subplots
##    plot.new()
    par(mfrow=c(2,2), new=TRUE)
    ##op <- par(mfrow=c(5,1))
          
    ## for each parameter (acc_x, etc)
    ##        for (param in params.of.interest) {
    for (param in param.names) {
        
        for (stroke in strokes_sample) {



            ## get the wavelet transform

            y <- signalSeries(stroke[[param]])
            
            ## calculate CWT using Mexican hat filter  CONSIDER USING SPLINE WAVELET
            wavelet_type <- "gaussian1"
            
            ## very discrete, only 7 scales from 2^1 to 2^6
            ## guaranteed to run on every signal
            ##        W <- wavCWT(y, wavelet=wavelet_type, n.scale = num_scales, scale.range = c(1, 64))
            
            ##num_scales = 4
            ##W <- wavCWT(y, wavelet=wavelet_type, n.scale = num_scales, scale.range = c(1, 8))
            W <- wavCWT(y, wavelet=wavelet_type, scale.range = c(1,64))
            
            ## more scales (5 per order of magnitude: 5 * 7 = 35)
            ##W <- wavCWT(y, wavelet=wavelet_type, n.scale = 35, scale.range = c(1, 64))

            plot(W, main = paste0(param, " ", uniq_label))
            
        }

        
    }

}
