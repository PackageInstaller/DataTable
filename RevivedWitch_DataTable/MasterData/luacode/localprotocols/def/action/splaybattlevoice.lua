-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/splaybattlevoice.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPlayBattleVoice = dataclass("SPlayBattleVoice")
SPlayBattleVoice.ProtocolType = 54
SPlayBattleVoice.roleId = 0
SPlayBattleVoice.voiceType = ""
SPlayBattleVoice.index = 0
SPlayBattleVoice.Ctor = function(self, client)
  -- function num : 0_0
end

SPlayBattleVoice.Marshal = function(self, data)
  -- function num : 0_1
  data.roleId = self.roleId
  data.voiceType = self.voiceType
  data.index = self.index
end

SPlayBattleVoice.Unmarshal = function(self, data)
  -- function num : 0_2
  self.roleId = data.roleId
  self.voiceType = data.voiceType
  self.index = data.index
  return true
end

SPlayBattleVoice.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.roleId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.roleId) = %s. number required.", type(self.roleId))
    return false
  end
  if type(self.voiceType) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.voiceType) = %s. string required.", type(self.voiceType))
    return false
  end
  if type(self.index) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.index) = %s. number required.", type(self.index))
    return false
  end
  return true
end

return SPlayBattleVoice

