-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/fashionbuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Role = require("logic.manager.experimental.types.role")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkinShopCfg = (BeanManager.GetTableByName)("recharge.cskinshopspecialcfg")
local UIBackManager = require("framework.ui.uibackmanager")
local ModelAnimation = require("logic.manager.experimental.types.modelanimation")
local FashionBuyDialog = class("FashionBuyDialog", Dialog)
FashionBuyDialog.AssetBundleName = "ui/layouts.activityspringouting"
FashionBuyDialog.AssetName = "FashionCharDetail"
local Diamond = DataCommon.DiamodID
local FashionCoin = DataCommon.FashionID
FashionBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FashionBuyDialog, Diamond, FashionCoin
  ((FashionBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._handler = nil
  self._modelHandle = nil
  self._moneyType = {Diamond, FashionCoin}
  self._roleData = nil
  self._fashionName = ""
  self._roleName = ""
  self._openFromShop = false
end

FashionBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, UIBackManager
  self._rolePanel = self:GetChild("Role")
  self._live2D = self:GetChild("Role/Live2D")
  self._rolePhoto = self:GetChild("Role/Photo")
  self._fashionTxt = self:GetChild("Panel/Name/Txt")
  self._roleNameTxt = self:GetChild("Panel/CharName/CharName")
  self._left = self:GetChild("Panel/Time")
  self._leftTxt = self:GetChild("Panel/Time/Txt")
  self._showBtn = self:GetChild("Panel/ShowBtn")
  self._addition = self:GetChild("Panel/Activity")
  self._actAdditon = self:GetChild("Panel/Activity/Txt2")
  self._limit = self:GetChild("Panel/Limit")
  self._model = self:GetChild("Panel/Detail/Model")
  self._artistName = self:GetChild("Panel/Detail/ArtistName")
  self._desc = self:GetChild("Panel/Detail/Describe")
  self._priceBoard = self:GetChild("Panel/Detail/Price")
  self._priceImg = self:GetChild("Panel/Detail/Price/Image")
  self._priceNum = self:GetChild("Panel/Detail/Price/Text")
  self._priceDelete = self:GetChild("Panel/Detail/Price/TextDelete")
  self._price2Board = self:GetChild("Panel/Detail/Price2")
  self._price2Img = self:GetChild("Panel/Detail/Price2/Image")
  self._price2Num = self:GetChild("Panel/Detail/Price2/Text")
  self._menuBtn = self:GetChild("MenuBtn")
  self._back = self:GetChild("Panel/Detail/Back")
  self._backBtn = self:GetChild("Panel/BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._modelBack = self:GetChild("Panel/Detail/ModelBack")
  ;
  (self._modelBack):Subscribe_PointerClickEvent(self.OnModelBackClick, self)
  ;
  (self._showBtn):Subscribe_PointerClickEvent(self.OnShowFashionClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBackBtnClicked, Common.n_RefreshShopInfo, nil)
  ;
  (UIBackManager.SwitchToNext)()
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(3)
end

FashionBuyDialog.OnModelBackClick = function(self)
  -- function num : 0_2 , upvalues : ModelAnimation, CSkin
  if self._modelPrefabName == nil then
    return 
  end
  do
    if self._modelAnimation == nil then
      local modelObj = (((((self._model):GetUIObject()).transform):GetChild(0)):GetChild(0)).gameObject
      self._modelAnimation = (ModelAnimation.Create)(self._modelPrefabName, modelObj)
      ;
      (self._modelAnimation):SetSkillList((CSkin:GetRecorder((self._itemInfo).itemId)).action)
    end
    if self._modelAnimation then
      (self._modelAnimation):PlaySkillCyclically()
    end
  end
end

FashionBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dlg = (DialogManager.GetDialog)("confirmbox.secondconfirmdialog")
  if dlg then
    (DialogManager.DestroySingletonDialog)("confirmbox.secondconfirmdialog")
  end
  self:Destroy()
end

FashionBuyDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV, UIBackManager
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
  if self._handler then
    (self._live2D):Release(self._handler)
    self._live2D = nil
    self._handler = nil
  end
  if self._modelHandle then
    (self._model):Release(self._modelHandle)
    self._modelHandle = nil
    self._model = nil
  end
  self._roleData = nil
  if self._modelAnimation ~= nil then
    (self._modelAnimation):Destroy()
    self._modelAnimation = nil
  end
end

FashionBuyDialog.SetData = function(self, iteminfo, shopid, fromShop, index)
  -- function num : 0_5 , upvalues : CSkin, _ENV, Role
  self._itemInfo = iteminfo
  local skin = CSkin:GetRecorder((self._itemInfo).itemId)
  self._shopID = shopid
  if not (self._itemInfo).beginTime or not (self._itemInfo).endTime or (self._itemInfo).beginTime == 0 or (self._itemInfo).endTime == 0 then
    (self._left):SetActive(false)
  else
    ;
    (self._left):SetActive(true)
    ;
    (self._leftTxt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._itemInfo).endTime))
  end
  local role = (Role.Create)(skin.roleid)
  self._roleData = role
  self._roleName = role:GetRoleName()
  -- DECOMPILER ERROR at PC60: Unhandled construct in 'MakeBoolean' P3

  ;
  (self._limit):SetActive(((self._itemInfo).endTime and (self._itemInfo).endTime > 0))
  self._fashionName = (TextManager.GetText)(skin.skinNameTextID)
  ;
  (self._fashionTxt):SetText(self._fashionName)
  ;
  (self._roleNameTxt):SetText(self._roleName)
  self:SetLive2D(skin.shapeID)
  if tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(101)).Value) == 1 then
    (self._artistName):SetText((TextManager.GetText)(skin.artistTextID))
  else
    (self._artistName):SetText((TextManager.GetText)(skin.overseasArtistTextID))
  end
  ;
  (self._desc):SetText((TextManager.GetText)(skin.discribeTextID))
  local str = (TextManager.GetText)(skin.EffectTextID)
  ;
  (self._addition):SetActive(str ~= "")
  ;
  (self._actAdditon):SetText(str)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

FashionBuyDialog.SetLive2D = function(self, shapeid)
  -- function num : 0_6 , upvalues : CNpcShapeTable, _ENV, CImagePathTable
  local shapeRecord = CNpcShapeTable:GetRecorder(shapeid)
  ;
  (self._rolePanel):SetAnimatorTrigger("loadReady")
  if self._handler then
    (self._live2D):Release(self._handler)
    self._handler = nil
  end
  if (Live2DManager.CanUse)() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    (self._rolePhoto):SetActive(false)
    self._handler = (self._live2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    if not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
      local lihuiImage = DataCommon.DefaultImageAsset
    end
    ;
    (self._rolePhoto):SetActive(true)
    ;
    (self._rolePhoto):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    ;
    (self._rolePhoto):SetLocalScale(scale, scale, scale)
    ;
    (self._rolePhoto):SetAnchoredPosition((shapeRecord.photoLocation)[1], (shapeRecord.photoLocation)[2])
  end
  do
    if self._modelHandler ~= 0 then
      (self._model):ReleaseModel(self._modelHandler)
      self._modelHandler = 0
    end
    if self._modelAnimation ~= nil then
      (self._modelAnimation):Destroy()
      self._modelAnimation = nil
    end
    self._modelPrefabName = nil
    if shapeRecord.assetBundleName and shapeRecord.prefabNameUI then
      self._modelPrefabName = shapeRecord.prefabNameUI
      self._modelHandler = (self._model):AddModelSync(shapeRecord.assetBundleName, shapeRecord.prefabNameUI)
    end
  end
end

FashionBuyDialog.OnShowFashionClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("character.characterfashionshowdialog")):SetData((self._itemInfo).itemId)
end

return FashionBuyDialog

