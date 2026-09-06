local Switch = require("logic.scene.trap.switch")
local Wayout = class("Wayout", Switch)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local PathResolver = require("logic.scene.pathresolver")

function Wayout:Ctor(...)
  Wayout.super.Ctor(self, ...)
end

function Wayout:Destroy()
  Wayout.super.Destroy(self)
  DialogManager.DestroySingletonDialog("dungeon.wayoutresetdialog")
end

function Wayout:BuildStateEffects()
  Wayout.super.BuildStateEffects(self)
  local root = EffectFactory.CreateComposedEffect()
  root = EffectFactory.CreateEffectList()
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    local actor = PathResolver.Resolve("[actor]")
    DialogManager.CreateSingletonDialog("dungeon.wayoutresetdialog"):SetData(self)
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller.GetBuffManager then
      local manager = controller:GetBuffManager()
      local current_buff = manager:GetCurrentBuff()
      if current_buff and current_buff:GetType() == 1 and current_buff:GetState() == 1 then
        manager:OnBuffTimeout(current_buff:GetID())
      end
    end
    self._speed = CS.PixelNeko.Lua.NavMeshStaticFunctions.GetSpeed(actor)
    CS.PixelNeko.Lua.NavMeshStaticFunctions.SetSpeed(actor, 0.95)
    controller:SetActorRunning(false)
  end))
  root:AddEffect(self._stateEffects[1])
  self._stateEffects[1] = root
end

function Wayout:Activate()
  Wayout.super.Activate(self)
  local area = {}
  for _, v in ipairs(self._effectArgs.switches) do
    local switch = SwitchManager.GetSwitch(v.instance, v.id)
    area[#area + 1] = switch:GetEffectArea()[1]
  end
  self._builder = FixedPos.Create(self, area)
  local event = self._builder:BuildEnterEvent()
  EventManager.AddEvent(event)
end

function Wayout:Deactivate()
  Wayout.super.Deactivate(self)
end

function Wayout:SetWayoutInfo(info)
  self._bornPosition = info.bornpos
end

local function send(instanceid, status)
  local req = LuaNetManager.CreateProtocol("protocol.battle.cresetpositiontrap")
  req.status = status
  req.trapGroupId = instanceid
  req:Send()
end

function Wayout:OnEnterArea(builder)
  send(self:GetInstanceID(), 1)
  self:ToState(1):Run()
end

function Wayout:OnLeaveArea(builder)
  send(self:GetInstanceID(), 0)
  DialogManager.DestroySingletonDialog("dungeon.wayoutresetdialog")
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  controller:SetActorRunning(true)
  local actor = PathResolver.Resolve("[actor]")
  CS.PixelNeko.Lua.NavMeshStaticFunctions.SetSpeed(actor, self._speed)
  self:ToState(0)
end

function Wayout:Reset()
  local root = EffectFactory.CreateComposedEffect()
  root:AddEffect(EffectFactory.CreateAnimationEffect("[actor]", "reset"))
  local fly = EffectFactory.CreateEffectList()
  for _, v in ipairs(self._effectArgs.switches) do
    local flipboard = SwitchManager.GetSwitch(v.instance, v.id)
    fly:AddEffect(flipboard:ToState(flipboard:GetInitialState()))
  end
  root:AddEffect(EffectFactory.CreateFlyToEffect("[actor]", self._bornPosition.x, self._bornPosition.y, true))
  root:AddEffect(fly)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    EffectFactory.CreateAnimationEffect("[actor]", "Blend Tree"):Run()
  end))
  return root
end

return Wayout
