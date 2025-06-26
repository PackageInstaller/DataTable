-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/user/handbooktype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local HandbookType = dataclass("HandbookType")
HandbookType.EQUIP = 1
HandbookType.MONSTER = 2
HandbookType.ROLE = 3
HandbookType.NPC = 4
HandbookType.WORLD = 5
HandbookType.FORCE = 6
HandbookType.ACTIVITY = 7
HandbookType.Ctor = function(self)
  -- function num : 0_0
end

HandbookType.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

HandbookType.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return HandbookType

