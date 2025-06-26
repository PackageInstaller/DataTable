-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/senter.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEnter = dataclass("SEnter", require("framework.net.protocol"))
SEnter.ProtocolType = 2202
SEnter.MaxSize = 655350
SEnter.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEnter, _ENV
  ((SEnter.super).Ctor)(self, client)
  self.userInfo = ((require("protocols.bean.protocol.user.userinfo")).Create)()
  self.bags = {}
end

SEnter.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (self.userInfo):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.bags)) then
    return false
  end
  for key,value in pairs(self.bags) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    if not value:Marshal(R9_PC26) then
      return false
    end
  end
  return true
end

SEnter.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  if not (self.userInfo):Unmarshal(buffer) then
    return false
  end
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
    -- DECOMPILER ERROR at PC39: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.bags)[key] = value
  end
  return ret
end

return SEnter

