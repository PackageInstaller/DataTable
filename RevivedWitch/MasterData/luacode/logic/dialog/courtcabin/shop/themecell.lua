-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/themecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDormFurnitureGroup = (BeanManager.GetTableByName)("courtyard.cdormfurnituregroup")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ThemeCell = class("ThemeCell", Dialog)
ThemeCell.AssetBundleName = "ui/layouts.yard"
ThemeCell.AssetName = "FurnitureThemeCell"
ThemeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ThemeCell
  ((ThemeCell.super).Ctor)(self, ...)
end

ThemeCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Back/Item")
  self._name = self:GetChild("Back/NameBack/Name")
  self._comfortIcon = self:GetChild("Back/Comfortable/ComfortableImg")
  self._comfortNum = self:GetChild("Back/Comfortable/ComfortableNum")
  self._num = self:GetChild("Back/Num/Num")
  self._new = self:GetChild("Back/New")
  self._soldOut = self:GetChild("Back/SoldOut")
  self._select = self:GetChild("Back/Select")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ThemeCell.OnDestroy = function(self)
  -- function num : 0_2
end

ThemeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CDormFurnitureGroup, CImagePathTable, _ENV
  self._themeId = (data.serverData).goodId
  local record = CDormFurnitureGroup:GetRecorder((data.serverData).goodId)
  local imgRecord = CImagePathTable:GetRecorder(record.image)
  ;
  (self._icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.nameTextID))
  imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  ;
  (self._comfortIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._comfortNum):SetText(data.comfort)
  ;
  (self._new):SetActive((((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. (DataCommon.CabinGoodsType).Theme .. tostring((data.serverData).goodId), (DataCommon.CabinGoodsStatus).Default) == (DataCommon.CabinGoodsStatus).NewAdd)
  if data.stock <= 0 then
    (self._soldOut):SetActive(true)
    ;
    (self._num):SetText(data.totalFurnitureNum .. "/" .. data.totalFurnitureNum)
  else
    (self._soldOut):SetActive(false)
    ;
    (self._num):SetText(data.haveFurnitureNum .. "/" .. data.totalFurnitureNum)
  end
  ;
  (self._select):SetActive(self._themeId == (self._delegate)._selectThemeId)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

ThemeCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):SetSelectTheme(self._themeId)
end

ThemeCell.OnEvent = function(self, eventName, args)
  -- function num : 0_5 , upvalues : _ENV
  if self._themeId ~= (self._delegate)._selectThemeId then
    (self._select):SetActive(eventName ~= "SetSelectTheme")
    if (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. (DataCommon.CabinGoodsType).Theme .. tostring(args), (DataCommon.CabinGoodsStatus).Default) ~= (DataCommon.CabinGoodsStatus).NewAdd then
      (self._new):SetActive(eventName ~= "ThemeChecked" or ((self._cellData).serverData).goodId ~= args)
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
end

return ThemeCell

