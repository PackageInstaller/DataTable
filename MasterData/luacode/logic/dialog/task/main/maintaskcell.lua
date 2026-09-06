local MainTaskCell = class("MainTaskCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
MainTaskCell.AssetBundleName = "ui/layouts.basetasklist"
MainTaskCell.AssetName = "TaskStoryCell1"

function MainTaskCell:Ctor(...)
  MainTaskCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function MainTaskCell:OnCreate()
  self._board = self:GetChild("Back")
  self._name = self:GetChild("Back/Title1")
  self._desc = self:GetChild("Back/Detail")
  self._new = self:GetChild("Back/New")
  self._done = self:GetChild("Back/DoneImg")
  self._background = self:GetChild("Back/WorldImg")
  self._selected = self:GetChild("Back/Select")
  self._marks = {
    self:GetChild("Back/TitleBack"),
    self:GetChild("Back/TitleBack2")
  }
  self._board:Subscribe_PointerClickEvent(self.OnMouseClick, self)
  self:GetRootWindow():Subscribe_AnimationEvent("TaskCellFinish", self.OnAnimationEvent, self)
end

function MainTaskCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function MainTaskCell:RefreshCell()
  self._name:SetText(self._cellData:GetName())
  self._desc:SetText(self._cellData:GetHintText() or self._cellData:GetShortDesc())
  local background = self._cellData:GetBackground()
  if background then
    self._background:SetSprite(background.assetBundle, background.assetName)
  end
  self._new:SetActive(self._cellData:IsNewTask() and self._cellData:GetStatus() == 4)
  self._done:SetActive(self._cellData:GetStatus() == 3)
  self._marks[1]:SetActive(self._cellData:GetType() == 1)
  self._marks[2]:SetActive(self._cellData:GetType() == 2)
end

function MainTaskCell:OnMouseClick()
  NekoData.BehaviorManager.BM_Task:GetTask(self._cellData:GetID()):SetNewTask(false)
  self._delegate:OnCellClick(self._cellData:GetID())
end

function MainTaskCell:OnAnimationEvent()
  self._delegate:OnCellFinish(self._cellData:GetID())
end

function MainTaskCell:OnEvent(name, args)
  if name == "remove" then
    if args == self._cellData:GetID() then
      self:GetRootWindow():SetAnimatorTrigger("onFinish")
    end
  elseif name == "select" then
    self:RefreshCell()
    self._selected:SetActive(args == self._cellData:GetID())
  end
end

return MainTaskCell
