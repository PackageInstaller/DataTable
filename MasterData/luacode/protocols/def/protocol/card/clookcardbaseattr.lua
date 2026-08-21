-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/clookcardbaseattr.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CLookCardBaseAttr = dataclass("CLookCardBaseAttr", require("framework.net.protocol"))
CLookCardBaseAttr.ProtocolType = 1527
CLookCardBaseAttr.MaxSize = 65535
CLookCardBaseAttr.roleId = 0
CLookCardBaseAttr.cfgId = 0
CLookCardBaseAttr.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CLookCardBaseAttr
  ((CLookCardBaseAttr.super).Ctor)(self, client)
end

CLookCardBaseAttr.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.cfgId) then
    return false
  end
  return true
end

CLookCardBaseAttr.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLookCardBaseAttr

