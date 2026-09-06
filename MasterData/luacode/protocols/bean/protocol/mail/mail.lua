local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Mail = dataclass("Mail")
Mail.uniqueId = 0
Mail.id = 0
Mail.title = ""
Mail.appellation = ""
Mail.content = ""
Mail.signature = ""
Mail.mailType = 0
Mail.receiveTime = 0
Mail.deleteTime = 0
Mail.status = 0
Mail.questId = 0

function Mail:Ctor()
  self.titleParameter = {}
  self.contentParameter = {}
  self.attachment = require("protocols.bean.protocol.mail.attachment").Create()
end

function Mail:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.uniqueId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.title) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.titleParameter)) then
    return false
  end
  for key, value in pairs(self.titleParameter) do
    if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.appellation) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.content) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.contentParameter)) then
    return false
  end
  for key, value in pairs(self.contentParameter) do
    if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.signature) then
    return false
  end
  if not self.attachment:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.mailType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.receiveTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.deleteTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.questId) then
    return false
  end
  return true
end

function Mail:Unmarshal(buffer)
  local ret = true
  ret, self.uniqueId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.title = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
    if not ret then
      return ret
    end
    self.titleParameter[key] = value
  end
  ret, self.appellation = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.content = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
    if not ret then
      return ret
    end
    self.contentParameter[key] = value
  end
  ret, self.signature = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  if not self.attachment:Unmarshal(buffer) then
    return false
  end
  ret, self.mailType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.receiveTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.deleteTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.questId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Mail
