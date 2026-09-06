local TabFrame = require("framework.ui.frame.tab.tabframe")
local GuildDialog = class("GuildDialog", Dialog)
GuildDialog.AssetBundleName = "ui/layouts.guild"
GuildDialog.AssetName = "GuildMain"

function GuildDialog:Ctor(...)
  GuildDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tab = nil
end

function GuildDialog:OnCreate()
  self:GetRootWindow():Subscribe_PointerDownEvent(nil, self)
  self._groupBtns = {}
  self._groupBtns[1] = self:GetChild("ChatBtn")
  self._groupBtns[2] = self:GetChild("MemberBtn")
  for i, v in ipairs(self._groupBtns) do
    v:Subscribe_PointerClickEvent(function()
      self:OnGroupBtnClick(i)
    end, self)
  end
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  UIBackManager.SetUIBackShow(true)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

function GuildDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
  self._frame:Destroy()
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
end

function GuildDialog:Init()
  self._baseSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  self:OnGroupBtnClick(1)
end

function GuildDialog:OnGroupBtnClick(index)
  if self._tab ~= index then
    self._tab = index
    local cellPage = self._frame:ToPage(self._tab)
    if cellPage and cellPage.RefreshCell then
      cellPage:RefreshCell()
    end
  end
end

function GuildDialog:DidToPage(frame, index)
  for k, v in pairs(self._groupBtns) do
    v:SetSelected(k == index)
  end
end

function GuildDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "guild.guildmaindetailtabcell"
  elseif index == 2 then
    return "guild.guildmainmembertabcell"
  end
end

function GuildDialog:OnBackBtnClicked()
  self:Destroy()
end

function GuildDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function GuildDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "friend.charactershowdialog" then
    self._rootWindow:SetActive(true)
  end
end

return GuildDialog
