local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLogin = dataclass("CLogin", require("framework.net.protocol"))
CLogin.ProtocolType = 101
CLogin.MaxSize = 10240
CLogin.account = ""
CLogin.token = ""
CLogin.plat = ""
CLogin.deviceId = ""
CLogin.channelId = ""
CLogin.imei = ""
CLogin.system = 0
CLogin.model = ""
CLogin.resolution = ""
CLogin.systemVersion = ""
CLogin.networkMode = ""
CLogin.operatorField = ""
CLogin.clientVersion = ""
CLogin.isRelogin = 0
CLogin.oaid = ""
CLogin.media = ""

function CLogin:Ctor(client)
  CLogin.super.Ctor(self, client)
end

function CLogin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.account) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.token) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.plat) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.deviceId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.channelId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.imei) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.system) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.model) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.resolution) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.systemVersion) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.networkMode) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.operatorField) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.clientVersion) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.isRelogin) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.oaid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.media) then
    return false
  end
  return true
end

function CLogin:Unmarshal(buffer)
  local ret = true
  ret, self.account = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.token = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.plat = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.deviceId = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.channelId = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.imei = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.system = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.model = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.resolution = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.systemVersion = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.networkMode = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.operatorField = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.clientVersion = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.isRelogin = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  ret, self.oaid = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.media = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLogin
