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

function EffectFactory.CreateComposedEffect()
  local effect = ComposedEffect.Create()
  return effect
end

function EffectFactory.CreateTrapComposedEffect()
  local effect = TrapComposedEffect.Create()
  return effect
end

function EffectFactory.CreateEffectList(...)
  local effect = EffectList.Create(...)
  return effect
end

function EffectFactory.CreateBattleEffect(battleid, callback, skipfreeze, dungeonType, battleSceneId)
  local effect = BattleEffect.Create(battleid, callback, skipfreeze, dungeonType, battleSceneId)
  return effect
end

function EffectFactory.CreateAddEventEffect(event)
  local effect = AddEventEffect.Create(event)
  return effect
end

function EffectFactory.CreateEventEffect(event)
  local effect = EventEffect.Create(event)
  return effect
end

function EffectFactory.CreateCustomEffect(callback)
  local effect = CustomEffect.Create(callback)
  return effect
end

function EffectFactory.CreateCounterEffect(tag, value)
  local effect = CounterEffect.Create(tag, value)
  return effect
end

function EffectFactory.CreateTimelineEffect(director, dynamic, shouldStop)
  local effect = TimeLineEffect.Create(director, dynamic, shouldStop)
  return effect
end

function EffectFactory.CreatePortalTimelineEffect(id)
  local effect = PortalTimeLineEffect.Create(id)
  return effect
end

function EffectFactory.CreateVisualEffect(path, isShow)
  local effect = VisualEffect.Create(path, isShow)
  return effect
end

function EffectFactory.CreateFlyToEffect(path, x, y, followNavMesh)
  local effect = FlyToEffect.Create(path, x, y, followNavMesh)
  return effect
end

function EffectFactory.CreateFlyToWorldPosEffect(path, x, y, z, followNavMesh)
  local effect = FlyToWorldPosEffect.Create(path, x, y, z, followNavMesh)
  return effect
end

function EffectFactory.CreateMoveToEffect(path, velocity, x, y, followNavMesh)
  local effect = MoveToEffect.Create(path, velocity, x, y, followNavMesh)
  return effect
end

function EffectFactory.CreateMoveToWorldPosEffect(path, velocity, x, y, z, followNavMesh)
  local effect = MoveToWorldPosEffect.Create(path, velocity, x, y, z, followNavMesh)
  return effect
end

function EffectFactory.CreateBlockChangeEffect(x, y, w, h, status, gridwidth, gridheight)
  local effect = BlockChangeEffect.Create(x, y, w, h, status, gridwidth, gridheight)
  return effect
end

function EffectFactory.CreateRemoveEventEffect(id)
  local effect = RemoveEventEffect.Create(id)
  return effect
end

function EffectFactory.CreateJumpBackEffect(type)
  local effect = JumpBackEffect.Create(type)
  return effect
end

function EffectFactory.CreateAnimationEffect(path, animation)
  local effect = AnimationEffect.Create(path, animation)
  return effect
end

function EffectFactory.CreateTrapStateChangeEffect(trapids, switchids, mode)
  local root
  if mode == "seq" then
    root = ChangeTrapStateEffect.Sequence.Create()
  elseif mode == "par" or not mode then
    root = ChangeTrapStateEffect.Parallel.Create()
  end
  for _, v in ipairs(trapids or {}) do
    local o = TrapManager.GetTrap(v.instance, v.id)
    root:Add(o)
  end
  for _, v in ipairs(switchids or {}) do
    local o = SwitchManager.GetSwitch(v.instance, v.id)
    root:Add(o)
  end
  local effect = ChangeTrapStateEffect.Create(root)
  return effect
end

function EffectFactory.CreateAnimatorStateChangeEffect(path, name, value, state, target)
  local effect = AnimatorStateChangeEffect.Create(path, name, value, state, target)
  return effect
end

function EffectFactory.CreateCameraMoveEffect(target, duration, staytime)
  local effect = CameraMoveEffect.Create(target, duration, staytime)
  return effect
end

function EffectFactory.CreateSpeedChangeEffect(path, speed)
  local effect = SpeedChangeEffect.Create(path, speed)
  return effect
end

function EffectFactory.CreateDialogEffect(id, args)
  local effect = CreateDialogEffect.Create(id, args)
  return effect
end

function EffectFactory.CreateSkillUnlockDialogEffect(skillId, skillItemId, roleId)
  local effect = CreateSkillUnlockDialogEffect.Create(skillId, skillItemId, roleId)
  return effect
end

function EffectFactory.CreateFreezeEffect(animated)
  local effect = FreezeEffect.Create(animated)
  return effect
end

function EffectFactory.CreateThawEffect(animated)
  local effect = ThawEffect.Create(animated)
  return effect
end

function EffectFactory.CreateTrapCheckEffect(trapids, switchids)
  local effect = TrapCheckEffect.Create(trapids, switchids)
  return effect
end

function EffectFactory.CreateBGMEffect(state, bgmid)
  local effect = BgmEffect.Create(state, bgmid)
  return effect
end

function EffectFactory.CreateDestroyEffect(path)
  local effect = DestroyEffect.Create(path)
  return effect
end

function EffectFactory.CreateAddNavMeshLinkEffect(...)
  local effect = NavMeshLinkEffect.Create("add", ...)
  return effect
end

function EffectFactory.CreateRemoveNavMeshLinkEffect(...)
  local effect = NavMeshLinkEffect.Create("remove", ...)
  return effect
end

function EffectFactory.CreateJumpEffect(mapid, jumppointid)
  local effect = JumpEffect.Create(mapid, jumppointid)
  return effect
end

function EffectFactory.CreateTurnEffect(dir, path)
  local effect = TurnEffect.Create(dir, path)
  return effect
end

function EffectFactory.CreateStartChatEffect(chatId)
  local effect = StartChatEffect.Create(chatId)
  return effect
end

function EffectFactory.CreateDelayEffect(time, context)
  local effect = DelayEffect.Create(time, context)
  return effect
end

function EffectFactory.CreateFinishBranchEffect()
  local effect = FinishBranchEffect.Create()
  return effect
end

function EffectFactory.CreateDelayedWrapper(creator, binder)
  local wrapper = DealyedWrapper.Create(creator, binder)
  return wrapper
end

return EffectFactory
