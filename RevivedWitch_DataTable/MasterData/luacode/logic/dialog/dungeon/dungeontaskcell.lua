-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeontaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonTaskCell = class("DungeonTaskCell", Dialog)
DungeonTaskCell.AssetBundleName = "ui/layouts.dungeon"
DungeonTaskCell.AssetName = "DungeonMenuTask1Cell"
local TableFrame = require("framework.ui.frame.table.tableframe")
DungeonTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonTaskCell
  ((DungeonTaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

DungeonTaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Task")
  self._progress = {[1] = self:GetChild("NumGreen"), [3] = self:GetChild("NumOrange"), [8] = self:GetChild("NumOrange")}
  self._marks = {[1] = self:GetChild("MainImg"), [2] = self:GetChild("BranchImg"), [3] = self:GetChild("QiYuanImg"), [8] = self:GetChild("QiYuanImg")}
  self._finishImg = self:GetChild("FinishImage")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnClick, self)
end

DungeonTaskCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonTaskCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in pairs(self._marks) do
    v:SetActive(false)
  end
  for i,v in pairs(self._progress) do
    v:SetActive(false)
  end
  ;
  (self._name):SetText((self._cellData):GetName())
  for i,v in pairs(self._marks) do
    if (self._cellData):GetType() == i then
      v:SetActive(true)
      break
    end
  end
  do
    ;
    (self._finishImg):SetActive((self._cellData):GetStatus() == 3)
    local progress = (self._cellData):GetProgress()
    if #progress <= 1 then
      self._data = {}
      if #progress == 0 or not (self._delegate):ShouldShowProgress() then
        for _,v in pairs(self._progress) do
          v:SetActive(false)
        end
      elseif #progress == 1 then
        local text = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1058)).msgTextID
        text = (TextManager.GetText)(text)
        text = text:gsub("%$parameter(%d)", {["1"] = (progress[1]).current, ["2"] = (progress[1]).total})
        for i,v in pairs(self._progress) do
          if i ~= (self._cellData):GetType() then
            do
              v:SetActive((self._cellData):GetType() ~= i)
              v:SetText(text)
              if (self._cellData):GetStatus() == 3 then
                v:SetActive(false)
              end
              do break end
              -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    else
      self._data = progress
      ;
      (self._helper):ReloadAllCell()
      local length = (self._helper):GetTotalLength()
      ;
      (self._helper):ReloadAllCell()
    end
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
end

DungeonTaskCell.OnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("task.tasktipdialog")):SetData(self._cellData)
end

DungeonTaskCell.NumberOfCell = function(self)
  -- function num : 0_5
  if (self._delegate):ShouldShowProgress() then
    return #self._tasks
  end
  return 0
end

DungeonTaskCell.CellAtIndex = function(self)
  -- function num : 0_6
  return "dungeon.dungeontaskprogresscell"
end

DungeonTaskCell.DataAtIndex = function(self, helper, index)
  -- function num : 0_7 , upvalues : _ENV
  local data = clone((self._data)[index])
  data.type = (self._cellData):GetType()
  data.index = index
  return data
end

return DungeonTaskCell

