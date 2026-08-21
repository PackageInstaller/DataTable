-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sbagfulldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBagFullDialog = dataclass("SBagFullDialog", require("framework.net.protocol"))
SBagFullDialog.ProtocolType = 1237
SBagFullDialog.MaxSize = 65535
SBagFullDialog.bagtype = 0
SBagFullDialog.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBagFullDialog
  ((SBagFullDialog.super).Ctor)(self, client)
end

SBagFullDialog.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bagtype) then
    return false
  end
  return true
end

SBagFullDialog.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBagFullDialog

