local CAudioPlayer = BeanManager.GetTableByName("courtyard.caudioplayer")
local CAudioPlayerCell = BeanManager.GetTableByName("courtyard.caudioplayercell")
local CAudioPlayerAlbum = BeanManager.GetTableByName("courtyard.caudioplayeralbum")
local SongStatus = LuaNetManager.GetBeanDef("protocol.yard.song")
local RewardStatus = LuaNetManager.GetBeanDef("protocol.yard.musiccollectionrewardsstatus")
local BM_YardMusic = class("BM_YardMusic")

function BM_YardMusic:Ctor()
  self._yardMusic = NekoData.Data.yardMusic
  self._maxfloorId = 0
  self._recordList = {}
  self._musicIdMap = {}
  local allIds = CAudioPlayer:GetAllIds()
  for i = 1, #allIds do
    local record = CAudioPlayer:GetRecorder(allIds[i])
    for _, v in ipairs(record.cellID) do
      self._musicIdMap[v] = record.floor
    end
    if record.floor > self._maxfloorId then
      self._maxfloorId = record.floor
    end
    table.insert(self._recordList, record)
  end
  table.sort(self._recordList, function(a, b)
    return a.floor < b.floor
  end)
  self._albumTotalNumMap = {}
  allIds = CAudioPlayerAlbum:GetAllIds()
  local len = #allIds
  for i = 1, len do
    self._albumTotalNumMap[allIds[i]] = 0
  end
  allIds = CAudioPlayerCell:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CAudioPlayerCell:GetRecorder(allIds[i])
    self._albumTotalNumMap[record.album] = self._albumTotalNumMap[record.album] + 1
  end
end

function BM_YardMusic:GetAlbumList()
  local list = {}
  local allIds = CAudioPlayerAlbum:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local id = allIds[i]
    local data = clone(self._yardMusic.albums[id])
    data = data or {
      musicList = {}
    }
    data.record = CAudioPlayerAlbum:GetRecorder(id)
    table.insert(list, data)
  end
  for _, album in ipairs(list) do
    if album.musicList then
      table.sort(album.musicList, function(a, b)
        return a.id < b.id
      end)
    end
  end
  for _, album in ipairs(list) do
    local floor = 0
    local nextLockMusicInfo = {}
    for i, v in ipairs(album.musicList) do
      if self._musicIdMap[v.id] and floor < self._musicIdMap[v.id] then
        floor = self._musicIdMap[v.id]
      end
    end
    for _, v in ipairs(self._recordList) do
      if floor < v.floor then
        for i, musicId in ipairs(v.cellID) do
          local record = CAudioPlayerCell:GetRecorder(musicId)
          if record.album == album.record.id then
            nextLockMusicInfo.floor = v.floor
            nextLockMusicInfo.musicRecord = record
            break
          end
        end
      end
      if nextLockMusicInfo.floor then
        break
      end
    end
    if nextLockMusicInfo.floor then
      table.insert(album.musicList, {
        id = nextLockMusicInfo.musicRecord.id,
        record = nextLockMusicInfo.musicRecord,
        floor = nextLockMusicInfo.floor
      })
    end
  end
  return list
end

function BM_YardMusic:GetCanPlayMusicNum()
  local num = 0
  for id, album in pairs(self._yardMusic.albums) do
    for _, music in ipairs(album.musicList) do
      if music.status == SongStatus.unlock then
        num = num + 1
      end
    end
  end
  return num
end

function BM_YardMusic:GetMusicTotalNum()
  return #CAudioPlayerCell:GetAllIds()
end

function BM_YardMusic:SetPlayingId(id)
  if id ~= self:GetPlayingId() then
    local userid = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
    CS.UnityEngine.PlayerPrefs.SetInt(userid .. "YardPlayingId", id)
    LuaNotificationCenter.PostNotification(Common.n_PlayingIdChanged, nil, id)
    local record = CAudioPlayerCell:GetRecorder(id)
    LuaAudioManager.PlayBGM(record.audioID, true)
  end
end

function BM_YardMusic:GetPlayingAudioId()
  local id = self:GetPlayingId()
  local record = CAudioPlayerCell:GetRecorder(id)
  return record.audioID
end

function BM_YardMusic:GetPlayingId()
  local userid = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
  return CS.UnityEngine.PlayerPrefs.GetInt(userid .. "YardPlayingId", 0)
end

function BM_YardMusic:SetSyncMainCity(sync)
  local value = 0
  if sync then
    value = 1
  end
  local userid = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
  CS.UnityEngine.PlayerPrefs.SetInt(userid .. "SyncMainCity", value)
end

function BM_YardMusic:GetSyncMainCity()
  local userid = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
  local value = CS.UnityEngine.PlayerPrefs.GetInt(userid .. "SyncMainCity", 0)
  return value == 1
end

function BM_YardMusic:GetLevel()
  return self._yardMusic.level
end

function BM_YardMusic:GetDispatchRoles()
  return {}
end

function BM_YardMusic:GetPauseTaskNum()
  return 0
end

function BM_YardMusic:GetGetNum()
  local num = 0
  if 0 < self._yardMusic.level then
    for id, album in pairs(self._yardMusic.albums) do
      if album.showNew then
        num = num + 1
      end
    end
    for k, v in pairs(self._yardMusic.rewardMap) do
      if v.rewardStatus == RewardStatus.AVAILABLE then
        num = num + 1
      end
    end
  end
  return num
end

function BM_YardMusic:CheckedAlbum(id)
  local album = self._yardMusic.albums[id]
  if album and album.showNew then
    local copenMusic = LuaNetManager.CreateProtocol("protocol.yard.copenmusic")
    copenMusic.albumId = id
    copenMusic:Send()
    NekoData.DataManager.DM_YardMusic:CheckedAlbum(id)
    LuaNotificationCenter.PostNotification(Common.n_BuildingGetNumChanged, nil, {
      buildingId = DataCommon.YardMusic,
      state = NekoData.BehaviorManager.BM_YardMusic:GetGetNum()
    })
  end
end

function BM_YardMusic:GetRewards()
  return self._yardMusic.rewardMap
end

function BM_YardMusic:GetAlbumMusicTotalNum(id)
  return self._albumTotalNumMap[id] or 0
end

function BM_YardMusic:GetUnlockMusicNum(id)
  local data = self._yardMusic.albums[id]
  if data then
    local num = 0
    for i, v in ipairs(data.musicList) do
      if v.status == SongStatus.unlock then
        num = num + 1
      end
    end
    return num
  else
    return 0
  end
end

return BM_YardMusic
