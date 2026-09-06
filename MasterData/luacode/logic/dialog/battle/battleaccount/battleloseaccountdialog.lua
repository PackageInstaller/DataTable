local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BattleLoseAccountDialog = class("BattleLoseAccountDialog", Dialog)
BattleLoseAccountDialog.AssetBundleName = "ui/layouts.battlelose"
BattleLoseAccountDialog.AssetName = "BattleLoseAccount"

function BattleLoseAccountDialog:Ctor(...)
  BattleLoseAccountDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

function BattleLoseAccountDialog:OnCreate()
  self._itemField = self:GetChild("Item")
  self._nextBtn = self:GetChild("NextImage")
  self._itemField:Subscribe_PointerClickEvent(nil, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self._frame = GridFrame.Create(self._itemField, self, true, 5)
  self:SetData()
  LuaNotificationCenter.AddObserver(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
end

function BattleLoseAccountDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
  self._data = {}
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
end

local function SortItemByPinji(self)
  local items = {}
  local equips = {}
  for _, v in ipairs(self._data) do
    local item
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(v.bagtype, v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v.id)
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = Item.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        item = Equip.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.SKILL then
        item = Skill.Create(v.id)
      end
      item:InitWithItemInfo(v)
    end
    if item:GetItemType() == ItemTypeEnum.EQUIP then
      table.insert(equips, item)
    else
      table.insert(items, item)
    end
  end
  
  local function tempFun(a, b)
    if a:GetPinJiID() > b:GetPinJiID() then
      return true
    elseif a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
      return true
    end
    return false
  end
  
  self._data = {}
  for _, type in ipairs({equips, items}) do
    for _, item in ipairs(type) do
      for i = 1, item:GetCount() do
        local temp = {}
        temp.item = item
        temp.num = 1
        table.insert(self._data, temp)
      end
    end
  end
  table.sort(self._data, function(a, b)
    return tempFun(a.item, b.item)
  end)
end

function BattleLoseAccountDialog:SetData()
  local awardList, currency = NekoData.BehaviorManager.BM_Dungeon:GetBattleAccountData()
  self._data = awardList or {}
  SortItemByPinji(self)
  self._frame:ReloadAllCell()
end

function BattleLoseAccountDialog:NumberOfCell(frame)
  return #self._data
end

function BattleLoseAccountDialog:CellAtIndex(frame, index)
  return "battle.battleaccount.battlewinaccountcell"
end

function BattleLoseAccountDialog:DataAtIndex(frame, index)
  if #self._data ~= 0 then
    return self._data[index]
  end
end

function BattleLoseAccountDialog:OnNextClicked()
  NekoData.DataManager.DM_Dungeon:SetLoseResultHasShow(true)
  NekoData.DataManager.DM_Dungeon:SetBattleResult(nil)
  self:Destroy()
end

function BattleLoseAccountDialog:OnTipsDestroy(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._frame:FireEvent("SetItemSelectedState", nil)
  end
end

function BattleLoseAccountDialog:SetSelectedID(args)
  self._frame:FireEvent("SetItemSelectedState", args)
end

function BattleLoseAccountDialog:SetNotSelect()
  self._frame:FireEvent("SetItemSelectedState", nil)
end

return BattleLoseAccountDialog
