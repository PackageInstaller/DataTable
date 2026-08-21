-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/database/cclosedatabase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCloseDataBase = dataclass("CCloseDataBase")
CCloseDataBase.ProtocolType = 302
CCloseDataBase.Ctor = function(self, client)
  -- function num : 0_0
end

CCloseDataBase.Marshal = function(self, data)
  -- function num : 0_1
end

CCloseDataBase.Unmarshal = function(self, data)
  -- function num : 0_2
  return true
end

CCloseDataBase.CheckVariable = function(self)
  -- function num : 0_3
  return true
end

return CCloseDataBase

