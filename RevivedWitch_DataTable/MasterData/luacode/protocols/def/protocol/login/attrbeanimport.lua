-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/attrbeanimport.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local AttrBeanImport = dataclass("AttrBeanImport", require("framework.net.protocol"))
AttrBeanImport.ProtocolType = 1100
AttrBeanImport.MaxSize = 65535
AttrBeanImport.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : AttrBeanImport, _ENV
  ((AttrBeanImport.super).Ctor)(self, client)
  self.b1 = ((require("protocols.bean.protocol.login.attrtype")).Create)()
  self.b2 = ((require("protocols.bean.protocol.login.effecttype")).Create)()
  self.b3 = ((require("protocols.bean.protocol.login.lineupstation")).Create)()
  self.b4 = ((require("protocols.bean.protocol.login.buffstate")).Create)()
end

AttrBeanImport.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.b1):Marshal(buffer) then
    return false
  end
  if not (self.b2):Marshal(buffer) then
    return false
  end
  if not (self.b3):Marshal(buffer) then
    return false
  end
  if not (self.b4):Marshal(buffer) then
    return false
  end
  return true
end

AttrBeanImport.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.b1):Unmarshal(buffer) then
    return false
  end
  if not (self.b2):Unmarshal(buffer) then
    return false
  end
  if not (self.b3):Unmarshal(buffer) then
    return false
  end
  if not (self.b4):Unmarshal(buffer) then
    return false
  end
  return ret
end

return AttrBeanImport

