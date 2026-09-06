local StoryBattle = class("StoryBattle")
local Triggers = require("data.dungeondata.event.cconditionconfig")
local Effects = require("data.dungeondata.event.ceffectconfig")

function StoryBattle:Ctor(id)
  self._id = id
  self._cfg = BeanManager.GetTableByName("event.ceventbattleconfig"):GetRecorder(id)
  self._state = -1
  self._prev = Effects[self._cfg.effect]()
  self._battleID = tonumber(self._cfg.battleId)
  if self._cfg.effectRetry ~= 0 then
    self._failprev = Effects[self._cfg.effectRetry]()
  end
  if self._cfg.winEffect ~= 0 then
    self._post = Effects[self._cfg.winEffect]()
  end
  if self._cfg.failEternalEffect ~= 0 then
    self._failpersist = Effects[self._cfg.failEternalEffect]()
  end
  if self._cfg.winEternalEffect ~= 0 then
    self._succpersist = Effects[self._cfg.winEternalEffect]()
  end
  self._events = {}
end

function StoryBattle:Destroy()
  for _, v in pairs(self._events) do
    EventManager.RemoveEvent(v:GetID())
  end
  self._events = {}
end

function StoryBattle:GetState()
  return self._state
end

local function add_init_event(self)
  local event = EventManager.CreateEvent()
  self._cond = Triggers[self._cfg.condition](event:GetID())
  event:AddTrigger(self._cond:GetType(), self._cond)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    if self._cfg.retreat ~= 0 then
      local function func1()
        EffectFactory.CreateThawEffect():Run()
        
        self:ToNextState()
      end
      
      local function func2()
        local root = EffectFactory.CreateComposedEffect()
        root:AddEffect(EffectFactory.CreateTimelineEffect(self._cfg.retreat))
        root:AddEffect(EffectFactory.CreateCustomEffect(function()
          add_init_event(self)
        end))
        root:AddEffect(EffectFactory.CreateThawEffect())
        root:Run()
      end
      
      EffectFactory.CreateFreezeEffect():Run()
      if 0 < self._cfg.minBreakLevel then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(39, {
          self._cfg.minBreakLevel,
          self._cfg.minRoleLevel
        }, func1, nil, func2, nil)
      else
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(112, {
          self._cfg.minRoleLevel
        }, func1, nil, func2, nil)
      end
    else
      self:ToNextState()
    end
  end))
  self._events[1] = event
  EventManager.AddEvent(self._events[1])
end

local function add_reinit_event(self)
  local event = EventManager.CreateEvent()
  self._cond = Triggers[self._cfg.conditionRetry](event:GetID())
  event:AddTrigger(self._cond:GetType(), self._cond)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    if self._cfg.retreat ~= 0 then
      local function func1()
        self:ToNextState()
      end
      
      local function func2()
        local root = EffectFactory.CreateComposedEffect()
        root:AddEffect(EffectFactory.CreateTimelineEffect(self._cfg.retreat))
        root:AddEffect(EffectFactory.CreateCustomEffect(function()
          add_reinit_event(self)
        end))
        root:AddEffect(EffectFactory.CreateThawEffect())
        root:Run()
      end
      
      EffectFactory.CreateFreezeEffect():Run()
      if 0 < self._cfg.minBreakLevel then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(39, {
          self._cfg.minBreakLevel,
          self._cfg.minRoleLevel
        }, func1, nil, func2, nil)
      else
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(112, {
          self._cfg.minRoleLevel
        }, func1, nil, func2, nil)
      end
    else
      self:ToNextState()
    end
  end))
  self._events[5] = event
  EventManager.AddEvent(self._events[5])
end

function StoryBattle:Init(state)
  if self._cfg.battleStartOnEnter == 1 and (state == 5 or state == 6) then
    self:ToNextState()
  else
    self:Load(state)
  end
end

function StoryBattle:Load(state)
  if state == self._state then
    return
  end
  if state == 0 then
    add_init_event(self)
  elseif state == 1 then
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(EffectFactory.CreateFreezeEffect())
    root:AddEffect(self._prev)
    root:AddEffect(EffectFactory.CreateBattleEffect(self._battleID))
    root:Run()
  elseif state == 2 then
  elseif state == 3 then
    EffectFactory.CreateThawEffect():Run()
    local root = EffectFactory.CreateComposedEffect()
    if self._succpersist then
      root:AddEffect(self._succpersist)
    end
    if self._post then
      root:AddEffect(self._post)
    end
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      self:ToNextState()
    end))
    if self._state == 2 then
      local event = EventManager.CreateEvent()
      local trigger = TriggerManager.CreateTrigger("battleend", event:GetID(), nil, "Success", "AfterReturn")
      event:AddTrigger(trigger:GetType(), trigger)
      event:AddEffect(root)
      EventManager.AddEvent(event)
      self._events[3] = event
    else
      root:Run()
    end
  elseif state == 4 then
    if self._state ~= 3 and self._succpersist then
      self._succpersist:Run()
    end
  elseif state == 5 then
    if self._failpersist then
      self._failpersist:Run()
    end
    add_reinit_event(self)
  elseif state == 6 then
    local root = EffectFactory.CreateComposedEffect()
    if self._failprev then
      root:AddEffect(self._failprev)
    end
    root:AddEffect(EffectFactory.CreateBattleEffect(self._battleID))
    root:Run()
  end
  LuaNotificationCenter.PostNotification(Common.n_StoryBattleProceed, self, self._id)
  self._state = state
end

function StoryBattle:ToNextState()
  local req = LuaNetManager.CreateProtocol("protocol.battle.cmodule")
  req.id = self._id
  req:Send()
end

function StoryBattle:GetMinimapPosition()
  local pos = string.split(self._cfg.coordinate, ",")
  return {
    x = tonumber(pos[1]),
    y = tonumber(pos[2])
  }
end

function StoryBattle:GetMinimapIcon()
  return self._cfg.imageId
end

function StoryBattle:ShowInMinimap()
  return self._cfg.isShowMinimapIcon == 1 and self._state ~= 4
end

return StoryBattle
