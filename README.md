
To run:

    ruby hw4.rb hw2.muscle organism/*.faa [> output.txt]

Some environment variables can be set.

* If `MY_NAME` is set, then the output will be prepended by the value of
  `MY_NAME` followed by an extra blank line.
* If `LIMIT` is set, its value will be interpreted as an integer and then used
  as an upper limit (exclusive) for truncating the number of proteins loaded
  in memory. This is used to artificially reduce the size of the data set.
* If `SPECIES` is set, then its value will be used as the species label when
  producing the new 13-protein multiple alignment. Otherwise the label will
  default to 'Unknown_species'. Per assingment specs, this value should not
  contain any spaces.
* If `LINEAR` is set to any value, then the program will run sequentially
  without any sort of parallelization, even if it is running on JRuby.
* If `DEBUG` is set to any value, then the program will dump debug messages
  to standard error.

For example:

    LIMIT=3 \
    MY_NAME='Wilson Lee' \
    SPECIES='Oligotropha_carboxidovorans' \
    time ruby hw4.rb hw2.muscle \
    ../Oligotropha_carboxidovorans_OM4_uid162135/*.faa > O.carboxidovorans.txt

