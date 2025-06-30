-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceiveactivtyitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveActivtyItem = dataclass("SReceiveActivtyItem", require("framework.net.protocol"))
SReceiveActivtyItem.ProtocolType = 2640
SReceiveActivtyItem.MaxSize = 65535
SReceiveActivtyItem.activityLineId = 0
SReceiveActivtyItem.FOOLSDAY = 33
SReceiveActivtyItem.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveActivtyItem
  ((SReceiveActivtyItem.super).Ctor)(self, client)
  self.itemlist = {}
end

SReceiveActivtyItem.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityLineId) then
    return false
  end
  local length = (table.slen)(self.itemlist)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.itemlist)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SReceiveActivtyItem.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.itemlist)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.itemlist)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SReceiveActivtyItem

