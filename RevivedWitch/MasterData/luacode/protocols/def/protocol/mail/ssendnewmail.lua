-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/ssendnewmail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendNewMail = dataclass("SSendNewMail", require("framework.net.protocol"))
SSendNewMail.ProtocolType = 1403
SSendNewMail.MaxSize = 65535
SSendNewMail.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendNewMail
  ((SSendNewMail.super).Ctor)(self, client)
  self.mails = {}
end

SSendNewMail.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.mails)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.mails)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SSendNewMail.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.mails)[i] = ((require("protocols.bean.protocol.mail.mail")).Create)()
    if not ((self.mails)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SSendNewMail

