-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/itembagimport.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ItemBagImport = dataclass("ItemBagImport", require("framework.net.protocol"))
ItemBagImport.ProtocolType = 1201
ItemBagImport.MaxSize = 65535
ItemBagImport.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : ItemBagImport, _ENV
  ((ItemBagImport.super).Ctor)(self, client)
  self.b1 = ((require("protocols.bean.protocol.item.beans.bagtypes")).Create)()
  self.b2 = ((require("protocols.bean.protocol.item.equiptype")).Create)()
end

ItemBagImport.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.b1):Marshal(buffer) then
    return false
  end
  if not (self.b2):Marshal(buffer) then
    return false
  end
  return true
end

ItemBagImport.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.b1):Unmarshal(buffer) then
    return false
  end
  if not (self.b2):Unmarshal(buffer) then
    return false
  end
  return ret
end

return ItemBagImport

