-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/templates/storybattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StoryBattle = class("StoryBattle")
local Triggers = require("data.dungeondata.event.cconditionconfig")
local Effects = require("data.dungeondata.event.ceffectconfig")
StoryBattle.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : _ENV, Effects
  self._id = id
  self._cfg = ((BeanManager.GetTableByName)("event.ceventbattleconfig")):GetRecorder(id)
  self._state = -1
  self._prev = (Effects[(self._cfg).effect])()
  self._battleID = tonumber((self._cfg).battleId)
  if (self._cfg).effectRetry ~= 0 then
    self._failprev = (Effects[(self._cfg).effectRetry])()
  end
  if (self._cfg).winEffect ~= 0 then
    self._post = (Effects[(self._cfg).winEffect])()
  end
  if (self._cfg).failEternalEffect ~= 0 then
    self._failpersist = (Effects[(self._cfg).failEternalEffect])()
  end
  if (self._cfg).winEternalEffect ~= 0 then
    self._succpersist = (Effects[(self._cfg).winEternalEffect])()
  end
  self._events = {}
end

StoryBattle.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs(self._events) do
    (EventManager.RemoveEvent)(v:GetID())
  end
  self._events = {}
end

StoryBattle.GetState = function(self)
  -- function num : 0_2
  return self._state
end

local add_init_event = function(self)
  -- function num : 0_3 , upvalues : _ENV, Triggers, add_init_event
  local event = (EventManager.CreateEvent)()
  self._cond = (Triggers[(self._cfg).condition])(event:GetID())
  event:AddTrigger((self._cond):GetType(), self._cond)
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_3_0 , upvalues : self, _ENV, add_init_event
    if (self._cfg).retreat ~= 0 then
      local func1 = function()
      -- function num : 0_3_0_0 , upvalues : _ENV, self
      ((EffectFactory.CreateThawEffect)()):Run()
      self:ToNextState()
    end

      local func2 = function()
      -- function num : 0_3_0_1 , upvalues : _ENV, self, add_init_event
      local root = (EffectFactory.CreateComposedEffect)()
      root:AddEffect((EffectFactory.CreateTimelineEffect)((self._cfg).retreat))
      root:AddEffect((EffectFactory.CreateCustomEffect)(function()
        -- function num : 0_3_0_1_0 , upvalues : add_init_event, self
        add_init_event(self)
      end
))
      root:AddEffect((EffectFactory.CreateThawEffect)())
      root:Run()
    end

      ;
      ((EffectFactory.CreateFreezeEffect)()):Run()
      if (self._cfg).minBreakLevel > 0 then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(39, {(self._cfg).minBreakLevel, (self._cfg).minRoleLevel}, func1, nil, func2, nil)
      else
        ;
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(112, {(self._cfg).minRoleLevel}, func1, nil, func2, nil)
      end
    else
      do
        self:ToNextState()
      end
    end
  end
))
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._events)[1] = event
  ;
  (EventManager.AddEvent)((self._events)[1])
end

local add_reinit_event = function(self)
  -- function num : 0_4 , upvalues : _ENV, Triggers, add_reinit_event
  local event = (EventManager.CreateEvent)()
  self._cond = (Triggers[(self._cfg).conditionRetry])(event:GetID())
  event:AddTrigger((self._cond):GetType(), self._cond)
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_0 , upvalues : self, _ENV, add_reinit_event
    if (self._cfg).retreat ~= 0 then
      local func1 = function()
      -- function num : 0_4_0_0 , upvalues : self
      self:ToNextState()
    end

      local func2 = function()
      -- function num : 0_4_0_1 , upvalues : _ENV, self, add_reinit_event
      local root = (EffectFactory.CreateComposedEffect)()
      root:AddEffect((EffectFactory.CreateTimelineEffect)((self._cfg).retreat))
      root:AddEffect((EffectFactory.CreateCustomEffect)(function()
        -- function num : 0_4_0_1_0 , upvalues : add_reinit_event, self
        add_reinit_event(self)
      end
))
      root:AddEffect((EffectFactory.CreateThawEffect)())
      root:Run()
    end

      ;
      ((EffectFactory.CreateFreezeEffect)()):Run()
      if (self._cfg).minBreakLevel > 0 then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(39, {(self._cfg).minBreakLevel, (self._cfg).minRoleLevel}, func1, nil, func2, nil)
      else
        ;
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(112, {(self._cfg).minRoleLevel}, func1, nil, func2, nil)
      end
    else
      do
        self:ToNextState()
      end
    end
  end
))
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._events)[5] = event
  ;
  (EventManager.AddEvent)((self._events)[5])
end

StoryBattle.Init = function(self, state)
  -- function num : 0_5
  if (self._cfg).battleStartOnEnter == 1 and (state == 5 or state == 6) then
    self:ToNextState()
  else
    self:Load(state)
  end
end

StoryBattle.Load = function(self, state)
  -- function num : 0_6 , upvalues : add_init_event, _ENV, add_reinit_event
  if state == self._state then
    return 
  end
  if state == 0 then
    add_init_event(self)
  else
    if state == 1 then
      local root = (EffectFactory.CreateComposedEffect)()
      root:AddEffect((EffectFactory.CreateFreezeEffect)())
      root:AddEffect(self._prev)
      root:AddEffect((EffectFactory.CreateBattleEffect)(self._battleID))
      root:Run()
    else
    end
  end
  do
    if state ~= 2 or state == 3 then
      ((EffectFactory.CreateThawEffect)()):Run()
      local root = (EffectFactory.CreateComposedEffect)()
      if self._succpersist then
        root:AddEffect(self._succpersist)
      end
      if self._post then
        root:AddEffect(self._post)
      end
      root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_6_0 , upvalues : self
    self:ToNextState()
  end
))
      if self._state == 2 then
        local event = (EventManager.CreateEvent)()
        local trigger = (TriggerManager.CreateTrigger)("battleend", (event:GetID()), nil, "Success", "AfterReturn")
        event:AddTrigger(trigger:GetType(), trigger)
        event:AddEffect(root)
        ;
        (EventManager.AddEvent)(event)
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (self._events)[3] = event
      else
        do
          do
            root:Run()
            -- DECOMPILER ERROR at PC106: Unhandled construct in 'MakeBoolean' P1

            if state == 4 and self._state ~= 3 and self._succpersist then
              (self._succpersist):Run()
            end
            if state == 5 then
              if self._failpersist then
                (self._failpersist):Run()
              end
              add_reinit_event(self)
            else
              if state == 6 then
                local root = (EffectFactory.CreateComposedEffect)()
                if self._failprev then
                  root:AddEffect(self._failprev)
                end
                root:AddEffect((EffectFactory.CreateBattleEffect)(self._battleID))
                root:Run()
              end
            end
            do
              ;
              (LuaNotificationCenter.PostNotification)(Common.n_StoryBattleProceed, self, self._id)
              self._state = state
            end
          end
        end
      end
    end
  end
end

StoryBattle.ToNextState = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cmodule")
  req.id = self._id
  req:Send()
end

StoryBattle.GetMinimapPosition = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local pos = (string.split)((self._cfg).coordinate, ",")
  return {x = tonumber(pos[1]), y = tonumber(pos[2])}
end

StoryBattle.GetMinimapIcon = function(self)
  -- function num : 0_9
  return (self._cfg).imageId
end

StoryBattle.ShowInMinimap = function(self)
  -- function num : 0_10
  do return (self._cfg).isShowMinimapIcon == 1 and self._state ~= 4 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return StoryBattle

