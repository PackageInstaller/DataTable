local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CGuildHead = BeanManager.GetTableByName("guild.cguildhead")
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60
local GuildLogoCell = class("GuildLogoCell", Dialog)
GuildLogoCell.AssetBundleName = "ui/layouts.guild"
GuildLogoCell.AssetName = "GuildLogoCell"

function GuildLogoCell:Ctor(...)
  GuildLogoCell.super.Ctor(self, ...)
end

function GuildLogoCell:OnCreate()
  self._back = self:GetChild("LogoBack")
  self._logo = self:GetChild("Logo")
  self._select = self:GetChild("Select")
  self._logo:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function GuildLogoCell:RefreshCell(data)
  local recorder = CGuildHead:GetRecorder(data.id)
  local imageRecord = CImagePath:GetRecorder(recorder.UiId) or DataCommon.DefaultImageAsset
  self._logo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function GuildLogoCell:OnCellClicked()
  self._delegate:OnCellClicked(self._cellData)
end

function GuildLogoCell:OnEvent(eventName, arg)
  if eventName == "Select" then
    if arg == self._cellData.id then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
end

return GuildLogoCell
