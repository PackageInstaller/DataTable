-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/battleeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonType = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
local CEVENTLIST = (BeanManager.GetTableByName)("dungeonselect.ceventlist")
local summeractivityEvents = (CEVENTLIST:GetRecorder((DataCommon.Activities).SwimSuit)).levenid
local christmasactivityEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).Christmas)).levenid
local loveractivityEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).Lover)).levenid
local anniversaryEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).Anniversary)).levenid
local starryirrorEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).StarMirage)).levenid
local starryirrorcopyEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).StarMirageCopy)).levenid
local summerechoesEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).SummerEchoes)).levenid
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local BattleEffect = class("BattleEffect", EffectBase)
BattleEffect.Ctor = function(self, id, callback, skipfreeze, dungeonType, battleSceneId)
  -- function num : 0_0
  self._id = id
  self._callback = callback
  self._freeze = not skipfreeze
  self._dungeonType = dungeonType
  self._battleSceneId = battleSceneId or 0
end

BattleEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV, DungeonType, summeractivityEvents, loveractivityEvent, christmasactivityEvent, starryirrorEvent, anniversaryEvent, starryirrorcopyEvent, summerechoesEvent
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
  if self._dungeonType and self._dungeonType == DungeonType.RESOURCE then
    req.battleType = req.RESOURCE
  else
    if self._dungeonType and self._dungeonType == DungeonType.ACTIVITY then
      if (table.contain)(summeractivityEvents, self._id) then
        req.battleType = req.SUMMER
      else
        if (table.contain)(loveractivityEvent, self._id) then
          req.battleType = req.LOVER
        else
          if (table.contain)(christmasactivityEvent, self._id) then
            req.battleType = req.CHRISTMAS
          else
            if (table.contain)(starryirrorEvent, self._id) then
              req.battleType = req.STARRY
            else
              if (table.contain)(anniversaryEvent, self._id) then
                req.battleType = req.ANNIVERSARY
              else
                if (table.contain)(starryirrorcopyEvent, self._id) then
                  req.battleType = req.STARRY_MIRROR
                else
                  if (table.contain)(summerechoesEvent, self._id) then
                    req.battleType = req.SUMMER_ECHO
                  end
                end
              end
            end
          end
        end
      end
    else
      req.battleType = req.DUNGEON
    end
  end
  req.id = self._id
  req.battleSceneId = self._battleSceneId
  req:Send()
  if self._freeze then
    ((EffectFactory.CreateFreezeEffect)()):Run()
  end
  local dungeon_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  dungeon_controller:StopWalking()
  local battleendevent = (EventManager.CreateEvent)()
  local betrigger = (TriggerManager.CreateTrigger)("battleend", (battleendevent:GetID()), nil, nil, "AfterReturn")
  battleendevent:AddTrigger("battleend", betrigger)
  local customeffect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_0 , upvalues : _ENV, self
    LogWarning("event", "post battle event fired")
    if self._callback then
      (self._callback)()
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  end
)
  battleendevent:AddEffect(customeffect)
  ;
  (EventManager.AddEvent)(battleendevent)
end

return BattleEffect

