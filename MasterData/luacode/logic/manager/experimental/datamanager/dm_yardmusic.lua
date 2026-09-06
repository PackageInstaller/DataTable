local CAudioPlayerCell = BeanManager.GetTableByName("courtyard.caudioplayercell")
local SongStatus = LuaNetManager.GetBeanDef("protocol.yard.song")
local RewardStatus = LuaNetManager.GetBeanDef("protocol.yard.musiccollectionrewardsstatus")
local DM_YardMusic = class("DM_YardMusic")

function DM_YardMusic:Ctor()
  self._yardMusic = NekoData.Data.yardMusic
  self._yardMusic.level = 0
  self._yardMusic.list = {}
  self._yardMusic.albums = {}
  self._yardMusic.rewardMap = {}
  self._musicRecords = {}
  local allIds = CAudioPlayerCell:GetAllIds()
  local len = #allIds
  for i = 1, len do
    self._musicRecords[allIds[i]] = CAudioPlayerCell:GetRecorder(allIds[i])
  end
end

function DM_YardMusic:Clear()
  self._yardMusic.level = 0
  self._yardMusic.list = {}
  for k, v in pairs(self._yardMusic.albums) do
    self._yardMusic.albums[k] = nil
  end
  for k, v in pairs(self._yardMusic.rewardMap) do
    self._yardMusic.rewardMap[k] = nil
  end
end

function DM_YardMusic:OnSYardInfo(protocol)
  self:RefreshYardMusic(protocol.music)
  if NekoData.BehaviorManager.BM_YardMusic:GetPlayingId() == 0 and 0 < self._yardMusic.level then
    local allIds = CAudioPlayerCell:GetAllIds()
    local userid = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
    CS.UnityEngine.PlayerPrefs.SetInt(userid .. "YardPlayingId", allIds[1])
  end
end

function DM_YardMusic:OnSInitMusic(protocol)
  self:RefreshYardMusic(protocol.music)
end

function DM_YardMusic:RefreshYardMusic(yardMusicInfo)
  self._yardMusic.level = yardMusicInfo.level
  while self._yardMusic.list[#self._yardMusic.list] do
    table.remove(self._yardMusic.list, #self._yardMusic.list)
  end
  for i, v in ipairs(yardMusicInfo.songs) do
    local record = self._musicRecords[v.id]
    if record then
      if not self._yardMusic.albums[record.album] then
        self._yardMusic.albums[record.album] = {
          musicList = {}
        }
      end
      table.insert(self._yardMusic.albums[record.album].musicList, {
        id = v.id,
        status = v.statue,
        record = record
      })
      if v.statue == SongStatus.NEW then
        self._yardMusic.albums[record.album].showNew = true
      end
    else
      LogErrorFormat("DM_YardMusic", "recorder with id %s is not exist in caudioplayercell", v.id)
    end
  end
end

function DM_YardMusic:OnSLockSong(protocol)
  for i, v in ipairs(protocol.id) do
    local record = self._musicRecords[v]
    if record then
      if not self._yardMusic.albums[record.album] then
        self._yardMusic.albums[record.album] = {
          musicList = {}
        }
      end
      table.insert(self._yardMusic.albums[record.album].musicList, {
        id = v,
        status = SongStatus.NEW,
        record = record
      })
      self._yardMusic.albums[record.album].showNew = true
    else
      LogErrorFormat("DM_YardMusic", "recorder with id %s is not exist in caudioplayercell", v)
    end
  end
end

function DM_YardMusic:OnSUnlockSong(protocol)
  local record = self._musicRecords[protocol.id]
  if record then
    local map = self._yardMusic.albums[record.album]
    if map then
      for i, v in ipairs(map.musicList) do
        if v.id == protocol.id then
          v.status = SongStatus.unlock
          break
        end
      end
    else
      LogErrorFormat("DM_YardMusic", "data with id %s is not exist in albums(id: %s)", protocol.id, record.album)
    end
  else
    LogErrorFormat("DM_YardMusic", "recorder with id %s is not exist in caudioplayercell", v.id)
  end
end

function DM_YardMusic:OnSMusicCollectionRewardsAchieved(protocol)
  for i, v in ipairs(protocol.musicCollectionRewardsStates) do
    if not self._yardMusic.rewardMap[v.rewardsId] then
      self._yardMusic.rewardMap[v.rewardsId] = {
        rewardId = v.rewardsId,
        rewardStatus = v.rewardsStatue
      }
    else
      self._yardMusic.rewardMap[v.rewardsId].rewardStatus = v.rewardsStatue
    end
  end
end

function DM_YardMusic:CheckedAlbum(id)
  local album = self._yardMusic.albums[id]
  if album then
    for i, v in ipairs(album.musicList) do
      if v.status == SongStatus.NEW then
        v.status = SongStatus.lock
      end
    end
    album.showNew = false
  end
end

return DM_YardMusic
