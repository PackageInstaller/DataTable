-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/character/charactertaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CharacterTaskCell = class("CharacterTaskCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
CharacterTaskCell.AssetBundleName = "ui/layouts.basetasklist"
CharacterTaskCell.AssetName = "TaskStoryCellChar"
CharacterTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterTaskCell
  ((CharacterTaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
  self._guideTag = false
end

CharacterTaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._board = self:GetChild("Back")
  self._name = self:GetChild("Back/Title1")
  self._desc = self:GetChild("Back/Detail")
  self._new = self:GetChild("Back/New")
  self._done = self:GetChild("Back/DoneImg")
  self._background = self:GetChild("Back/WorldImg")
  self._selected = self:GetChild("Back/Select")
  self._photo = self:GetChild("Back/Mask/Photo")
  ;
  (self._board):Subscribe_PointerClickEvent(self.OnMouseClick, self)
  ;
  (self:GetRootWindow()):Subscribe_AnimationEvent("TaskCellFinish", self.OnAnimationEvent, self)
end

CharacterTaskCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

CharacterTaskCell.RefreshCell = function(self)
  -- function num : 0_3
  (self._name):SetText((self._cellData):GetName())
  if not (self._cellData):GetHintText() then
    (self._desc):SetText((self._cellData):GetShortDesc())
    local background = (self._cellData):GetBackground()
    if background then
      (self._background):SetSprite(background.assetBundle, background.assetName)
    end
    local photo = (self._cellData):GetRoleImage()
    if photo then
      (self._photo):SetSprite(photo.assetBundle, photo.assetName)
    end
    ;
    (self._new):SetActive(not (self._cellData):IsNewTask() or (self._cellData):GetStatus() == 4)
    ;
    (self._done):SetActive((self._cellData):GetStatus() == 3)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

CharacterTaskCell.OnMouseClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (((NekoData.BehaviorManager).BM_Task):GetTask((self._cellData):GetID())):SetNewTask(false)
  ;
  (self._delegate):OnCellClick((self._cellData):GetID())
end

CharacterTaskCell.OnAnimationEvent = function(self)
  -- function num : 0_5
  (self._delegate):OnCellFinish((self._cellData):GetID())
end

CharacterTaskCell.OnEvent = function(self, name, args)
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

return CharacterTaskCell

