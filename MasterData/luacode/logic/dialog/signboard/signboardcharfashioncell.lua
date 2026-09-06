local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local RoleSkin = require("logic.manager.experimental.types.roleskin")
local SignboardCharFashionCell = class("SignboardCharFashionCell", Dialog)
SignboardCharFashionCell.AssetBundleName = "ui/layouts.signboard"
SignboardCharFashionCell.AssetName = "SignboardClothesCell"

function SignboardCharFashionCell:Ctor(...)
  SignboardCharFashionCell.super.Ctor(self, ...)
  self._choose = false
end

function SignboardCharFashionCell:OnCreate()
  self._img = self:GetChild("Back/Char")
  self._current = self:GetChild("Back/Current")
  self._live = self:GetChild("Back/Live2d")
  self._select = self:GetChild("Back/Select")
  self._name = self:GetChild("Back/Name")
  self._downBlack = self:GetChild("Back/DownBlack")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function SignboardCharFashionCell:OnDestroy()
end

function SignboardCharFashionCell:RefreshCell(data)
  self._data = data
  if data.isAlinna then
    local record = CImagePathTable:GetRecorder(data.data.bigbustID) or DataCommon.DefaultImageAsset
    self._img:SetSprite(record.assetBundle, record.assetName)
    local currentRole = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().backgroundRole
    local isWearing = currentRole == 0
    self._choose = isWearing
    self._current:SetActive(isWearing)
    self._select:SetActive(isWearing)
    self._name:SetActive(false)
    self._downBlack:SetActive(false)
    self._live:SetActive(false)
  else
    local roleSkin = RoleSkin.Create(data.skinID)
    local imgRecord = roleSkin:GetBigBustImg()
    self._img:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    self._name:SetText(roleSkin:GetSkinName())
    local curWearFashionId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().backgroundSkin
    local isWearing = curWearFashionId == data.skinID
    self._choose = isWearing
    self._current:SetActive(isWearing)
    self._select:SetActive(isWearing)
    self._downBlack:SetActive(true)
    self._live:SetActive(roleSkin:IsShowLiveText())
  end
end

function SignboardCharFashionCell:OnCellClick(args)
  if self._choose then
    return
  end
  self._delegate:OnFashionCellClick(self._data)
end

return SignboardCharFashionCell
