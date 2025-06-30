-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolstowermaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CTowerfloorCfg = (BeanManager.GetTableByName)("activity.ctowerfloorcfg")
local CMonster_Handbook = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CClownSpecialCfg = (BeanManager.GetTableByName)("activity.cclownspecialcfg")
local CClownRoleLevelUp = (BeanManager.GetTableByName)("activity.cclownrolelevelup")
local CClownEquip = (BeanManager.GetTableByName)("activity.cclownequip")
local CClownRole = (BeanManager.GetTableByName)("activity.cclownrole")
local SUnlockFoolsDaysFunctionDef = (LuaNetManager.GetProtocolDef)("protocol.activity.sunlockfoolsdaysfunction")
local SReceiveActivtyItemDef = (LuaNetManager.GetProtocolDef)("protocol.activity.sreceiveactivtyitem")
local CStartFoolsDayBattleDef = (LuaNetManager.GetProtocolDef)("protocol.activity.cstartfoolsdaybattle")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local AprilFoolsTowerMainDialog = class("AprilFoolsTowerMainDialog", Dialog)
AprilFoolsTowerMainDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerMainDialog.AssetName = "ActivityAprilFoolsTower"
local FloorType = {None = 0, Box = 1, Story = 2, Battle = 3, Boss = 4}
local charNumber = 3
local ProcessNumber = {[FloorType.None] = 0, [FloorType.Box] = 2, [FloorType.Story] = 2, [FloorType.Battle] = 3, [FloorType.Boss] = 3}
AprilFoolsTowerMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsTowerMainDialog, ProcessNumber, FloorType, _ENV, CClownSpecialCfg
  ((AprilFoolsTowerMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._sendEnterNextFloorProtocol = false
  self._sendCompleteFloorProtocol = false
  self._sendStartBattleProtocol = false
  self._completeRefreshFloor = true
  self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.None]
  self._canShowItemGottenProcessNumberCount = 0
  self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.None]
  self._canShowNewCharProcessNumberCount = 0
  self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.None]
  self._canShowFuncUnlockProcessNumberCount = 0
  self._charLevelUpNeedItemId = tonumber((CClownSpecialCfg:GetRecorder(3)).Value)
  self._changeBackGroundFloorId = tonumber((CClownSpecialCfg:GetRecorder(9)).Value)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)
end

AprilFoolsTowerMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : charNumber, _ENV, AnimatorStaticFunctions, TableFrame
  self._backFrame = self:GetChild("BackFrame")
  self._towerPanel = self:GetChild("Frame")
  self._backBtn = self:GetChild("BackBtn")
  self._titleTxt = self:GetChild("Title")
  self._goBtn = self:GetChild("GoBtn")
  self._goBtnTxt = self:GetChild("GoBtn/text")
  self._shopBtn = self:GetChild("ShopBtn")
  self._char = {}
  for i = 1, charNumber do
    do
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

      (self._char)[i] = {}
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).panel = self:GetChild("CharCell" .. tostring(i))
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).level = self:GetChild("CharCell" .. tostring(i) .. "/Level")
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).headImg = self:GetChild("CharCell" .. tostring(i) .. "/HeadPhoto")
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).healthTxt = self:GetChild("CharCell" .. tostring(i) .. "/Health/HealthNum")
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).attackTxt = self:GetChild("CharCell" .. tostring(i) .. "/Attack/AttackNum")
      -- DECOMPILER ERROR at PC101: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).redDot = self:GetChild("CharCell" .. tostring(i) .. "/Dot")
      ;
      (((self._char)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCharPanelClicked(i)
  end
, self)
    end
  end
  self._storyUI = {}
  -- DECOMPILER ERROR at PC117: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._storyUI).panel = self:GetChild("ActivityAprilFoolsStory")
  -- DECOMPILER ERROR at PC124: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._storyUI).panelAnimator = (AnimatorStaticFunctions.Get)(((self._storyUI).panel)._uiObject)
  -- DECOMPILER ERROR at PC129: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._storyUI).btn = self:GetChild("ActivityAprilFoolsStory/Checkbtn")
  -- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._storyUI).btnTxt = self:GetChild("ActivityAprilFoolsStory/Checkbtn/Text")
  -- DECOMPILER ERROR at PC139: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._storyUI).name = self:GetChild("ActivityAprilFoolsStory/Name")
  -- DECOMPILER ERROR at PC144: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._storyUI).typeImg = self:GetChild("ActivityAprilFoolsStory/Item")
  -- DECOMPILER ERROR at PC149: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._storyUI).detail = self:GetChild("ActivityAprilFoolsStory/Title")
  self._battleUI = {}
  -- DECOMPILER ERROR at PC156: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).panel = self:GetChild("ActivityAprilFoolsbattle")
  -- DECOMPILER ERROR at PC163: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).panelAnimator = (AnimatorStaticFunctions.Get)(((self._battleUI).panel)._uiObject)
  -- DECOMPILER ERROR at PC168: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).title = self:GetChild("ActivityAprilFoolsbattle/Name/text")
  -- DECOMPILER ERROR at PC173: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).detail = self:GetChild("ActivityAprilFoolsbattle/LevelTxt")
  -- DECOMPILER ERROR at PC178: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).model = self:GetChild("ActivityAprilFoolsbattle/Model")
  local modelPivotX, modelPivotY = ((self._battleUI).model):GetPivotPosition()
  local modelRectSizeX, modelRectSizeY = ((self._battleUI).model):GetRectSize()
  -- DECOMPILER ERROR at PC189: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPivotDeltaX = modelRectSizeX * modelPivotX
  -- DECOMPILER ERROR at PC192: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPivotDeltaY = modelRectSizeY * modelPivotY
  -- DECOMPILER ERROR at PC201: Confused about usage of register: R8 in 'UnsetPending'

  -- DECOMPILER ERROR at PC202: Confused about usage of register: R7 in 'UnsetPending'

  -- DECOMPILER ERROR at PC203: Confused about usage of register: R6 in 'UnsetPending'

  -- DECOMPILER ERROR at PC204: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPosX = ((self._battleUI).model):GetPosition()
  -- DECOMPILER ERROR at PC209: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).typeImg = self:GetChild("ActivityAprilFoolsbattle/Item")
  -- DECOMPILER ERROR at PC214: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).attackNumTxt = self:GetChild("ActivityAprilFoolsbattle/Attack/AttackNum")
  -- DECOMPILER ERROR at PC219: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).healthNumTxt = self:GetChild("ActivityAprilFoolsbattle/Health/HealthNum")
  -- DECOMPILER ERROR at PC224: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).btn = self:GetChild("ActivityAprilFoolsbattle/Checkbtn")
  -- DECOMPILER ERROR at PC229: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).btnTxt = self:GetChild("ActivityAprilFoolsbattle/Checkbtn/Text")
  self._dungeonBattleBtn = self:GetChild("BattleBtn")
  self._dungeonBattleBtnTxt = self:GetChild("BattleBtn/Text")
  self._shopBtn = self:GetChild("ShopBtn")
  self._shopBtnTxt = self:GetChild("ShopBtn/Text")
  self._tipsBtn = self:GetChild("Tips")
  self._topGroup = self:GetChild("TopGroup")
  self._finish = self:GetChild("Finish")
  ;
  (self._finish):SetActive(false)
  self._towerFrame = (TableFrame.Create)(self._towerPanel, self, true, true, false)
  self._moneyFrame = (TableFrame.Create)(self._topGroup, self, false, false, true)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  ((self._storyUI).btn):Subscribe_PointerClickEvent(self.OnStoryBtnClicked, self)
  ;
  ((self._battleUI).btn):Subscribe_PointerClickEvent(self.OnBattleBtnClicked, self)
  ;
  (self._dungeonBattleBtn):Subscribe_PointerClickEvent(self.OnDungeonBattleBtnClicked, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (self._finish):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSEnterNextFloor, Common.n_AprilFoolsSEnterNextFloor, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSCompleteFloor, Common.n_AprilFoolsSCompleteFloor, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSRefreshFoolsDaySingleRole, Common.n_AprilFoolsSRefreshFoolsDaySingleRole, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSEndFoolsDayBattle, Common.n_AprilFoolsSEndFoolsDayBattle, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsClientBattleProcessOver, Common.n_AprilFoolsClientBattleProcessOver, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSUnlockFoolsDaysFunction, Common.n_AprilFoolsSUnlockFoolsDaysFunction, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSReceiveActivtyItem, Common.n_SReceiveActivtyItem, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSAddNewFoolsDayRole, Common.n_AprilFoolsSAddNewFoolsDayRole, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsOpenTowerDungeonDialog, Common.n_AprilFoolsOpenTowerDungeonDialog, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsOpenTowerShopDialog, Common.n_AprilFoolsOpenTowerShopDialog, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSOpenFoolsDayActivity, Common.n_SOpenFoolsDayActivity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  self._backImgWidth = (self._backFrame):GetRectSize()
  self._backImgPosX = (self._backFrame):GetPosition()
  self._screenWidth = (self:GetRootWindow()):GetRectSize()
  self._changeTotalLength = self._backImgHeight - self._screenHeight
  if self._changeTotalLength < 0 then
    self._changeTotalLength = 0
  end
  local anchorMinX, anchorMinY, anchorMaxX, anchorMaxY = (self._backFrame):GetAnchor()
  ;
  (self._backFrame):SetAnchor(R11_PC202, R12_PC201, anchorMaxX, 0)
  -- DECOMPILER ERROR at PC468: Overwrote pending register: R11 in 'AssignReg'

  -- DECOMPILER ERROR at PC469: Overwrote pending register: R12 in 'AssignReg'

  ;
  (self._backFrame):SetPivotPosition(R11_PC202, R12_PC201)
  self:Init()
end

AprilFoolsTowerMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._towerFrame then
    (self._towerFrame):Destroy()
    self._towerFrame = nil
  end
  if self._battleUI_Model_handler ~= 0 then
    ((self._battleUI).model):ReleaseModel(self._battleUI_Model_handler)
    self._battleUI_Model_handler = 0
  end
  if self._moneyFrame then
    (self._moneyFrame):Destroy()
    self._moneyFrame = nil
  end
end

AprilFoolsTowerMainDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringres, CTowerfloorCfg
  (self._titleTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1772)).msgTextID))
  ;
  (self._goBtnTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1774)).msgTextID))
  ;
  (self._dungeonBattleBtnTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1775)).msgTextID))
  ;
  (self._shopBtnTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1776)).msgTextID))
  self._floorList = {}
  self._currentFloorId = (self._bm):GetGardenPartyCurrentFloorId()
  self._currentFloorState = (self._bm):GetGardenPartyCurrentFloorState()
  ;
  (self._shopBtn):SetActive((self._bm):IfGardenPartyShopUnlock())
  ;
  (self._dungeonBattleBtn):SetActive((self._bm):IfGardenPartyDungeonBattleUnlock())
  local record, state = nil, nil
  for _,id in ipairs(CTowerfloorCfg:GetAllIds()) do
    record = CTowerfloorCfg:GetRecorder(id)
    state = ((self._dm).TowerFloorStateType).Untraveled
    if id == self._currentFloorId then
      state = self._currentFloorState
    else
      if id < self._currentFloorId then
        state = ((self._dm).TowerFloorStateType).Finish
      end
    end
    ;
    (table.insert)(self._floorList, {floorId = id, floorType = record.type, parameter = record.parameter, handbookid = record.handbookid, enemyHP = record.enemyHP, enemyATK = record.enemyATK, eventname = record.eventname, eventtext = record.eventtext, eventimg = record.eventimg, worldimg = record.worldimg, btntext = record.btntext, state = state, scale = record.scale, position = record.position})
  end
  ;
  (self._towerFrame):ReloadAllCell()
  ;
  (self._towerFrame):SetSoftMaskActive(false)
  self._towerTotalLength = (self._towerFrame):GetTotalLength()
  self._changeBackGroundTotalLength = self._towerTotalLength * (self._changeBackGroundFloorId / #self._floorList)
  self._backFrameCurPos = 0
  self._charList = (self._bm):GetGardenPartyRoleList()
  self:RefreshCharInfo()
  self:RefreshFloor()
  self:OnRefreshMoney()
end

AprilFoolsTowerMainDialog.RefreshCharInfo = function(self)
  -- function num : 0_4 , upvalues : charNumber, _ENV, CStringres, Role, CClownRoleLevelUp, CClownEquip
  for i = 1, charNumber do
    (((self._char)[i]).panel):SetActive(false)
  end
  local str = ((TextManager.GetText)((CStringres:GetRecorder(1773)).msgTextID))
  local role, image = nil, nil
  local needNum = 0
  local currentNum = 0
  local redDotShow = false
  local record = nil
  for i,char in ipairs(self._charList) do
    (((self._char)[i]).panel):SetActive(true)
    ;
    (((self._char)[i]).level):SetText((string.gsub)(str, "%$parameter1%$", char.roleLv))
    role = (Role.Create)(char.roleId)
    image = role:GetDiamondHeadImageRecord()
    ;
    (((self._char)[i]).headImg):SetSprite(image.assetBundle, image.assetName)
    ;
    (((self._char)[i]).healthTxt):SetText(char.blood)
    ;
    (((self._char)[i]).attackTxt):SetText(char.attack)
    currentNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(self._charLevelUpNeedItemId)
    needNum = (CClownRoleLevelUp:GetRecorder(char.roleLv)).neednum
    redDotShow = needNum <= currentNum and needNum > 0
    for _,id in ipairs(CClownEquip:GetAllIds()) do
      record = CClownEquip:GetRecorder(id)
    end
    if (record.equipid == char.equipid and record.level == char.weaponLv) or not record then
      LogErrorFormat("AprilFoolsTowerMainDialog", "no record in cclownequip with equipid %s level %s", char.equipid, char.weaponLv)
      return 
    end
    currentNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(record.itemid)
    needNum = record.itemnum
    redDotShow = redDotShow or (needNum <= currentNum and needNum > 0)
    if redDotShow then
      redDotShow = (self._bm):IsGardenPartyTowerAndDungeonOpen()
    end
    record = nil
    ;
    (((self._char)[i]).redDot):SetActive(redDotShow)
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

AprilFoolsTowerMainDialog.RefreshFloor = function(self, moveShowAnimation)
  -- function num : 0_5 , upvalues : FloorType, _ENV, CImagePath, CMonster_Handbook, CNPCShape
  if self._currentFloorState == ((self._dm).TowerFloorStateType).Going then
    (self._goBtn):SetActive(false)
    ;
    ((self._storyUI).panel):SetActive(false)
    ;
    ((self._battleUI).panel):SetActive(false)
    if self._currentFloorId == 1 then
      self:OnStoryBtnClicked()
    else
      if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Box or ((self._floorList)[self._currentFloorId]).floorType == FloorType.Story then
        ((self._storyUI).panel):SetActive((self._bm):IsGardenPartyTowerAndDungeonOpen())
        ;
        ((self._storyUI).panelAnimator):SetTrigger("Into")
        ;
        ((self._storyUI).btnTxt):SetText((TextManager.GetText)(((self._floorList)[self._currentFloorId]).btntext))
        ;
        ((self._storyUI).detail):SetText((TextManager.GetText)(((self._floorList)[self._currentFloorId]).eventtext))
        ;
        ((self._storyUI).name):SetText((TextManager.GetText)(((self._floorList)[self._currentFloorId]).eventname))
        if not CImagePath:GetRecorder(((self._floorList)[self._currentFloorId]).eventimg) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        ((self._storyUI).typeImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        do
          if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Battle or ((self._floorList)[self._currentFloorId]).floorType == FloorType.Boss then
            ((self._battleUI).panel):SetActive((self._bm):IsGardenPartyTowerAndDungeonOpen())
            ;
            ((self._battleUI).panelAnimator):SetTrigger("Into")
            local record = CMonster_Handbook:GetRecorder(((self._floorList)[self._currentFloorId]).handbookid)
            local npcShapeRecorder = CNPCShape:GetRecorder(record.shapeID)
            if self._battleUI_Model_handler ~= 0 then
              ((self._battleUI).model):ReleaseModel(self._battleUI_Model_handler)
              self._battleUI_Model_handler = 0
            end
            self._battleUI_Model_handler = ((self._battleUI).model):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
            local scale = ((self._floorList)[self._currentFloorId]).scale
            ;
            ((self._battleUI).model):SetLocalScale(scale, scale, scale)
            local posLs = (string.split)(((self._floorList)[self._currentFloorId]).position, ";")
            if #posLs > 1 then
              ((self._battleUI).model):SetPosition((self._battleUI).modelPosX, tonumber(posLs[1]) - (self._battleUI).modelPivotDeltaX, (self._battleUI).modelPosY, tonumber(posLs[2]) - (self._battleUI).modelPivotDeltaY)
            end
            ;
            ((self._battleUI).attackNumTxt):SetText(((self._floorList)[self._currentFloorId]).enemyATK)
            ;
            ((self._battleUI).healthNumTxt):SetText(((self._floorList)[self._currentFloorId]).enemyHP)
            ;
            ((self._battleUI).btnTxt):SetText((TextManager.GetText)(((self._floorList)[self._currentFloorId]).btntext))
            ;
            ((self._battleUI).detail):SetText((TextManager.GetText)(((self._floorList)[self._currentFloorId]).eventtext))
            ;
            ((self._battleUI).title):SetText((TextManager.GetText)(((self._floorList)[self._currentFloorId]).eventname))
            if not CImagePath:GetRecorder(((self._floorList)[self._currentFloorId]).eventimg) then
              local imageRecord = DataCommon.DefaultImageAsset
            end
            ;
            ((self._battleUI).typeImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          end
          do
            if self._currentFloorState == ((self._dm).TowerFloorStateType).Finish then
              if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Boss then
                (self._goBtn):SetActive(false)
              else
                ;
                (self._goBtn):SetActive((self._bm):IsGardenPartyTowerAndDungeonOpen())
              end
              ;
              ((self._storyUI).panel):SetActive(false)
              ;
              ((self._battleUI).panel):SetActive(false)
            else
              LogErrorFormat("AprilFoolsTowerMainDialog", "currentstate %s wrong (should be 0/1)", self._currentFloorState)
            end
            local moveToIndex = self._currentFloorId
            if moveToIndex > 1 then
              moveToIndex = moveToIndex - 1
            end
            ;
            (self._towerFrame):MoveDownToIndex(moveToIndex, moveShowAnimation)
          end
        end
      end
    end
  end
end

AprilFoolsTowerMainDialog.OnCharPanelClicked = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolstowercharacterinfodialog")):SetData((self._charList)[index])
end

AprilFoolsTowerMainDialog.OnGoBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  do
    if (self._bm):IsGardenPartyTowerAndDungeonOpen() and not self._sendEnterNextFloorProtocol then
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.centernextfloor")
      csend:Send()
      self._sendEnterNextFloorProtocol = true
    end
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100452)
  end
end

AprilFoolsTowerMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

AprilFoolsTowerMainDialog.OnStoryBtnClicked = function(self)
  -- function num : 0_9 , upvalues : FloorType, ProcessNumber, _ENV
  if (self._bm):IsGardenPartyTowerAndDungeonOpen() then
    if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Box then
      self._completeRefreshFloor = true
      self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.Box]
      self._canShowItemGottenProcessNumberCount = 0
      self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.Box]
      self._canShowNewCharProcessNumberCount = 0
      self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.Box]
      self._canShowFuncUnlockProcessNumberCount = 0
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copenfloorbox")
      csend.floorId = self._currentFloorId
      csend:Send()
    else
      do
        do
          if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Story then
            local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
            if dialog then
              dialog:SetDialogLibraryId(((self._floorList)[self._currentFloorId]).parameter, false, (dialog.DialogType).AprilFools)
            end
            self._completeRefreshFloor = false
          end
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100452)
        end
      end
    end
  end
end

AprilFoolsTowerMainDialog.SendBattleProtocol = function(self, floorType)
  -- function num : 0_10 , upvalues : _ENV, ProcessNumber, CStartFoolsDayBattleDef
  if not self._sendStartBattleProtocol then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cstartfoolsdaybattle")
    self._battleData = (self._floorList)[self._currentFloorId]
    self._sendStartBattleProtocol = true
    self._canShowItemGottenProcessNumberNeed = ProcessNumber[floorType]
    self._canShowItemGottenProcessNumberCount = 0
    self._canShowNewCharProcessNumberNeed = ProcessNumber[floorType]
    self._canShowNewCharProcessNumberCount = 0
    self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[floorType]
    self._canShowFuncUnlockProcessNumberCount = 0
    csend.battleType = CStartFoolsDayBattleDef.FLOOR
    csend.battleId = self._currentFloorId
    csend:Send()
  end
end

AprilFoolsTowerMainDialog.OnBattleBtnClicked = function(self)
  -- function num : 0_11 , upvalues : FloorType, _ENV
  if (self._bm):IsGardenPartyTowerAndDungeonOpen() then
    self._completeRefreshFloor = false
    if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Boss then
      local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
      if dialog then
        dialog:SetDialogLibraryId(((self._floorList)[self._currentFloorId]).parameter, false, (dialog.DialogType).AprilFools)
      end
    else
      do
        if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Battle then
          self:SendBattleProtocol(FloorType.Battle)
        end
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100452)
      end
    end
  end
end

AprilFoolsTowerMainDialog.OnDungeonBattleBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if (self._bm):IsGardenPartyTowerAndDungeonOpen() then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copenfoolscopybattle")
    csend:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100452)
    end
  end
end

AprilFoolsTowerMainDialog.OnShopBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  do
    if (self._bm):IfGardenPartyBlueShopUnlock() then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
      protocol.shopId = ((DataCommon.AprilFoolsDayActivity).Shop).BlueClownShopID
      protocol:Send()
    end
    do
      if (self._bm):IfGardenPartyRedShopUnlock() then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
        protocol.shopId = ((DataCommon.AprilFoolsDayActivity).Shop).RedClownShopID
        protocol:Send()
      end
      ;
      (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolstowershopmaindialog")
    end
  end
end

AprilFoolsTowerMainDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV, CStringres
  ((DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsdaytipsdialog")):SetData((CStringres:GetRecorder(1836)).msgTextID, (CStringres:GetRecorder(1837)).msgTextID)
end

AprilFoolsTowerMainDialog.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_15
  if stateName == "towerfinish" then
    (self._finish):SetActive(false)
  end
end

AprilFoolsTowerMainDialog.OnAprilFoolsSEnterNextFloor = function(self, notification)
  -- function num : 0_16 , upvalues : _ENV
  self._sendEnterNextFloorProtocol = false
  local lastFloorId = self._currentFloorId
  self._currentFloorId = (self._bm):GetGardenPartyCurrentFloorId()
  ;
  (self._towerFrame):FireEvent("RefreshModel", self._currentFloorId)
  self._currentFloorState = (self._bm):GetGardenPartyCurrentFloorState()
  LogInfoFormat("AprilFoolsTowerMainDialog", "last floorid %s enter floorid %s == ctowerfloorcfg id %s? currentstate %s", lastFloorId, self._currentFloorId, ((self._floorList)[self._currentFloorId]).floorId, self._currentFloorState)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._floorList)[self._currentFloorId]).state = self._currentFloorState
  self:RefreshFloor(true)
end

AprilFoolsTowerMainDialog.OnAprilFoolsSCompleteFloor = function(self, notification)
  -- function num : 0_17 , upvalues : _ENV, ProcessNumber, FloorType
  self._sendCompleteFloorProtocol = false
  local lastFloorId = self._currentFloorId
  self._currentFloorId = (self._bm):GetGardenPartyCurrentFloorId()
  ;
  (self._towerFrame):FireEvent("RefreshModel", self._currentFloorId)
  self._currentFloorState = (self._bm):GetGardenPartyCurrentFloorState()
  LogInfoFormat("AprilFoolsTowerMainDialog", "last floorid %s complete floorid %s == ctowerfloorcfg id %s? currentstate %s", lastFloorId, self._currentFloorId, ((self._floorList)[self._currentFloorId]).floorId, self._currentFloorState)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._floorList)[self._currentFloorId]).state = self._currentFloorState
  if self._completeRefreshFloor then
    self._completeRefreshFloor = false
    self:RefreshFloor(true)
  else
    self._completeRefreshFloor = true
  end
  self._canShowItemGottenProcessNumberCount = self._canShowItemGottenProcessNumberCount + 1
  if self._canShowItemGottenProcessNumberCount == self._canShowItemGottenProcessNumberNeed then
    self._canShowItemGottenProcessNumberCount = 0
    self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.None]
    ;
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).AprilFoolsDayActivityItems, data = (self._bm):GetGardenPartyGottenItemList()})
  end
  self._canShowNewCharProcessNumberCount = self._canShowNewCharProcessNumberCount + 1
  if self._canShowNewCharProcessNumberCount == self._canShowNewCharProcessNumberNeed then
    self._canShowNewCharProcessNumberCount = 0
    self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.None]
    local dialog = (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
    if dialog then
      dialog:SetData((dialog.ShowDialogType).Role, self._newCharId)
    end
    self._newCharId = nil
  end
  do
    self._canShowFuncUnlockProcessNumberCount = self._canShowFuncUnlockProcessNumberCount + 1
    if self._canShowFuncUnlockProcessNumberCount == self._canShowFuncUnlockProcessNumberNeed then
      self._canShowFuncUnlockProcessNumberCount = 0
      self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.None]
      self:OpenUnlockFunctionDialog()
    end
  end
end

AprilFoolsTowerMainDialog.OnAprilFoolsSRefreshFoolsDaySingleRole = function(self, notification)
  -- function num : 0_18
  self._charList = (self._bm):GetGardenPartyRoleList()
  self:RefreshCharInfo()
end

AprilFoolsTowerMainDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_19 , upvalues : FloorType, ProcessNumber, _ENV
  if notification.userInfo == ((self._floorList)[self._currentFloorId]).parameter then
    if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Boss then
      self:SendBattleProtocol(FloorType.Boss)
    else
      if not self._sendCompleteFloorProtocol then
        self._sendCompleteFloorProtocol = true
        self._completeRefreshFloor = true
        self._canShowItemGottenProcessNumberNeed = ProcessNumber[((self._floorList)[self._currentFloorId]).floorType]
        self._canShowItemGottenProcessNumberCount = 0
        self._canShowNewCharProcessNumberNeed = ProcessNumber[((self._floorList)[self._currentFloorId]).floorType]
        self._canShowNewCharProcessNumberCount = 0
        self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[((self._floorList)[self._currentFloorId]).floorType]
        self._canShowFuncUnlockProcessNumberCount = 0
        local csend = (LuaNetManager.CreateProtocol)("protocol.activity.ccompletefloor")
        csend.floorId = self._currentFloorId
        csend:Send()
      end
    end
  end
end

AprilFoolsTowerMainDialog.OnAprilFoolsSEndFoolsDayBattle = function(self, notification)
  -- function num : 0_20 , upvalues : CStartFoolsDayBattleDef, _ENV
  if (notification.userInfo).battleType == CStartFoolsDayBattleDef.FLOOR then
    self._sendStartBattleProtocol = false
    self._battleResult = (notification.userInfo).result
    LogInfoFormat("AprilFoolsTowerMainDialog", "server battle result %s", (notification.userInfo).result)
    ;
    ((DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolstowerbattledialog")):SetData((notification.userInfo).result, self._battleData)
  end
end

AprilFoolsTowerMainDialog.OnAprilFoolsClientBattleProcessOver = function(self, notification)
  -- function num : 0_21 , upvalues : FloorType, ProcessNumber, _ENV
  local ResultType = {Success = 1, Failed = 0}
  if self._battleResult == ResultType.Success then
    if ((self._floorList)[self._currentFloorId]).floorType == FloorType.Boss then
      (self._finish):SetActive(true)
      ;
      (self._finish):SetAnimatorTrigger("End")
    end
    self._battleResult = nil
    if self._completeRefreshFloor then
      self._completeRefreshFloor = false
      self:RefreshFloor(true)
    else
      self._completeRefreshFloor = true
    end
    self._canShowItemGottenProcessNumberCount = self._canShowItemGottenProcessNumberCount + 1
    if self._canShowItemGottenProcessNumberCount == self._canShowItemGottenProcessNumberNeed then
      self._canShowItemGottenProcessNumberCount = 0
      self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.None]
      ;
      ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).AprilFoolsDayActivityItems, data = (self._bm):GetGardenPartyGottenItemList()})
    end
    self._canShowNewCharProcessNumberCount = self._canShowNewCharProcessNumberCount + 1
    if self._canShowNewCharProcessNumberCount == self._canShowNewCharProcessNumberNeed then
      self._canShowNewCharProcessNumberCount = 0
      self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.None]
      local dialog = (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
      if dialog then
        dialog:SetData((dialog.ShowDialogType).Role, self._newCharId)
      end
      self._newCharId = nil
    end
    do
      self._canShowFuncUnlockProcessNumberCount = self._canShowFuncUnlockProcessNumberCount + 1
      if self._canShowFuncUnlockProcessNumberCount == self._canShowFuncUnlockProcessNumberNeed then
        self._canShowFuncUnlockProcessNumberCount = 0
        self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.None]
        self:OpenUnlockFunctionDialog()
      end
    end
  end
end

AprilFoolsTowerMainDialog.OnAprilFoolsSUnlockFoolsDaysFunction = function(self, notification)
  -- function num : 0_22 , upvalues : SUnlockFoolsDaysFunctionDef, ProcessNumber, FloorType
  if ((notification.userInfo).functionId == SUnlockFoolsDaysFunctionDef.RED_CLOWN and (self._bm):IfGardenPartyBlueShopUnlock()) or (notification.userInfo).functionId == SUnlockFoolsDaysFunctionDef.BLUE_CLOWN and (self._bm):IfGardenPartyRedShopUnlock() then
    return 
  end
  self._unlockFunctionId = (notification.userInfo).functionId
  self._canShowFuncUnlockProcessNumberCount = self._canShowFuncUnlockProcessNumberCount + 1
  if self._canShowFuncUnlockProcessNumberCount == self._canShowFuncUnlockProcessNumberNeed then
    self._canShowFuncUnlockProcessNumberCount = 0
    self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.None]
    self:OpenUnlockFunctionDialog()
  end
end

AprilFoolsTowerMainDialog.OpenUnlockFunctionDialog = function(self)
  -- function num : 0_23 , upvalues : SUnlockFoolsDaysFunctionDef, _ENV
  if self._unlockFunctionId == SUnlockFoolsDaysFunctionDef.RED_CLOWN or self._unlockFunctionId == SUnlockFoolsDaysFunctionDef.BLUE_CLOWN then
    (self._shopBtn):SetActive(true)
    local dialog = (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
    if dialog then
      dialog:SetData((dialog.ShowDialogType).ShopUnlock)
    end
  else
    do
      if self._unlockFunctionId == SUnlockFoolsDaysFunctionDef.COPY_BATTLE then
        (self._dungeonBattleBtn):SetActive(true)
        local dialog = (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
        if dialog then
          dialog:SetData((dialog.ShowDialogType).DungeonUnlock)
        end
      end
      do
        self._unlockFunctionId = nil
      end
    end
  end
end

AprilFoolsTowerMainDialog.OnSReceiveActivtyItem = function(self, notification)
  -- function num : 0_24 , upvalues : SReceiveActivtyItemDef, ProcessNumber, FloorType, _ENV
  if (notification.userInfo).activityLineId == SReceiveActivtyItemDef.FOOLSDAY then
    self._canShowItemGottenProcessNumberCount = self._canShowItemGottenProcessNumberCount + 1
    if self._canShowItemGottenProcessNumberCount == self._canShowItemGottenProcessNumberNeed then
      self._canShowItemGottenProcessNumberCount = 0
      self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.None]
      ;
      ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).AprilFoolsDayActivityItems, data = (self._bm):GetGardenPartyGottenItemList()})
    end
  end
end

AprilFoolsTowerMainDialog.OnAprilFoolsSAddNewFoolsDayRole = function(self, notification)
  -- function num : 0_25 , upvalues : CClownRole, _ENV, ProcessNumber, FloorType
  local record = CClownRole:GetRecorder((notification.userInfo).Id)
  if record then
    self._newCharId = record.roleid
  else
    LogErrorFormat("AprilFoolsTowerMainDialog", "CClownRole dont have id %s", (notification.userInfo).Id)
    return 
  end
  self._canShowNewCharProcessNumberCount = self._canShowNewCharProcessNumberCount + 1
  if self._canShowNewCharProcessNumberCount == self._canShowNewCharProcessNumberNeed then
    self._canShowNewCharProcessNumberCount = 0
    self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.None]
    local dialog = (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
    if dialog then
      dialog:SetData((dialog.ShowDialogType).Role, self._newCharId)
    end
    self._newCharId = nil
  end
end

AprilFoolsTowerMainDialog.IsShow = function(self, flag)
  -- function num : 0_26 , upvalues : FloorType
  (self._backBtn):SetActive(flag)
  ;
  (self._titleTxt):SetActive(flag)
  ;
  (self._tipsBtn):SetActive(flag)
  ;
  (self._topGroup):SetActive(flag)
  if self._currentFloorState == ((self._dm).TowerFloorStateType).Going then
    ((self._storyUI).panel):SetActive(false)
    ;
    ((self._battleUI).panel):SetActive(false)
    if (self._bm):IsGardenPartyTowerAndDungeonOpen() then
      ((self._storyUI).panel):SetActive(((self._floorList)[self._currentFloorId]).floorType ~= FloorType.Box and ((self._floorList)[self._currentFloorId]).floorType ~= FloorType.Story or flag)
      if (self._bm):IsGardenPartyTowerAndDungeonOpen() then
        ((self._battleUI).panel):SetActive(((self._floorList)[self._currentFloorId]).floorType ~= FloorType.Battle and ((self._floorList)[self._currentFloorId]).floorType ~= FloorType.Boss or flag)
        if self._currentFloorState == ((self._dm).TowerFloorStateType).Finish then
          ((self._storyUI).panel):SetActive(false)
          ;
          ((self._battleUI).panel):SetActive(false)
        end
      end
    end
  end
end

AprilFoolsTowerMainDialog.OnAprilFoolsOpenTowerDungeonDialog = function(self, notification)
  -- function num : 0_27 , upvalues : ProcessNumber, FloorType
  if notification.userInfo then
    self._canShowItemGottenProcessNumberCount = 0
    self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.None]
    self:IsShow(false)
  else
    self:IsShow(true)
  end
end

AprilFoolsTowerMainDialog.OnAprilFoolsOpenTowerShopDialog = function(self, notification)
  -- function num : 0_28
  if notification.userInfo then
    self:IsShow(false)
  else
    self:IsShow(true)
  end
end

AprilFoolsTowerMainDialog.OnSOpenFoolsDayActivity = function(self)
  -- function num : 0_29
  self:RefreshCharInfo()
  self:RefreshFloor()
end

AprilFoolsTowerMainDialog.OnRefreshMoney = function(self)
  -- function num : 0_30 , upvalues : _ENV, CClownSpecialCfg
  self._moneyList = {}
  ;
  (table.insert)(self._moneyList, tonumber((CClownSpecialCfg:GetRecorder(4)).Value))
  ;
  (table.insert)(self._moneyList, tonumber((CClownSpecialCfg:GetRecorder(5)).Value))
  ;
  (self._moneyFrame):ReloadAllCell()
  self:RefreshCharInfo()
end

AprilFoolsTowerMainDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_31
  if (notification.userInfo)._dialogName == "gacha.gacharesultdialog" then
    (self._rootWindow):SetActive(true)
  end
end

AprilFoolsTowerMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_32
  if frame == self._towerFrame then
    return #self._floorList
  else
    if frame == self._moneyFrame then
      return #self._moneyList
    end
  end
end

AprilFoolsTowerMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_33
  if frame == self._towerFrame then
    return "activity.aprilfoolsday.aprilfoolstowerfloorcell"
  else
    if frame == self._moneyFrame then
      return "activity.aprilfoolsday.aprilfoolsmoneynumcell"
    end
  end
end

AprilFoolsTowerMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_34
  if frame == self._towerFrame then
    return (self._floorList)[index]
  else
    if frame == self._moneyFrame then
      return (self._moneyList)[index]
    end
  end
end

AprilFoolsTowerMainDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_35
  if frame == self._towerFrame and self._towerTotalLength then
    self._backFrameCurPos = self._towerTotalLength * (1 - proportion) / self._changeBackGroundTotalLength * self._changeTotalLength
    if self._changeTotalLength < self._backFrameCurPos then
      self._backFrameCurPos = self._changeTotalLength
    end
    ;
    (self._backFrame):SetPosition(self._backImgPosX, self._backImgPosOX, 0, -self._backFrameCurPos)
  end
end

AprilFoolsTowerMainDialog.AddNewModal = function(self, dialog)
  -- function num : 0_36
  if dialog._dialogName == "gacha.gacharesultdialog" then
    (self._rootWindow):SetActive(false)
  else
    ;
    (self._rootWindow):SetActive(true)
  end
end

return AprilFoolsTowerMainDialog

