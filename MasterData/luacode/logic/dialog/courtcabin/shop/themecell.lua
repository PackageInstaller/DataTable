local CDormFurnitureGroup = BeanManager.GetTableByName("courtyard.cdormfurnituregroup")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ThemeCell = class("ThemeCell", Dialog)
ThemeCell.AssetBundleName = "ui/layouts.yard"
ThemeCell.AssetName = "FurnitureThemeCell"

function ThemeCell:Ctor(...)
  ThemeCell.super.Ctor(self, ...)
end

function ThemeCell:OnCreate()
  self._icon = self:GetChild("Back/Item")
  self._name = self:GetChild("Back/NameBack/Name")
  self._comfortIcon = self:GetChild("Back/Comfortable/ComfortableImg")
  self._comfortNum = self:GetChild("Back/Comfortable/ComfortableNum")
  self._num = self:GetChild("Back/Num/Num")
  self._new = self:GetChild("Back/New")
  self._soldOut = self:GetChild("Back/SoldOut")
  self._select = self:GetChild("Back/Select")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ThemeCell:OnDestroy()
end

function ThemeCell:RefreshCell(data)
  self._themeId = data.serverData.goodId
  local record = CDormFurnitureGroup:GetRecorder(data.serverData.goodId)
  local imgRecord = CImagePathTable:GetRecorder(record.image)
  self._icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._name:SetText(TextManager.GetText(record.nameTextID))
  imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._comfortNum:SetText(data.comfort)
  self._new:SetActive(CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.CabinGoodsType.Theme .. tostring(data.serverData.goodId), DataCommon.CabinGoodsStatus.Default) == DataCommon.CabinGoodsStatus.NewAdd)
  if data.stock <= 0 then
    self._soldOut:SetActive(true)
    self._num:SetText(data.totalFurnitureNum .. "/" .. data.totalFurnitureNum)
  else
    self._soldOut:SetActive(false)
    self._num:SetText(data.haveFurnitureNum .. "/" .. data.totalFurnitureNum)
  end
  self._select:SetActive(self._themeId == self._delegate._selectThemeId)
end

function ThemeCell:OnCellClicked()
  self._delegate:SetSelectTheme(self._themeId)
end

function ThemeCell:OnEvent(eventName, args)
  if eventName == "SetSelectTheme" then
    self._select:SetActive(self._themeId == self._delegate._selectThemeId)
  elseif eventName == "ThemeChecked" and self._cellData.serverData.goodId == args then
    self._new:SetActive(CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.CabinGoodsType.Theme .. tostring(args), DataCommon.CabinGoodsStatus.Default) == DataCommon.CabinGoodsStatus.NewAdd)
  end
end

return ThemeCell
