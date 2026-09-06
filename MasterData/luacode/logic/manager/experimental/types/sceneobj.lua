local SceneObj = class("SceneObj")
local cinteractiveconfig = BeanManager.GetTableByName("sceneinteractive.cinteractiveconfig")

function SceneObj:Ctor(interactiveId, sceneId, object, position, type, value, texttype)
  self._interactiveId = interactiveId
  self._sceneId = sceneId
  self._sceneObj = object
  self._position = position
  self._position.w = position.w or 1
  self._position.h = position.h or 1
  self._type = type
  self._value = value
  self._texttype = texttype or value
  if _G.type(self._texttype) == "table" then
    self._texttype = self._texttype[1]
  end
  self._cfg = cinteractiveconfig:GetRecorder(interactiveId)
end

function SceneObj:Destroy()
end

function SceneObj:GetInteractiveId()
  return self._interactiveId
end

function SceneObj:GetSceneId()
  return self._sceneId
end

function SceneObj:GetObj()
  return self._sceneObj
end

function SceneObj:GetPosition()
  return self._position
end

function SceneObj:GetType()
  return self._type
end

function SceneObj:GetOperation()
  return self._value
end

function SceneObj:GetButtonTextType()
  return self._texttype
end

function SceneObj:GetState()
  return self._state
end

function SceneObj:SetState(state)
  self._state = state
end

function SceneObj:SetRepeat(isRepeat)
  if isRepeat == 0 then
    self._isRepeat = false
  elseif isRepeat == 1 then
    self._isRepeat = true
  end
end

function SceneObj:IsRepeat()
  return self._isRepeat
end

function SceneObj:BlockInConfig()
  if self._cfg then
    return self._cfg.Block == 1
  end
  return true
end

return SceneObj
