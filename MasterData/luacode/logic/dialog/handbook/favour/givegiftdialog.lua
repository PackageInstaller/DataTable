local CFavourPresentType = BeanManager.GetTableByName("role.cfavourpresenttype")
local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GiveGiftDialog = class("GiveGiftDialog", Dialog)
GiveGiftDialog.AssetBundleName = "ui/layouts.tujian"
GiveGiftDialog.AssetName = "FavourGive"

function GiveGiftDialog:Ctor(...)
  GiveGiftDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._itemList = {}
  self._needExp = 0
end

function GiveGiftDialog:OnCreate()
  self._closeBtn = self:GetChild("BackBtn")
  self._itemPanel = self:GetChild("Frame")
  self._itemPanel_scaleX, self._itemPanel_scaleY = self._itemPanel:GetLocalScale()
  self._itemFrame = GridFrame.Create(self._itemPanel, self, true, 3)
  self._detail_icon = self:GetChild("Detail/ItemCell/_BackGround/Icon")
  self._detail_frame = self:GetChild("Detail/ItemCell/_BackGround/Frame")
  self._detail_name = self:GetChild("Detail/ItemName")
  self._detail_description = self:GetChild("Detail/Detail")
  self._heartEffectPanel = self:GetChild("Detail/HeartFrame")
  self._heartEffectFrame = TableFrame.Create(self._heartEffectPanel, self, false, false)
  self._curGiveNumTxt = self:GetChild("Num/Num")
  self._reduceBtn = self:GetChild("Num/MinusBtn")
  self._addBtn = self:GetChild("Num/AddBtn")
  self._minBtn = self:GetChild("Num/MinBtn")
  self._maxBtn = self:GetChild("Num/MaxBtn")
  self._giveBtn = self:GetChild("GiveBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnCloseBtnClick, self)
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._minBtn:Subscribe_PointerClickEvent(self.OnMinBtnClicked, self)
  self._maxBtn:Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  self._giveBtn:Subscribe_PointerClickEvent(self.OnGiveBtnClicked, self)
  local dialog = DialogManager.GetDialog("handbook.roledetailinfodialog")
  if dialog then
    dialog._panelWnd:SetActive(false)
  end
end

function GiveGiftDialog:OnDestroy()
  self._itemFrame:Destroy()
  self._heartEffectFrame:Destroy()
  local dialog = DialogManager.GetDialog("handbook.roledetailinfodialog")
  if dialog then
    dialog._panelWnd:SetActive(true)
  end
end

function GiveGiftDialog:SetData(roleId)
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  local rarityId = self._role:GetRarityId()
  local curLv = self._role:GetRelationLevel()
  local maxLv = self._role:GetRelationMaxLevel()
  local curProgress = self._role:GetRelationProgress()
  if curLv < maxLv then
    for i = curLv, maxLv do
      local record = CFavourExp:GetRecorder(i)
      local num
      if rarityId == 1 then
        num = record.Rfavourexp
      elseif rarityId == 2 then
        num = record.SRfavourexp
      elseif rarityId == 3 then
        num = record.SSRfavourexp
      elseif rarityId == 4 then
        num = record.URfavourexp
      elseif rarityId == 5 then
        num = record.EXfavourexp
      end
      if i == curLv then
        self._needExp = self._needExp + num - curProgress
      else
        self._needExp = self._needExp + num
      end
    end
  end
  self._favourGiftType = self._role:GetFavourGiftType()
  local itemList = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(75)
  local list = {}
  for i, v in ipairs(itemList) do
    local pinJiID = v:GetPinJiID()
    if not list[pinJiID] then
      list[pinJiID] = {}
    end
    table.insert(list[pinJiID], v)
  end
  local temp = {}
  for k, v in pairs(list) do
    table.insert(temp, k)
  end
  table.sort(temp, function(a, b)
    return b < a
  end)
  local map = {}
  for k, v in pairs(list) do
    map[k] = {
      likeItemList = {},
      dislikeItemList = {}
    }
    for i, item in ipairs(v) do
      local favourPresentTypeRecord = CFavourPresentType:GetRecorder(item:GetID())
      if favourPresentTypeRecord.presenttype == self._favourGiftType then
        table.insert(map[k].likeItemList, item)
      else
        table.insert(map[k].dislikeItemList, item)
      end
    end
  end
  for k, v in pairs(temp) do
    local data = map[v]
    for _, item in ipairs(data.likeItemList) do
      table.insert(self._itemList, item)
    end
    for _, item in ipairs(data.dislikeItemList) do
      table.insert(self._itemList, item)
    end
  end
  self._selectItem = self._itemList[1]
  self:RefreshSelectItemDetail()
  self._itemFrame:ReloadAllCell()
end

function GiveGiftDialog:RefreshSelectItemDetail()
  local imageRecord = self._selectItem:GetIcon()
  self._detail_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._selectItem:GetPinJiImage()
  self._detail_frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._detail_name:SetText(self._selectItem:GetName())
  self._detail_description:SetText(self._selectItem:GetDestribe())
  local favourPresentTypeRecord = CFavourPresentType:GetRecorder(self._selectItem:GetID())
  self._heartEffectNum = favourPresentTypeRecord.presentuplevel
  self._favourExpNum = favourPresentTypeRecord.favour
  if favourPresentTypeRecord.presenttype == self._favourGiftType then
    self._heartEffectNum = self._heartEffectNum * 2
    self._favourExpNum = self._favourExpNum + favourPresentTypeRecord.exfavour
  end
  self._sendMaxNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(self._selectItem:GetID())
  self._heartEffectFrame:ReloadAllCell()
  self._sendNum = 1
  self._curGiveNumTxt:SetText(self._sendNum)
end

function GiveGiftDialog:SetSelectItem(item)
  if item:GetID() ~= self._selectItem:GetID() then
    self._selectItem = item
    self:RefreshSelectItemDetail()
    self._itemFrame:FireEvent("SetSelectItem", self._selectItem:GetID())
  end
end

function GiveGiftDialog:OnReduceBtnClicked()
  if self._sendNum > 1 then
    self._sendNum = self._sendNum - 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100253)
  end
end

function GiveGiftDialog:OnAddBtnClicked()
  if self._sendNum < self._sendMaxNum then
    self._sendNum = self._sendNum + 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100254)
  end
end

function GiveGiftDialog:OnMinBtnClicked()
  if self._sendNum ~= 1 then
    self._sendNum = 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100253)
  end
end

function GiveGiftDialog:OnMaxBtnClicked()
  if self._sendNum ~= self._sendMaxNum then
    if self._needExp == 0 then
      self._sendNum = self._sendMaxNum
    else
      self._sendNum = self._sendMaxNum
      local num = math.ceil(self._needExp / self._favourExpNum)
      if num < self._sendMaxNum then
        self._sendNum = num
      end
    end
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100254)
  end
end

function GiveGiftDialog:OnGiveBtnClicked()
  if self._role:GetRelationLevel() < self._role:GetRelationMaxLevel() or NekoData.BehaviorManager.BM_Game:GetFavourMaxGiveGift() ~= 0 then
    local csend = LuaNetManager.CreateProtocol("protocol.good.cpresent")
    csend.roleId = self._role:GetId()
    csend.itemId = self._selectItem:GetID()
    csend.itemNum = self._sendNum
    csend:Send()
    local dialog = DialogManager.GetDialog("handbook.roledetailinfodialog")
    if dialog then
      dialog:CacheGiveItemId(self._selectItem:GetID())
    end
    self:Destroy()
  else
    NekoData.DataManager.DM_Game:SetFavourMaxGiveGift()
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(89, nil, function()
      local csend = LuaNetManager.CreateProtocol("protocol.good.cpresent")
      csend.roleId = self._role:GetId()
      csend.itemId = self._selectItem:GetID()
      csend.itemNum = self._sendNum
      csend:Send()
      local dialog = DialogManager.GetDialog("handbook.roledetailinfodialog")
      if dialog then
        dialog:CacheGiveItemId(self._selectItem:GetID())
      end
      self:Destroy()
    end, {}, nil, {})
  end
end

function GiveGiftDialog:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._itemList
  else
    return self._heartEffectNum
  end
end

function GiveGiftDialog:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "handbook.favour.givegiftitemcell"
  else
    return "handbook.favour.givegiftheartcell"
  end
end

function GiveGiftDialog:DataAtIndex(frame, index)
  if frame == self._itemFrame then
    return self._itemList[index]
  else
  end
end

function GiveGiftDialog:OnCloseBtnClick()
  self:Destroy()
end

return GiveGiftDialog
