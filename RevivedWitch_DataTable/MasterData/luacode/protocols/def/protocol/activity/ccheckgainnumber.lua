-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ccheckgainnumber.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckGainNumber = dataclass("CCheckGainNumber", require("framework.net.protocol"))
CCheckGainNumber.ProtocolType = 2606
CCheckGainNumber.MaxSize = 65535
CCheckGainNumber.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckGainNumber
  ((CCheckGainNumber.super).Ctor)(self, client)
end

CCheckGainNumber.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CCheckGainNumber.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CCheckGainNumber

