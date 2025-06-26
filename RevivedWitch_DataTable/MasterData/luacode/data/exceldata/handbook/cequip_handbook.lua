-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/handbook/cequip_handbook.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cequip_handbook = {}
cequip_handbook.Data = {
[45001] = {id = 45001, nameTextID = 1800300, rarity = 1, icon = 10670, isShow = 1, itemType = 299, equipNumber = "P-01", destribeTextID = 1800580, 
abilityID = {20, 30}
, 
abilityValue = {91.8, 4.41}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[45002] = {id = 45002, nameTextID = 1800301, rarity = 2, icon = 10524, isShow = 1, itemType = 299, equipNumber = "P-02", destribeTextID = 1800581, 
abilityID = {20, 30}
, 
abilityValue = {97.2, 4.67}
, initMagnify = 10, 
randomAbility = {71}
, equipSuitid = 0}
, 
[45003] = {id = 45003, nameTextID = 1800302, rarity = 2, icon = 10523, isShow = 0, itemType = 299, equipNumber = "N-01", destribeTextID = 1800582, 
abilityID = {20, 30}
, 
abilityValue = {99.63, 4.78}
, initMagnify = 10, 
randomAbility = {71}
, equipSuitid = 0}
, 
[45004] = {id = 45004, nameTextID = 1800303, rarity = 3, icon = 10522, isShow = 1, itemType = 299, equipNumber = "P-03", destribeTextID = 1800583, 
abilityID = {20, 30}
, 
abilityValue = {102.6, 4.92}
, initMagnify = 10, 
randomAbility = {72}
, equipSuitid = 0}
, 
[45005] = {id = 45005, nameTextID = 1800304, rarity = 3, icon = 11259, isShow = 0, itemType = 299, equipNumber = "N-02", destribeTextID = 1800584, 
abilityID = {20, 30}
, 
abilityValue = {105.17, 5.05}
, initMagnify = 10, 
randomAbility = {72}
, equipSuitid = 0}
, 
[45006] = {id = 45006, nameTextID = 1800305, rarity = 5, icon = 11260, isShow = 1, itemType = 299, equipNumber = "P-04", destribeTextID = 1800585, 
abilityID = {20, 30}
, 
abilityValue = {110.7, 5.18}
, initMagnify = 10, 
randomAbility = {73, 73}
, equipSuitid = 0}
, 
[45007] = {id = 45007, nameTextID = 1800306, rarity = 5, icon = 11261, isShow = 1, itemType = 299, equipNumber = "P-05", destribeTextID = 1800586, 
abilityID = {20, 30}
, 
abilityValue = {108, 5.31}
, initMagnify = 10, 
randomAbility = {73, 73}
, equipSuitid = 0}
, 
[45008] = {id = 45008, nameTextID = 1800307, rarity = 5, icon = 11262, isShow = 1, itemType = 299, equipNumber = "P-06", destribeTextID = 1800587, 
abilityID = {20, 30}
, 
abilityValue = {118.8, 5.44}
, initMagnify = 10, 
randomAbility = {73, 73}
, equipSuitid = 8}
, 
[45009] = {id = 45009, nameTextID = 1800308, rarity = 5, icon = 11263, isShow = 1, itemType = 299, equipNumber = "P-07", destribeTextID = 1800588, 
abilityID = {20, 30}
, 
abilityValue = {113.4, 5.7}
, initMagnify = 10, 
randomAbility = {73, 73}
, equipSuitid = 11}
, 
[45201] = {id = 45201, nameTextID = 1800309, rarity = 1, icon = 10673, isShow = 1, itemType = 299, equipNumber = "P-08", destribeTextID = 1800589, 
abilityID = {20, 30}
, 
abilityValue = {64.26, 7.34}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[45202] = {id = 45202, nameTextID = 1800310, rarity = 2, icon = 10674, isShow = 1, itemType = 299, equipNumber = "P-09", destribeTextID = 1800590, 
abilityID = {20, 30}
, 
abilityValue = {68.04, 7.78}
, initMagnify = 10, 
randomAbility = {71}
, equipSuitid = 0}
, 
[45203] = {id = 45203, nameTextID = 1800311, rarity = 2, icon = 10675, isShow = 0, itemType = 299, equipNumber = "N-03", destribeTextID = 1800591, 
abilityID = {20, 30}
, 
abilityValue = {69.74, 7.97}
, initMagnify = 10, 
randomAbility = {71}
, equipSuitid = 0}
, 
[45204] = {id = 45204, nameTextID = 1800312, rarity = 3, icon = 10676, isShow = 1, itemType = 299, equipNumber = "P-10", destribeTextID = 1800592, 
abilityID = {20, 30}
, 
abilityValue = {71.82, 8.21}
, initMagnify = 10, 
randomAbility = {72}
, equipSuitid = 0}
, 
[45205] = {id = 45205, nameTextID = 1800313, rarity = 3, icon = 11254, isShow = 0, itemType = 299, equipNumber = "N-04", destribeTextID = 1800593, 
abilityID = {20, 30}
, 
abilityValue = {73.62, 8.41}
, initMagnify = 10, 
randomAbility = {72}
, equipSuitid = 0}
, 
[45206] = {id = 45206, nameTextID = 1800314, rarity = 5, icon = 11255, isShow = 1, itemType = 299, equipNumber = "P-11", destribeTextID = 1800594, 
abilityID = {20, 30}
, 
abilityValue = {77.49, 8.64}
, initMagnify = 10, 
randomAbility = {73, 73}
, equipSuitid = 0}
, 
[45207] = {id = 45207, nameTextID = 1800315, rarity = 5, icon = 11256, isShow = 1, itemType = 299, equipNumber = "P-12", destribeTextID = 1800595, 
abilityID = {20, 30}
, 
abilityValue = {75.6, 8.86}
, initMagnify = 10, 
randomAbility = {73, 73}
, equipSuitid = 0}
, 
[45208] = {id = 45208, nameTextID = 1800316, rarity = 5, icon = 11257, isShow = 1, itemType = 299, equipNumber = "P-13", destribeTextID = 1800596, 
abilityID = {20, 30}
, 
abilityValue = {83.16, 9.07}
, initMagnify = 10, 
randomAbility = {73, 73}
, equipSuitid = 8}
, 
[45209] = {id = 45209, nameTextID = 1800317, rarity = 5, icon = 11258, isShow = 1, itemType = 299, equipNumber = "P-14", destribeTextID = 1800597, 
abilityID = {20, 30}
, 
abilityValue = {79.38, 9.5}
, initMagnify = 10, 
randomAbility = {73, 73}
, equipSuitid = 11}
, 
[45401] = {id = 45401, nameTextID = 1800318, rarity = 1, icon = 10532, isShow = 1, itemType = 299, equipNumber = "P-15", destribeTextID = 1800598, 
abilityID = {20, 30}
, 
abilityValue = {64.26, 10.92}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[45402] = {id = 45402, nameTextID = 1800319, rarity = 2, icon = 10533, isShow = 1, itemType = 299, equipNumber = "P-16", destribeTextID = 1800599, 
abilityID = {20, 30}
, 
abilityValue = {68.04, 11.57}
, initMagnify = 10, 
randomAbility = {11}
, equipSuitid = 0}
, 
[45403] = {id = 45403, nameTextID = 1800320, rarity = 2, icon = 10534, isShow = 0, itemType = 299, equipNumber = "N-05", destribeTextID = 1800600, 
abilityID = {20, 30}
, 
abilityValue = {69.74, 11.86}
, initMagnify = 10, 
randomAbility = {11}
, equipSuitid = 0}
, 
[45404] = {id = 45404, nameTextID = 1800321, rarity = 3, icon = 10726, isShow = 1, itemType = 299, equipNumber = "P-17", destribeTextID = 1800601, 
abilityID = {20, 30}
, 
abilityValue = {71.82, 12.21}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 0}
, 
[45405] = {id = 45405, nameTextID = 1800322, rarity = 3, icon = 11279, isShow = 0, itemType = 299, equipNumber = "N-06", destribeTextID = 1800602, 
abilityID = {20, 30}
, 
abilityValue = {73.62, 12.51}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 0}
, 
[45406] = {id = 45406, nameTextID = 1800323, rarity = 5, icon = 11280, isShow = 1, itemType = 299, equipNumber = "P-18", destribeTextID = 1800603, 
abilityID = {20, 30}
, 
abilityValue = {77.49, 12.85}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[45407] = {id = 45407, nameTextID = 1800324, rarity = 5, icon = 11281, isShow = 1, itemType = 299, equipNumber = "P-19", destribeTextID = 1800604, 
abilityID = {20, 30}
, 
abilityValue = {75.6, 13.17}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[45408] = {id = 45408, nameTextID = 1800325, rarity = 5, icon = 11282, isShow = 1, itemType = 299, equipNumber = "P-20", destribeTextID = 1800605, 
abilityID = {20, 30}
, 
abilityValue = {83.16, 13.49}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 8}
, 
[45409] = {id = 45409, nameTextID = 1800326, rarity = 5, icon = 11283, isShow = 1, itemType = 299, equipNumber = "P-21", destribeTextID = 1800606, 
abilityID = {20, 30}
, 
abilityValue = {79.38, 14.14}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 11}
, 
[45601] = {id = 45601, nameTextID = 1800327, rarity = 1, icon = 10677, isShow = 1, itemType = 299, equipNumber = "P-22", destribeTextID = 1800607, 
abilityID = {20, 30}
, 
abilityValue = {32.13, 15.61}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[45602] = {id = 45602, nameTextID = 1800328, rarity = 2, icon = 10678, isShow = 1, itemType = 299, equipNumber = "P-23", destribeTextID = 1800608, 
abilityID = {20, 30}
, 
abilityValue = {34.02, 16.52}
, initMagnify = 10, 
randomAbility = {11}
, equipSuitid = 0}
, 
[45603] = {id = 45603, nameTextID = 1800329, rarity = 2, icon = 10679, isShow = 0, itemType = 299, equipNumber = "N-07", destribeTextID = 1800609, 
abilityID = {20, 30}
, 
abilityValue = {34.87, 16.94}
, initMagnify = 10, 
randomAbility = {11}
, equipSuitid = 0}
, 
[45604] = {id = 45604, nameTextID = 1800330, rarity = 3, icon = 10680, isShow = 1, itemType = 299, equipNumber = "P-24", destribeTextID = 1800610, 
abilityID = {20, 30}
, 
abilityValue = {35.91, 17.44}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 0}
, 
[45605] = {id = 45605, nameTextID = 1800331, rarity = 3, icon = 11269, isShow = 0, itemType = 299, equipNumber = "N-08", destribeTextID = 1800611, 
abilityID = {20, 30}
, 
abilityValue = {36.81, 17.88}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 0}
, 
[45606] = {id = 45606, nameTextID = 1800332, rarity = 5, icon = 11270, isShow = 1, itemType = 299, equipNumber = "P-25", destribeTextID = 1800612, 
abilityID = {20, 30}
, 
abilityValue = {38.75, 18.36}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[45607] = {id = 45607, nameTextID = 1800333, rarity = 5, icon = 11271, isShow = 1, itemType = 299, equipNumber = "P-26", destribeTextID = 1800613, 
abilityID = {20, 30}
, 
abilityValue = {37.8, 18.82}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[45608] = {id = 45608, nameTextID = 1800334, rarity = 5, icon = 11272, isShow = 1, itemType = 299, equipNumber = "P-27", destribeTextID = 1800614, 
abilityID = {20, 30}
, 
abilityValue = {41.58, 19.28}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 8}
, 
[45609] = {id = 45609, nameTextID = 1800335, rarity = 5, icon = 11273, isShow = 1, itemType = 299, equipNumber = "P-28", destribeTextID = 1800615, 
abilityID = {20, 30}
, 
abilityValue = {39.69, 20.2}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 11}
, 
[45801] = {id = 45801, nameTextID = 1800336, rarity = 1, icon = 10517, isShow = 1, itemType = 299, equipNumber = "P-29", destribeTextID = 1800616, 
abilityID = {20, 30}
, 
abilityValue = {36.72, 12.85}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[45802] = {id = 45802, nameTextID = 1800337, rarity = 2, icon = 10516, isShow = 1, itemType = 299, equipNumber = "P-30", destribeTextID = 1800617, 
abilityID = {20, 30}
, 
abilityValue = {38.88, 13.61}
, initMagnify = 10, 
randomAbility = {11}
, equipSuitid = 0}
, 
[45803] = {id = 45803, nameTextID = 1800338, rarity = 2, icon = 10515, isShow = 0, itemType = 299, equipNumber = "N-09", destribeTextID = 1800618, 
abilityID = {20, 30}
, 
abilityValue = {39.85, 13.95}
, initMagnify = 10, 
randomAbility = {11}
, equipSuitid = 0}
, 
[45804] = {id = 45804, nameTextID = 1800339, rarity = 3, icon = 10668, isShow = 1, itemType = 299, equipNumber = "P-31", destribeTextID = 1800619, 
abilityID = {20, 30}
, 
abilityValue = {41.04, 14.36}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 0}
, 
[45805] = {id = 45805, nameTextID = 1800340, rarity = 3, icon = 11249, isShow = 0, itemType = 299, equipNumber = "N-10", destribeTextID = 1800620, 
abilityID = {20, 30}
, 
abilityValue = {42.07, 14.72}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 0}
, 
[45806] = {id = 45806, nameTextID = 1800341, rarity = 5, icon = 11250, isShow = 1, itemType = 299, equipNumber = "P-32", destribeTextID = 1800621, 
abilityID = {20, 30}
, 
abilityValue = {44.28, 15.12}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[45807] = {id = 45807, nameTextID = 1800342, rarity = 5, icon = 11251, isShow = 1, itemType = 299, equipNumber = "P-33", destribeTextID = 1800622, 
abilityID = {20, 30}
, 
abilityValue = {43.2, 15.5}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[45808] = {id = 45808, nameTextID = 1800343, rarity = 5, icon = 11252, isShow = 1, itemType = 299, equipNumber = "P-34", destribeTextID = 1800623, 
abilityID = {20, 30}
, 
abilityValue = {47.52, 15.88}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 8}
, 
[45809] = {id = 45809, nameTextID = 1800344, rarity = 5, icon = 11253, isShow = 1, itemType = 299, equipNumber = "P-35", destribeTextID = 1800624, 
abilityID = {20, 30}
, 
abilityValue = {45.36, 16.63}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 11}
, 
[46001] = {id = 46001, nameTextID = 1800345, rarity = 1, icon = 10705, isShow = 1, itemType = 299, equipNumber = "P-36", destribeTextID = 1800625, 
abilityID = {20, 30}
, 
abilityValue = {11.02, 18.36}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[46002] = {id = 46002, nameTextID = 1800346, rarity = 2, icon = 10706, isShow = 1, itemType = 299, equipNumber = "P-37", destribeTextID = 1800626, 
abilityID = {20, 30}
, 
abilityValue = {11.66, 19.44}
, initMagnify = 10, 
randomAbility = {11}
, equipSuitid = 0}
, 
[46003] = {id = 46003, nameTextID = 1800347, rarity = 2, icon = 10707, isShow = 0, itemType = 299, equipNumber = "N-11", destribeTextID = 1800627, 
abilityID = {20, 30}
, 
abilityValue = {11.96, 19.93}
, initMagnify = 10, 
randomAbility = {11}
, equipSuitid = 0}
, 
[46004] = {id = 46004, nameTextID = 1800348, rarity = 3, icon = 10708, isShow = 1, itemType = 299, equipNumber = "P-38", destribeTextID = 1800628, 
abilityID = {20, 30}
, 
abilityValue = {12.31, 20.52}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 0}
, 
[46005] = {id = 46005, nameTextID = 1800349, rarity = 3, icon = 11274, isShow = 0, itemType = 299, equipNumber = "N-12", destribeTextID = 1800629, 
abilityID = {20, 30}
, 
abilityValue = {12.62, 21.03}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 0}
, 
[46006] = {id = 46006, nameTextID = 1800350, rarity = 5, icon = 11275, isShow = 1, itemType = 299, equipNumber = "P-39", destribeTextID = 1800630, 
abilityID = {20, 30}
, 
abilityValue = {13.28, 21.6}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[46007] = {id = 46007, nameTextID = 1800351, rarity = 5, icon = 11276, isShow = 1, itemType = 299, equipNumber = "P-40", destribeTextID = 1800631, 
abilityID = {20, 30}
, 
abilityValue = {12.96, 22.14}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[46008] = {id = 46008, nameTextID = 1800352, rarity = 5, icon = 11277, isShow = 1, itemType = 299, equipNumber = "P-41", destribeTextID = 1800632, 
abilityID = {20, 30}
, 
abilityValue = {14.26, 22.68}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 8}
, 
[46009] = {id = 46009, nameTextID = 1800353, rarity = 5, icon = 11278, isShow = 1, itemType = 299, equipNumber = "P-42", destribeTextID = 1800633, 
abilityID = {20, 30}
, 
abilityValue = {13.61, 23.76}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 11}
, 
[46201] = {id = 46201, nameTextID = 1800354, rarity = 1, icon = 10520, isShow = 1, itemType = 299, equipNumber = "M-01", destribeTextID = 1800634, 
abilityID = {20, 30}
, 
abilityValue = {45.9, 7.71}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[46202] = {id = 46202, nameTextID = 1800355, rarity = 2, icon = 10669, isShow = 1, itemType = 299, equipNumber = "M-02", destribeTextID = 1800635, 
abilityID = {20, 30}
, 
abilityValue = {48.6, 8.16}
, initMagnify = 10, 
randomAbility = {81}
, equipSuitid = 0}
, 
[46203] = {id = 46203, nameTextID = 1800356, rarity = 2, icon = 10519, isShow = 0, itemType = 299, equipNumber = "N-13", destribeTextID = 1800636, 
abilityID = {20, 30}
, 
abilityValue = {49.82, 8.37}
, initMagnify = 10, 
randomAbility = {81}
, equipSuitid = 0}
, 
[46204] = {id = 46204, nameTextID = 1800357, rarity = 3, icon = 10518, isShow = 1, itemType = 299, equipNumber = "M-03", destribeTextID = 1800637, 
abilityID = {20, 30}
, 
abilityValue = {51.3, 8.62}
, initMagnify = 10, 
randomAbility = {82}
, equipSuitid = 0}
, 
[46205] = {id = 46205, nameTextID = 1800358, rarity = 3, icon = 11304, isShow = 0, itemType = 299, equipNumber = "N-14", destribeTextID = 1800638, 
abilityID = {20, 30}
, 
abilityValue = {52.58, 8.83}
, initMagnify = 10, 
randomAbility = {82}
, equipSuitid = 0}
, 
[46206] = {id = 46206, nameTextID = 1800359, rarity = 5, icon = 11305, isShow = 1, itemType = 299, equipNumber = "M-04", destribeTextID = 1800639, 
abilityID = {20, 30}
, 
abilityValue = {55.35, 9.07}
, initMagnify = 10, 
randomAbility = {83, 83}
, equipSuitid = 0}
, 
[46207] = {id = 46207, nameTextID = 1800360, rarity = 5, icon = 11306, isShow = 1, itemType = 299, equipNumber = "M-05", destribeTextID = 1800640, 
abilityID = {20, 30}
, 
abilityValue = {54, 9.3}
, initMagnify = 10, 
randomAbility = {83, 83}
, equipSuitid = 0}
, 
[46208] = {id = 46208, nameTextID = 1800361, rarity = 5, icon = 11307, isShow = 1, itemType = 299, equipNumber = "M-06", destribeTextID = 1800641, 
abilityID = {20, 30}
, 
abilityValue = {59.4, 9.53}
, initMagnify = 10, 
randomAbility = {83, 83}
, equipSuitid = 8}
, 
[46209] = {id = 46209, nameTextID = 1800362, rarity = 5, icon = 11308, isShow = 1, itemType = 299, equipNumber = "M-07", destribeTextID = 1800642, 
abilityID = {20, 30}
, 
abilityValue = {56.7, 9.98}
, initMagnify = 10, 
randomAbility = {83, 83}
, equipSuitid = 11}
, 
[46401] = {id = 46401, nameTextID = 1800363, rarity = 1, icon = 10681, isShow = 1, itemType = 299, equipNumber = "M-08", destribeTextID = 1800643, 
abilityID = {20, 30}
, 
abilityValue = {27.54, 11.02}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[46402] = {id = 46402, nameTextID = 1800364, rarity = 2, icon = 10682, isShow = 1, itemType = 299, equipNumber = "M-09", destribeTextID = 1800644, 
abilityID = {20, 30}
, 
abilityValue = {29.16, 11.66}
, initMagnify = 10, 
randomAbility = {81}
, equipSuitid = 0}
, 
[46403] = {id = 46403, nameTextID = 1800365, rarity = 2, icon = 10683, isShow = 0, itemType = 299, equipNumber = "N-15", destribeTextID = 1800645, 
abilityID = {20, 30}
, 
abilityValue = {29.89, 11.96}
, initMagnify = 10, 
randomAbility = {81}
, equipSuitid = 0}
, 
[46404] = {id = 46404, nameTextID = 1800366, rarity = 3, icon = 10684, isShow = 1, itemType = 299, equipNumber = "M-10", destribeTextID = 1800646, 
abilityID = {20, 30}
, 
abilityValue = {30.78, 12.31}
, initMagnify = 10, 
randomAbility = {82}
, equipSuitid = 0}
, 
[46405] = {id = 46405, nameTextID = 1800367, rarity = 3, icon = 11309, isShow = 0, itemType = 299, equipNumber = "N-16", destribeTextID = 1800647, 
abilityID = {20, 30}
, 
abilityValue = {31.55, 12.62}
, initMagnify = 10, 
randomAbility = {82}
, equipSuitid = 0}
, 
[46406] = {id = 46406, nameTextID = 1800368, rarity = 5, icon = 11310, isShow = 1, itemType = 299, equipNumber = "M-11", destribeTextID = 1800648, 
abilityID = {20, 30}
, 
abilityValue = {33.21, 12.96}
, initMagnify = 10, 
randomAbility = {83, 83}
, equipSuitid = 0}
, 
[46407] = {id = 46407, nameTextID = 1800369, rarity = 5, icon = 11311, isShow = 1, itemType = 299, equipNumber = "M-12", destribeTextID = 1800649, 
abilityID = {20, 30}
, 
abilityValue = {32.4, 13.28}
, initMagnify = 10, 
randomAbility = {83, 83}
, equipSuitid = 0}
, 
[46408] = {id = 46408, nameTextID = 1800370, rarity = 5, icon = 11312, isShow = 1, itemType = 299, equipNumber = "M-13", destribeTextID = 1800650, 
abilityID = {20, 30}
, 
abilityValue = {35.64, 13.61}
, initMagnify = 10, 
randomAbility = {83, 83}
, equipSuitid = 8}
, 
[46409] = {id = 46409, nameTextID = 1800371, rarity = 5, icon = 11313, isShow = 1, itemType = 299, equipNumber = "M-14", destribeTextID = 1800651, 
abilityID = {20, 30}
, 
abilityValue = {34.02, 14.26}
, initMagnify = 10, 
randomAbility = {83, 83}
, equipSuitid = 11}
, 
[46601] = {id = 46601, nameTextID = 1800372, rarity = 1, icon = 10529, isShow = 1, itemType = 299, equipNumber = "M-15", destribeTextID = 1800652, 
abilityID = {20, 30}
, 
abilityValue = {45.9, 7.71}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[46602] = {id = 46602, nameTextID = 1800373, rarity = 2, icon = 10530, isShow = 1, itemType = 299, equipNumber = "M-16", destribeTextID = 1800653, 
abilityID = {20, 30}
, 
abilityValue = {48.6, 8.16}
, initMagnify = 10, 
randomAbility = {21}
, equipSuitid = 0}
, 
[46603] = {id = 46603, nameTextID = 1800374, rarity = 2, icon = 10703, isShow = 0, itemType = 299, equipNumber = "N-17", destribeTextID = 1800654, 
abilityID = {20, 30}
, 
abilityValue = {49.82, 8.37}
, initMagnify = 10, 
randomAbility = {21}
, equipSuitid = 0}
, 
[46604] = {id = 46604, nameTextID = 1800375, rarity = 3, icon = 10531, isShow = 1, itemType = 299, equipNumber = "M-17", destribeTextID = 1800655, 
abilityID = {20, 30}
, 
abilityValue = {51.3, 8.62}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 0}
, 
[46605] = {id = 46605, nameTextID = 1800376, rarity = 3, icon = 11244, isShow = 0, itemType = 299, equipNumber = "N-18", destribeTextID = 1800656, 
abilityID = {20, 30}
, 
abilityValue = {52.58, 8.83}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 0}
, 
[46606] = {id = 46606, nameTextID = 1800377, rarity = 5, icon = 11245, isShow = 1, itemType = 299, equipNumber = "M-18", destribeTextID = 1800657, 
abilityID = {20, 30}
, 
abilityValue = {55.35, 9.07}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 0}
, 
[46607] = {id = 46607, nameTextID = 1800378, rarity = 5, icon = 11246, isShow = 1, itemType = 299, equipNumber = "M-19", destribeTextID = 1800658, 
abilityID = {20, 30}
, 
abilityValue = {54, 9.3}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 0}
, 
[46608] = {id = 46608, nameTextID = 1800379, rarity = 5, icon = 11247, isShow = 1, itemType = 299, equipNumber = "M-20", destribeTextID = 1800659, 
abilityID = {20, 30}
, 
abilityValue = {59.4, 9.53}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 8}
, 
[46609] = {id = 46609, nameTextID = 1800380, rarity = 5, icon = 11248, isShow = 1, itemType = 299, equipNumber = "M-21", destribeTextID = 1800660, 
abilityID = {20, 30}
, 
abilityValue = {56.7, 9.98}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 11}
, 
[46801] = {id = 46801, nameTextID = 1800381, rarity = 1, icon = 10714, isShow = 1, itemType = 299, equipNumber = "M-22", destribeTextID = 1800661, 
abilityID = {20, 30}
, 
abilityValue = {22.95, 11.02}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[46802] = {id = 46802, nameTextID = 1800382, rarity = 2, icon = 10715, isShow = 1, itemType = 299, equipNumber = "M-23", destribeTextID = 1800662, 
abilityID = {20, 30}
, 
abilityValue = {24.3, 11.66}
, initMagnify = 10, 
randomAbility = {21}
, equipSuitid = 0}
, 
[46803] = {id = 46803, nameTextID = 1800383, rarity = 2, icon = 10727, isShow = 0, itemType = 299, equipNumber = "N-19", destribeTextID = 1800663, 
abilityID = {20, 30}
, 
abilityValue = {24.91, 11.96}
, initMagnify = 10, 
randomAbility = {21}
, equipSuitid = 0}
, 
[46804] = {id = 46804, nameTextID = 1800384, rarity = 3, icon = 10728, isShow = 1, itemType = 299, equipNumber = "M-24", destribeTextID = 1800664, 
abilityID = {20, 30}
, 
abilityValue = {25.65, 12.31}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 0}
, 
[46805] = {id = 46805, nameTextID = 1800385, rarity = 3, icon = 11299, isShow = 0, itemType = 299, equipNumber = "N-20", destribeTextID = 1800665, 
abilityID = {20, 30}
, 
abilityValue = {26.29, 12.62}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 0}
, 
[46806] = {id = 46806, nameTextID = 1800386, rarity = 5, icon = 11300, isShow = 1, itemType = 299, equipNumber = "M-25", destribeTextID = 1800666, 
abilityID = {20, 30}
, 
abilityValue = {27.68, 12.96}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 0}
, 
[46807] = {id = 46807, nameTextID = 1800387, rarity = 5, icon = 11301, isShow = 1, itemType = 299, equipNumber = "M-26", destribeTextID = 1800667, 
abilityID = {20, 30}
, 
abilityValue = {27, 13.28}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 0}
, 
[46808] = {id = 46808, nameTextID = 1800388, rarity = 5, icon = 11302, isShow = 1, itemType = 299, equipNumber = "M-27", destribeTextID = 1800668, 
abilityID = {20, 30}
, 
abilityValue = {29.7, 13.61}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 8}
, 
[46809] = {id = 46809, nameTextID = 1800389, rarity = 5, icon = 11303, isShow = 1, itemType = 299, equipNumber = "M-28", destribeTextID = 1800669, 
abilityID = {20, 30}
, 
abilityValue = {28.35, 14.26}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 11}
, 
[47001] = {id = 47001, nameTextID = 1800390, rarity = 1, icon = 10521, isShow = 1, itemType = 299, equipNumber = "M-29", destribeTextID = 1800670, 
abilityID = {20, 30}
, 
abilityValue = {45.9, 11.57}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[47002] = {id = 47002, nameTextID = 1800391, rarity = 2, icon = 10539, isShow = 1, itemType = 299, equipNumber = "M-30", destribeTextID = 1800671, 
abilityID = {20, 30}
, 
abilityValue = {48.6, 12.25}
, initMagnify = 10, 
randomAbility = {21}
, equipSuitid = 0}
, 
[47003] = {id = 47003, nameTextID = 1800392, rarity = 2, icon = 10671, isShow = 0, itemType = 299, equipNumber = "N-21", destribeTextID = 1800672, 
abilityID = {20, 30}
, 
abilityValue = {49.82, 12.55}
, initMagnify = 10, 
randomAbility = {21}
, equipSuitid = 0}
, 
[47004] = {id = 47004, nameTextID = 1800393, rarity = 3, icon = 10672, isShow = 1, itemType = 299, equipNumber = "M-31", destribeTextID = 1800673, 
abilityID = {20, 30}
, 
abilityValue = {51.3, 12.93}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 0}
, 
[47005] = {id = 47005, nameTextID = 1800394, rarity = 3, icon = 11264, isShow = 0, itemType = 299, equipNumber = "N-22", destribeTextID = 1800674, 
abilityID = {20, 30}
, 
abilityValue = {52.58, 13.25}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 0}
, 
[47006] = {id = 47006, nameTextID = 1800395, rarity = 5, icon = 11265, isShow = 1, itemType = 299, equipNumber = "M-32", destribeTextID = 1800675, 
abilityID = {20, 30}
, 
abilityValue = {55.35, 13.61}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 0}
, 
[47007] = {id = 47007, nameTextID = 1800396, rarity = 5, icon = 11266, isShow = 1, itemType = 299, equipNumber = "M-33", destribeTextID = 1800676, 
abilityID = {20, 30}
, 
abilityValue = {54, 13.95}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 0}
, 
[47008] = {id = 47008, nameTextID = 1800397, rarity = 5, icon = 11267, isShow = 1, itemType = 299, equipNumber = "M-34", destribeTextID = 1800677, 
abilityID = {20, 30}
, 
abilityValue = {59.4, 14.29}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 8}
, 
[47009] = {id = 47009, nameTextID = 1800398, rarity = 5, icon = 11268, isShow = 1, itemType = 299, equipNumber = "M-35", destribeTextID = 1800678, 
abilityID = {20, 30}
, 
abilityValue = {56.7, 14.97}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 11}
, 
[47201] = {id = 47201, nameTextID = 1800399, rarity = 1, icon = 10717, isShow = 1, itemType = 299, equipNumber = "M-36", destribeTextID = 1800679, 
abilityID = {20, 30}
, 
abilityValue = {22.95, 16.52}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[47202] = {id = 47202, nameTextID = 1800400, rarity = 2, icon = 10718, isShow = 1, itemType = 299, equipNumber = "M-37", destribeTextID = 1800680, 
abilityID = {20, 30}
, 
abilityValue = {24.3, 17.5}
, initMagnify = 10, 
randomAbility = {21}
, equipSuitid = 0}
, 
[47203] = {id = 47203, nameTextID = 1800401, rarity = 2, icon = 10719, isShow = 0, itemType = 299, equipNumber = "N-23", destribeTextID = 1800681, 
abilityID = {20, 30}
, 
abilityValue = {24.91, 17.93}
, initMagnify = 10, 
randomAbility = {21}
, equipSuitid = 0}
, 
[47204] = {id = 47204, nameTextID = 1800402, rarity = 3, icon = 10720, isShow = 1, itemType = 299, equipNumber = "M-38", destribeTextID = 1800682, 
abilityID = {20, 30}
, 
abilityValue = {25.65, 18.47}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 0}
, 
[47205] = {id = 47205, nameTextID = 1800403, rarity = 3, icon = 11294, isShow = 0, itemType = 299, equipNumber = "N-24", destribeTextID = 1800683, 
abilityID = {20, 30}
, 
abilityValue = {26.29, 18.93}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 0}
, 
[47206] = {id = 47206, nameTextID = 1800404, rarity = 5, icon = 11295, isShow = 1, itemType = 299, equipNumber = "M-39", destribeTextID = 1800684, 
abilityID = {20, 30}
, 
abilityValue = {27.68, 19.44}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 0}
, 
[47207] = {id = 47207, nameTextID = 1800405, rarity = 5, icon = 11296, isShow = 1, itemType = 299, equipNumber = "M-40", destribeTextID = 1800685, 
abilityID = {20, 30}
, 
abilityValue = {27, 19.93}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 0}
, 
[47208] = {id = 47208, nameTextID = 1800406, rarity = 5, icon = 11297, isShow = 1, itemType = 299, equipNumber = "M-41", destribeTextID = 1800686, 
abilityID = {20, 30}
, 
abilityValue = {29.7, 20.41}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 8}
, 
[47209] = {id = 47209, nameTextID = 1800407, rarity = 5, icon = 11298, isShow = 1, itemType = 299, equipNumber = "M-42", destribeTextID = 1800687, 
abilityID = {20, 30}
, 
abilityValue = {28.35, 21.38}
, initMagnify = 10, 
randomAbility = {23, 23}
, equipSuitid = 11}
, 
[47401] = {id = 47401, nameTextID = 1800408, rarity = 1, icon = 10527, isShow = 1, itemType = 811, equipNumber = "S-01", destribeTextID = 1800688, 
abilityID = {20, 50}
, 
abilityValue = {55.08, 7.34}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[47402] = {id = 47402, nameTextID = 1800409, rarity = 2, icon = 10721, isShow = 1, itemType = 811, equipNumber = "S-02", destribeTextID = 1800689, 
abilityID = {20, 50}
, 
abilityValue = {58.32, 7.78}
, initMagnify = 10, 
randomAbility = {31}
, equipSuitid = 0}
, 
[47403] = {id = 47403, nameTextID = 1800410, rarity = 2, icon = 10526, isShow = 1, itemType = 811, equipNumber = "S-03", destribeTextID = 1800690, 
abilityID = {20, 50}
, 
abilityValue = {59.78, 7.97}
, initMagnify = 10, 
randomAbility = {31}
, equipSuitid = 3}
, 
[47404] = {id = 47404, nameTextID = 1800411, rarity = 3, icon = 11289, isShow = 1, itemType = 811, equipNumber = "S-04", destribeTextID = 1800691, 
abilityID = {20, 50}
, 
abilityValue = {61.56, 8.21}
, initMagnify = 10, 
randomAbility = {32}
, equipSuitid = 0}
, 
[47405] = {id = 47405, nameTextID = 1800412, rarity = 3, icon = 11292, isShow = 0, itemType = 811, equipNumber = "N-25", destribeTextID = 1800692, 
abilityID = {20, 50}
, 
abilityValue = {63.1, 8.41}
, initMagnify = 10, 
randomAbility = {32}
, equipSuitid = 0}
, 
[47406] = {id = 47406, nameTextID = 1800413, rarity = 5, icon = 11290, isShow = 1, itemType = 811, equipNumber = "S-05", destribeTextID = 1800693, 
abilityID = {20, 50}
, 
abilityValue = {66.42, 8.64}
, initMagnify = 10, 
randomAbility = {33, 33}
, equipSuitid = 0}
, 
[47407] = {id = 47407, nameTextID = 1800414, rarity = 5, icon = 11291, isShow = 1, itemType = 811, equipNumber = "S-06", destribeTextID = 1800694, 
abilityID = {20, 50}
, 
abilityValue = {64.8, 8.86}
, initMagnify = 10, 
randomAbility = {33, 33}
, equipSuitid = 0}
, 
[47408] = {id = 47408, nameTextID = 1800415, rarity = 5, icon = 10525, isShow = 1, itemType = 811, equipNumber = "S-07", destribeTextID = 1800695, 
abilityID = {20, 50}
, 
abilityValue = {71.28, 9.07}
, initMagnify = 10, 
randomAbility = {33, 33}
, equipSuitid = 9}
, 
[47409] = {id = 47409, nameTextID = 1800416, rarity = 5, icon = 11293, isShow = 1, itemType = 811, equipNumber = "S-08", destribeTextID = 1800696, 
abilityID = {20, 50}
, 
abilityValue = {68.04, 9.5}
, initMagnify = 10, 
randomAbility = {33, 33}
, equipSuitid = 12}
, 
[47601] = {id = 47601, nameTextID = 1800417, rarity = 1, icon = 11235, isShow = 1, itemType = 811, equipNumber = "S-09", destribeTextID = 1800697, 
abilityID = {20, 60}
, 
abilityValue = {55.08, 7.34}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[47602] = {id = 47602, nameTextID = 1800418, rarity = 2, icon = 11236, isShow = 1, itemType = 811, equipNumber = "S-10", destribeTextID = 1800698, 
abilityID = {20, 60}
, 
abilityValue = {58.32, 7.78}
, initMagnify = 10, 
randomAbility = {41}
, equipSuitid = 0}
, 
[47603] = {id = 47603, nameTextID = 1800419, rarity = 2, icon = 11237, isShow = 1, itemType = 811, equipNumber = "S-11", destribeTextID = 1800699, 
abilityID = {20, 60}
, 
abilityValue = {59.78, 7.97}
, initMagnify = 10, 
randomAbility = {41}
, equipSuitid = 3}
, 
[47604] = {id = 47604, nameTextID = 1800420, rarity = 3, icon = 11238, isShow = 1, itemType = 811, equipNumber = "S-12", destribeTextID = 1800700, 
abilityID = {20, 60}
, 
abilityValue = {61.56, 8.21}
, initMagnify = 10, 
randomAbility = {42}
, equipSuitid = 0}
, 
[47605] = {id = 47605, nameTextID = 1800421, rarity = 3, icon = 11239, isShow = 0, itemType = 811, equipNumber = "N-26", destribeTextID = 1800701, 
abilityID = {20, 60}
, 
abilityValue = {63.1, 8.41}
, initMagnify = 10, 
randomAbility = {42}
, equipSuitid = 0}
, 
[47606] = {id = 47606, nameTextID = 1800422, rarity = 5, icon = 11240, isShow = 1, itemType = 811, equipNumber = "S-13", destribeTextID = 1800702, 
abilityID = {20, 60}
, 
abilityValue = {66.42, 8.64}
, initMagnify = 10, 
randomAbility = {43, 43}
, equipSuitid = 0}
, 
[47607] = {id = 47607, nameTextID = 1800423, rarity = 5, icon = 11241, isShow = 1, itemType = 811, equipNumber = "S-14", destribeTextID = 1800703, 
abilityID = {20, 60}
, 
abilityValue = {64.8, 8.86}
, initMagnify = 10, 
randomAbility = {43, 43}
, equipSuitid = 0}
, 
[47608] = {id = 47608, nameTextID = 1800424, rarity = 5, icon = 11242, isShow = 1, itemType = 811, equipNumber = "S-15", destribeTextID = 1800704, 
abilityID = {20, 60}
, 
abilityValue = {71.28, 9.07}
, initMagnify = 10, 
randomAbility = {43, 43}
, equipSuitid = 9}
, 
[47609] = {id = 47609, nameTextID = 1800425, rarity = 5, icon = 11243, isShow = 1, itemType = 811, equipNumber = "S-16", destribeTextID = 1800705, 
abilityID = {20, 60}
, 
abilityValue = {68.04, 9.5}
, initMagnify = 10, 
randomAbility = {43, 43}
, equipSuitid = 12}
, 
[47801] = {id = 47801, nameTextID = 1800426, rarity = 1, icon = 10698, isShow = 1, itemType = 555, equipNumber = "A-01", destribeTextID = 1800706, 
abilityID = {30, 50}
, 
abilityValue = {12.24, 4.9}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[47802] = {id = 47802, nameTextID = 1800427, rarity = 2, icon = 10702, isShow = 1, itemType = 555, equipNumber = "A-02", destribeTextID = 1800707, 
abilityID = {30, 50}
, 
abilityValue = {12.96, 5.18}
, initMagnify = 10, 
randomAbility = {51}
, equipSuitid = 0}
, 
[47803] = {id = 47803, nameTextID = 1800428, rarity = 2, icon = 10699, isShow = 1, itemType = 555, equipNumber = "A-03", destribeTextID = 1800708, 
abilityID = {30, 60}
, 
abilityValue = {12.96, 5.18}
, initMagnify = 10, 
randomAbility = {51}
, equipSuitid = 1}
, 
[47804] = {id = 47804, nameTextID = 1800429, rarity = 3, icon = 10700, isShow = 1, itemType = 555, equipNumber = "A-04", destribeTextID = 1800709, 
abilityID = {30, 50}
, 
abilityValue = {13.68, 5.47}
, initMagnify = 10, 
randomAbility = {52}
, equipSuitid = 0}
, 
[47805] = {id = 47805, nameTextID = 1800430, rarity = 3, icon = 11284, isShow = 0, itemType = 555, equipNumber = "N-27", destribeTextID = 1800710, 
abilityID = {30, 60}
, 
abilityValue = {13.68, 5.47}
, initMagnify = 10, 
randomAbility = {52}
, equipSuitid = 0}
, 
[47806] = {id = 47806, nameTextID = 1800431, rarity = 5, icon = 11285, isShow = 1, itemType = 555, equipNumber = "A-05", destribeTextID = 1800711, 
abilityID = {30, 50}
, 
abilityValue = {14.4, 5.76}
, initMagnify = 10, 
randomAbility = {53, 53}
, equipSuitid = 0}
, 
[47807] = {id = 47807, nameTextID = 1800432, rarity = 5, icon = 11286, isShow = 1, itemType = 555, equipNumber = "A-06", destribeTextID = 1800712, 
abilityID = {30, 60}
, 
abilityValue = {14.4, 5.76}
, initMagnify = 10, 
randomAbility = {53, 53}
, equipSuitid = 0}
, 
[47808] = {id = 47808, nameTextID = 1800433, rarity = 5, icon = 11287, isShow = 1, itemType = 555, equipNumber = "A-07", destribeTextID = 1800713, 
abilityID = {30, 50}
, 
abilityValue = {15.84, 6.05}
, initMagnify = 10, 
randomAbility = {53, 53}
, equipSuitid = 10}
, 
[47809] = {id = 47809, nameTextID = 1800434, rarity = 5, icon = 11288, isShow = 1, itemType = 555, equipNumber = "A-08", destribeTextID = 1800714, 
abilityID = {30, 60}
, 
abilityValue = {15.84, 6.05}
, initMagnify = 10, 
randomAbility = {53, 53}
, equipSuitid = 13}
, 
[48001] = {id = 48001, nameTextID = 1800435, rarity = 1, icon = 10722, isShow = 1, itemType = 555, equipNumber = "A-09", destribeTextID = 1800715, 
abilityID = {20, 50}
, 
abilityValue = {36.72, 4.9}
, initMagnify = 10, 
randomAbility = {}
, equipSuitid = 0}
, 
[48002] = {id = 48002, nameTextID = 1800436, rarity = 2, icon = 10723, isShow = 1, itemType = 555, equipNumber = "A-10", destribeTextID = 1800716, 
abilityID = {20, 50}
, 
abilityValue = {38.88, 5.18}
, initMagnify = 10, 
randomAbility = {61}
, equipSuitid = 0}
, 
[48003] = {id = 48003, nameTextID = 1800437, rarity = 2, icon = 10724, isShow = 1, itemType = 555, equipNumber = "A-11", destribeTextID = 1800717, 
abilityID = {20, 60}
, 
abilityValue = {38.88, 5.18}
, initMagnify = 10, 
randomAbility = {61}
, equipSuitid = 2}
, 
[48004] = {id = 48004, nameTextID = 1800438, rarity = 3, icon = 10725, isShow = 1, itemType = 555, equipNumber = "A-12", destribeTextID = 1800718, 
abilityID = {20, 50}
, 
abilityValue = {41.04, 5.47}
, initMagnify = 10, 
randomAbility = {62}
, equipSuitid = 0}
, 
[48005] = {id = 48005, nameTextID = 1800439, rarity = 3, icon = 11314, isShow = 0, itemType = 555, equipNumber = "N-28", destribeTextID = 1800719, 
abilityID = {20, 60}
, 
abilityValue = {41.04, 5.47}
, initMagnify = 10, 
randomAbility = {62}
, equipSuitid = 0}
, 
[48006] = {id = 48006, nameTextID = 1800440, rarity = 5, icon = 11315, isShow = 1, itemType = 555, equipNumber = "A-13", destribeTextID = 1800720, 
abilityID = {20, 50}
, 
abilityValue = {43.2, 5.76}
, initMagnify = 10, 
randomAbility = {63, 63}
, equipSuitid = 0}
, 
[48007] = {id = 48007, nameTextID = 1800441, rarity = 5, icon = 11316, isShow = 1, itemType = 555, equipNumber = "A-14", destribeTextID = 1800721, 
abilityID = {20, 60}
, 
abilityValue = {43.2, 5.76}
, initMagnify = 10, 
randomAbility = {63, 63}
, equipSuitid = 0}
, 
[48008] = {id = 48008, nameTextID = 1800442, rarity = 5, icon = 11317, isShow = 1, itemType = 555, equipNumber = "A-15", destribeTextID = 1800722, 
abilityID = {20, 50}
, 
abilityValue = {47.52, 6.05}
, initMagnify = 10, 
randomAbility = {63, 63}
, equipSuitid = 10}
, 
[48009] = {id = 48009, nameTextID = 1800443, rarity = 5, icon = 11318, isShow = 1, itemType = 555, equipNumber = "A-16", destribeTextID = 1800723, 
abilityID = {20, 60}
, 
abilityValue = {47.52, 6.05}
, initMagnify = 10, 
randomAbility = {63, 63}
, equipSuitid = 13}
, 
[48101] = {id = 48101, nameTextID = 1802329, rarity = 3, icon = 12975, isShow = 1, itemType = 299, equipNumber = "P-43", destribeTextID = 1802361, 
abilityID = {20, 30}
, 
abilityValue = {49.14, 6.46}
, initMagnify = 10, 
randomAbility = {72}
, equipSuitid = 4}
, 
[48102] = {id = 48102, nameTextID = 1802330, rarity = 3, icon = 12977, isShow = 1, itemType = 299, equipNumber = "P-44", destribeTextID = 1802362, 
abilityID = {20, 30}
, 
abilityValue = {24.57, 13.72}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 4}
, 
[48103] = {id = 48103, nameTextID = 1802331, rarity = 3, icon = 12978, isShow = 1, itemType = 299, equipNumber = "P-45", destribeTextID = 1802363, 
abilityID = {20, 30}
, 
abilityValue = {28.08, 11.3}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 4}
, 
[48104] = {id = 48104, nameTextID = 1802332, rarity = 3, icon = 12980, isShow = 1, itemType = 299, equipNumber = "M-43", destribeTextID = 1802364, 
abilityID = {20, 30}
, 
abilityValue = {35.1, 6.78}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 4}
, 
[48105] = {id = 48105, nameTextID = 1802333, rarity = 3, icon = 12974, isShow = 1, itemType = 299, equipNumber = "M-44", destribeTextID = 1802365, 
abilityID = {20, 30}
, 
abilityValue = {35.1, 6.78}
, initMagnify = 10, 
randomAbility = {82}
, equipSuitid = 4}
, 
[48106] = {id = 48106, nameTextID = 1802334, rarity = 3, icon = 12976, isShow = 1, itemType = 299, equipNumber = "M-45", destribeTextID = 1802366, 
abilityID = {20, 30}
, 
abilityValue = {17.55, 14.53}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 4}
, 
[48107] = {id = 48107, nameTextID = 1802335, rarity = 3, icon = 12979, isShow = 1, itemType = 811, equipNumber = "S-17", destribeTextID = 1802367, 
abilityID = {20, 50}
, 
abilityValue = {48.44, 5.62}
, initMagnify = 10, 
randomAbility = {32}
, equipSuitid = 4}
, 
[48108] = {id = 48108, nameTextID = 1802336, rarity = 3, icon = 12973, isShow = 1, itemType = 555, equipNumber = "A-17", destribeTextID = 1802368, 
abilityID = {30, 50}
, 
abilityValue = {10.76, 3.74}
, initMagnify = 10, 
randomAbility = {52}
, equipSuitid = 4}
, 
[48201] = {id = 48201, nameTextID = 1802337, rarity = 3, icon = 12931, isShow = 1, itemType = 299, equipNumber = "P-46", destribeTextID = 1802369, 
abilityID = {20, 30}
, 
abilityValue = {80.73, 3.37}
, initMagnify = 10, 
randomAbility = {72}
, equipSuitid = 5}
, 
[48202] = {id = 48202, nameTextID = 1802338, rarity = 3, icon = 12930, isShow = 1, itemType = 299, equipNumber = "P-47", destribeTextID = 1802370, 
abilityID = {20, 30}
, 
abilityValue = {56.51, 8.35}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 5}
, 
[48203] = {id = 48203, nameTextID = 1802339, rarity = 3, icon = 12933, isShow = 1, itemType = 299, equipNumber = "P-48", destribeTextID = 1802371, 
abilityID = {20, 30}
, 
abilityValue = {9.69, 14.04}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 5}
, 
[48204] = {id = 48204, nameTextID = 1802340, rarity = 3, icon = 12935, isShow = 1, itemType = 299, equipNumber = "M-46", destribeTextID = 1802372, 
abilityID = {20, 30}
, 
abilityValue = {24.22, 8.42}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 5}
, 
[48205] = {id = 48205, nameTextID = 1802341, rarity = 3, icon = 12936, isShow = 1, itemType = 299, equipNumber = "M-47", destribeTextID = 1802373, 
abilityID = {20, 30}
, 
abilityValue = {20.18, 8.42}
, initMagnify = 10, 
randomAbility = {82}
, equipSuitid = 5}
, 
[48206] = {id = 48206, nameTextID = 1802342, rarity = 3, icon = 12932, isShow = 1, itemType = 299, equipNumber = "M-48", destribeTextID = 1802374, 
abilityID = {20, 30}
, 
abilityValue = {40.37, 8.85}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 5}
, 
[48207] = {id = 48207, nameTextID = 1802343, rarity = 3, icon = 12929, isShow = 1, itemType = 811, equipNumber = "S-18", destribeTextID = 1802375, 
abilityID = {20, 60}
, 
abilityValue = {48.44, 5.62}
, initMagnify = 10, 
randomAbility = {42}
, equipSuitid = 5}
, 
[48208] = {id = 48208, nameTextID = 1802344, rarity = 3, icon = 12934, isShow = 1, itemType = 555, equipNumber = "A-18", destribeTextID = 1802376, 
abilityID = {30, 60}
, 
abilityValue = {10.3, 3.93}
, initMagnify = 10, 
randomAbility = {52}
, equipSuitid = 5}
, 
[48301] = {id = 48301, nameTextID = 1802345, rarity = 3, icon = 12858, isShow = 1, itemType = 299, equipNumber = "P-49", destribeTextID = 1802377, 
abilityID = {20, 30}
, 
abilityValue = {77.22, 3.54}
, initMagnify = 10, 
randomAbility = {72}
, equipSuitid = 6}
, 
[48302] = {id = 48302, nameTextID = 1802346, rarity = 3, icon = 12857, isShow = 1, itemType = 299, equipNumber = "P-50", destribeTextID = 1802378, 
abilityID = {20, 30}
, 
abilityValue = {54.05, 8.77}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 6}
, 
[48303] = {id = 48303, nameTextID = 1802347, rarity = 3, icon = 12860, isShow = 1, itemType = 299, equipNumber = "P-51", destribeTextID = 1802379, 
abilityID = {20, 30}
, 
abilityValue = {9.27, 14.74}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 6}
, 
[48304] = {id = 48304, nameTextID = 1802348, rarity = 3, icon = 12862, isShow = 1, itemType = 299, equipNumber = "M-49", destribeTextID = 1802380, 
abilityID = {20, 30}
, 
abilityValue = {23.17, 8.85}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 6}
, 
[48305] = {id = 48305, nameTextID = 1802349, rarity = 3, icon = 12863, isShow = 1, itemType = 299, equipNumber = "M-50", destribeTextID = 1802381, 
abilityID = {20, 30}
, 
abilityValue = {19.31, 8.85}
, initMagnify = 10, 
randomAbility = {82}
, equipSuitid = 6}
, 
[48306] = {id = 48306, nameTextID = 1802350, rarity = 3, icon = 12859, isShow = 1, itemType = 299, equipNumber = "M-51", destribeTextID = 1802382, 
abilityID = {20, 30}
, 
abilityValue = {38.61, 9.29}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 6}
, 
[48307] = {id = 48307, nameTextID = 1802351, rarity = 3, icon = 12861, isShow = 1, itemType = 811, equipNumber = "S-19", destribeTextID = 1802383, 
abilityID = {20, 50}
, 
abilityValue = {42.12, 6.46}
, initMagnify = 10, 
randomAbility = {32}
, equipSuitid = 6}
, 
[48308] = {id = 48308, nameTextID = 1802352, rarity = 3, icon = 12864, isShow = 1, itemType = 555, equipNumber = "A-19", destribeTextID = 1802384, 
abilityID = {20, 50}
, 
abilityValue = {28.08, 4.31}
, initMagnify = 10, 
randomAbility = {62}
, equipSuitid = 6}
, 
[48401] = {id = 48401, nameTextID = 1802353, rarity = 3, icon = 12851, isShow = 1, itemType = 299, equipNumber = "P-52", destribeTextID = 1802385, 
abilityID = {20, 30}
, 
abilityValue = {54.05, 5.9}
, initMagnify = 10, 
randomAbility = {72}
, equipSuitid = 7}
, 
[48402] = {id = 48402, nameTextID = 1802354, rarity = 3, icon = 12852, isShow = 1, itemType = 299, equipNumber = "P-53", destribeTextID = 1802386, 
abilityID = {20, 30}
, 
abilityValue = {27.03, 12.53}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 7}
, 
[48403] = {id = 48403, nameTextID = 1802355, rarity = 3, icon = 12850, isShow = 1, itemType = 299, equipNumber = "P-54", destribeTextID = 1802387, 
abilityID = {20, 30}
, 
abilityValue = {30.89, 10.32}
, initMagnify = 10, 
randomAbility = {12}
, equipSuitid = 7}
, 
[48404] = {id = 48404, nameTextID = 1802356, rarity = 3, icon = 12855, isShow = 1, itemType = 299, equipNumber = "M-52", destribeTextID = 1802388, 
abilityID = {20, 30}
, 
abilityValue = {38.61, 6.19}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 7}
, 
[48405] = {id = 48405, nameTextID = 1802357, rarity = 3, icon = 12849, isShow = 1, itemType = 299, equipNumber = "M-53", destribeTextID = 1802389, 
abilityID = {20, 30}
, 
abilityValue = {38.61, 6.19}
, initMagnify = 10, 
randomAbility = {82}
, equipSuitid = 7}
, 
[48406] = {id = 48406, nameTextID = 1802358, rarity = 3, icon = 12854, isShow = 1, itemType = 299, equipNumber = "M-54", destribeTextID = 1802390, 
abilityID = {20, 30}
, 
abilityValue = {19.31, 13.27}
, initMagnify = 10, 
randomAbility = {22}
, equipSuitid = 7}
, 
[48407] = {id = 48407, nameTextID = 1802359, rarity = 3, icon = 12853, isShow = 1, itemType = 811, equipNumber = "S-20", destribeTextID = 1802391, 
abilityID = {20, 60}
, 
abilityValue = {42.12, 6.46}
, initMagnify = 10, 
randomAbility = {42}
, equipSuitid = 7}
, 
[48508] = {id = 48508, nameTextID = 1802360, rarity = 3, icon = 12856, isShow = 1, itemType = 555, equipNumber = "A-20", destribeTextID = 1802392, 
abilityID = {20, 60}
, 
abilityValue = {28.08, 4.31}
, initMagnify = 10, 
randomAbility = {62}
, equipSuitid = 7}
, 
[49901] = {id = 49901, nameTextID = 1803141, rarity = 5, icon = 13840, isShow = 1, itemType = 299, equipNumber = "EX-1", destribeTextID = 1803143, 
abilityID = {20, 30}
, 
abilityValue = {82.03, 13.94}
, initMagnify = 10, 
randomAbility = {13, 13}
, equipSuitid = 0}
, 
[49902] = {id = 49902, nameTextID = 1803142, rarity = 3, icon = 13839, isShow = 1, itemType = 555, equipNumber = "EX-2", destribeTextID = 1803144, 
abilityID = {50, 60}
, 
abilityValue = {5.94, 5.94}
, initMagnify = 10, 
randomAbility = {62}
, equipSuitid = 0}
}
cequip_handbook.AllIds = {45001, 45002, 45003, 45004, 45005, 45006, 45007, 45008, 45009, 45201, 45202, 45203, 45204, 45205, 45206, 45207, 45208, 45209, 45401, 45402, 45403, 45404, 45405, 45406, 45407, 45408, 45409, 45601, 45602, 45603, 45604, 45605, 45606, 45607, 45608, 45609, 45801, 45802, 45803, 45804, 45805, 45806, 45807, 45808, 45809, 46001, 46002, 46003, 46004, 46005, 46006, 46007, 46008, 46009, 46201, 46202, 46203, 46204, 46205, 46206, 46207, 46208, 46209, 46401, 46402, 46403, 46404, 46405, 46406, 46407, 46408, 46409, 46601, 46602, 46603, 46604, 46605, 46606, 46607, 46608, 46609, 46801, 46802, 46803, 46804, 46805, 46806, 46807, 46808, 46809, 47001, 47002, 47003, 47004, 47005, 47006, 47007, 47008, 47009, 47201, 47202, 47203, 47204, 47205, 47206, 47207, 47208, 47209, 47401, 47402, 47403, 47404, 47405, 47406, 47407, 47408, 47409, 47601, 47602, 47603, 47604, 47605, 47606, 47607, 47608, 47609, 47801, 47802, 47803, 47804, 47805, 47806, 47807, 47808, 47809, 48001, 48002, 48003, 48004, 48005, 48006, 48007, 48008, 48009, 48101, 48102, 48103, 48104, 48105, 48106, 48107, 48108, 48201, 48202, 48203, 48204, 48205, 48206, 48207, 48208, 48301, 48302, 48303, 48304, 48305, 48306, 48307, 48308, 48401, 48402, 48403, 48404, 48405, 48406, 48407, 48508, 49901, 49902}
return cequip_handbook

