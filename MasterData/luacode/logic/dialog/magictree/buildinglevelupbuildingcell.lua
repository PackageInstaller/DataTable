local CStringres = BeanManager.GetTableByName("message.cstringres")
local CCourtyardNameCfg = BeanManager.GetTableByName("courtyard.ccourtyardname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CTreeLvUp = BeanManager.GetTableByName("courtyard.ctreelvup")
local BuildingLevelUpBuildingCell = class("BuildingLevelUpBuildingCell", Dialog)
BuildingLevelUpBuildingCell.AssetBundleName = "ui/layouts.yard"
BuildingLevelUpBuildingCell.AssetName = "MagicTreeLevelUpCell1"

function BuildingLevelUpBuildingCell:Ctor(...)
  BuildingLevelUpBuildingCell.super.Ctor(self, ...)
end

function BuildingLevelUpBuildingCell:OnCreate()
  self._title = self:GetChild("Title")
  self._icon = self:GetChild("Image")
  self._lv = self:GetChild("LVNum")
  self._tips = self:GetChild("TipsFrame")
  self._tips:SetActive(false)
end

function BuildingLevelUpBuildingCell:OnDestroy()
end

function BuildingLevelUpBuildingCell:RefreshCell(data)
  local courtYardRecord = CCourtyardNameCfg:GetRecorder(data.id)
  self._title:SetText(TextManager.GetText(courtYardRecord.nameTextID))
  local imageRecord
  if data.id == DataCommon.MagicTree then
    imageRecord = CImagePathTable:GetRecorder(CTreeLvUp:GetRecorder(data.cdtLv).image) or DataCommon.DefaultImageAsset
  else
    imageRecord = CImagePathTable:GetRecorder(courtYardRecord.yardconstructionicon) or DataCommon.DefaultImageAsset
  end
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = ""
  if data.curLv >= data.cdtLv then
    self._enough = true
    str = TextManager.GetText(CStringres:GetRecorder(1306).msgTextID)
    str = string.gsub(str, "%$parameter1%$", data.curLv)
  else
    self._enough = false
    str = TextManager.GetText(CStringres:GetRecorder(1307).msgTextID)
    str = string.gsub(str, "%$parameter1%$", data.curLv)
  end
  str = string.gsub(str, "%$parameter2%$", data.cdtLv)
  self._lv:SetText(str)
end

function BuildingLevelUpBuildingCell:OnEvent(eventName, arg)
  if eventName == "ShowTips" then
    self._tips:SetActive(not self._enough)
  end
end

return BuildingLevelUpBuildingCell
