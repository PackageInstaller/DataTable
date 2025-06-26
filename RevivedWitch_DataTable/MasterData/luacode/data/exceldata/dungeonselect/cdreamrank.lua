-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cdreamrank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cdreamrank = {}
cdreamrank.Data = {
[1] = {id = 1, rankName = "青铜I", rankDown = 0, rankUp = 50, rankBigIcon = 16123, rankSmallIcon = 16123, 
item = {31723, 35008, 35011, 0}
, 
num = {1, 100, 5, 0}
, mail = 2716, 
battleDown = {1, 2, 3, 4}
, 
battleUp = {1, 2, 3, 4}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[2] = {id = 2, rankName = "青铜II", rankDown = 51, rankUp = 100, rankBigIcon = 16124, rankSmallIcon = 16124, 
item = {31723, 35008, 35011, 0}
, 
num = {1, 150, 10, 0}
, mail = 2717, 
battleDown = {1, 2, 3, 4}
, 
battleUp = {2, 3, 4, 5}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[3] = {id = 3, rankName = "青铜III", rankDown = 101, rankUp = 150, rankBigIcon = 16125, rankSmallIcon = 16125, 
item = {31723, 35008, 35011, 0}
, 
num = {1, 200, 15, 0}
, mail = 2718, 
battleDown = {2, 3, 4, 5}
, 
battleUp = {3, 4, 5, 6}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[4] = {id = 4, rankName = "白银I", rankDown = 151, rankUp = 200, rankBigIcon = 16126, rankSmallIcon = 16126, 
item = {31724, 35008, 35011, 0}
, 
num = {1, 250, 20, 0}
, mail = 2719, 
battleDown = {3, 4, 5, 6}
, 
battleUp = {4, 5, 6, 7}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[5] = {id = 5, rankName = "白银II", rankDown = 201, rankUp = 250, rankBigIcon = 16127, rankSmallIcon = 16127, 
item = {31724, 35008, 35011, 0}
, 
num = {1, 300, 25, 0}
, mail = 2720, 
battleDown = {4, 5, 6, 7}
, 
battleUp = {5, 6, 7, 8}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[6] = {id = 6, rankName = "白银III", rankDown = 251, rankUp = 300, rankBigIcon = 16128, rankSmallIcon = 16128, 
item = {31724, 35008, 35011, 0}
, 
num = {1, 350, 30, 0}
, mail = 2721, 
battleDown = {5, 6, 7, 8}
, 
battleUp = {6, 7, 8, 9}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[7] = {id = 7, rankName = "黄金I", rankDown = 301, rankUp = 350, rankBigIcon = 16129, rankSmallIcon = 16129, 
item = {31724, 35008, 35012, 0}
, 
num = {1, 400, 2, 0}
, mail = 2722, 
battleDown = {6, 7, 8, 9}
, 
battleUp = {7, 8, 9, 10}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[8] = {id = 8, rankName = "黄金II", rankDown = 351, rankUp = 400, rankBigIcon = 16130, rankSmallIcon = 16130, 
item = {31724, 35008, 35012, 0}
, 
num = {1, 450, 3, 0}
, mail = 2723, 
battleDown = {7, 8, 9, 10}
, 
battleUp = {8, 9, 10, 11}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[9] = {id = 9, rankName = "黄金III", rankDown = 401, rankUp = 450, rankBigIcon = 16131, rankSmallIcon = 16131, 
item = {31725, 35008, 35012, 0}
, 
num = {1, 500, 4, 0}
, mail = 2724, 
battleDown = {8, 9, 10, 11}
, 
battleUp = {9, 10, 11, 12}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[10] = {id = 10, rankName = "白金I", rankDown = 451, rankUp = 500, rankBigIcon = 16132, rankSmallIcon = 16132, 
item = {31725, 35008, 35012, 0}
, 
num = {1, 550, 5, 0}
, mail = 2725, 
battleDown = {9, 10, 11, 12}
, 
battleUp = {10, 11, 12, 13}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[11] = {id = 11, rankName = "白金II", rankDown = 501, rankUp = 550, rankBigIcon = 16133, rankSmallIcon = 16133, 
item = {31725, 35008, 35012, 0}
, 
num = {1, 600, 6, 0}
, mail = 2726, 
battleDown = {10, 11, 12, 13}
, 
battleUp = {11, 12, 13, 14}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[12] = {id = 12, rankName = "白金III", rankDown = 551, rankUp = 600, rankBigIcon = 16134, rankSmallIcon = 16134, 
item = {31725, 35008, 35012, 0}
, 
num = {1, 650, 7, 0}
, mail = 2727, 
battleDown = {11, 12, 13, 14}
, 
battleUp = {12, 13, 14, 15}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[13] = {id = 13, rankName = "钻石I", rankDown = 601, rankUp = 650, rankBigIcon = 16135, rankSmallIcon = 16135, 
item = {31725, 35008, 35012, 0}
, 
num = {1, 700, 8, 0}
, mail = 2728, 
battleDown = {12, 13, 14, 15}
, 
battleUp = {13, 14, 15, 15}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[14] = {id = 14, rankName = "钻石II", rankDown = 651, rankUp = 700, rankBigIcon = 16136, rankSmallIcon = 16136, 
item = {31725, 35008, 35012, 0}
, 
num = {1, 750, 9, 0}
, mail = 2729, 
battleDown = {12, 13, 14, 15}
, 
battleUp = {13, 14, 15, 15}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
, 
[15] = {id = 15, rankName = "钻石III", rankDown = 701, rankUp = 9999, rankBigIcon = 16137, rankSmallIcon = 16137, 
item = {31725, 35008, 35012, 0}
, 
num = {1, 800, 10, 0}
, mail = 2730, 
battleDown = {12, 13, 14, 15}
, 
battleUp = {13, 14, 15, 15}
, 
battleWin = {8, 10, 12, 15}
, 
battleLose = {-5, -5, -5, -5}
, 
battleWinDef = {8, 10, 12, 15}
, 
battleLoseDef = {-5, -5, -5, -5}
}
}
cdreamrank.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
return cdreamrank

