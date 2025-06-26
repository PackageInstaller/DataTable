-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sdialoguebuy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SDialogueBuy = dataclass("SDialogueBuy", require("framework.net.protocol"))
SDialogueBuy.ProtocolType = 2605
SDialogueBuy.MaxSize = 65535
SDialogueBuy.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SDialogueBuy
  ((SDialogueBuy.super).Ctor)(self, client)
end

SDialogueBuy.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SDialogueBuy.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SDialogueBuy

