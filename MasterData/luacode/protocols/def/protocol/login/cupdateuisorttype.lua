local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUpdateUISortType = dataclass("CUpdateUISortType", require("framework.net.protocol"))
CUpdateUISortType.ProtocolType = 1085
CUpdateUISortType.MaxSize = 65535
CUpdateUISortType.key = 0
CUpdateUISortType.Showtype = 0
CUpdateUISortType.ALL_ROLES = 1
CUpdateUISortType.EQUIPMENT_LIST = 2
CUpdateUISortType.SUPPORT_ROLE = 3
CUpdateUISortType.ROLE4SHOW = 4
CUpdateUISortType.QUICKSET_LINEUP = 5
CUpdateUISortType.ROLES_HANDBOOK = 6

function CUpdateUISortType:Ctor(client)
  CUpdateUISortType.super.Ctor(self, client)
end

function CUpdateUISortType:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.Showtype) then
    return false
  end
  return true
end

function CUpdateUISortType:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.Showtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUpdateUISortType
