-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/roleskinlist/roleskinlistrewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleSkinListRewardDialog = class("RoleSkinListRewardDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local CSkinBonus = (BeanManager.GetTableByName)("recharge.cskinbonus")
local TopToBottom = 4
RoleSkinListRewardDialog.AssetBundleName = "ui/layouts.baseshop"
RoleSkinListRewardDialog.AssetName = "FashionShopListReward"
RoleSkinListRewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleSkinListRewardDialog
  ((RoleSkinListRewardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

RoleSkinListRewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame, TopToBottom
  self._title = self:GetChild("Back/Title")
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1903))
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._scrollbar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollbar):SetScrollDirection(TopToBottom)
  self._width = (self._panel):GetRectSize()
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._Txt1 = self:GetChild("Back/Difficulty/Txt1")
  self._Txt2 = self:GetChild("Back/Difficulty/Txt2")
  ;
  (self._Txt1):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1905))
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRewardList, Common.n_RefreshSkinCollectAwardStatus, nil)
end

RoleSkinListRewardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  if self._frame then
    (self._frame):Destroy()
  end
end

RoleSkinListRewardDialog.Init = function(self)
  -- function num : 0_3
  self:RefreshRewardList()
  ;
  (self._frame):MoveToTop()
end

RoleSkinListRewardDialog.RefreshRewardList = function(self)
  -- function num : 0_4 , upvalues : _ENV, CSkinBonus, Item
  (self._Txt2):SetText(((NekoData.BehaviorManager).BM_SkinList):GetProcessStr())
  self._rewards = {}
  local statelist = ((NekoData.BehaviorManager).BM_SkinList):GetSkinCollectTask()
  for _,v in ipairs(CSkinBonus:GetAllIds()) do
    local recoder = CSkinBonus:GetRecorder(v)
    local items = {}
    local temptable = {}
    for i,v in ipairs(recoder.itemsId) do
      local item = (Item.Create)(v)
      item:SetCount((recoder.itemsNums)[i])
      local temp = {}
      temp.value = item
      temp.type = "item"
      ;
      (table.insert)(temptable, temp)
    end
    for _,value in ipairs(temptable) do
      (table.insert)(items, value)
    end
    ;
    (table.insert)(self._rewards, {recorder = recoder, state = statelist[v], items = items})
  end
  local lastPos = (self._frame):GetCurrentPosition()
  ;
  (self._frame):ReloadAllCell()
  if lastPos then
    (self._frame):MoveToAssignedPos(lastPos)
  end
end

RoleSkinListRewardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._rewards
end

RoleSkinListRewardDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_6
  return "shop.roleskinlist.roleskinlistrewardcell"
end

RoleSkinListRewardDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_7
  return (self._rewards)[index]
end

RoleSkinListRewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

RoleSkinListRewardDialog.OnCommitClick = function(self, rewardId)
  -- function num : 0_9 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.item.cfetchskincollectaward")
  csend.taskId = rewardId
  csend:Send()
end

RoleSkinListRewardDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_10
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollbar):SetActive(true)
    ;
    (self._scrollbar):SetScrollSize(self._height / total)
    ;
    (self._scrollbar):SetScrollValue(proportion)
  else
    ;
    (self._scrollbar):SetActive(false)
  end
end

return RoleSkinListRewardDialog

