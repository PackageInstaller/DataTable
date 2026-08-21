-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/crecordwhitevalentineroleid.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecordWhiteValentineRoleId = dataclass("CRecordWhiteValentineRoleId", require("framework.net.protocol"))
CRecordWhiteValentineRoleId.ProtocolType = 2620
CRecordWhiteValentineRoleId.MaxSize = 65535
CRecordWhiteValentineRoleId.roleId = 0
CRecordWhiteValentineRoleId.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecordWhiteValentineRoleId
  ((CRecordWhiteValentineRoleId.super).Ctor)(self, client)
end

CRecordWhiteValentineRoleId.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CRecordWhiteValentineRoleId.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordWhiteValentineRoleId

