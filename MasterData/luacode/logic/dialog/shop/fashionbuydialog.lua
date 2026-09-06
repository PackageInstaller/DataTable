local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Role = require("logic.manager.experimental.types.role")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkinShopCfg = BeanManager.GetTableByName("recharge.cskinshopspecialcfg")
local UIBackManager = require("framework.ui.uibackmanager")
local ModelAnimation = require("logic.manager.experimental.types.modelanimation")
local FashionBuyDialog = class("FashionBuyDialog", Dialog)
FashionBuyDialog.AssetBundleName = "ui/layouts.baseshop"
FashionBuyDialog.AssetName = "FashionCharDetail"
local Diamond = DataCommon.DiamodID
local FashionCoin = DataCommon.FashionID
FashionBuyDialog.TargetType = {
  Shop = 1,
  SkinList = 2,
  OnlyShow = 3
}

function FashionBuyDialog:Ctor(...)
  FashionBuyDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._handler = nil
  self._modelHandle = nil
  self._moneyType = {Diamond, FashionCoin}
  self._roleData = nil
  self._fashionName = ""
  self._roleName = ""
  self._openFromShop = false
  self._totalNum = 0
end

function FashionBuyDialog:OnCreate()
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
  self._currencyList = {}
  for i = 1, 2 do
    local t = {
      icon = self:GetChild("Panel/TopGroup/Num" .. i .. "/Icon"),
      text = self:GetChild("Panel/TopGroup/Num" .. i .. "/Text"),
      add = self:GetChild("Panel/TopGroup/Num" .. i .. "/Add"),
      num = 0
    }
    self._currencyList[i] = t
    t.icon:Subscribe_PointerClickEvent(function()
      self:OnCurrencyIconClicked(i)
    end, self)
    t.text:Subscribe_PointerClickEvent(function()
      self:OnCurrencyIconClicked(i)
    end, self)
  end
  local fashionIcon = self:GetChild("Panel/TopGroup/Num2")
  fashionIcon:SetActive(false)
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
  self._price2Txt = self:GetChild("Panel/Detail/Price2/Txt")
  self._leftArrow = self:GetChild("Panel/LeftArrow")
  self._rightArrow = self:GetChild("Panel/RightArrow")
  self._menuBtn = self:GetChild("MenuBtn")
  self._back = self:GetChild("Panel/Detail/Back")
  self._buyBtn = self:GetChild("Panel/Detail/BuyBtn")
  self._boughtBtn = self:GetChild("Panel/Detail/BoughtBtn")
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClick, self)
  self._boughtBtn:Subscribe_PointerClickEvent(self.OnBoughtBtnClicked, self)
  self._backBtn = self:GetChild("Panel/BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._backBtn_text = self:GetChild("Panel/BackBtn/Text")
  self._modelBack = self:GetChild("Panel/Detail/ModelBack")
  self._modelBack:Subscribe_PointerClickEvent(self.OnModelBackClick, self)
  self._showBtn:Subscribe_PointerClickEvent(self.OnShowFashionClicked, self)
  LuaNotificationCenter.AddObserver(self, self.UpdateMoney, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBackBtnClicked, Common.n_RefreshShopInfo, nil)
  UIBackManager.SwitchToNext()
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(3)
end

function FashionBuyDialog:OnModelBackClick()
  if self._modelPrefabName == nil then
    return
  end
  if self._modelAnimation == nil then
    local modelObj = self._model:GetUIObject().transform:GetChild(0):GetChild(0).gameObject
    self._modelAnimation = ModelAnimation.Create(self._modelPrefabName, modelObj)
    self._modelAnimation:SetSkillList(CSkin:GetRecorder(self._itemInfo.itemId).action)
  end
  if self._modelAnimation then
    self._modelAnimation:PlaySkillCyclically()
  end
end

function FashionBuyDialog:OnBackBtnClicked()
  local dlg = DialogManager.GetDialog("confirmbox.secondconfirmdialog")
  if dlg then
    DialogManager.DestroySingletonDialog("confirmbox.secondconfirmdialog")
  end
  self:Destroy()
end

function FashionBuyDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  UIBackManager.SetUIBackShow(false)
  if self._handler then
    self._live2D:Release(self._handler)
    self._live2D = nil
    self._handler = nil
  end
  if self._modelHandle then
    self._model:Release(self._modelHandle)
    self._modelHandle = nil
    self._model = nil
  end
  self._roleData = nil
  if self._modelAnimation ~= nil then
    self._modelAnimation:Destroy()
    self._modelAnimation = nil
  end
end

function FashionBuyDialog:SetData(target, iteminfo, index, shopid)
  self._target = target
  self._index = index or 1
  self._itemInfos = iteminfo
  self._totalNum = #self._itemInfos
  self._itemInfo = iteminfo[self._index]
  self._leftArrow:SetActive(1 < self._totalNum)
  self._rightArrow:SetActive(1 < self._totalNum)
  if target == FashionBuyDialog.TargetType.Shop then
    self._shopID = shopid
  elseif target == FashionBuyDialog.TargetType.SkinList then
    local skin = CSkin:GetRecorder(self._itemInfo.itemId)
    self._price2Num:SetText(TextManager.GetText(skin.getwayID))
    self._priceBoard:SetActive(false)
    self._boughtBtn:SetActive(false)
    self._buyBtn:SetActive(false)
    self._price2Txt:SetActive(false)
    self._price2Board:SetActive(true)
    self._price2Img:SetActive(false)
  elseif target == FashionBuyDialog.TargetType.OnlyShow then
    self._price2Board:SetActive(false)
    self._priceBoard:SetActive(false)
    self._buyBtn:SetActive(false)
    self._boughtBtn:SetActive(false)
    self._back:SetActive(false)
  end
  local skin = CSkin:GetRecorder(self._itemInfo.itemId)
  if not (self._itemInfo.beginTime and self._itemInfo.endTime) or self._itemInfo.beginTime == 0 or self._itemInfo.endTime == 0 then
    self._left:SetActive(false)
  else
    self._left:SetActive(true)
    self._leftTxt:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._itemInfo.endTime))
  end
  local role = Role.Create(skin.roleid)
  self._roleData = role
  self._roleName = role:GetRoleName()
  self._limit:SetActive(self._itemInfo.endTime and self._itemInfo.endTime > 0 or false)
  self._fashionName = TextManager.GetText(skin.skinNameTextID)
  self._fashionTxt:SetText(self._fashionName)
  self._roleNameTxt:SetText(self._roleName)
  if target == FashionBuyDialog.TargetType.Shop then
    self._backBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1925))
    if self._itemInfo.discount then
      local discount = 0 < self._itemInfo.discount and self._itemInfo.price ~= self._itemInfo.discountPrice
      local hasBought = self._itemInfo.goodRemain ~= 1
      self._boughtBtn:SetActive(hasBought)
      self._buyBtn:SetActive(not hasBought)
      self._back:SetActive(not hasBought)
      self._price2Board:SetActive(not discount and not hasBought)
      self._priceBoard:SetActive(discount and not hasBought)
      if not hasBought then
        if discount then
          local item = Item.Create(self._itemInfo.moneyType)
          local imageRecord = item:GetIcon()
          self._priceImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          self._priceNum:SetText(self._itemInfo.discountPrice)
          self._priceDelete:SetText(self._itemInfo.price)
        else
          local item = Item.Create(self._itemInfo.moneyType)
          local imageRecord = item:GetIcon()
          self._price2Img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          self._price2Num:SetText(tostring(self._itemInfo.discountPrice))
        end
      else
        self._left:SetActive(false)
        self._limit:SetActive(false)
        self._price2Board:SetActive(false)
        self._priceBoard:SetActive(false)
      end
    end
  else
    self._backBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1926))
  end
  self:SetLive2D(skin.shapeID)
  self:UpdateMoney()
  self._artistName:SetText(TextManager.GetText(skin.artistTextID))
  self._desc:SetText(TextManager.GetText(skin.discribeTextID))
  local str = TextManager.GetText(skin.EffectTextID)
  self._addition:SetActive(str ~= "")
  self._actAdditon:SetText(str)
end

function FashionBuyDialog:SetLive2D(shapeid)
  local shapeRecord = CNpcShapeTable:GetRecorder(shapeid)
  self._rolePanel:SetAnimatorTrigger("loadReady")
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
  if Live2DManager.CanUse() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    self._rolePhoto:SetActive(false)
    self._handler = self._live2D:AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    local lihuiImage = CImagePathTable:GetRecorder(shapeRecord.lihuiID) or DataCommon.DefaultImageAsset
    self._rolePhoto:SetActive(true)
    self._rolePhoto:SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    self._rolePhoto:SetLocalScale(scale, scale, scale)
    self._rolePhoto:SetAnchoredPosition(shapeRecord.photoLocation[1], shapeRecord.photoLocation[2])
  end
  if self._modelHandler ~= 0 then
    self._model:ReleaseModel(self._modelHandler)
    self._modelHandler = 0
  end
  if self._modelAnimation ~= nil then
    self._modelAnimation:Destroy()
    self._modelAnimation = nil
  end
  self._modelPrefabName = nil
  if shapeRecord.assetBundleName and shapeRecord.prefabNameUI then
    self._modelPrefabName = shapeRecord.prefabNameUI
    self._modelHandler = self._model:AddModelSync(shapeRecord.assetBundleName, shapeRecord.prefabNameUI)
  end
end

function FashionBuyDialog:UpdateMoney()
  for k, v in ipairs(self._moneyType) do
    local item = Item.Create(v)
    local m = self._currencyList[k]
    if item then
      local icon = item:GetIcon()
      m.icon:SetSprite(icon.assetBundle, icon.assetName)
      m.num = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(v)
      m.text:SetText(m.num)
      m.type = v
      m.add:SetActive(v == Diamond)
      if v == FashionCoin then
        self._totalMoney = m.num
      end
    end
  end
end

function FashionBuyDialog:OnCurrencyIconClicked(index)
  local m = self._currencyList[index]
  if not m then
    return
  end
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(m.type)
    })
    local width, height = m.icon:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, m.icon:GetLocalPointInUiRootPanel())
  end
end

function FashionBuyDialog:OnBuyBtnClick()
  if self._itemInfo.moneyType == DataCommon.DiamodID then
    self:UseDiamond()
  else
    self:UseFashionCoin()
  end
end

function FashionBuyDialog:UseDiamond()
  local rec = CSkinShopCfg:GetRecorder(4)
  local ratio = tonumber(rec.Value)
  local consume = self._itemInfo.discountPrice
  local hasDiamond = NekoData.BehaviorManager.BM_Currency:GetDiamond()
  if consume <= hasDiamond then
    if consume == 0 then
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
      if protocol then
        protocol.shopId = self._shopID
        local map = {}
        map[self._itemInfo.goodId] = 1
        protocol.goods = map
        protocol:Send()
      end
    else
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(62, {
        consume,
        self._roleName,
        self._fashionName
      }, function()
        local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
        if protocol then
          protocol.shopId = self._shopID
          local map = {}
          map[self._itemInfo.goodId] = 1
          protocol.goods = map
          protocol:Send()
        end
      end, {}, nil, {})
    end
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(15, nil, function()
      NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(4)
      DialogManager.DestroySingletonDialog("shop.roleskinlist.roleskinlistmaindialog")
    end, {}, nil, {})
  end
end

function FashionBuyDialog:UseFashionCoin()
  local fashionCoinNum = NekoData.BehaviorManager.BM_Currency:GetFashionCoin()
  local price = self._itemInfo.discountPrice
  if fashionCoinNum >= price then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(62, {
      price,
      self._roleName,
      self._fashionName
    }, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
      if protocol then
        protocol.shopId = self._shopID
        local map = {}
        map[self._itemInfo.goodId] = 1
        protocol.goods = map
        protocol:Send()
      end
    end, {}, nil, {})
  else
    local function buyFunc()
      local rec = CSkinShopCfg:GetRecorder(4)
      
      local needNum = self._itemInfo.discountPrice - fashionCoinNum
      local ratio = tonumber(rec.Value)
      local consume = math.ceil(needNum / ratio)
      needNum = consume * ratio
      local hasDiamond = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(Diamond)
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(64, {consume, needNum}, function()
        if hasDiamond >= consume then
          local cmd = LuaNetManager.CreateProtocol("protocol.shop.cdiamondexchange")
          cmd.costItem = Diamond
          cmd.exchangeCurrencyType = FashionCoin
          cmd.exchangeCurrencySum = needNum
          cmd.costItemSum = consume
          cmd:Send()
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100077)
        end
      end, {}, nil, {})
    end
    
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(63, nil, function()
      NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(3)
    end, {}, nil, {})
  end
end

function FashionBuyDialog:OnBoughtBtnClicked()
  NekoData.BehaviorManager.BM_Message:SendMessageById(100405)
end

function FashionBuyDialog:OnShowFashionClicked()
  DialogManager.CreateSingletonDialog("character.characterfashionshowdialog"):SetData(self._itemInfo.itemId)
end

function FashionBuyDialog:OnLeftArrowClick()
  if self._index > 1 then
    self._index = self._index - 1
  else
    self._index = self._totalNum
  end
  self:SetData(self._target, self._itemInfos, self._index, self._shopID)
end

function FashionBuyDialog:OnRightArrowClick()
  if self._index < self._totalNum then
    self._index = self._index + 1
  else
    self._index = 1
  end
  self:SetData(self._target, self._itemInfos, self._index, self._shopID)
end

return FashionBuyDialog
