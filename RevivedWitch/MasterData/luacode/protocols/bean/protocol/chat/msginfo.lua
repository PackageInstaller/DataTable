-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/chat/msginfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local MsgInfo = dataclass("MsgInfo")
MsgInfo.position = 0
MsgInfo.sendTime = 0
MsgInfo.msgType = 0
MsgInfo.msg = ""
MsgInfo.chat = 1
MsgInfo.notify = 2
MsgInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.baseUserData = ((require("protocols.bean.protocol.chat.baseuserdata")).Create)()
  self.hyperlinks = {}
end

MsgInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (self.baseUserData):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.position) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.sendTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.msgType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.msg) then
    return false
  end
  local length = (table.slen)(self.hyperlinks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.hyperlinks)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

MsgInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  if not (self.baseUserData):Unmarshal(buffer) then
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

    (self.hyperlinks)[i] = ((require("protocols.bean.protocol.chat.hyperlink")).Create)()
    if not ((self.hyperlinks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return MsgInfo

