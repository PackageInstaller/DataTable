-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_children.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Children = class("DM_Children")
DM_Children.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._children = ((NekoData.Data).activities).children
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).taskFinish = false
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).leftTimes = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).awards = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).score = 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).init = true
end

DM_Children.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._children).taskFinish = false
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).leftTimes = {}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).awards = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).score = 0
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._children).init = true
end

DM_Children.OnClientGetInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if (self._children).init then
    (self._children).init = false
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._children).taskFinish = protocol.taskFinishLeft <= 0
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._children).awards = protocol.awards
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._children).leftTimes = protocol.leftTimes
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._children).score = protocol.score
  if self._timers then
    self._timers = (ServerGameTimer.RemoveTask)(self._timers)
  end
  if protocol.taskFinishLeft > 0 then
    self._timers = (ServerGameTimer.AddTask)(protocol.taskFinishLeft // 1000, 0, function()
    -- function num : 0_2_0 , upvalues : self, _ENV, protocol
    self._timers = nil
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self._children).taskFinish = true
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SRefreshChildrenInfo, nil, protocol)
  end
)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return DM_Children

