-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/maincityfirstawarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local DungeonFirstAwardDialog = class("DungeonFirstAwardDialog", Dialog)
DungeonFirstAwardDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonFirstAwardDialog.AssetName = "DungeonFinish1"
DungeonFirstAwardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonFirstAwardDialog
  ((DungeonFirstAwardDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

DungeonFirstAwardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._itemField = self:GetChild("Frame/CellPanel")
  self._nextBtn = self:GetChild("Frame/NextImage")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
end

DungeonFirstAwardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if self._showAddFriend then
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
  end
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
end

DungeonFirstAwardDialog.SetTag = function(self, tag)
  -- function num : 0_3
  self._tag = tag
end

DungeonFirstAwardDialog.SetData = function(self, bagList)
  -- function num : 0_4 , upvalues : _ENV, TableFrame
  self._data = {}
  for _,v in ipairs(bagList) do
    (table.insert)(self._data, {item = v})
  end
  if #self._data < 5 then
    local width, height = (self._itemField):GetRectSize()
    local cellPanelWidth = width / 5 * #self._data
    local cellPanelHeight = height / 3
    ;
    (self._itemField):SetWidth(0, cellPanelWidth)
    ;
    (self._itemField):SetHeight(0, cellPanelHeight)
    local rootWindowAnchoredx, rootWindowAnchoredy = (self:GetRootWindow()):GetAnchoredPosition()
    ;
    (self._itemField):SetAnchoredPosition(rootWindowAnchoredx, rootWindowAnchoredy)
    self._itemFrame = (TableFrame.Create)(self._itemField, self, true, false)
  else
    do
      self._itemFrame = (TableFrame.Create)(self._itemField, self, false, true)
      ;
      (self._itemFrame):SetMargin(20, 0)
      ;
      (self._itemFrame):ReloadAllCell()
      self._supportRoleInfo = ((NekoData.BehaviorManager).BM_Team):GetSupportRole()
      if (self._supportRoleInfo).user and ((self._supportRoleInfo).user):IsStranger() then
        self._task = (GameTimer.AddTask)(0.5, 0, function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    self._task = nil
    self._showAddFriend = true
    ;
    ((DialogManager.CreateSingletonDialog)("assistbattle.addfriendsecondconfirmdialog")):SetConfirmFunc(function()
      -- function num : 0_4_0_0 , upvalues : _ENV, self
      ((NekoData.BehaviorManager).BM_Friends):RequesAddFriend(((self._supportRoleInfo).user):GetID())
    end
)
  end
, nil)
      end
    end
  end
end

DungeonFirstAwardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._itemFrame then
    return #self._data
  end
end

DungeonFirstAwardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._itemFrame then
    return "dungeon.dungeonfirstawardcell"
  end
end

DungeonFirstAwardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._itemFrame and #self._data ~= 0 then
    return (self._data)[index]
  end
end

DungeonFirstAwardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  if self._canClose then
    self:Destroy()
  end
end

DungeonFirstAwardDialog.OnTipsDestroy = function(self, notification)
  -- function num : 0_9
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._itemFrame):FireEvent("SetItemSelectedState", nil)
  end
end

DungeonFirstAwardDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_10
  if stateName == "DungeonFinishGetItem" then
    self._canClose = true
  end
end

return DungeonFirstAwardDialog

