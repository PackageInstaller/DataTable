-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/buff/scenebuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneBuff = class("Buff")
local cdungeonbuffconfig = (BeanManager.GetTableByName)("sceneinteractive.cdungeonbuffconfig")
SceneBuff.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : cdungeonbuffconfig
  self._id = id
  self._state = 0
  self._cfg = cdungeonbuffconfig:GetRecorder(id)
end

SceneBuff.Destroy = function(self)
  -- function num : 0_1
end

SceneBuff.Activate = function(self)
  -- function num : 0_2
end

SceneBuff.Deactivate = function(self)
  -- function num : 0_3
end

SceneBuff.GetID = function(self)
  -- function num : 0_4
  return self._id
end

SceneBuff.GetType = function(self)
  -- function num : 0_5
  return (self._cfg).typeID
end

SceneBuff.GetState = function(self)
  -- function num : 0_6
  return self._state
end

SceneBuff.ToState = function(self, state)
  -- function num : 0_7
  self._state = state
end

SceneBuff.GetDurationTime = function(self)
  -- function num : 0_8
end

SceneBuff.GetRespawnTime = function(self)
  -- function num : 0_9
end

SceneBuff.OnActive = function(self)
  -- function num : 0_10
end

SceneBuff.OnInactivate = function(self)
  -- function num : 0_11
end

SceneBuff.OnRespawn = function(self)
  -- function num : 0_12
end

SceneBuff.OnUpdate = function(self, delta)
  -- function num : 0_13
end

return SceneBuff

