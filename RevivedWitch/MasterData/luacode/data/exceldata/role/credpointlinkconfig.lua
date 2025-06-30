-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/role/credpointlinkconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local credpointlinkconfig = {}
credpointlinkconfig.Data = {
[1] = {id = 1, notes = "主城人偶按钮", type = 1, paramNum = 0, 
paramTypes = {}
, calculateDetailNum = 1, getParentParamsType = -1, 
childs = {2}
}
, 
[2] = {id = 2, notes = "人偶一览列表cell", type = 2, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 0, 
childs = {3, 5, 7, 9, 11}
}
, 
[3] = {id = 3, notes = "人偶属性技能", type = 3, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {4}
}
, 
[4] = {id = 4, notes = "人偶技能节点", type = 4, paramNum = 2, 
paramTypes = {1, 2}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[5] = {id = 5, notes = "人偶属性进化", type = 5, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {6}
}
, 
[6] = {id = 6, notes = "人偶属性进化阶段等级", type = 6, paramNum = 2, 
paramTypes = {1, 3}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[7] = {id = 7, notes = "人偶属性时装", type = 7, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {8}
}
, 
[8] = {id = 8, notes = "人偶时装", type = 8, paramNum = 2, 
paramTypes = {1, 4}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[9] = {id = 9, notes = "人偶属性好感度", type = 9, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {10}
}
, 
[10] = {id = 10, notes = "人偶好感度", type = 10, paramNum = 2, 
paramTypes = {1, 5}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[11] = {id = 11, notes = "人偶属性突破", type = 11, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {12}
}
, 
[12] = {id = 12, notes = "人偶突破", type = 12, paramNum = 2, 
paramTypes = {1, 6}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[103] = {id = 103, notes = "人偶属性技能-本地查看", type = 3, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {104}
}
, 
[104] = {id = 104, notes = "人偶技能节点-本地查看", type = 104, paramNum = 2, 
paramTypes = {1, 2}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[105] = {id = 105, notes = "人偶属性进化-本地查看", type = 5, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {106}
}
, 
[106] = {id = 106, notes = "人偶属性进化阶段等级-本地查看", type = 106, paramNum = 2, 
paramTypes = {1, 3}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[107] = {id = 107, notes = "人偶属性时装-本地查看", type = 7, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {108}
}
, 
[108] = {id = 108, notes = "人偶时装-本地查看", type = 108, paramNum = 2, 
paramTypes = {1, 4}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[109] = {id = 109, notes = "人偶属性好感度-本地查看", type = 9, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {110}
}
, 
[110] = {id = 110, notes = "人偶好感度-本地查看", type = 110, paramNum = 2, 
paramTypes = {1, 5}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[111] = {id = 111, notes = "人偶属性突破-本地查看", type = 11, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 1, 
childs = {112}
}
, 
[112] = {id = 112, notes = "人偶突破-本地查看", type = 112, paramNum = 2, 
paramTypes = {1, 6}
, calculateDetailNum = 0, getParentParamsType = 1, 
childs = {}
}
, 
[100001] = {id = 100001, notes = "主城人偶按钮-刷新", type = 1, paramNum = 0, 
paramTypes = {}
, calculateDetailNum = 1, getParentParamsType = -1, 
childs = {100002}
}
, 
[100002] = {id = 100002, notes = "人偶一览列表cell-刷新", type = 2, paramNum = 1, 
paramTypes = {1}
, calculateDetailNum = 1, getParentParamsType = 0, 
childs = {103, 105, 107, 109, 111}
}
}
credpointlinkconfig.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 100001, 100002}
return credpointlinkconfig

