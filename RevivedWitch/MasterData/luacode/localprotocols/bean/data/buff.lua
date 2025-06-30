-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/bean/data/buff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Buff = dataclass("Buff")
Buff.id = 0
Buff.key = 0
Buff.countdown = 0
Buff.Ctor = function(self)
  -- function num : 0_0
end

Buff.Marshal = function(self, data)
  -- function num : 0_1
  data.id = self.id
  data.key = self.key
  data.countdown = self.countdown
end

Buff.Unmarshal = function(self, data)
  -- function num : 0_2
  self.id = data.id
  self.key = data.key
  self.countdown = data.countdown
end

Buff.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.id) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.id) = %s. number required.", type(self.id))
    return false
  end
  if type(self.key) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.key) = %s. number required.", type(self.key))
    return false
  end
  if type(self.countdown) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.countdown) = %s. number required.", type(self.countdown))
    return false
  end
  return true
end

return Buff

