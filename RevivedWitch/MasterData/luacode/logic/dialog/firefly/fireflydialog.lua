-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/firefly/fireflydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFireflylvupCfg = (BeanManager.GetTableByName)("courtyard.cfireflylvup")
local CTreeLvUpCfg = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local CLightImageCfg = (BeanManager.GetTableByName)("courtyard.clightimage")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CCollectorlvupCfg = (BeanManager.GetTableByName)("courtyard.ccollectorlvup")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local FreeState = 10
local FireflyDialog = class("FireflyDialog", Dialog)
FireflyDialog.AssetBundleName = "ui/layouts.yard"
FireflyDialog.AssetName = "YardLight"
FireflyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FireflyDialog, _ENV
  ((FireflyDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._courtyardSceneController = nil
  self._currencies = {}
  self._task = nil
  self._sendChangFireflyNumProtocol = false
  self._lightPanel = {}
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._lightPanel)[DataCommon.WhiteLight] = {fireflyWorkDotEffectHandler = nil, fireflyWorkLightDotEffectHandler = nil, work = 0}
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._lightPanel)[DataCommon.DarkLight] = {fireflyWorkDotEffectHandler = nil, fireflyWorkLightDotEffectHandler = nil, work = 0}
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._lightPanel)[DataCommon.ColorLight] = {fireflyWorkDotEffectHandler = nil, fireflyWorkLightDotEffectHandler = nil, work = 0}
  self._flowerEffectHandlers = {}
  self._flowerStopEffectHandlers = {}
end

FireflyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, Item, TableFrame
  self._currencyPanel = self:GetChild("TopGroup")
  self._flowerEffect = self:GetChild("LeftPanel/Back/Effect")
  ;
  (self._flowerEffect):Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  self._loadingPanel = self:GetChild("LeftPanel/Loading")
  self._progress = self:GetChild("LeftPanel/Loading/BackGround/Progress")
  self._time = self:GetChild("LeftPanel/Loading/Time")
  self._txt = self:GetChild("LeftPanel/Text")
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    do
      local str1 = "LeftPanel/"
      local str2 = "RightPanel/"
      if i == DataCommon.WhiteLight then
        str1 = str1 .. "Cell1"
        str2 = str2 .. "Bai"
      else
        if i == DataCommon.DarkLight then
          str1 = str1 .. "Cell2"
          str2 = str2 .. "An"
        else
          str1 = str1 .. "Cell3"
          str2 = str2 .. "Cai"
        end
      end
      local map = (self._lightPanel)[i]
      map.item = (Item.Create)(i)
      map.leftCell = self:GetChild(str1)
      map.leftCell_itemIcon = self:GetChild(str1 .. "/Item")
      map.leftCell_restPanel = self:GetChild(str1 .. "/Rest")
      map.leftCell_restPanel_txt = self:GetChild(str1 .. "/Rest/TxtBack/Text")
      map.leftCell_workPanel = self:GetChild(str1 .. "/Work")
      map.leftCell_workPanel_firefly = self:GetChild(str1 .. "/Work/Img")
      map.leftCell_workPanel_yield = self:GetChild(str1 .. "/Work/Img/TxtBack/Text")
      map.leftCell_workPanel_fireflyWorkLightDotEffect = self:GetChild(str1 .. "/Work/Img/Effect")
      map.leftCell_workPanel_fireflyWorkDotEffect = self:GetChild(str1 .. "/Work/Img/Effect2")
      map.leftCell_fullPanel = self:GetChild(str1 .. "/Max")
      map.leftCell_fullPanel_txt = self:GetChild(str1 .. "/Max/TxtBack/Text")
      map.leftCell_lockPanel = self:GetChild(str1 .. "/Lock")
      map.leftCell_lockPanel_txt = self:GetChild(str1 .. "/Lock/TxtBack/Text")
      map.rightCell = self:GetChild(str2)
      map.rightCell_anchorx = (map.rightCell):GetXPosition()
      map.rightCell_width = (map.rightCell):GetRectSize()
      map.rightCell_itemIcon = self:GetChild(str2 .. "/Item")
      map.rightCell_dispatchTxt = self:GetChild(str2 .. "/Text")
      map.rightCell_fireflyNum = self:GetChild(str2 .. "/Num")
      map.rightCell_firefly = self:GetChild(str2 .. "/Img")
      map.rightCell_lockPanel = self:GetChild(str2 .. "/Lock")
      map.rightCell_lockPanel_txt = self:GetChild(str2 .. "/Lock/TxtBack/Text")
      map.rightCell_addBtn = self:GetChild(str2 .. "/AddBtn")
      map.rightCell_addBtn_num = self:GetChild(str2 .. "/AddBtn/Text")
      map.rightCell_maxBtn = self:GetChild(str2 .. "/MaxBtn")
      map.rightCell_maxBtn_text = self:GetChild(str2 .. "/MaxBtn/Text")
      map.rightCell_reduceBtn = self:GetChild(str2 .. "/MinusBtn")
      map.rightCell_reduceBtn_num = self:GetChild(str2 .. "/MinusBtn/Text")
      map.rightCell_minBtn = self:GetChild(str2 .. "/MinBtn")
      map.rightCell_minBtn_text = self:GetChild(str2 .. "/MinBtn/Text")
      map.leftCell_workPanel_firefly_stateHandler = (map.leftCell_workPanel_firefly):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
      ;
      (map.rightCell_addBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnAddBtnClicked(i)
  end
)
      ;
      (map.rightCell_reduceBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i
    self:OnReduceBtnClicked(i)
  end
)
      ;
      (map.rightCell_maxBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:OnMaxBtnClicked(i)
  end
)
      ;
      (map.rightCell_minBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self, i
    self:OnMinBtnClicked(i)
  end
)
      ;
      (map.leftCell_restPanel_txt):SetText((TextManager.GetText)(800139))
      ;
      (map.leftCell_fullPanel_txt):SetText((TextManager.GetText)(800140))
      ;
      (map.rightCell_maxBtn_text):SetText((TextManager.GetText)(800148))
      ;
      (map.rightCell_minBtn_text):SetText((TextManager.GetText)(800149))
      ;
      (map.rightCell_dispatchTxt):SetText((TextManager.GetText)(800150))
    end
  end
  self._title = self:GetChild("RightPanel/Top/Title")
  self._tips = self:GetChild("RightPanel/Top/Tips")
  self._fireflyTxt = self:GetChild("RightPanel/Light/Text")
  self._fireflyNum = self:GetChild("RightPanel/Light/Num")
  self._fireflyLvUpBtn = self:GetChild("RightPanel/Light/AddBtn")
  self._fireflyLvUpBtn_addIcon = self:GetChild("RightPanel/Light/AddBtn/Image")
  self._fireflyLvUpBtn_maxTxt = self:GetChild("RightPanel/Light/AddBtn/Text")
  self._fireflyLvUpIcon = self:GetChild("RightPanel/Light/LevelUpBtn")
  self._iBtn = self:GetChild("Ibtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._width = (self._currencyPanel):GetRectSize()
  self._anchoredx = (self._currencyPanel):GetAnchoredPosition()
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false)
  ;
  (self._fireflyLvUpBtn):Subscribe_PointerClickEvent(self.OnFireflyLvUpBtnClicked, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._txt):SetText((TextManager.GetText)(((NekoData.BehaviorManager).BM_Firefly):GetCopywritingPlotId()))
  ;
  (self._fireflyLvUpBtn_maxTxt):SetText((TextManager.GetText)(800158))
  ;
  (self._title):SetText((TextManager.GetText)(800141))
  ;
  (self._tips):SetText((TextManager.GetText)(800151))
  ;
  (self._fireflyTxt):SetText((TextManager.GetText)(800142))
  self:LoadLocalData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnCollectorFireflyNumChanged, Common.n_CollectorFireflyNumChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.LoadLocalData, Common.n_RefreshFirefly, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnCollectorCapacityLvUp, Common.n_CollectorCapacityLvUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnFireflyCapacityLvUp, Common.n_FireflyCapacityLvUp, nil)
end

FireflyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
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
  (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  ;
  (DialogManager.DestroySingletonDialog)("firefly.fireflylevelupdialog")
end

FireflyDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._courtyardSceneController = sceneController
end

FireflyDialog.GetCurrencyIndexById = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs(self._currencies) do
    if v.currecyId == id then
      return i
    end
  end
end

FireflyDialog.OnRefreshCurrency = function(self)
  -- function num : 0_5 , upvalues : _ENV
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
        (table.insert)(self._currencies, {currecyId = i, num = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(i), maxCapacity = maxCapacity, canJump = false})
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
    end
  end
end

FireflyDialog.OnCollectorFireflyNumChanged = function(self, notification)
  -- function num : 0_6
  self._sendChangFireflyNumProtocol = false
  self:RefreshFireflyPanel()
  local collectorId = (notification.userInfo).taskId
  self:RefreshCollectorById(collectorId)
  self:RefreshLoadingState()
end

FireflyDialog.OnCollectorCapacityLvUp = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  self:OnRefreshCurrency()
  for i,v in ipairs((notification.userInfo).tasks) do
    local collectorId = v.taskId
    self:RefreshCollectorById(collectorId)
  end
  self:RefreshLoadingState()
end

FireflyDialog.OnFireflyCapacityLvUp = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self:RefreshFireflyPanel()
  for index = DataCommon.WhiteLight, DataCommon.ColorLight do
    local i = index - DataCommon.WhiteLight + 1
    self:RefreshCollectorById(i)
  end
end

FireflyDialog.RefreshCollectTime = function(self)
  -- function num : 0_9 , upvalues : _ENV, CStringres
  local restTime = ((NekoData.BehaviorManager).BM_Firefly):GetCollectLightsLeftTime()
  local rate = ((NekoData.BehaviorManager).BM_Firefly):GetCollectLightsRate()
  local collectSpeed = ((NekoData.BehaviorManager).BM_Firefly):GetCollectSpeed()
  local str = (TextManager.GetText)((CStringres:GetRecorder(1143)).msgTextID)
  if restTime // 1000 > 0 then
    str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%M", restTime // 1000))
    str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%S", restTime // 1000))
    ;
    (self._progress):SetFillAmount((rate - restTime * collectSpeed) / rate)
  else
    str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%M", 0))
    str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%S", 0))
    ;
    (self._progress):SetFillAmount(1)
  end
  ;
  (self._time):SetText(str)
end

FireflyDialog.RefreshFireflyPanel = function(self)
  -- function num : 0_10 , upvalues : _ENV, CFireflylvupCfg
  local restFireflyNum = ((NekoData.BehaviorManager).BM_Firefly):GetFreeFireflyNum()
  local totalFireflyNum = (((NekoData.BehaviorManager).BM_Firefly):GetMaxFireflyNum())
  -- DECOMPILER ERROR at PC10: Overwrote pending register: R3 in 'AssignReg'

  local str = .end
  local params = {}
  if totalFireflyNum <= restFireflyNum then
    str = (TextManager.GetText)(800143)
    ;
    (table.insert)(params, totalFireflyNum)
    ;
    (table.insert)(params, totalFireflyNum)
  else
    if restFireflyNum <= 0 then
      str = (TextManager.GetText)(800145)
      ;
      (table.insert)(params, totalFireflyNum)
    else
      str = (TextManager.GetText)(800144)
      ;
      (table.insert)(params, restFireflyNum)
      ;
      (table.insert)(params, totalFireflyNum)
    end
  end
  for i,v in ipairs(params) do
    str = (string.gsub)(str, "%$parameter" .. i .. "%$", v)
  end
  ;
  (self._fireflyNum):SetText(str)
  local fireflyLv = ((NekoData.BehaviorManager).BM_Firefly):GetFireflyLevel()
  local fireflyMaxLv = ((NekoData.BehaviorManager).BM_Firefly):GetFireflyCurMaxLv()
  local value = fireflyLv < fireflyMaxLv
  ;
  (self._fireflyLvUpBtn_addIcon):SetActive(value)
  ;
  (self._fireflyLvUpBtn_maxTxt):SetActive(not value)
  ;
  (self._fireflyLvUpBtn):SetInteractable(value)
  if value then
    local nextLv = fireflyLv + 1
    local record = CFireflylvupCfg:GetRecorder(nextLv)
    local list = (string.split)(record.items, "@")
    local items = {}
    ;
    (table.insert)(items, {id = tonumber(list[1]), num = tonumber(list[2])})
    local enough = true
    for i,v in ipairs(items) do
      local haveNum = 0
      if (string.sub)(v.id, 1, 2) == "35" then
        haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(v.id)
      else
        haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v.id)
      end
      if haveNum < v.num then
        enough = false
        break
      end
    end
    ;
    (self._fireflyLvUpIcon):SetActive(enough)
  else
    (self._fireflyLvUpIcon):SetActive(false)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

FireflyDialog.GetCollectorUnlockLv = function(self, collectorId)
  -- function num : 0_11 , upvalues : CTreeLvUpCfg
  local allIds = (CTreeLvUpCfg:GetAllIds())
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local unlockLv = .end
  for j = 1, #allIds do
    local record = CTreeLvUpCfg:GetRecorder(allIds[j])
    -- DECOMPILER ERROR at PC17: Unhandled construct in 'MakeBoolean' P1

    if collectorId == 1 and record.light1Lv > 0 then
      unlockLv = record.id
      break
    end
    -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

    if collectorId == 2 and record.light2Lv > 0 then
      unlockLv = record.id
      break
    end
    if collectorId == 3 and record.light3Lv > 0 then
      unlockLv = record.id
      break
    end
  end
  do
    return unlockLv
  end
end

FireflyDialog.RefreshCollectorById = function(self, collectorId)
  -- function num : 0_12 , upvalues : CLightImageCfg, CCollectorlvupCfg, _ENV, CImagePathTable
  local collectorInfo = (self._collectorsInfo)[collectorId]
  local lightId = collectorInfo.currencyId
  local lightImageRecord = CLightImageCfg:GetRecorder(collectorId)
  local collectorTaskRecord = CCollectorlvupCfg:GetRecorder(collectorInfo.collectorTaskId)
  local map = (self._lightPanel)[lightId]
  if map.fireflyWorkDotEffectHandler then
    (map.leftCell_workPanel_fireflyWorkDotEffect):ReleaseEffect(map.fireflyWorkDotEffectHandler)
    map.fireflyWorkDotEffectHandler = nil
  end
  if map.fireflyWorkLightDotEffectHandler then
    (map.leftCell_workPanel_fireflyWorkLightDotEffect):ReleaseEffect(map.fireflyWorkLightDotEffectHandler)
    map.fireflyWorkLightDotEffectHandler = nil
  end
  local imageRecord = (map.item):GetIcon()
  ;
  (map.leftCell_itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (map.rightCell_itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if collectorInfo.collectorLv == 0 then
    (map.leftCell_lockPanel):SetActive(true)
    ;
    (map.rightCell_lockPanel):SetActive(true)
    ;
    (map.leftCell_fullPanel):SetActive(false)
    ;
    (map.leftCell_restPanel):SetActive(false)
    ;
    (map.leftCell_workPanel):SetActive(false)
    local unlockLv = self:GetCollectorUnlockLv(collectorId)
    ;
    (map.leftCell_lockPanel_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1139, {unlockLv}))
    ;
    (map.rightCell_lockPanel_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1139, {unlockLv}))
    ;
    (map.rightCell):SetActive(false)
  else
    do
      ;
      (map.leftCell_lockPanel):SetActive(false)
      ;
      (map.rightCell_lockPanel):SetActive(false)
      ;
      (map.rightCell):SetActive(true)
      local fireflyCurNum = collectorInfo.fireflyNum
      ;
      (map.rightCell_fireflyNum):SetText((string.gsub)((TextManager.GetText)(800152), "%$parameter1%$", fireflyCurNum))
      ;
      (map.rightCell_addBtn_num):SetText((string.gsub)((TextManager.GetText)(800146), "%$parameter1%$", collectorTaskRecord.fireflyordernum))
      ;
      (map.rightCell_reduceBtn_num):SetText((string.gsub)((TextManager.GetText)(800147), "%$parameter1%$", collectorTaskRecord.fireflyordernum))
      local lightNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(lightId)
      local lightMaxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(lightId)
      local lastActive = (map.leftCell_workPanel):IsActive()
      if lightMaxCapacity <= lightNum then
        (map.leftCell_fullPanel):SetActive(true)
        ;
        (map.leftCell_restPanel):SetActive(false)
        if map.work == 1 then
          (map.leftCell_workPanel_firefly):PlayAnimation("WorkFireFlyHide")
        else
          ;
          (map.leftCell_workPanel):SetActive(false)
        end
        map.work = 2
      else
        if fireflyCurNum <= 0 then
          (map.leftCell_fullPanel):SetActive(false)
          if map.work == 1 then
            (map.leftCell_workPanel_firefly):PlayAnimation("WorkFireFlyHide")
          else
            ;
            (map.leftCell_workPanel):SetActive(false)
            ;
            (map.leftCell_restPanel):SetActive(true)
          end
          map.work = 2
        else
          ;
          (map.leftCell_fullPanel):SetActive(false)
          ;
          (map.leftCell_restPanel):SetActive(false)
          ;
          (map.leftCell_workPanel):SetActive(true)
          imageRecord = CImagePathTable:GetRecorder(lightImageRecord.fireflyBig)
          ;
          (map.leftCell_workPanel_firefly):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          if map.work == 2 then
            (map.leftCell_workPanel_firefly):PlayAnimation("WorkFireFlyShow")
          end
          map.work = 1
          local str = (TextManager.GetText)(800138)
          ;
          (map.leftCell_workPanel_yield):SetText((string.gsub)(str, "%$parameter1%$", fireflyCurNum // collectorTaskRecord.fireflyordernum))
          map.fireflyWorkLightDotEffectHandler = (map.leftCell_workPanel_fireflyWorkLightDotEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(lightImageRecord.backLight))
          map.fireflyWorkDotEffectHandler = (map.leftCell_workPanel_fireflyWorkDotEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(lightImageRecord.fireflyEffect))
        end
      end
      do
        imageRecord = CImagePathTable:GetRecorder(lightImageRecord.fireflySmall)
        ;
        (map.rightCell_firefly):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
    end
  end
end

FireflyDialog.RefreshLoadingState = function(self)
  -- function num : 0_13 , upvalues : _ENV, CLightImageCfg, FreeState
  local workState = 0
  for k,v in pairs(self._collectorsInfo) do
    if v.collectorLv ~= 0 then
      local lightId = v.currencyId
      local fireflyCurNum = v.fireflyNum
      local lightNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(lightId)
      local lightMaxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(lightId)
      if lightMaxCapacity <= lightNum and (self._flowerEffectHandlers)[k] then
        (self._flowerEffect):ReleaseEffect((self._flowerEffectHandlers)[k])
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._flowerEffectHandlers)[k] = nil
        local lightImageRecord = CLightImageCfg:GetRecorder(k)
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self._flowerStopEffectHandlers)[k] = (self._flowerEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(lightImageRecord.manjusakastopeffect))
      end
    end
    do
      if fireflyCurNum <= 0 and (self._flowerEffectHandlers)[k] then
        (self._flowerEffect):ReleaseEffect((self._flowerEffectHandlers)[k])
        -- DECOMPILER ERROR at PC61: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._flowerEffectHandlers)[k] = nil
        local lightImageRecord = CLightImageCfg:GetRecorder(k)
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self._flowerStopEffectHandlers)[k] = (self._flowerEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(lightImageRecord.manjusakastopeffect))
      end
      do
        if (self._flowerStopEffectHandlers)[k] then
          (self._flowerEffect):ReleaseEffect((self._flowerStopEffectHandlers)[k])
          -- DECOMPILER ERROR at PC86: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (self._flowerStopEffectHandlers)[k] = nil
        end
        do
          do
            if not (self._flowerEffectHandlers)[k] then
              local lightImageRecord = CLightImageCfg:GetRecorder(k)
              -- DECOMPILER ERROR at PC103: Confused about usage of register: R12 in 'UnsetPending'

              ;
              (self._flowerEffectHandlers)[k] = (self._flowerEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(lightImageRecord.manjusakaeffect))
            end
            workState = workState + 1
            -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
  ;
  (self._loadingPanel):SetActive(workState > 0)
  do
    if workState <= 0 and not (self._flowerEffectHandlers)[FreeState] then
      local lightImageRecord = CLightImageCfg:GetRecorder(FreeState)
      -- DECOMPILER ERROR at PC134: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._flowerEffectHandlers)[FreeState] = (self._flowerEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(lightImageRecord.manjusakaeffect))
    end
    if (self._flowerEffectHandlers)[FreeState] then
      (self._flowerEffect):ReleaseEffect((self._flowerEffectHandlers)[FreeState])
      -- DECOMPILER ERROR at PC149: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._flowerEffectHandlers)[FreeState] = nil
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

FireflyDialog.LoadLocalData = function(self)
  -- function num : 0_14 , upvalues : _ENV
  self._collectorsInfo = ((NekoData.BehaviorManager).BM_Firefly):GetCollectorsInfo()
  self:RefreshCollectTime()
  self:RefreshFireflyPanel()
  self:OnRefreshCurrency()
  self:RefreshLoadingState()
  local lockCellWidth = 0
  for index = DataCommon.WhiteLight, DataCommon.ColorLight do
    local i = index - DataCommon.WhiteLight + 1
    self:RefreshCollectorById(i)
    local collectorInfo = (self._collectorsInfo)[i]
    local map = (self._lightPanel)[index]
    if collectorInfo.collectorLv == 0 then
      lockCellWidth = lockCellWidth + map.rightCell_width
    end
  end
  for index = DataCommon.WhiteLight, DataCommon.ColorLight do
    local i = index - DataCommon.WhiteLight + 1
    local collectorInfo = (self._collectorsInfo)[i]
    local map = (self._lightPanel)[index]
    if collectorInfo.collectorLv ~= 0 then
      (map.rightCell):SetXPosition(map.rightCell_anchorx, map.rightCell_offsetx + (lockCellWidth) / 2)
    end
  end
  if not self._task then
    self._task = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_14_0 , upvalues : self
    self:RefreshCollectTime()
  end
, nil)
  end
end

FireflyDialog.OnAddBtnClicked = function(self, lightId)
  -- function num : 0_15 , upvalues : _ENV, CCollectorlvupCfg
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(56) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(56)
  end
  if not self._sendChangFireflyNumProtocol then
    local collectorId = lightId - DataCommon.WhiteLight + 1
    local collectorInfo = (self._collectorsInfo)[collectorId]
    local collectorTaskRecord = CCollectorlvupCfg:GetRecorder(collectorInfo.collectorTaskId)
    local num = collectorTaskRecord.fireflyordernum
    local lightNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(lightId)
    local lightMaxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(lightId)
    if lightMaxCapacity <= lightNum then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100223, {(((self._lightPanel)[lightId]).item):GetName()})
    else
      if num <= ((NekoData.BehaviorManager).BM_Firefly):GetFreeFireflyNum() then
        self._sendChangFireflyNumProtocol = true
        local caddGlowworm = (LuaNetManager.CreateProtocol)("protocol.yard.caddglowworm")
        caddGlowworm.taskId = collectorId
        caddGlowworm.addNums = num
        caddGlowworm:Send()
      else
        do
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100221)
        end
      end
    end
  end
end

FireflyDialog.OnReduceBtnClicked = function(self, lightId)
  -- function num : 0_16 , upvalues : _ENV, CCollectorlvupCfg
  if not self._sendChangFireflyNumProtocol then
    local collectorId = lightId - DataCommon.WhiteLight + 1
    local collectorInfo = (self._collectorsInfo)[collectorId]
    local fireflyCurNum = collectorInfo.fireflyNum
    local collectorTaskRecord = CCollectorlvupCfg:GetRecorder(collectorInfo.collectorTaskId)
    local num = collectorTaskRecord.fireflyordernum
    if num <= fireflyCurNum then
      self._sendChangFireflyNumProtocol = true
      local caddGlowworm = (LuaNetManager.CreateProtocol)("protocol.yard.caddglowworm")
      caddGlowworm.taskId = collectorId
      caddGlowworm.addNums = -num
      caddGlowworm:Send()
    else
      do
        if fireflyCurNum == 0 then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100222, {(((self._lightPanel)[lightId]).item):GetName()})
        end
      end
    end
  end
end

FireflyDialog.OnMaxBtnClicked = function(self, lightId)
  -- function num : 0_17 , upvalues : _ENV, CCollectorlvupCfg
  if not self._sendChangFireflyNumProtocol then
    local collectorId = lightId - DataCommon.WhiteLight + 1
    local collectorInfo = (self._collectorsInfo)[collectorId]
    local collectorTaskRecord = CCollectorlvupCfg:GetRecorder(collectorInfo.collectorTaskId)
    local restFireflyNum = ((NekoData.BehaviorManager).BM_Firefly):GetFreeFireflyNum()
    local num = collectorTaskRecord.fireflyordernum
    local lightNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(lightId)
    local lightMaxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(lightId)
    local rate = (math.floor)(restFireflyNum / num)
    if lightMaxCapacity <= lightNum then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100223, {(((self._lightPanel)[lightId]).item):GetName()})
    else
      if rate > 0 then
        self._sendChangFireflyNumProtocol = true
        local caddGlowworm = (LuaNetManager.CreateProtocol)("protocol.yard.caddglowworm")
        caddGlowworm.taskId = collectorId
        caddGlowworm.addNums = rate * num
        caddGlowworm:Send()
      else
        do
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100221)
        end
      end
    end
  end
end

FireflyDialog.OnMinBtnClicked = function(self, lightId)
  -- function num : 0_18 , upvalues : _ENV, CCollectorlvupCfg
  if not self._sendChangFireflyNumProtocol then
    local collectorId = lightId - DataCommon.WhiteLight + 1
    local collectorInfo = (self._collectorsInfo)[collectorId]
    local collectorTaskRecord = CCollectorlvupCfg:GetRecorder(collectorInfo.collectorTaskId)
    local fireflyCurNum = collectorInfo.fireflyNum
    local num = collectorTaskRecord.fireflyordernum
    local rate = (math.floor)(fireflyCurNum / num)
    if rate > 0 then
      self._sendChangFireflyNumProtocol = true
      local caddGlowworm = (LuaNetManager.CreateProtocol)("protocol.yard.caddglowworm")
      caddGlowworm.taskId = collectorId
      caddGlowworm.addNums = -rate * num
      caddGlowworm:Send()
    else
      do
        if fireflyCurNum == 0 then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100222, {(((self._lightPanel)[lightId]).item):GetName()})
        end
      end
    end
  end
end

FireflyDialog.OnFireflyLvUpBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("firefly.fireflylevelupdialog")
end

FireflyDialog.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_20 , upvalues : _ENV
  for k,v in pairs(self._lightPanel) do
    -- DECOMPILER ERROR at PC15: Unhandled construct in 'MakeBoolean' P1

    if v.leftCell_workPanel_firefly_stateHandler == handle and v.work == 2 and stateName == "WorkFireFlyHide" then
      (v.leftCell_workPanel):SetActive(false)
      local lightNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(k)
      local lightMaxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(k)
      local fireflyCurNum = ((self._collectorsInfo)[k - DataCommon.WhiteLight + 1]).fireflyNum
      ;
      (v.leftCell_restPanel):SetActive(fireflyCurNum <= 0 and lightMaxCapacity > lightNum)
    end
    break
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

FireflyDialog.OnEffectEnd = function(self, effectHandler, window)
  -- function num : 0_21
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if (self._flowerStopEffectHandlers)[effectHandler] then
    (self._flowerStopEffectHandlers)[effectHandler] = nil
  end
end

FireflyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_22
  return #self._currencies
end

FireflyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_23
  return "courtyard.currencycell"
end

FireflyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_24
  return (self._currencies)[index]
end

FireflyDialog.OnIBtnClicked = function(self)
  -- function num : 0_25 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(((DataCommon.LocalTips).GuideOpenInstructionDialog_Firefly).guideId)
end

FireflyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_26 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(57) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(57)
  end
  self:Destroy()
end

FireflyDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_27 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return FireflyDialog

