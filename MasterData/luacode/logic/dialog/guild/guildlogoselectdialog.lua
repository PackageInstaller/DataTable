local CGuildHead = BeanManager.GetTableByName("guild.cguildhead")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local GuildLogoSelectDialog = class("GuildLogoSelectDialog", Dialog)
GuildLogoSelectDialog.AssetBundleName = "ui/layouts.guild"
GuildLogoSelectDialog.AssetName = "GuildLogo"

function GuildLogoSelectDialog:Ctor(...)
  GuildLogoSelectDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._selectData = nil
  self._delegate = nil
  self._data = {}
end

function GuildLogoSelectDialog:OnCreate()
  self._logo = self:GetChild("Back/Logo")
  self._name = self:GetChild("Back/Name")
  self._panel = self:GetChild("Back/Frame")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function GuildLogoSelectDialog:OnDestroy()
  self._frame:Destroy()
end

function GuildLogoSelectDialog:Init(delegate, index)
  self._data = {}
  self._delegate = delegate
  self._frame = GridFrame.Create(self._panel, self, true, 3)
  local allId = CGuildHead:GetAllIds()
  local recorder, temp
  for i, v in ipairs(allId) do
    recorder = CGuildHead:GetRecorder(v)
    table.insert(self._data, recorder)
  end
  table.sort(self._data, function(a, b)
    return a.SortId < b.SortId
  end)
  self._frame:ReloadAllCell()
  self:OnCellClicked(CGuildHead:GetRecorder(index))
end

function GuildLogoSelectDialog:OnBackBtnClicked()
  self:Destroy()
end

function GuildLogoSelectDialog:OnCellClicked(data)
  self._selectData = data
  local recorder = CGuildHead:GetRecorder(data.id)
  local imageRecord = CImagePath:GetRecorder(recorder.BigUiId) or DataCommon.DefaultImageAsset
  self._logo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(data.NameId))
  self._frame:FireEvent("Select", data.id)
end

function GuildLogoSelectDialog:OnConfirmBtnClicked()
  self._delegate:SetHead(self._selectData)
  self:Destroy()
end

function GuildLogoSelectDialog:GetAvatarId()
  return self._delegate._avatarId
end

function GuildLogoSelectDialog:NumberOfCell(frame)
  return #self._data
end

function GuildLogoSelectDialog:CellAtIndex(frame, index)
  return "guild.guildlogocell"
end

function GuildLogoSelectDialog:DataAtIndex(frame, index)
  return self._data[index]
end

return GuildLogoSelectDialog
