-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_towerv2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_TowerV2 = class("BM_TowerV2")
local cstairlevelcfg = (BeanManager.GetTableByName)("dungeonselect.cstairlevelcfg")
local cstairvarcfg = (BeanManager.GetTableByName)("dungeonselect.cstairvarcfg")
local cstairbackconfig = (BeanManager.GetTableByName)("dungeonselect.cstairbackconfig")
BM_TowerV2.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._towerInfo = (NekoData.Data).towerv2
end

BM_TowerV2.IsFreshStart = function(self)
  -- function num : 0_1
  return (self._towerInfo).fresh
end

BM_TowerV2.GetPassedCount = function(self)
  -- function num : 0_2
  return (self._towerInfo).passedCount
end

BM_TowerV2.GetReachedFloorID = function(self)
  -- function num : 0_3
  return (self._towerInfo).reachedfloorid
end

BM_TowerV2.GetReachedCount = function(self)
  -- function num : 0_4
  return (self._towerInfo).reachedfloorcount
end

BM_TowerV2.GetCurrentFloorID = function(self)
  -- function num : 0_5
  return (self._towerInfo).currentFloor
end

BM_TowerV2.GetCurrentFloorIndex = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local index, _ = (table.first)((self._towerInfo).mapInfo, function(k, v)
    -- function num : 0_6_0 , upvalues : self
    do return v.id == (self._towerInfo).currentFloor end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return index
end

BM_TowerV2.GetFloorCount = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (table.nums)((self._towerInfo).mapInfo)
end

BM_TowerV2.GetLastRewards = function(self)
  -- function num : 0_8
  return (self._towerInfo).lastRewards
end

BM_TowerV2.GetBuffs = function(self)
  -- function num : 0_9
  return (self._towerInfo).buffs
end

BM_TowerV2.GetInitBuffCandidates = function(self)
  -- function num : 0_10
  return (self._towerInfo).buffCandidates
end

BM_TowerV2.GetInitBuffProgress = function(self)
  -- function num : 0_11
  return (self._towerInfo).buffCandidateProgress
end

BM_TowerV2.GetLastBuffCandidates = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local _, info = (table.first)((self._towerInfo).mapInfo, function(k, v)
    -- function num : 0_12_0
    do return #v.buff ~= 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if info then
    return info.id, {info.buff}
  end
end

BM_TowerV2.GetInitBuffChances = function(self)
  -- function num : 0_13
  return (self._towerInfo).buffChances
end

BM_TowerV2.GetFloorTotalCount = function(self)
  -- function num : 0_14 , upvalues : cstairlevelcfg
  return #cstairlevelcfg:GetAllIds()
end

BM_TowerV2.GetCurrentFloorInfo = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local _, info = (table.first)((self._towerInfo).mapInfo, function(k, v)
    -- function num : 0_15_0 , upvalues : self
    do return v.id == (self._towerInfo).currentFloor end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return info
end

BM_TowerV2.GetFloorInfoByID = function(self, id)
  -- function num : 0_16 , upvalues : _ENV
  local _, info = (table.first)((self._towerInfo).mapInfo, function(k, v)
    -- function num : 0_16_0 , upvalues : id
    do return v.id == id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return info
end

BM_TowerV2.GetNextWorld = function(self, floorid)
  -- function num : 0_17 , upvalues : _ENV, cstairlevelcfg
  if not floorid then
    floorid = self:GetCurrentFloorID()
  end
  local n = nil
  for _,i in ipairs(cstairlevelcfg:GetAllIds()) do
    local recorder = cstairlevelcfg:GetRecorder(i)
    if n then
      return tonumber(recorder.world)
    end
    n = recorder.id == floorid
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_TowerV2.GetFloorInfoByIndex = function(self, index)
  -- function num : 0_18
  return ((self._towerInfo).mapInfo)[index]
end

BM_TowerV2.GetRoleHP = function(self, roleid)
  -- function num : 0_19
  return ((self._towerInfo).hp)[roleid] or 1
end

BM_TowerV2.CheckTeamHP = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local bm_team = (NekoData.BehaviorManager).BM_Team
  local list = (bm_team:GetTowerTeamsInfo())[bm_team:GetTowerCurrentTeamId()]
  return not (table.any)(list.roles, function(k, v)
    -- function num : 0_20_0 , upvalues : self
    do return not v or (v ~= 0 and self:GetRoleHP(v) == 0) end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
end

BM_TowerV2.GetStartStair = function(self, levelid)
  -- function num : 0_21 , upvalues : cstairlevelcfg
  return (cstairlevelcfg:GetRecorder(levelid)).continueAsset
end

BM_TowerV2.GetRetreatStair = function(self, levelid)
  -- function num : 0_22 , upvalues : cstairlevelcfg, _ENV, cstairvarcfg
  local ids = cstairlevelcfg:GetAllIds()
  for i = levelid - 1, ids[1], -1 do
    local recorder = cstairlevelcfg:GetRecorder(i)
    if recorder and recorder.typeID == 4 then
      return recorder.startAsset
    end
  end
  return tonumber((cstairvarcfg:GetRecorder(2)).value)
end

BM_TowerV2.GetFinishStair = function(self, levelid)
  -- function num : 0_23 , upvalues : cstairlevelcfg, _ENV, cstairvarcfg
  local ids = cstairlevelcfg:GetAllIds()
  for i = levelid, ids[1], -1 do
    local recorder = cstairlevelcfg:GetRecorder(i)
    if recorder and recorder.typeID == 4 then
      return recorder.startAsset
    end
  end
  return tonumber((cstairvarcfg:GetRecorder(2)).value)
end

BM_TowerV2.GetSpiritCost = function(self, levelid)
  -- function num : 0_24 , upvalues : cstairlevelcfg
  return (cstairlevelcfg:GetRecorder(levelid)).apCost
end

BM_TowerV2.GetState = function(self)
  -- function num : 0_25
  return (self._towerInfo).state
end

BM_TowerV2.GetPreviewRewards = function(self)
  -- function num : 0_26
  return (self._towerInfo).previewRewards
end

BM_TowerV2.GetRefreshTime = function(self)
  -- function num : 0_27
  return (self._towerInfo).nextRefreshTime
end

BM_TowerV2.CanAutoExplore = function(self)
  -- function num : 0_28 , upvalues : _ENV, cstairvarcfg
  local floorId = self:GetCurrentFloorID()
  do return (self._towerInfo).autoUnlocked or not floorId or tonumber((cstairvarcfg:GetRecorder(9)).value) <= floorId end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_TowerV2.IsInAutoExplore = function(self)
  -- function num : 0_29
  return (self._towerInfo).autoExplore
end

BM_TowerV2.GetBGM = function(self, id)
  -- function num : 0_30 , upvalues : cstairlevelcfg
  if not id then
    id = self:GetCurrentFloorID()
  end
  return (cstairlevelcfg:GetRecorder(id)).bgm
end

local weak_type_priority = {8, 5, 6, 3, 1, 2, 7}
local strong_type_priority = {2, 5, 3, 6, 1, 8, 7}
BM_TowerV2.PickEventByPriority = function(self, events)
  -- function num : 0_31 , upvalues : _ENV, strong_type_priority
  local t = clone(events)
  ;
  (table.sort)(t, function(lhs, rhs)
    -- function num : 0_31_0 , upvalues : _ENV, strong_type_priority
    if lhs.id >= rhs.id then
      do return lhs.type ~= rhs.type end
      for i,v in ipairs(strong_type_priority) do
        if v == lhs.type then
          return true
        end
        if v == rhs.type then
          return false
        end
      end
      do return true end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return t[1]
end

BM_TowerV2.RewardHasRedpoint = function(self)
  -- function num : 0_32
  return (self._towerInfo).rewardRedpoint
end

BM_TowerV2.BuffHasRedpoint = function(self)
  -- function num : 0_33
  return (self._towerInfo).buffRedpoint
end

BM_TowerV2.SetBuffRedpoint = function(self, state)
  -- function num : 0_34
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._towerInfo).buffRedpoint = state
end

BM_TowerV2.GetBackgrounds = function(self, levelid)
  -- function num : 0_35 , upvalues : _ENV, cstairlevelcfg, cstairbackconfig
  if not levelid then
    levelid = self:GetCurrentFloorID()
  end
  local first = (((self._towerInfo).mapInfo)[1]).id
  local last = (((self._towerInfo).mapInfo)[#(self._towerInfo).mapInfo]).id
  local bg = {}
  for _,i in ipairs(cstairlevelcfg:GetAllIds()) do
    local recorder = cstairlevelcfg:GetRecorder(i)
    if recorder.id < first then
      bg[1] = recorder.BackAsset
    else
      if recorder.id == levelid then
        bg[2] = recorder.BackAsset
      else
        if last < recorder.id then
          bg[3] = recorder.BackAsset
          break
        end
      end
    end
  end
  do
    if (levelid == first or not bg[1]) and not bg[1] then
      bg[1] = bg[2]
      if not bg[3] then
        bg[3] = bg[2]
        local assets = {}
        for i,v in ipairs(bg) do
          assets[i] = cstairbackconfig:GetRecorder(v)
        end
        return assets
      end
    end
  end
end

BM_TowerV2.IsOpen = function(self)
  -- function num : 0_36
  return (self._towerInfo).open
end

BM_TowerV2.GetNextTime = function(self)
  -- function num : 0_37
  return (self._towerInfo).openTime
end

BM_TowerV2.TryEnter = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cpreviewtowerfloorstatue")
  req:Send()
end

BM_TowerV2.Enter = function(self)
  -- function num : 0_39 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cgettowerfloorinfo")
  req:Send()
end

BM_TowerV2.FreshStart = function(self)
  -- function num : 0_40 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cwarp2newpoint")
  req.toNextFloor = 0
  req:Send()
end

BM_TowerV2.StartBattle = function(self, index, teamid)
  -- function num : 0_41 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
  req.battleType = req.TOWER
  req.id = (((self._towerInfo).mapInfo)[index]).id
  req.lineupID = teamid
  req:Send()
end

BM_TowerV2.Forward = function(self)
  -- function num : 0_42 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cwarp2newpoint")
  req.toNextFloor = 1
  req:Send()
end

BM_TowerV2.Retreat = function(self)
  -- function num : 0_43 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cwarp2newpoint")
  req.toNextFloor = 1
  req:Send()
end

BM_TowerV2.ChooseEvent = function(self, id, eventIndex, choice)
  -- function num : 0_44 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cchoosepointevent")
  req.pointID = id
  req.eventIndex = eventIndex
  req.eventChoice = choice
  req:Send()
end

BM_TowerV2.RequestRewardPreview = function(self)
  -- function num : 0_45 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cpreviewpassedpointsreward")
  req:Send()
end

BM_TowerV2.ChooseBuff = function(self, point, choice)
  -- function num : 0_46 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.crougetowerchoicebuff")
  req.pointID = point
  req.buffChoice = choice
  req:Send()
end

BM_TowerV2.Reset = function(self, type)
  -- function num : 0_47 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.crougetowerresettype")
  req.resetType = type
  req:Send()
end

BM_TowerV2.StartAutoExplore = function(self)
  -- function num : 0_48 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cchangerougetowerautoexplore")
  req.switchState = 1
  req:Send()
end

BM_TowerV2.StopAutoExplore = function(self)
  -- function num : 0_49 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.cchangerougetowerautoexplore")
  req.switchState = 0
  req:Send()
end

BM_TowerV2.RequestAward = function(self, id)
  -- function num : 0_50 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.creceivetoweraward")
  req.id = id
  req:Send()
end

BM_TowerV2.RequestOpenState = function(self)
  -- function num : 0_51 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.activity.crequestrougetoweropen")
  req:Send()
end

return BM_TowerV2

