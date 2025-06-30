-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/mail/mail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
Mail.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.titleParameter = {}
  self.contentParameter = {}
  self.attachment = ((require("protocols.bean.protocol.mail.attachment")).Create)()
end

Mail.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.uniqueId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.title) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.titleParameter)) then
    return false
  end
  for key,value in pairs(self.titleParameter) do
    if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, R9_PC42) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.appellation) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.content) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.contentParameter)) then
    return false
  end
  for key,value in pairs(self.contentParameter) do
    -- DECOMPILER ERROR at PC90: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, R9_PC42) then
      return false
    end
    -- DECOMPILER ERROR at PC98: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.signature) then
    return false
  end
  if not (self.attachment):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.mailType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.receiveTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.deleteTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.status) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.questId) then
    return false
  end
  return true
end

Mail.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC53: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.titleParameter)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC105: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.contentParameter)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  if not (self.attachment):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Mail

