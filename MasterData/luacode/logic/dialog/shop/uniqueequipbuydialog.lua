local UIManager = CS.PixelNeko.UI.UIManager
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UniqueEquipBuyDialog = class("UniqueEquipBuyDialog", Dialog)
UniqueEquipBuyDialog.AssetBundleName = "ui/layouts.baseshop"
UniqueEquipBuyDialog.AssetName = "ExclusiveEquipBuy"

function UniqueEquipBuyDialog:Ctor(...)
  UniqueEquipBuyDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._attrList = {}
end

function UniqueEquipBuyDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._charBack = self:GetChild("Back/Char/Frame")
  self._charIcon = self:GetChild("Back/Char/Photo")
  self._charName = self:GetChild("Back/CharName")
  self._priceTypeImage = self:GetChild("Back/Price/Image")
  self._priceNum = self:GetChild("Back/Price/Num")
  self._attrPanel = self:GetChild("Back/Frame/Property")
  self._attrFrame = TableFrame.Create(self._attrPanel, self, true, true, true)
  self:GetChild("Back/Frame/Txt1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1553))
  self:GetChild("Back/Frame/Txt2"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1558))
  self:GetChild("Back/Frame/Txt3"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1555))
  self._skillEffect = self:GetChild("Back/Frame/Txt4/Txt4")
  self._unlockEffect_width, self._unlockEffect_height = self._skillEffect:GetRectSize()
  self._anchorMinX1, self._anchorMinY1, self._anchorMaxX1, self._anchorMaxY1, self._offsetMinX1, self._offsetMinY1, self._offsetMaxX1, self._offsetMaxY1 = self._skillEffect:GetAnchorAndOffset()
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function UniqueEquipBuyDialog:OnDestroy()
  self._attrFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function UniqueEquipBuyDialog:SetData(iteminfo, shopid)
  self._itemInfo = iteminfo
  self._shopID = shopid
  local uniqueEquipItem = UniqueEquip.Create(iteminfo.itemId)
  local imageRecord = uniqueEquipItem:GetShopBuyBackGroudImg()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = uniqueEquipItem:GetIcon()
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(uniqueEquipItem:GetName())
  self._uniqueEquipItem = uniqueEquipItem
  local role = Role.Create(uniqueEquipItem:GetRoleId())
  imageRecord = role:GetShapeLittleHeadImageRecord()
  self._charIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = role:GetSmallRarityFrameRecord()
  self._charBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if role:GetRoleId() == DataCommon.LeaderId then
    self._charName:SetText(NekoData.BehaviorManager.BM_Message:GetString(1433))
  else
    self._charName:SetText(role:GetRoleName())
  end
  local item = Item.Create(iteminfo.moneyType)
  imageRecord = item:GetIcon()
  self._priceTypeImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._priceNum:SetText(tostring(iteminfo.discountPrice))
  local initAttrs = uniqueEquipItem:GetInitAttrs()
  for k, v in pairs(initAttrs) do
    table.insert(self._attrList, {attrId = k, attrValue = v})
  end
  table.sort(self._attrList, function(a, b)
    return self._uniqueEquipItem:GetIndexByAttrId(a.attrId) < self._uniqueEquipItem:GetIndexByAttrId(b.attrId)
  end)
  self._attrFrame:ReloadAllCell()
  self._attrFrame:MoveToTop()
  self._skillEffect:SetText(NekoData.BehaviorManager.BM_Message:GetUniqueEquipSkillDescribe(uniqueEquipItem:GetSkillIdByLevel(1)))
  local textwidth, textheight = self._skillEffect:GetPreferredSize()
  if textheight > self._unlockEffect_height then
    local delta = textheight - self._unlockEffect_height
    self._skillEffect:SetAnchorAndOffset(self._anchorMinX1, self._anchorMinY1, self._anchorMaxX1, self._anchorMaxY1, self._offsetMinX1, self._offsetMinY1 - delta, self._offsetMaxX1, self._offsetMaxY1)
  else
    self._skillEffect:SetAnchorAndOffset(self._anchorMinX1, self._anchorMinY1, self._anchorMaxX1, self._anchorMaxY1, self._offsetMinX1, self._offsetMinY1, self._offsetMaxX1, self._offsetMaxY1)
  end
end

function UniqueEquipBuyDialog:NumberOfCell(frame, index)
  return #self._attrList
end

function UniqueEquipBuyDialog:CellAtIndex(frame, index)
  return "shop.uniqueequipbuyattrcell"
end

function UniqueEquipBuyDialog:DataAtIndex(frame, index)
  return self._attrList[index]
end

function UniqueEquipBuyDialog:OnBuyBtnClicked()
  local currencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._itemInfo.moneyType)
  if currencyNum < self._itemInfo.discountPrice then
    local currencyName = Item.Create(self._itemInfo.moneyType):GetName()
    local uniqueEquipName = self._uniqueEquipItem:GetName()
    NekoData.BehaviorManager.BM_Message:SendMessageById(100371, {currencyName, uniqueEquipName})
  else
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
    if protocol then
      protocol.shopId = self._shopID
      local map = {}
      map[self._itemInfo.goodId] = 1
      protocol.goods = map
      protocol:Send()
    end
  end
end

function UniqueEquipBuyDialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function UniqueEquipBuyDialog:OnBackBtnClicked()
  self:Destroy()
end

return UniqueEquipBuyDialog
