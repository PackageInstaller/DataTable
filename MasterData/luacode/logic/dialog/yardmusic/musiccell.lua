local SongStatus = LuaNetManager.GetBeanDef("protocol.yard.song")
local MusicCell = class("MusicCell", Dialog)
MusicCell.AssetBundleName = "ui/layouts.yard"
MusicCell.AssetName = "MusicPlayerAldumCell"

function MusicCell:Ctor(...)
  MusicCell.super.Ctor(self, ...)
end

function MusicCell:OnCreate()
  self._panel = self:GetChild("Panel/Panel")
  self._canUnlockPanel = self:GetChild("Panel/Panel/LockBack")
  self._canNotUnlockPanel = self:GetChild("Panel/Undiscovered")
  self._canNotUnlockPanel_txt = self:GetChild("Panel/Undiscovered/Title")
  self._new = self:GetChild("Panel/Panel/New")
  self._select = self:GetChild("Panel/Panel/Select")
  self._musicName = self:GetChild("Panel/Panel/Music")
  self._musicAuthor = self:GetChild("Panel/Panel/Author")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellMouseClicked, self)
end

function MusicCell:OnDestroy()
end

function MusicCell:RefreshCell(data)
  if data.floor then
    self._panel:SetActive(false)
    self._canNotUnlockPanel:SetActive(true)
    self._canUnlockPanel:SetActive(false)
    self._new:SetActive(false)
    self._canNotUnlockPanel_txt:SetText(TextManager.GetText(data.record.audioName))
  else
    self._panel:SetActive(true)
    self._canNotUnlockPanel:SetActive(false)
    self._new:SetActive(data.status == SongStatus.NEW)
    if data.status == SongStatus.unlock then
      self._canUnlockPanel:SetActive(false)
    else
      self._canUnlockPanel:SetActive(true)
    end
    self._musicName:SetText(TextManager.GetText(data.record.audioName))
    self._musicAuthor:SetText(TextManager.GetText(data.record.author))
  end
  self._select:SetActive(self._delegate._selectMusic and data.id == self._delegate._selectMusic.id)
end

function MusicCell:OnCellMouseClicked()
  self._delegate:SelectMusic(self._cellData, false, true)
end

function MusicCell:OnEvent(eventName, args)
  if eventName == "SelectedMusic" then
    self._select:SetActive(self._delegate._selectMusic and self._cellData.id == self._delegate._selectMusic.id)
    self._new:SetActive(self._cellData.status == SongStatus.NEW)
  elseif eventName == "MusicUnlocked" and self._cellData.id == args.id then
    self:RefreshCell(args)
  end
end

return MusicCell
