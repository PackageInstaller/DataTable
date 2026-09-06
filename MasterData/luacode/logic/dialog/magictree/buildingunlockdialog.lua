local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local CCourtyardNameCfg = BeanManager.GetTableByName("courtyard.ccourtyardname")
local BuildingUnlockDialog = class("BuildingUnlockDialog", Dialog)
BuildingUnlockDialog.AssetBundleName = "ui/layouts.yard"
BuildingUnlockDialog.AssetName = "YardTreeUnLock"

local function HandleHandleStage(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  if userInfo.guideID == 16 then
    if userInfo.stageRefCountTable[4] > 0 then
      self._guideTag = true
      local width, height = self._confirmBtn:GetRectSize()
      local screenPos = self._confirmBtn:GetLocalPointInUiRootPanel()
      local dialog = DialogManager.CreateSingletonDialog("guide.guidedialog")
      dialog:SetGuideId(userInfo.guideID)
      dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
    elseif self._guideTag then
      self._guideTag = false
      DialogManager.DestroySingletonDialog("guide.guidedialog")
    end
  end
end

function BuildingUnlockDialog:Ctor(...)
  BuildingUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._taskId = nil
  self._items = {}
end

function BuildingUnlockDialog:OnCreate()
  self._name = self:GetChild("Title")
  self._time = self:GetChild("Time/Time")
  self._result = self:GetChild("Effect/Txt")
  self._itemsPanel = self:GetChild("ItemFrame")
  self._itemsFrame = TableFrame.Create(self._itemsPanel, self, false, false)
  self._cancelBtn = self:GetChild("CancelBtn")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, HandleHandleStage, Common.n_HandleStage, nil)
end

function BuildingUnlockDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._itemsFrame:Destroy()
  DialogManager.DestroySingletonDialog("guide.guidedialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function BuildingUnlockDialog:Init(taskId)
  self._taskId = taskId
  local record = CCourtyardLvUpCfg:GetRecorder(taskId)
  local str = ""
  str = TextManager.GetText(CCourtyardNameCfg:GetRecorder(record.functionID).nameTextID)
  self._name:SetText(str)
  local time = record.time * 60
  str = TextManager.GetText(CStringres:GetRecorder(1109).msgTextID)
  str = string.gsub(str, "%$parameter1%$", os.date("!%H", time))
  str = string.gsub(str, "%$parameter2%$", os.date("!%M", time))
  str = string.gsub(str, "%$parameter3%$", os.date("!%S", time))
  self._time:SetText(str)
  self._result:SetText(TextManager.GetText(record.unlockEffectTextID))
  self._itemsEnough = true
  for i, v in ipairs(record.items) do
    local data = {}
    data.id = v
    data.num = record.nums[i]
    table.insert(self._items, data)
    local haveNum = 0
    if string.sub(v, 1, 2) == "35" then
      haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(v)
    else
      haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
    end
    if self._itemsEnough and haveNum < record.nums[i] then
      self._itemsEnough = false
    end
  end
  self._itemsFrame:ReloadAllCell()
  local width, height = self._itemsPanel:GetRectSize()
  local cellPanelWidth = width / 4 * #self._items
  local cellPanelHeight = self._itemsFrame:GetTotalLength()
  local rootWindowAnchoredx, rootWindowAnchoredy = self._itemsPanel:GetAnchoredPosition()
  self._itemsPanel:SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  self._itemsPanel:SetAnchoredPosition(rootWindowAnchoredx, rootWindowAnchoredy)
  self._itemsFrame:ReloadAllCell()
end

function BuildingUnlockDialog:NumberOfCell()
  return #self._items
end

function BuildingUnlockDialog:CellAtIndex()
  return "magictree.buildinglevelupitemcell"
end

function BuildingUnlockDialog:DataAtIndex(frame, index)
  return self._items[index]
end

function BuildingUnlockDialog:OnBackBtnClicked()
  self:Destroy()
end

function BuildingUnlockDialog:OnConfirmBtnClicked()
  if self._itemsEnough then
    local record = CCourtyardLvUpCfg:GetRecorder(self._taskId)
    local cstartTreeTask = LuaNetManager.CreateProtocol("protocol.yard.cstarttreetask")
    cstartTreeTask.buildId = record.functionID
    cstartTreeTask:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100095)
  end
end

return BuildingUnlockDialog
