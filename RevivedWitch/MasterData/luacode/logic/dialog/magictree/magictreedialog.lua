-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/magictreedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CMagictreePanelStringCfg = (BeanManager.GetTableByName)("courtyard.cmagictreepanelstring")
local CTreeLvUp = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local BM_Buildings = {}
BM_Buildings[DataCommon.MagicTree] = (NekoData.BehaviorManager).BM_MagicTree
BM_Buildings[DataCommon.Explore] = (NekoData.BehaviorManager).BM_Explore
BM_Buildings[DataCommon.Firefly] = (NekoData.BehaviorManager).BM_Firefly
BM_Buildings[DataCommon.Alchemy] = (NekoData.BehaviorManager).BM_Alchemy
BM_Buildings[DataCommon.Cabin] = (NekoData.BehaviorManager).BM_Cabin
BM_Buildings[DataCommon.TrainCamp] = (NekoData.BehaviorManager).BM_TrainCamp
BM_Buildings[DataCommon.YardMusic] = (NekoData.BehaviorManager).BM_YardMusic
local MagicTreeDialog = class("MagicTreeDialog", Dialog)
MagicTreeDialog.AssetBundleName = "ui/layouts.yard"
MagicTreeDialog.AssetName = "MagicTreeNew"
MagicTreeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MagicTreeDialog
  ((MagicTreeDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._courtyardSceneController = nil
  self._currencies = {}
  self._task = nil
  self._selectBuildingId = nil
  self._magicTreeEffectHandler = nil
  self._magicTreeLvUpClick = false
end

MagicTreeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, BM_Buildings, TableFrame
  self._iBtn = self:GetChild("Ibtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._currencyPanel = self:GetChild("TopGroup")
  self._magicTreeEffect = self:GetChild("TreeDetail/Tree/Effect")
  self._magicTreeName = self:GetChild("TreeDetail/Tree/Detail/Title")
  self._buildings = {}
  for k,v in pairs(BM_Buildings) do
    do
      local node = ""
      if k == DataCommon.MagicTree then
        node = "Tree"
      else
        if k == DataCommon.Explore then
          node = "Cell2"
        else
          if k == DataCommon.Firefly then
            node = "Cell3"
          else
            if k == DataCommon.Alchemy then
              node = "Cell4"
            else
              if k == DataCommon.Cabin then
                node = "Cell1"
              else
                if k == DataCommon.TrainCamp then
                  node = "Cell5"
                else
                  if k == DataCommon.YardMusic then
                    node = "Cell6"
                  end
                end
              end
            end
          end
        end
      end
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._buildings)[k] = {}
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).node = self:GetChild("TreeDetail/" .. node)
      -- DECOMPILER ERROR at PC91: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).unlock = self:GetChild("TreeDetail/" .. node .. "/Detail")
      -- DECOMPILER ERROR at PC100: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).lvTxt = self:GetChild("TreeDetail/" .. node .. "/Detail/LV")
      -- DECOMPILER ERROR at PC109: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).lvMax = self:GetChild("TreeDetail/" .. node .. "/Detail/LVNum")
      -- DECOMPILER ERROR at PC122: Confused about usage of register: R7 in 'UnsetPending'

      if k ~= DataCommon.MagicTree then
        ((self._buildings)[k]).icon = self:GetChild("TreeDetail/" .. node .. "/Image")
        -- DECOMPILER ERROR at PC131: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self._buildings)[k]).lock = self:GetChild("TreeDetail/" .. node .. "/LockState")
        -- DECOMPILER ERROR at PC140: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self._buildings)[k]).lock_name = self:GetChild("TreeDetail/" .. node .. "/LockState/Title")
        -- DECOMPILER ERROR at PC149: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self._buildings)[k]).lock_image = self:GetChild("TreeDetail/" .. node .. "/LockState/Black")
        -- DECOMPILER ERROR at PC158: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self._buildings)[k]).lock_redDot = self:GetChild("TreeDetail/" .. node .. "/LockState/RedDot")
      end
      -- DECOMPILER ERROR at PC167: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).lvUpIng = self:GetChild("TreeDetail/" .. node .. "/LevelUpState")
      -- DECOMPILER ERROR at PC176: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).lvUpIng_restTime = self:GetChild("TreeDetail/" .. node .. "/LevelUpState/Time")
      -- DECOMPILER ERROR at PC185: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).lvUpIng_txt = self:GetChild("TreeDetail/" .. node .. "/LevelUpState/Txt")
      -- DECOMPILER ERROR at PC194: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).lvUp = self:GetChild("TreeDetail/" .. node .. "/LevelUpBtn")
      -- DECOMPILER ERROR at PC203: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).lvUp_txt = self:GetChild("TreeDetail/" .. node .. "/LevelUpBtn/Txt")
      -- DECOMPILER ERROR at PC212: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).finish = self:GetChild("TreeDetail/" .. node .. "/FinishState")
      -- DECOMPILER ERROR at PC221: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._buildings)[k]).select = self:GetChild("TreeDetail/" .. node .. "/Select")
      ;
      (((self._buildings)[k]).node):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, k
    self:OnBuildingNodeClicked(k)
  end
)
    end
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
  -- DECOMPILER ERROR at PC285: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._normalDetail_dispatchBtns).lvUpBtn = self:GetChild("DetailPanel/NormalState/BtnArea1/LevelBtn")
  -- DECOMPILER ERROR at PC290: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._normalDetail_dispatchBtns).lvUpIng = self:GetChild("DetailPanel/NormalState/BtnArea1/LevelUpState")
  -- DECOMPILER ERROR at PC295: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._normalDetail_dispatchBtns).finishBtn = self:GetChild("DetailPanel/NormalState/BtnArea1/FinishState")
  -- DECOMPILER ERROR at PC300: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._normalDetail_dispatchBtns).levelMax = self:GetChild("DetailPanel/NormalState/BtnArea1/LevelMaxBtn")
  self._normalDetail_noDispatchBtns = {}
  -- DECOMPILER ERROR at PC307: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._normalDetail_noDispatchBtns).lvUpBtn = self:GetChild("DetailPanel/NormalState/BtnArea2/LevelBtn")
  -- DECOMPILER ERROR at PC312: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._normalDetail_noDispatchBtns).lvUpIng = self:GetChild("DetailPanel/NormalState/BtnArea2/LevelUpState")
  -- DECOMPILER ERROR at PC317: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._normalDetail_noDispatchBtns).finishBtn = self:GetChild("DetailPanel/NormalState/BtnArea2/FinishState")
  -- DECOMPILER ERROR at PC322: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._normalDetail_noDispatchBtns).levelMax = self:GetChild("DetailPanel/NormalState/BtnArea2/LevelMaxBtn")
  ;
  ((self._normalDetail_dispatchBtns).lvUpBtn):Subscribe_PointerClickEvent(self.OnLvUpBtnClicked, self)
  ;
  ((self._normalDetail_noDispatchBtns).lvUpBtn):Subscribe_PointerClickEvent(self.OnLvUpBtnClicked, self)
  ;
  ((self._normalDetail_dispatchBtns).finishBtn):Subscribe_PointerClickEvent(self.OnFinishBtnClicked, self)
  ;
  ((self._normalDetail_noDispatchBtns).finishBtn):Subscribe_PointerClickEvent(self.OnFinishBtnClicked, self)
  self._lockDetailPanel = self:GetChild("DetailPanel/LockState")
  self._lockDetail_image = self:GetChild("DetailPanel/LockState/Image")
  self._lockDetail_name = self:GetChild("DetailPanel/LockState/Title")
  self._lockDetail_buildingDes = self:GetChild("DetailPanel/LockState/Txt")
  self._lockDetail_unlockBtn = self:GetChild("DetailPanel/LockState/OpenBtn")
  ;
  (self._lockDetail_unlockBtn):Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false)
  self._width = (self._currencyPanel):GetRectSize()
  self._anchoredx = (self._currencyPanel):GetAnchoredPosition()
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:LoadLocalData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMagicTree, Common.n_RefreshMagicTree, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMagicTreeTask, Common.n_RefreshMagicTreeTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMagicTree, Common.n_RefreshCourtYard, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_CollectorCapacityLvUp, nil)
end

MagicTreeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._magicTreeEffectHandler then
    (self._magicTreeEffect):ReleaseEffect(self._magicTreeEffectHandler)
    self._magicTreeEffectHandler = nil
  end
  ;
  ((NekoData.BehaviorManager).BM_MagicTree):RefreshPlot()
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  (self._currencyFrame):Destroy()
  if self._courtyardSceneController then
    (self._courtyardSceneController):SetCameraAnimatorState(0)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("magictree.magictreelvupeffectdialog")
end

MagicTreeDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._courtyardSceneController = sceneController
  self:RefreshCurrency()
end

MagicTreeDialog.OnRefreshMagicTree = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._tasksInfo = ((NekoData.BehaviorManager).BM_MagicTree):GetTasksInfoMap()
  for k,v in pairs(self._buildings) do
    self:RefreshLeftCellById(k)
  end
  self:RefreshRightDetailPanel()
end

MagicTreeDialog.OnRefreshMagicTreeTask = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local buildingId = ((notification.userInfo).task).buildId
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._tasksInfo)[buildingId] = ((NekoData.BehaviorManager).BM_MagicTree):GetTaskInfoByBuildingId(buildingId)
  if buildingId == self._selectBuildingId then
    self:RefreshRightDetailPanel()
  end
  if buildingId == DataCommon.MagicTree then
    for k,v in pairs(self._buildings) do
      self:RefreshLeftCellById(k)
    end
  else
    do
      self:RefreshLeftCellById(buildingId)
    end
  end
end

MagicTreeDialog.RefreshLvUpIngTimeById = function(self, buildingId)
  -- function num : 0_6 , upvalues : TaskStateEnum, _ENV, CStringres
  local taskInfo = (self._tasksInfo)[buildingId]
  if taskInfo.taskState == TaskStateEnum.PROCESSING then
    local leftTime = taskInfo.leftTime
    local str = ""
    if leftTime // 1000 > 0 then
      str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", leftTime // 1000))
      str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", leftTime // 1000))
      str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", leftTime // 1000))
    else
      str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", "00")
      str = (string.gsub)(str, "%$parameter2%$", "00")
      str = (string.gsub)(str, "%$parameter3%$", "00")
    end
    ;
    (((self._buildings)[buildingId]).lvUpIng_restTime):SetText(str)
  end
end

MagicTreeDialog.RefreshLeftCellById = function(self, buildingId)
  -- function num : 0_7 , upvalues : BM_Buildings, CCourtyardNameCfg, _ENV, CTreeLvUp, CImagePathTable, CCourtyardLvUpCfg, TaskStateEnum
  local bm_building = BM_Buildings[buildingId]
  local taskInfo = (self._tasksInfo)[buildingId]
  local courtYardRecord = CCourtyardNameCfg:GetRecorder(buildingId)
  local buildingNode = (self._buildings)[buildingId]
  local imgRecord = nil
  local unlock = false
  if buildingId == DataCommon.MagicTree then
    unlock = true
    if self._magicTreeEffectHandler then
      (self._magicTreeEffect):ReleaseEffect(self._magicTreeEffectHandler)
      self._magicTreeEffectHandler = nil
    end
    self._magicTreeEffectHandler = (self._magicTreeEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)((CTreeLvUp:GetRecorder(bm_building:GetLevel())).treeconstanteffect))
    ;
    (buildingNode.unlock):SetActive(true)
    ;
    (self._magicTreeName):SetText((TextManager.GetText)(courtYardRecord.nameTextID))
  else
    unlock = bm_building:GetLevel() ~= 0
    if unlock then
      (buildingNode.unlock):SetActive(true)
      ;
      (buildingNode.icon):SetActive(true)
      ;
      (buildingNode.lock):SetActive(false)
      if not CImagePathTable:GetRecorder(courtYardRecord.yardconstructionicon) then
        imgRecord = DataCommon.DefaultImageAsset
      end
      ;
      (buildingNode.icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      (buildingNode.unlock):SetActive(false)
      ;
      (buildingNode.icon):SetActive(false)
      ;
      (buildingNode.lock):SetActive(true)
      local taskRecord = CCourtyardLvUpCfg:GetRecorder(taskInfo.taskId)
      ;
      (buildingNode.lock_redDot):SetActive(taskRecord.openCondition <= ((NekoData.BehaviorManager).BM_MagicTree):GetLevel())
      ;
      (buildingNode.lock_name):SetText((TextManager.GetText)(courtYardRecord.nameTextID))
      if not CImagePathTable:GetRecorder(courtYardRecord.yardconstructioniconlocked) then
        imgRecord = DataCommon.DefaultImageAsset
      end
      ;
      (buildingNode.lock_image):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    end
  end
  if unlock then
    (buildingNode.lvTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1338, {bm_building:GetLevel()}))
    if taskInfo.taskId == 0 then
      (buildingNode.lvMax):SetActive(true)
      ;
      (buildingNode.lvMax):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1339))
      ;
      (buildingNode.lvUp):SetActive(false)
      ;
      (buildingNode.lvUpIng):SetActive(false)
      ;
      (buildingNode.finish):SetActive(false)
    else
      (buildingNode.lvMax):SetActive(false)
      local taskRecord = CCourtyardLvUpCfg:GetRecorder(taskInfo.taskId)
      local itemsEnough = true
      for i,v in ipairs(taskRecord.items) do
        local haveNum = 0
        if (string.sub)(v, 1, 2) == "35" then
          haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(v)
        else
          haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v)
        end
        if itemsEnough and haveNum < (taskRecord.nums)[i] then
          itemsEnough = false
          break
        end
      end
      if buildingId ~= DataCommon.MagicTree then
        do
          (buildingNode.unlock):SetActive(taskInfo.taskState ~= TaskStateEnum.PROCESSING)
          ;
          (buildingNode.lvUp):SetActive(false)
          ;
          (buildingNode.lvUpIng):SetActive(true)
          ;
          (buildingNode.finish):SetActive(false)
          ;
          (buildingNode.lvUpIng_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1337))
          self:RefreshLvUpIngTimeById(buildingId)
          if taskInfo.taskState == TaskStateEnum.UnReceive then
            (buildingNode.lvUp):SetActive(false)
            ;
            (buildingNode.lvUpIng):SetActive(false)
            ;
            (buildingNode.finish):SetActive(true)
          elseif taskInfo.taskState == TaskStateEnum.LOCK or not itemsEnough then
            (buildingNode.lvUp):SetActive(false)
            ;
            (buildingNode.lvUpIng):SetActive(false)
            ;
            (buildingNode.finish):SetActive(false)
          else
            (buildingNode.lvUp):SetActive(true)
            ;
            (buildingNode.lvUpIng):SetActive(false)
            ;
            (buildingNode.finish):SetActive(false)
            ;
            (buildingNode.lvUp_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1336))
          end
          ;
          (buildingNode.lvUp):SetActive(false)
          ;
          (buildingNode.lvUpIng):SetActive(false)
          ;
          (buildingNode.finish):SetActive(false)
          -- DECOMPILER ERROR: 18 unprocessed JMP targets
        end
      end
    end
  end
end

MagicTreeDialog.LoadLocalData = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self._tasksInfo = ((NekoData.BehaviorManager).BM_MagicTree):GetTasksInfoMap()
  for k,v in pairs(self._buildings) do
    self:RefreshLeftCellById(k)
  end
  self:OnBuildingNodeClicked(DataCommon.MagicTree)
  if not self._task then
    self._task = (GameTimer.AddTask)(1, 1, function()
    -- function num : 0_8_0 , upvalues : _ENV, self
    for k,v in pairs(self._buildings) do
      self:RefreshLvUpIngTimeById(k)
    end
  end
, nil)
  end
end

MagicTreeDialog.GetCurrencyIndexById = function(self, id)
  -- function num : 0_9 , upvalues : _ENV
  for i,v in ipairs(self._currencies) do
    if v.currecyId == id then
      return i
    end
  end
end

MagicTreeDialog.OnRefreshCurrency = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV
  local fireMap = {}
  local insertList = {}
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local index = self:GetCurrencyIndexById(i)
    if index then
      fireMap[i] = true
    else
      if ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(i) > 0 then
        (table.insert)(insertList, i - DataCommon.WhiteLight + 1)
      end
    end
  end
  do
    while (self._currencies)[#self._currencies] do
      (table.remove)(self._currencies, #self._currencies)
    end
    for i = DataCommon.WhiteLight, DataCommon.ColorLight do
      local maxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(i)
      if maxCapacity > 0 then
        (table.insert)(self._currencies, {currecyId = i, num = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(i), maxCapacity = maxCapacity, canJump = true})
      end
    end
    ;
    (self._currencyFrame):FireEvent("PlayUpEffect", fireMap)
    do
      if #insertList > 0 then
        local cellPanelWidth = self._width / 3 * #self._currencies
        ;
        (self._currencyPanel):SetSize(0, cellPanelWidth, 0, self._height)
        ;
        (self._currencyPanel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
      end
      for i,v in ipairs(insertList) do
        (self._currencyFrame):InsertCellsAtIndex({v})
      end
      for k,v in pairs(self._buildings) do
        self:RefreshLeftCellById(k)
      end
    end
  end
end

MagicTreeDialog.RefreshCurrency = function(self)
  -- function num : 0_11 , upvalues : _ENV
  while (self._currencies)[#self._currencies] do
    (table.remove)(self._currencies, #self._currencies)
  end
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local maxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(i)
    if maxCapacity > 0 then
      (table.insert)(self._currencies, {currecyId = i, num = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(i), maxCapacity = maxCapacity, canJump = true})
    end
  end
  local cellPanelWidth = self._width / 3 * #self._currencies
  ;
  (self._currencyPanel):SetSize(0, cellPanelWidth, 0, self._height)
  ;
  (self._currencyPanel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
  ;
  (self._currencyFrame):ReloadAllCell()
end

MagicTreeDialog.RefreshRightDetailPanel = function(self)
  -- function num : 0_12 , upvalues : BM_Buildings, CCourtyardNameCfg, CMagictreePanelStringCfg, CImagePathTable, _ENV, TaskStateEnum
  local bm_building = BM_Buildings[self._selectBuildingId]
  local taskInfo = (self._tasksInfo)[self._selectBuildingId]
  local courtYardRecord = CCourtyardNameCfg:GetRecorder(self._selectBuildingId)
  local buidingDetailRecord = CMagictreePanelStringCfg:GetRecorder(self._selectBuildingId)
  if not CImagePathTable:GetRecorder(buidingDetailRecord.illustration) then
    local imgRecord = DataCommon.DefaultImageAsset
  end
  if bm_building:GetLevel() ~= 0 then
    (self._lockDetailPanel):SetActive(false)
    ;
    (self._normalDetailPanel):SetActive(true)
    ;
    (self._normalDetail_image):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    ;
    (self._normalDetail_name):SetText((TextManager.GetText)(courtYardRecord.nameTextID))
    local dispatchBtns = nil
    if buidingDetailRecord.stayingnumber ~= -1 then
      dispatchBtns = self._normalDetail_dispatchBtns
      ;
      (self._normalDetail_dispatchBtnPanel):SetActive(true)
      ;
      (self._normalDetail_noDispatchBtnPanel):SetActive(false)
      ;
      (self._normalDetail_noDispatchPanel):SetActive(false)
      ;
      (self._normalDetail_dispatchPanel):SetActive(true)
      ;
      (self._normalDetail_dispatchPanel_lvTxt):SetText(bm_building:GetLevel())
      ;
      (self._normalDetail_dispatchPanel_num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(buidingDetailRecord.stayingnumber, {#bm_building:GetDispatchRoles(true), bm_building:GetDispatchMaxRoleNum()}))
    else
      dispatchBtns = self._normalDetail_noDispatchBtns
      ;
      (self._normalDetail_dispatchBtnPanel):SetActive(false)
      ;
      (self._normalDetail_noDispatchBtnPanel):SetActive(true)
      ;
      (self._normalDetail_noDispatchPanel):SetActive(true)
      ;
      (self._normalDetail_noDispatchPanel_lvTxt):SetText(bm_building:GetLevel())
      ;
      (self._normalDetail_dispatchPanel):SetActive(false)
    end
    ;
    (self._normalDetail_buildingDes):SetText((TextManager.GetText)(buidingDetailRecord.stayingfunction))
    ;
    (self._normalDetail_buildingPlot):SetText((TextManager.GetText)(((NekoData.BehaviorManager).BM_MagicTree):GetPlotIdByBuildingId(self._selectBuildingId)))
    if taskInfo.taskId == 0 then
      (dispatchBtns.lvUpBtn):SetActive(false)
      ;
      (dispatchBtns.lvUpIng):SetActive(false)
      ;
      (dispatchBtns.finishBtn):SetActive(false)
      ;
      (dispatchBtns.levelMax):SetActive(true)
    else
      ;
      (dispatchBtns.levelMax):SetActive(false)
      if taskInfo.taskState == TaskStateEnum.PROCESSING then
        (dispatchBtns.lvUpBtn):SetActive(false)
        ;
        (dispatchBtns.lvUpIng):SetActive(true)
        ;
        (dispatchBtns.finishBtn):SetActive(false)
      else
        if taskInfo.taskState == TaskStateEnum.UnReceive then
          (dispatchBtns.lvUpBtn):SetActive(false)
          ;
          (dispatchBtns.lvUpIng):SetActive(false)
          ;
          (dispatchBtns.finishBtn):SetActive(true)
        else
          ;
          (dispatchBtns.lvUpBtn):SetActive(true)
          ;
          (dispatchBtns.lvUpIng):SetActive(false)
          ;
          (dispatchBtns.finishBtn):SetActive(false)
        end
      end
    end
  else
    do
      ;
      (self._lockDetailPanel):SetActive(true)
      ;
      (self._normalDetailPanel):SetActive(false)
      ;
      (self._lockDetail_image):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      ;
      (self._lockDetail_name):SetText((TextManager.GetText)(courtYardRecord.nameTextID))
      if buidingDetailRecord.stayingfunction ~= -1 then
        (self._lockDetail_buildingDes):SetActive(true)
        ;
        (self._lockDetail_buildingDes):SetText((TextManager.GetText)(buidingDetailRecord.stayingfunction))
      else
        ;
        (self._lockDetail_buildingDes):SetActive(false)
      end
      for k,v in pairs(self._buildings) do
        (v.select):SetActive(k == self._selectBuildingId)
      end
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

MagicTreeDialog.OnBuildingNodeClicked = function(self, buildingId)
  -- function num : 0_13
  if self._selectBuildingId ~= buildingId then
    self._selectBuildingId = buildingId
    self:RefreshRightDetailPanel()
  end
end

MagicTreeDialog.OnLvUpBtnClicked = function(self)
  -- function num : 0_14 , upvalues : CCourtyardLvUpCfg, _ENV
  local taskInfo = (self._tasksInfo)[self._selectBuildingId]
  local taskRecord = CCourtyardLvUpCfg:GetRecorder(taskInfo.taskId)
  if ((NekoData.BehaviorManager).BM_MagicTree):GetWorkingTaskNum() < ((NekoData.BehaviorManager).BM_MagicTree):GetMaxTaskNum() then
    if taskRecord.openCondition <= ((NekoData.BehaviorManager).BM_MagicTree):GetLevel() then
      ((DialogManager.CreateSingletonDialog)("magictree.buildinglevelupdialog")):Init(taskInfo.taskId)
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100264, {taskRecord.openCondition})
    end
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100088)
  end
end

MagicTreeDialog.OnFinishBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV, BM_Buildings
  if self._selectBuildingId == DataCommon.MagicTree and (BM_Buildings[DataCommon.MagicTree]):GetLevel() < (BM_Buildings[DataCommon.MagicTree]):GetMaxLevel() and not self._magicTreeLvUpClick then
    self._magicTreeLvUpClick = true
    ;
    (DialogManager.CreateSingletonDialog)("magictree.magictreelvupeffectdialog")
  end
  local ccompleteTask = (LuaNetManager.CreateProtocol)("protocol.yard.ccompletetask")
  ccompleteTask.id = self._selectBuildingId
  ccompleteTask:Send()
end

MagicTreeDialog.OnUnlockBtnClicked = function(self)
  -- function num : 0_16 , upvalues : CCourtyardLvUpCfg, _ENV
  local taskInfo = (self._tasksInfo)[self._selectBuildingId]
  local taskRecord = CCourtyardLvUpCfg:GetRecorder(taskInfo.taskId)
  if ((NekoData.BehaviorManager).BM_MagicTree):GetWorkingTaskNum() < ((NekoData.BehaviorManager).BM_MagicTree):GetMaxTaskNum() then
    if taskRecord.openCondition <= ((NekoData.BehaviorManager).BM_MagicTree):GetLevel() then
      local cstartTreeTask = (LuaNetManager.CreateProtocol)("protocol.yard.cstarttreetask")
      cstartTreeTask.buildId = self._selectBuildingId
      cstartTreeTask:Send()
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100092, {taskRecord.openCondition})
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100088)
      end
    end
  end
end

MagicTreeDialog.NumberOfCell = function(self, frame)
  -- function num : 0_17
  if frame == self._currencyFrame then
    return #self._currencies
  end
end

MagicTreeDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_18
  if frame == self._currencyFrame then
    return "courtyard.currencycell"
  end
end

MagicTreeDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_19
  if frame == self._currencyFrame then
    return (self._currencies)[index]
  end
end

MagicTreeDialog.OnIBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(((DataCommon.LocalTips).GuideOpenInstructionDialog_Magictree).guideId)
end

MagicTreeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_21
  self:Destroy()
end

MagicTreeDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_22 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return MagicTreeDialog

