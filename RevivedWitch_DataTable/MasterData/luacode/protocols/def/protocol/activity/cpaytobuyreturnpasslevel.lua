-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cpaytobuyreturnpasslevel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CPayToBuyReturnPassLevel = dataclass("CPayToBuyReturnPassLevel", require("framework.net.protocol"))
CPayToBuyReturnPassLevel.ProtocolType = 2742
CPayToBuyReturnPassLevel.MaxSize = 65535
CPayToBuyReturnPassLevel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CPayToBuyReturnPassLevel
  ((CPayToBuyReturnPassLevel.super).Ctor)(self, client)
end

CPayToBuyReturnPassLevel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CPayToBuyReturnPassLevel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CPayToBuyReturnPassLevel

