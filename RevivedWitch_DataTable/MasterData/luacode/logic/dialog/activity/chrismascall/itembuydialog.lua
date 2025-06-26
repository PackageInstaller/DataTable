-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/itembuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSugarShopOpen = (BeanManager.GetTableByName)("recharge.csugarshopopen")
local RoleTypeId = 27
local ItemBuyDialog = class("ItemBuyDialog", Dialog)
ItemBuyDialog.AssetBundleName = "ui/layouts.activitychristmascall"
ItemBuyDialog.AssetName = "ActivityChristmasCallShop6"
ItemBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemBuyDialog
  ((ItemBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ItemBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemName = self:GetChild("Back/ItemName")
  self._itemIcon = self:GetChild("Back/MonthCardImg")
  self._charIcon = self:GetChild("Back/Char")
  self._goodsNum = self:GetChild("Back/Num/Num")
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemDetail = self:GetChild("Back/IncludeBack1/Text")
  self._width = (self._itemDetail):GetRectSize()
  local _ = 0
  _ = (self._itemDetail):GetPreferredSize()
  self._text_size_x = (self._itemDetail):GetSize()
  self._text_pos_x = (self._itemDetail):GetPosition()
  self._limit = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC54: Overwrote pending register: R4 in 'AssignReg'

  self._limitTxt = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC58: Overwrote pending register: R4 in 'AssignReg'

  self._saleImage = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC62: Overwrote pending register: R4 in 'AssignReg'

  self._itemPanel = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC67: Overwrote pending register: R4 in 'AssignReg'

  self._itemFrame = (TableFrame.Create)(self._itemPanel, R4_PC39, R5_PC38, true, true)
  -- DECOMPILER ERROR at PC74: Overwrote pending register: R4 in 'AssignReg'

  self._priceOnSale = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC78: Overwrote pending register: R4 in 'AssignReg'

  self._priceOnSaleOri = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC82: Overwrote pending register: R4 in 'AssignReg'

  self._priceOnSaleNow = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC86: Overwrote pending register: R4 in 'AssignReg'

  self._priceNormal = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC90: Overwrote pending register: R4 in 'AssignReg'

  self._priceNormalNow = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC94: Overwrote pending register: R4 in 'AssignReg'

  self._priceFree = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC98: Overwrote pending register: R4 in 'AssignReg'

  self._buyBtn = self:GetChild(R4_PC39)
  -- DECOMPILER ERROR at PC103: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC104: Overwrote pending register: R5 in 'AssignReg'

  ;
  (self._buyBtn):Subscribe_PointerClickEvent(R4_PC39, R5_PC38)
  -- DECOMPILER ERROR at PC109: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC110: Overwrote pending register: R5 in 'AssignReg'

  -- DECOMPILER ERROR at PC111: Overwrote pending register: R5 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, R4_PC39, R5_PC38, nil)
end

ItemBuyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ItemBuyDialog.SetData = function(self, data, shopid)
  -- function num : 0_3 , upvalues : _ENV, Item, CImagePathTable, CSugarShopOpen, RoleTypeId, CRoleItem, RoleConfigTable, CNPCShape
  self._data = data
  self._shopID = shopid
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  if (self._data).goodRemain == 0 then
    (self._goodsNum):SetText(0)
  else
    if (self._data).goodRemain == -1 then
      (self._goodsNum):SetText(tostring(99 .. "+"))
    else
      ;
      (self._goodsNum):SetText((NumberManager.GetShowNumber)((self._data).goodRemain))
    end
  end
  local item = nil
  if type((self._data).itemId) == "table" then
    item = (Item.Create)((self._data).giftId)
    ;
    (self._itemName):SetText((TextManager.GetText)((self._data).goodName))
    ;
    (self._charIcon):SetActive(false)
    ;
    (self._itemIcon):SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder((self._data).pictureId)
    ;
    (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      item = (Item.Create)((CSugarShopOpen:GetRecorder((self._data).goodId)).Items)
      ;
      (self._itemName):SetText(item:GetName())
      local isRole = item:GetItemTypeId() == RoleTypeId
      ;
      (self._charIcon):SetActive(isRole)
      ;
      (self._itemIcon):SetActive(not isRole)
      if isRole then
        local roleid = (CRoleItem:GetRecorder((self._data).itemId)).roleid
        local roleRecorder = RoleConfigTable:GetRecorder(roleid)
        local npcshaperecord = CNPCShape:GetRecorder(roleRecorder.shapeID)
        local imageRecord = CImagePathTable:GetRecorder(npcshaperecord.skillHeadID)
        ;
        (self._charIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        local imageRecord = item:GetIcon()
        ;
        (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      if not (self._data).beginTime or not (self._data).endTime or (self._data).beginTime == 0 or (self._data).endTime == 0 then
        (self._limit):SetActive(false)
        ;
        (self._limitTxt):SetActive(false)
      else
        (self._limit):SetActive(true)
        ;
        (self._limitTxt):SetActive(true)
        ;
        (self._limitTxt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._data).endTime))
      end
      self._goodType = (self._data).moneyType > 35000
      local noDiscount = (self._data).discount == -1 or (self._data).discount == 10
      if noDiscount and (self._data).discountPrice > 0 then
        (self._priceOnSale):SetActive(false)
        ;
        (self._priceNormal):SetActive(true)
        ;
        (self._priceFree):SetActive(false)
        ;
        (self._priceNormalNow):SetText((self._data).discountPrice)
        ;
        (self._saleImage):SetActive(false)
      elseif noDiscount and (self._data).discountPrice == 0 then
        (self._priceOnSale):SetActive(false)
        ;
        (self._priceNormal):SetActive(false)
        ;
        (self._priceFree):SetActive(true)
        ;
        (self._saleImage):SetActive(false)
      elseif not noDiscount then
        (self._priceOnSale):SetActive(true)
        ;
        (self._priceNormal):SetActive(false)
        ;
        (self._priceFree):SetActive(false)
        ;
        (self._priceOnSaleNow):SetText((self._data).discountPrice)
        ;
        (self._priceOnSaleOri):SetText((self._data).price)
        ;
        (self._saleImage):SetActive(true)
        local imageRecord = CImagePathTable:GetRecorder(10 - (self._data).discount + 11392)
        ;
        (self._saleImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        LogErrorFormat("ItemBuyDialog", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", (self._data).discount, (self._data).discountPrice)
      end
      local imageRecord = item:GetShopBuyBackGroudImg()
      ;
      (self._itemBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._itemDetail):SetText(item:GetDestribe())
      local fontsize = (self._itemDetail):GetFontSize()
      local _, textheight = (self._itemDetail):GetPreferredSize()
      if self._height < textheight then
        local line = (textheight - self._height) / fontsize
        local delta = line * fontsize
        ;
        (self._itemDetail):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
        ;
        (self._itemDetail):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
      end
      if type((self._data).itemId) == "table" then
        self._itemData = {}
        for i,v in ipairs((self._data).itemId) do
          local temp = {id = v, count = ((self._data).itemSum)[i]}
          ;
          (table.insert)(self._itemData, temp)
        end
      else
        self._itemData = {
{id = (self._data).itemId, count = (self._data).itemSum}
}
      end
      ;
      (self._itemFrame):ReloadAllCell()
      ;
      (self._itemFrame):MoveToTop()
      -- DECOMPILER ERROR: 16 unprocessed JMP targets
    end
  end
end

ItemBuyDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._data).discount == -1 or (self._data).discount == 10 and (self._data).discountPrice == 0 then
    (self._bm):KillRedDot(((self._bm):GetSChristmasSupportRedPointDef()).FREE_GOOD)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnLocalRefreshChristmasSupportRedpoint, nil, nil)
  end
  if (self._data).moneyType > 35000 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyshopgood")
    if protocol then
      protocol.shopId = self._shopID
      protocol.goods = {[(self._data).goodId] = 1}
      protocol:Send()
    end
  else
    do
      do
        local protocol = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
        if protocol then
          protocol.goodId = (self._data).goodId
          protocol:Send()
        end
        self:Destroy()
      end
    end
  end
end

ItemBuyDialog.OnDialogClicked = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ItemBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") or (DialogManager.GetDialog)("equip.equiptipspreviewdialog") then
    return 
  end
  self:Destroy()
end

ItemBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemData
end

ItemBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "activity.chrismascall.shopitembuycell"
end

ItemBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemData)[index]
end

return ItemBuyDialog

