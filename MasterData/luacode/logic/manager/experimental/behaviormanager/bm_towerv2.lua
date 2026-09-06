local BM_TowerV2 = class("BM_TowerV2")
local cstairlevelcfg = BeanManager.GetTableByName("dungeonselect.cstairlevelcfg")
local cstairvarcfg = BeanManager.GetTableByName("dungeonselect.cstairvarcfg")
local cstairbackconfig = BeanManager.GetTableByName("dungeonselect.cstairbackconfig")

function BM_TowerV2:Ctor()
  self._towerInfo = NekoData.Data.towerv2
end

function BM_TowerV2:IsFreshStart()
  return self._towerInfo.fresh
end

function BM_TowerV2:GetPassedCount()
  return self._towerInfo.passedCount
end

function BM_TowerV2:GetReachedFloorID()
  return self._towerInfo.reachedfloorid
end

function BM_TowerV2:GetReachedCount()
  return self._towerInfo.reachedfloorcount
end

function BM_TowerV2:GetCurrentFloorID()
  return self._towerInfo.currentFloor
end

function BM_TowerV2:GetCurrentFloorIndex()
  local index, _ = table.first(self._towerInfo.mapInfo, function(k, v)
    return v.id == self._towerInfo.currentFloor
  end)
  return index
end

function BM_TowerV2:GetFloorCount()
  return table.nums(self._towerInfo.mapInfo)
end

function BM_TowerV2:GetLastRewards()
  return self._towerInfo.lastRewards
end

function BM_TowerV2:GetBuffs()
  return self._towerInfo.buffs
end

function BM_TowerV2:GetUnreceivedReward()
  return self._towerInfo.unreceivedReward
end

function BM_TowerV2:GetInitBuffCandidates()
  return self._towerInfo.buffCandidates
end

function BM_TowerV2:GetInitBuffProgress()
  return self._towerInfo.buffCandidateProgress
end

function BM_TowerV2:GetLastBuffCandidates()
  local _, info = table.first(self._towerInfo.mapInfo, function(k, v)
    return #v.buff ~= 0
  end)
  if info then
    return info.id, {
      info.buff
    }
  end
end

function BM_TowerV2:GetInitBuffChances()
  return self._towerInfo.buffChances
end

function BM_TowerV2:GetFloorTotalCount()
  return #cstairlevelcfg:GetAllIds()
end

function BM_TowerV2:GetCurrentFloorInfo()
  local _, info = table.first(self._towerInfo.mapInfo, function(k, v)
    return v.id == self._towerInfo.currentFloor
  end)
  return info
end

function BM_TowerV2:GetFloorInfoByID(id)
  local _, info = table.first(self._towerInfo.mapInfo, function(k, v)
    return v.id == id
  end)
  return info
end

function BM_TowerV2:GetNextWorld(floorid)
  floorid = floorid or self:GetCurrentFloorID()
  local n
  for _, i in ipairs(cstairlevelcfg:GetAllIds()) do
    local recorder = cstairlevelcfg:GetRecorder(i)
    if n then
      return tonumber(recorder.world)
    end
    n = recorder.id == floorid
  end
end

function BM_TowerV2:GetFloorInfoByIndex(index)
  return self._towerInfo.mapInfo[index]
end

function BM_TowerV2:GetRoleHP(roleid)
  return self._towerInfo.hp[roleid] or 1
end

function BM_TowerV2:CheckTeamHP()
  local bm_team = NekoData.BehaviorManager.BM_Team
  local list = bm_team:GetTowerTeamsInfo()[bm_team:GetTowerCurrentTeamId()]
  return not table.any(list.roles, function(k, v)
    return v and v ~= 0 and self:GetRoleHP(v) == 0
  end)
end

function BM_TowerV2:GetStartStair(levelid)
  return cstairlevelcfg:GetRecorder(levelid).continueAsset
end

function BM_TowerV2:GetRetreatStair(levelid)
  local ids = cstairlevelcfg:GetAllIds()
  for i = levelid - 1, ids[1], -1 do
    local recorder = cstairlevelcfg:GetRecorder(i)
    if recorder and recorder.typeID == 4 then
      return recorder.startAsset
    end
  end
  return tonumber(cstairvarcfg:GetRecorder(2).value)
end

function BM_TowerV2:GetFinishStair(levelid)
  local ids = cstairlevelcfg:GetAllIds()
  for i = levelid, ids[1], -1 do
    local recorder = cstairlevelcfg:GetRecorder(i)
    if recorder and recorder.typeID == 4 then
      return recorder.startAsset
    end
  end
  return tonumber(cstairvarcfg:GetRecorder(2).value)
end

function BM_TowerV2:IsReachedBossStair()
  local bossStair = tonumber(cstairvarcfg:GetRecorder(12).value)
  if bossStair <= self._towerInfo.currentFloor then
    return true
  end
  return false
end

function BM_TowerV2:GetBossRetryStair()
  return tonumber(cstairvarcfg:GetRecorder(13).value)
end

function BM_TowerV2:GetSpiritCost(levelid)
  return cstairlevelcfg:GetRecorder(levelid).apCost
end

function BM_TowerV2:GetState()
  return self._towerInfo.state
end

function BM_TowerV2:GetPreviewRewards()
  return self._towerInfo.previewRewards
end

function BM_TowerV2:GetRefreshTime()
  return self._towerInfo.nextRefreshTime
end

function BM_TowerV2:CanAutoExplore()
  local floorId = self:GetCurrentFloorID()
  return self._towerInfo.autoUnlocked or floorId and floorId >= tonumber(cstairvarcfg:GetRecorder(9).value)
end

function BM_TowerV2:IsInAutoExplore()
  return self._towerInfo.autoExplore
end

function BM_TowerV2:GetBGM(id)
  id = id or self:GetCurrentFloorID()
  return cstairlevelcfg:GetRecorder(id).bgm
end

local weak_type_priority = {
  8,
  5,
  6,
  3,
  1,
  2,
  7
}
local strong_type_priority = {
  2,
  5,
  3,
  6,
  1,
  8,
  7
}

function BM_TowerV2:PickEventByPriority(events)
  local t = clone(events)
  table.sort(t, function(lhs, rhs)
    if lhs.type == rhs.type then
      return lhs.id < rhs.id
    end
    for i, v in ipairs(strong_type_priority) do
      if v == lhs.type then
        return true
      end
      if v == rhs.type then
        return false
      end
    end
    return true
  end)
  return t[1]
end

function BM_TowerV2:RewardHasRedpoint()
  return self._towerInfo.rewardRedpoint
end

function BM_TowerV2:BuffHasRedpoint()
  return self._towerInfo.buffRedpoint
end

function BM_TowerV2:SetBuffRedpoint(state)
  self._towerInfo.buffRedpoint = state
end

function BM_TowerV2:GetBackgrounds(levelid)
  levelid = levelid or self:GetCurrentFloorID()
  local first = self._towerInfo.mapInfo[1].id
  local last = self._towerInfo.mapInfo[#self._towerInfo.mapInfo].id
  local bg = {}
  for _, i in ipairs(cstairlevelcfg:GetAllIds()) do
    local recorder = cstairlevelcfg:GetRecorder(i)
    if first > recorder.id then
      bg[1] = recorder.BackAsset
    elseif recorder.id == levelid then
      bg[2] = recorder.BackAsset
    elseif last < recorder.id then
      bg[3] = recorder.BackAsset
      break
    end
  end
  if levelid == first or not bg[1] then
    bg[1] = bg[1] or bg[2]
  end
  bg[3] = bg[3] or bg[2]
  local assets = {}
  for i, v in ipairs(bg) do
    assets[i] = cstairbackconfig:GetRecorder(v)
  end
  return assets
end

function BM_TowerV2:IsOpen()
  return self._towerInfo.open
end

function BM_TowerV2:GetNextTime()
  return self._towerInfo.openTime
end

function BM_TowerV2:TryEnter()
  local req = LuaNetManager.CreateProtocol("protocol.activity.cpreviewtowerfloorstatue")
  req:Send()
end

function BM_TowerV2:Enter()
  local req = LuaNetManager.CreateProtocol("protocol.activity.cgettowerfloorinfo")
  req:Send()
end

function BM_TowerV2:FreshStart()
  local req = LuaNetManager.CreateProtocol("protocol.activity.cwarp2newpoint")
  req.toNextFloor = 0
  req:Send()
end

function BM_TowerV2:StartBattle(index, teamid)
  local req = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
  req.battleType = req.TOWER
  req.id = self._towerInfo.mapInfo[index].id
  req.lineupID = teamid
  req:Send()
end

function BM_TowerV2:Forward()
  local req = LuaNetManager.CreateProtocol("protocol.activity.cwarp2newpoint")
  req.toNextFloor = 1
  req:Send()
end

function BM_TowerV2:Retreat()
  local req = LuaNetManager.CreateProtocol("protocol.activity.cwarp2newpoint")
  req.toNextFloor = 1
  req:Send()
end

function BM_TowerV2:ChooseEvent(id, eventIndex, choice)
  local req = LuaNetManager.CreateProtocol("protocol.activity.cchoosepointevent")
  req.pointID = id
  req.eventIndex = eventIndex
  req.eventChoice = choice
  req:Send()
end

function BM_TowerV2:RequestRewardPreview()
  local req = LuaNetManager.CreateProtocol("protocol.activity.cpreviewpassedpointsreward")
  req:Send()
end

function BM_TowerV2:ChooseBuff(point, choice)
  local req = LuaNetManager.CreateProtocol("protocol.activity.crougetowerchoicebuff")
  req.pointID = point
  req.buffChoice = choice
  req:Send()
end

function BM_TowerV2:Reset(type)
  local req = LuaNetManager.CreateProtocol("protocol.activity.crougetowerresettype")
  req.resetType = type
  req:Send()
end

function BM_TowerV2:StartAutoExplore()
  local req = LuaNetManager.CreateProtocol("protocol.activity.cchangerougetowerautoexplore")
  req.switchState = 1
  req:Send()
end

function BM_TowerV2:StopAutoExplore()
  local req = LuaNetManager.CreateProtocol("protocol.activity.cchangerougetowerautoexplore")
  req.switchState = 0
  req:Send()
end

function BM_TowerV2:RequestAward(id)
  local req = LuaNetManager.CreateProtocol("protocol.activity.creceivetoweraward")
  req.id = id
  req:Send()
end

function BM_TowerV2:RequestOpenState()
  local req = LuaNetManager.CreateProtocol("protocol.activity.crequestrougetoweropen")
  req:Send()
end

function BM_TowerV2:GetHasReward()
  if self._towerInfo.hasReward then
    return self._towerInfo.hasReward
  end
  return 0
end

return BM_TowerV2
