local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local PageFrame = require("framework.ui.frame.page.pageframe")
local MaxColumnNums = 5
local ItemAccountDialog = class("ItemAccountDialog", Dialog)
ItemAccountDialog.AssetBundleName = "ui/layouts.bag"
ItemAccountDialog.AssetName = "ItemAccountNew"

function ItemAccountDialog:Ctor(...)
  ItemAccountDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._tag = nil
  self._pageIndex = nil
  self._itemAccount = {}
  self._cellInfo = {}
  self._consumaableItemIds = {}
  self._showOnce = false
end

function ItemAccountDialog:OnCreate()
  self._rightBtn = self:GetChild("CellPanel/RightArrow")
  self._leftBtn = self:GetChild("CellPanel/LeftArrow")
  self._cellPanel = self:GetChild("CellPanel/CellPanel")
  self._panel = self:GetChild("CellPanel")
  self._width, self._height = self._cellPanel:GetRectSize()
  self._rootWindowAnchoredx, self._rootWindowAnchoredy = self:GetRootWindow():GetAnchoredPosition()
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
  self._panel:Subscribe_PointerClickEvent(self.OnSet, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
  self._frame = GridFrame.Create(self._cellPanel, self, true, MaxColumnNums, true)
  if DialogManager.GetDialog("guide.guidedialog") then
    local guideGroup = DialogManager.GetGroup("Guide")
    self._guideTag = guideGroup:GetObjectActive()
    guideGroup:SetObjectActive(false)
  end
end

function ItemAccountDialog:OnDestroy()
  if self._guideTag then
    self._guideTag = false
    DialogManager.GetGroup("Guide"):SetObjectActive(true)
  end
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  if NekoData.BehaviorManager.BM_Chat:GetGuideCommentCache() then
    DialogManager.CreateSingletonDialog("chat.guidecommentdialog"):SetData()
  end
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
end

function ItemAccountDialog:ChangeCellPosition()
  local num = #self._cellInfo
  local cellPanelWidth
  if num < MaxColumnNums then
    cellPanelWidth = self._width / MaxColumnNums * num
  else
    cellPanelWidth = self._width
  end
  local cellPanelHeight = self._frame:GetTotalLength()
  if cellPanelHeight > self._height then
    cellPanelHeight = self._height
  end
  self._cellPanel:SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  self._cellPanel:SetAnchoredPosition(self._rootWindowAnchoredx, self._rootWindowAnchoredy)
  self._panel:SetAnchoredPosition(self._rootWindowAnchoredx, self._rootWindowAnchoredy)
  self._frame:ReloadAllCell()
end

function ItemAccountDialog:LoadData(protocol)
  table.insert(self._itemAccount, protocol)
  local tempProtocol = self._itemAccount[1]
  if not self._showOnce and tempProtocol then
    table.remove(self._itemAccount, 1)
    self:ShowFromOnce(tempProtocol)
  end
end

function ItemAccountDialog:ShowFromOnce(protocol)
  self._showOnce = true
  while self._cellInfo[#self._cellInfo] do
    table.remove(self._cellInfo, #self._cellInfo)
  end
  local itemAccounts = {}
  for i, v in ipairs(protocol.items) do
    local itemInfo = {}
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(v.bagtype, v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        itemInfo.item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v.id)
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = Item.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        itemInfo.item = Equip.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.SKILL then
        itemInfo.item = Skill.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.CONSUMAABLE then
        itemInfo.item = Item.Create(v.id)
        table.insert(self._consumaableItemIds, v.id)
      end
      itemInfo.item:InitWithItemInfo(v)
    end
    itemInfo.num = v.number
    itemInfo.dontShowName = true
    table.insert(itemAccounts, itemInfo)
  end
  
  local function tempFun(a, b)
    if a:GetPinJiID() > b:GetPinJiID() then
      return true
    elseif a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
      return true
    end
    return false
  end
  
  table.sort(itemAccounts, function(a, b)
    return tempFun(a.item, b.item)
  end)
  for i, v in ipairs(itemAccounts) do
    table.insert(self._cellInfo, v)
  end
  self._tag = "gridFrame"
  self._frame:ReloadAllCell()
  self:ChangeCellPosition()
  self._leftBtn:SetActive(false)
  self._rightBtn:SetActive(false)
end

function ItemAccountDialog:OnGlobalPointerDown(notification)
  if self._tag == "gridFrame" and not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._frame:FireEvent("SetItemSelectedState", nil)
  end
end

function ItemAccountDialog:NumberOfCell(frame)
  if self._tag == "gridFrame" then
    return #self._cellInfo
  end
end

function ItemAccountDialog:CellAtIndex(frame)
  if self._tag == "gridFrame" then
    return "bag.itemcell"
  end
end

function ItemAccountDialog:DataAtIndex(frame, index)
  if self._tag == "gridFrame" then
    return self._cellInfo[index]
  end
end

function ItemAccountDialog:SetSelectedID(notification)
  self._selectedID = notification
  self._frame:FireEvent("SetItemSelectedState", self._selectedID)
end

function ItemAccountDialog:SetNotSelect()
  self._selectedID = nil
  self._frame:FireEvent("SetItemSelectedState", self._selectedID)
end

function ItemAccountDialog:OnSet()
  if #self._cellInfo <= MaxColumnNums then
    self:OnBackBtnClicked()
  end
end

function ItemAccountDialog:OnBackBtnClicked()
  if self._canClose then
    self._showOnce = false
    local tempProtocol = self._itemAccount[1]
    if tempProtocol then
      table.remove(self._itemAccount, 1)
      self:GetRootWindow():PlayAnimation("GetItem")
      self:ShowFromOnce(tempProtocol)
    else
      if #self._consumaableItemIds > 0 then
        local csend = LuaNetManager.CreateProtocol("protocol.user.cuseconsumableitem")
        csend.itemIds = self._consumaableItemIds
        csend:Send()
      end
      DialogManager.DestroySingletonDialog("bag.itemaccountdialog")
    end
  end
end

function ItemAccountDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "GetItem" then
    self._canClose = true
  end
end

function ItemAccountDialog:IsItemAccount()
  return true
end

return ItemAccountDialog
