local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeUserIntroduce = dataclass("CChangeUserIntroduce", require("framework.net.protocol"))
CChangeUserIntroduce.ProtocolType = 2222
CChangeUserIntroduce.MaxSize = 65535
CChangeUserIntroduce.introduce = ""

function CChangeUserIntroduce:Ctor(client)
  CChangeUserIntroduce.super.Ctor(self, client)
end

function CChangeUserIntroduce:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.introduce) then
    return false
  end
  return true
end

function CChangeUserIntroduce:Unmarshal(buffer)
  local ret = true
  ret, self.introduce = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeUserIntroduce
