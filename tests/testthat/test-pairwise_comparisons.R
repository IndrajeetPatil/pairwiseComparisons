# between-subjects design --------------------------------------------------

# msleep dataset
msleep <-
  structure(list(name = c(
    "Cheetah", "Owl monkey", "Mountain beaver",
    "Greater short-tailed shrew", "Cow", "Three-toed sloth", "Northern fur seal",
    "Vesper mouse", "Dog", "Roe deer", "Goat", "Guinea pig", "Grivet",
    "Chinchilla", "Star-nosed mole", "African giant pouched rat",
    "Lesser short-tailed shrew", "Long-nosed armadillo", "Tree hyrax",
    "North American Opossum", "Asian elephant", "Big brown bat",
    "Horse", "Donkey", "European hedgehog", "Patas monkey", "Western american chipmunk",
    "Domestic cat", "Galago", "Giraffe", "Pilot whale", "Gray seal",
    "Gray hyrax", "Human", "Mongoose lemur", "African elephant",
    "Thick-tailed opposum", "Macaque", "Mongolian gerbil", "Golden hamster",
    "Vole ", "House mouse", "Little brown bat", "Round-tailed muskrat",
    "Slow loris", "Degu", "Northern grasshopper mouse", "Rabbit",
    "Sheep", "Chimpanzee", "Tiger", "Jaguar", "Lion", "Baboon", "Desert hedgehog",
    "Potto", "Deer mouse", "Phalanger", "Caspian seal", "Common porpoise",
    "Potoroo", "Giant armadillo", "Rock hyrax", "Laboratory rat",
    "African striped mouse", "Squirrel monkey", "Eastern american mole",
    "Cotton rat", "Mole rat", "Arctic ground squirrel", "Thirteen-lined ground squirrel",
    "Golden-mantled ground squirrel", "Musk shrew", "Pig", "Short-nosed echidna",
    "Eastern american chipmunk", "Brazilian tapir", "Tenrec", "Tree shrew",
    "Bottle-nosed dolphin", "Genet", "Arctic fox", "Red fox"
  ), genus = c(
    "Acinonyx",
    "Aotus", "Aplodontia", "Blarina", "Bos", "Bradypus", "Callorhinus",
    "Calomys", "Canis", "Capreolus", "Capri", "Cavis", "Cercopithecus",
    "Chinchilla", "Condylura", "Cricetomys", "Cryptotis", "Dasypus",
    "Dendrohyrax", "Didelphis", "Elephas", "Eptesicus", "Equus",
    "Equus", "Erinaceus", "Erythrocebus", "Eutamias", "Felis", "Galago",
    "Giraffa", "Globicephalus", "Haliochoerus", "Heterohyrax", "Homo",
    "Lemur", "Loxodonta", "Lutreolina", "Macaca", "Meriones", "Mesocricetus",
    "Microtus", "Mus", "Myotis", "Neofiber", "Nyctibeus", "Octodon",
    "Onychomys", "Oryctolagus", "Ovis", "Pan", "Panthera", "Panthera",
    "Panthera", "Papio", "Paraechinus", "Perodicticus", "Peromyscus",
    "Phalanger", "Phoca", "Phocoena", "Potorous", "Priodontes", "Procavia",
    "Rattus", "Rhabdomys", "Saimiri", "Scalopus", "Sigmodon", "Spalax",
    "Spermophilus", "Spermophilus", "Spermophilus", "Suncus", "Sus",
    "Tachyglossus", "Tamias", "Tapirus", "Tenrec", "Tupaia", "Tursiops",
    "Genetta", "Vulpes", "Vulpes"
  ), vore = c(
    "carni", "omni", "herbi",
    "omni", "herbi", "herbi", "carni", NA, "carni", "herbi", "herbi",
    "herbi", "omni", "herbi", "omni", "omni", "omni", "carni", "herbi",
    "omni", "herbi", "insecti", "herbi", "herbi", "omni", "omni",
    "herbi", "carni", "omni", "herbi", "carni", "carni", "herbi",
    "omni", "herbi", "herbi", "carni", "omni", "herbi", "herbi",
    "herbi", "herbi", "insecti", "herbi", "carni", "herbi", "carni",
    "herbi", "herbi", "omni", "carni", "carni", "carni", "omni",
    NA, "omni", NA, NA, "carni", "carni", "herbi", "insecti", NA,
    "herbi", "omni", "omni", "insecti", "herbi", NA, "herbi", "herbi",
    "herbi", NA, "omni", "insecti", "herbi", "herbi", "omni", "omni",
    "carni", "carni", "carni", "carni"
  ), order = c(
    "Carnivora", "Primates",
    "Rodentia", "Soricomorpha", "Artiodactyla", "Pilosa", "Carnivora",
    "Rodentia", "Carnivora", "Artiodactyla", "Artiodactyla", "Rodentia",
    "Primates", "Rodentia", "Soricomorpha", "Rodentia", "Soricomorpha",
    "Cingulata", "Hyracoidea", "Didelphimorphia", "Proboscidea",
    "Chiroptera", "Perissodactyla", "Perissodactyla", "Erinaceomorpha",
    "Primates", "Rodentia", "Carnivora", "Primates", "Artiodactyla",
    "Cetacea", "Carnivora", "Hyracoidea", "Primates", "Primates",
    "Proboscidea", "Didelphimorphia", "Primates", "Rodentia", "Rodentia",
    "Rodentia", "Rodentia", "Chiroptera", "Rodentia", "Primates",
    "Rodentia", "Rodentia", "Lagomorpha", "Artiodactyla", "Primates",
    "Carnivora", "Carnivora", "Carnivora", "Primates", "Erinaceomorpha",
    "Primates", "Rodentia", "Diprotodontia", "Carnivora", "Cetacea",
    "Diprotodontia", "Cingulata", "Hyracoidea", "Rodentia", "Rodentia",
    "Primates", "Soricomorpha", "Rodentia", "Rodentia", "Rodentia",
    "Rodentia", "Rodentia", "Soricomorpha", "Artiodactyla", "Monotremata",
    "Rodentia", "Perissodactyla", "Afrosoricida", "Scandentia", "Cetacea",
    "Carnivora", "Carnivora", "Carnivora"
  ), conservation = c(
    "lc",
    NA, "nt", "lc", "domesticated", NA, "vu", NA, "domesticated",
    "lc", "lc", "domesticated", "lc", "domesticated", "lc", NA, "lc",
    "lc", "lc", "lc", "en", "lc", "domesticated", "domesticated",
    "lc", "lc", NA, "domesticated", NA, "cd", "cd", "lc", "lc", NA,
    "vu", "vu", "lc", NA, "lc", "en", NA, "nt", NA, "nt", NA, "lc",
    "lc", "domesticated", "domesticated", NA, "en", "nt", "vu", NA,
    "lc", "lc", NA, NA, "vu", "vu", NA, "en", "lc", "lc", NA, NA,
    "lc", NA, NA, "lc", "lc", "lc", NA, "domesticated", NA, NA, "vu",
    NA, NA, NA, NA, NA, NA
  ), sleep_total = c(
    12.1, 17, 14.4, 14.9,
    4, 14.4, 8.7, 7, 10.1, 3, 5.3, 9.4, 10, 12.5, 10.3, 8.3, 9.1,
    17.4, 5.3, 18, 3.9, 19.7, 2.9, 3.1, 10.1, 10.9, 14.9, 12.5, 9.8,
    1.9, 2.7, 6.2, 6.3, 8, 9.5, 3.3, 19.4, 10.1, 14.2, 14.3, 12.8,
    12.5, 19.9, 14.6, 11, 7.7, 14.5, 8.4, 3.8, 9.7, 15.8, 10.4, 13.5,
    9.4, 10.3, 11, 11.5, 13.7, 3.5, 5.6, 11.1, 18.1, 5.4, 13, 8.7,
    9.6, 8.4, 11.3, 10.6, 16.6, 13.8, 15.9, 12.8, 9.1, 8.6, 15.8,
    4.4, 15.6, 8.9, 5.2, 6.3, 12.5, 9.8
  ), sleep_rem = c(
    NA, 1.8,
    2.4, 2.3, 0.7, 2.2, 1.4, NA, 2.9, NA, 0.6, 0.8, 0.7, 1.5, 2.2,
    2, 1.4, 3.1, 0.5, 4.9, NA, 3.9, 0.6, 0.4, 3.5, 1.1, NA, 3.2,
    1.1, 0.4, 0.1, 1.5, 0.6, 1.9, 0.9, NA, 6.6, 1.2, 1.9, 3.1, NA,
    1.4, 2, NA, NA, 0.9, NA, 0.9, 0.6, 1.4, NA, NA, NA, 1, 2.7, NA,
    NA, 1.8, 0.4, NA, 1.5, 6.1, 0.5, 2.4, NA, 1.4, 2.1, 1.1, 2.4,
    NA, 3.4, 3, 2, 2.4, NA, NA, 1, 2.3, 2.6, NA, 1.3, NA, 2.4
  ), sleep_cycle = c(
    NA,
    NA, NA, 0.133333333, 0.666666667, 0.766666667, 0.383333333, NA,
    0.333333333, NA, NA, 0.216666667, NA, 0.116666667, NA, NA, 0.15,
    0.383333333, NA, 0.333333333, NA, 0.116666667, 1, NA, 0.283333333,
    NA, NA, 0.416666667, 0.55, NA, NA, NA, NA, 1.5, NA, NA, NA, 0.75,
    NA, 0.2, NA, 0.183333333, 0.2, NA, NA, NA, NA, 0.416666667, NA,
    1.416666667, NA, NA, NA, 0.666666667, NA, NA, NA, NA, NA, NA,
    NA, NA, NA, 0.183333333, NA, NA, 0.166666667, 0.15, NA, NA, 0.216666667,
    NA, 0.183333333, 0.5, NA, NA, 0.9, NA, 0.233333333, NA, NA, NA,
    0.35
  ), awake = c(
    11.9, 7, 9.6, 9.1, 20, 9.6, 15.3, 17, 13.9,
    21, 18.7, 14.6, 14, 11.5, 13.7, 15.7, 14.9, 6.6, 18.7, 6, 20.1,
    4.3, 21.1, 20.9, 13.9, 13.1, 9.1, 11.5, 14.2, 22.1, 21.35, 17.8,
    17.7, 16, 14.5, 20.7, 4.6, 13.9, 9.8, 9.7, 11.2, 11.5, 4.1, 9.4,
    13, 16.3, 9.5, 15.6, 20.2, 14.3, 8.2, 13.6, 10.5, 14.6, 13.7,
    13, 12.5, 10.3, 20.5, 18.45, 12.9, 5.9, 18.6, 11, 15.3, 14.4,
    15.6, 12.7, 13.4, 7.4, 10.2, 8.1, 11.2, 14.9, 15.4, 8.2, 19.6,
    8.4, 15.1, 18.8, 17.7, 11.5, 14.2
  ), brainwt = c(
    NA, 0.0155, NA,
    0.00029, 0.423, NA, NA, NA, 0.07, 0.0982, 0.115, 0.0055, NA,
    0.0064, 0.001, 0.0066, 0.00014, 0.0108, 0.0123, 0.0063, 4.603,
    3e-04, 0.655, 0.419, 0.0035, 0.115, NA, 0.0256, 0.005, NA, NA,
    0.325, 0.01227, 1.32, NA, 5.712, NA, 0.179, NA, 0.001, NA, 4e-04,
    0.00025, NA, 0.0125, NA, NA, 0.0121, 0.175, 0.44, NA, 0.157,
    NA, 0.18, 0.0024, NA, NA, 0.0114, NA, NA, NA, 0.081, 0.021, 0.0019,
    NA, 0.02, 0.0012, 0.00118, 0.003, 0.0057, 0.004, NA, 0.00033,
    0.18, 0.025, NA, 0.169, 0.0026, 0.0025, NA, 0.0175, 0.0445, 0.0504
  ), bodywt = c(
    50, 0.48, 1.35, 0.019, 600, 3.85, 20.49, 0.045,
    14, 14.8, 33.5, 0.728, 4.75, 0.42, 0.06, 1, 0.005, 3.5, 2.95,
    1.7, 2547, 0.023, 521, 187, 0.77, 10, 0.071, 3.3, 0.2, 899.995,
    800, 85, 2.625, 62, 1.67, 6654, 0.37, 6.8, 0.053, 0.12, 0.035,
    0.022, 0.01, 0.266, 1.4, 0.21, 0.028, 2.5, 55.5, 52.2, 162.564,
    100, 161.499, 25.235, 0.55, 1.1, 0.021, 1.62, 86, 53.18, 1.1,
    60, 3.6, 0.32, 0.044, 0.743, 0.075, 0.148, 0.122, 0.92, 0.101,
    0.205, 0.048, 86.25, 4.5, 0.112, 207.501, 0.9, 0.104, 173.33,
    2, 3.38, 4.23
  )), class = c("tbl_df", "tbl", "data.frame"), row.names = c(
    NA,
    -83L
  ))

testthat::test_that(
  desc = "`pairwise_comparisons()` works for between-subjects design",
  code = {
    set.seed(123)

    # student's t
    df1 <-
      pairwiseComparisons::pairwise_comparisons(
        data = msleep,
        x = vore,
        y = "brainwt",
        type = "p",
        var.equal = TRUE,
        paired = FALSE,
        p.adjust.method = "bonferroni"
      )

    # games-howell
    df_msleep <- msleep

    # adding empty factor level (shouldn't change results)
    df_msleep %<>%
      dplyr::mutate(
        vore = as.factor(vore),
        vore = forcats::fct_expand(vore, "random")
      )

    df2 <-
      pairwiseComparisons::pairwise_comparisons(
        data = df_msleep,
        x = "vore",
        y = brainwt,
        type = "p",
        var.equal = FALSE,
        paired = FALSE,
        p.adjust.method = "bonferroni"
      )

    # Dunn test
    df3 <-
      pairwiseComparisons::pairwise_comparisons(
        data = msleep,
        x = vore,
        y = brainwt,
        type = "np",
        paired = FALSE,
        p.adjust.method = "none"
      )

    # robust t test
    df4 <-
      pairwiseComparisons::pairwise_comparisons(
        data = msleep,
        x = vore,
        y = brainwt,
        type = "r",
        paired = FALSE,
        p.adjust.method = "fdr"
      )

    # checking the edge case where factor level names contain `-`
    set.seed(123)
    df5 <-
      pairwiseComparisons::pairwise_comparisons(
        data = movies_wide,
        x = mpaa,
        y = rating,
        var.equal = TRUE
      )

    # bayes test
    df6 <-
      pairwiseComparisons::pairwise_comparisons(
        data = msleep,
        x = vore,
        y = brainwt,
        type = "bf",
        k = 3
      )

    testthat::expect_equal(
      df1,
      structure(list(group1 = c(
        "carni", "carni", "carni", "herbi",
        "herbi", "insecti"
      ), group2 = c(
        "herbi", "insecti", "omni", "insecti",
        "omni", "omni"
      ), mean.difference = c(
        0.542341944444444, -0.0577055555555556,
        0.0664756209150327, -0.6000475, -0.475866323529411, 0.124181176470588
      ), p.value = c(1, 1, 1, 1, 0.97896258889857, 1), significance = c(
        "ns",
        "ns", "ns", "ns", "ns", "ns"
      ), label = c(
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )", "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )", "list(~italic(p)[ adjusted ]== 0.979 )",
        "list(~italic(p)[ adjusted ]== 1.000 )"
      ), test.details = c(
        "Student's t-test",
        "Student's t-test", "Student's t-test", "Student's t-test", "Student's t-test",
        "Student's t-test"
      ), p.value.adjustment = c(
        "Bonferroni", "Bonferroni",
        "Bonferroni", "Bonferroni", "Bonferroni", "Bonferroni"
      )), row.names = c(
        NA,
        -6L
      ), class = c("tbl_df", "tbl", "data.frame"))
    )

    testthat::expect_equal(
      df2,
      structure(list(
        group1 = c(
          "carni", "herbi", "herbi", "omni",
          "omni", "omni"
        ), group2 = c(
          "insecti", "carni", "insecti", "carni",
          "herbi", "insecti"
        ), mean.difference = c(
          -0.058, -0.542, -0.6,
          -0.066, 0.476, -0.124
        ), se = c(
          0.027, 0.25, 0.249, 0.061, 0.255,
          0.057
        ), t.value = c(1.534, 1.536, 1.705, 0.774, 1.321, 1.547),
        df = c(10.74, 19.358, 19.075, 21.114, 20.891, 17.175), p.value = c(
          1,
          1, 1, 1, 1, 1
        ), significance = c(
          "ns", "ns", "ns", "ns",
          "ns", "ns"
        ), label = c(
          "list(~italic(p)[ adjusted ]== 1.000 )",
          "list(~italic(p)[ adjusted ]== 1.000 )", "list(~italic(p)[ adjusted ]== 1.000 )",
          "list(~italic(p)[ adjusted ]== 1.000 )", "list(~italic(p)[ adjusted ]== 1.000 )",
          "list(~italic(p)[ adjusted ]== 1.000 )"
        ), test.details = c(
          "Games-Howell test",
          "Games-Howell test", "Games-Howell test", "Games-Howell test",
          "Games-Howell test", "Games-Howell test"
        ), p.value.adjustment = c(
          "Bonferroni",
          "Bonferroni", "Bonferroni", "Bonferroni", "Bonferroni", "Bonferroni"
        )
      ), row.names = c(NA, -6L), class = c("tbl_df", "tbl", "data.frame"))
    )

    testthat::expect_equal(
      df3,
      structure(list(group1 = c(
        "carni", "carni", "carni", "herbi",
        "herbi", "insecti"
      ), group2 = c(
        "herbi", "insecti", "omni", "insecti",
        "omni", "omni"
      ), z.value = c(
        0.581939863708611, 1.88416265861034,
        1.1401937549755, 1.63470584606214, 0.716738819223383, 1.14184879734281
      ), p.value = c(
        0.560607187991022, 0.059542976820867, 0.254205588698823,
        0.102110726395835, 0.473535268409823, 0.253516874904017
      ), significance = c(
        "ns",
        "ns", "ns", "ns", "ns", "ns"
      ), label = c(
        "list(~italic(p)[ unadjusted ]== 0.561 )",
        "list(~italic(p)[ unadjusted ]== 0.060 )", "list(~italic(p)[ unadjusted ]== 0.254 )",
        "list(~italic(p)[ unadjusted ]== 0.102 )", "list(~italic(p)[ unadjusted ]== 0.474 )",
        "list(~italic(p)[ unadjusted ]== 0.254 )"
      ), test.details = c(
        "Dunn test",
        "Dunn test", "Dunn test", "Dunn test", "Dunn test", "Dunn test"
      ), p.value.adjustment = c(
        "None", "None", "None", "None", "None",
        "None"
      )), row.names = c(NA, -6L), class = c(
        "tbl_df", "tbl",
        "data.frame"
      ))
    )

    testthat::expect_equal(
      df4,
      structure(list(
        group1 = c(
          "carni", "carni", "carni", "herbi",
          "herbi", "insecti"
        ), group2 = c(
          "herbi", "insecti", "omni", "insecti",
          "omni", "omni"
        ), psihat = c(
          -0.0529663194444444, 0.0577055555555556,
          0.00210288888888889, 0.110671875, 0.0550692083333333, -0.0556026666666667
        ), conf.low = c(
          -0.274279949740241, -0.0608840127189589, -0.150576458524469,
          -0.0982585938419747, -0.172668886166973, -0.184033645343686
        ),
        conf.high = c(
          0.168347310851352, 0.17629512383007, 0.154782236302247,
          0.319602343841975, 0.28280730283364, 0.0728283120103522
        ),
        p.value = c(
          0.968822355846075, 0.968822355846075, 0.968822355846075,
          0.968822355846075, 0.968822355846075, 0.968822355846075
        ),
        significance = c("ns", "ns", "ns", "ns", "ns", "ns"), label = c(
          "list(~italic(p)[ adjusted ]== 0.969 )",
          "list(~italic(p)[ adjusted ]== 0.969 )", "list(~italic(p)[ adjusted ]== 0.969 )",
          "list(~italic(p)[ adjusted ]== 0.969 )", "list(~italic(p)[ adjusted ]== 0.969 )",
          "list(~italic(p)[ adjusted ]== 0.969 )"
        ), test.details = c(
          "Yuen's trimmed means test",
          "Yuen's trimmed means test", "Yuen's trimmed means test",
          "Yuen's trimmed means test", "Yuen's trimmed means test",
          "Yuen's trimmed means test"
        ), p.value.adjustment = c(
          "Benjamini & Hochberg",
          "Benjamini & Hochberg", "Benjamini & Hochberg", "Benjamini & Hochberg",
          "Benjamini & Hochberg", "Benjamini & Hochberg"
        )
      ), row.names = c(
        NA,
        -6L
      ), class = c("tbl_df", "tbl", "data.frame"))
    )

    testthat::expect_equal(
      df5,
      structure(list(
        group1 = c("PG", "PG", "PG-13"), group2 = c(
          "PG-13",
          "R", "R"
        ), mean.difference = c(
          0.104274593206392, 0.323409359571652,
          0.219134766365261
        ), p.value = c(
          0.31593151838515, 0.00282540700002925,
          0.00310027887332363
        ), significance = c("ns", "**", "**"), label = c(
          "list(~italic(p)[ adjusted ]== 0.316 )",
          "list(~italic(p)[ adjusted ]== 0.003 )", "list(~italic(p)[ adjusted ]== 0.003 )"
        ), test.details = c("Student's t-test", "Student's t-test", "Student's t-test"),
        p.value.adjustment = c("Holm", "Holm", "Holm")
      ), row.names = c(
        NA,
        -3L
      ), class = c("tbl_df", "tbl", "data.frame"))
    )

    testthat::expect_equal(
      df6,
      structure(list(group1 = c(
        "omni", "omni", "omni", "herbi", "herbi",
        "carni"
      ), group2 = c(
        "herbi", "carni", "insecti", "carni", "insecti",
        "insecti"
      ), bf10 = c(
        0.571459118057204, 0.427087262024776, 0.545369208129638,
        0.539799796668641, 0.540146386265641, 0.717619263870734
      ), error = c(
        4.11455126195299e-05,
        0.000105116542699516, 1.90369418701351e-05, 1.00212517554447e-05,
        1.75305381253856e-05, 0.000152111281377722
      ), bf01 = c(
        1.74990645595036,
        2.34144187597426, 1.83362020644608, 1.85253867484106, 1.85134997738966,
        1.39349659401023
      ), log_e_bf10 = c(
        -0.559562332764069, -0.850766925918558,
        -0.6062922675725, -0.616556955077368, -0.615915090483787, -0.331816123738985
      ), log_e_bf01 = c(
        0.559562332764069, 0.850766925918558, 0.6062922675725,
        0.616556955077368, 0.615915090483787, 0.331816123738985
      ), log_10_bf10 = c(
        -0.243014833400346,
        -0.369483381312222, -0.263309386227347, -0.267767283369172, -0.267488525118051,
        -0.144105911546368
      ), log_10_bf01 = c(
        0.243014833400346, 0.369483381312222,
        0.263309386227347, 0.267767283369172, 0.267488525118051, 0.144105911546368
      ), bf.prior = c(0.707, 0.707, 0.707, 0.707, 0.707, 0.707), label = c(
        "list(~log[e](BF[10])==-0.560)",
        "list(~log[e](BF[10])==-0.851)", "list(~log[e](BF[10])==-0.606)",
        "list(~log[e](BF[10])==-0.617)", "list(~log[e](BF[10])==-0.616)",
        "list(~log[e](BF[10])==-0.332)"
      ), test.details = c(
        "Student's t-test",
        "Student's t-test", "Student's t-test", "Student's t-test", "Student's t-test",
        "Student's t-test"
      )), row.names = c(NA, -6L), class = c(
        "tbl_df",
        "tbl", "data.frame"
      ))
    )
  }
)


# within-subjects design --------------------------------------------------

testthat::test_that(
  desc = "`pairwise_comparisons()` works for within-subjects design",
  code = {

    # student's t test
    set.seed(123)
    df1 <-
      pairwiseComparisons::pairwise_comparisons(
        data = pairwiseComparisons::bugs_long,
        x = condition,
        y = desire,
        type = "p",
        k = 3,
        paired = TRUE,
        p.adjust.method = "bonferroni"
      )

    # Durbin-Conover test
    set.seed(123)
    df2 <-
      pairwiseComparisons::pairwise_comparisons(
        data = pairwiseComparisons::bugs_long,
        x = condition,
        y = desire,
        type = "np",
        k = 3,
        paired = TRUE,
        p.adjust.method = "BY"
      )

    # robust t test
    set.seed(123)
    df3 <-
      pairwiseComparisons::pairwise_comparisons(
        data = pairwiseComparisons::bugs_long,
        x = condition,
        y = desire,
        type = "r",
        k = 3,
        paired = TRUE,
        p.adjust.method = "hommel"
      )

    # bf
    df4 <-
      pairwiseComparisons::pairwise_comparisons(
        data = bugs_long,
        x = condition,
        y = desire,
        type = "bf",
        k = 4,
        bf.prior = 0.9,
        paired = TRUE
      )

    testthat::expect_equal(
      df1,
      structure(list(
        group1 = c(
          "HDHF", "HDHF", "HDHF", "HDLF", "HDLF",
          "LDHF"
        ), group2 = c("HDLF", "LDHF", "LDLF", "LDHF", "LDLF", "LDLF"), mean.difference = c(
          -1.11150262780698, -0.474139990444344,
          -2.13820710612436, 0.637362637362633, -1.02670447831738, -1.66406711568001
        ), p.value = c(
          0.00299976631652718, 0.424489481143163, 7.64012434838759e-12,
          0.273674946144599, 0.00555105484340761, 1.33421409568175e-08
        ),
        significance = c("**", "ns", "***", "ns", "**", "***"), label = c(
          "list(~italic(p)[ adjusted ]== 0.003 )",
          "list(~italic(p)[ adjusted ]== 0.424 )", "list(~italic(p)[ adjusted ]<= 0.001 )",
          "list(~italic(p)[ adjusted ]== 0.274 )", "list(~italic(p)[ adjusted ]== 0.006 )",
          "list(~italic(p)[ adjusted ]<= 0.001 )"
        ), test.details = c(
          "Student's t-test",
          "Student's t-test", "Student's t-test", "Student's t-test",
          "Student's t-test", "Student's t-test"
        ), p.value.adjustment = c(
          "Bonferroni",
          "Bonferroni", "Bonferroni", "Bonferroni", "Bonferroni", "Bonferroni"
        )
      ), row.names = c(NA, -6L), class = c("tbl_df", "tbl", "data.frame"))
    )

    testthat::expect_equal(
      df2,
      structure(list(group1 = c(
        "HDHF", "HDHF", "HDHF", "HDLF", "HDLF",
        "LDHF"
      ), group2 = c("HDLF", "LDHF", "LDLF", "LDHF", "LDLF", "LDLF"), W = c(
        4.78004208516409, 2.44393129166284, 8.01465703001196,
        2.33611079350124, 3.23461494484788, 5.57072573834912
      ), p.value = c(
        1.43572019298853e-05,
        0.0446609703688148, 5.44695321290943e-13, 0.0495952072169543,
        0.00505348837336956, 4.63541745933777e-07
      ), significance = c(
        "***",
        "*", "***", "*", "**", "***"
      ), label = c(
        "list(~italic(p)[ adjusted ]<= 0.001 )",
        "list(~italic(p)[ adjusted ]== 0.045 )", "list(~italic(p)[ adjusted ]<= 0.001 )",
        "list(~italic(p)[ adjusted ]== 0.050 )", "list(~italic(p)[ adjusted ]== 0.005 )",
        "list(~italic(p)[ adjusted ]<= 0.001 )"
      ), test.details = c(
        "Durbin-Conover test",
        "Durbin-Conover test", "Durbin-Conover test", "Durbin-Conover test",
        "Durbin-Conover test", "Durbin-Conover test"
      ), p.value.adjustment = c(
        "Benjamini & Yekutieli",
        "Benjamini & Yekutieli", "Benjamini & Yekutieli", "Benjamini & Yekutieli",
        "Benjamini & Yekutieli", "Benjamini & Yekutieli"
      )), row.names = c(
        NA,
        -6L
      ), class = c("tbl_df", "tbl", "data.frame"))
    )

    testthat::expect_equal(
      df3,
      structure(list(group1 = c(
        "HDHF", "HDHF", "HDHF", "HDLF", "HDLF",
        "LDHF"
      ), group2 = c("HDLF", "LDHF", "LDLF", "LDHF", "LDLF", "LDLF"), psihat = c(
        1.15972222222222, 0.5, 2.09722222222222, -0.701388888888889,
        0.9375, 1.54166666666667
      ), conf.low = c(
        0.31774693796343, -0.187985427677011,
        1.37347486163769, -1.70531936933122, 0.0693889218577616, 0.810451016256075
      ), conf.high = c(
        2.00169750648101, 1.18798542767701, 2.82096958280676,
        0.30254159155344, 1.80561107814224, 2.27288231707726
      ), p.value = c(
        0.0014863398097571,
        0.061996268653904, 1.78549175444687e-10, 0.061996268653904, 0.0136221810275785,
        1.16044491682565e-06
      ), significance = c(
        "**", "ns", "***", "ns",
        "*", "***"
      ), label = c(
        "list(~italic(p)[ adjusted ]== 0.001 )",
        "list(~italic(p)[ adjusted ]== 0.062 )", "list(~italic(p)[ adjusted ]<= 0.001 )",
        "list(~italic(p)[ adjusted ]== 0.062 )", "list(~italic(p)[ adjusted ]== 0.014 )",
        "list(~italic(p)[ adjusted ]<= 0.001 )"
      ), test.details = c(
        "Yuen's trimmed means test",
        "Yuen's trimmed means test", "Yuen's trimmed means test", "Yuen's trimmed means test",
        "Yuen's trimmed means test", "Yuen's trimmed means test"
      ), p.value.adjustment = c(
        "Hommel",
        "Hommel", "Hommel", "Hommel", "Hommel", "Hommel"
      )), row.names = c(
        NA,
        -6L
      ), class = c("tbl_df", "tbl", "data.frame"))
    )

    testthat::expect_equal(
      df4,
      structure(list(group1 = c(
        "HDHF", "HDHF", "HDHF", "HDLF", "HDLF",
        "LDHF"
      ), group2 = c("HDLF", "LDHF", "LDLF", "LDHF", "LDLF", "LDLF"), bf10 = c(
        4.7282799581255, 0.358401385629325, 37036.6126255396,
        0.402224731211428, 2.6615649279829, 1053.39083914171
      ), error = c(
        2.15914439779206e-08,
        3.68989361580263e-07, 2.7577830338764e-13, 3.2610911164951e-07,
        4.12334316216598e-08, 2.47596521080377e-11
      ), bf01 = c(
        0.211493399049164,
        2.79016778421232, 2.70003093995271e-05, 2.48617233701215, 0.375718807189822,
        0.000949315261574505
      ), log_e_bf10 = c(
        1.55356149115229, -1.02610173173558,
        10.5196622327839, -0.910744313699526, 0.978914268592519, 6.95976961054452
      ), log_e_bf01 = c(
        -1.55356149115229, 1.02610173173558, -10.5196622327839,
        0.910744313699526, -0.978914268592519, -6.95976961054452
      ), log_10_bf10 = c(
        0.674703182904827,
        -0.445630319964135, 4.56863125918407, -0.395531229864468, 0.425137065106089,
        3.02258953717743
      ), log_10_bf01 = c(
        -0.674703182904827, 0.445630319964135,
        -4.56863125918407, 0.395531229864468, -0.425137065106089, -3.02258953717743
      ), bf.prior = c(0.9, 0.9, 0.9, 0.9, 0.9, 0.9), label = c(
        "list(~log[e](BF[10])==1.5536)",
        "list(~log[e](BF[10])==-1.0261)", "list(~log[e](BF[10])==10.5197)",
        "list(~log[e](BF[10])==-0.9107)", "list(~log[e](BF[10])==0.9789)",
        "list(~log[e](BF[10])==6.9598)"
      ), test.details = c(
        "Student's t-test",
        "Student's t-test", "Student's t-test", "Student's t-test", "Student's t-test",
        "Student's t-test"
      )), row.names = c(NA, -6L), class = c(
        "tbl_df",
        "tbl", "data.frame"
      ))
    )
  }
)

# dropped levels --------------------------------------------------

testthat::test_that(
  desc = "dropped levels are not included",
  code = {
    set.seed(123)

    # drop levels
    msleep2 <- dplyr::filter(
      .data = msleep,
      vore %in% c("carni", "omni")
    )

    # check those levels are not included
    df1 <-
      pairwiseComparisons::pairwise_comparisons(
        data = msleep2,
        x = vore,
        y = brainwt,
        p.adjust.method = "none"
      )

    df2 <-
      pairwiseComparisons::pairwise_comparisons(
        data = msleep,
        x = vore,
        y = brainwt,
        p.adjust.method = "none"
      ) %>%
      dplyr::filter(.data = ., group1 == "omni", group2 == "carni")

    testthat::expect_equal(
      df1,
      structure(list(
        group1 = "omni", group2 = "carni", mean.difference = -0.066,
        se = 0.061, t.value = 0.774, df = 21.114, p.value = 0.447,
        significance = "ns", label = "list(~italic(p)[ unadjusted ]== 0.447 )",
        test.details = "Games-Howell test", p.value.adjustment = "None"
      ), row.names = c(
        NA,
        -1L
      ), class = c("tbl_df", "tbl", "data.frame"))
    )

    testthat::expect_equal(
      df2,
      structure(list(
        group1 = "omni", group2 = "carni", mean.difference = -0.066,
        se = 0.061, t.value = 0.774, df = 21.114, p.value = 0.865,
        significance = "ns", label = "list(~italic(p)[ unadjusted ]== 0.865 )",
        test.details = "Games-Howell test", p.value.adjustment = "None"
      ), row.names = c(
        NA,
        -1L
      ), class = c("tbl_df", "tbl", "data.frame"))
    )
  }
)

# irregular names --------------------------------------------------

testthat::test_that(
  desc = "check if everything works fine with irregular factor level names",
  code = {
    set.seed(123)

    df <-
      pairwiseComparisons::pairwise_comparisons(
        data = movies_wide,
        x = mpaa,
        y = rating,
        type = "p",
        var.equal = TRUE
      )

    testthat::expect_equal(
      df,
      structure(list(
        group1 = c("PG", "PG", "PG-13"), group2 = c(
          "PG-13",
          "R", "R"
        ), mean.difference = c(
          0.104274593206392, 0.323409359571652,
          0.219134766365261
        ), p.value = c(
          0.31593151838515, 0.00282540700002925,
          0.00310027887332363
        ), significance = c("ns", "**", "**"), label = c(
          "list(~italic(p)[ adjusted ]== 0.316 )",
          "list(~italic(p)[ adjusted ]== 0.003 )", "list(~italic(p)[ adjusted ]== 0.003 )"
        ), test.details = c("Student's t-test", "Student's t-test", "Student's t-test"),
        p.value.adjustment = c("Holm", "Holm", "Holm")
      ), row.names = c(
        NA,
        -3L
      ), class = c("tbl_df", "tbl", "data.frame"))
    )
  }
)
