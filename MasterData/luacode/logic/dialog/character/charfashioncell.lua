local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local RoleSkin = require("logic.manager.experimental.types.roleskin")
local CharFashionCell = class("CharFashionCell", Dialog)
CharFashionCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharFashionCell.AssetName = "CharClothesCell"

function CharFashionCell:Ctor(...)
  CharFashionCell.super.Ctor(self, ...)
  self._choose = false
end

function CharFashionCell:OnCreate()
  self._img = self:GetChild("Back/Char")
  self._current = self:GetChild("Back/Current")
  self._gray = self:GetChild("Back/Grey")
  self._grayTxt = self:GetChild("Back/Grey/Back/Txt")
  self._live = self:GetChild("Back/Live2d")
  self._select = self:GetChild("Back/Select")
  self._redDot = self:GetChild("Back/RedDot")
  self._name = self:GetChild("Back/Name")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function CharFashionCell:OnDestroy()
end

local function RefreshRedDot(self)
  self._redDot:SetActive(NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(8, {
    self._data.roleId,
    self._data.skinID
  }) > 0)
end

function CharFashionCell:RefreshCell(data)
  self._data = data
  self._skin = RoleSkin.Create(data.skinID)
  local imgRecord = self._skin:GetBigBustImg()
  self._img:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(data.roleId)
  local curWearFashionId = role:GetDefaultFashion()
  local isWearing = curWearFashionId == data.skinID
  self._name:SetText(self._skin:GetSkinName())
  self._current:SetActive(isWearing)
  self._gray:SetActive(not data.hasGotten and not isWearing)
  self._grayTxt:SetText(self._skin:GetGetWayText())
  self._live:SetActive(self._skin:IsShowLiveText())
  self._select:SetActive(self._data.index == self._delegate._curSelectIdx)
  self._choose = self._delegate._curSelectIdx == self._data.index
  RefreshRedDot(self)
end

function CharFashionCell:OnCellClick(args)
  if self._choose then
    return
  end
  self._delegate:UpdateLive2D(self._data)
end

function CharFashionCell:OnEvent(eventName, index)
  if eventName == "select" then
    self._select:SetActive(index == self._data.index)
    self._choose = index == self._data.index
  elseif eventName == "RefreshRedDot" then
    RefreshRedDot(self)
  end
end

return CharFashionCell
