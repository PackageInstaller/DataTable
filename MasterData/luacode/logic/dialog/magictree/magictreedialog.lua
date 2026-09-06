local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CCourtyardNameCfg = BeanManager.GetTableByName("courtyard.ccourtyardname")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local CMagictreePanelStringCfg = BeanManager.GetTableByName("courtyard.cmagictreepanelstring")
local CTreeLvUp = BeanManager.GetTableByName("courtyard.ctreelvup")
local TaskStateEnum = LuaNetManager.GetBeanDef("protocol.yard.task")
local BM_Buildings = {}
BM_Buildings[DataCommon.MagicTree] = NekoData.BehaviorManager.BM_MagicTree
BM_Buildings[DataCommon.Explore] = NekoData.BehaviorManager.BM_Explore
BM_Buildings[DataCommon.Firefly] = NekoData.BehaviorManager.BM_Firefly
BM_Buildings[DataCommon.Alchemy] = NekoData.BehaviorManager.BM_Alchemy
BM_Buildings[DataCommon.Cabin] = NekoData.BehaviorManager.BM_Cabin
BM_Buildings[DataCommon.TrainCamp] = NekoData.BehaviorManager.BM_TrainCamp
BM_Buildings[DataCommon.YardMusic] = NekoData.BehaviorManager.BM_YardMusic
local MagicTreeDialog = class("MagicTreeDialog", Dialog)
MagicTreeDialog.AssetBundleName = "ui/layouts.yard"
MagicTreeDialog.AssetName = "MagicTreeNew"

function MagicTreeDialog:Ctor(...)
  MagicTreeDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._courtyardSceneController = nil
  self._currencies = {}
  self._task = nil
  self._selectBuildingId = nil
  self._magicTreeEffectHandler = nil
  self._magicTreeLvUpClick = false
end

function MagicTreeDialog:OnCreate()
  self._iBtn = self:GetChild("Ibtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._currencyPanel = self:GetChild("TopGroup")
  self._magicTreeEffect = self:GetChild("TreeDetail/Tree/Effect")
  self._magicTreeName = self:GetChild("TreeDetail/Tree/Detail/Title")
  self._buildings = {}
  for k, v in pairs(BM_Buildings) do
    local node = ""
    if k == DataCommon.MagicTree then
      node = "Tree"
    elseif k == DataCommon.Explore then
      node = "Cell2"
    elseif k == DataCommon.Firefly then
      node = "Cell3"
    elseif k == DataCommon.Alchemy then
      node = "Cell4"
    elseif k == DataCommon.Cabin then
      node = "Cell1"
    elseif k == DataCommon.TrainCamp then
      node = "Cell5"
    elseif k == DataCommon.YardMusic then
      node = "Cell6"
    end
    self._buildings[k] = {}
    self._buildings[k].node = self:GetChild("TreeDetail/" .. node)
    self._buildings[k].unlock = self:GetChild("TreeDetail/" .. node .. "/Detail")
    self._buildings[k].lvTxt = self:GetChild("TreeDetail/" .. node .. "/Detail/LV")
    self._buildings[k].lvMax = self:GetChild("TreeDetail/" .. node .. "/Detail/LVNum")
    if k ~= DataCommon.MagicTree then
      self._buildings[k].icon = self:GetChild("TreeDetail/" .. node .. "/Image")
      self._buildings[k].lock = self:GetChild("TreeDetail/" .. node .. "/LockState")
      self._buildings[k].lock_name = self:GetChild("TreeDetail/" .. node .. "/LockState/Title")
      self._buildings[k].lock_image = self:GetChild("TreeDetail/" .. node .. "/LockState/Black")
      self._buildings[k].lock_redDot = self:GetChild("TreeDetail/" .. node .. "/LockState/RedDot")
    end
    self._buildings[k].lvUpIng = self:GetChild("TreeDetail/" .. node .. "/LevelUpState")
    self._buildings[k].lvUpIng_restTime = self:GetChild("TreeDetail/" .. node .. "/LevelUpState/Time")
    self._buildings[k].lvUpIng_txt = self:GetChild("TreeDetail/" .. node .. "/LevelUpState/Txt")
    self._buildings[k].lvUp = self:GetChild("TreeDetail/" .. node .. "/LevelUpBtn")
    self._buildings[k].lvUp_txt = self:GetChild("TreeDetail/" .. node .. "/LevelUpBtn/Txt")
    self._buildings[k].finish = self:GetChild("TreeDetail/" .. node .. "/FinishState")
    self._buildings[k].select = self:GetChild("TreeDetail/" .. node .. "/Select")
    self._buildings[k].node:Subscribe_PointerClickEvent(function()
      self:OnBuildingNodeClicked(k)
    end)
  end
  self._normalDetailPanel = self:GetChild("DetailPanel/NormalState")
  self._normalDetail_image = self:GetChild("DetailPanel/NormalState/Image")
  self._normalDetail_name = self:GetChild("DetailPanel/NormalState/Title")
  self._normalDetail_noDispatchPanel = self:GetChild("DetailPanel/NormalState/LevelBack")
  self._normalDetail_noDispatchPanel_lvTxt = self:GetChild("DetailPanel/NormalState/LevelBack/LVNum")
  self._normalDetail_dispatchPanel = self:GetChild("DetailPanel/NormalState/CharNum")
  self._normalDetail_dispatchPanel_lvTxt = self:GetChild("DetailPanel/NormalState/CharNum/LVNum")
  self._normalDetail_dispatchPanel_num = self:GetChild("DetailPanel/NormalState/CharNum/Txt")
  self._normalDetail_buildingDes = self:GetChild("DetailPanel/NormalState/Txt")
  self._normalDetail_buildingPlot = self:GetChild("DetailPanel/NormalState/Txt2")
  self._normalDetail_dispatchBtnPanel = self:GetChild("DetailPanel/NormalState/BtnArea1")
  self._normalDetail_noDispatchBtnPanel = self:GetChild("DetailPanel/NormalState/BtnArea2")
  self._normalDetail_dispatchBtns = {}
  self._normalDetail_dispatchBtns.lvUpBtn = self:GetChild("DetailPanel/NormalState/BtnArea1/LevelBtn")
  self._normalDetail_dispatchBtns.lvUpIng = self:GetChild("DetailPanel/NormalState/BtnArea1/LevelUpState")
  self._normalDetail_dispatchBtns.finishBtn = self:GetChild("DetailPanel/NormalState/BtnArea1/FinishState")
  self._normalDetail_dispatchBtns.levelMax = self:GetChild("DetailPanel/NormalState/BtnArea1/LevelMaxBtn")
  self._normalDetail_noDispatchBtns = {}
  self._normalDetail_noDispatchBtns.lvUpBtn = self:GetChild("DetailPanel/NormalState/BtnArea2/LevelBtn")
  self._normalDetail_noDispatchBtns.lvUpIng = self:GetChild("DetailPanel/NormalState/BtnArea2/LevelUpState")
  self._normalDetail_noDispatchBtns.finishBtn = self:GetChild("DetailPanel/NormalState/BtnArea2/FinishState")
  self._normalDetail_noDispatchBtns.levelMax = self:GetChild("DetailPanel/NormalState/BtnArea2/LevelMaxBtn")
  self._normalDetail_dispatchBtns.lvUpBtn:Subscribe_PointerClickEvent(self.OnLvUpBtnClicked, self)
  self._normalDetail_noDispatchBtns.lvUpBtn:Subscribe_PointerClickEvent(self.OnLvUpBtnClicked, self)
  self._normalDetail_dispatchBtns.finishBtn:Subscribe_PointerClickEvent(self.OnFinishBtnClicked, self)
  self._normalDetail_noDispatchBtns.finishBtn:Subscribe_PointerClickEvent(self.OnFinishBtnClicked, self)
  self._lockDetailPanel = self:GetChild("DetailPanel/LockState")
  self._lockDetail_image = self:GetChild("DetailPanel/LockState/Image")
  self._lockDetail_name = self:GetChild("DetailPanel/LockState/Title")
  self._lockDetail_buildingDes = self:GetChild("DetailPanel/LockState/Txt")
  self._lockDetail_unlockBtn = self:GetChild("DetailPanel/LockState/OpenBtn")
  self._lockDetail_unlockBtn:Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false)
  self._width, self._height = self._currencyPanel:GetRectSize()
  self._anchoredx, self._anchoredy = self._currencyPanel:GetAnchoredPosition()
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:LoadLocalData()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMagicTree, Common.n_RefreshMagicTree, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMagicTreeTask, Common.n_RefreshMagicTreeTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMagicTree, Common.n_RefreshCourtYard, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_CollectorCapacityLvUp, nil)
end

function MagicTreeDialog:OnDestroy()
  if self._magicTreeEffectHandler then
    self._magicTreeEffect:ReleaseEffect(self._magicTreeEffectHandler)
    self._magicTreeEffectHandler = nil
  end
  NekoData.BehaviorManager.BM_MagicTree:RefreshPlot()
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  self._currencyFrame:Destroy()
  if self._courtyardSceneController then
    self._courtyardSceneController:SetCameraAnimatorState(0)
  end
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("magictree.magictreelvupeffectdialog")
end

function MagicTreeDialog:Init(sceneController)
  self._courtyardSceneController = sceneController
  self:RefreshCurrency()
end

function MagicTreeDialog:OnRefreshMagicTree()
  self._tasksInfo = NekoData.BehaviorManager.BM_MagicTree:GetTasksInfoMap()
  for k, v in pairs(self._buildings) do
    self:RefreshLeftCellById(k)
  end
  self:RefreshRightDetailPanel()
end

function MagicTreeDialog:OnRefreshMagicTreeTask(notification)
  local buildingId = notification.userInfo.task.buildId
  self._tasksInfo[buildingId] = NekoData.BehaviorManager.BM_MagicTree:GetTaskInfoByBuildingId(buildingId)
  if buildingId == self._selectBuildingId then
    self:RefreshRightDetailPanel()
  end
  if buildingId == DataCommon.MagicTree then
    for k, v in pairs(self._buildings) do
      self:RefreshLeftCellById(k)
    end
  else
    self:RefreshLeftCellById(buildingId)
  end
end

function MagicTreeDialog:RefreshLvUpIngTimeById(buildingId)
  local taskInfo = self._tasksInfo[buildingId]
  if taskInfo.taskState == TaskStateEnum.PROCESSING then
    local leftTime = taskInfo.leftTime
    local str = ""
    if leftTime // 1000 > 0 then
      str = TextManager.GetText(CStringres:GetRecorder(1109).msgTextID)
      str = string.gsub(str, "%$parameter1%$", os.date("!%H", leftTime // 1000))
      str = string.gsub(str, "%$parameter2%$", os.date("!%M", leftTime // 1000))
      str = string.gsub(str, "%$parameter3%$", os.date("!%S", leftTime // 1000))
    else
      str = TextManager.GetText(CStringres:GetRecorder(1109).msgTextID)
      str = string.gsub(str, "%$parameter1%$", "00")
      str = string.gsub(str, "%$parameter2%$", "00")
      str = string.gsub(str, "%$parameter3%$", "00")
    end
    self._buildings[buildingId].lvUpIng_restTime:SetText(str)
  end
end

function MagicTreeDialog:RefreshLeftCellById(buildingId)
  local bm_building = BM_Buildings[buildingId]
  local taskInfo = self._tasksInfo[buildingId]
  local courtYardRecord = CCourtyardNameCfg:GetRecorder(buildingId)
  local buildingNode = self._buildings[buildingId]
  local imgRecord
  local unlock = false
  if buildingId == DataCommon.MagicTree then
    unlock = true
    if self._magicTreeEffectHandler then
      self._magicTreeEffect:ReleaseEffect(self._magicTreeEffectHandler)
      self._magicTreeEffectHandler = nil
    end
    self._magicTreeEffectHandler = self._magicTreeEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(CTreeLvUp:GetRecorder(bm_building:GetLevel()).treeconstanteffect))
    buildingNode.unlock:SetActive(true)
    self._magicTreeName:SetText(TextManager.GetText(courtYardRecord.nameTextID))
  else
    unlock = bm_building:GetLevel() ~= 0
    if unlock then
      buildingNode.unlock:SetActive(true)
      buildingNode.icon:SetActive(true)
      buildingNode.lock:SetActive(false)
      imgRecord = CImagePathTable:GetRecorder(courtYardRecord.yardconstructionicon) or DataCommon.DefaultImageAsset
      buildingNode.icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      buildingNode.unlock:SetActive(false)
      buildingNode.icon:SetActive(false)
      buildingNode.lock:SetActive(true)
      local taskRecord = CCourtyardLvUpCfg:GetRecorder(taskInfo.taskId)
      buildingNode.lock_redDot:SetActive(NekoData.BehaviorManager.BM_MagicTree:GetLevel() >= taskRecord.openCondition)
      buildingNode.lock_name:SetText(TextManager.GetText(courtYardRecord.nameTextID))
      imgRecord = CImagePathTable:GetRecorder(courtYardRecord.yardconstructioniconlocked) or DataCommon.DefaultImageAsset
      buildingNode.lock_image:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    end
  end
  if unlock then
    buildingNode.lvTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1338, {
      bm_building:GetLevel()
    }))
    if taskInfo.taskId == 0 then
      buildingNode.lvMax:SetActive(true)
      buildingNode.lvMax:SetText(NekoData.BehaviorManager.BM_Message:GetString(1339))
      buildingNode.lvUp:SetActive(false)
      buildingNode.lvUpIng:SetActive(false)
      buildingNode.finish:SetActive(false)
    else
      buildingNode.lvMax:SetActive(false)
      local taskRecord = CCourtyardLvUpCfg:GetRecorder(taskInfo.taskId)
      local itemsEnough = true
      for i, v in ipairs(taskRecord.items) do
        local haveNum = 0
        if string.sub(v, 1, 2) == "35" then
          haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(v)
        else
          haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
        end
        if itemsEnough and haveNum < taskRecord.nums[i] then
          itemsEnough = false
          break
        end
      end
      if taskInfo.taskState == TaskStateEnum.PROCESSING then
        buildingNode.unlock:SetActive(buildingId == DataCommon.MagicTree)
        buildingNode.lvUp:SetActive(false)
        buildingNode.lvUpIng:SetActive(true)
        buildingNode.finish:SetActive(false)
        buildingNode.lvUpIng_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1337))
        self:RefreshLvUpIngTimeById(buildingId)
      elseif taskInfo.taskState == TaskStateEnum.UnReceive then
        buildingNode.lvUp:SetActive(false)
        buildingNode.lvUpIng:SetActive(false)
        buildingNode.finish:SetActive(true)
      elseif taskInfo.taskState == TaskStateEnum.LOCK or not itemsEnough then
        buildingNode.lvUp:SetActive(false)
        buildingNode.lvUpIng:SetActive(false)
        buildingNode.finish:SetActive(false)
      else
        buildingNode.lvUp:SetActive(true)
        buildingNode.lvUpIng:SetActive(false)
        buildingNode.finish:SetActive(false)
        buildingNode.lvUp_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1336))
      end
    end
  else
    buildingNode.lvUp:SetActive(false)
    buildingNode.lvUpIng:SetActive(false)
    buildingNode.finish:SetActive(false)
  end
end

function MagicTreeDialog:LoadLocalData()
  self._tasksInfo = NekoData.BehaviorManager.BM_MagicTree:GetTasksInfoMap()
  for k, v in pairs(self._buildings) do
    self:RefreshLeftCellById(k)
  end
  self:OnBuildingNodeClicked(DataCommon.MagicTree)
  if not self._task then
    self._task = GameTimer.AddTask(1, 1, function()
      for k, v in pairs(self._buildings) do
        self:RefreshLvUpIngTimeById(k)
      end
    end, nil)
  end
end

function MagicTreeDialog:GetCurrencyIndexById(id)
  for i, v in ipairs(self._currencies) do
    if v.currecyId == id then
      return i
    end
  end
end

function MagicTreeDialog:OnRefreshCurrency(notification)
  local fireMap = {}
  local insertList = {}
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local index = self:GetCurrencyIndexById(i)
    if index then
      fireMap[i] = true
    elseif NekoData.BehaviorManager.BM_Firefly:GetLightMaxCapacity(i) > 0 then
      table.insert(insertList, i - DataCommon.WhiteLight + 1)
    end
  end
  while self._currencies[#self._currencies] do
    table.remove(self._currencies, #self._currencies)
  end
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local maxCapacity = NekoData.BehaviorManager.BM_Firefly:GetLightMaxCapacity(i)
    if 0 < maxCapacity then
      table.insert(self._currencies, {
        currecyId = i,
        num = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(i),
        maxCapacity = maxCapacity,
        canJump = true
      })
    end
  end
  self._currencyFrame:FireEvent("PlayUpEffect", fireMap)
  if 0 < #insertList then
    local cellPanelWidth = self._width / 3 * #self._currencies
    self._currencyPanel:SetSize(0, cellPanelWidth, 0, self._height)
    self._currencyPanel:SetAnchoredPosition(self._anchoredx, self._anchoredy)
  end
  for i, v in ipairs(insertList) do
    self._currencyFrame:InsertCellsAtIndex({v})
  end
  for k, v in pairs(self._buildings) do
    self:RefreshLeftCellById(k)
  end
end

function MagicTreeDialog:RefreshCurrency()
  while self._currencies[#self._currencies] do
    table.remove(self._currencies, #self._currencies)
  end
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local maxCapacity = NekoData.BehaviorManager.BM_Firefly:GetLightMaxCapacity(i)
    if 0 < maxCapacity then
      table.insert(self._currencies, {
        currecyId = i,
        num = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(i),
        maxCapacity = maxCapacity,
        canJump = true
      })
    end
  end
  local cellPanelWidth = self._width / 3 * #self._currencies
  self._currencyPanel:SetSize(0, cellPanelWidth, 0, self._height)
  self._currencyPanel:SetAnchoredPosition(self._anchoredx, self._anchoredy)
  self._currencyFrame:ReloadAllCell()
end

function MagicTreeDialog:RefreshRightDetailPanel()
  local bm_building = BM_Buildings[self._selectBuildingId]
  local taskInfo = self._tasksInfo[self._selectBuildingId]
  local courtYardRecord = CCourtyardNameCfg:GetRecorder(self._selectBuildingId)
  local buidingDetailRecord = CMagictreePanelStringCfg:GetRecorder(self._selectBuildingId)
  local imgRecord = CImagePathTable:GetRecorder(buidingDetailRecord.illustration) or DataCommon.DefaultImageAsset
  if bm_building:GetLevel() ~= 0 then
    self._lockDetailPanel:SetActive(false)
    self._normalDetailPanel:SetActive(true)
    self._normalDetail_image:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    self._normalDetail_name:SetText(TextManager.GetText(courtYardRecord.nameTextID))
    local dispatchBtns
    if buidingDetailRecord.stayingnumber ~= -1 then
      dispatchBtns = self._normalDetail_dispatchBtns
      self._normalDetail_dispatchBtnPanel:SetActive(true)
      self._normalDetail_noDispatchBtnPanel:SetActive(false)
      self._normalDetail_noDispatchPanel:SetActive(false)
      self._normalDetail_dispatchPanel:SetActive(true)
      self._normalDetail_dispatchPanel_lvTxt:SetText(bm_building:GetLevel())
      self._normalDetail_dispatchPanel_num:SetText(NekoData.BehaviorManager.BM_Message:GetString(buidingDetailRecord.stayingnumber, {
        #bm_building:GetDispatchRoles(true),
        bm_building:GetDispatchMaxRoleNum()
      }))
    else
      dispatchBtns = self._normalDetail_noDispatchBtns
      self._normalDetail_dispatchBtnPanel:SetActive(false)
      self._normalDetail_noDispatchBtnPanel:SetActive(true)
      self._normalDetail_noDispatchPanel:SetActive(true)
      self._normalDetail_noDispatchPanel_lvTxt:SetText(bm_building:GetLevel())
      self._normalDetail_dispatchPanel:SetActive(false)
    end
    self._normalDetail_buildingDes:SetText(TextManager.GetText(buidingDetailRecord.stayingfunction))
    self._normalDetail_buildingPlot:SetText(TextManager.GetText(NekoData.BehaviorManager.BM_MagicTree:GetPlotIdByBuildingId(self._selectBuildingId)))
    if taskInfo.taskId == 0 then
      dispatchBtns.lvUpBtn:SetActive(false)
      dispatchBtns.lvUpIng:SetActive(false)
      dispatchBtns.finishBtn:SetActive(false)
      dispatchBtns.levelMax:SetActive(true)
    else
      dispatchBtns.levelMax:SetActive(false)
      if taskInfo.taskState == TaskStateEnum.PROCESSING then
        dispatchBtns.lvUpBtn:SetActive(false)
        dispatchBtns.lvUpIng:SetActive(true)
        dispatchBtns.finishBtn:SetActive(false)
      elseif taskInfo.taskState == TaskStateEnum.UnReceive then
        dispatchBtns.lvUpBtn:SetActive(false)
        dispatchBtns.lvUpIng:SetActive(false)
        dispatchBtns.finishBtn:SetActive(true)
      else
        dispatchBtns.lvUpBtn:SetActive(true)
        dispatchBtns.lvUpIng:SetActive(false)
        dispatchBtns.finishBtn:SetActive(false)
      end
    end
  else
    self._lockDetailPanel:SetActive(true)
    self._normalDetailPanel:SetActive(false)
    self._lockDetail_image:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    self._lockDetail_name:SetText(TextManager.GetText(courtYardRecord.nameTextID))
    if buidingDetailRecord.stayingfunction ~= -1 then
      self._lockDetail_buildingDes:SetActive(true)
      self._lockDetail_buildingDes:SetText(TextManager.GetText(buidingDetailRecord.stayingfunction))
    else
      self._lockDetail_buildingDes:SetActive(false)
    end
  end
  for k, v in pairs(self._buildings) do
    v.select:SetActive(k == self._selectBuildingId)
  end
end

function MagicTreeDialog:OnBuildingNodeClicked(buildingId)
  if self._selectBuildingId ~= buildingId then
    self._selectBuildingId = buildingId
    self:RefreshRightDetailPanel()
  end
end

function MagicTreeDialog:OnLvUpBtnClicked()
  local taskInfo = self._tasksInfo[self._selectBuildingId]
  local taskRecord = CCourtyardLvUpCfg:GetRecorder(taskInfo.taskId)
  if NekoData.BehaviorManager.BM_MagicTree:GetWorkingTaskNum() < NekoData.BehaviorManager.BM_MagicTree:GetMaxTaskNum() then
    if NekoData.BehaviorManager.BM_MagicTree:GetLevel() >= taskRecord.openCondition then
      DialogManager.CreateSingletonDialog("magictree.buildinglevelupdialog"):Init(taskInfo.taskId)
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100264, {
        taskRecord.openCondition
      })
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100088)
  end
end

function MagicTreeDialog:OnFinishBtnClicked()
  if self._selectBuildingId == DataCommon.MagicTree and BM_Buildings[DataCommon.MagicTree]:GetLevel() < BM_Buildings[DataCommon.MagicTree]:GetMaxLevel() then
    if not self._magicTreeLvUpClick then
      self._magicTreeLvUpClick = true
      DialogManager.CreateSingletonDialog("magictree.magictreelvupeffectdialog")
    end
  else
    local ccompleteTask = LuaNetManager.CreateProtocol("protocol.yard.ccompletetask")
    ccompleteTask.id = self._selectBuildingId
    ccompleteTask:Send()
  end
end

function MagicTreeDialog:OnUnlockBtnClicked()
  local taskInfo = self._tasksInfo[self._selectBuildingId]
  local taskRecord = CCourtyardLvUpCfg:GetRecorder(taskInfo.taskId)
  if NekoData.BehaviorManager.BM_MagicTree:GetWorkingTaskNum() < NekoData.BehaviorManager.BM_MagicTree:GetMaxTaskNum() then
    if NekoData.BehaviorManager.BM_MagicTree:GetLevel() >= taskRecord.openCondition then
      local cstartTreeTask = LuaNetManager.CreateProtocol("protocol.yard.cstarttreetask")
      cstartTreeTask.buildId = self._selectBuildingId
      cstartTreeTask:Send()
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100092, {
        taskRecord.openCondition
      })
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100088)
  end
end

function MagicTreeDialog:NumberOfCell(frame)
  if frame == self._currencyFrame then
    return #self._currencies
  end
end

function MagicTreeDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "courtyard.currencycell"
  end
end

function MagicTreeDialog:DataAtIndex(frame, index)
  if frame == self._currencyFrame then
    return self._currencies[index]
  end
end

function MagicTreeDialog:OnIBtnClicked()
  DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(DataCommon.LocalTips.GuideOpenInstructionDialog_Magictree.guideId)
end

function MagicTreeDialog:OnBackBtnClicked()
  self:Destroy()
end

function MagicTreeDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return MagicTreeDialog
