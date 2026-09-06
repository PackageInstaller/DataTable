local DM_Sign = class("DM_Sign")

function DM_Sign:Ctor()
  self._data = NekoData.Data.activities.sign
  self._data.signActivity = {}
  self._data.signActivityState = false
  self._data.returnsignActivityState = false
end

function DM_Sign:Clear()
  self._data.signActivity = {}
  self._data.signActivityState = false
  self._data.returnsignActivityState = false
end

function DM_Sign:OnSSignActivity(protocol)
  local activity = self._data.signActivity[protocol.actId]
  if not activity then
    local awards = {}
    for index, award in ipairs(protocol.awards) do
      table.insert(awards, {
        itemId = award.itemId,
        itemNum = award.itemNum,
        receive = award.receive == 1,
        index = index
      })
    end
    self._data.signActivity[protocol.actId] = {
      id = protocol.actId,
      awards = awards,
      totalSignNum = protocol.totalSignNum
    }
    local CWelfareTabCfg = BeanManager.GetTableByName("welfare.cwelfaretabconfig")
    if CWelfareTabCfg:GetRecorder(protocol.actId) then
      self._data.signActivity[protocol.actId].iswelfare = true
    else
      self._data.signActivity[protocol.actId].iswelfare = false
    end
  else
    activity.awards = {}
    for index, award in ipairs(protocol.awards) do
      table.insert(activity.awards, {
        itemId = award.itemId,
        itemNum = award.itemNum,
        receive = award.receive == 1,
        index = index
      })
    end
    activity.totalSignNum = protocol.totalSignNum
  end
  self:RefreshSignActivityState()
end

function DM_Sign:OnSReceiveAward(protocol)
  local act = self._data.signActivity[protocol.actId]
  if act then
    for i, v in ipairs(protocol.index) do
      local award = act.awards[v]
      if award then
        award.receive = true
      else
        LogErrorFormat("DM_Sign", "awardIndex = %s does not exist!", v)
      end
    end
  else
    LogErrorFormat("DM_Sign", "actId = %s does not exist!", protocol.actId)
  end
  self:RefreshSignActivityState()
end

function DM_Sign:RefreshSignActivityState()
  self._data.signActivityState = false
  for _, activity in pairs(self._data.signActivity) do
    if activity.iswelfare then
      for _, award in ipairs(activity.awards) do
        if award.index <= activity.totalSignNum and not award.receive then
          self._data.signActivityState = true
          break
        end
      end
      if self._data.signActivityState then
        break
      end
    end
  end
  self._data.returnsignActivityState = false
  for _, activity in pairs(self._data.signActivity) do
    if not activity.iswelfare then
      for _, award in ipairs(activity.awards) do
        if award.index <= activity.totalSignNum and not award.receive then
          self._data.returnsignActivityState = true
          break
        end
      end
      if self._data.returnsignActivityState then
        break
      end
    end
  end
end

function DM_Sign:OnSSignCrossDay(activityId)
  self._data.signActivity[activityId] = nil
  self:RefreshSignActivityState()
end

return DM_Sign
