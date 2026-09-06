local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBagFullDialog = dataclass("SBagFullDialog", require("framework.net.protocol"))
SBagFullDialog.ProtocolType = 1237
SBagFullDialog.MaxSize = 65535
SBagFullDialog.bagtype = 0

function SBagFullDialog:Ctor(client)
  SBagFullDialog.super.Ctor(self, client)
end

function SBagFullDialog:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bagtype) then
    return false
  end
  return true
end

function SBagFullDialog:Unmarshal(buffer)
  local ret = true
  ret, self.bagtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBagFullDialog
