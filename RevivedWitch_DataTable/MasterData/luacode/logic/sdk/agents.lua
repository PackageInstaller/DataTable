-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sdk/agents.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Agents = {
{path = "logic.sdk.agent.none", op = function(platformStr)
  -- function num : 0_0
  do return platformStr == "none" end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
, 
{path = "logic.sdk.agent.leiting", op = function(platformStr)
  -- function num : 0_1
  do return platformStr == "leit" end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
, 
{path = "logic.sdk.agent.yostar", op = function(platformStr)
  -- function num : 0_2
  do return platformStr == "yost" end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
, 
{path = "logic.sdk.agent.qianqian", op = function(platformStr)
  -- function num : 0_3
  do return platformStr == "qian" end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
, 
{path = "logic.sdk.agent.qianqian", op = function(platformStr)
  -- function num : 0_4
  do return platformStr == "mqan" end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
}
return Agents

