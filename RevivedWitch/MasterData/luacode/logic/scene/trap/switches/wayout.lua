-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/wayout.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local Wayout = class("Wayout", Switch)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local PathResolver = require("logic.scene.pathresolver")
Wayout.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Wayout
  ((Wayout.super).Ctor)(self, ...)
end

Wayout.Destroy = function(self)
  -- function num : 0_1 , upvalues : Wayout, _ENV
  ((Wayout.super).Destroy)(self)
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.wayoutresetdialog")
end

Wayout.BuildStateEffects = function(self)
  -- function num : 0_2 , upvalues : Wayout, _ENV, PathResolver
  ((Wayout.super).BuildStateEffects)(self)
  local root = (EffectFactory.CreateComposedEffect)()
  root = (EffectFactory.CreateEffectList)()
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_0 , upvalues : PathResolver, _ENV, self
    local actor = (PathResolver.Resolve)("[actor]")
    ;
    ((DialogManager.CreateSingletonDialog)("dungeon.wayoutresetdialog")):SetData(self)
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller.GetBuffManager then
      local manager = controller:GetBuffManager()
      local current_buff = manager:GetCurrentBuff()
      if current_buff and current_buff:GetType() == 1 and current_buff:GetState() == 1 then
        manager:OnBuffTimeout(current_buff:GetID())
      end
    end
    do
      self._speed = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetSpeed)(actor)
      ;
      ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetSpeed)(actor, 0.95)
      controller:SetActorRunning(false)
    end
  end
))
  root:AddEffect((self._stateEffects)[1])
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._stateEffects)[1] = root
end

Wayout.Activate = function(self)
  -- function num : 0_3 , upvalues : Wayout, _ENV, FixedPos
  ((Wayout.super).Activate)(self)
  local area = {}
  for _,v in ipairs((self._effectArgs).switches) do
    local switch = (SwitchManager.GetSwitch)(v.instance, v.id)
    area[#area + 1] = (switch:GetEffectArea())[1]
  end
  self._builder = (FixedPos.Create)(self, area)
  local event = (self._builder):BuildEnterEvent()
  ;
  (EventManager.AddEvent)(event)
end

Wayout.Deactivate = function(self)
  -- function num : 0_4 , upvalues : Wayout
  ((Wayout.super).Deactivate)(self)
end

Wayout.SetWayoutInfo = function(self, info)
  -- function num : 0_5
  self._bornPosition = info.bornpos
end

local send = function(instanceid, status)
  -- function num : 0_6 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cresetpositiontrap")
  req.status = status
  req.trapGroupId = instanceid
  req:Send()
end

Wayout.OnEnterArea = function(self, builder)
  -- function num : 0_7 , upvalues : send
  send(self:GetInstanceID(), 1)
  ;
  (self:ToState(1)):Run()
end

Wayout.OnLeaveArea = function(self, builder)
  -- function num : 0_8 , upvalues : send, _ENV, PathResolver
  send(self:GetInstanceID(), 0)
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.wayoutresetdialog")
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  controller:SetActorRunning(true)
  local actor = (PathResolver.Resolve)("[actor]")
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetSpeed)(actor, self._speed)
  self:ToState(0)
end

Wayout.Reset = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((EffectFactory.CreateAnimationEffect)("[actor]", "reset"))
  local fly = (EffectFactory.CreateEffectList)()
  for _,v in ipairs((self._effectArgs).switches) do
    local flipboard = (SwitchManager.GetSwitch)(v.instance, v.id)
    fly:AddEffect(flipboard:ToState(flipboard:GetInitialState()))
  end
  root:AddEffect((EffectFactory.CreateFlyToEffect)("[actor]", (self._bornPosition).x, (self._bornPosition).y, true))
  root:AddEffect(fly)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_9_0 , upvalues : _ENV
    ((EffectFactory.CreateAnimationEffect)("[actor]", "Blend Tree")):Run()
  end
))
  return root
end

return Wayout

