local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local MaxColumnNums = 5
local ProductAccountDialog = class("ProductAccountDialog", Dialog)
ProductAccountDialog.AssetBundleName = "ui/layouts.yard"
ProductAccountDialog.AssetName = "AlchemyReward"

function ProductAccountDialog:Ctor(...)
  ProductAccountDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._tag = nil
  self._itemAccount = {}
  self._cellInfo = {}
  self._showOnce = false
end

function ProductAccountDialog:OnCreate()
  self._extra = self:GetChild("Extra")
  self._extra:SetText(TextManager.GetText(800117))
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
end

function ProductAccountDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
end

function ProductAccountDialog:ChangeCellPosition()
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

function ProductAccountDialog:SetData(protocol)
  table.insert(self._itemAccount, protocol)
  local tempProtocol = self._itemAccount[1]
  if not self._showOnce and tempProtocol then
    table.remove(self._itemAccount, 1)
    self:ShowFromOnce(tempProtocol)
  end
end

function ProductAccountDialog:ShowFromOnce(protocol)
  self._extra:SetActive(protocol.effect == 1)
  self._showOnce = true
  while self._cellInfo[#self._cellInfo] do
    table.remove(self._cellInfo, #self._cellInfo)
  end
  local itemAccounts = {}
  for i, v in ipairs(protocol.mainResult) do
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
      end
      itemInfo.item:InitWithItemInfo(v)
    end
    itemInfo.num = v.number
    table.insert(itemAccounts, itemInfo)
  end
  for i, v in ipairs(protocol.secondResult) do
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
      end
      itemInfo.item:InitWithItemInfo(v)
    end
    itemInfo.num = v.number
    itemInfo.extra = true
    table.insert(itemAccounts, itemInfo)
  end
  for i, v in ipairs(itemAccounts) do
    table.insert(self._cellInfo, v)
  end
  self._tag = "gridFrame"
  self._frame:ReloadAllCell()
  self:ChangeCellPosition()
  self._leftBtn:SetActive(false)
  self._rightBtn:SetActive(false)
end

function ProductAccountDialog:OnGlobalPointerDown(notification)
  if self._tag == "gridFrame" and not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._frame:FireEvent("SetItemSelectedState", nil)
  end
end

function ProductAccountDialog:NumberOfCell(frame)
  if self._tag == "gridFrame" then
    return #self._cellInfo
  end
end

function ProductAccountDialog:CellAtIndex(frame)
  if self._tag == "gridFrame" then
    return "alchemy.productaccountcell"
  end
end

function ProductAccountDialog:DataAtIndex(frame, index)
  if self._tag == "gridFrame" then
    return self._cellInfo[index]
  end
end

function ProductAccountDialog:SetSelectedID(notification)
  self._selectedID = notification
  self._frame:FireEvent("SetItemSelectedState", self._selectedID)
end

function ProductAccountDialog:SetNotSelect()
  self._selectedID = nil
  self._frame:FireEvent("SetItemSelectedState", self._selectedID)
end

function ProductAccountDialog:OnSet()
  if #self._cellInfo <= MaxColumnNums then
    self:OnBackBtnClicked()
  end
end

function ProductAccountDialog:OnBackBtnClicked()
  if self._canClose then
    self._showOnce = false
    local tempProtocol = self._itemAccount[1]
    if tempProtocol then
      table.remove(self._itemAccount, 1)
      self:GetRootWindow():PlayAnimation("GetItem")
      self:ShowFromOnce(tempProtocol)
    else
      self:Destroy()
    end
  end
end

function ProductAccountDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "GetItem" then
    self._canClose = true
  end
end

return ProductAccountDialog
