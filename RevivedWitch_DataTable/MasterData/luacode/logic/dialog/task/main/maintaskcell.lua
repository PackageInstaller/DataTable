-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/main/maintaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainTaskCell = class("MainTaskCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
MainTaskCell.AssetBundleName = "ui/layouts.basetasklist"
MainTaskCell.AssetName = "TaskStoryCell1"
MainTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainTaskCell
  ((MainTaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

MainTaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._board = self:GetChild("Back")
  self._name = self:GetChild("Back/Title1")
  self._desc = self:GetChild("Back/Detail")
  self._new = self:GetChild("Back/New")
  self._done = self:GetChild("Back/DoneImg")
  self._background = self:GetChild("Back/WorldImg")
  self._selected = self:GetChild("Back/Select")
  self._marks = {self:GetChild("Back/TitleBack"), self:GetChild("Back/TitleBack2")}
  ;
  (self._board):Subscribe_PointerClickEvent(self.OnMouseClick, self)
  ;
  (self:GetRootWindow()):Subscribe_AnimationEvent("TaskCellFinish", self.OnAnimationEvent, self)
end

MainTaskCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

MainTaskCell.RefreshCell = function(self)
  -- function num : 0_3
  (self._name):SetText((self._cellData):GetName())
  if not (self._cellData):GetHintText() then
    (self._desc):SetText((self._cellData):GetShortDesc())
    local background = (self._cellData):GetBackground()
    if background then
      (self._background):SetSprite(background.assetBundle, background.assetName)
    end
    ;
    (self._new):SetActive(not (self._cellData):IsNewTask() or (self._cellData):GetStatus() == 4)
    ;
    (self._done):SetActive((self._cellData):GetStatus() == 3)
    ;
    ((self._marks)[1]):SetActive((self._cellData):GetType() == 1)
    ;
    ((self._marks)[2]):SetActive((self._cellData):GetType() == 2)
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

MainTaskCell.OnMouseClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (((NekoData.BehaviorManager).BM_Task):GetTask((self._cellData):GetID())):SetNewTask(false)
  ;
  (self._delegate):OnCellClick((self._cellData):GetID())
end

MainTaskCell.OnAnimationEvent = function(self)
  -- function num : 0_5
  (self._delegate):OnCellFinish((self._cellData):GetID())
end

MainTaskCell.OnEvent = function(self, name, args)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

  if name == "remove" and args == (self._cellData):GetID() then
    (self:GetRootWindow()):SetAnimatorTrigger("onFinish")
  end
  if name == "select" then
    self:RefreshCell()
    ;
    (self._selected):SetActive(args == (self._cellData):GetID())
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return MainTaskCell

