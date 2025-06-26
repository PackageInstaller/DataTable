-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/sceneobj.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneObj = class("SceneObj")
local cinteractiveconfig = (BeanManager.GetTableByName)("sceneinteractive.cinteractiveconfig")
SceneObj.Ctor = function(self, interactiveId, sceneId, object, position, type, value, texttype)
  -- function num : 0_0 , upvalues : _ENV, cinteractiveconfig
  self._interactiveId = interactiveId
  self._sceneId = sceneId
  self._sceneObj = object
  self._position = position
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._position).w = position.w or 1
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._position).h = position.h or 1
  self._type = type
  self._value = value
  self._texttype = texttype or value
  if (_G.type)(self._texttype) == "table" then
    self._texttype = (self._texttype)[1]
  end
  self._cfg = cinteractiveconfig:GetRecorder(interactiveId)
end

SceneObj.Destroy = function(self)
  -- function num : 0_1
end

SceneObj.GetInteractiveId = function(self)
  -- function num : 0_2
  return self._interactiveId
end

SceneObj.GetSceneId = function(self)
  -- function num : 0_3
  return self._sceneId
end

SceneObj.GetObj = function(self)
  -- function num : 0_4
  return self._sceneObj
end

SceneObj.GetPosition = function(self)
  -- function num : 0_5
  return self._position
end

SceneObj.GetType = function(self)
  -- function num : 0_6
  return self._type
end

SceneObj.GetOperation = function(self)
  -- function num : 0_7
  return self._value
end

SceneObj.GetButtonTextType = function(self)
  -- function num : 0_8
  return self._texttype
end

SceneObj.GetState = function(self)
  -- function num : 0_9
  return self._state
end

SceneObj.SetState = function(self, state)
  -- function num : 0_10
  self._state = state
end

SceneObj.SetRepeat = function(self, isRepeat)
  -- function num : 0_11
  if isRepeat == 0 then
    self._isRepeat = false
  else
    if isRepeat == 1 then
      self._isRepeat = true
    end
  end
end

SceneObj.IsRepeat = function(self)
  -- function num : 0_12
  return self._isRepeat
end

SceneObj.BlockInConfig = function(self)
  -- function num : 0_13
  if (self._cfg).Block ~= 1 then
    do return not self._cfg end
    do return true end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return SceneObj

