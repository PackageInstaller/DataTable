-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dialog/cdramachatconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cdramachatconfig = {}
cdramachatconfig.Data = {
[6] = {id = 6, dialogList = "1", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[7] = {id = 7, dialogList = "2", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[8] = {id = 8, dialogList = "3-5", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[14] = {id = 14, dialogList = "14", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[15] = {id = 15, dialogList = "15", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[22] = {id = 22, dialogList = "13", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[25] = {id = 25, dialogList = "16", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[26] = {id = 26, dialogList = "17", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[27] = {id = 27, dialogList = "18,19", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[29] = {id = 29, dialogList = "20", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[30] = {id = 30, dialogList = "21,2010,2011,2012,2013,2014,2015,2016,2017", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[31] = {id = 31, dialogList = "29,30,1304", nextDialog = 232, skipTime = -1, canSkip = 0}
, 
[33] = {id = 33, dialogList = "7", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[34] = {id = 34, dialogList = "119", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[35] = {id = 35, dialogList = "120", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[40] = {id = 40, dialogList = "124-133", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[46] = {id = 46, dialogList = "134-142", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[47] = {id = 47, dialogList = "36", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[48] = {id = 48, dialogList = "143-147", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[52] = {id = 52, dialogList = "148-152", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[56] = {id = 56, dialogList = "153-163", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[70] = {id = 70, dialogList = "164-169", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[75] = {id = 75, dialogList = "170", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[77] = {id = 77, dialogList = "172-184", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[84] = {id = 84, dialogList = "207-220", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[114] = {id = 114, dialogList = "236-255", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[130] = {id = 130, dialogList = "264-272", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[140] = {id = 140, dialogList = "289-294", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[148] = {id = 148, dialogList = "330", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[157] = {id = 157, dialogList = "374-381", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[161] = {id = 161, dialogList = "331", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[176] = {id = 176, dialogList = "45,46,47", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[179] = {id = 179, dialogList = "918", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[180] = {id = 180, dialogList = "48", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[181] = {id = 181, dialogList = "49-52", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[187] = {id = 187, dialogList = "919,121,122,123", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[191] = {id = 191, dialogList = "333-339,2025,340", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[199] = {id = 199, dialogList = "341,342,343,1949,1950,1951,1952,1953,1954", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[202] = {id = 202, dialogList = "344", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[224] = {id = 224, dialogList = "357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[232] = {id = 232, dialogList = "31", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[234] = {id = 234, dialogList = "230-235", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[237] = {id = 237, dialogList = "321-326", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[251] = {id = 251, dialogList = "387", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[258] = {id = 258, dialogList = "221-225,226,227", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[262] = {id = 262, dialogList = "256-263", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[267] = {id = 267, dialogList = "388,389", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[269] = {id = 269, dialogList = "390-398", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[276] = {id = 276, dialogList = "399", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[278] = {id = 278, dialogList = "32", nextDialog = 232, skipTime = -1, canSkip = 0}
, 
[279] = {id = 279, dialogList = "33", nextDialog = 232, skipTime = -1, canSkip = 0}
, 
[285] = {id = 285, dialogList = "400,401", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[297] = {id = 297, dialogList = "43,44", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[299] = {id = 299, dialogList = "402-405", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[303] = {id = 303, dialogList = "406-409", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[307] = {id = 307, dialogList = "410,349,350,411,412,1955,1956,1957", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[310] = {id = 310, dialogList = "192-196", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[316] = {id = 316, dialogList = "61,62", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[318] = {id = 318, dialogList = "63-67", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[323] = {id = 323, dialogList = "68,69,70,71,72,73,74,75,3254,3255,76,77", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[334] = {id = 334, dialogList = "78,81,82", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[339] = {id = 339, dialogList = "83", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[340] = {id = 340, dialogList = "84-90", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[347] = {id = 347, dialogList = "91,92,93,94,95", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[353] = {id = 353, dialogList = "97,98,113,114,115,116,117,118,99,100,101,102,103,104,105,106,107,108", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[368] = {id = 368, dialogList = "109-118", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[383] = {id = 383, dialogList = "53,54,55,56,57,58,59,929,930,931,932,933,60", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[394] = {id = 394, dialogList = "34,35,920,921,922", nextDialog = 232, skipTime = -1, canSkip = 0}
, 
[396] = {id = 396, dialogList = "39-42", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[400] = {id = 400, dialogList = "121,122,123", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[414] = {id = 414, dialogList = "185,186,3256,188", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[420] = {id = 420, dialogList = "197,198,199,200,201,202,203,204,205,206,979,980,981,982,983,984,985,986,987,991,988,992,989,993,990", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[444] = {id = 444, dialogList = "273,274,275,276,277,278,279,280,281,282,283,284,285,286,1946,287,1947,288,1948", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[462] = {id = 462, dialogList = "297-307", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[473] = {id = 473, dialogList = "308,309,310,311", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[477] = {id = 477, dialogList = "312-320", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[499] = {id = 499, dialogList = "413,414,415,416,417,418,419,420,421,422,1009,423,1010,1011,1012,1013,1014,1015", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[508] = {id = 508, dialogList = "424-436", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[520] = {id = 520, dialogList = "437-449", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[532] = {id = 532, dialogList = "450,451,452,453,454,455,456,457,458,1958,1959,1960,1961,1962,1963,1964,459,460", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[543] = {id = 543, dialogList = "461-465", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[546] = {id = 546, dialogList = "466-468", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[550] = {id = 550, dialogList = "469", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[551] = {id = 551, dialogList = "470", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[552] = {id = 552, dialogList = "471", nextDialog = 551, skipTime = -1, canSkip = 1}
, 
[553] = {id = 553, dialogList = "472", nextDialog = 551, skipTime = -1, canSkip = 1}
, 
[554] = {id = 554, dialogList = "473", nextDialog = 551, skipTime = -1, canSkip = 1}
, 
[555] = {id = 555, dialogList = "474", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[556] = {id = 556, dialogList = "475-479", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[561] = {id = 561, dialogList = "480-485", nextDialog = 567, skipTime = -1, canSkip = 1}
, 
[567] = {id = 567, dialogList = "486", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[568] = {id = 568, dialogList = "487,488", nextDialog = 567, skipTime = -1, canSkip = 1}
, 
[570] = {id = 570, dialogList = "489,490,491", nextDialog = 567, skipTime = -1, canSkip = 1}
, 
[573] = {id = 573, dialogList = "493-501", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[580] = {id = 580, dialogList = "502-508", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[589] = {id = 589, dialogList = "509,510", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[592] = {id = 592, dialogList = "511-526", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[606] = {id = 606, dialogList = "527-530", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[609] = {id = 609, dialogList = "531-535", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[614] = {id = 614, dialogList = "536-545", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[625] = {id = 625, dialogList = "546-548", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[628] = {id = 628, dialogList = "549-556", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[634] = {id = 634, dialogList = "557,558,559,560,561,562,563,1016,564,565,566,567,568,1017,1018,1019,1020,569,570,2652", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[648] = {id = 648, dialogList = "571-572", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[650] = {id = 650, dialogList = "573-579", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[657] = {id = 657, dialogList = "580,581,582,1023,583,584,585,587,586,1025", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[665] = {id = 665, dialogList = "588-593", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[671] = {id = 671, dialogList = "594-598", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[677] = {id = 677, dialogList = "599-606", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[685] = {id = 685, dialogList = "607", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[686] = {id = 686, dialogList = "608,609", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[688] = {id = 688, dialogList = "610,611", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[690] = {id = 690, dialogList = "612-619", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[697] = {id = 697, dialogList = "1042,621,622,623,624,625,627,626,628,629,630,631", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[720] = {id = 720, dialogList = "641,642", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[723] = {id = 723, dialogList = "645,646,1089,1090", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[724] = {id = 724, dialogList = "647,648,649,650,651", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[731] = {id = 731, dialogList = "652-654", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[735] = {id = 735, dialogList = "656-662", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[781] = {id = 781, dialogList = "663,664,665,1005,666,667,668,669,670,671,672", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[795] = {id = 795, dialogList = "677", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[802] = {id = 802, dialogList = "684,685,686,1006,687,688,1007,689,690,1008,691,692", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[811] = {id = 811, dialogList = "693-700", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[819] = {id = 819, dialogList = "701-714", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[833] = {id = 833, dialogList = "715-723", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[842] = {id = 842, dialogList = "724,1054,725,726,727,728,1055,1056,1057,1058", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[847] = {id = 847, dialogList = "729-731", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[852] = {id = 852, dialogList = "734-738", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[857] = {id = 857, dialogList = "739-740", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[859] = {id = 859, dialogList = "741-743", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[862] = {id = 862, dialogList = "744-746", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[865] = {id = 865, dialogList = "747-755", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[874] = {id = 874, dialogList = "756-757", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[876] = {id = 876, dialogList = "758-762", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[881] = {id = 881, dialogList = "763-766", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[885] = {id = 885, dialogList = "767", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[886] = {id = 886, dialogList = "768-776", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[895] = {id = 895, dialogList = "777-780", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[899] = {id = 899, dialogList = "781-786", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[905] = {id = 905, dialogList = "787-794", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[913] = {id = 913, dialogList = "795-796", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[915] = {id = 915, dialogList = "797,798,799,800,1059,801,802,803,804,805,806,807,808,1060,809,810,811", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[930] = {id = 930, dialogList = "812,813,814,815,816,817,818,819,820,821,822,2661,2662,823,824", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[943] = {id = 943, dialogList = "825,1061", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[944] = {id = 944, dialogList = "826-835", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[954] = {id = 954, dialogList = "836-840", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[959] = {id = 959, dialogList = "842,843,844,845,846,847,848,849,850,851,852,853,1062,1063,1064,1065,854,855,856,857", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[976] = {id = 976, dialogList = "858-867", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[986] = {id = 986, dialogList = "868", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[990] = {id = 990, dialogList = "872-882,1087,1088", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1001] = {id = 1001, dialogList = "883", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1002] = {id = 1002, dialogList = "884", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1006] = {id = 1006, dialogList = "620", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1007] = {id = 1007, dialogList = "891,892", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1009] = {id = 1009, dialogList = "893", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1010] = {id = 1010, dialogList = "894", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1011] = {id = 1011, dialogList = "895", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1012] = {id = 1012, dialogList = "896", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1013] = {id = 1013, dialogList = "885-889,1306,1307,1308,1309,1310,1311,1312", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1014] = {id = 1014, dialogList = "897", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1015] = {id = 1015, dialogList = "38", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1016] = {id = 1016, dialogList = "898,899", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1017] = {id = 1017, dialogList = "356", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1018] = {id = 1018, dialogList = "191", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1023] = {id = 1023, dialogList = "906-911", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1031] = {id = 1031, dialogList = "914-916", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1032] = {id = 1032, dialogList = "655", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1034] = {id = 1034, dialogList = "917", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1035] = {id = 1035, dialogList = "923,924,925,926,927,2018,928", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1036] = {id = 1036, dialogList = "934,935", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1037] = {id = 1037, dialogList = "936,937,938,939,940,941,942", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1038] = {id = 1038, dialogList = "943", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1039] = {id = 1039, dialogList = "944", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1040] = {id = 1040, dialogList = "945,946,947,948,949,950,951,952", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1041] = {id = 1041, dialogList = "953,954,955,956,957", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1042] = {id = 1042, dialogList = "958,959,960,961,962,963,964,965,966,967,968,969,970,971", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1043] = {id = 1043, dialogList = "972,973,978,974,976,975,977", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1044] = {id = 1044, dialogList = "994,1303,1301,1302", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1045] = {id = 1045, dialogList = "995,996,997,998", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1046] = {id = 1046, dialogList = "1028,1029,1030,1032,1031,1033,1034,1035,1036,1037,1039,1038,1040", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1047] = {id = 1047, dialogList = "893", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1048] = {id = 1048, dialogList = "894", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1049] = {id = 1049, dialogList = "1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,1053", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1050] = {id = 1050, dialogList = "1066,1067,1068,1069,1070,1071,1072", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1051] = {id = 1051, dialogList = "1073,1074,1075,1076,1077,1078,1079,1080", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1052] = {id = 1052, dialogList = "1091,1092,1093,1094,1095", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1053] = {id = 1053, dialogList = "999,1000", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1054] = {id = 1054, dialogList = "1001,1002,1003,1004", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1055] = {id = 1055, dialogList = "1096,1097,1098,1099,1100,1101,1102,1103,1104,1105,1106,1107,1108,1109,1110,1111,1112,1113", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1056] = {id = 1056, dialogList = "1114", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1057] = {id = 1057, dialogList = "1115", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1058] = {id = 1058, dialogList = "1116,1117,1118,1119,1120,1121,1122,1123,1124,1125,1126,1127,1128,1129", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1059] = {id = 1059, dialogList = "1130,1131,1132,1133", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1060] = {id = 1060, dialogList = "1134,1135,1136,1137,1138,1139,1140,1141,1142", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1061] = {id = 1061, dialogList = "1143", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1062] = {id = 1062, dialogList = "1144,1145,1146,1147", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1063] = {id = 1063, dialogList = "1148,1149,1150,1152,1153,1154,1155,1156,1157,1158,1159,1160,1161,1162,1163,1164,1165,1151,1166,1167,1168,1169,1170,1171,1172", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1064] = {id = 1064, dialogList = "1173,1174,1175,1176,1177,1178,1320,1321,1322,1323", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1065] = {id = 1065, dialogList = "1179,1180", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1066] = {id = 1066, dialogList = "1181", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1067] = {id = 1067, dialogList = "1182", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1068] = {id = 1068, dialogList = "1183,1184,1185,1186,1187,1188,1189,1190,1191,1192", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1069] = {id = 1069, dialogList = "1191,1192", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1070] = {id = 1070, dialogList = "1193", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1071] = {id = 1071, dialogList = "1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1206,1207,1208,1209", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1072] = {id = 1072, dialogList = "1210,1211,1212,1213,1214,1215,1216,1217,1218,1219,1220,1221,1222", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1073] = {id = 1073, dialogList = "1223,1224,1225,1226,1227,1228,1229,1230,1231,1232,1233", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1074] = {id = 1074, dialogList = "1234,1235,1236,1237,1238,1239,1240,1241,1242", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1075] = {id = 1075, dialogList = "1243,1244,1245,1246,1247,1250,1251,1252,1253,1255,1256,1257", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1076] = {id = 1076, dialogList = "1258,1259,1260,1261,1262", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1077] = {id = 1077, dialogList = "1263", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1078] = {id = 1078, dialogList = "1264", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1079] = {id = 1079, dialogList = "1265,1266,1267,1268", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1080] = {id = 1080, dialogList = "1269,1270,1271,1272", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1081] = {id = 1081, dialogList = "1273,1274,1275,1276,1277,1278", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1082] = {id = 1082, dialogList = "1279,1280,1281,1282,1283,1284", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1083] = {id = 1083, dialogList = "1285,1286,1287,1288,1289,1290,1291,1292,1293,1294,1295,1296,1297,1298,2024,1299,1300", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1084] = {id = 1084, dialogList = "1313,1314,1315,1316,1317,1318,1319", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1085] = {id = 1085, dialogList = "1324,1325,1326", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1086] = {id = 1086, dialogList = "1327", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1087] = {id = 1087, dialogList = "1328,1329,1330,1331", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1088] = {id = 1088, dialogList = "1081-1086", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1089] = {id = 1089, dialogList = "1332", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1090] = {id = 1090, dialogList = "1333,1334,1335,1336,1337,1338", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1091] = {id = 1091, dialogList = "1339,1340,1341,1342", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1092] = {id = 1092, dialogList = "1343,1344", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1093] = {id = 1093, dialogList = "1345,1346,1347,1348,1349,1350", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1094] = {id = 1094, dialogList = "1351,1352", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1095] = {id = 1095, dialogList = "1353", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1096] = {id = 1096, dialogList = "1354,1355,1356,1357,1358,1359,1360,1361,1362,1363,1364,1365", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1097] = {id = 1097, dialogList = "1366", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1098] = {id = 1098, dialogList = "1464,1465", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1099] = {id = 1099, dialogList = "1367,1368,1369,1370,1371,1372,1373,1374,1375,1376,1377,1378,1379,1380,1381,1382,1383", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1100] = {id = 1100, dialogList = "1384", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1101] = {id = 1101, dialogList = "1386,1387,1388", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1102] = {id = 1102, dialogList = "1389,1390,1391,1392,1393", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1103] = {id = 1103, dialogList = "1394,1395,1396,1397,1398,1399", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1104] = {id = 1104, dialogList = "1400,1401", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1105] = {id = 1105, dialogList = "1402,1403,1404,1405,1406,1407,1408,1409,1410", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1106] = {id = 1106, dialogList = "1411,1412", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1107] = {id = 1107, dialogList = "1413,1414,1415,1416,1417", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1108] = {id = 1108, dialogList = "1418,1419,1420,1421,1422,1423,1424,1425,1426,1427,1428,1429,1430,1431,1432,1433,1434", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1109] = {id = 1109, dialogList = "1435,1436,1437,1438,1439,1440,1441,1442,1443,1444,1445,1446,1447,1448,1449", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1110] = {id = 1110, dialogList = "1450,1451,1452,1453,1454,1455,1456,1457", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1111] = {id = 1111, dialogList = "1458,1459,1460,1461,1462,1463", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1112] = {id = 1112, dialogList = "1466,1467", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1113] = {id = 1113, dialogList = "1468,1469", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1114] = {id = 1114, dialogList = "1470,1471,1472,1473,1474,1475", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1115] = {id = 1115, dialogList = "1476", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1116] = {id = 1116, dialogList = "1477,1478", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1117] = {id = 1117, dialogList = "1479,1480,1481", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1118] = {id = 1118, dialogList = "1487,1488,1489,1490,1491,1492,1493,1494,1495,1496", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1119] = {id = 1119, dialogList = "1497,1498,1499,1500,1501", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1120] = {id = 1120, dialogList = "1502,1503,1504", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1121] = {id = 1121, dialogList = "1505,1506", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1122] = {id = 1122, dialogList = "1507,1508,1509,1510,1511,1512,1513", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1123] = {id = 1123, dialogList = "1514,1515,1516,1517,1518,1519,1520,1521,1522,1523", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1124] = {id = 1124, dialogList = "1524", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1125] = {id = 1125, dialogList = "1525,1526,1527,1528,1529", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1126] = {id = 1126, dialogList = "1530,1531,1532,1533,1534,1535,1536,1537,1538,1539", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1127] = {id = 1127, dialogList = "1540,1541,1542,1543,1544,1545,1546", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1128] = {id = 1128, dialogList = "1547,1548", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1129] = {id = 1129, dialogList = "1550,1551,1552,1553,1554,1555,1556,1557,1558,1559", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1130] = {id = 1130, dialogList = "1560", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1131] = {id = 1131, dialogList = "1561", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1132] = {id = 1132, dialogList = "1562,1563,1564,1565,1566,1567,1568,1569,1570,1571,1572,1573,1574", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1133] = {id = 1133, dialogList = "1575", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1134] = {id = 1134, dialogList = "1576,1577,1578,1579", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1135] = {id = 1135, dialogList = "1580,1581", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1136] = {id = 1136, dialogList = "1582,1583", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1137] = {id = 1137, dialogList = "1589,1590,1591,1592,1593,1594,1595,1596", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1138] = {id = 1138, dialogList = "1597,1598,1599,1600,1601", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1139] = {id = 1139, dialogList = "1604-1629", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1140] = {id = 1140, dialogList = "1634", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1141] = {id = 1141, dialogList = "1635,1636", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1142] = {id = 1142, dialogList = "1637,1638,1639,1640", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1143] = {id = 1143, dialogList = "1641,1642,1643,1644,1645,1646,1647", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1144] = {id = 1144, dialogList = "1648,1649,1650,1651,1652,1653,1654,1655,1656,1657", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1145] = {id = 1145, dialogList = "1662,1663,1664,1665,1666,1667,1668,1669,1670,1671", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1146] = {id = 1146, dialogList = "1672,1673,1674,1675,1676,1677,1678,1679,1680", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1147] = {id = 1147, dialogList = "1681,1682,1683,1684", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1148] = {id = 1148, dialogList = "1685,1686", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1149] = {id = 1149, dialogList = "1688,1689,1690,1691,1692", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1150] = {id = 1150, dialogList = "1693", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1151] = {id = 1151, dialogList = "1694", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1152] = {id = 1152, dialogList = "1695,1696,1697,1698,1699,1700,1701,1702,1703,1704,1705,1706,1707,1708,1709,1710", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1153] = {id = 1153, dialogList = "1711,1712,1713,1714,1715,1716,1717,1718", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1154] = {id = 1154, dialogList = "1719", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1155] = {id = 1155, dialogList = "1720,1721,1722,1723,1724", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1156] = {id = 1156, dialogList = "1725,1726", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1157] = {id = 1157, dialogList = "1727", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1158] = {id = 1158, dialogList = "1728", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1159] = {id = 1159, dialogList = "1729,1730,1731,1732,1733,1734,1735,1736,1737,1738,1739,1740,1741,1742,1743,1744,1745,1746,1747,1748,1749,1750,1751,1752,1753,1754,1755,1756", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1160] = {id = 1160, dialogList = "1757,1758,1759,1760,1761", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1161] = {id = 1161, dialogList = "1762,1763,1764,1765,1766", nextDialog = 1160, skipTime = -1, canSkip = 1}
, 
[1162] = {id = 1162, dialogList = "1767,1768", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1163] = {id = 1163, dialogList = "1769,1770", nextDialog = 1162, skipTime = -1, canSkip = 1}
, 
[1164] = {id = 1164, dialogList = "1771,1772,1773,1774", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1165] = {id = 1165, dialogList = "1775,1776,1777,1778,1779,1780,1781,1782,1783,1784,1785,1786,1787,1788", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1166] = {id = 1166, dialogList = "1789,1790,1791,1792", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1167] = {id = 1167, dialogList = "1793,1794,1795,1796,1797,1798,1799,1800,1801,1802,1803,1804", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1168] = {id = 1168, dialogList = "1805,1806,1807,1808,1809,1810", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1169] = {id = 1169, dialogList = "1811", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1170] = {id = 1170, dialogList = "1812,1813,1814,1815,1816,1817", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1171] = {id = 1171, dialogList = "1818", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1172] = {id = 1172, dialogList = "1819,1820,1821,1822,1823", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1173] = {id = 1173, dialogList = "1824", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1174] = {id = 1174, dialogList = "1825,1826", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1175] = {id = 1175, dialogList = "1827", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1176] = {id = 1176, dialogList = "1828,1829", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1177] = {id = 1177, dialogList = "1830,1831,1832,1833,1834,1835", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1178] = {id = 1178, dialogList = "1836,1837,1838,1839,1840", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1179] = {id = 1179, dialogList = "1841", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1180] = {id = 1180, dialogList = "1842,1843,1844,1845,1846,1847,1848,1849,1850", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1181] = {id = 1181, dialogList = "1851", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1182] = {id = 1182, dialogList = "1852", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1183] = {id = 1183, dialogList = "1853,1854,1855,1856,1857,1858,1859", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1184] = {id = 1184, dialogList = "1860", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1185] = {id = 1185, dialogList = "1861,1862,1863,1864,1865,1866,1867,1868,1869,1870,1871,1872,1873,1874,1875,1876,1877,1878,1879,1880", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1186] = {id = 1186, dialogList = "1881", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1187] = {id = 1187, dialogList = "1893,1894", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1188] = {id = 1188, dialogList = "1895", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1189] = {id = 1189, dialogList = "1896,1897,1898,1899", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1190] = {id = 1190, dialogList = "1900", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1191] = {id = 1191, dialogList = "1901,1902", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1192] = {id = 1192, dialogList = "1903,1904", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1193] = {id = 1193, dialogList = "1905,1906,1907,1908,1909,1910,1911,1912,1913,1914,1915,1917", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1194] = {id = 1194, dialogList = "1918,1919,1920,1925,1923", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1195] = {id = 1195, dialogList = "1926,1927", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1196] = {id = 1196, dialogList = "1928", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1197] = {id = 1197, dialogList = "1929,1930,1931,1932", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1198] = {id = 1198, dialogList = "1933,1934,1935,1936", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1199] = {id = 1199, dialogList = "1937,1938", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1200] = {id = 1200, dialogList = "1385", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1201] = {id = 1201, dialogList = "1482-1486", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1202] = {id = 1202, dialogList = "1584,1585,1586,1587,1588", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1203] = {id = 1203, dialogList = "1939", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1204] = {id = 1204, dialogList = "1602,1603", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1205] = {id = 1205, dialogList = "1630,1631,1632", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1206] = {id = 1206, dialogList = "1965,1966,1942,1943", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1207] = {id = 1207, dialogList = "1944,1945", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1208] = {id = 1208, dialogList = "1967,1968,1969,1971", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1209] = {id = 1209, dialogList = "1882,1883,1884,1885,1886,1887", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1210] = {id = 1210, dialogList = "1888,1889,1890,1891,1892", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1211] = {id = 1211, dialogList = "1972,1889,1890,1891,1892", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1212] = {id = 1212, dialogList = "1973", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1213] = {id = 1213, dialogList = "1974,1975,1976,1977,1978", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1214] = {id = 1214, dialogList = "1979", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1215] = {id = 1215, dialogList = "1980,1981,1982", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1216] = {id = 1216, dialogList = "1983,1984,1985,1986,1987,1988,1989", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1217] = {id = 1217, dialogList = "1990,1991,1992,1993,1994,1995,1996", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1218] = {id = 1218, dialogList = "1997,2009", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1219] = {id = 1219, dialogList = "1998,1999,2000,2001", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1220] = {id = 1220, dialogList = "2002,2003", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1221] = {id = 1221, dialogList = "2004,2005,2006", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1222] = {id = 1222, dialogList = "2007,2008", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1223] = {id = 1223, dialogList = "2019", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1224] = {id = 1224, dialogList = "2020,2021", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1225] = {id = 1225, dialogList = "1584-1588", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1226] = {id = 1226, dialogList = "2022,2023", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1227] = {id = 1227, dialogList = "1658,1659,1660", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1228] = {id = 1228, dialogList = "2026", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1229] = {id = 1229, dialogList = "382-386,2027-2030", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1230] = {id = 1230, dialogList = "2031,2032", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1231] = {id = 1231, dialogList = "2033,2034", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1232] = {id = 1232, dialogList = "2035,2036", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1233] = {id = 1233, dialogList = "2037", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1234] = {id = 1234, dialogList = "2038", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1235] = {id = 1235, dialogList = "2051-2054", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1236] = {id = 1236, dialogList = "2055-2059", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1237] = {id = 1237, dialogList = "2060-2070", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1238] = {id = 1238, dialogList = "2071-2074", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1239] = {id = 1239, dialogList = "2075", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1240] = {id = 1240, dialogList = "2076", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1241] = {id = 1241, dialogList = "2082-2089", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1242] = {id = 1242, dialogList = "2077", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1243] = {id = 1243, dialogList = "2078", nextDialog = 1244, skipTime = -1, canSkip = 0}
, 
[1244] = {id = 1244, dialogList = "2079-2081", nextDialog = 0, skipTime = -1, canSkip = 0}
, 
[1245] = {id = 1245, dialogList = "2090", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1246] = {id = 1246, dialogList = "2091-2094", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1247] = {id = 1247, dialogList = "2095-2115", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1248] = {id = 1248, dialogList = "2116-2123", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1249] = {id = 1249, dialogList = "2124-2130", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1250] = {id = 1250, dialogList = "2131", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1251] = {id = 1251, dialogList = "2132-2135", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1252] = {id = 1252, dialogList = "2146-2150", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1253] = {id = 1253, dialogList = "2151-2154", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1254] = {id = 1254, dialogList = "2153-2154", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1255] = {id = 1255, dialogList = "2155-2161", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1256] = {id = 1256, dialogList = "2162-2163", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1257] = {id = 1257, dialogList = "2164-2170", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1258] = {id = 1258, dialogList = "2136-2142", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1259] = {id = 1259, dialogList = "2143-2145", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1260] = {id = 1260, dialogList = "2171-2174", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1261] = {id = 1261, dialogList = "2175-2179", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1262] = {id = 1262, dialogList = "2180-2183", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1263] = {id = 1263, dialogList = "2184-2186", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1264] = {id = 1264, dialogList = "2187-2197", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1265] = {id = 1265, dialogList = "2198-2202", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1266] = {id = 1266, dialogList = "2203-2205", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1267] = {id = 1267, dialogList = "2206-2208", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1268] = {id = 1268, dialogList = "2209", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1269] = {id = 1269, dialogList = "2210-2211", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1270] = {id = 1270, dialogList = "2212-2214", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1271] = {id = 1271, dialogList = "2215-2221", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1272] = {id = 1272, dialogList = "2222-2223", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1273] = {id = 1273, dialogList = "2225", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1274] = {id = 1274, dialogList = "2226-2227", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1275] = {id = 1275, dialogList = "2228-2229", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1276] = {id = 1276, dialogList = "2230-2234", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1277] = {id = 1277, dialogList = "2235-2237", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1278] = {id = 1278, dialogList = "2238-2240", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1279] = {id = 1279, dialogList = "2241", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1280] = {id = 1280, dialogList = "2242-2245", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1281] = {id = 1281, dialogList = "2246-2256", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1282] = {id = 1282, dialogList = "2641", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1283] = {id = 1283, dialogList = "2642", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1284] = {id = 1284, dialogList = "2643", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1285] = {id = 1285, dialogList = "2644-2648", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1286] = {id = 1286, dialogList = "2649", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1287] = {id = 1287, dialogList = "2650,2651", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1288] = {id = 1288, dialogList = "2663", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1289] = {id = 1289, dialogList = "2666,2667", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1290] = {id = 1290, dialogList = "2668", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1291] = {id = 1291, dialogList = "2669", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1292] = {id = 1292, dialogList = "2670,2671", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1293] = {id = 1293, dialogList = "2672,2673", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1294] = {id = 1294, dialogList = "2674-2678", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1296] = {id = 1296, dialogList = "2679-2696", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1297] = {id = 1297, dialogList = "2697-2699", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1298] = {id = 1298, dialogList = "2700-2702", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1299] = {id = 1299, dialogList = "2703-2710", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1300] = {id = 1300, dialogList = "2711-2712", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1301] = {id = 1301, dialogList = "2713-2726", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1302] = {id = 1302, dialogList = "2727-2737", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1303] = {id = 1303, dialogList = "2738-2739", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1304] = {id = 1304, dialogList = "2740-2751", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1305] = {id = 1305, dialogList = "2752-2762", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1306] = {id = 1306, dialogList = "2765-2769", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1307] = {id = 1307, dialogList = "2770-2776", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1308] = {id = 1308, dialogList = "2777-2779", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1309] = {id = 1309, dialogList = "2274,2275,2276,2277,2278,2279", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1310] = {id = 1310, dialogList = "2257,2258", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1311] = {id = 1311, dialogList = "2782-2788", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1312] = {id = 1312, dialogList = "2789-2791", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1313] = {id = 1313, dialogList = "2792-2793", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1314] = {id = 1314, dialogList = "2794-2795", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1315] = {id = 1315, dialogList = "2796", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1316] = {id = 1316, dialogList = "2797", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1317] = {id = 1317, dialogList = "2798-2799", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1318] = {id = 1318, dialogList = "2800", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1319] = {id = 1319, dialogList = "2801", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1320] = {id = 1320, dialogList = "2802", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1321] = {id = 1321, dialogList = "2803", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1322] = {id = 1322, dialogList = "2804", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1323] = {id = 1323, dialogList = "2805", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1324] = {id = 1324, dialogList = "2806-2807", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1325] = {id = 1325, dialogList = "2808", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1326] = {id = 1326, dialogList = "2809-2810", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1327] = {id = 1327, dialogList = "2811", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1328] = {id = 1328, dialogList = "2812", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1329] = {id = 1329, dialogList = "2813-2817", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1330] = {id = 1330, dialogList = "2818", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1331] = {id = 1331, dialogList = "2819", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1332] = {id = 1332, dialogList = "2820", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1333] = {id = 1333, dialogList = "2821", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1334] = {id = 1334, dialogList = "2822,2823", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1335] = {id = 1335, dialogList = "2824", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1336] = {id = 1336, dialogList = "2825", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1337] = {id = 1337, dialogList = "2826", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1338] = {id = 1338, dialogList = "2827", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1339] = {id = 1339, dialogList = "2828,2829,2830", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1340] = {id = 1340, dialogList = "2831", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1341] = {id = 1341, dialogList = "2832,2833,2852", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1342] = {id = 1342, dialogList = "2835", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1343] = {id = 1343, dialogList = "2836-2837", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1344] = {id = 1344, dialogList = "2838", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1345] = {id = 1345, dialogList = "2839", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1346] = {id = 1346, dialogList = "2840", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1347] = {id = 1347, dialogList = "2834", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1348] = {id = 1348, dialogList = "2842-2843", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1349] = {id = 1349, dialogList = "2844", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1350] = {id = 1350, dialogList = "2845", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1351] = {id = 1351, dialogList = "2846", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1352] = {id = 1352, dialogList = "2855", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1353] = {id = 1353, dialogList = "2848", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1354] = {id = 1354, dialogList = "2849", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1355] = {id = 1355, dialogList = "2856", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1356] = {id = 1356, dialogList = "2851", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1357] = {id = 1357, dialogList = "2858", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1358] = {id = 1358, dialogList = "2853-2854,2862,2863", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1359] = {id = 1359, dialogList = "2857", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1360] = {id = 1360, dialogList = "2865", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1361] = {id = 1361, dialogList = "2859-2861", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1362] = {id = 1362, dialogList = "2867-2868", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1363] = {id = 1363, dialogList = "2864,2872", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1364] = {id = 1364, dialogList = "2866,2874,2889,2869,2870,2871", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1365] = {id = 1365, dialogList = "2921", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1366] = {id = 1366, dialogList = "2873,2875-2876", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1367] = {id = 1367, dialogList = "2877-2880", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1368] = {id = 1368, dialogList = "2881", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1369] = {id = 1369, dialogList = "2882", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1370] = {id = 1370, dialogList = "2883-2884", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1371] = {id = 1371, dialogList = "2885-2886", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1372] = {id = 1372, dialogList = "2887-2888", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1373] = {id = 1373, dialogList = "2939", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1374] = {id = 1374, dialogList = "2890", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1375] = {id = 1375, dialogList = "2891", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1376] = {id = 1376, dialogList = "2892", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1377] = {id = 1377, dialogList = "2893-2894", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1378] = {id = 1378, dialogList = "2895", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1379] = {id = 1379, dialogList = "2896-2897", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1380] = {id = 1380, dialogList = "2898-2899", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1381] = {id = 1381, dialogList = "2900", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1382] = {id = 1382, dialogList = "2901-2902", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1383] = {id = 1383, dialogList = "2903", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1384] = {id = 1384, dialogList = "2904", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1385] = {id = 1385, dialogList = "2905", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1386] = {id = 1386, dialogList = "2906", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1387] = {id = 1387, dialogList = "2907", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1388] = {id = 1388, dialogList = "2908", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1389] = {id = 1389, dialogList = "2909-2917", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1390] = {id = 1390, dialogList = "2918-2919", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1391] = {id = 1391, dialogList = "2920", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1392] = {id = 1392, dialogList = "2942", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1393] = {id = 1393, dialogList = "2922", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1394] = {id = 1394, dialogList = "2923", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1395] = {id = 1395, dialogList = "2924", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1396] = {id = 1396, dialogList = "2925-2926", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1397] = {id = 1397, dialogList = "2927-2928", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1398] = {id = 1398, dialogList = "2929", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1399] = {id = 1399, dialogList = "2930", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1400] = {id = 1400, dialogList = "2931-2932", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1401] = {id = 1401, dialogList = "2933", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1402] = {id = 1402, dialogList = "2934", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1403] = {id = 1403, dialogList = "2946", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1404] = {id = 1404, dialogList = "2936-2938", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1405] = {id = 1405, dialogList = "2940,2941,2950,2943,2944,2945,2951,2947", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1406] = {id = 1406, dialogList = "2841,2949,2847,2850", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1407] = {id = 1407, dialogList = "2952", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1408] = {id = 1408, dialogList = "2953", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1409] = {id = 1409, dialogList = "2954-2958", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1410] = {id = 1410, dialogList = "2959-2960", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1411] = {id = 1411, dialogList = "2961-2962", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1412] = {id = 1412, dialogList = "2963-2964", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1413] = {id = 1413, dialogList = "2965-2972", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1414] = {id = 1414, dialogList = "2973", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1415] = {id = 1415, dialogList = "2974", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1416] = {id = 1416, dialogList = "2975", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1417] = {id = 1417, dialogList = "2976-2977", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1418] = {id = 1418, dialogList = "2978", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1419] = {id = 1419, dialogList = "2979-2981", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1420] = {id = 1420, dialogList = "2982", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1421] = {id = 1421, dialogList = "2984-2985", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1422] = {id = 1422, dialogList = "2986-2991", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1423] = {id = 1423, dialogList = "2992-2993", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1424] = {id = 1424, dialogList = "2994", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1425] = {id = 1425, dialogList = "2995", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1426] = {id = 1426, dialogList = "2996", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1427] = {id = 1427, dialogList = "2997", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1428] = {id = 1428, dialogList = "2998", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1429] = {id = 1429, dialogList = "2999", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1430] = {id = 1430, dialogList = "3000-3005", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1431] = {id = 1431, dialogList = "3006-3007", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1432] = {id = 1432, dialogList = "3008", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1433] = {id = 1433, dialogList = "3010-3013", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1434] = {id = 1434, dialogList = "3014-3015", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1435] = {id = 1435, dialogList = "3016", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1436] = {id = 1436, dialogList = "3017", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1437] = {id = 1437, dialogList = "2579", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1438] = {id = 1438, dialogList = "2580-2584", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1439] = {id = 1439, dialogList = "2585-2591", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1440] = {id = 1440, dialogList = "2284", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1441] = {id = 1441, dialogList = "2285,2286,2287", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1442] = {id = 1442, dialogList = "2288-2290", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1443] = {id = 1443, dialogList = "2291-2293", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1444] = {id = 1444, dialogList = "2294", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1445] = {id = 1445, dialogList = "2295,2296", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1446] = {id = 1446, dialogList = "2297", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1447] = {id = 1447, dialogList = "2298-2312", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1448] = {id = 1448, dialogList = "2313-2315", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1449] = {id = 1449, dialogList = "2316", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1450] = {id = 1450, dialogList = "2317", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1451] = {id = 1451, dialogList = "2318", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1452] = {id = 1452, dialogList = "2321", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1453] = {id = 1453, dialogList = "2322", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1454] = {id = 1454, dialogList = "2324-2330", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1455] = {id = 1455, dialogList = "2331", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1456] = {id = 1456, dialogList = "2332-2338", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1457] = {id = 1457, dialogList = "2339-2343", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1458] = {id = 1458, dialogList = "2344-2347", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1459] = {id = 1459, dialogList = "2348-2354", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1460] = {id = 1460, dialogList = "2355-2358", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1461] = {id = 1461, dialogList = "2359", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1462] = {id = 1462, dialogList = "2360-2362", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1463] = {id = 1463, dialogList = "2372,2373", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1464] = {id = 1464, dialogList = "2374-2378", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1465] = {id = 1465, dialogList = "2379", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1466] = {id = 1466, dialogList = "2380-2385", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1467] = {id = 1467, dialogList = "2386", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1468] = {id = 1468, dialogList = "2387", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1469] = {id = 1469, dialogList = "2388-2393", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1470] = {id = 1470, dialogList = "2395", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1471] = {id = 1471, dialogList = "2396,2397", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1472] = {id = 1472, dialogList = "2398-2408", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1473] = {id = 1473, dialogList = "2409-2414", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1474] = {id = 1474, dialogList = "2420-2422", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1475] = {id = 1475, dialogList = "2423-2427", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1476] = {id = 1476, dialogList = "2437-2442", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1477] = {id = 1477, dialogList = "2443-2452", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1478] = {id = 1478, dialogList = "2453-2455", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1479] = {id = 1479, dialogList = "2456-2460", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1480] = {id = 1480, dialogList = "2461-2464", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1481] = {id = 1481, dialogList = "2465", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1482] = {id = 1482, dialogList = "2466-2467", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1483] = {id = 1483, dialogList = "2468-2476", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1484] = {id = 1484, dialogList = "2477-2478", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1485] = {id = 1485, dialogList = "2479-2480", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1486] = {id = 1486, dialogList = "2481", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1487] = {id = 1487, dialogList = "2482-2483", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1488] = {id = 1488, dialogList = "2484-2490", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1489] = {id = 1489, dialogList = "2491,2492", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1490] = {id = 1490, dialogList = "2493-2501", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1491] = {id = 1491, dialogList = "2502", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1492] = {id = 1492, dialogList = "2503-2509", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1493] = {id = 1493, dialogList = "2510-2513", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1494] = {id = 1494, dialogList = "2514-2520", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1495] = {id = 1495, dialogList = "2521-2528", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1496] = {id = 1496, dialogList = "2529", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1497] = {id = 1497, dialogList = "2534-2543", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1498] = {id = 1498, dialogList = "2544-2549", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1499] = {id = 1499, dialogList = "2550-2556", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1500] = {id = 1500, dialogList = "2557-2559", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1501] = {id = 1501, dialogList = "2560,2561", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1502] = {id = 1502, dialogList = "2562-2567", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1503] = {id = 1503, dialogList = "2568", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1504] = {id = 1504, dialogList = "2569-2573", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1505] = {id = 1505, dialogList = "2574-2578", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1506] = {id = 1506, dialogList = "2579-2584", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1507] = {id = 1507, dialogList = "2585-2591", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1508] = {id = 1508, dialogList = "2592,2593", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1509] = {id = 1509, dialogList = "2594-2597", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1510] = {id = 1510, dialogList = "2598", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1511] = {id = 1511, dialogList = "2599-2609", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1512] = {id = 1512, dialogList = "2610", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1513] = {id = 1513, dialogList = "2611-2616", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1514] = {id = 1514, dialogList = "2617", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1515] = {id = 1515, dialogList = "2618,2619,2620", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1516] = {id = 1516, dialogList = "2621-2624", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1517] = {id = 1517, dialogList = "2764", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1518] = {id = 1518, dialogList = "3019-3025", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1519] = {id = 1519, dialogList = "3026-3037", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1520] = {id = 1520, dialogList = "3038", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1521] = {id = 1521, dialogList = "3009", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1522] = {id = 1522, dialogList = "3039", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1523] = {id = 1523, dialogList = "2259-2266", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1524] = {id = 1524, dialogList = "2267-2273", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1525] = {id = 1525, dialogList = "2656,2657", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1526] = {id = 1526, dialogList = "2658", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1527] = {id = 1527, dialogList = "2659,2660", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1528] = {id = 1528, dialogList = "2780,2781,2283", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1529] = {id = 1529, dialogList = "3040", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1530] = {id = 1530, dialogList = "3041", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1531] = {id = 1531, dialogList = "2530,2531", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1532] = {id = 1532, dialogList = "2532,2533", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1533] = {id = 1533, dialogList = "2625,2626", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1534] = {id = 1534, dialogList = "2627", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1535] = {id = 1535, dialogList = "2629", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1536] = {id = 1536, dialogList = "2630,2631", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1537] = {id = 1537, dialogList = "2632-2636", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1538] = {id = 1538, dialogList = "2637", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1539] = {id = 1539, dialogList = "2638", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1540] = {id = 1540, dialogList = "2639,2640", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1541] = {id = 1541, dialogList = "3042,3043", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1542] = {id = 1542, dialogList = "3044", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1543] = {id = 1543, dialogList = "3045-3052", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1544] = {id = 1544, dialogList = "3053-3056", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1545] = {id = 1545, dialogList = "2363-2365", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1546] = {id = 1546, dialogList = "2366-2367", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1547] = {id = 1547, dialogList = "2368-2371", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1548] = {id = 1548, dialogList = "2664,2665", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1549] = {id = 1549, dialogList = "3057-3060", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1550] = {id = 1550, dialogList = "3061-3068", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1551] = {id = 1551, dialogList = "3069-3071", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1552] = {id = 1552, dialogList = "3073-3086", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1553] = {id = 1553, dialogList = "3087,3088", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1554] = {id = 1554, dialogList = "3089-3101", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1555] = {id = 1555, dialogList = "3106-3108", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1556] = {id = 1556, dialogList = "3109-3113", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1557] = {id = 1557, dialogList = "3114", nextDialog = 0, skipTime = -1, canSkip = -1}
, 
[1558] = {id = 1558, dialogList = "3121-3123", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1559] = {id = 1559, dialogList = "3124-3127", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1560] = {id = 1560, dialogList = "3131-3134", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1561] = {id = 1561, dialogList = "3135-3136", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1562] = {id = 1562, dialogList = "3137", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1563] = {id = 1563, dialogList = "3138", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1564] = {id = 1564, dialogList = "3139-3144", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1565] = {id = 1565, dialogList = "3146-3151", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1566] = {id = 1566, dialogList = "3152-3154", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1567] = {id = 1567, dialogList = "3155-3156", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1568] = {id = 1568, dialogList = "3115-3120", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1569] = {id = 1569, dialogList = "3157-3159", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1570] = {id = 1570, dialogList = "3160-3168", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1571] = {id = 1571, dialogList = "3171-3178", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1572] = {id = 1572, dialogList = "3179-3183", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1573] = {id = 1573, dialogList = "3184", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1574] = {id = 1574, dialogList = "3185", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1575] = {id = 1575, dialogList = "3186-3192", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1576] = {id = 1576, dialogList = "3145", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1577] = {id = 1577, dialogList = "3193-3194", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1578] = {id = 1578, dialogList = "3195-3205", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1579] = {id = 1579, dialogList = "3206", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1580] = {id = 1580, dialogList = "3207,3247", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1581] = {id = 1581, dialogList = "3208-3211", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1582] = {id = 1582, dialogList = "3212-3216", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1583] = {id = 1583, dialogList = "3217-3218", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1584] = {id = 1584, dialogList = "3219-3222", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1585] = {id = 1585, dialogList = "3223-3227", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1586] = {id = 1586, dialogList = "3228-3232", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1587] = {id = 1587, dialogList = "3233-3234", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1588] = {id = 1588, dialogList = "3235-3236", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1589] = {id = 1589, dialogList = "3237-3240", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1590] = {id = 1590, dialogList = "3241-3245", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1591] = {id = 1591, dialogList = "3072", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1592] = {id = 1592, dialogList = "3102,3103", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1593] = {id = 1593, dialogList = "3104", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1594] = {id = 1594, dialogList = "3105", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1595] = {id = 1595, dialogList = "3246", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1596] = {id = 1596, dialogList = "3128-3130", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1597] = {id = 1597, dialogList = "3169-3170", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1598] = {id = 1598, dialogList = "3248-3250", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1599] = {id = 1599, dialogList = "3251", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1600] = {id = 1600, dialogList = "3252,3253", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1601] = {id = 1601, dialogList = "3257,3258,3259", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1602] = {id = 1602, dialogList = "3260", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1603] = {id = 1603, dialogList = "3261", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1604] = {id = 1604, dialogList = "3262-3268", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1605] = {id = 1605, dialogList = "3269,3270", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1606] = {id = 1606, dialogList = "3271,3272", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1607] = {id = 1607, dialogList = "3273", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1608] = {id = 1608, dialogList = "3273", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1609] = {id = 1609, dialogList = "3274-3276", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1610] = {id = 1610, dialogList = "3277-3281", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1611] = {id = 1611, dialogList = "3283-3291", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1612] = {id = 1612, dialogList = "3292-3302", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1613] = {id = 1613, dialogList = "3303-3309", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1614] = {id = 1614, dialogList = "3310-3314", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1615] = {id = 1615, dialogList = "3315-3319", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1616] = {id = 1616, dialogList = "3320-3329", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1617] = {id = 1617, dialogList = "3330-3336", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1618] = {id = 1618, dialogList = "3337-3342", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1619] = {id = 1619, dialogList = "3343-3348", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1620] = {id = 1620, dialogList = "3349-3350", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1621] = {id = 1621, dialogList = "3351", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1622] = {id = 1622, dialogList = "3352-3356", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1623] = {id = 1623, dialogList = "3357", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1624] = {id = 1624, dialogList = "3358-3359", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1625] = {id = 1625, dialogList = "3360-3364", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1626] = {id = 1626, dialogList = "3365-3366", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1627] = {id = 1627, dialogList = "3367", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1628] = {id = 1628, dialogList = "3368", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1629] = {id = 1629, dialogList = "3369-3373", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1630] = {id = 1630, dialogList = "3374-3377", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1631] = {id = 1631, dialogList = "3378-3379", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1632] = {id = 1632, dialogList = "3380-3386", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1633] = {id = 1633, dialogList = "3387", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1634] = {id = 1634, dialogList = "3388-3399", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1635] = {id = 1635, dialogList = "3400-3408", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1636] = {id = 1636, dialogList = "3409-3412", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1637] = {id = 1637, dialogList = "3413-3422", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1638] = {id = 1638, dialogList = "3423", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1639] = {id = 1639, dialogList = "3424", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1640] = {id = 1640, dialogList = "3425", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1641] = {id = 1641, dialogList = "3426-3429", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1642] = {id = 1642, dialogList = "3430-3435", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1643] = {id = 1643, dialogList = "3436-3440", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1644] = {id = 1644, dialogList = "3441-3452", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1645] = {id = 1645, dialogList = "3453-3454", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1646] = {id = 1646, dialogList = "3455-3463", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1647] = {id = 1647, dialogList = "3464-3470", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1648] = {id = 1648, dialogList = "3471-3476", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1649] = {id = 1649, dialogList = "3477-3481", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1650] = {id = 1650, dialogList = "3482-3487", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1651] = {id = 1651, dialogList = "3488", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1652] = {id = 1652, dialogList = "3489-3498", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1653] = {id = 1653, dialogList = "3499-3502", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1654] = {id = 1654, dialogList = "3503-3520", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1655] = {id = 1655, dialogList = "3523", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1656] = {id = 1656, dialogList = "3524-3542", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1657] = {id = 1657, dialogList = "3543-3546", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1658] = {id = 1658, dialogList = "3547-3558", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1659] = {id = 1659, dialogList = "3559-3563", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1660] = {id = 1660, dialogList = "3564", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1661] = {id = 1661, dialogList = "3565-3568", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1662] = {id = 1662, dialogList = "3569", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1663] = {id = 1663, dialogList = "3570-3577", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1664] = {id = 1664, dialogList = "3578-3593", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1665] = {id = 1665, dialogList = "3594-3597", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1666] = {id = 1666, dialogList = "3598-3600", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1667] = {id = 1667, dialogList = "3601-3604", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1668] = {id = 1668, dialogList = "3605-3607", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1669] = {id = 1669, dialogList = "3608", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1670] = {id = 1670, dialogList = "3609-3620", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1671] = {id = 1671, dialogList = "3621-3627", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1672] = {id = 1672, dialogList = "3628-3629", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1673] = {id = 1673, dialogList = "3630-3636", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1674] = {id = 1674, dialogList = "3637-3646", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1675] = {id = 1675, dialogList = "3647-3648", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1676] = {id = 1676, dialogList = "3649-3654", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1677] = {id = 1677, dialogList = "3655-3658", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1678] = {id = 1678, dialogList = "3282", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1679] = {id = 1679, dialogList = "3521-3522", nextDialog = 0, skipTime = -1, canSkip = 1}
, 
[1680] = {id = 1680, dialogList = "3596", nextDialog = 0, skipTime = -1, canSkip = 1}
}
cdramachatconfig.AllIds = {6, 7, 8, 14, 15, 22, 25, 26, 27, 29, 30, 31, 33, 34, 35, 40, 46, 47, 48, 52, 56, 70, 75, 77, 84, 114, 130, 140, 148, 157, 161, 176, 179, 180, 181, 187, 191, 199, 202, 224, 232, 234, 237, 251, 258, 262, 267, 269, 276, 278, 279, 285, 297, 299, 303, 307, 310, 316, 318, 323, 334, 339, 340, 347, 353, 368, 383, 394, 396, 400, 414, 420, 444, 462, 473, 477, 499, 508, 520, 532, 543, 546, 550, 551, 552, 553, 554, 555, 556, 561, 567, 568, 570, 573, 580, 589, 592, 606, 609, 614, 625, 628, 634, 648, 650, 657, 665, 671, 677, 685, 686, 688, 690, 697, 720, 723, 724, 731, 735, 781, 795, 802, 811, 819, 833, 842, 847, 852, 857, 859, 862, 865, 874, 876, 881, 885, 886, 895, 899, 905, 913, 915, 930, 943, 944, 954, 959, 976, 986, 990, 1001, 1002, 1006, 1007, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1023, 1031, 1032, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165, 1166, 1167, 1168, 1169, 1170, 1171, 1172, 1173, 1174, 1175, 1176, 1177, 1178, 1179, 1180, 1181, 1182, 1183, 1184, 1185, 1186, 1187, 1188, 1189, 1190, 1191, 1192, 1193, 1194, 1195, 1196, 1197, 1198, 1199, 1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1217, 1218, 1219, 1220, 1221, 1222, 1223, 1224, 1225, 1226, 1227, 1228, 1229, 1230, 1231, 1232, 1233, 1234, 1235, 1236, 1237, 1238, 1239, 1240, 1241, 1242, 1243, 1244, 1245, 1246, 1247, 1248, 1249, 1250, 1251, 1252, 1253, 1254, 1255, 1256, 1257, 1258, 1259, 1260, 1261, 1262, 1263, 1264, 1265, 1266, 1267, 1268, 1269, 1270, 1271, 1272, 1273, 1274, 1275, 1276, 1277, 1278, 1279, 1280, 1281, 1282, 1283, 1284, 1285, 1286, 1287, 1288, 1289, 1290, 1291, 1292, 1293, 1294, 1296, 1297, 1298, 1299, 1300, 1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310, 1311, 1312, 1313, 1314, 1315, 1316, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1329, 1330, 1331, 1332, 1333, 1334, 1335, 1336, 1337, 1338, 1339, 1340, 1341, 1342, 1343, 1344, 1345, 1346, 1347, 1348, 1349, 1350, 1351, 1352, 1353, 1354, 1355, 1356, 1357, 1358, 1359, 1360, 1361, 1362, 1363, 1364, 1365, 1366, 1367, 1368, 1369, 1370, 1371, 1372, 1373, 1374, 1375, 1376, 1377, 1378, 1379, 1380, 1381, 1382, 1383, 1384, 1385, 1386, 1387, 1388, 1389, 1390, 1391, 1392, 1393, 1394, 1395, 1396, 1397, 1398, 1399, 1400, 1401, 1402, 1403, 1404, 1405, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1414, 1415, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1436, 1437, 1438, 1439, 1440, 1441, 1442, 1443, 1444, 1445, 1446, 1447, 1448, 1449, 1450, 1451, 1452, 1453, 1454, 1455, 1456, 1457, 1458, 1459, 1460, 1461, 1462, 1463, 1464, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472, 1473, 1474, 1475, 1476, 1477, 1478, 1479, 1480, 1481, 1482, 1483, 1484, 1485, 1486, 1487, 1488, 1489, 1490, 1491, 1492, 1493, 1494, 1495, 1496, 1497, 1498, 1499, 1500, 1501, 1502, 1503, 1504, 1505, 1506, 1507, 1508, 1509, 1510, 1511, 1512, 1513, 1514, 1515, 1516, 1517, 1518, 1519, 1520, 1521, 1522, 1523, 1524, 1525, 1526, 1527, 1528, 1529, 1530, 1531, 1532, 1533, 1534, 1535, 1536, 1537, 1538, 1539, 1540, 1541, 1542, 1543, 1544, 1545, 1546, 1547, 1548, 1549, 1550, 1551, 1552, 1553, 1554, 1555, 1556, 1557, 1558, 1559, 1560, 1561, 1562, 1563, 1564, 1565, 1566, 1567, 1568, 1569, 1570, 1571, 1572, 1573, 1574, 1575, 1576, 1577, 1578, 1579, 1580, 1581, 1582, 1583, 1584, 1585, 1586, 1587, 1588, 1589, 1590, 1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, 1600, 1601, 1602, 1603, 1604, 1605, 1606, 1607, 1608, 1609, 1610, 1611, 1612, 1613, 1614, 1615, 1616, 1617, 1618, 1619, 1620, 1621, 1622, 1623, 1624, 1625, 1626, 1627, 1628, 1629, 1630, 1631, 1632, 1633, 1634, 1635, 1636, 1637, 1638, 1639, 1640, 1641, 1642, 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, 1653, 1654, 1655, 1656, 1657, 1658, 1659, 1660, 1661, 1662, 1663, 1664, 1665, 1666, 1667, 1668, 1669, 1670, 1671, 1672, 1673, 1674, 1675, 1676, 1677, 1678, 1679, 1680}
return cdramachatconfig

