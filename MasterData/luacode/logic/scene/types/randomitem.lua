local RandomItem = class("RandomItem")

function RandomItem:Ctor(data)
  self._data = data
end

function RandomItem:Destroy(instant)
  local cleanup = EffectFactory.CreateCustomEffect(function()
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._object)
    self._object = nil
  end)
  if instant then
    cleanup:Run()
  end
  if self._eventID then
    EventManager.RemoveEvent(self._eventID)
    self._eventID = nil
  end
  if self._interactiveTri then
    self._interactiveTri:Destroy()
  end
end

function RandomItem:Bind(object)
  self._object = object
end

function RandomItem:GetKey()
  return self._data.key
end

function RandomItem:GetId()
  return self._data.id
end

function RandomItem:GetGirdPosition()
  return self._data.x, self._data.z
end

function RandomItem:Activate()
end

function RandomItem:Deactivate()
end

RandomItem.RandomItemPosTrigger = class("RandomItemPosTrigger")

function RandomItem.RandomItemPosTrigger:Ctor(id, key)
  self._id = id
  self._key = key
end

function RandomItem.RandomItemPosTrigger:Build()
  local recorder = BeanManager.GetTableByName("scene.cscenerandomreward"):GetRecorder(self._id)
  local event = EventManager.Builder.BuildRandomItemEvent(self._data.x, self._data.z, recorder.crashCubeHeight, recorder.crashCubeWidth, self._key)
  self._eventID = event:GetID()
  EventManager.AddEvent(event)
end

function RandomItem.RandomItemPosTrigger:Destroy()
  if self._eventID then
    EventManager.RemoveEvent(self._eventID)
    self._eventID = nil
  end
end

RandomItem.RandomItemInteractiveTrigger = class("RandomItemInteractiveTrigger")
local SceneObj = require("logic.manager.experimental.types.sceneobj")
local UIInteraction = require("logic.scene.interaction.uiinteraction")

function RandomItem.RandomItemInteractiveTrigger:Ctor(id, key, cfg, object)
  self._id = id
  self._key = key
  self._cfg = cfg
  self._object = object
end

local function parse_pos_scene(situation)
  return {
    x = situation.x,
    y = situation.y,
    w = situation.w or 1,
    h = situation.h or 1
  }
end

function RandomItem.RandomItemInteractiveTrigger:Build()
  local sceneid = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon):GetSceneID()
  self._sceneObject = SceneObj.Create(-1 * self._key, sceneid, self._object, parse_pos_scene(self._cfg.situation), 1, self._cfg.button_tip)
  UIInteraction.AddSceneInteractiveObj(self._sceneObject)
  UIInteraction.SetInteractiveData(self._sceneObject:GetInteractiveId())
end

function RandomItem.RandomItemInteractiveTrigger:Destroy()
  UIInteraction.RemoveSceneInteractiveObj(-1 * self._key)
  UIInteraction.RemoveActButton(self._sceneObject:GetInteractiveId())
end

return RandomItem
