local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CTowerfloorCfg = BeanManager.GetTableByName("activity.ctowerfloorcfg")
local CMonster_Handbook = BeanManager.GetTableByName("handbook.cmonster_handbook")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CClownSpecialCfg = BeanManager.GetTableByName("activity.cclownspecialcfg")
local CClownRoleLevelUp = BeanManager.GetTableByName("activity.cclownrolelevelup")
local CClownEquip = BeanManager.GetTableByName("activity.cclownequip")
local CClownRole = BeanManager.GetTableByName("activity.cclownrole")
local SUnlockFoolsDaysFunctionDef = LuaNetManager.GetProtocolDef("protocol.activity.sunlockfoolsdaysfunction")
local SReceiveActivtyItemDef = LuaNetManager.GetProtocolDef("protocol.activity.sreceiveactivtyitem")
local CStartFoolsDayBattleDef = LuaNetManager.GetProtocolDef("protocol.activity.cstartfoolsdaybattle")
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local AprilFoolsTowerMainDialog = class("AprilFoolsTowerMainDialog", Dialog)
AprilFoolsTowerMainDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerMainDialog.AssetName = "ActivityAprilFoolsTower"
local FloorType = {
  None = 0,
  Box = 1,
  Story = 2,
  Battle = 3,
  Boss = 4
}
local charNumber = 3
local ProcessNumber = {
  [FloorType.None] = 0,
  [FloorType.Box] = 2,
  [FloorType.Story] = 2,
  [FloorType.Battle] = 3,
  [FloorType.Boss] = 3
}

function AprilFoolsTowerMainDialog:Ctor(...)
  AprilFoolsTowerMainDialog.super.Ctor(self, ...)
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
  self._charLevelUpNeedItemId = tonumber(CClownSpecialCfg:GetRecorder(3).Value)
  self._changeBackGroundFloorId = tonumber(CClownSpecialCfg:GetRecorder(9).Value)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID)
end

function AprilFoolsTowerMainDialog:OnCreate()
  self._backFrame = self:GetChild("BackFrame")
  self._towerPanel = self:GetChild("Frame")
  self._backBtn = self:GetChild("BackBtn")
  self._titleTxt = self:GetChild("Title")
  self._goBtn = self:GetChild("GoBtn")
  self._goBtnTxt = self:GetChild("GoBtn/text")
  self._shopBtn = self:GetChild("ShopBtn")
  self._char = {}
  for i = 1, charNumber do
    self._char[i] = {}
    self._char[i].panel = self:GetChild("CharCell" .. tostring(i))
    self._char[i].level = self:GetChild("CharCell" .. tostring(i) .. "/Level")
    self._char[i].headImg = self:GetChild("CharCell" .. tostring(i) .. "/HeadPhoto")
    self._char[i].healthTxt = self:GetChild("CharCell" .. tostring(i) .. "/Health/HealthNum")
    self._char[i].attackTxt = self:GetChild("CharCell" .. tostring(i) .. "/Attack/AttackNum")
    self._char[i].redDot = self:GetChild("CharCell" .. tostring(i) .. "/Dot")
    self._char[i].panel:Subscribe_PointerClickEvent(function()
      self:OnCharPanelClicked(i)
    end, self)
  end
  self._storyUI = {}
  self._storyUI.panel = self:GetChild("ActivityAprilFoolsStory")
  self._storyUI.panelAnimator = AnimatorStaticFunctions.Get(self._storyUI.panel._uiObject)
  self._storyUI.btn = self:GetChild("ActivityAprilFoolsStory/Checkbtn")
  self._storyUI.btnTxt = self:GetChild("ActivityAprilFoolsStory/Checkbtn/Text")
  self._storyUI.name = self:GetChild("ActivityAprilFoolsStory/Name")
  self._storyUI.typeImg = self:GetChild("ActivityAprilFoolsStory/Item")
  self._storyUI.detail = self:GetChild("ActivityAprilFoolsStory/Title")
  self._battleUI = {}
  self._battleUI.panel = self:GetChild("ActivityAprilFoolsbattle")
  self._battleUI.panelAnimator = AnimatorStaticFunctions.Get(self._battleUI.panel._uiObject)
  self._battleUI.title = self:GetChild("ActivityAprilFoolsbattle/Name/text")
  self._battleUI.detail = self:GetChild("ActivityAprilFoolsbattle/LevelTxt")
  self._battleUI.model = self:GetChild("ActivityAprilFoolsbattle/Model")
  local modelPivotX, modelPivotY = self._battleUI.model:GetPivotPosition()
  local modelRectSizeX, modelRectSizeY = self._battleUI.model:GetRectSize()
  self._battleUI.modelPivotDeltaX = modelRectSizeX * modelPivotX
  self._battleUI.modelPivotDeltaY = modelRectSizeY * modelPivotY
  self._battleUI.modelPosX, self._battleUI.modelPosOX, self._battleUI.modelPosY, self._battleUI.modelPosOY = self._battleUI.model:GetPosition()
  self._battleUI.typeImg = self:GetChild("ActivityAprilFoolsbattle/Item")
  self._battleUI.attackNumTxt = self:GetChild("ActivityAprilFoolsbattle/Attack/AttackNum")
  self._battleUI.healthNumTxt = self:GetChild("ActivityAprilFoolsbattle/Health/HealthNum")
  self._battleUI.btn = self:GetChild("ActivityAprilFoolsbattle/Checkbtn")
  self._battleUI.btnTxt = self:GetChild("ActivityAprilFoolsbattle/Checkbtn/Text")
  self._dungeonBattleBtn = self:GetChild("BattleBtn")
  self._dungeonBattleBtnTxt = self:GetChild("BattleBtn/Text")
  self._shopBtn = self:GetChild("ShopBtn")
  self._shopBtnTxt = self:GetChild("ShopBtn/Text")
  self._tipsBtn = self:GetChild("Tips")
  self._topGroup = self:GetChild("TopGroup")
  self._finish = self:GetChild("Finish")
  self._finish:SetActive(false)
  self._towerFrame = TableFrame.Create(self._towerPanel, self, true, true, false)
  self._moneyFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._storyUI.btn:Subscribe_PointerClickEvent(self.OnStoryBtnClicked, self)
  self._battleUI.btn:Subscribe_PointerClickEvent(self.OnBattleBtnClicked, self)
  self._dungeonBattleBtn:Subscribe_PointerClickEvent(self.OnDungeonBattleBtnClicked, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._finish:Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSEnterNextFloor, Common.n_AprilFoolsSEnterNextFloor, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSCompleteFloor, Common.n_AprilFoolsSCompleteFloor, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSRefreshFoolsDaySingleRole, Common.n_AprilFoolsSRefreshFoolsDaySingleRole, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSEndFoolsDayBattle, Common.n_AprilFoolsSEndFoolsDayBattle, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsClientBattleProcessOver, Common.n_AprilFoolsClientBattleProcessOver, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSUnlockFoolsDaysFunction, Common.n_AprilFoolsSUnlockFoolsDaysFunction, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSReceiveActivtyItem, Common.n_SReceiveActivtyItem, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSAddNewFoolsDayRole, Common.n_AprilFoolsSAddNewFoolsDayRole, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsOpenTowerDungeonDialog, Common.n_AprilFoolsOpenTowerDungeonDialog, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsOpenTowerShopDialog, Common.n_AprilFoolsOpenTowerShopDialog, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSOpenFoolsDayActivity, Common.n_SOpenFoolsDayActivity, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  self._backImgWidth, self._backImgHeight = self._backFrame:GetRectSize()
  self._backImgPosX, self._backImgPosOX = self._backFrame:GetPosition()
  self._screenWidth, self._screenHeight = self:GetRootWindow():GetRectSize()
  self._changeTotalLength = self._backImgHeight - self._screenHeight
  if self._changeTotalLength < 0 then
    self._changeTotalLength = 0
  end
  local anchorMinX, anchorMinY, anchorMaxX, anchorMaxY = self._backFrame:GetAnchor()
  self._backFrame:SetAnchor(anchorMinX, 0, anchorMaxX, 0)
  self._backFrame:SetPivotPosition(0, 0)
  self:Init()
end

function AprilFoolsTowerMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._towerFrame then
    self._towerFrame:Destroy()
    self._towerFrame = nil
  end
  if self._battleUI_Model_handler ~= 0 then
    self._battleUI.model:ReleaseModel(self._battleUI_Model_handler)
    self._battleUI_Model_handler = 0
  end
  if self._moneyFrame then
    self._moneyFrame:Destroy()
    self._moneyFrame = nil
  end
end

function AprilFoolsTowerMainDialog:Init()
  self._titleTxt:SetText(TextManager.GetText(CStringres:GetRecorder(1772).msgTextID))
  self._goBtnTxt:SetText(TextManager.GetText(CStringres:GetRecorder(1774).msgTextID))
  self._dungeonBattleBtnTxt:SetText(TextManager.GetText(CStringres:GetRecorder(1775).msgTextID))
  self._shopBtnTxt:SetText(TextManager.GetText(CStringres:GetRecorder(1776).msgTextID))
  self._floorList = {}
  self._currentFloorId = self._bm:GetGardenPartyCurrentFloorId()
  self._currentFloorState = self._bm:GetGardenPartyCurrentFloorState()
  self._shopBtn:SetActive(self._bm:IfGardenPartyShopUnlock())
  self._dungeonBattleBtn:SetActive(self._bm:IfGardenPartyDungeonBattleUnlock())
  local record, state
  for _, id in ipairs(CTowerfloorCfg:GetAllIds()) do
    record = CTowerfloorCfg:GetRecorder(id)
    state = self._dm.TowerFloorStateType.Untraveled
    if id == self._currentFloorId then
      state = self._currentFloorState
    elseif id < self._currentFloorId then
      state = self._dm.TowerFloorStateType.Finish
    end
    table.insert(self._floorList, {
      floorId = id,
      floorType = record.type,
      parameter = record.parameter,
      handbookid = record.handbookid,
      enemyHP = record.enemyHP,
      enemyATK = record.enemyATK,
      eventname = record.eventname,
      eventtext = record.eventtext,
      eventimg = record.eventimg,
      worldimg = record.worldimg,
      btntext = record.btntext,
      state = state,
      scale = record.scale,
      position = record.position
    })
  end
  self._towerFrame:ReloadAllCell()
  self._towerFrame:SetSoftMaskActive(false)
  self._towerTotalLength = self._towerFrame:GetTotalLength()
  self._changeBackGroundTotalLength = self._towerTotalLength * (self._changeBackGroundFloorId / #self._floorList)
  self._backFrameCurPos = 0
  self._charList = self._bm:GetGardenPartyRoleList()
  self:RefreshCharInfo()
  self:RefreshFloor()
  self:OnRefreshMoney()
end

function AprilFoolsTowerMainDialog:RefreshCharInfo()
  for i = 1, charNumber do
    self._char[i].panel:SetActive(false)
  end
  local str = TextManager.GetText(CStringres:GetRecorder(1773).msgTextID)
  local role, image
  local needNum = 0
  local currentNum = 0
  local redDotShow = false
  local record
  for i, char in ipairs(self._charList) do
    self._char[i].panel:SetActive(true)
    self._char[i].level:SetText(string.gsub(str, "%$parameter1%$", char.roleLv))
    role = Role.Create(char.roleId)
    image = role:GetDiamondHeadImageRecord()
    self._char[i].headImg:SetSprite(image.assetBundle, image.assetName)
    self._char[i].healthTxt:SetText(char.blood)
    self._char[i].attackTxt:SetText(char.attack)
    currentNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._charLevelUpNeedItemId)
    needNum = CClownRoleLevelUp:GetRecorder(char.roleLv).neednum
    redDotShow = currentNum >= needNum and 0 < needNum
    for _, id in ipairs(CClownEquip:GetAllIds()) do
      record = CClownEquip:GetRecorder(id)
      if record.equipid == char.equipid and record.level == char.weaponLv then
        break
      end
    end
    if not record then
      LogErrorFormat("AprilFoolsTowerMainDialog", "no record in cclownequip with equipid %s level %s", char.equipid, char.weaponLv)
      return
    end
    currentNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(record.itemid)
    needNum = record.itemnum
    redDotShow = redDotShow or currentNum >= needNum and 0 < needNum
    redDotShow = redDotShow and self._bm:IsGardenPartyTowerAndDungeonOpen()
    record = nil
    self._char[i].redDot:SetActive(redDotShow)
  end
end

function AprilFoolsTowerMainDialog:RefreshFloor(moveShowAnimation)
  if self._currentFloorState == self._dm.TowerFloorStateType.Going then
    self._goBtn:SetActive(false)
    self._storyUI.panel:SetActive(false)
    self._battleUI.panel:SetActive(false)
    if self._currentFloorId == 1 then
      self:OnStoryBtnClicked()
    elseif self._floorList[self._currentFloorId].floorType == FloorType.Box or self._floorList[self._currentFloorId].floorType == FloorType.Story then
      self._storyUI.panel:SetActive(self._bm:IsGardenPartyTowerAndDungeonOpen())
      self._storyUI.panelAnimator:SetTrigger("Into")
      self._storyUI.btnTxt:SetText(TextManager.GetText(self._floorList[self._currentFloorId].btntext))
      self._storyUI.detail:SetText(TextManager.GetText(self._floorList[self._currentFloorId].eventtext))
      self._storyUI.name:SetText(TextManager.GetText(self._floorList[self._currentFloorId].eventname))
      local imageRecord = CImagePath:GetRecorder(self._floorList[self._currentFloorId].eventimg) or DataCommon.DefaultImageAsset
      self._storyUI.typeImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    elseif self._floorList[self._currentFloorId].floorType == FloorType.Battle or self._floorList[self._currentFloorId].floorType == FloorType.Boss then
      self._battleUI.panel:SetActive(self._bm:IsGardenPartyTowerAndDungeonOpen())
      self._battleUI.panelAnimator:SetTrigger("Into")
      local record = CMonster_Handbook:GetRecorder(self._floorList[self._currentFloorId].handbookid)
      local npcShapeRecorder = CNPCShape:GetRecorder(record.shapeID)
      if self._battleUI_Model_handler ~= 0 then
        self._battleUI.model:ReleaseModel(self._battleUI_Model_handler)
        self._battleUI_Model_handler = 0
      end
      self._battleUI_Model_handler = self._battleUI.model:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
      local scale = self._floorList[self._currentFloorId].scale
      self._battleUI.model:SetLocalScale(scale, scale, scale)
      local posLs = string.split(self._floorList[self._currentFloorId].position, ";")
      if 1 < #posLs then
        self._battleUI.model:SetPosition(self._battleUI.modelPosX, tonumber(posLs[1]) - self._battleUI.modelPivotDeltaX, self._battleUI.modelPosY, tonumber(posLs[2]) - self._battleUI.modelPivotDeltaY)
      end
      self._battleUI.attackNumTxt:SetText(self._floorList[self._currentFloorId].enemyATK)
      self._battleUI.healthNumTxt:SetText(self._floorList[self._currentFloorId].enemyHP)
      self._battleUI.btnTxt:SetText(TextManager.GetText(self._floorList[self._currentFloorId].btntext))
      self._battleUI.detail:SetText(TextManager.GetText(self._floorList[self._currentFloorId].eventtext))
      self._battleUI.title:SetText(TextManager.GetText(self._floorList[self._currentFloorId].eventname))
      local imageRecord = CImagePath:GetRecorder(self._floorList[self._currentFloorId].eventimg) or DataCommon.DefaultImageAsset
      self._battleUI.typeImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  elseif self._currentFloorState == self._dm.TowerFloorStateType.Finish then
    if self._floorList[self._currentFloorId].floorType == FloorType.Boss then
      self._goBtn:SetActive(false)
    else
      self._goBtn:SetActive(self._bm:IsGardenPartyTowerAndDungeonOpen())
    end
    self._storyUI.panel:SetActive(false)
    self._battleUI.panel:SetActive(false)
  else
    LogErrorFormat("AprilFoolsTowerMainDialog", "currentstate %s wrong (should be 0/1)", self._currentFloorState)
  end
  local moveToIndex = self._currentFloorId
  if 1 < moveToIndex then
    moveToIndex = moveToIndex - 1
  end
  self._towerFrame:MoveDownToIndex(moveToIndex, moveShowAnimation)
end

function AprilFoolsTowerMainDialog:OnCharPanelClicked(index)
  DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolstowercharacterinfodialog"):SetData(self._charList[index])
end

function AprilFoolsTowerMainDialog:OnGoBtnClicked()
  if self._bm:IsGardenPartyTowerAndDungeonOpen() then
    if not self._sendEnterNextFloorProtocol then
      local csend = LuaNetManager.CreateProtocol("protocol.activity.centernextfloor")
      csend:Send()
      self._sendEnterNextFloorProtocol = true
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100452)
  end
end

function AprilFoolsTowerMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function AprilFoolsTowerMainDialog:OnStoryBtnClicked()
  if self._bm:IsGardenPartyTowerAndDungeonOpen() then
    if self._floorList[self._currentFloorId].floorType == FloorType.Box then
      self._completeRefreshFloor = true
      self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.Box]
      self._canShowItemGottenProcessNumberCount = 0
      self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.Box]
      self._canShowNewCharProcessNumberCount = 0
      self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.Box]
      self._canShowFuncUnlockProcessNumberCount = 0
      local csend = LuaNetManager.CreateProtocol("protocol.activity.copenfloorbox")
      csend.floorId = self._currentFloorId
      csend:Send()
    elseif self._floorList[self._currentFloorId].floorType == FloorType.Story then
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        dialog:SetDialogLibraryId(self._floorList[self._currentFloorId].parameter, false, dialog.DialogType.AprilFools)
      end
      self._completeRefreshFloor = false
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100452)
  end
end

function AprilFoolsTowerMainDialog:SendBattleProtocol(floorType)
  if not self._sendStartBattleProtocol then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cstartfoolsdaybattle")
    self._battleData = self._floorList[self._currentFloorId]
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

function AprilFoolsTowerMainDialog:OnBattleBtnClicked()
  if self._bm:IsGardenPartyTowerAndDungeonOpen() then
    self._completeRefreshFloor = false
    if self._floorList[self._currentFloorId].floorType == FloorType.Boss then
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        dialog:SetDialogLibraryId(self._floorList[self._currentFloorId].parameter, false, dialog.DialogType.AprilFools)
      end
    elseif self._floorList[self._currentFloorId].floorType == FloorType.Battle then
      self:SendBattleProtocol(FloorType.Battle)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100452)
  end
end

function AprilFoolsTowerMainDialog:OnDungeonBattleBtnClicked()
  if self._bm:IsGardenPartyTowerAndDungeonOpen() then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.copenfoolscopybattle")
    csend:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100452)
  end
end

function AprilFoolsTowerMainDialog:OnShopBtnClicked()
  if self._bm:IfGardenPartyBlueShopUnlock() then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    protocol.shopId = DataCommon.AprilFoolsDayActivity.Shop.BlueClownShopID
    protocol:Send()
  end
  if self._bm:IfGardenPartyRedShopUnlock() then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    protocol.shopId = DataCommon.AprilFoolsDayActivity.Shop.RedClownShopID
    protocol:Send()
  end
  DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolstowershopmaindialog")
end

function AprilFoolsTowerMainDialog:OnTipsBtnClicked()
  DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsdaytipsdialog"):SetData(CStringres:GetRecorder(1836).msgTextID, CStringres:GetRecorder(1837).msgTextID)
end

function AprilFoolsTowerMainDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "towerfinish" then
    self._finish:SetActive(false)
  end
end

function AprilFoolsTowerMainDialog:OnAprilFoolsSEnterNextFloor(notification)
  self._sendEnterNextFloorProtocol = false
  local lastFloorId = self._currentFloorId
  self._currentFloorId = self._bm:GetGardenPartyCurrentFloorId()
  self._towerFrame:FireEvent("RefreshModel", self._currentFloorId)
  self._currentFloorState = self._bm:GetGardenPartyCurrentFloorState()
  LogInfoFormat("AprilFoolsTowerMainDialog", "last floorid %s enter floorid %s == ctowerfloorcfg id %s? currentstate %s", lastFloorId, self._currentFloorId, self._floorList[self._currentFloorId].floorId, self._currentFloorState)
  self._floorList[self._currentFloorId].state = self._currentFloorState
  self:RefreshFloor(true)
end

function AprilFoolsTowerMainDialog:OnAprilFoolsSCompleteFloor(notification)
  self._sendCompleteFloorProtocol = false
  local lastFloorId = self._currentFloorId
  self._currentFloorId = self._bm:GetGardenPartyCurrentFloorId()
  self._towerFrame:FireEvent("RefreshModel", self._currentFloorId)
  self._currentFloorState = self._bm:GetGardenPartyCurrentFloorState()
  LogInfoFormat("AprilFoolsTowerMainDialog", "last floorid %s complete floorid %s == ctowerfloorcfg id %s? currentstate %s", lastFloorId, self._currentFloorId, self._floorList[self._currentFloorId].floorId, self._currentFloorState)
  self._floorList[self._currentFloorId].state = self._currentFloorState
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
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.AprilFoolsDayActivityItems,
      data = self._bm:GetGardenPartyGottenItemList()
    })
  end
  self._canShowNewCharProcessNumberCount = self._canShowNewCharProcessNumberCount + 1
  if self._canShowNewCharProcessNumberCount == self._canShowNewCharProcessNumberNeed then
    self._canShowNewCharProcessNumberCount = 0
    self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.None]
    local dialog = DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
    if dialog then
      dialog:SetData(dialog.ShowDialogType.Role, self._newCharId)
    end
    self._newCharId = nil
  end
  self._canShowFuncUnlockProcessNumberCount = self._canShowFuncUnlockProcessNumberCount + 1
  if self._canShowFuncUnlockProcessNumberCount == self._canShowFuncUnlockProcessNumberNeed then
    self._canShowFuncUnlockProcessNumberCount = 0
    self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.None]
    self:OpenUnlockFunctionDialog()
  end
end

function AprilFoolsTowerMainDialog:OnAprilFoolsSRefreshFoolsDaySingleRole(notification)
  self._charList = self._bm:GetGardenPartyRoleList()
  self:RefreshCharInfo()
end

function AprilFoolsTowerMainDialog:OnNPCChatEnd(notification)
  if notification.userInfo == self._floorList[self._currentFloorId].parameter then
    if self._floorList[self._currentFloorId].floorType == FloorType.Boss then
      self:SendBattleProtocol(FloorType.Boss)
    elseif not self._sendCompleteFloorProtocol then
      self._sendCompleteFloorProtocol = true
      self._completeRefreshFloor = true
      self._canShowItemGottenProcessNumberNeed = ProcessNumber[self._floorList[self._currentFloorId].floorType]
      self._canShowItemGottenProcessNumberCount = 0
      self._canShowNewCharProcessNumberNeed = ProcessNumber[self._floorList[self._currentFloorId].floorType]
      self._canShowNewCharProcessNumberCount = 0
      self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[self._floorList[self._currentFloorId].floorType]
      self._canShowFuncUnlockProcessNumberCount = 0
      local csend = LuaNetManager.CreateProtocol("protocol.activity.ccompletefloor")
      csend.floorId = self._currentFloorId
      csend:Send()
    end
  end
end

function AprilFoolsTowerMainDialog:OnAprilFoolsSEndFoolsDayBattle(notification)
  if notification.userInfo.battleType == CStartFoolsDayBattleDef.FLOOR then
    self._sendStartBattleProtocol = false
    self._battleResult = notification.userInfo.result
    LogInfoFormat("AprilFoolsTowerMainDialog", "server battle result %s", notification.userInfo.result)
    DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolstowerbattledialog"):SetData(notification.userInfo.result, self._battleData)
  end
end

function AprilFoolsTowerMainDialog:OnAprilFoolsClientBattleProcessOver(notification)
  local ResultType = {Success = 1, Failed = 0}
  if self._battleResult == ResultType.Success then
    if self._floorList[self._currentFloorId].floorType == FloorType.Boss then
      self._finish:SetActive(true)
      self._finish:SetAnimatorTrigger("End")
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
      NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
        tag = DataCommon.ShowDialogType.AprilFoolsDayActivityItems,
        data = self._bm:GetGardenPartyGottenItemList()
      })
    end
    self._canShowNewCharProcessNumberCount = self._canShowNewCharProcessNumberCount + 1
    if self._canShowNewCharProcessNumberCount == self._canShowNewCharProcessNumberNeed then
      self._canShowNewCharProcessNumberCount = 0
      self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.None]
      local dialog = DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
      if dialog then
        dialog:SetData(dialog.ShowDialogType.Role, self._newCharId)
      end
      self._newCharId = nil
    end
    self._canShowFuncUnlockProcessNumberCount = self._canShowFuncUnlockProcessNumberCount + 1
    if self._canShowFuncUnlockProcessNumberCount == self._canShowFuncUnlockProcessNumberNeed then
      self._canShowFuncUnlockProcessNumberCount = 0
      self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.None]
      self:OpenUnlockFunctionDialog()
    end
  end
end

function AprilFoolsTowerMainDialog:OnAprilFoolsSUnlockFoolsDaysFunction(notification)
  if notification.userInfo.functionId == SUnlockFoolsDaysFunctionDef.RED_CLOWN and self._bm:IfGardenPartyBlueShopUnlock() or notification.userInfo.functionId == SUnlockFoolsDaysFunctionDef.BLUE_CLOWN and self._bm:IfGardenPartyRedShopUnlock() then
    return
  end
  self._unlockFunctionId = notification.userInfo.functionId
  self._canShowFuncUnlockProcessNumberCount = self._canShowFuncUnlockProcessNumberCount + 1
  if self._canShowFuncUnlockProcessNumberCount == self._canShowFuncUnlockProcessNumberNeed then
    self._canShowFuncUnlockProcessNumberCount = 0
    self._canShowFuncUnlockProcessNumberNeed = ProcessNumber[FloorType.None]
    self:OpenUnlockFunctionDialog()
  end
end

function AprilFoolsTowerMainDialog:OpenUnlockFunctionDialog()
  if self._unlockFunctionId == SUnlockFoolsDaysFunctionDef.RED_CLOWN or self._unlockFunctionId == SUnlockFoolsDaysFunctionDef.BLUE_CLOWN then
    self._shopBtn:SetActive(true)
    local dialog = DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
    if dialog then
      dialog:SetData(dialog.ShowDialogType.ShopUnlock)
    end
  elseif self._unlockFunctionId == SUnlockFoolsDaysFunctionDef.COPY_BATTLE then
    self._dungeonBattleBtn:SetActive(true)
    local dialog = DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
    if dialog then
      dialog:SetData(dialog.ShowDialogType.DungeonUnlock)
    end
  end
  self._unlockFunctionId = nil
end

function AprilFoolsTowerMainDialog:OnSReceiveActivtyItem(notification)
  if notification.userInfo.activityLineId == SReceiveActivtyItemDef.FOOLSDAY then
    self._canShowItemGottenProcessNumberCount = self._canShowItemGottenProcessNumberCount + 1
    if self._canShowItemGottenProcessNumberCount == self._canShowItemGottenProcessNumberNeed then
      self._canShowItemGottenProcessNumberCount = 0
      self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.None]
      NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
        tag = DataCommon.ShowDialogType.AprilFoolsDayActivityItems,
        data = self._bm:GetGardenPartyGottenItemList()
      })
    end
  end
end

function AprilFoolsTowerMainDialog:OnAprilFoolsSAddNewFoolsDayRole(notification)
  local record = CClownRole:GetRecorder(notification.userInfo.Id)
  if record then
    self._newCharId = record.roleid
  else
    LogErrorFormat("AprilFoolsTowerMainDialog", "CClownRole dont have id %s", notification.userInfo.Id)
    return
  end
  self._canShowNewCharProcessNumberCount = self._canShowNewCharProcessNumberCount + 1
  if self._canShowNewCharProcessNumberCount == self._canShowNewCharProcessNumberNeed then
    self._canShowNewCharProcessNumberCount = 0
    self._canShowNewCharProcessNumberNeed = ProcessNumber[FloorType.None]
    local dialog = DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
    if dialog then
      dialog:SetData(dialog.ShowDialogType.Role, self._newCharId)
    end
    self._newCharId = nil
  end
end

function AprilFoolsTowerMainDialog:IsShow(flag)
  self._backBtn:SetActive(flag)
  self._titleTxt:SetActive(flag)
  self._tipsBtn:SetActive(flag)
  self._topGroup:SetActive(flag)
  if self._currentFloorState == self._dm.TowerFloorStateType.Going then
    self._storyUI.panel:SetActive(false)
    self._battleUI.panel:SetActive(false)
    if self._floorList[self._currentFloorId].floorType == FloorType.Box or self._floorList[self._currentFloorId].floorType == FloorType.Story then
      self._storyUI.panel:SetActive(self._bm:IsGardenPartyTowerAndDungeonOpen() and flag)
    elseif self._floorList[self._currentFloorId].floorType == FloorType.Battle or self._floorList[self._currentFloorId].floorType == FloorType.Boss then
      self._battleUI.panel:SetActive(self._bm:IsGardenPartyTowerAndDungeonOpen() and flag)
    end
  elseif self._currentFloorState == self._dm.TowerFloorStateType.Finish then
    self._storyUI.panel:SetActive(false)
    self._battleUI.panel:SetActive(false)
  end
end

function AprilFoolsTowerMainDialog:OnAprilFoolsOpenTowerDungeonDialog(notification)
  if notification.userInfo then
    self._canShowItemGottenProcessNumberCount = 0
    self._canShowItemGottenProcessNumberNeed = ProcessNumber[FloorType.None]
    self:IsShow(false)
  else
    self:IsShow(true)
  end
end

function AprilFoolsTowerMainDialog:OnAprilFoolsOpenTowerShopDialog(notification)
  if notification.userInfo then
    self:IsShow(false)
  else
    self:IsShow(true)
  end
end

function AprilFoolsTowerMainDialog:OnSOpenFoolsDayActivity()
  self:RefreshCharInfo()
  self:RefreshFloor()
end

function AprilFoolsTowerMainDialog:OnRefreshMoney()
  self._moneyList = {}
  table.insert(self._moneyList, tonumber(CClownSpecialCfg:GetRecorder(4).Value))
  table.insert(self._moneyList, tonumber(CClownSpecialCfg:GetRecorder(5).Value))
  self._moneyFrame:ReloadAllCell()
  self:RefreshCharInfo()
end

function AprilFoolsTowerMainDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "gacha.gacharesultdialog" then
    self._rootWindow:SetActive(true)
  end
end

function AprilFoolsTowerMainDialog:NumberOfCell(frame)
  if frame == self._towerFrame then
    return #self._floorList
  elseif frame == self._moneyFrame then
    return #self._moneyList
  end
end

function AprilFoolsTowerMainDialog:CellAtIndex(frame, index)
  if frame == self._towerFrame then
    return "activity.aprilfoolsday.aprilfoolstowerfloorcell"
  elseif frame == self._moneyFrame then
    return "activity.aprilfoolsday.aprilfoolsmoneynumcell"
  end
end

function AprilFoolsTowerMainDialog:DataAtIndex(frame, index)
  if frame == self._towerFrame then
    return self._floorList[index]
  elseif frame == self._moneyFrame then
    return self._moneyList[index]
  end
end

function AprilFoolsTowerMainDialog:OnCurPosChange(frame, proportion)
  if frame == self._towerFrame and self._towerTotalLength then
    self._backFrameCurPos = self._towerTotalLength * (1 - proportion) / self._changeBackGroundTotalLength * self._changeTotalLength
    if self._backFrameCurPos > self._changeTotalLength then
      self._backFrameCurPos = self._changeTotalLength
    end
    self._backFrame:SetPosition(self._backImgPosX, self._backImgPosOX, 0, -self._backFrameCurPos)
  end
end

function AprilFoolsTowerMainDialog:AddNewModal(dialog)
  if dialog._dialogName == "gacha.gacharesultdialog" then
    self._rootWindow:SetActive(false)
  else
    self._rootWindow:SetActive(true)
  end
end

return AprilFoolsTowerMainDialog
