-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/randomitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RandomItem = class("RandomItem")
RandomItem.Ctor = function(self, data)
  -- function num : 0_0
  self._data = data
end

RandomItem.Destroy = function(self, instant)
  -- function num : 0_1 , upvalues : _ENV
  local cleanup = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_0 , upvalues : _ENV, self
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._object)
    self._object = nil
  end
)
  if instant then
    cleanup:Run()
  end
  if self._eventID then
    (EventManager.RemoveEvent)(self._eventID)
    self._eventID = nil
  end
  if self._interactiveTri then
    (self._interactiveTri):Destroy()
  end
end

RandomItem.Bind = function(self, object)
  -- function num : 0_2
  self._object = object
end

RandomItem.GetKey = function(self)
  -- function num : 0_3
  return (self._data).key
end

RandomItem.GetId = function(self)
  -- function num : 0_4
  return (self._data).id
end

RandomItem.GetGirdPosition = function(self)
  -- function num : 0_5
  return (self._data).x, (self._data).z
end

RandomItem.Activate = function(self)
  -- function num : 0_6
end

RandomItem.Deactivate = function(self)
  -- function num : 0_7
end

RandomItem.RandomItemPosTrigger = class("RandomItemPosTrigger")
-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

;
(RandomItem.RandomItemPosTrigger).Ctor = function(self, id, key)
  -- function num : 0_8
  self._id = id
  self._key = key
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

;
(RandomItem.RandomItemPosTrigger).Build = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local recorder = ((BeanManager.GetTableByName)("scene.cscenerandomreward")):GetRecorder(self._id)
  local event = ((EventManager.Builder).BuildRandomItemEvent)((self._data).x, (self._data).z, recorder.crashCubeHeight, recorder.crashCubeWidth, self._key)
  self._eventID = event:GetID()
  ;
  (EventManager.AddEvent)(event)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

;
(RandomItem.RandomItemPosTrigger).Destroy = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if self._eventID then
    (EventManager.RemoveEvent)(self._eventID)
    self._eventID = nil
  end
end

RandomItem.RandomItemInteractiveTrigger = class("RandomItemInteractiveTrigger")
local SceneObj = require("logic.manager.experimental.types.sceneobj")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
-- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

;
(RandomItem.RandomItemInteractiveTrigger).Ctor = function(self, id, key, cfg, object)
  -- function num : 0_11
  self._id = id
  self._key = key
  self._cfg = cfg
  self._object = object
end

local parse_pos_scene = function(situation)
  -- function num : 0_12
  return {x = situation.x, y = situation.y, w = situation.w or 1, h = situation.h or 1}
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

;
(RandomItem.RandomItemInteractiveTrigger).Build = function(self)
  -- function num : 0_13 , upvalues : _ENV, SceneObj, parse_pos_scene, UIInteraction
  local sceneid = ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):GetSceneID()
  self._sceneObject = (SceneObj.Create)(-1 * self._key, sceneid, self._object, parse_pos_scene((self._cfg).situation), 1, (self._cfg).button_tip)
  ;
  (UIInteraction.AddSceneInteractiveObj)(self._sceneObject)
  ;
  (UIInteraction.SetInteractiveData)((self._sceneObject):GetInteractiveId())
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R4 in 'UnsetPending'

;
(RandomItem.RandomItemInteractiveTrigger).Destroy = function(self)
  -- function num : 0_14 , upvalues : UIInteraction
  (UIInteraction.RemoveSceneInteractiveObj)(-1 * self._key)
  ;
  (UIInteraction.RemoveActButton)((self._sceneObject):GetInteractiveId())
end

return RandomItem

