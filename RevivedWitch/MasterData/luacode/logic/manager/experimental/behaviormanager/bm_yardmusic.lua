-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_yardmusic.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAudioPlayer = (BeanManager.GetTableByName)("courtyard.caudioplayer")
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local CAudioPlayerAlbum = (BeanManager.GetTableByName)("courtyard.caudioplayeralbum")
local SongStatus = (LuaNetManager.GetBeanDef)("protocol.yard.song")
local RewardStatus = (LuaNetManager.GetBeanDef)("protocol.yard.musiccollectionrewardsstatus")
local BM_YardMusic = class("BM_YardMusic")
BM_YardMusic.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CAudioPlayer, CAudioPlayerAlbum, CAudioPlayerCell
  self._yardMusic = (NekoData.Data).yardMusic
  self._maxfloorId = 0
  self._recordList = {}
  self._musicIdMap = {}
  local allIds = CAudioPlayer:GetAllIds()
  for i = 1, #allIds do
    local record = CAudioPlayer:GetRecorder(allIds[i])
    for _,v in ipairs(record.cellID) do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R12 in 'UnsetPending'

      (self._musicIdMap)[v] = record.floor
    end
    if self._maxfloorId < record.floor then
      self._maxfloorId = record.floor
    end
    ;
    (table.insert)(self._recordList, record)
  end
  ;
  (table.sort)(self._recordList, function(a, b)
    -- function num : 0_0_0
    do return a.floor < b.floor end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self._albumTotalNumMap = {}
  allIds = CAudioPlayerAlbum:GetAllIds()
  local len = #allIds
  for i = 1, len do
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R7 in 'UnsetPending'

    (self._albumTotalNumMap)[allIds[i]] = 0
  end
  allIds = CAudioPlayerCell:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CAudioPlayerCell:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._albumTotalNumMap)[record.album] = (self._albumTotalNumMap)[record.album] + 1
  end
end

BM_YardMusic.GetAlbumList = function(self)
  -- function num : 0_1 , upvalues : CAudioPlayerAlbum, _ENV, CAudioPlayerCell
  local list = {}
  local allIds = CAudioPlayerAlbum:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local id = allIds[i]
    local data = clone(((self._yardMusic).albums)[id])
    if not data then
      data = {
musicList = {}
}
    end
    data.record = CAudioPlayerAlbum:GetRecorder(id)
    ;
    (table.insert)(list, data)
  end
  for _,album in ipairs(list) do
    if album.musicList then
      (table.sort)(album.musicList, function(a, b)
    -- function num : 0_1_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
  end
  for _,album in ipairs(list) do
    local floor = 0
    local nextLockMusicInfo = {}
    for i,v in ipairs(album.musicList) do
      if (self._musicIdMap)[v.id] and floor < (self._musicIdMap)[v.id] then
        floor = (self._musicIdMap)[v.id]
      end
    end
    for _,v in ipairs(self._recordList) do
      if floor < v.floor then
        for i,musicId in ipairs(v.cellID) do
          local record = CAudioPlayerCell:GetRecorder(musicId)
          if record.album == (album.record).id then
            nextLockMusicInfo.floor = v.floor
            nextLockMusicInfo.musicRecord = record
            break
          end
        end
      end
    end
    do
      do
        if nextLockMusicInfo.floor or nextLockMusicInfo.floor then
          (table.insert)(album.musicList, {id = (nextLockMusicInfo.musicRecord).id, record = nextLockMusicInfo.musicRecord, floor = nextLockMusicInfo.floor})
        end
        -- DECOMPILER ERROR at PC117: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return list
end

BM_YardMusic.GetCanPlayMusicNum = function(self)
  -- function num : 0_2 , upvalues : _ENV, SongStatus
  local num = 0
  for id,album in pairs((self._yardMusic).albums) do
    for _,music in ipairs(album.musicList) do
      if music.status == SongStatus.unlock then
        num = num + 1
      end
    end
  end
  return num
end

BM_YardMusic.GetMusicTotalNum = function(self)
  -- function num : 0_3 , upvalues : CAudioPlayerCell
  return #CAudioPlayerCell:GetAllIds()
end

BM_YardMusic.SetPlayingId = function(self, id)
  -- function num : 0_4 , upvalues : _ENV, CAudioPlayerCell
  if id ~= self:GetPlayingId() then
    local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)(userid .. "YardPlayingId", id)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_PlayingIdChanged, nil, id)
    local record = CAudioPlayerCell:GetRecorder(id)
    ;
    (LuaAudioManager.PlayBGM)(record.audioID, true)
  end
end

BM_YardMusic.GetPlayingAudioId = function(self)
  -- function num : 0_5 , upvalues : CAudioPlayerCell
  local id = self:GetPlayingId()
  local record = CAudioPlayerCell:GetRecorder(id)
  return record.audioID
end

BM_YardMusic.GetPlayingId = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
  return (((CS.UnityEngine).PlayerPrefs).GetInt)(userid .. "YardPlayingId", 0)
end

BM_YardMusic.SetSyncMainCity = function(self, sync)
  -- function num : 0_7 , upvalues : _ENV
  local value = 0
  if sync then
    value = 1
  end
  local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)(userid .. "SyncMainCity", value)
end

BM_YardMusic.GetSyncMainCity = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
  local value = (((CS.UnityEngine).PlayerPrefs).GetInt)(userid .. "SyncMainCity", 0)
  do return value == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_YardMusic.GetLevel = function(self)
  -- function num : 0_9
  return (self._yardMusic).level
end

BM_YardMusic.GetDispatchRoles = function(self)
  -- function num : 0_10
  return {}
end

BM_YardMusic.GetPauseTaskNum = function(self)
  -- function num : 0_11
  return 0
end

BM_YardMusic.GetGetNum = function(self)
  -- function num : 0_12 , upvalues : _ENV, RewardStatus
  local num = 0
  if (self._yardMusic).level > 0 then
    for id,album in pairs((self._yardMusic).albums) do
      if album.showNew then
        num = num + 1
      end
    end
    for k,v in pairs((self._yardMusic).rewardMap) do
      if v.rewardStatus == RewardStatus.AVAILABLE then
        num = num + 1
      end
    end
  end
  do
    return num
  end
end

BM_YardMusic.CheckedAlbum = function(self, id)
  -- function num : 0_13 , upvalues : _ENV
  local album = ((self._yardMusic).albums)[id]
  if album and album.showNew then
    local copenMusic = (LuaNetManager.CreateProtocol)("protocol.yard.copenmusic")
    copenMusic.albumId = id
    copenMusic:Send()
    ;
    ((NekoData.DataManager).DM_YardMusic):CheckedAlbum(id)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingGetNumChanged, nil, {buildingId = DataCommon.YardMusic, state = ((NekoData.BehaviorManager).BM_YardMusic):GetGetNum()})
  end
end

BM_YardMusic.GetRewards = function(self)
  -- function num : 0_14
  return (self._yardMusic).rewardMap
end

BM_YardMusic.GetAlbumMusicTotalNum = function(self, id)
  -- function num : 0_15
  return (self._albumTotalNumMap)[id] or 0
end

BM_YardMusic.GetUnlockMusicNum = function(self, id)
  -- function num : 0_16 , upvalues : _ENV, SongStatus
  local data = ((self._yardMusic).albums)[id]
  if data then
    local num = 0
    for i,v in ipairs(data.musicList) do
      if v.status == SongStatus.unlock then
        num = num + 1
      end
    end
    return num
  else
    do
      do return 0 end
    end
  end
end

return BM_YardMusic

