-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sshowobtainpanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SShowObtainPanel = dataclass("SShowObtainPanel", require("framework.net.protocol"))
SShowObtainPanel.ProtocolType = 4102
SShowObtainPanel.MaxSize = 65535
SShowObtainPanel.showType = 0
SShowObtainPanel.AWARD = 1
SShowObtainPanel.RETURN = 2
SShowObtainPanel.RETURN_SHOW = 3
SShowObtainPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SShowObtainPanel
  ((SShowObtainPanel.super).Ctor)(self, client)
  self.awardCurrency = {}
  self.awardItems = {}
end

SShowObtainPanel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.awardCurrency)) then
    return false
  end
  for key,value in pairs(self.awardCurrency) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R9_PC18) then
      return false
    end
  end
  local length = (table.slen)(self.awardItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC52: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.awardItems)[i]):Marshal(R9_PC18) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.showType) then
    return false
  end
  return true
end

SShowObtainPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC29: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.awardCurrency)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R11 in 'UnsetPending'

    (self.awardItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.awardItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShowObtainPanel

