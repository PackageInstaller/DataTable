-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/buildinglevelupdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local BuildingLevelUpDialog = class("BuildingLevelUpDialog", Dialog)
BuildingLevelUpDialog.AssetBundleName = "ui/layouts.yard"
BuildingLevelUpDialog.AssetName = "MagicTreeLevelUp"
BuildingLevelUpDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuildingLevelUpDialog
  ((BuildingLevelUpDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._taskId = nil
  self._items = {}
  self._conditions = {}
  self._effects = {}
  self._gameTimerID = nil
end

BuildingLevelUpDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._name = self:GetChild("Back/Title")
  self._curLevel = self:GetChild("Back/Level/LevelNum1")
  self._nextLevel = self:GetChild("Back/Level/LevelNum2")
  self._time = self:GetChild("Back/Time/Time")
  self._unlockCondition = self:GetChild("Condition/Condition")
  self._itemsPanel = self:GetChild("Back/Condition/Frame")
  self._effectPanel = self:GetChild("Back/Effect/Frame")
  self._itemsFrame = (TableFrame.Create)(self._itemsPanel, self, false, false)
  self._effectFrame = (TableFrame.Create)(self._effectPanel, self, true, false, true)
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

BuildingLevelUpDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  ;
  (self._itemsFrame):Destroy()
  ;
  (self._effectFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

BuildingLevelUpDialog.Init = function(self, taskId)
  -- function num : 0_3 , upvalues : CCourtyardLvUpCfg, _ENV, CCourtyardNameCfg, CStringres
  self._taskId = taskId
  local record = CCourtyardLvUpCfg:GetRecorder(taskId)
  local str = ""
  str = (TextManager.GetText)((CCourtyardNameCfg:GetRecorder(record.functionID)).nameTextID)
  ;
  (self._name):SetText(str)
  local nextLv = record.id - record.functionID
  ;
  (self._curLevel):SetText(tostring(nextLv - 1))
  ;
  (self._nextLevel):SetText(nextLv)
  local time = record.time * 60
  str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time))
  str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time))
  ;
  (self._time):SetText(str)
  self._effects = record.unlockEffect
  ;
  (self._effectFrame):ReloadAllCell()
  str = (TextManager.GetText)((CStringres:GetRecorder(1110)).msgTextID)
  self._magictreeLvLimitTag = record.openCondition <= ((NekoData.BehaviorManager).BM_MagicTree):GetLevel()
  self._itemsEnough = true
  for i,v in ipairs(record.items) do
    local data = {}
    data.id = v
    data.num = (record.nums)[i]
    local haveNum = 0
    if (string.sub)(R14_PC121, 1, 2) == "35" then
      haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(R15_PC129)
    else
      -- DECOMPILER ERROR at PC135: Overwrote pending register: R14 in 'AssignReg'

      haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(R15_PC129)
    end
    if self._itemsEnough and haveNum < (record.nums)[i] then
      self._itemsEnough = false
    end
    -- DECOMPILER ERROR at PC149: Overwrote pending register: R14 in 'AssignReg'

    ;
    (table.insert)(R14_PC121, R15_PC129)
    R15_PC129 = {type = "Item", data = data}
  end
  ;
  (table.insert)(self._conditions, {type = "Building", 
data = {id = DataCommon.MagicTree, curLv = ((NekoData.BehaviorManager).BM_MagicTree):GetLevel(), cdtLv = record.openCondition}
})
  ;
  (self._itemsFrame):ReloadAllCell()
  local width, height = (self._itemsPanel):GetRectSize()
  local cellPanelWidth = width / 3 * #self._conditions
  local cellPanelHeight = (self._itemsFrame):GetTotalLength()
  local rootWindowAnchoredx, rootWindowAnchoredy = (self._itemsPanel):GetAnchoredPosition()
  -- DECOMPILER ERROR at PC193: Overwrote pending register: R14 in 'AssignReg'

  ;
  (self._itemsPanel):SetSize(R14_PC121, R15_PC129, 0, cellPanelHeight)
  -- DECOMPILER ERROR at PC200: Overwrote pending register: R14 in 'AssignReg'

  -- DECOMPILER ERROR at PC201: Overwrote pending register: R15 in 'AssignReg'

  ;
  (self._itemsPanel):SetAnchoredPosition(R14_PC121, R15_PC129)
  ;
  (self._itemsFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

BuildingLevelUpDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  if frame == self._itemsFrame then
    return #self._conditions
  else
    return #self._effects
  end
end

BuildingLevelUpDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._itemsFrame then
    if ((self._conditions)[index]).type == "Item" then
      return "magictree.buildinglevelupitemcell"
    else
      return "magictree.buildinglevelupbuildingcell"
    end
  else
    return "magictree.buildinglevelupeffectcell"
  end
end

BuildingLevelUpDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._itemsFrame then
    return ((self._conditions)[index]).data
  else
    return (self._effects)[index]
  end
end

BuildingLevelUpDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

BuildingLevelUpDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_8 , upvalues : CCourtyardLvUpCfg, _ENV
  if self._magictreeLvLimitTag and self._itemsEnough then
    local record = CCourtyardLvUpCfg:GetRecorder(self._taskId)
    local cstartTreeTask = (LuaNetManager.CreateProtocol)("protocol.yard.cstarttreetask")
    cstartTreeTask.buildId = record.functionID
    cstartTreeTask:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100203)
      if not self._gameTimerID then
        self._gameTimerID = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_8_0 , upvalues : self
    (self._itemsFrame):FireEvent("ShowTips")
  end
)
      end
    end
  end
end

return BuildingLevelUpDialog

