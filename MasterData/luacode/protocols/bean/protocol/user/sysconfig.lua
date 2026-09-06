local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SysConfig = dataclass("SysConfig")
SysConfig.music = 1
SysConfig.musicNum = 2
SysConfig.soundEffect = 3
SysConfig.soundEffectNum = 4
SysConfig.dubbing = 5
SysConfig.dubbingNum = 6
SysConfig.quality = 7
SysConfig.UIDisplay = 8
SysConfig.sysChat = 9
SysConfig.worldChat = 10
SysConfig.guideChat = 11
SysConfig.boxOpen = 12
SysConfig.moveType = 13
SysConfig.showBuff = 14
SysConfig.rockerType = 15
SysConfig.autoBattleMode = 16

function SysConfig:Ctor()
end

function SysConfig:Marshal(buffer)
  return true
end

function SysConfig:Unmarshal(buffer)
  local ret = true
  return ret
end

return SysConfig
