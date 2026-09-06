local DM_Children = class("DM_Children")

function DM_Children:Ctor()
  self._children = NekoData.Data.activities.children
  self._children.taskFinish = false
  self._children.leftTimes = {}
  self._children.awards = {}
  self._children.score = 0
  self._children.init = true
end

function DM_Children:Clear()
  self._children.taskFinish = false
  self._children.leftTimes = {}
  self._children.awards = {}
  self._children.score = 0
  self._children.init = true
end

function DM_Children:OnClientGetInfo(protocol)
  if self._children.init then
    self._children.init = false
  end
  self._children.taskFinish = protocol.taskFinishLeft <= 0
  self._children.awards = protocol.awards
  self._children.leftTimes = protocol.leftTimes
  self._children.score = protocol.score
  if self._timers then
    self._timers = ServerGameTimer.RemoveTask(self._timers)
  end
  if protocol.taskFinishLeft > 0 then
    self._timers = ServerGameTimer.AddTask(protocol.taskFinishLeft // 1000, 0, function()
      self._timers = nil
      self._children.taskFinish = true
      LuaNotificationCenter.PostNotification(Common.n_SRefreshChildrenInfo, nil, protocol)
    end)
  end
end

return DM_Children
