-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/chest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Chest = class("Chest")
local SceneObject = require("logic.manager.experimental.types.sceneobj")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local cboxtypeconfig = (BeanManager.GetTableByName)("sceneinteractive.cboxtypeconfig")
Chest.Ctor = function(self, id, object)
  -- function num : 0_0 , upvalues : _ENV
  self._id = id
  self._minimapID = nil
  self._type = nil
  self._object = object
  self._cfg = ((BeanManager.GetTableByName)("sceneinteractive.cboxconfig")):GetRecorder(id)
  local pos = (string.split)((self._cfg).position, ",")
  self._pos = {x = tonumber(pos[1]), y = tonumber(pos[2])}
  self._opened = false
  self:BuildSceneObject()
end

Chest.Destroy = function(self)
  -- function num : 0_1 , upvalues : UIInteraction
  if self._sceneobject then
    (UIInteraction.RemoveSceneInteractiveObj)((self._sceneobject):GetInteractiveId())
    self._sceneobject = nil
  end
end

Chest.GetID = function(self)
  -- function num : 0_2
  return self._id
end

Chest.GetObject = function(self)
  -- function num : 0_3
  return self._object
end

Chest.GetType = function(self)
  -- function num : 0_4
  return (self._cfg).type
end

Chest.GetSceneObject = function(self)
  -- function num : 0_5
  return self._sceneobject
end

Chest.GetHintRange = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (self._cfg).Zone == 0 then
    return 
  end
  local radius = (math.floor)((self._cfg).Zone / 2)
  return {x = (self._pos).x - radius, y = (self._pos).y - radius, w = (self._cfg).Zone, h = (self._cfg).Zone}
end

Chest.GetKeyID = function(self)
  -- function num : 0_7 , upvalues : _ENV, cboxtypeconfig
  for _,i in pairs(cboxtypeconfig:GetAllIds()) do
    local record = cboxtypeconfig:GetRecorder(i)
    if record.type == (self._cfg).type then
      return record.key_id
    end
  end
end

Chest.GetHintType = function(self)
  -- function num : 0_8 , upvalues : _ENV, cboxtypeconfig
  for _,i in pairs(cboxtypeconfig:GetAllIds()) do
    local record = cboxtypeconfig:GetRecorder(i)
    if record.type == (self._cfg).type then
      return record.modals
    end
  end
end

Chest.BuildSceneObject = function(self)
  -- function num : 0_9 , upvalues : _ENV, SceneObject, UIInteraction
  local id = -10000 * self._id
  local sceneid = ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):GetSceneID()
  self._sceneobject = (SceneObject.Create)(id, sceneid, self._object, self._pos, 1, 10, (self._cfg).button)
  ;
  (UIInteraction.AddSceneInteractiveObj)(self._sceneobject)
end

Chest.BuildBlocking = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).AddBlockingPoint)((active_controller._sceneRef).builder, (self._pos).x, (self._pos).y, tonumber((self._cfg).width), tonumber((self._cfg).length))
end

Chest.Activate = function(self)
  -- function num : 0_11 , upvalues : UIInteraction, _ENV
  (UIInteraction.SetInteractiveData)((self._sceneobject):GetInteractiveId())
  self:BuildBlocking()
  self._minimapID = ((NekoData.BehaviorManager).BM_MiniMap):AddObject(5, (self._pos).y, (self._pos).x, true)
end

Chest.Open = function(self, protocol)
  -- function num : 0_12 , upvalues : ComposedEffect, _ENV, UIInteraction
  self._opened = true
  local root = (ComposedEffect.Create)()
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_12_0 , upvalues : UIInteraction, self
    (UIInteraction.RemoveActButton)((self._sceneobject):GetInteractiveId())
  end
)
  root:AddEffect(effect)
  effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "ChestState", 1)
  root:AddEffect(effect)
  effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_12_1 , upvalues : self
    self:Destroy()
  end
)
  root:AddEffect(effect)
  if #protocol.items ~= 0 then
    effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_12_2 , upvalues : _ENV, protocol
    ((DialogManager.CreateSingletonDialog)("dungeon.dungeonitemaccountdialog")):SetData(protocol)
  end
)
    root:AddEffect(effect)
  end
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_12_3 , upvalues : self
    self:AddOpenIcon()
  end
))
  effect = (EffectFactory.CreateBGMEffect)("play", 63)
  root:AddEffect(effect)
  root:Bind(self._object)
  root:Run()
end

Chest.RestoreState = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self._opened = true
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "ChestState", 1)
  effect:Bind(self._object)
  effect:Run()
  self:BuildBlocking()
  self:AddOpenIcon()
end

Chest.AddOpenIcon = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self._minimapID then
    ((NekoData.BehaviorManager).BM_MiniMap):RemoveObject(self._minimapID)
  end
  self._minimapID = ((NekoData.BehaviorManager).BM_MiniMap):AddObject(6, (self._pos).y, (self._pos).x, true)
end

Chest.IsOpened = function(self)
  -- function num : 0_15
  return self._opened
end

return Chest

