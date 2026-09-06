local DM_Counter = class("DM_Counter")

function DM_Counter:Ctor()
  self._counter = NekoData.Data.counter
  LuaNotificationCenter.AddObserver(self, self.OnBattleEnd, Common.n_BattleEnd, nil)
end

function DM_Counter:Clear()
  if self._counter then
    for k, v in pairs(self._counter) do
      self._counter[k] = nil
    end
  end
end

function DM_Counter:ChangeCounter(tag, num)
  self._counter[tag] = (self._counter[tag] or 0) + num
end

function DM_Counter:FindCounter(tag)
  return self._counter[tag]
end

function DM_Counter:OnBattleEnd(notification)
  self._counter.battle = (self._counter.battle or 0) + 1
end

return DM_Counter
