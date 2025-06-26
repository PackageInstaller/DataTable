-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonhud.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local VarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CGuideConditionconfig = (BeanManager.GetTableByName)("guide.cguideconditionconfig")
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local eventId = tonumber(((CGuideConditionconfig:GetRecorder(40)).parm)[1])
local DungeonHUD = class("DungeonHUD", Dialog)
local GridFrame = require("framework.ui.frame.grid.gridframe")
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local roleNum = 6
local deltaNumBetweenRoleAndAlternate = 3
DungeonHUD.AssetBundleName = "ui/layouts.dungeon"
DungeonHUD.AssetName = "DungeonHUD"
local DungeonEventEnd = function(self, notification)
  -- function num : 0_0 , upvalues : eventId, _ENV, DungeonHUD
  if notification.userInfo == eventId then
    (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, DungeonHUD, nil)
  end
end

local HandleBuffGuide = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local guideId = ((NekoData.BehaviorManager).BM_Game):GetPlayBuffGuideId()
  if guideId and not (DialogManager.GetDialog)("newbattle.battleteachguidedialog") then
    ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(guideId)
  end
end

DungeonHUD.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : DungeonHUD, _ENV
  ((DungeonHUD.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._actor = ((((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon))._sceneRef).actor).object
  self._moneyTask = nil
  self._secondTask = nil
  self._showFor3secs = nil
  self._showTeam = {false, false, false, false, false, false}
  self._showTeamLinkTag = {false, false, false}
  self._curMoney = nil
  self._curSecond = nil
  self._roleList = {}
  self._roleListShowStationList = {}
  self._isActive = true
  self._hasTriggerGuideTag = false
  self._runtimePackerLuaAgent = nil
  self._currentRoleList = nil
  self._leaveToShowFinishDialog = false
end

DungeonHUD.OnCreate = function(self)
  -- function num : 0_3 , upvalues : _ENV, roleNum, deltaNumBetweenRoleAndAlternate, DungeonHUD, DungeonEventEnd, HandleBuffGuide
  self._name = self:GetChild("Back/Name")
  self._area = self:GetChild("Back/Area")
  self._leaveBtn = self:GetChild("Back/Leave")
  self._smallMap = self:GetChild("MapArea")
  self._bagBtn = self:GetChild("Back/BagListBtn")
  self._chatBtn = self:GetChild("Back/ChatBtn")
  self._gmChatBtn = self:GetChild("GM")
  ;
  (self._gmChatBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsGM())
  self._actArea = self:GetChild("ActButtons")
  self._stickArea = self:GetChild("JoyStickArea")
  self._teamPos = {}
  for i = 1, roleNum do
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      (self._teamPos)[i] = self:GetChild("Back/Char" .. R9_PC54)
      ;
      ((self._teamPos)[i]):SetActive(false)
    end
  end
  self._LinkImg = {}
  for i = 1, deltaNumBetweenRoleAndAlternate do
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

    (self._LinkImg)[i] = self:GetChild("Back/Link" .. R9_PC54)
    ;
    ((self._LinkImg)[i]):SetActive(false)
  end
  self._posImg = {}
  for i = 1, roleNum do
    -- DECOMPILER ERROR at PC91: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC95: Confused about usage of register: R5 in 'UnsetPending'

    (self._posImg)[i] = self:GetChild("Back/Char" .. R9_PC54 .. "/Back/Photo")
  end
  self._posHP = {}
  for i = 1, roleNum do
    -- DECOMPILER ERROR at PC106: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC110: Confused about usage of register: R5 in 'UnsetPending'

    (self._posHP)[i] = self:GetChild("Back/Char" .. R9_PC54 .. "/Frame")
    ;
    ((self._posHP)[i]):SetFillAmount(0)
  end
  self._teamGuidePoint = {}
  for i = 1, roleNum do
    -- DECOMPILER ERROR at PC126: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC130: Confused about usage of register: R5 in 'UnsetPending'

    (self._teamGuidePoint)[i] = self:GetChild("Back/Char" .. R9_PC54 .. "/Guide")
  end
  self._charRedDot = {}
  for i = 1, roleNum do
    -- DECOMPILER ERROR at PC141: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC145: Confused about usage of register: R5 in 'UnsetPending'

    (self._charRedDot)[i] = self:GetChild("Back/Char" .. R9_PC54 .. "/Dot")
    ;
    ((self._charRedDot)[i]):SetActive(false)
  end
  self._numPanel = self:GetChild("Back/TopGroup")
  self._moneyPanel = self:GetChild("Back/TopGroup/Num0")
  self._px = ((((CS.PixelNeko).UI).UIManager).WorldToScreenPointInMargin)("UICamera", ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)((self._moneyPanel)._uiObject))
  self._secondPanel = self:GetChild("Back/TopGroup/Num1")
  ;
  (self._numPanel):SetActive(false)
  self._moneyNum = self:GetChild("Back/TopGroup/Num0/Text")
  ;
  (self._moneyNum):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetMoney())
  self._moneyNumEffect = self:GetChild("Back/TopGroup/Num0/Effect")
  self._soulNumEffect = self:GetChild("Back/TopGroup/Num1/Effect")
  self._secondNum = self:GetChild("Back/TopGroup/Num1/Text")
  ;
  (self._secondNum):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID))
  self._addMoneyBtn = self:GetChild("Back/TopGroup/Num0/Add")
  self._addSecondBtn = self:GetChild("Back/TopGroup/Num1/Add")
  self._msgPopBack = self:GetChild("ChatCellBack")
  self._chestProcessTxt = self:GetChild("Chest/Text")
  self._helpBtn = self:GetChild("Back/HelpBtn")
  self._teamLock = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Dungeon_TeamInfo)
  self._bagLock = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Dungeon_Bag)
  self._smallMapUnlock = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Dungeon_MiniMap)
  if self._smallMapUnlock then
    local cSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
    local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if sceneController then
      local record = cSceneInfoStatic:GetRecorder(sceneController:GetSceneID())
      self._smallMapUnlock = record.haveMiniMap ~= 0
    end
  end
  if self._smallMapUnlock then
    (self._smallMap):Subscribe_PointerClickEvent(self.OnSmallMapClicked, self)
  end
  ;
  (self._bagBtn):Subscribe_PointerClickEvent(self.OnBagBtnClicked, self)
  ;
  (self._chatBtn):Subscribe_PointerClickEvent(self.OnChatBtnClicked, self)
  ;
  (self._gmChatBtn):Subscribe_PointerClickEvent(self.OnGMBtnClicked, self)
  ;
  (self._leaveBtn):Subscribe_PointerClickEvent(self.OnLeaveBtnClicked, self)
  ;
  (self._helpBtn):Subscribe_PointerClickEvent(self.OnHelpBtnClicked, self)
  for i = 1, roleNum do
    ((self._teamPos)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_0 , upvalues : self, i
    self:OnTeamCharClicked(i)
  end
, self)
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNumPanelUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNavMeshBuildFinish, Common.n_NavMeshBuildFinish, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdateMoneyNum, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdateSecondNum, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdateSecondNum, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdateSecondNum, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBattleRewardEnd, Common.n_BattleRewardEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActorMovingStateChange, Common.n_ActorMovingStateChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetTeamInfo, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerBegin, Common.n_RockerBegin, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDungeonEquipRedDot, Common.n_DungeonEquipRedDot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTriggerBuffGuide, Common.n_TriggerBuffGuide, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSingletonDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnOpenOneChestYeah, Common.n_OpenOneChestYeah, nil)
  self._curMoney = ((NekoData.BehaviorManager).BM_Currency):GetMoney()
  self._curSecond = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, DungeonHUD, nil)
  if not ((NekoData.BehaviorManager).BM_Guide):HasFinished(15) then
    (LuaNotificationCenter.AddObserver)(self, DungeonEventEnd, Common.n_DungeonEventEnd, nil)
  end
  ;
  (self._chatBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Chat))
  ;
  ((NekoData.BehaviorManager).BM_Game):SetGMHideUIByDialog((DataCommon.GMHideUI).Dungeon, self)
  HandleBuffGuide(self)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

DungeonHUD.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("chat.msgpopdialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonconquestdialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonmenudialog")
  ;
  (DialogManager.DestroySingletonDialog)("chat.chatmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("debug.gmorderdialog")
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battleteachguidedialog")
  if self._moneyNumEffectHandler then
    (self._moneyNumEffect):ReleaseEffect(self._moneyNumEffectHandler)
    self._moneyNumEffectHandler = nil
  end
  if self._soulNumEffectHandler then
    (self._soulNumEffect):ReleaseEffect(self._soulNumEffectHandler)
    self._soulNumEffectHandler = nil
  end
  if self._runtimePackerLuaAgent then
    (self._runtimePackerLuaAgent):Release()
  end
end

local CheckLock = function(self)
  -- function num : 0_5 , upvalues : roleNum, _ENV
  if not self._teamLock then
    for i = 1, roleNum do
      ((self._teamPos)[i]):SetActive(false)
      if (self._LinkImg)[i] then
        ((self._LinkImg)[i]):SetActive(false)
      end
    end
  else
    do
      for i = 1, roleNum do
        ((self._teamPos)[i]):SetActive((self._showTeam)[i])
        if (self._LinkImg)[i] then
          ((self._LinkImg)[i]):SetActive((self._showTeamLinkTag)[i])
        end
      end
      do
        if not self._bagLock then
          (self._bagBtn):SetActive(false)
        else
          ;
          (self._bagBtn):SetActive(true)
        end
        ;
        (self._chatBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Chat))
      end
    end
  end
end

DungeonHUD.OnActorMovingStateChange = function(self, notification)
  -- function num : 0_6
  local mode = {moveTostop = 0, stopTomove = 1}
  if (notification.userInfo).state == mode.moveTostop then
    self:SetButtonActive(false)
  else
    if (notification.userInfo).state == mode.stopTomove then
      self:SetButtonActive(true)
    end
  end
end

DungeonHUD.OnSingletonDialogDestroy = function(self, notification)
  -- function num : 0_7 , upvalues : HandleBuffGuide
  if (notification.userInfo)._dialogName == "newbattle.battleteachguidedialog" then
    HandleBuffGuide(self)
  end
end

DungeonHUD.OnTriggerBuffGuide = function(self)
  -- function num : 0_8 , upvalues : HandleBuffGuide
  HandleBuffGuide(self)
end

DungeonHUD.InitCharShow = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
  if dialog and dialog:IsMoving() then
    self:SetButtonActive(true)
  else
    self:SetButtonActive(false)
  end
end

DungeonHUD.OnRockerBegin = function(self)
  -- function num : 0_10
  self:SetButtonActive(true)
end

DungeonHUD.OnRockerEnd = function(self)
  -- function num : 0_11
  self:SetButtonActive(false)
end

DungeonHUD.SetActive = function(self, tag)
  -- function num : 0_12 , upvalues : _ENV
  self._isActive = tag
  ;
  (self:GetRootWindow()):SetActive(tag)
  local msgdialog = (DialogManager.GetDialog)("chat.msgpopdialog")
  if msgdialog then
    (msgdialog:GetRootWindow()):SetActive(tag)
  end
end

DungeonHUD.SetButtonActive = function(self, moving)
  -- function num : 0_13 , upvalues : _ENV, CheckLock, roleNum
  local mode = ((NekoData.BehaviorManager).BM_Game):GetUIShowMode()
  if mode == "uiMovingHideMode" then
    if not moving then
      CheckLock(self)
    else
      for i = 1, roleNum do
        ((self._teamPos)[i]):SetActive(false)
        if (self._LinkImg)[i] then
          ((self._LinkImg)[i]):SetActive(false)
        end
      end
      ;
      (self._bagBtn):SetActive(false)
      ;
      (self._chatBtn):SetActive(false)
    end
  else
    if mode == "uiAlwaysShowMode" then
      CheckLock(self)
    end
  end
end

DungeonHUD.OnNumPanelUpdate = function(self, notification)
  -- function num : 0_14 , upvalues : _ENV
  if self._moneyTask then
    if (self._moneyTask):update((notification.userInfo).deltaTime) then
      self._moneyTask = nil
      ;
      (self._moneyNum):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetMoney())
      self._showFor3secs = (Tween.new)(3, {}, {}, "linear")
    else
      ;
      (self._moneyNum):SetNumber((math.ceil)(((self._moneyTask).subject).value))
    end
  end
  if self._secondTask then
    if (self._secondTask):update((notification.userInfo).deltaTime) then
      self._secondTask = nil
      ;
      (self._secondNum):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID))
      self._showFor3secs = (Tween.new)(3, {}, {}, "linear")
    else
      ;
      (self._secondNum):SetNumber((math.ceil)(((self._secondTask).subject).value))
    end
  end
  if self._showFor3secs and (self._showFor3secs):update((notification.userInfo).deltaTime) then
    if not self._moneyTask and self._moneyNumEffectHandler then
      (self._moneyNumEffect):ReleaseEffect(self._moneyNumEffectHandler)
      self._moneyNumEffectHandler = nil
    end
    if not self._secondTask and self._soulNumEffectHandler then
      (self._soulNumEffect):ReleaseEffect(self._soulNumEffectHandler)
      self._soulNumEffectHandler = nil
    end
    if not self._moneyTask and not self._secondTask then
      (self._numPanel):SetActive(false)
    end
    self._showFor3secs = nil
  end
end

DungeonHUD.Refresh = function(self)
  -- function num : 0_15 , upvalues : _ENV, CDungeonSelectMainLine
  self:SetTeamInfo()
  self:InitCharShow()
  self:OnDungeonEquipRedDot()
  local str = ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):GetSceneShowName()
  ;
  (self._name):SetText(str)
  local sceneId = ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):GetSceneID()
  str = ""
  for _,value in pairs(CDungeonSelectMainLine:GetAllIds()) do
    local recorder = CDungeonSelectMainLine:GetRecorder(value)
    if recorder.sceneid == sceneId then
      str = recorder.floor
      break
    end
    local smallNodeJHave = false
    for _,value in pairs(recorder.smallnodeid) do
      if value == sceneId then
        str = recorder.floor
        smallNodeJHave = true
        break
      end
    end
  end
  do
    if not smallNodeJHave then
      (self._area):SetText(str)
    end
  end
end

DungeonHUD.SetTeamInfo = function(self)
  -- function num : 0_16 , upvalues : _ENV, LineUpStation, deltaNumBetweenRoleAndAlternate
  self._curTeamId = ((NekoData.BehaviorManager).BM_Team):GetCurrentTeamId()
  local isNewRoleList = false
  local teamRole = {}
  if self._curTeamId then
    local oldRoleList = self._currentRoleList
    self._currentRoleList = ((((NekoData.BehaviorManager).BM_Team):GetTeamsInfo())[self._curTeamId]).roles
    if oldRoleList then
      if #oldRoleList ~= #self._currentRoleList then
        isNewRoleList = true
      else
        for k,v in pairs(self._currentRoleList) do
          if v ~= oldRoleList[k] then
            isNewRoleList = true
            break
          end
        end
      end
    else
      do
        do
          isNewRoleList = true
          do return LogError("DungeonHUD", "team id is nil") end
          local i = 1
          local j = 1
          local goInBattleRoleIndex = 1
          self._roleList = {}
          self._roleListShowStationList = {}
          local headAssetbundles = {}
          local headAssetNames = {}
          local rawImages = {}
          local mainRoleList = {}
          local mainRoleListShowStationList = {}
          local alternateRoleList = {}
          local alternateRoleListShowStationList = {}
          for station,key in pairs(self._currentRoleList) do
            if key ~= 0 then
              local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
              if station == LineUpStation.FRONT_ROW or station == LineUpStation.MIDDLE_ROW or station == LineUpStation.BACK_ROW then
                if not role then
                  LogErrorFormat("DungeonHUD", "wrong role key %d", key)
                else
                  mainRoleList[i] = role
                  mainRoleListShowStationList[i] = goInBattleRoleIndex
                  i = i + 1
                  local img = role:GetDiamondHeadImageRecord()
                  if img ~= DataCommon.DefaultImageAsset then
                    (table.insert)(headAssetbundles, img.assetBundle)
                    ;
                    (table.insert)(headAssetNames, img.assetName)
                    ;
                    (table.insert)(rawImages, ((self._posImg)[goInBattleRoleIndex]):GetRawImage())
                  else
                    LogErrorFormat("DungeonHUD", "there is no diamondHeadImage for role %d", key)
                  end
                  local roles = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
                  for _,v in pairs(roles) do
                    if key == v:GetRoleId() then
                      ((self._posHP)[goInBattleRoleIndex]):SetFillAmount(v:GetCurrentHp() / v:GetMaxHp())
                    end
                  end
                  -- DECOMPILER ERROR at PC150: Confused about usage of register: R21 in 'UnsetPending'

                  ;
                  (self._showTeam)[goInBattleRoleIndex] = true
                end
                do
                  local alternateRoleId = (self._currentRoleList)[station + deltaNumBetweenRoleAndAlternate]
                  if alternateRoleId and alternateRoleId ~= 0 then
                    role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(alternateRoleId)
                    if not role then
                      LogErrorFormat("DungeonHUD", "wrong alternate role id %d", alternateRoleId)
                    else
                      alternateRoleList[j] = role
                      alternateRoleListShowStationList[j] = goInBattleRoleIndex + deltaNumBetweenRoleAndAlternate
                      j = j + 1
                      local img = role:GetDiamondHeadImageRecord()
                      if img ~= DataCommon.DefaultImageAsset then
                        (table.insert)(headAssetbundles, img.assetBundle)
                        ;
                        (table.insert)(headAssetNames, img.assetName)
                        ;
                        (table.insert)(rawImages, ((self._posImg)[goInBattleRoleIndex + deltaNumBetweenRoleAndAlternate]):GetRawImage())
                      else
                        LogErrorFormat("DungeonHUD", "there is no diamondHeadImage for role %d", alternateRoleId)
                      end
                      local roles = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
                      for _,v in pairs(roles) do
                        if alternateRoleId == v:GetRoleId() then
                          ((self._posHP)[goInBattleRoleIndex + deltaNumBetweenRoleAndAlternate]):SetFillAmount(v:GetCurrentHp() / v:GetMaxHp())
                        end
                      end
                      -- DECOMPILER ERROR at PC240: Confused about usage of register: R22 in 'UnsetPending'

                      ;
                      (self._showTeam)[goInBattleRoleIndex + deltaNumBetweenRoleAndAlternate] = true
                      -- DECOMPILER ERROR at PC242: Confused about usage of register: R22 in 'UnsetPending'

                      ;
                      (self._showTeamLinkTag)[goInBattleRoleIndex] = true
                    end
                  end
                  do
                    do
                      goInBattleRoleIndex = goInBattleRoleIndex + 1
                      -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
            end
          end
          for _,v in ipairs({mainRoleList, alternateRoleList}) do
            for i,role in ipairs(v) do
              (table.insert)(self._roleList, role)
            end
          end
          for _,v in ipairs({mainRoleListShowStationList, alternateRoleListShowStationList}) do
            for i,index in ipairs(v) do
              (table.insert)(self._roleListShowStationList, index)
            end
          end
          if isNewRoleList then
            self._runtimePackerLuaAgent = ((((CS.PixelNeko).UI).RuntimePackerStaticFunctions).GenerateAtlasIntoRT)(rawImages, headAssetbundles, headAssetNames)
          end
        end
      end
    end
  end
end

DungeonHUD.OnBattleRewardEnd = function(self)
  -- function num : 0_17 , upvalues : _ENV, VarConfig
  if self._curTeamId then
    local teamRole = ((((NekoData.BehaviorManager).BM_Team):GetTeamsInfo())[self._curTeamId]).roles
    local currentHP, totalHP = 0, 0
    for station,id in pairs(teamRole) do
      if id ~= 0 then
        local roles = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
        for _,v in pairs(roles) do
          if id == v:GetRoleId() then
            currentHP = currentHP + v:GetCurrentHp()
            totalHP = totalHP + v:GetMaxHp()
          end
        end
      end
    end
    if (currentHP) / (totalHP) <= tonumber((VarConfig:GetRecorder(5)).Value) then
      (LuaNotificationCenter.PostNotification)(Common.n_TeamHPIsLow, self, true)
    end
  end
end

DungeonHUD.OnSmallMapClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("dungeon.dungeonmenudialog")
end

DungeonHUD.GetMiniMapOrigin = function(self)
  -- function num : 0_19
  return self._smallMap
end

DungeonHUD.OnBagBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonconquestdialog")
  if dialog then
    dialog:Refresh()
  end
end

DungeonHUD.OnChatBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("chat.chatmaindialog")):Toggle()
end

DungeonHUD.OnGMBtnClicked = function(self)
  -- function num : 0_22 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("debug.gmorderdialog")):Toggle()
end

DungeonHUD.OnTeamCharClicked = function(self, i)
  -- function num : 0_23 , upvalues : _ENV
  local dlg = (DialogManager.GetDialog)("dungeon.rockerdialog")
  if dlg then
    dlg:Mute()
  end
  local dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
  for index,role in ipairs(self._roleList) do
    if (self._roleListShowStationList)[index] == i then
      dialog:Refresh(role)
    end
  end
end

DungeonHUD.ReturnRoleList = function(self)
  -- function num : 0_24
  return self._roleList
end

DungeonHUD.OnRandomItemPick = function(self, itemKey, x, y, type)
  -- function num : 0_25 , upvalues : _ENV
  if type == (RandomItemManager.Type).Mana then
    ((((CS.PixelNeko).Animation).AnimationHelper).PlayAnimation2)(self._actor, "GetMana", 1)
  end
end

DungeonHUD.OnUpdateMoneyNum = function(self, notification)
  -- function num : 0_26 , upvalues : _ENV
  local cur = self._curMoney
  local next = ((NekoData.BehaviorManager).BM_Currency):GetMoney()
  self._curMoney = next
  if self._moneyTask then
    cur = ((self._moneyTask).subject).value
    self._moneyTask = nil
  end
  if cur ~= next then
    self._moneyTask = (Tween.new)(0.5, {value = cur}, {value = next}, "linear")
    if self._moneyNumEffectHandler then
      (self._moneyNumEffect):ReleaseEffect(self._moneyNumEffectHandler)
      self._moneyNumEffectHandler = nil
    end
    if not self._moneyNumEffectHandler then
      self._moneyNumEffectHandler = (self._moneyNumEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1026))
    end
    ;
    (self._numPanel):SetActive(true)
  end
  cur = self._curSecond
  next = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID)
  self._curSecond = next
  if self._secondTask then
    cur = ((self._secondTask).subject).value
    self._secondTask = nil
  end
  if cur ~= next then
    self._secondTask = (Tween.new)(0.5, {value = cur}, {value = next}, "linear")
    if self._soulNumEffectHandler then
      (self._soulNumEffect):ReleaseEffect(self._soulNumEffectHandler)
      self._soulNumEffectHandler = nil
    end
    if not self._soulNumEffectHandler then
      self._soulNumEffectHandler = (self._soulNumEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1026))
    end
    ;
    (self._numPanel):SetActive(true)
  end
end

DungeonHUD.OnUpdateSecondNum = function(self, notification)
  -- function num : 0_27 , upvalues : _ENV
  local cur = self._curSecond
  local next = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID)
  self._curSecond = next
  if self._secondTask then
    cur = ((self._secondTask).subject).value
    self._secondTask = nil
  end
  if cur ~= next then
    self._secondTask = (Tween.new)(0.5, {value = cur}, {value = next}, "linear")
    if self._soulNumEffectHandler then
      (self._soulNumEffect):ReleaseEffect(self._soulNumEffectHandler)
      self._soulNumEffectHandler = nil
    end
    if not self._soulNumEffectHandler then
      self._soulNumEffectHandler = (self._soulNumEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1026))
    end
    ;
    (self._numPanel):SetActive(true)
  end
end

DungeonHUD.OnNavMeshBuildFinish = function(self)
  -- function num : 0_28
  self:SetHelpBtnActive(false)
end

DungeonHUD.GetMsgPopBack = function(self)
  -- function num : 0_29
  return self._msgPopBack
end

DungeonHUD.IsActive = function(self)
  -- function num : 0_30
  return self._isActive
end

DungeonHUD.OnDungeonEquipRedDot = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local redData = ((NekoData.BehaviorManager).BM_Dungeon):GetEquipRedData()
  for station,key in pairs(self._currentRoleList) do
    if key ~= 0 then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
      for _,roleValue in ipairs(redData) do
        if role:GetRoleId() == roleValue.roleKey then
          for _,v in pairs(roleValue.canEquipList) do
            if #v ~= 0 then
              ((self._charRedDot)[station]):SetActive(true)
              break
            else
              ;
              ((self._charRedDot)[station]):SetActive(false)
            end
          end
          break
        end
      end
    end
  end
end

DungeonHUD.OnLeaveBtnClicked = function(self)
  -- function num : 0_32 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).MiniMapOperate) or not ((NekoData.BehaviorManager).BM_Guide):HasFinished(15) and not ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(15) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100211)
    return 
  end
  LogInfo("DungeonHUD", "跳转主城场景")
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(15, 1) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(15)
    ;
    ((NekoData.DataManager).DM_Game):SetStandAloneMode()
    ;
    (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
    if ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)).HideUI then
      ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):HideUI()
    end
    local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
    csend:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(41, nil, function()
    -- function num : 0_32_0 , upvalues : _ENV, self
    ((NekoData.DataManager).DM_Game):SetStandAloneMode()
    ;
    (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
    if ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)).HideUI then
      ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):HideUI()
    end
    self._leaveToShowFinishDialog = true
    local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
    csend:Send()
  end
, {}, nil, {})
    end
  end
end

DungeonHUD.ShowFinishExploreDialog = function(self, data)
  -- function num : 0_33 , upvalues : _ENV
  self._leaveToShowFinishDialog = false
  local dialog = (DialogManager.CreateSingletonDialog)("battle.finishexploredialog")
  if dialog then
    dialog:SetSpiritGiveData(data.money)
    dialog:SetCallBackFunc(data.doNext)
  else
    ;
    (data.doNext)()
  end
end

DungeonHUD.GetLeaveToShowFinishDialog = function(self)
  -- function num : 0_34
  return self._leaveToShowFinishDialog
end

DungeonHUD.ShowAndSetHelpBtn = function(self, effect)
  -- function num : 0_35
  self:SetHelpBtnActive(true)
  self._helpEffect = effect
end

DungeonHUD.OnHelpBtnClicked = function(self)
  -- function num : 0_36 , upvalues : _ENV
  if self._helpEffect then
    local dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonhelpdialog")
    dialog:SetEffect(self._helpEffect)
    self:SetHelpBtnActive(false)
  end
end

DungeonHUD.SetHelpBtnActive = function(self, flg)
  -- function num : 0_37 , upvalues : _ENV
  (self._helpBtn):SetActive(flg)
  ;
  ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):SetHelpBtnActive(flg)
end

DungeonHUD.OnOpenOneChestYeah = function(self)
  -- function num : 0_38 , upvalues : _ENV, CStringRes
  local str = ""
  str = (TextManager.GetText)((CStringRes:GetRecorder(1543)).msgTextID)
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local chestList = controller:GetChestList()
  local totalBox = #chestList
  local openedBox = 0
  for _,chest in ipairs(chestList) do
    if chest:IsOpened() then
      openedBox = openedBox + 1
    end
  end
  str = str:gsub("%$parameter1%$", openedBox)
  str = str:gsub("%$parameter2%$", totalBox)
  ;
  (self._chestProcessTxt):SetText(str)
end

return DungeonHUD

