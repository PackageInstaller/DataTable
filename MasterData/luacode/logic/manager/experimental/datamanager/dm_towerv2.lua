local DM_TowerV2 = class("DM_TowerV2")
local cstairlevelcfg = BeanManager.GetTableByName("dungeonselect.cstairlevelcfg")
local cstaireventtype = BeanManager.GetTableByName("dungeonselect.cstaireventtype")
local cstairblessingdeploy = BeanManager.GetTableByName("dungeonselect.cstairblessingdeploy")
local Item = require("logic.manager.experimental.types.item")

function DM_TowerV2:Ctor()
  self._towerInfo = NekoData.Data.towerv2
  self._towerInfo.hp = {}
end

function DM_TowerV2:Clear()
  if self._towerInfo.task then
    ServerGameTimer.RemoveTask(self._towerInfo.task)
  end
  for k, v in pairs(self._towerInfo) do
    self._towerInfo[k] = nil
  end
  self._towerInfo.hp = {}
end

function DM_TowerV2:OnSRougeTowerUpdateUnreceivedReward(protocol)
  self._towerInfo.unreceivedReward = protocol.unreceivedReward
  self._towerInfo.hasReward = 0
  for k, v in pairs(self._towerInfo.unreceivedReward) do
    self._towerInfo.hasReward = 1
    break
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshTowerV2RedPoint, nil, nil)
end

function DM_TowerV2:OnSGetTowerFloorInfo(protocol)
  self._towerInfo.autoExplore = protocol.autoExploreState == 1
  self._towerInfo.nextRefreshTime = protocol.time2reset
  local ids = cstairlevelcfg:GetAllIds()
  self._towerInfo.fresh = protocol.enterType == 0
  self._towerInfo.passedCount = protocol.passedPoints
  self._towerInfo.autoUnlocked = protocol.autoExploreUnlock == 1
  self:RefreshReached(protocol.highestPointID)
  self._towerInfo.rewardRedpoint = protocol.rewardRedPoint == 1
  self._towerInfo.hp = {}
  self:RefreshHP(protocol.rolesState)
  self._towerInfo.buffs = {}
  self:RefreshBuff(protocol.buffList)
  self._towerInfo.unreceivedReward = protocol.unreceivedReward
  self._towerInfo.hasReward = 0
  for k, v in pairs(self._towerInfo.unreceivedReward) do
    self._towerInfo.hasReward = 1
    break
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshTowerV2RedPoint, nil, nil)
  self._towerInfo.mapInfo = {}
  self._towerInfo.currentFloor = nil
  for _, v in ipairs(protocol.points) do
    local cfg = cstairlevelcfg:GetRecorder(v.pointID)
    local node = {
      id = v.pointID,
      type = cfg.typeID,
      cfg = cfg,
      state = v.pointState,
      events = {},
      buff = v.pointBuff
    }
    for i = 1, #v.pointEventsType do
      local iconcfg = cstaireventtype:GetRecorder(v.pointEventsType[i])
      local altercfg = {}
      if v.pointEventsType[i] == 4 then
        iconcfg = cstaireventtype:GetRecorder(v.pointEventsType[i])
      end
      if v.pointEventsType[i] == 9 then
      end
      node.events[i] = {
        type = v.pointEventsType[i],
        id = v.pointEventsID[i],
        assetBundle = iconcfg.assetBundle,
        assetName = iconcfg.assetName,
        alterAssetBundle = altercfg.assetBundleBattle,
        alterAssetName = altercfg.assetNameBattle
      }
    end
    if node.state ~= 2 and not self._towerInfo.currentFloor then
      self._towerInfo.currentFloor = node.id
    end
    self._towerInfo.mapInfo[#self._towerInfo.mapInfo + 1] = node
  end
  if protocol.enterType == 0 then
    self._towerInfo.state = "fresh"
  elseif protocol.enterType == 2 then
    self._towerInfo.state = "retreat"
  elseif protocol.enterType == 3 then
    self._towerInfo.state = "reset"
  elseif protocol.enterType == 4 then
    self._towerInfo.state = "buffchoose"
    self:OnSRougeTowerInitialBuffChoose({
      buff = protocol.buff4Choice
    })
    local count = table.aggregate(protocol.buffList, 0, function(seed, k, v)
      return seed + v
    end)
    self._towerInfo.buffCandidateProgress = count
  elseif not self._towerInfo.currentFloor then
    if ids[#ids] == protocol.points[#protocol.points].pointID then
      self._towerInfo.state = "complete"
    else
      self._towerInfo.state = "finished"
    end
  elseif protocol.enterType == 1 then
    self._towerInfo.state = "continue"
  end
  self._towerInfo.currentFloor = self._towerInfo.currentFloor or protocol.points[#protocol.points].pointID
  self._towerInfo.buffChances = protocol.buffNum4Reset
end

function DM_TowerV2:OnSPassFloorEndPoint(protocol)
  local items = {}
  for _, v in ipairs(protocol.receiveItems) do
    local item = Item.Create(v.id)
    item:InitWithItemInfo(v)
    items[#items + 1] = {
      item = item,
      num = item:GetCount()
    }
  end
  self._towerInfo.lastRewards = items
end

function DM_TowerV2:OnSChoosePointEvent(protocol)
  if self._towerInfo.currentFloor then
    if protocol.EventID ~= -1 then
      local index = 1
      for i, v in ipairs(self._towerInfo.mapInfo) do
        if v.id == protocol.pointID then
          index = i
          v.state = 2
          break
        end
      end
      if self._towerInfo.reachedfloorid <= self._towerInfo.currentFloor then
        self._towerInfo.passedCount = self._towerInfo.passedCount + 1
        self:RefreshReached(self._towerInfo.currentFloor)
      end
      if index + 1 > #self._towerInfo.mapInfo then
        self._towerInfo.currentFloor = self._towerInfo.mapInfo[#self._towerInfo.mapInfo].id
        self._towerInfo.state = "finished"
        for i = 1, #self._towerInfo.mapInfo - 1 do
          self._towerInfo.mapInfo[i].buff = {}
        end
      else
        self._towerInfo.currentFloor = self._towerInfo.mapInfo[index + 1].id
      end
    else
      self._towerInfo.state = "retreat"
    end
    local ids = cstairlevelcfg:GetAllIds()
    if ids[#ids] == self._towerInfo.currentFloor then
      self._towerInfo.state = "complete"
    end
    self:RefreshBuff(protocol.updateBuff)
    self:RefreshHP(protocol.rolesState)
  end
end

function DM_TowerV2:OnSReceiveTowerResetAward(protocol)
end

function DM_TowerV2:OnSUpdateTowerLineupStatue(protocol)
  self:RefreshHP(protocol.rolesState)
end

function DM_TowerV2:OnSPreviewPassedPointsReward(protocol)
  self:BuildPreviewRewards()
  self._towerInfo.rewardRedpoint = self._towerInfo.rewardRedpoint or protocol.afterBattle == 1
  for _, v in pairs(self._towerInfo.previewRewards) do
    if protocol.rewards[v.id] then
      v.got = protocol.rewards[v.id].received == 1
    elseif v.id ~= 0 then
      LogErrorFormat("towerv2", "reward level %s not found in protocol", v.pt)
    end
  end
end

function DM_TowerV2:OnSRougeTowerChoiceBuff(protocol)
  if protocol.choiceResult == 0 then
    LogError("towerv2", "invalid buff choice " .. protocol.pointID)
  end
  local config = cstairblessingdeploy:GetRecorder(protocol.choiceBuff)
  if not config then
    LogError("towerv2", "OnSRougeTowerChoiceBuff config is nil id =" .. protocol.choiceBuff)
    return
  end
  local index, v = table.first(self._towerInfo.buffs, function(k, v)
    return v.id == protocol.choiceBuff
  end)
  if v then
    v.count = (v.count or 1) + 1
  else
    self._towerInfo.buffs[#self._towerInfo.buffs + 1] = {
      id = protocol.choiceBuff,
      cfg = cstairblessingdeploy:GetRecorder(protocol.choiceBuff),
      new = true,
      count = 1
    }
  end
  table.sort(self._towerInfo.buffs, function(lhs, rhs)
    if lhs.cfg.QualityTyp > rhs.cfg.QualityTyp then
      return true
    elseif lhs.cfg.QualityTyp < rhs.cfg.QualityTyp then
      return false
    else
      return lhs.id < rhs.id
    end
  end)
  if not self._towerInfo.buffCandidates or #self._towerInfo.buffCandidates == 0 then
    for _, v in pairs(self._towerInfo.mapInfo) do
      if v.id == protocol.pointID then
        v.buff = {}
        break
      end
    end
  elseif protocol.pointID == #self._towerInfo.buffCandidates then
    self._towerInfo.buffCandidates = {}
  end
  self._towerInfo.buffRedpoint = true
end

function DM_TowerV2:OnSRougeTowerInitialBuffChoose(protocol)
  self._towerInfo.buffCandidates = {}
  self._towerInfo.buffCandidateProgress = 0
  local list = protocol.buff
  for i = 1, #list, 3 do
    local info = {
      list[i],
      list[i + 1],
      list[i + 2]
    }
    table.insert(self._towerInfo.buffCandidates, info)
  end
end

function DM_TowerV2:OnSChangeRougeTowerAutoExplore(protocol)
  self._towerInfo.autoExplore = protocol.switchState == 1
end

function DM_TowerV2:OnSReceiveTowerAward(protocol)
  if protocol.id == 0 then
    LogError("towerv2", "request award error")
    return
  end
  self._towerInfo.rewardRedpoint = false
  for _, v in pairs(self._towerInfo.previewRewards) do
    if v.id == protocol.id or v.id == 0 then
      v.got = true
    end
    self._towerInfo.rewardRedpoint = self._towerInfo.rewardRedpoint or v.pt <= self._towerInfo.passedCount and not v.got
  end
end

function DM_TowerV2:OnSRougeTowerOpenorNot(protocol)
  self._towerInfo.open = protocol.openornot == 1
  self._towerInfo.openTime = protocol.leftTime // 1000 + os.time()
  self._towerInfo.hasReward = protocol.hasReward
  if self._towerInfo.task then
    ServerGameTimer.RemoveTask(self._towerInfo.task)
  end
  self._towerInfo.task = ServerGameTimer.AddTask(protocol.leftTime // 1000, -1, function()
    NekoData.BehaviorManager.BM_TowerV2:RequestOpenState()
  end)
  LuaNotificationCenter.PostNotification(Common.n_RefreshTowerV2RedPoint, nil, nil)
end

function DM_TowerV2:RefreshReached(highest)
  self._towerInfo.reachedfloorcount = 0
  if highest ~= 0 then
    for i, v in ipairs(cstairlevelcfg:GetAllIds()) do
      if v == highest then
        self._towerInfo.reachedfloorcount = i
        break
      end
    end
  end
  self._towerInfo.reachedfloorid = highest
end

function DM_TowerV2:RefreshHP(status)
  for rolekey, hp in pairs(status) do
    if 100 < hp or hp < 0 then
      LogError("towerv2", string.format("invalid hp: %d%% @ %s", hp, rolekey))
    end
    self._towerInfo.hp[rolekey] = hp / 100
  end
end

function DM_TowerV2:RefreshBuff(buffs)
  local current = {}
  for _, v in pairs(self._towerInfo.buffs) do
    v.count = buffs[v.id] or v.count
    v.new = buffs[v.id] and buffs[v.id] ~= v.count
    current[v.id] = true
  end
  for id, count in pairs(buffs) do
    if id == 0 then
      LogError("towerv2", "invalid buff id 0")
    elseif not current[id] then
      self._towerInfo.buffs[#self._towerInfo.buffs + 1] = {
        id = id,
        count = count,
        cfg = cstairblessingdeploy:GetRecorder(id),
        new = true
      }
    end
  end
  table.sort(self._towerInfo.buffs, function(lhs, rhs)
    if lhs.cfg.QualityTyp > rhs.cfg.QualityTyp then
      return true
    elseif lhs.cfg.QualityTyp < rhs.cfg.QualityTyp then
      return false
    else
      return lhs.id < rhs.id
    end
  end)
end

function DM_TowerV2:BuildPreviewRewards()
  if not self._towerInfo.previewRewards then
    local cstairweekaward = BeanManager.GetTableByName("dungeonselect.cstairweekaward")
    local rewards = {
      {
        id = 0,
        pt = 0,
        nextpt = cstairweekaward:GetRecorder(1).pt,
        got = true
      }
    }
    local ids = cstairweekaward:GetAllIds()
    for _, i in ipairs(ids) do
      local recorder = cstairweekaward:GetRecorder(i)
      local item = Item.Create(recorder.showItem)
      item:SetCount(recorder.ItemNum)
      local info = {
        id = i,
        pt = recorder.passedPoints,
        item = item
      }
      if #rewards ~= 0 then
        info.prevpt = rewards[#rewards].pt
      end
      rewards[#rewards + 1] = info
    end
    for i, v in ipairs(rewards) do
      if rewards[i + 1] then
        v.nextpt = rewards[i + 1].pt
      end
    end
    self._towerInfo.previewRewards = rewards
  end
  return self._towerInfo.previewRewards
end

return DM_TowerV2
