-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/card/drawcarddetails.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local DrawCardDetails = dataclass("DrawCardDetails")
DrawCardDetails.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.upRoles = {}
  self.ssr = ((require("protocols.bean.protocol.card.rolepool")).Create)()
  self.sr = ((require("protocols.bean.protocol.card.rolepool")).Create)()
  self.r = ((require("protocols.bean.protocol.card.rolepool")).Create)()
  self.ur = ((require("protocols.bean.protocol.card.rolepool")).Create)()
end

DrawCardDetails.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.upRoles)) then
    return false
  end
  for key,value in pairs(self.upRoles) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
  end
  if not (self.ssr):Marshal(buffer) then
    return false
  end
  if not (self.sr):Marshal(buffer) then
    return false
  end
  if not (self.r):Marshal(buffer) then
    return false
  end
  if not (self.ur):Marshal(buffer) then
    return false
  end
  return true
end

DrawCardDetails.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
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

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.upRoles)[key] = value
  end
  if not (self.ssr):Unmarshal(buffer) then
    return false
  end
  if not (self.sr):Unmarshal(buffer) then
    return false
  end
  if not (self.r):Unmarshal(buffer) then
    return false
  end
  if not (self.ur):Unmarshal(buffer) then
    return false
  end
  return ret
end

return DrawCardDetails

