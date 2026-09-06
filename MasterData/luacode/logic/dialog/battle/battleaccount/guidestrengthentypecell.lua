local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GuideStrengthenTypeCell = class("GuideStrengthenTypeCell", Dialog)
GuideStrengthenTypeCell.AssetBundleName = "ui/layouts.battlelose"
GuideStrengthenTypeCell.AssetName = "DefeatGuideWayCell"

function GuideStrengthenTypeCell:Ctor(...)
  GuideStrengthenTypeCell.super.Ctor(self, ...)
end

function GuideStrengthenTypeCell:OnCreate()
  self._icon_normal = self:GetChild("Image")
  self._txt_normal = self:GetChild("Txt")
  self._icon_select = self:GetChild("Select")
  self._txt_select = self:GetChild("TxtSelect")
  self._recommend = self:GetChild("recommend")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function GuideStrengthenTypeCell:OnDestroy()
end

local function Select(self, select)
  self._icon_normal:SetActive(not select)
  self._txt_normal:SetActive(not select)
  self._icon_select:SetActive(select)
  self._txt_select:SetActive(select)
end

function GuideStrengthenTypeCell:RefreshCell(data)
  local iconId_normal, txtId_normal, iconId_select, txtId_select
  if data.tag == "RoleLevelUp" then
    iconId_normal = 12610
    iconId_select = 12611
    txtId_normal = 701092
    txtId_select = 701089
  elseif data.tag == "RoleStrengthenEquip" then
    iconId_normal = 12608
    iconId_select = 12609
    txtId_normal = 701094
    txtId_select = 701091
  elseif data.tag == "ImproveSkill" then
    iconId_normal = 12612
    iconId_select = 12613
    txtId_normal = 701093
    txtId_select = 701090
  end
  local imageRecord = CImagePathTable:GetRecorder(iconId_normal) or DataCommon.DefaultImageAsset
  self._icon_normal:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePathTable:GetRecorder(iconId_select) or DataCommon.DefaultImageAsset
  self._icon_select:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._txt_normal:SetText(TextManager.GetText(txtId_normal))
  self._txt_select:SetText(TextManager.GetText(txtId_select))
  if self._delegate._selectGuideType and data.tag == self._delegate._selectGuideType.tag then
    Select(self, true)
  else
    Select(self, false)
  end
  if self._delegate._recommendTag and data.tag == self._delegate._recommendTag then
    self._recommend:SetActive(true)
  else
    self._recommend:SetActive(false)
  end
end

function GuideStrengthenTypeCell:OnCellClick()
  self._delegate:SetSelect(self._cellData)
end

function GuideStrengthenTypeCell:OnEvent()
  if self._delegate._selectGuideType and self._cellData.tag == self._delegate._selectGuideType.tag then
    Select(self, true)
  else
    Select(self, false)
  end
end

return GuideStrengthenTypeCell
