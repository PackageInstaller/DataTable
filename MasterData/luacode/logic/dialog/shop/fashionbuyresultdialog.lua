local Item = require("logic.manager.experimental.types.item")
local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Role = require("logic.manager.experimental.types.role")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local UIBackManager = require("framework.ui.uibackmanager")
local FashionBuyResultDialog = class("FashionBuyResultDialog", Dialog)
FashionBuyResultDialog.AssetBundleName = "ui/layouts.baseshop"
FashionBuyResultDialog.AssetName = "FashionGet"

function FashionBuyResultDialog:Ctor(...)
  FashionBuyResultDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._handler = nil
  self._roleData = nil
  self._hasRole = false
  self._isFromeBreak = false
  self._skinRecorder = nil
end

function FashionBuyResultDialog:OnCreate()
  self._rolePanel = self:GetChild("Role")
  self._live2D = self:GetChild("Role/Live2D")
  self._rolePhoto = self:GetChild("Role/Photo")
  self._jobImg = self:GetChild("UI/Job")
  self._jobTxt = self:GetChild("UI/JobTxt")
  self._jobTxtBack = self:GetChild("UI/JobTxtBack")
  self._lightBack = self:GetChild("UI/LightBack")
  self._shortInfo = self:GetChild("UI/ShortInfo")
  self._name = self:GetChild("UI/ShortInfo/Name")
  self._shortName = self:GetChild("UI/ShortInfo/ShortName")
  self._fashionName = self:GetChild("UI/Name")
  self._tips = self:GetChild("UI/Tips")
  self._closeBtn = self:GetChild("UI/CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._changeBtn = self:GetChild("UI/ChangeBtn")
  self._changeBtn:Subscribe_PointerClickEvent(self.OnChangeBtnClick, self)
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  UIBackManager.SwitchToNext()
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(3)
end

function FashionBuyResultDialog:OnBackBtnClicked()
  self:Destroy()
end

function FashionBuyResultDialog:OnChangeBtnClick()
  if not self._hasRole then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100406)
    return
  end
  if self._isFromeBreak then
    local roleInfoDialog = DialogManager.GetDialog("character.newcharacterinfodialog")
    roleInfoDialog:SetLive2D(self._roleData, self._skinRecorder)
  end
  local cmd = LuaNetManager.CreateProtocol("protocol.item.cchangeskin")
  cmd.roleId = self._roleData:GetId()
  cmd.skin2Change = self._itemInfo.itemId
  cmd:Send()
end

function FashionBuyResultDialog:OnDestroy()
  if self._handler then
    self._live2D:Release(self._handler)
    self._live2D = nil
    self._handler = nil
  end
  if self._isFromeBreak then
    self._skinRecorder = skin
    local roleInfoDialog = DialogManager.GetDialog("character.newcharacterinfodialog")
    roleInfoDialog:GetRootWindow():SetLocalScale(1, 1, 1)
  end
  UIBackManager.SetUIBackShow(false)
end

function FashionBuyResultDialog:SetData(iteminfo, isFromeBreak)
  self._itemInfo = iteminfo
  self._isFromeBreak = isFromeBreak
  local skin = CSkin:GetRecorder(iteminfo.itemId)
  if self._isFromeBreak then
    self._skinRecorder = skin
    local roleInfoDialog = DialogManager.GetDialog("character.newcharacterinfodialog")
    roleInfoDialog:SetActive(false)
  end
  if skin.roleid == 1 then
    self._animator:SetBool("isNoName", true)
    self._lightBack:SetActive(false)
  end
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(skin.roleid)
  self._hasRole = role ~= nil
  role = role or Role.Create(skin.roleid)
  self._tips:SetActive(not self._hasRole)
  self._changeBtn:SetInteractable(self._hasRole)
  self._roleData = role
  self._roleName = role:GetRoleName()
  self._fashionName:SetText(TextManager.GetText(skin.skinNameTextID))
  self._name:SetText(role:GetRoleName())
  self._shortName:SetText(role:GetTitleName())
  local image = role:GetVocationImgDrawRecord()
  self._jobImg:SetSprite(image.assetBundle, image.assetName)
  local nameId = role:GetVocationNameId()
  self._jobTxt:SetText(TextManager.GetText(nameId))
  local shapeRecord = CNpcShapeTable:GetRecorder(skin.shapeID)
  local isFashionLive2D = skin.shapeType == 2
  if isFashionLive2D and Live2DManager.CanUse() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    if not self._handler then
      self._rolePhoto:SetActive(false)
      self._handler = self._live2D:AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
    end
  else
    local lihuiImage = CImagePathTable:GetRecorder(shapeRecord.lihuiID) or DataCommon.DefaultImageAsset
    self._rolePhoto:SetActive(true)
    self._rolePhoto:SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    self._rolePhoto:SetLocalScale(scale, scale, scale)
    self._rolePhoto:SetAnchoredPosition(shapeRecord.photoLocation[1], shapeRecord.photoLocation[2])
  end
end

return FashionBuyResultDialog
