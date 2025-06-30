-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitaccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local SwimSuitAccountDialog = class("SwimSuitAccountDialog", Dialog)
SwimSuitAccountDialog.AssetBundleName = "ui/layouts.dungeon"
SwimSuitAccountDialog.AssetName = "DungeonFinish2"
SwimSuitAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitAccountDialog
  ((SwimSuitAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

SwimSuitAccountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._itemField = self:GetChild("ItemFrame")
  self._getMoney = self:GetChild("NumFrame/Num1")
  ;
  (self._getMoney):SetText(0)
  self._totalMoney = self:GetChild("NumFrame/Num2")
  self._nextBtn = self:GetChild("ConfirmButton")
  self._emptyTips = self:GetChild("EmptyTips")
  ;
  (self._nextBtn):Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self._itemFrame = (GridFrame.Create)(self._itemField, self, true, 6)
  ;
  (self._itemFrame):SetMargin(30, 0)
  self:SetData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
end

SwimSuitAccountDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  ((NekoData.DataManager).DM_Team):ClearSupportRole()
  ;
  ((NekoData.DataManager).DM_Game):ClearExploreWithoutBackAwards()
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
  -- function num : 0_3 , upvalues : _ENV
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

  ;
  (table.sort)(self._data, function(a, b)
    -- function num : 0_3_1 , upvalues : tempFun
    return tempFun(a.item, b.item)
  end
)
end

SwimSuitAccountDialog.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item, SortItemByPinji, CStringRes
  local bagList = ((NekoData.BehaviorManager).BM_Game):GetAutoExploreWithoutBackAwards()
  self._data = {}
  for i,v in ipairs(bagList.item) do
    (table.insert)(self._data, {item = (Item.Create)(v.id), num = v.number})
  end
  SortItemByPinji(self)
  local moneyData = {}
  local money = bagList.money
  for k,v in pairs(money) do
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

SwimSuitAccountDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._itemFrame then
    return #self._data
  end
end

SwimSuitAccountDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._itemFrame then
    return "dungeon.dungeonaccountcell"
  end
end

SwimSuitAccountDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._itemFrame and #self._data ~= 0 then
    return (self._data)[index]
  end
end

SwimSuitAccountDialog.OnNextClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if not controller then
    ((NekoData.BehaviorManager).BM_Game):FinishDungeonReward()
  end
  self:Destroy()
end

SwimSuitAccountDialog.OnTipsDestroy = function(self, notification)
  -- function num : 0_9
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._itemFrame):FireEvent("SetItemSelectedState", nil)
  end
end

SwimSuitAccountDialog.SetSelectedID = function(self, args)
  -- function num : 0_10
  (self._itemFrame):FireEvent("SetItemSelectedState", args)
end

SwimSuitAccountDialog.SetNotSelect = function(self)
  -- function num : 0_11
  (self._itemFrame):FireEvent("SetItemSelectedState", nil)
end

return SwimSuitAccountDialog

