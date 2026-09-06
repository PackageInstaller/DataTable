local Chest = class("Chest")
local SceneObject = require("logic.manager.experimental.types.sceneobj")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local cboxtypeconfig = BeanManager.GetTableByName("sceneinteractive.cboxtypeconfig")

function Chest:Ctor(id, object)
  self._id = id
  self._minimapID = nil
  self._type = nil
  self._object = object
  self._cfg = BeanManager.GetTableByName("sceneinteractive.cboxconfig"):GetRecorder(id)
  local pos = string.split(self._cfg.position, ",")
  self._pos = {
    x = tonumber(pos[1]),
    y = tonumber(pos[2])
  }
  self._opened = false
  self:BuildSceneObject()
end

function Chest:Destroy()
  if self._sceneobject then
    UIInteraction.RemoveSceneInteractiveObj(self._sceneobject:GetInteractiveId())
    self._sceneobject = nil
  end
end

function Chest:GetID()
  return self._id
end

function Chest:GetObject()
  return self._object
end

function Chest:GetType()
  return self._cfg.type
end

function Chest:GetSceneObject()
  return self._sceneobject
end

function Chest:GetHintRange()
  if self._cfg.Zone == 0 then
    return
  end
  local radius = math.floor(self._cfg.Zone / 2)
  return {
    x = self._pos.x - radius,
    y = self._pos.y - radius,
    w = self._cfg.Zone,
    h = self._cfg.Zone
  }
end

function Chest:GetKeyID()
  for _, i in pairs(cboxtypeconfig:GetAllIds()) do
    local record = cboxtypeconfig:GetRecorder(i)
    if record.type == self._cfg.type then
      return record.key_id
    end
  end
end

function Chest:GetHintType()
  for _, i in pairs(cboxtypeconfig:GetAllIds()) do
    local record = cboxtypeconfig:GetRecorder(i)
    if record.type == self._cfg.type then
      return record.modals
    end
  end
end

function Chest:BuildSceneObject()
  local id = -10000 * self._id
  local sceneid = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon):GetSceneID()
  self._sceneobject = SceneObject.Create(id, sceneid, self._object, self._pos, 1, 10, self._cfg.button)
  UIInteraction.AddSceneInteractiveObj(self._sceneobject)
end

function Chest:BuildBlocking()
  local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.AddBlockingPoint(active_controller._sceneRef.builder, self._pos.x, self._pos.y, tonumber(self._cfg.width), tonumber(self._cfg.length))
end

function Chest:Activate()
  UIInteraction.SetInteractiveData(self._sceneobject:GetInteractiveId())
  self:BuildBlocking()
  self._minimapID = NekoData.BehaviorManager.BM_MiniMap:AddObject(5, self._pos.y, self._pos.x, true)
end

function Chest:Open(protocol)
  self._opened = true
  local root = ComposedEffect.Create()
  local effect = EffectFactory.CreateCustomEffect(function()
    UIInteraction.RemoveActButton(self._sceneobject:GetInteractiveId())
  end)
  root:AddEffect(effect)
  effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "ChestState", 1)
  root:AddEffect(effect)
  effect = EffectFactory.CreateCustomEffect(function()
    self:Destroy()
  end)
  root:AddEffect(effect)
  if #protocol.items ~= 0 then
    effect = EffectFactory.CreateCustomEffect(function()
      DialogManager.CreateSingletonDialog("dungeon.dungeonitemaccountdialog"):SetData(protocol)
    end)
    root:AddEffect(effect)
  end
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    self:AddOpenIcon()
  end))
  effect = EffectFactory.CreateBGMEffect("play", 63)
  root:AddEffect(effect)
  root:Bind(self._object)
  root:Run()
end

function Chest:RestoreState()
  self._opened = true
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "ChestState", 1)
  effect:Bind(self._object)
  effect:Run()
  self:BuildBlocking()
  self:AddOpenIcon()
end

function Chest:AddOpenIcon()
  if self._minimapID then
    NekoData.BehaviorManager.BM_MiniMap:RemoveObject(self._minimapID)
  end
  self._minimapID = NekoData.BehaviorManager.BM_MiniMap:AddObject(6, self._pos.y, self._pos.x, true)
end

function Chest:IsOpened()
  return self._opened
end

return Chest
