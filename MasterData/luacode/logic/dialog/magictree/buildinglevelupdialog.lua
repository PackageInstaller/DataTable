local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local CCourtyardNameCfg = BeanManager.GetTableByName("courtyard.ccourtyardname")
local BuildingLevelUpDialog = class("BuildingLevelUpDialog", Dialog)
BuildingLevelUpDialog.AssetBundleName = "ui/layouts.yard"
BuildingLevelUpDialog.AssetName = "MagicTreeLevelUp"

function BuildingLevelUpDialog:Ctor(...)
  BuildingLevelUpDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._taskId = nil
  self._items = {}
  self._conditions = {}
  self._effects = {}
  self._gameTimerID = nil
end

function BuildingLevelUpDialog:OnCreate()
  self._name = self:GetChild("Back/Title")
  self._curLevel = self:GetChild("Back/Level/LevelNum1")
  self._nextLevel = self:GetChild("Back/Level/LevelNum2")
  self._time = self:GetChild("Back/Time/Time")
  self._unlockCondition = self:GetChild("Condition/Condition")
  self._itemsPanel = self:GetChild("Back/Condition/Frame")
  self._effectPanel = self:GetChild("Back/Effect/Frame")
  self._itemsFrame = TableFrame.Create(self._itemsPanel, self, false, false)
  self._effectFrame = TableFrame.Create(self._effectPanel, self, true, false, true)
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function BuildingLevelUpDialog:OnDestroy()
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  self._itemsFrame:Destroy()
  self._effectFrame:Destroy()
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function BuildingLevelUpDialog:Init(taskId)
  self._taskId = taskId
  local record = CCourtyardLvUpCfg:GetRecorder(taskId)
  local str = ""
  str = TextManager.GetText(CCourtyardNameCfg:GetRecorder(record.functionID).nameTextID)
  self._name:SetText(str)
  local nextLv = record.id - record.functionID
  self._curLevel:SetText(tostring(nextLv - 1))
  self._nextLevel:SetText(nextLv)
  local time = record.time * 60
  str = TextManager.GetText(CStringres:GetRecorder(1109).msgTextID)
  str = string.gsub(str, "%$parameter1%$", os.date("!%H", time))
  str = string.gsub(str, "%$parameter2%$", os.date("!%M", time))
  str = string.gsub(str, "%$parameter3%$", os.date("!%S", time))
  self._time:SetText(str)
  self._effects = record.unlockEffect
  self._effectFrame:ReloadAllCell()
  str = TextManager.GetText(CStringres:GetRecorder(1110).msgTextID)
  self._magictreeLvLimitTag = NekoData.BehaviorManager.BM_MagicTree:GetLevel() >= record.openCondition
  self._itemsEnough = true
  for i, v in ipairs(record.items) do
    local data = {}
    data.id = v
    data.num = record.nums[i]
    local haveNum = 0
    if string.sub(v, 1, 2) == "35" then
      haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(v)
    else
      haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
    end
    if self._itemsEnough and haveNum < record.nums[i] then
      self._itemsEnough = false
    end
    table.insert(self._conditions, {type = "Item", data = data})
  end
  table.insert(self._conditions, {
    type = "Building",
    data = {
      id = DataCommon.MagicTree,
      curLv = NekoData.BehaviorManager.BM_MagicTree:GetLevel(),
      cdtLv = record.openCondition
    }
  })
  self._itemsFrame:ReloadAllCell()
  local width, height = self._itemsPanel:GetRectSize()
  local cellPanelWidth = width / 3 * #self._conditions
  local cellPanelHeight = self._itemsFrame:GetTotalLength()
  local rootWindowAnchoredx, rootWindowAnchoredy = self._itemsPanel:GetAnchoredPosition()
  self._itemsPanel:SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  self._itemsPanel:SetAnchoredPosition(rootWindowAnchoredx, rootWindowAnchoredy)
  self._itemsFrame:ReloadAllCell()
end

function BuildingLevelUpDialog:NumberOfCell(frame, index)
  if frame == self._itemsFrame then
    return #self._conditions
  else
    return #self._effects
  end
end

function BuildingLevelUpDialog:CellAtIndex(frame, index)
  if frame == self._itemsFrame then
    if self._conditions[index].type == "Item" then
      return "magictree.buildinglevelupitemcell"
    else
      return "magictree.buildinglevelupbuildingcell"
    end
  else
    return "magictree.buildinglevelupeffectcell"
  end
end

function BuildingLevelUpDialog:DataAtIndex(frame, index)
  if frame == self._itemsFrame then
    return self._conditions[index].data
  else
    return self._effects[index]
  end
end

function BuildingLevelUpDialog:OnBackBtnClicked()
  self:Destroy()
end

function BuildingLevelUpDialog:OnConfirmBtnClicked()
  if self._magictreeLvLimitTag and self._itemsEnough then
    local record = CCourtyardLvUpCfg:GetRecorder(self._taskId)
    local cstartTreeTask = LuaNetManager.CreateProtocol("protocol.yard.cstarttreetask")
    cstartTreeTask.buildId = record.functionID
    cstartTreeTask:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100203)
    if not self._gameTimerID then
      self._gameTimerID = GameTimer.AddTask(1, 0, function()
        self._itemsFrame:FireEvent("ShowTips")
      end)
    end
  end
end

return BuildingLevelUpDialog
