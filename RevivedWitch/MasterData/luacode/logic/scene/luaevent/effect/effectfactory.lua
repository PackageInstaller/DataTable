-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/effectfactory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectFactory = {}
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local TrapComposedEffect = require("logic.scene.luaevent.effect.composed.trapcomposedeffect")
local EffectList = require("logic.scene.luaevent.effect.composed.effectlist")
local BattleEffect = require("logic.scene.luaevent.effect.basic.battleeffect")
local EventEffect = require("logic.scene.luaevent.effect.basic.eventeffect")
local AddEventEffect = require("logic.scene.luaevent.effect.basic.addeventeffect")
local CustomEffect = require("logic.scene.luaevent.effect.basic.customeffect")
local CounterEffect = require("logic.scene.luaevent.effect.basic.countereffect")
local TimeLineEffect = require("logic.scene.luaevent.effect.basic.timelineeffect")
local PortalTimeLineEffect = require("logic.scene.luaevent.effect.basic.portaltimelineeffect")
local VisualEffect = require("logic.scene.luaevent.effect.basic.visualeffect")
local FlyToEffect = require("logic.scene.luaevent.effect.basic.flytoeffect")
local FlyToWorldPosEffect = require("logic.scene.luaevent.effect.basic.flytoworldposeffect")
local MoveToEffect = require("logic.scene.luaevent.effect.basic.movetoeffect")
local MoveToWorldPosEffect = require("logic.scene.luaevent.effect.basic.movetoworldposeffect")
local BlockChangeEffect = require("logic.scene.luaevent.effect.basic.blockchangeeffect")
local RemoveEventEffect = require("logic.scene.luaevent.effect.basic.removeeventeffect")
local JumpBackEffect = require("logic.scene.luaevent.effect.basic.jumpbackeffect")
local AnimationEffect = require("logic.scene.luaevent.effect.basic.animationeffect")
local TrapStateChangeEffect = require("logic.scene.luaevent.effect.basic.trapstatechangeeffect")
local AnimatorStateChangeEffect = require("logic.scene.luaevent.effect.basic.animatorstatechangeeffect")
local CameraMoveEffect = require("logic.scene.luaevent.effect.basic.cameramoveeffect")
local SpeedChangeEffect = require("logic.scene.luaevent.effect.basic.speedchangeeffect")
local CreateDialogEffect = require("logic.scene.luaevent.effect.basic.createdialogeffect")
local CreateSkillUnlockDialogEffect = require("logic.scene.luaevent.effect.basic.createskillunlockdialogeffect")
local FreezeEffect = require("logic.scene.luaevent.effect.basic.freezeeffect")
local ThawEffect = require("logic.scene.luaevent.effect.basic.thaweffect")
local TrapCheckEffect = require("logic.scene.luaevent.effect.basic.trapcheckeffect")
local BgmEffect = require("logic.scene.luaevent.effect.basic.bgmeffect")
local DestroyEffect = require("logic.scene.luaevent.effect.basic.destroyeffect")
local NavMeshLinkEffect = require("logic.scene.luaevent.effect.basic.navmeshlinkeffect")
local JumpEffect = require("logic.scene.luaevent.effect.basic.jumpeffect")
local TurnEffect = require("logic.scene.luaevent.effect.basic.turneffect")
local StartChatEffect = require("logic.scene.luaevent.effect.basic.startchateffect")
local DelayEffect = require("logic.scene.luaevent.effect.basic.delayeffect")
local ChangeTrapStateEffect = require("logic.scene.luaevent.effect.composed.changetrapstateeffect")
local FinishBranchEffect = require("logic.scene.luaevent.effect.basic.finishbrancheffect")
local DealyedWrapper = require("logic.scene.luaevent.effect.delayedwrapper")
EffectFactory.CreateComposedEffect = function()
  -- function num : 0_0 , upvalues : ComposedEffect
  local effect = (ComposedEffect.Create)()
  return effect
end

EffectFactory.CreateTrapComposedEffect = function()
  -- function num : 0_1 , upvalues : TrapComposedEffect
  local effect = (TrapComposedEffect.Create)()
  return effect
end

EffectFactory.CreateEffectList = function(...)
  -- function num : 0_2 , upvalues : EffectList
  local effect = (EffectList.Create)(...)
  return effect
end

EffectFactory.CreateBattleEffect = function(battleid, callback, skipfreeze, dungeonType, battleSceneId)
  -- function num : 0_3 , upvalues : BattleEffect
  local effect = (BattleEffect.Create)(battleid, callback, skipfreeze, dungeonType, battleSceneId)
  return effect
end

EffectFactory.CreateAddEventEffect = function(event)
  -- function num : 0_4 , upvalues : AddEventEffect
  local effect = (AddEventEffect.Create)(event)
  return effect
end

EffectFactory.CreateEventEffect = function(event)
  -- function num : 0_5 , upvalues : EventEffect
  local effect = (EventEffect.Create)(event)
  return effect
end

EffectFactory.CreateCustomEffect = function(callback)
  -- function num : 0_6 , upvalues : CustomEffect
  local effect = (CustomEffect.Create)(callback)
  return effect
end

EffectFactory.CreateCounterEffect = function(tag, value)
  -- function num : 0_7 , upvalues : CounterEffect
  local effect = (CounterEffect.Create)(tag, value)
  return effect
end

EffectFactory.CreateTimelineEffect = function(director, dynamic, shouldStop)
  -- function num : 0_8 , upvalues : TimeLineEffect
  local effect = (TimeLineEffect.Create)(director, dynamic, shouldStop)
  return effect
end

EffectFactory.CreatePortalTimelineEffect = function(id)
  -- function num : 0_9 , upvalues : PortalTimeLineEffect
  local effect = (PortalTimeLineEffect.Create)(id)
  return effect
end

EffectFactory.CreateVisualEffect = function(path, isShow)
  -- function num : 0_10 , upvalues : VisualEffect
  local effect = (VisualEffect.Create)(path, isShow)
  return effect
end

EffectFactory.CreateFlyToEffect = function(path, x, y, followNavMesh)
  -- function num : 0_11 , upvalues : FlyToEffect
  local effect = (FlyToEffect.Create)(path, x, y, followNavMesh)
  return effect
end

EffectFactory.CreateFlyToWorldPosEffect = function(path, x, y, z, followNavMesh)
  -- function num : 0_12 , upvalues : FlyToWorldPosEffect
  local effect = (FlyToWorldPosEffect.Create)(path, x, y, z, followNavMesh)
  return effect
end

EffectFactory.CreateMoveToEffect = function(path, velocity, x, y, followNavMesh)
  -- function num : 0_13 , upvalues : MoveToEffect
  local effect = (MoveToEffect.Create)(path, velocity, x, y, followNavMesh)
  return effect
end

EffectFactory.CreateMoveToWorldPosEffect = function(path, velocity, x, y, z, followNavMesh)
  -- function num : 0_14 , upvalues : MoveToWorldPosEffect
  local effect = (MoveToWorldPosEffect.Create)(path, velocity, x, y, z, followNavMesh)
  return effect
end

EffectFactory.CreateBlockChangeEffect = function(x, y, w, h, status, gridwidth, gridheight)
  -- function num : 0_15 , upvalues : BlockChangeEffect
  local effect = (BlockChangeEffect.Create)(x, y, w, h, status, gridwidth, gridheight)
  return effect
end

EffectFactory.CreateRemoveEventEffect = function(id)
  -- function num : 0_16 , upvalues : RemoveEventEffect
  local effect = (RemoveEventEffect.Create)(id)
  return effect
end

EffectFactory.CreateJumpBackEffect = function(type)
  -- function num : 0_17 , upvalues : JumpBackEffect
  local effect = (JumpBackEffect.Create)(type)
  return effect
end

EffectFactory.CreateAnimationEffect = function(path, animation)
  -- function num : 0_18 , upvalues : AnimationEffect
  local effect = (AnimationEffect.Create)(path, animation)
  return effect
end

EffectFactory.CreateTrapStateChangeEffect = function(trapids, switchids, mode)
  -- function num : 0_19 , upvalues : ChangeTrapStateEffect, _ENV
  local root = nil
  if mode == "seq" then
    root = ((ChangeTrapStateEffect.Sequence).Create)()
  else
    if mode == "par" or not mode then
      root = ((ChangeTrapStateEffect.Parallel).Create)()
    end
  end
  if not trapids then
    for _,v in ipairs({}) do
      local o = (TrapManager.GetTrap)(v.instance, v.id)
      root:Add(o)
    end
    do
      if not switchids then
        for _,v in ipairs({}) do
          local o = (SwitchManager.GetSwitch)(v.instance, v.id)
          root:Add(o)
        end
        local effect = (ChangeTrapStateEffect.Create)(root)
        return effect
      end
    end
  end
end

EffectFactory.CreateAnimatorStateChangeEffect = function(path, name, value, state, target)
  -- function num : 0_20 , upvalues : AnimatorStateChangeEffect
  local effect = (AnimatorStateChangeEffect.Create)(path, name, value, state, target)
  return effect
end

EffectFactory.CreateCameraMoveEffect = function(target, duration, staytime)
  -- function num : 0_21 , upvalues : CameraMoveEffect
  local effect = (CameraMoveEffect.Create)(target, duration, staytime)
  return effect
end

EffectFactory.CreateSpeedChangeEffect = function(path, speed)
  -- function num : 0_22 , upvalues : SpeedChangeEffect
  local effect = (SpeedChangeEffect.Create)(path, speed)
  return effect
end

EffectFactory.CreateDialogEffect = function(id, args)
  -- function num : 0_23 , upvalues : CreateDialogEffect
  local effect = (CreateDialogEffect.Create)(id, args)
  return effect
end

EffectFactory.CreateSkillUnlockDialogEffect = function(skillId, skillItemId, roleId)
  -- function num : 0_24 , upvalues : CreateSkillUnlockDialogEffect
  local effect = (CreateSkillUnlockDialogEffect.Create)(skillId, skillItemId, roleId)
  return effect
end

EffectFactory.CreateFreezeEffect = function(animated)
  -- function num : 0_25 , upvalues : FreezeEffect
  local effect = (FreezeEffect.Create)(animated)
  return effect
end

EffectFactory.CreateThawEffect = function(animated)
  -- function num : 0_26 , upvalues : ThawEffect
  local effect = (ThawEffect.Create)(animated)
  return effect
end

EffectFactory.CreateTrapCheckEffect = function(trapids, switchids)
  -- function num : 0_27 , upvalues : TrapCheckEffect
  local effect = (TrapCheckEffect.Create)(trapids, switchids)
  return effect
end

EffectFactory.CreateBGMEffect = function(state, bgmid)
  -- function num : 0_28 , upvalues : BgmEffect
  local effect = (BgmEffect.Create)(state, bgmid)
  return effect
end

EffectFactory.CreateDestroyEffect = function(path)
  -- function num : 0_29 , upvalues : DestroyEffect
  local effect = (DestroyEffect.Create)(path)
  return effect
end

EffectFactory.CreateAddNavMeshLinkEffect = function(...)
  -- function num : 0_30 , upvalues : NavMeshLinkEffect
  local effect = (NavMeshLinkEffect.Create)("add", ...)
  return effect
end

EffectFactory.CreateRemoveNavMeshLinkEffect = function(...)
  -- function num : 0_31 , upvalues : NavMeshLinkEffect
  local effect = (NavMeshLinkEffect.Create)("remove", ...)
  return effect
end

EffectFactory.CreateJumpEffect = function(mapid, jumppointid)
  -- function num : 0_32 , upvalues : JumpEffect
  local effect = (JumpEffect.Create)(mapid, jumppointid)
  return effect
end

EffectFactory.CreateTurnEffect = function(dir, path)
  -- function num : 0_33 , upvalues : TurnEffect
  local effect = (TurnEffect.Create)(dir, path)
  return effect
end

EffectFactory.CreateStartChatEffect = function(chatId)
  -- function num : 0_34 , upvalues : StartChatEffect
  local effect = (StartChatEffect.Create)(chatId)
  return effect
end

EffectFactory.CreateDelayEffect = function(time, context)
  -- function num : 0_35 , upvalues : DelayEffect
  local effect = (DelayEffect.Create)(time, context)
  return effect
end

EffectFactory.CreateFinishBranchEffect = function()
  -- function num : 0_36 , upvalues : FinishBranchEffect
  local effect = (FinishBranchEffect.Create)()
  return effect
end

EffectFactory.CreateDelayedWrapper = function(creator, binder)
  -- function num : 0_37 , upvalues : DealyedWrapper
  local wrapper = (DealyedWrapper.Create)(creator, binder)
  return wrapper
end

return EffectFactory

