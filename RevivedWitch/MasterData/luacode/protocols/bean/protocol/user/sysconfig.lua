-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/user/sysconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
SysConfig.Ctor = function(self)
  -- function num : 0_0
end

SysConfig.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SysConfig.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SysConfig

