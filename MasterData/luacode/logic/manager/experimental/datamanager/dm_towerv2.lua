-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_towerv2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_TowerV2 = class("DM_TowerV2")
local cstairlevelcfg = (BeanManager.GetTableByName)("dungeonselect.cstairlevelcfg")
local cstaireventtype = (BeanManager.GetTableByName)("dungeonselect.cstaireventtype")
local cstairblessingdeploy = (BeanManager.GetTableByName)("dungeonselect.cstairblessingdeploy")
local Item = require("logic.manager.experimental.types.item")
DM_TowerV2.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._towerInfo = (NekoData.Data).towerv2
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerInfo).hp = {}
end

DM_TowerV2.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if (self._towerInfo).task then
    (ServerGameTimer.RemoveTask)((self._towerInfo).task)
  end
  for k,v in pairs(self._towerInfo) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    (self._towerInfo)[k] = nil
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerInfo).hp = {}
end

DM_TowerV2.OnSGetTowerFloorInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : cstairlevelcfg, _ENV, cstaireventtype
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._towerInfo).autoExplore = protocol.autoExploreState == 1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).nextRefreshTime = protocol.time2reset
  local ids = cstairlevelcfg:GetAllIds()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).fresh = protocol.enterType == 0
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).passedCount = protocol.passedPoints
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).autoUnlocked = protocol.autoExploreUnlock == 1
  self:RefreshReached(protocol.highestPointID)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).rewardRedpoint = protocol.rewardRedPoint == 1
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).hp = {}
  self:RefreshHP(protocol.rolesState)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).buffs = {}
  self:RefreshBuff(protocol.buffList)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).mapInfo = {}
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).currentFloor = nil
  for _,v in ipairs(protocol.points) do
    local cfg = cstairlevelcfg:GetRecorder(v.pointID)
    local node = {id = v.pointID, type = cfg.typeID, cfg = cfg, state = v.pointState, 
events = {}
, buff = v.pointBuff}
    for i = 1, #v.pointEventsType do
      local iconcfg = cstaireventtype:GetRecorder((v.pointEventsType)[i])
      local altercfg = {}
      if (v.pointEventsType)[i] == 4 then
        iconcfg = cstaireventtype:GetRecorder((v.pointEventsType)[i])
      end
      -- DECOMPILER ERROR at PC118: Confused about usage of register: R16 in 'UnsetPending'

      if (v.pointEventsType)[i] == 9 then
        do
          (node.events)[i] = {type = (v.pointEventsType)[i], id = (v.pointEventsID)[i], assetBundle = iconcfg.assetBundle, assetName = iconcfg.assetName, alterAssetBundle = altercfg.assetBundleBattle, alterAssetName = altercfg.assetNameBattle}
          -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    -- DECOMPILER ERROR at PC129: Confused about usage of register: R10 in 'UnsetPending'

    if node.state ~= 2 and not (self._towerInfo).currentFloor then
      (self._towerInfo).currentFloor = node.id
    end
    -- DECOMPILER ERROR at PC136: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self._towerInfo).mapInfo)[#(self._towerInfo).mapInfo + 1] = node
  end
  -- DECOMPILER ERROR at PC143: Confused about usage of register: R3 in 'UnsetPending'

  if protocol.enterType == 0 then
    (self._towerInfo).state = "fresh"
  else
    -- DECOMPILER ERROR at PC149: Confused about usage of register: R3 in 'UnsetPending'

    if protocol.enterType == 2 then
      (self._towerInfo).state = "retreat"
    else
      -- DECOMPILER ERROR at PC155: Confused about usage of register: R3 in 'UnsetPending'

      if protocol.enterType == 3 then
        (self._towerInfo).state = "reset"
      else
        -- DECOMPILER ERROR at PC161: Confused about usage of register: R3 in 'UnsetPending'

        if protocol.enterType == 4 then
          (self._towerInfo).state = "buffchoose"
          self:OnSRougeTowerInitialBuffChoose({buff = protocol.buff4Choice})
          local count = (table.aggregate)(protocol.buffList, 0, function(seed, k, v)
    -- function num : 0_2_0
    return seed + v
  end
)
          -- DECOMPILER ERROR at PC174: Confused about usage of register: R4 in 'UnsetPending'

          ;
          (self._towerInfo).buffCandidateProgress = count
        else
          -- DECOMPILER ERROR at PC190: Confused about usage of register: R3 in 'UnsetPending'

          if not (self._towerInfo).currentFloor then
            if ids[#ids] == ((protocol.points)[#protocol.points]).pointID then
              (self._towerInfo).state = "complete"
            else
              -- DECOMPILER ERROR at PC193: Confused about usage of register: R3 in 'UnsetPending'

              (self._towerInfo).state = "finished"
            end
          else
            -- DECOMPILER ERROR at PC199: Confused about usage of register: R3 in 'UnsetPending'

            if protocol.enterType == 1 then
              (self._towerInfo).state = "continue"
            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC210: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._towerInfo).currentFloor then
    (self._towerInfo).currentFloor = ((protocol.points)[#protocol.points]).pointID
    -- DECOMPILER ERROR at PC213: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._towerInfo).buffChances = protocol.buffNum4Reset
    -- DECOMPILER ERROR: 16 unprocessed JMP targets
  end
end

DM_TowerV2.OnSPassFloorEndPoint = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, Item
  local items = {}
  for _,v in ipairs(protocol.receiveItems) do
    local item = (Item.Create)(v.id)
    item:InitWithItemInfo(v)
    items[#items + 1] = {item = item, num = item:GetCount()}
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).lastRewards = items
end

DM_TowerV2.OnSChoosePointEvent = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV, cstairlevelcfg
  if (self._towerInfo).currentFloor then
    if protocol.EventID ~= -1 then
      local index = 1
      for i,v in ipairs((self._towerInfo).mapInfo) do
        if v.id == protocol.pointID then
          index = i
          v.state = 2
          break
        end
      end
      do
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

        if (self._towerInfo).reachedfloorid <= (self._towerInfo).currentFloor then
          (self._towerInfo).passedCount = (self._towerInfo).passedCount + 1
          self:RefreshReached((self._towerInfo).currentFloor)
        end
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

        if #(self._towerInfo).mapInfo < index + 1 then
          (self._towerInfo).currentFloor = (((self._towerInfo).mapInfo)[#(self._towerInfo).mapInfo]).id
          -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (self._towerInfo).state = "finished"
          for i = 1, #(self._towerInfo).mapInfo - 1 do
            -- DECOMPILER ERROR at PC65: Confused about usage of register: R7 in 'UnsetPending'

            (((self._towerInfo).mapInfo)[i]).buff = {}
          end
        else
          do
            do
              -- DECOMPILER ERROR at PC74: Confused about usage of register: R3 in 'UnsetPending'

              ;
              (self._towerInfo).currentFloor = (((self._towerInfo).mapInfo)[index + 1]).id
              -- DECOMPILER ERROR at PC77: Confused about usage of register: R2 in 'UnsetPending'

              ;
              (self._towerInfo).state = "retreat"
              local ids = cstairlevelcfg:GetAllIds()
              -- DECOMPILER ERROR at PC88: Confused about usage of register: R3 in 'UnsetPending'

              if ids[#ids] == (self._towerInfo).currentFloor then
                (self._towerInfo).state = "complete"
              end
              self:RefreshBuff(protocol.updateBuff)
              self:RefreshHP(protocol.rolesState)
            end
          end
        end
      end
    end
  end
end

DM_TowerV2.OnSReceiveTowerResetAward = function(self, protocol)
  -- function num : 0_5
end

DM_TowerV2.OnSUpdateTowerLineupStatue = function(self, protocol)
  -- function num : 0_6
  self:RefreshHP(protocol.rolesState)
end

DM_TowerV2.OnSPreviewPassedPointsReward = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  self:BuildPreviewRewards()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).rewardRedpoint = (self._towerInfo).rewardRedpoint or protocol.afterBattle == 1
  for _,v in pairs((self._towerInfo).previewRewards) do
    if ((protocol.rewards)[v.id]).received ~= 1 then
      do
        v.got = not (protocol.rewards)[v.id]
        if v.id ~= 0 then
          LogErrorFormat("towerv2", "reward level %s not found in protocol", v.pt)
        end
        -- DECOMPILER ERROR at PC41: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC41: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

DM_TowerV2.OnSRougeTowerChoiceBuff = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV, cstairblessingdeploy
  if protocol.choiceResult == 0 then
    LogError("towerv2", "invalid buff choice " .. protocol.pointID)
  end
  local index, v = (table.first)((self._towerInfo).buffs, function(k, v)
    -- function num : 0_8_0 , upvalues : protocol
    do return v.id == protocol.choiceBuff end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if not v.count then
    v.count = (not v or 1) + 1
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self._towerInfo).buffs)[#(self._towerInfo).buffs + 1] = {id = protocol.choiceBuff, cfg = cstairblessingdeploy:GetRecorder(protocol.choiceBuff), new = true, count = 1}
    ;
    (table.sort)((self._towerInfo).buffs, function(lhs, rhs)
    -- function num : 0_8_1
    if (rhs.cfg).QualityTyp < (lhs.cfg).QualityTyp then
      return true
    else
      if (lhs.cfg).QualityTyp < (rhs.cfg).QualityTyp then
        return false
      else
        return lhs.id < rhs.id
      end
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
    if not (self._towerInfo).buffCandidates or #(self._towerInfo).buffCandidates == 0 then
      for _,v in pairs((self._towerInfo).mapInfo) do
        if v.id == protocol.pointID then
          v.buff = {}
          break
        end
      end
    else
      do
        -- DECOMPILER ERROR at PC79: Confused about usage of register: R4 in 'UnsetPending'

        if protocol.pointID == #(self._towerInfo).buffCandidates then
          (self._towerInfo).buffCandidates = {}
        end
        -- DECOMPILER ERROR at PC81: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self._towerInfo).buffRedpoint = true
      end
    end
  end
end

DM_TowerV2.OnSRougeTowerInitialBuffChoose = function(self, protocol)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._towerInfo).buffCandidates = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).buffCandidateProgress = 0
  local list = protocol.buff
  for i = 1, #list, 3 do
    local info = {list[i], list[i + 1], list[i + 2]}
    ;
    (table.insert)((self._towerInfo).buffCandidates, info)
  end
end

DM_TowerV2.OnSChangeRougeTowerAutoExplore = function(self, protocol)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._towerInfo).autoExplore = protocol.switchState == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_TowerV2.OnSReceiveTowerAward = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV
  if protocol.id == 0 then
    LogError("towerv2", "request award error")
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).rewardRedpoint = false
  for _,v in pairs((self._towerInfo).previewRewards) do
    if v.id == protocol.id or v.id == 0 then
      v.got = true
    end
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._towerInfo).rewardRedpoint = not (self._towerInfo).rewardRedpoint and ((v.pt <= (self._towerInfo).passedCount and not v.got))
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DM_TowerV2.OnSRougeTowerOpenorNot = function(self, protocol)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._towerInfo).open = protocol.openornot == 1
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).openTime = protocol.leftTime // 1000 + (os.time)()
  if (self._towerInfo).task then
    (ServerGameTimer.RemoveTask)((self._towerInfo).task)
  end
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).task = (ServerGameTimer.AddTask)(protocol.leftTime // 1000, -1, function()
    -- function num : 0_12_0 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_TowerV2):RequestOpenState()
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DM_TowerV2.RefreshReached = function(self, highest)
  -- function num : 0_13 , upvalues : _ENV, cstairlevelcfg
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._towerInfo).reachedfloorcount = 0
  if highest ~= 0 then
    for i,v in ipairs(cstairlevelcfg:GetAllIds()) do
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

      if v == highest then
        (self._towerInfo).reachedfloorcount = i
        break
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._towerInfo).reachedfloorid = highest
  end
end

DM_TowerV2.RefreshHP = function(self, status)
  -- function num : 0_14 , upvalues : _ENV
  for rolekey,hp in pairs(status) do
    if hp > 100 or hp < 0 then
      LogError("towerv2", (string.format)("invalid hp: %d%% @ %s", hp, rolekey))
    end
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._towerInfo).hp)[rolekey] = hp / 100
  end
end

DM_TowerV2.RefreshBuff = function(self, buffs)
  -- function num : 0_15 , upvalues : _ENV, cstairblessingdeploy
  local current = {}
  for _,v in pairs((self._towerInfo).buffs) do
    if not buffs[v.id] then
      do
        v.count = v.count
        v.new = not buffs[v.id] or buffs[v.id] ~= v.count
        current[v.id] = true
        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for id,count in pairs(buffs) do
    if id == 0 then
      LogError("towerv2", "invalid buff id 0")
    else
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

      if not current[id] then
        ((self._towerInfo).buffs)[#(self._towerInfo).buffs + 1] = {id = id, count = count, cfg = cstairblessingdeploy:GetRecorder(id), new = true}
      end
    end
  end
  ;
  (table.sort)((self._towerInfo).buffs, function(lhs, rhs)
    -- function num : 0_15_0
    if (rhs.cfg).QualityTyp < (lhs.cfg).QualityTyp then
      return true
    else
      if (lhs.cfg).QualityTyp < (rhs.cfg).QualityTyp then
        return false
      else
        return lhs.id < rhs.id
      end
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

DM_TowerV2.BuildPreviewRewards = function(self)
  -- function num : 0_16 , upvalues : _ENV, Item
  if not (self._towerInfo).previewRewards then
    local cstairweekaward = (BeanManager.GetTableByName)("dungeonselect.cstairweekaward")
    local rewards = {
{id = 0, pt = 0, nextpt = (cstairweekaward:GetRecorder(1)).pt, got = true}
}
    local ids = cstairweekaward:GetAllIds()
    for _,i in ipairs(ids) do
      local recorder = cstairweekaward:GetRecorder(i)
      local item = (Item.Create)(recorder.showItem)
      item:SetCount(recorder.ItemNum)
      local info = {id = i, pt = recorder.passedPoints, item = item}
      if #rewards ~= 0 then
        info.prevpt = (rewards[#rewards]).pt
      end
      rewards[#rewards + 1] = info
    end
    for i,v in ipairs(rewards) do
      if rewards[i + 1] then
        v.nextpt = (rewards[i + 1]).pt
      end
    end
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._towerInfo).previewRewards = rewards
  end
  do
    return (self._towerInfo).previewRewards
  end
end

return DM_TowerV2

