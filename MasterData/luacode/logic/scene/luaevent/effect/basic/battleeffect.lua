local DungeonType = LuaNetManager.CreateBean("protocol.battle.dungeontype")
local CEVENTLIST = BeanManager.GetTableByName("dungeonselect.ceventlist")
local summeractivityEvents = CEVENTLIST:GetRecorder(DataCommon.Activities.SwimSuit).levenid
local christmasactivityEvent = CEVENTLIST:GetRecorder(DataCommon.Activities.Christmas).levenid
local loveractivityEvent = CEVENTLIST:GetRecorder(DataCommon.Activities.Lover).levenid
local anniversaryEvent = CEVENTLIST:GetRecorder(DataCommon.Activities.Anniversary).levenid
local starryirrorEvent = CEVENTLIST:GetRecorder(DataCommon.Activities.StarMirage).levenid
local starryirrorcopyEvent = CEVENTLIST:GetRecorder(DataCommon.Activities.StarMirageCopy).levenid
local summerechoesEvent = CEVENTLIST:GetRecorder(DataCommon.Activities.SummerEchoes).levenid
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local BattleEffect = class("BattleEffect", EffectBase)

function BattleEffect:Ctor(id, callback, skipfreeze, dungeonType, battleSceneId)
  self._id = id
  self._callback = callback
  self._freeze = not skipfreeze
  self._dungeonType = dungeonType
  self._battleSceneId = battleSceneId or 0
end

function BattleEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local req = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
  if self._dungeonType and self._dungeonType == DungeonType.RESOURCE then
    req.battleType = req.RESOURCE
  elseif self._dungeonType and self._dungeonType == DungeonType.ACTIVITY then
    if table.contain(summeractivityEvents, self._id) then
      req.battleType = req.SUMMER
    elseif table.contain(loveractivityEvent, self._id) then
      req.battleType = req.LOVER
    elseif table.contain(christmasactivityEvent, self._id) then
      req.battleType = req.CHRISTMAS
    elseif table.contain(starryirrorEvent, self._id) then
      req.battleType = req.STARRY
    elseif table.contain(anniversaryEvent, self._id) then
      req.battleType = req.ANNIVERSARY
    elseif table.contain(starryirrorcopyEvent, self._id) then
      req.battleType = req.STARRY_MIRROR
    elseif table.contain(summerechoesEvent, self._id) then
      req.battleType = req.SUMMER_ECHO
    end
  else
    req.battleType = req.DUNGEON
  end
  req.id = self._id
  req.battleSceneId = self._battleSceneId
  req:Send()
  if self._freeze then
    EffectFactory.CreateFreezeEffect():Run()
  end
  local dungeon_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  dungeon_controller:StopWalking()
  local battleendevent = EventManager.CreateEvent()
  local betrigger = TriggerManager.CreateTrigger("battleend", battleendevent:GetID(), nil, nil, "AfterReturn")
  battleendevent:AddTrigger("battleend", betrigger)
  local customeffect = EffectFactory.CreateCustomEffect(function()
    LogWarning("event", "post battle event fired")
    if self._callback then
      self._callback()
    end
    LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  end)
  battleendevent:AddEffect(customeffect)
  EventManager.AddEvent(battleendevent)
end

return BattleEffect
