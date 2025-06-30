-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battleloseaccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BattleLoseAccountDialog = class("BattleLoseAccountDialog", Dialog)
BattleLoseAccountDialog.AssetBundleName = "ui/layouts.battlelose"
BattleLoseAccountDialog.AssetName = "BattleLoseAccount"
BattleLoseAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLoseAccountDialog
  ((BattleLoseAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

BattleLoseAccountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._itemField = self:GetChild("Item")
  self._nextBtn = self:GetChild("NextImage")
  ;
  (self._itemField):Subscribe_PointerClickEvent(nil, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self._frame = (GridFrame.Create)(self._itemField, self, true, 5)
  self:SetData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
end

BattleLoseAccountDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
  self._data = {}
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
end

local SortItemByPinji = function(self)
  -- function num : 0_3 , upvalues : _ENV, ItemTypeEnum, Item, Equip, Skill
  local items = {}
  local equips = {}
  for _,v in ipairs(self._data) do
    local item = nil
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(v.bagtype, v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v.id)
        end
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = (Item.Create)(v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          item = (Equip.Create)(v.id)
        else
          if v.itemtype == ItemTypeEnum.SKILL then
            item = (Skill.Create)(v.id)
          end
        end
      end
      item:InitWithItemInfo(v)
    end
    if item:GetItemType() == ItemTypeEnum.EQUIP then
      (table.insert)(equips, item)
    else
      ;
      (table.insert)(items, item)
    end
  end
  local tempFun = function(a, b)
    -- function num : 0_3_0
    if b:GetPinJiID() < a:GetPinJiID() then
      return true
    else
      if a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
        return true
      end
    end
    return false
  end

  self._data = {}
  for _,type in ipairs({equips, items}) do
    for _,item in ipairs(type) do
      for i = 1, item:GetCount() do
        local temp = {}
        temp.item = item
        temp.num = 1
        ;
        (table.insert)(self._data, temp)
      end
    end
  end
  ;
  (table.sort)(self._data, function(a, b)
    -- function num : 0_3_1 , upvalues : tempFun
    return tempFun(a.item, b.item)
  end
)
end

BattleLoseAccountDialog.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV, SortItemByPinji
  local awardList, currency = ((NekoData.BehaviorManager).BM_Dungeon):GetBattleAccountData()
  if not awardList then
    self._data = {}
    SortItemByPinji(self)
    ;
    (self._frame):ReloadAllCell()
  end
end

BattleLoseAccountDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

BattleLoseAccountDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "battle.battleaccount.battlewinaccountcell"
end

BattleLoseAccountDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if #self._data ~= 0 then
    return (self._data)[index]
  end
end

BattleLoseAccountDialog.OnNextClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((NekoData.DataManager).DM_Dungeon):SetLoseResultHasShow(true)
  ;
  ((NekoData.DataManager).DM_Dungeon):SetBattleResult(nil)
  self:Destroy()
end

BattleLoseAccountDialog.OnTipsDestroy = function(self, notification)
  -- function num : 0_9
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._frame):FireEvent("SetItemSelectedState", nil)
  end
end

BattleLoseAccountDialog.SetSelectedID = function(self, args)
  -- function num : 0_10
  (self._frame):FireEvent("SetItemSelectedState", args)
end

BattleLoseAccountDialog.SetNotSelect = function(self)
  -- function num : 0_11
  (self._frame):FireEvent("SetItemSelectedState", nil)
end

return BattleLoseAccountDialog

