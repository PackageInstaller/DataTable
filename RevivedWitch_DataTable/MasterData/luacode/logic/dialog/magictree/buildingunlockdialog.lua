-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/buildingunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local BuildingUnlockDialog = class("BuildingUnlockDialog", Dialog)
BuildingUnlockDialog.AssetBundleName = "ui/layouts.yard"
BuildingUnlockDialog.AssetName = "YardTreeUnLock"
local HandleHandleStage = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  if userInfo.guideID == 16 then
    if (userInfo.stageRefCountTable)[4] > 0 then
      self._guideTag = true
      local width, height = (self._confirmBtn):GetRectSize()
      local screenPos = (self._confirmBtn):GetLocalPointInUiRootPanel()
      local dialog = (DialogManager.CreateSingletonDialog)("guide.guidedialog")
      dialog:SetGuideId(userInfo.guideID)
      dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
    else
      do
        if self._guideTag then
          self._guideTag = false
          ;
          (DialogManager.DestroySingletonDialog)("guide.guidedialog")
        end
      end
    end
  end
end

BuildingUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : BuildingUnlockDialog
  ((BuildingUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._taskId = nil
  self._items = {}
end

BuildingUnlockDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV, HandleHandleStage
  self._name = self:GetChild("Title")
  self._time = self:GetChild("Time/Time")
  self._result = self:GetChild("Effect/Txt")
  self._itemsPanel = self:GetChild("ItemFrame")
  self._itemsFrame = (TableFrame.Create)(self._itemsPanel, self, false, false)
  self._cancelBtn = self:GetChild("CancelBtn")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleHandleStage, Common.n_HandleStage, nil)
end

BuildingUnlockDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._itemsFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("guide.guidedialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

BuildingUnlockDialog.Init = function(self, taskId)
  -- function num : 0_4 , upvalues : CCourtyardLvUpCfg, _ENV, CCourtyardNameCfg, CStringres
  self._taskId = taskId
  local record = CCourtyardLvUpCfg:GetRecorder(taskId)
  local str = ""
  str = (TextManager.GetText)((CCourtyardNameCfg:GetRecorder(record.functionID)).nameTextID)
  ;
  (self._name):SetText(str)
  local time = record.time * 60
  str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time))
  str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time))
  ;
  (self._time):SetText(str)
  ;
  (self._result):SetText((TextManager.GetText)(record.unlockEffectTextID))
  self._itemsEnough = true
  for i,v in ipairs(record.items) do
    local data = {}
    data.id = v
    data.num = (record.nums)[i]
    ;
    (table.insert)(self._items, data)
    local haveNum = 0
    if (string.sub)(R13_PC95, 1, 2) == "35" then
      haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(R14_PC103)
    else
      -- DECOMPILER ERROR at PC109: Overwrote pending register: R13 in 'AssignReg'

      haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(R14_PC103)
    end
    if self._itemsEnough and haveNum < (record.nums)[i] then
      self._itemsEnough = false
    end
  end
  ;
  (self._itemsFrame):ReloadAllCell()
  local width, height = (self._itemsPanel):GetRectSize()
  local cellPanelWidth = width / 4 * #self._items
  local cellPanelHeight = (self._itemsFrame):GetTotalLength()
  local rootWindowAnchoredx, rootWindowAnchoredy = (self._itemsPanel):GetAnchoredPosition()
  -- DECOMPILER ERROR at PC141: Overwrote pending register: R13 in 'AssignReg'

  -- DECOMPILER ERROR at PC142: Overwrote pending register: R14 in 'AssignReg'

  ;
  (self._itemsPanel):SetSize(R13_PC95, R14_PC103, 0, cellPanelHeight)
  -- DECOMPILER ERROR at PC148: Overwrote pending register: R13 in 'AssignReg'

  -- DECOMPILER ERROR at PC149: Overwrote pending register: R14 in 'AssignReg'

  ;
  (self._itemsPanel):SetAnchoredPosition(R13_PC95, R14_PC103)
  ;
  (self._itemsFrame):ReloadAllCell()
end

BuildingUnlockDialog.NumberOfCell = function(self)
  -- function num : 0_5
  return #self._items
end

BuildingUnlockDialog.CellAtIndex = function(self)
  -- function num : 0_6
  return "magictree.buildinglevelupitemcell"
end

BuildingUnlockDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._items)[index]
end

BuildingUnlockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

BuildingUnlockDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_9 , upvalues : CCourtyardLvUpCfg, _ENV
  if self._itemsEnough then
    local record = CCourtyardLvUpCfg:GetRecorder(self._taskId)
    local cstartTreeTask = (LuaNetManager.CreateProtocol)("protocol.yard.cstarttreetask")
    cstartTreeTask.buildId = record.functionID
    cstartTreeTask:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100095)
    end
  end
end

return BuildingUnlockDialog

