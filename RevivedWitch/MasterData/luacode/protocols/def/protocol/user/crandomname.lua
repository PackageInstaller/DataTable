-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/crandomname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRandomName = dataclass("CRandomName", require("framework.net.protocol"))
CRandomName.ProtocolType = 2203
CRandomName.MaxSize = 65535
CRandomName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRandomName
  ((CRandomName.super).Ctor)(self, client)
end

CRandomName.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRandomName.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRandomName

