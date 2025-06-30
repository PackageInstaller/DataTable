-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sfirstpassresourcescene.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFirstPassResourceScene = dataclass("SFirstPassResourceScene", require("framework.net.protocol"))
SFirstPassResourceScene.ProtocolType = 1936
SFirstPassResourceScene.MaxSize = 65535
SFirstPassResourceScene.passid = 0
SFirstPassResourceScene.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFirstPassResourceScene
  ((SFirstPassResourceScene.super).Ctor)(self, client)
  self.firstItems = {}
end

SFirstPassResourceScene.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.passid) then
    return false
  end
  local length = (table.slen)(self.firstItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.firstItems)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SFirstPassResourceScene.Unmarshal = function(self, buffer)
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

    (self.firstItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.firstItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SFirstPassResourceScene

