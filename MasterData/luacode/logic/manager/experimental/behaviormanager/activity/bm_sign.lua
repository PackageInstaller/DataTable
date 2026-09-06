local BM_Sign = class("BM_Sign")

function BM_Sign:Ctor()
  self._data = NekoData.Data.activities.sign
end

function BM_Sign:GetSignActivityState()
  return self._data.signActivityState
end

function BM_Sign:GetReturnActivityState()
  return self._data.returnsignActivityState
end

function BM_Sign:ShowWelfareEntrance_Sign()
  for _, activity in pairs(self._data.signActivity) do
    if activity.iswelfare then
      for i, award in ipairs(activity.awards) do
        if not award.receive then
          return true
        end
      end
    end
  end
end

function BM_Sign:ShowReturnWelfareEntrance_Sign()
  for _, activity in pairs(self._data.signActivity) do
    if not activity.iswelfare then
      for i, award in ipairs(activity.awards) do
        if not award.receive then
          return true
        end
      end
    end
  end
end

function BM_Sign:GetSignActivities()
  local list = {}
  for _, activity in pairs(self._data.signActivity) do
    if activity.iswelfare then
      table.insert(list, activity)
    end
  end
  return list
end

function BM_Sign:GetReturnSignActivities()
  local list = {}
  for _, activity in pairs(self._data.signActivity) do
    if not activity.iswelfare then
      table.insert(list, activity)
    end
  end
  return list
end

function BM_Sign:GetSignActivityById(id)
  return self._data.signActivity[id]
end

return BM_Sign
