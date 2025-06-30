-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/productaccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local MaxColumnNums = 5
local ProductAccountDialog = class("ProductAccountDialog", Dialog)
ProductAccountDialog.AssetBundleName = "ui/layouts.yard"
ProductAccountDialog.AssetName = "AlchemyReward"
ProductAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ProductAccountDialog
  ((ProductAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._tag = nil
  self._itemAccount = {}
  self._cellInfo = {}
  self._showOnce = false
end

ProductAccountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame, MaxColumnNums
  self._extra = self:GetChild("Extra")
  ;
  (self._extra):SetText((TextManager.GetText)(800117))
  self._rightBtn = self:GetChild("CellPanel/RightArrow")
  self._leftBtn = self:GetChild("CellPanel/LeftArrow")
  self._cellPanel = self:GetChild("CellPanel/CellPanel")
  self._panel = self:GetChild("CellPanel")
  self._width = (self._cellPanel):GetRectSize()
  self._rootWindowAnchoredx = (self:GetRootWindow()):GetAnchoredPosition()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
  ;
  (self._panel):Subscribe_PointerClickEvent(self.OnSet, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
  self._frame = (GridFrame.Create)(self._cellPanel, self, true, MaxColumnNums, true)
end

ProductAccountDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  end
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
end

ProductAccountDialog.ChangeCellPosition = function(self)
  -- function num : 0_3 , upvalues : MaxColumnNums
  local num = #self._cellInfo
  local cellPanelWidth = nil
  if num < MaxColumnNums then
    cellPanelWidth = self._width / MaxColumnNums * num
  else
    cellPanelWidth = self._width
  end
  local cellPanelHeight = (self._frame):GetTotalLength()
  if self._height < cellPanelHeight then
    cellPanelHeight = self._height
  end
  ;
  (self._cellPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  ;
  (self._cellPanel):SetAnchoredPosition(self._rootWindowAnchoredx, self._rootWindowAnchoredy)
  ;
  (self._panel):SetAnchoredPosition(self._rootWindowAnchoredx, self._rootWindowAnchoredy)
  ;
  (self._frame):ReloadAllCell()
end

ProductAccountDialog.SetData = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  (table.insert)(self._itemAccount, protocol)
  local tempProtocol = (self._itemAccount)[1]
  if not self._showOnce and tempProtocol then
    (table.remove)(self._itemAccount, 1)
    self:ShowFromOnce(tempProtocol)
  end
end

ProductAccountDialog.ShowFromOnce = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, ItemTypeEnum, Item, Equip, Skill
  (self._extra):SetActive(protocol.effect == 1)
  self._showOnce = true
  while (self._cellInfo)[#self._cellInfo] do
    (table.remove)(self._cellInfo, #self._cellInfo)
  end
  local itemAccounts = {}
  for i,v in ipairs(protocol.mainResult) do
    local itemInfo = {}
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(v.bagtype, v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        itemInfo.item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v.id)
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = (Item.Create)(v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        itemInfo.item = (Equip.Create)(v.id)
      elseif v.itemtype == ItemTypeEnum.SKILL then
        itemInfo.item = (Skill.Create)(v.id)
      end
      ;
      (itemInfo.item):InitWithItemInfo(v)
    end
    itemInfo.num = v.number
    ;
    (table.insert)(itemAccounts, itemInfo)
  end
  for i,v in ipairs(protocol.secondResult) do
    local itemInfo = {}
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(v.bagtype, v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        itemInfo.item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v.id)
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = (Item.Create)(v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        itemInfo.item = (Equip.Create)(v.id)
      elseif v.itemtype == ItemTypeEnum.SKILL then
        itemInfo.item = (Skill.Create)(v.id)
      end
      ;
      (itemInfo.item):InitWithItemInfo(v)
    end
    itemInfo.num = v.number
    itemInfo.extra = true
    ;
    (table.insert)(itemAccounts, itemInfo)
  end
  for i,v in ipairs(itemAccounts) do
    (table.insert)(self._cellInfo, v)
  end
  self._tag = "gridFrame"
  ;
  (self._frame):ReloadAllCell()
  self:ChangeCellPosition()
  ;
  (self._leftBtn):SetActive(false)
  ;
  (self._rightBtn):SetActive(false)
  -- DECOMPILER ERROR: 18 unprocessed JMP targets
end

ProductAccountDialog.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_6
  if self._tag == "gridFrame" and not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._frame):FireEvent("SetItemSelectedState", nil)
  end
end

ProductAccountDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if self._tag == "gridFrame" then
    return #self._cellInfo
  end
end

ProductAccountDialog.CellAtIndex = function(self, frame)
  -- function num : 0_8
  if self._tag == "gridFrame" then
    return "alchemy.productaccountcell"
  end
end

ProductAccountDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if self._tag == "gridFrame" then
    return (self._cellInfo)[index]
  end
end

ProductAccountDialog.SetSelectedID = function(self, notification)
  -- function num : 0_10
  self._selectedID = notification
  ;
  (self._frame):FireEvent("SetItemSelectedState", self._selectedID)
end

ProductAccountDialog.SetNotSelect = function(self)
  -- function num : 0_11
  self._selectedID = nil
  ;
  (self._frame):FireEvent("SetItemSelectedState", self._selectedID)
end

ProductAccountDialog.OnSet = function(self)
  -- function num : 0_12 , upvalues : MaxColumnNums
  if #self._cellInfo <= MaxColumnNums then
    self:OnBackBtnClicked()
  end
end

ProductAccountDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if self._canClose then
    self._showOnce = false
    local tempProtocol = (self._itemAccount)[1]
    if tempProtocol then
      (table.remove)(self._itemAccount, 1)
      ;
      (self:GetRootWindow()):PlayAnimation("GetItem")
      self:ShowFromOnce(tempProtocol)
    else
      self:Destroy()
    end
  end
end

ProductAccountDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_14
  if stateName == "GetItem" then
    self._canClose = true
  end
end

return ProductAccountDialog

