-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copendungeonlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenDungeonList = dataclass("COpenDungeonList", require("framework.net.protocol"))
COpenDungeonList.ProtocolType = 1910
COpenDungeonList.MaxSize = 65535
COpenDungeonList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenDungeonList
  ((COpenDungeonList.super).Ctor)(self, client)
end

COpenDungeonList.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenDungeonList.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenDungeonList

