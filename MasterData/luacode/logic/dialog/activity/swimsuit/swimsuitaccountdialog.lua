local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local SwimSuitAccountDialog = class("SwimSuitAccountDialog", Dialog)
SwimSuitAccountDialog.AssetBundleName = "ui/layouts.dungeon"
SwimSuitAccountDialog.AssetName = "DungeonFinish2"

function SwimSuitAccountDialog:Ctor(...)
  SwimSuitAccountDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

function SwimSuitAccountDialog:OnCreate()
  self._itemField = self:GetChild("ItemFrame")
  self._getMoney = self:GetChild("NumFrame/Num1")
  self._getMoney:SetText(0)
  self._totalMoney = self:GetChild("NumFrame/Num2")
  self._nextBtn = self:GetChild("ConfirmButton")
  self._emptyTips = self:GetChild("EmptyTips")
  self._nextBtn:Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self._itemFrame = GridFrame.Create(self._itemField, self, true, 6)
  self._itemFrame:SetMargin(30, 0)
  self:SetData()
  LuaNotificationCenter.AddObserver(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
end

function SwimSuitAccountDialog:OnDestroy()
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  NekoData.DataManager.DM_Team:ClearSupportRole()
  NekoData.DataManager.DM_Game:ClearExploreWithoutBackAwards()
  LuaNotificationCenter.RemoveObserver(self)
  self._itemFrame:Destroy()
  self._data = {}
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
  DialogManager.DestroySingletonDialog("assistbattle.addfriendsecondconfirmdialog")
end

local function SortItemByPinji(self)
  local function tempFun(a, b)
    if a:GetPinJiID() > b:GetPinJiID() then
      return true
    elseif a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
      return true
    end
    return false
  end
  
  table.sort(self._data, function(a, b)
    return tempFun(a.item, b.item)
  end)
end

function SwimSuitAccountDialog:SetData()
  local bagList = NekoData.BehaviorManager.BM_Game:GetAutoExploreWithoutBackAwards()
  self._data = {}
  for i, v in ipairs(bagList.item) do
    table.insert(self._data, {
      item = Item.Create(v.id),
      num = v.number
    })
  end
  SortItemByPinji(self)
  local moneyData = {}
  local money = bagList.money
  for k, v in pairs(money) do
    local item = Item.Create(k)
    table.insert(moneyData, {item = item, num = v})
  end
  table.sort(moneyData, function(a, b)
    local aId, bId = a.item:GetID(), b.item:GetID()
    if aId == 35003 then
      return false
    elseif bId == 35003 then
      return true
    else
      return aId > bId
    end
  end)
  for _, v in ipairs(moneyData) do
    table.insert(self._data, 1, v)
  end
  if #self._data ~= 0 then
    self._emptyTips:SetActive(false)
  else
    self._emptyTips:SetActive(true)
    local str = TextManager.GetText(CStringRes:GetRecorder(1106).msgTextID)
    self._emptyTips:SetText(str)
  end
  self._itemFrame:ReloadAllCell()
  self._getMoney:SetNumber(money[DataCommon.ManaID] or 0)
  self._totalMoney:SetNumber(NekoData.BehaviorManager.BM_Currency:GetMoney())
  self._supportRoleInfo = NekoData.BehaviorManager.BM_Team:GetSupportRole()
  if self._supportRoleInfo.user and self._supportRoleInfo.user:IsStranger() then
    self._task = GameTimer.AddTask(0.5, 0, function()
      self._task = nil
      DialogManager.CreateSingletonDialog("assistbattle.addfriendsecondconfirmdialog"):SetConfirmFunc(function()
        NekoData.BehaviorManager.BM_Friends:RequesAddFriend(self._supportRoleInfo.user:GetID())
      end)
    end, nil)
  end
end

function SwimSuitAccountDialog:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._data
  end
end

function SwimSuitAccountDialog:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "dungeon.dungeonaccountcell"
  end
end

function SwimSuitAccountDialog:DataAtIndex(frame, index)
  if frame == self._itemFrame and #self._data ~= 0 then
    return self._data[index]
  end
end

function SwimSuitAccountDialog:OnNextClicked()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if not controller then
    NekoData.BehaviorManager.BM_Game:FinishDungeonReward()
  end
  self:Destroy()
end

function SwimSuitAccountDialog:OnTipsDestroy(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._itemFrame:FireEvent("SetItemSelectedState", nil)
  end
end

function SwimSuitAccountDialog:SetSelectedID(args)
  self._itemFrame:FireEvent("SetItemSelectedState", args)
end

function SwimSuitAccountDialog:SetNotSelect()
  self._itemFrame:FireEvent("SetItemSelectedState", nil)
end

return SwimSuitAccountDialog
