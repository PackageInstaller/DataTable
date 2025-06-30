-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/friendsmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendsMainDialog = class("FriendsMainDialog", Dialog)
local TabFrame = require("framework.ui.frame.tab.tabframe")
local RedData = require("logic.manager.experimental.types.reddata")
FriendsMainDialog.AssetBundleName = "ui/layouts.friends"
FriendsMainDialog.AssetName = "FriendsMain"
FriendsMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendsMainDialog
  ((FriendsMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

FriendsMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  (self:GetRootWindow()):Subscribe_PointerDownEvent(nil, self)
  self._groupBtnInfo = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtnInfo)[i] = {}
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

      if i < 3 then
        ((self._groupBtnInfo)[i]).redicon = self:GetChild("Back/GroupBtn" .. i .. "/RedDot")
      end
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._groupBtnInfo)[i]).btn = self:GetChild("Back/GroupBtn" .. i)
      ;
      (((self._groupBtnInfo)[i]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupClick(i)
  end
)
    end
  end
  self._panelWnd = self:GetChild("Back/RightPanel")
  self._pageHelper = (TabFrame.Create)(self._panelWnd, self)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
  self:SetRedData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedData, Common.n_FriendsRedChange, nil)
  self:OnGroupClick(4)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
end

FriendsMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._pageHelper):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
end

FriendsMainDialog.OnGroupClick = function(self, index)
  -- function num : 0_3
  (self._pageHelper):ToPage(index)
end

FriendsMainDialog.DidToPage = function(self, helper, index)
  -- function num : 0_4
  local dlg = (self._pageHelper):GetCellAtIndex(index)
  if dlg.Refresh then
    dlg:Refresh()
  end
  for i = 1, 4 do
    (((self._groupBtnInfo)[i]).btn):SetSelected(index == i)
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FriendsMainDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_5
  if index == 1 then
    return "friend.friendslistdialog"
  else
    if index == 2 then
      return "friend.findfriendsdialog"
    else
      if index == 3 then
        return "friend.blacklistdialog"
      else
        if index == 4 then
          return "friend.hexmaterialdialog"
        end
      end
    end
  end
end

FriendsMainDialog.SetRedData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local redData = ((NekoData.BehaviorManager).BM_Friends):GetRedData()
  for i = 1, 2 do
    (((self._groupBtnInfo)[i]).redicon):SetActive(redData:IsIndexTrue(i))
  end
end

FriendsMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

FriendsMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return FriendsMainDialog

