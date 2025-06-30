-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/cgetmaillist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetMailList = dataclass("CGetMailList", require("framework.net.protocol"))
CGetMailList.ProtocolType = 1401
CGetMailList.MaxSize = 65535
CGetMailList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetMailList
  ((CGetMailList.super).Ctor)(self, client)
end

CGetMailList.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetMailList.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetMailList

