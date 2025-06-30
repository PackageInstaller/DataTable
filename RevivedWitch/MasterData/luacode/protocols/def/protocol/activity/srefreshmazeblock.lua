-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshmazeblock.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshMazeBlock = dataclass("SRefreshMazeBlock", require("framework.net.protocol"))
SRefreshMazeBlock.ProtocolType = 2686
SRefreshMazeBlock.MaxSize = 65535
SRefreshMazeBlock.pos = 0
SRefreshMazeBlock.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshMazeBlock
  ((SRefreshMazeBlock.super).Ctor)(self, client)
  self.blocks = {}
  self.itemInfo = {}
end

SRefreshMazeBlock.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.blocks)) then
    return false
  end
  for key,value in pairs(self.blocks) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not value:Marshal(R9_PC18) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pos) then
    return false
  end
  local length = (table.slen)(self.itemInfo)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC59: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.itemInfo)[i]):Marshal(R9_PC18) then
      return false
    end
  end
  return true
end

SRefreshMazeBlock.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC31: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.blocks)[key] = value
  end
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
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R11 in 'UnsetPending'

    (self.itemInfo)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.itemInfo)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRefreshMazeBlock

