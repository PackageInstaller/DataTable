-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guilddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local GuildDialog = class("GuildDialog", Dialog)
GuildDialog.AssetBundleName = "ui/layouts.guild"
GuildDialog.AssetName = "GuildMain"
GuildDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildDialog
  ((GuildDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tab = nil
end

GuildDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TabFrame
  (self:GetRootWindow()):Subscribe_PointerDownEvent(nil, self)
  self._groupBtns = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._groupBtns)[1] = self:GetChild("ChatBtn")
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._groupBtns)[2] = self:GetChild("MemberBtn")
  for i,v in ipairs(self._groupBtns) do
    do
      v:Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupBtnClick(i)
  end
, self)
    end
  end
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

GuildDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (self._frame):Destroy()
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
end

GuildDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  self:OnGroupBtnClick(1)
end

GuildDialog.OnGroupBtnClick = function(self, index)
  -- function num : 0_4
  if self._tab ~= index then
    self._tab = index
    local cellPage = (self._frame):ToPage(self._tab)
    if cellPage and cellPage.RefreshCell then
      cellPage:RefreshCell()
    end
  end
end

GuildDialog.DidToPage = function(self, frame, index)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs(self._groupBtns) do
    v:SetSelected(k == index)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GuildDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if index == 1 then
    return "guild.guildmaindetailtabcell"
  else
    if index == 2 then
      return "guild.guildmainmembertabcell"
    end
  end
end

GuildDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

GuildDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

GuildDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_9
  if (notification.userInfo)._dialogName == "friend.charactershowdialog" then
    (self._rootWindow):SetActive(true)
  end
end

return GuildDialog

