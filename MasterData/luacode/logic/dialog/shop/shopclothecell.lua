local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CCommoditClothes = BeanManager.GetTableByName("recharge.ccommoditclothes")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local ShopClotheCell = class("ShopClotheCell", Dialog)
ShopClotheCell.AssetBundleName = "ui/layouts.baseshop"
ShopClotheCell.AssetName = "FashionShopCell"

function ShopClotheCell:Ctor(...)
  ShopClotheCell.super.Ctor(self, ...)
end

function ShopClotheCell:OnCreate()
  self._img = self:GetChild("Cell/Char")
  self._name = self:GetChild("Cell/Name")
  self._roleName = self:GetChild("Cell/CharName/CharName")
  self._limitTag = self:GetChild("Cell/Limit")
  self._limit = self:GetChild("Cell/Time")
  self._limitT = self:GetChild("Cell/Time/Txt")
  self._buy = self:GetChild("Cell/Buy")
  self._sale = self:GetChild("Cell/Sale")
  self._freeBack = self:GetChild("Cell/FreeBack")
  self._priceFree = self:GetChild("Cell/PriceFree")
  self._pirceBoard = self:GetChild("Cell/Price")
  self._priceImg = self:GetChild("Cell/Price/Image")
  self._priceNum = self:GetChild("Cell/Price/Text")
  self._priceDelete = self:GetChild("Cell/Price/TextDelete")
  self._price2Board = self:GetChild("Cell/Price2")
  self._price2Img = self:GetChild("Cell/Price2/Image")
  self._price2Num = self:GetChild("Cell/Price2/Text")
  self._redDot = self:GetChild("Cell/RedDot")
  self._back = self:GetChild("Cell/Back")
  self._backFree = self:GetChild("Cell/BackFree")
  self._downBlack = self:GetChild("Cell/DownBlack")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ShopClotheCell:OnDestroy()
end

function ShopClotheCell:RefreshCell(data)
  self._data = data
  self._index = data.index
  self._redDotNodes = self._data.itemRedDotNodes
  if self._delegate._delegate._selectShopID == 15 then
    self._buy:SetActive(true)
    self._sale:SetActive(false)
    self._priceFree:SetActive(false)
    self._freeBack:SetActive(false)
    self._downBlack:SetActive(true)
    self._backFree:SetActive(false)
    self._back:SetActive(true)
    self._pirceBoard:SetActive(false)
    self._price2Board:SetActive(false)
    self._limit:SetActive(false)
    self._limitTag:SetActive(false)
  else
    local hasBought = self._data.iteminfo.goodRemain == 0
    self._buy:SetActive(hasBought)
    local noDiscount = self._data.iteminfo.discount == -1 or self._data.iteminfo.discount == 10
    if noDiscount and 0 < self._data.iteminfo.discountPrice then
      self._sale:SetActive(false)
      self._priceFree:SetActive(false)
      self._freeBack:SetActive(false)
      self._downBlack:SetActive(true)
      self._pirceBoard:SetActive(false)
      self._price2Board:SetActive(not hasBought)
      local item = Item.Create(self._data.iteminfo.moneyType)
      local imageRecord = item:GetIcon()
      self._price2Img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._price2Num:SetText(self._data.iteminfo.discountPrice)
      self._backFree:SetActive(false)
      self._back:SetActive(true)
    elseif noDiscount and self._data.iteminfo.discountPrice == 0 then
      self._sale:SetActive(false)
      self._priceFree:SetActive(not hasBought)
      self._freeBack:SetActive(true)
      self._downBlack:SetActive(false)
      self._pirceBoard:SetActive(false)
      self._price2Board:SetActive(false)
      self._backFree:SetActive(true)
      self._back:SetActive(false)
    elseif not noDiscount then
      self._sale:SetActive(true)
      self._priceFree:SetActive(false)
      self._freeBack:SetActive(false)
      self._downBlack:SetActive(true)
      self._pirceBoard:SetActive(not hasBought)
      self._price2Board:SetActive(false)
      local item = Item.Create(self._data.iteminfo.moneyType)
      local imageRecord = item:GetIcon()
      self._priceImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._priceNum:SetText(self._data.iteminfo.discountPrice)
      self._priceDelete:SetText(self._data.iteminfo.price)
      imageRecord = NekoData.BehaviorManager.BM_Shop:GetDiscountAsset(self._data.iteminfo.discount)
      self._sale:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._backFree:SetActive(false)
      self._back:SetActive(true)
    else
      LogErrorFormat("ShopClotheCell", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", self._data.iteminfo.discount, self._data.iteminfo.discountPrice)
    end
    if self._data.iteminfo.endTime and 0 < self._data.iteminfo.endTime then
      self._limit:SetActive(true)
      self._limitT:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._data.iteminfo.endTime))
    else
      self._limit:SetActive(false)
    end
    local record = CCommoditClothes:GetRecorder(self._data.iteminfo.goodId)
    self._limitTag:SetActive(record.TimeLimit == 1)
  end
  local skin = CSkin:GetRecorder(self._data.iteminfo.itemId)
  local record = CImagePathTable:GetRecorder(CNpcShapeTable:GetRecorder(skin.shapeID).bigbustID) or DataCommon.DefaultImageAsset
  self._img:SetSprite(record.assetBundle, record.assetName)
  self._name:SetText(TextManager.GetText(skin.skinNameTextID))
  local role = Role.Create(skin.roleid)
  self._roleName:SetText(role:GetRoleName())
  if self._redDotNodes then
    self._redDotNode = self._redDotNodes.childNode[tostring(self._data.iteminfo.goodId)]
  else
    self._redDotNode = nil
  end
  self:ShowRedDot()
end

function ShopClotheCell:OnCellClicked()
  if self._data.iteminfo.goodRemain == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100314)
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("shop.fashionbuydialog")
  if dialog then
    if self._redDotResult and self._redDotNode then
      DM_RedDot.SetNodeRead(self._redDotNode, true)
      if not DM_RedDot.GetNodeResult(self._redDotNode) then
        LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
      end
    end
    dialog:SetData(dialog.TargetType.Shop, self._delegate._goodInfoData, self._data.index, self._delegate._delegate._selectShopID)
  end
end

function ShopClotheCell:OnEvent(eventName, arg)
  if eventName == "BuyGoodRefresh" then
    local info = arg.goodInfo[self._data.iteminfo.goodId]
    if info then
      for key, _ in pairs(self._data.iteminfo) do
        self._data.iteminfo[key] = info[key]
      end
      if self._data.iteminfo.goodRemain == 0 then
        self._data.iteminfo.endTime = 0
      end
      self:RefreshCell({
        iteminfo = self._data.iteminfo,
        index = self._index
      })
      if self._redDotNode then
        self._redDotNode.childNode.hasFreeGoodNotBuy.haveRedDot = info.discountPrice == 0 and info.goodRemain ~= 0
        if self._redDotResult ~= DM_RedDot.GetNodeResult(self._redDotNode) then
          LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
        end
      end
    end
  elseif eventName == "RedPointInfo" then
    self:ShowRedDot()
  end
end

function ShopClotheCell:ShowRedDot()
  if self._redDotNode then
    self._redDotResult = DM_RedDot.GetNodeResult(self._redDotNode)
    self._redDot:SetActive(self._redDotResult)
  else
    self._redDot:SetActive(false)
  end
end

return ShopClotheCell
