-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/character/charactertaskdetailframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CharacterTaskDetailFrame = class("CharacterTaskDetailFrame", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
CharacterTaskDetailFrame.AssetBundleName = "ui/layouts.basetasklist"
CharacterTaskDetailFrame.AssetName = "TaskDetail"
CharacterTaskDetailFrame.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterTaskDetailFrame
  ((CharacterTaskDetailFrame.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

CharacterTaskDetailFrame.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._name = self:GetChild("Title")
  self._desc = self:GetChild("Detail")
  self._commit = self:GetChild("GetBtn")
  self._tip = self:GetChild("Tip")
  self._board = self:GetChild("ItemFrame")
  self._progress = {back = self:GetChild("ProgressBack"), current = self:GetChild("ProgressBack/Num/Num"), total = self:GetChild("ProgressBack/Num/NumMax"), bar = self:GetChild("ProgressBack/Progress"), text = self:GetChild("ProgressName")}
  self._goButton = self:GetChild("GoBtn")
  self._helper = (TableFrame.Create)(self._board, self, false, false)
  ;
  (self._commit):Subscribe_PointerClickEvent(self.OnCommitClick, self)
  ;
  (self._goButton):Subscribe_PointerClickEvent(self.OnGoButtonClick, self)
end

CharacterTaskDetailFrame.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._helper then
    (self._helper):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

CharacterTaskDetailFrame.RefreshCell = function(self, data, delegate)
  -- function num : 0_3
  self._cellData = data
  self._delegate = delegate
  ;
  (self._helper):ReloadAllCell()
  ;
  (self._name):SetText((self._cellData):GetName())
  ;
  (self._desc):SetText((self._cellData):GetDesc())
  ;
  (self._tip):SetText((self._cellData):GetHintLocation())
  self:RefreshProgress()
  ;
  (self._goButton):SetActive(not (self._cellData):CanJump() or (self._cellData):GetStatus() ~= 3)
  ;
  (self._commit):SetActive((self._cellData):GetStatus() == 3)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

CharacterTaskDetailFrame.RefreshProgress = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local progress = (self._cellData):GetProgress()
  local current = 0
  local total = 0
  ;
  ((self._progress).back):SetActive(#progress ~= 0)
  if #progress == 1 then
    current = (progress[1]).current
    total = (progress[1]).total
  else
    for i,v in ipairs(progress) do
      total = total + 1
      if v.total <= v.current then
        current = current + 1
      end
    end
  end
  ;
  ((self._progress).current):SetText(current)
  ;
  ((self._progress).total):SetText(total)
  ;
  ((self._progress).bar):SetFillAmount((current) / (total))
  ;
  ((self._progress).text):SetText((self._cellData):GetShortDesc())
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

CharacterTaskDetailFrame.OnCommitClick = function(self)
  -- function num : 0_5
  (self._delegate):OnCommitClick((self._cellData):GetID())
end

CharacterTaskDetailFrame.OnGoButtonClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Task):HandleTask((self._cellData):GetID())
end

CharacterTaskDetailFrame.NumberOfCell = function(self, helper)
  -- function num : 0_7
  return #(self._cellData):GetAwards()
end

CharacterTaskDetailFrame.CellAtIndex = function(self, helper, index)
  -- function num : 0_8
  return "task.taskawardcell"
end

CharacterTaskDetailFrame.DataAtIndex = function(self, helper, index)
  -- function num : 0_9
  return ((self._cellData):GetAwards())[index]
end

return CharacterTaskDetailFrame

