-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_yardmusic.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local SongStatus = (LuaNetManager.GetBeanDef)("protocol.yard.song")
local RewardStatus = (LuaNetManager.GetBeanDef)("protocol.yard.musiccollectionrewardsstatus")
local DM_YardMusic = class("DM_YardMusic")
DM_YardMusic.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CAudioPlayerCell
  self._yardMusic = (NekoData.Data).yardMusic
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._yardMusic).level = 0
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._yardMusic).list = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._yardMusic).albums = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._yardMusic).rewardMap = {}
  self._musicRecords = {}
  local allIds = CAudioPlayerCell:GetAllIds()
  local len = #allIds
  for i = 1, len do
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

    (self._musicRecords)[allIds[i]] = CAudioPlayerCell:GetRecorder(allIds[i])
  end
end

DM_YardMusic.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._yardMusic).level = 0
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._yardMusic).list = {}
  for k,v in pairs((self._yardMusic).albums) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

    ((self._yardMusic).albums)[k] = nil
  end
  for k,v in pairs((self._yardMusic).rewardMap) do
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

    ((self._yardMusic).rewardMap)[k] = nil
  end
end

DM_YardMusic.OnSYardInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, CAudioPlayerCell
  self:RefreshYardMusic(protocol.music)
  if ((NekoData.BehaviorManager).BM_YardMusic):GetPlayingId() == 0 and (self._yardMusic).level > 0 then
    local allIds = CAudioPlayerCell:GetAllIds()
    local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)(userid .. "YardPlayingId", allIds[1])
  end
end

DM_YardMusic.OnSInitMusic = function(self, protocol)
  -- function num : 0_3
  self:RefreshYardMusic(protocol.music)
end

DM_YardMusic.RefreshYardMusic = function(self, yardMusicInfo)
  -- function num : 0_4 , upvalues : _ENV, SongStatus
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._yardMusic).level = yardMusicInfo.level
  while ((self._yardMusic).list)[#(self._yardMusic).list] do
    (table.remove)((self._yardMusic).list, #(self._yardMusic).list)
  end
  for i,v in ipairs(yardMusicInfo.songs) do
    local record = (self._musicRecords)[v.id]
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

    if record then
      if not ((self._yardMusic).albums)[record.album] then
        ((self._yardMusic).albums)[record.album] = {
musicList = {}
}
      end
      ;
      (table.insert)((((self._yardMusic).albums)[record.album]).musicList, {id = v.id, status = v.statue, record = record})
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R8 in 'UnsetPending'

      if v.statue == SongStatus.NEW then
        (((self._yardMusic).albums)[record.album]).showNew = true
      end
    else
      LogErrorFormat("DM_YardMusic", "recorder with id %s is not exist in caudioplayercell", v.id)
    end
  end
end

DM_YardMusic.OnSLockSong = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, SongStatus
  for i,v in ipairs(protocol.id) do
    local record = (self._musicRecords)[v]
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    if record then
      if not ((self._yardMusic).albums)[record.album] then
        ((self._yardMusic).albums)[record.album] = {
musicList = {}
}
      end
      ;
      (table.insert)((((self._yardMusic).albums)[record.album]).musicList, {id = v, status = SongStatus.NEW, record = record})
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (((self._yardMusic).albums)[record.album]).showNew = true
    else
      LogErrorFormat("DM_YardMusic", "recorder with id %s is not exist in caudioplayercell", v)
    end
  end
end

DM_YardMusic.OnSUnlockSong = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV, SongStatus
  local record = (self._musicRecords)[protocol.id]
  if record then
    local map = ((self._yardMusic).albums)[record.album]
    if map then
      for i,v in ipairs(map.musicList) do
        if v.id == protocol.id then
          v.status = SongStatus.unlock
          break
        end
      end
    else
      do
        do
          LogErrorFormat("DM_YardMusic", "data with id %s is not exist in albums(id: %s)", protocol.id, record.album)
          LogErrorFormat("DM_YardMusic", "recorder with id %s is not exist in caudioplayercell", v.id)
        end
      end
    end
  end
end

DM_YardMusic.OnSMusicCollectionRewardsAchieved = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  for i,v in ipairs(protocol.musicCollectionRewardsStates) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    if not ((self._yardMusic).rewardMap)[v.rewardsId] then
      ((self._yardMusic).rewardMap)[v.rewardsId] = {rewardId = v.rewardsId, rewardStatus = v.rewardsStatue}
    else
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (((self._yardMusic).rewardMap)[v.rewardsId]).rewardStatus = v.rewardsStatue
    end
  end
end

DM_YardMusic.CheckedAlbum = function(self, id)
  -- function num : 0_8 , upvalues : _ENV, SongStatus
  local album = ((self._yardMusic).albums)[id]
  if album then
    for i,v in ipairs(album.musicList) do
      if v.status == SongStatus.NEW then
        v.status = SongStatus.lock
      end
    end
    album.showNew = false
  end
end

return DM_YardMusic

