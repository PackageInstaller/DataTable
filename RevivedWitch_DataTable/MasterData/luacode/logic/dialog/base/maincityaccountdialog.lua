-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/maincityaccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local DungeonAccountDialog = class("DungeonAccountDialog", Dialog)
DungeonAccountDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonAccountDialog.AssetName = "DungeonFinish2"
DungeonAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonAccountDialog
  ((DungeonAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

DungeonAccountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._itemField = self:GetChild("ItemFrame")
  self._getMoney = self:GetChild("NumFrame/Num1")
  ;
  (self._getMoney):SetText(0)
  self._totalMoney = self:GetChild("NumFrame/Num2")
  self._nextBtn = self:GetChild("ConfirmButton")
  self._emptyTips = self:GetChild("EmptyTips")
  ;
  (self._nextBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._itemFrame = (GridFrame.Create)(self._itemField, self, true, 6)
  ;
  (self._itemFrame):SetMargin(30, 0)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
end

DungeonAccountDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  ((NekoData.DataManager).DM_Team):ClearSupportRole()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._itemFrame):Destroy()
  self._data = {}
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
  ;
  (DialogManager.DestroySingletonDialog)("assistbattle.addfriendsecondconfirmdialog")
end

local SortItemByPinji = function(self)
  -- function num : 0_3 , upvalues : _ENV, ItemTypeEnum
  local items = {}
  local equips = {}
  for _,v in ipairs(self._data) do
    local item = v.item
    if item:GetItemType() == ItemTypeEnum.EQUIP then
      (table.insert)(equips, v)
    else
      ;
      (table.insert)(items, v)
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
  for _,item in ipairs(equips) do
    for i = 1, item.num do
      local temp = {}
      temp.item = item.item
      temp.num = 1
      ;
      (table.insert)(self._data, temp)
    end
  end
  for _,item in ipairs(items) do
    local flag = true
    for _,i in ipairs(self._data) do
      if (item.item):GetID() == (i.item):GetID() then
        i.num = i.num + item.num
        flag = false
        break
      end
    end
    do
      do
        if flag then
          local temp = {}
          temp.item = item.item
          temp.num = item.num
          ;
          (table.insert)(self._data, temp)
        end
        -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out DO_STMT

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

DungeonAccountDialog.SetData = function(self, money)
  -- function num : 0_4 , upvalues : _ENV, Item, CStringRes
  self._data = {}
  local moneyData = {}
  for k,v in pairs(money) do
    LogErrorFormat("DungeonAccountDialog", "--- id = %s, num = %s ---", k, v)
    local item = (Item.Create)(k)
    ;
    (table.insert)(moneyData, {item = item, num = v})
  end
  ;
  (table.sort)(moneyData, function(a, b)
    -- function num : 0_4_0
    local aId, bId = (a.item):GetID(), (b.item):GetID()
    if aId == 35003 then
      return false
    else
      if bId == 35003 then
        return true
      else
        return bId < aId
      end
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  for _,v in ipairs(moneyData) do
    (table.insert)(self._data, 1, v)
  end
  if #self._data ~= 0 then
    (self._emptyTips):SetActive(false)
  else
    ;
    (self._emptyTips):SetActive(true)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1106)).msgTextID)
    ;
    (self._emptyTips):SetText(str)
  end
  do
    ;
    (self._itemFrame):ReloadAllCell()
    ;
    (self._getMoney):SetNumber(money[DataCommon.ManaID] or 0)
    ;
    (self._totalMoney):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetMoney())
    self._supportRoleInfo = ((NekoData.BehaviorManager).BM_Team):GetSupportRole()
    if (self._supportRoleInfo).user and ((self._supportRoleInfo).user):IsStranger() then
      self._task = (GameTimer.AddTask)(0.5, 0, function()
    -- function num : 0_4_1 , upvalues : self, _ENV
    self._task = nil
    ;
    ((DialogManager.CreateSingletonDialog)("assistbattle.addfriendsecondconfirmdialog")):SetConfirmFunc(function()
      -- function num : 0_4_1_0 , upvalues : _ENV, self
      ((NekoData.BehaviorManager).BM_Friends):RequesAddFriend(((self._supportRoleInfo).user):GetID())
    end
)
  end
, nil)
    end
  end
end

DungeonAccountDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._itemFrame then
    return #self._data
  end
end

DungeonAccountDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._itemFrame then
    return "dungeon.dungeonaccountcell"
  end
end

DungeonAccountDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._itemFrame and #self._data ~= 0 then
    return (self._data)[index]
  end
end

DungeonAccountDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if not controller then
    ((NekoData.BehaviorManager).BM_Game):FinishDungeonReward()
  end
  self:Destroy()
end

DungeonAccountDialog.OnTipsDestroy = function(self, notification)
  -- function num : 0_9
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._itemFrame):FireEvent("SetItemSelectedState", nil)
  end
end

DungeonAccountDialog.SetSelectedID = function(self, args)
  -- function num : 0_10
  (self._itemFrame):FireEvent("SetItemSelectedState", args)
end

DungeonAccountDialog.SetNotSelect = function(self)
  -- function num : 0_11
  (self._itemFrame):FireEvent("SetItemSelectedState", nil)
end

return DungeonAccountDialog

