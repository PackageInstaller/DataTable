local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CClownDungeo = BeanManager.GetTableByName("activity.cclowndungeo")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CMonster_Handbook = BeanManager.GetTableByName("handbook.cmonster_handbook")
local CClownSpecialCfg = BeanManager.GetTableByName("activity.cclownspecialcfg")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CClownDungeonRefresh = BeanManager.GetTableByName("activity.cclowndungeonrefresh")
local SReceiveActivtyItemDef = LuaNetManager.GetProtocolDef("protocol.activity.sreceiveactivtyitem")
local CStartFoolsDayBattleDef = LuaNetManager.GetProtocolDef("protocol.activity.cstartfoolsdaybattle")
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local AprilFoolsTowerDungeonDialog = class("AprilFoolsTowerDungeonDialog", Dialog)
AprilFoolsTowerDungeonDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerDungeonDialog.AssetName = "ActivityAprilFoolsDungeon"
local dungeonNumber = 3

function AprilFoolsTowerDungeonDialog:Ctor(...)
  AprilFoolsTowerDungeonDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._sendStartBattleProtocol = false
  self._havePlayIntoAnimation = false
  self._canShowItemGotten = false
  self._battleShowOver = false
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID)
end

function AprilFoolsTowerDungeonDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._title = self:GetChild("Title")
  self._battleUI = {}
  self._battleUI.panel = self:GetChild("ActivityAprilFoolsbattle")
  self._battleUI.panel:SetActive(false)
  self._battleUI.levelTxt = self:GetChild("ActivityAprilFoolsbattle/Name/text")
  self._battleUI.title = self:GetChild("ActivityAprilFoolsbattle/Name/Name")
  self._battleUI.model = self:GetChild("ActivityAprilFoolsbattle/Model")
  local modelPivotX, modelPivotY = self._battleUI.model:GetPivotPosition()
  local modelRectSizeX, modelRectSizeY = self._battleUI.model:GetRectSize()
  self._battleUI.modelPivotDeltaX = modelRectSizeX * modelPivotX
  self._battleUI.modelPivotDeltaY = modelRectSizeY * modelPivotY
  self._battleUI.modelPosX, self._battleUI.modelPosOX, self._battleUI.modelPosY, self._battleUI.modelPosOY = self._battleUI.model:GetPosition()
  self._battleUI.attackNumTxt = self:GetChild("ActivityAprilFoolsbattle/Attack/AttackNum")
  self._battleUI.healthNumTxt = self:GetChild("ActivityAprilFoolsbattle/Health/HealthNum")
  self._battleUI.btn = self:GetChild("ActivityAprilFoolsbattle/Checkbtn")
  self._battleUI.btnTxt = self:GetChild("ActivityAprilFoolsbattle/Checkbtn/Text")
  self._battleUI.detail = self:GetChild("ActivityAprilFoolsbattle/LevelTxt")
  self._dungeonFrame = self:GetChild("DungeonBattleFrame")
  self._dungeonCell = {}
  for i = 1, dungeonNumber do
    self._dungeonCell[i] = {}
    self._dungeonCell[i].leftTimeTagTxt = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/Text")
    self._dungeonCell[i].leftTimeTxt = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/Num")
    self._dungeonCell[i].model = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/Model")
    self._dungeonCell[i].name = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/Name")
    self._dungeonCell[i].panel = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i)
    self._dungeonCell[i].addBtn = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/Add")
    self._dungeonCell[i].levelBtn = {}
    self._dungeonCell[i].levelBtnTxt = {}
    self._dungeonCell[i].levelBtn[1] = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/NormalBtn")
    self._dungeonCell[i].levelBtn[2] = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/MediumBtn")
    self._dungeonCell[i].levelBtn[3] = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/HardBtn")
    self._dungeonCell[i].levelBtnTxt[1] = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/NormalBtn/Text")
    self._dungeonCell[i].levelBtnTxt[2] = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/MediumBtn/Text")
    self._dungeonCell[i].levelBtnTxt[3] = self:GetChild("DungeonBattleFrame/ActivityAprilFoolsDungeonBattleCell" .. i .. "/HardBtn/Text")
    self._dungeonCell[i].levelBtn[1]:Subscribe_PointerClickEvent(function()
      self:OnLevelBtnClicked(i, 1)
    end, self)
    self._dungeonCell[i].levelBtn[2]:Subscribe_PointerClickEvent(function()
      self:OnLevelBtnClicked(i, 2)
    end, self)
    self._dungeonCell[i].levelBtn[3]:Subscribe_PointerClickEvent(function()
      self:OnLevelBtnClicked(i, 3)
    end, self)
    self._dungeonCell[i].addBtn:Subscribe_PointerClickEvent(function()
      self:OnAddBtnClicked(i)
    end, self)
  end
  self._topGroup = self:GetChild("TopGroup")
  self._diamondAddBtn = self:GetChild("TopGroup/Num0/Add")
  self._diamondImg = self:GetChild("TopGroup/Num0/Icon")
  self._diamondNumTxt = self:GetChild("TopGroup/Num0/Text")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._battleUI.btn:Subscribe_PointerClickEvent(self.OnBattleBtnClicked, self)
  self._rootWindowAnimator = AnimatorStaticFunctions.Get(self:GetRootWindow()._uiObject)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSRefreshBattlesTimes, Common.n_AprilFoolsSRefreshBattlesTimes, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSEndFoolsDayBattle, Common.n_AprilFoolsSEndFoolsDayBattle, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsClientBattleProcessOver, Common.n_AprilFoolsClientBattleProcessOver, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSReceiveActivtyItem, Common.n_SReceiveActivtyItem, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.PostNotification(Common.n_AprilFoolsOpenTowerDungeonDialog, self, true)
  self:Init()
end

function AprilFoolsTowerDungeonDialog:OnDestroy()
  LuaNotificationCenter.PostNotification(Common.n_AprilFoolsOpenTowerDungeonDialog, self, false)
  LuaNotificationCenter.RemoveObserver(self)
  if self._battleUI_Model_handler ~= 0 then
    self._battleUI.model:ReleaseModel(self._battleUI_Model_handler)
    self._battleUI_Model_handler = 0
  end
  for _, v in ipairs(self._dungeonCell) do
    if v.handler then
      v.model:ReleaseModel(v.handler)
      v.handler = nil
    end
  end
end

function AprilFoolsTowerDungeonDialog:Init()
  self._title:SetText(TextManager.GetText(CStringres:GetRecorder(1775).msgTextID))
  self._battleUI.btnTxt:SetText(TextManager.GetText(701877))
  self._diamondAddBtn:SetActive(false)
  local item = Item.Create(DataCommon.DiamodID)
  local image = item:GetIcon()
  self._diamondImg:SetSprite(image.assetBundle, image.assetName)
  self._diamondNumTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
  local dungeonList = self._bm:GetGardenPartyDungeonBattle()
  local tempRecordList = {}
  local record
  for _, id in ipairs(CClownDungeo:GetAllIds()) do
    record = CClownDungeo:GetRecorder(id)
    tempRecordList[record.dungeontype] = tempRecordList[record.dungeontype] or {}
    tempRecordList[record.dungeontype][record.dungeondifficulty] = record
  end
  self._dungeonList = {}
  local tempDifficulty
  for _, v in ipairs(dungeonList) do
    tempDifficulty = {}
    for _, h in ipairs(v.difficult) do
      table.insert(tempDifficulty, {
        dungeonDifficulty = h,
        handbookid = tempRecordList[v.bossId][h].handbookid,
        enemyHP = tempRecordList[v.bossId][h].enemyHP,
        enemyATK = tempRecordList[v.bossId][h].enemyATK,
        battleId = tempRecordList[v.bossId][h].id,
        dungeondifficultytext = tempRecordList[v.bossId][h].dungeondifficultytext,
        eventtext = tempRecordList[v.bossId][h].eventtext,
        scale = tempRecordList[v.bossId][h].scale,
        position = tempRecordList[v.bossId][h].position
      })
    end
    table.sort(tempDifficulty, function(a, b)
      return a.dungeonDifficulty < b.dungeonDifficulty
    end)
    table.insert(self._dungeonList, {
      dungeonType = v.bossId,
      leftTimes = v.leftTimes,
      dungeonDifficultyList = tempDifficulty,
      dungeonnametext = tempRecordList[v.bossId][v.difficult[1]].dungeonnametext
    })
  end
  self._maxTime = tonumber(CClownSpecialCfg:GetRecorder(2).Value)
  for i = 1, dungeonNumber do
    self._dungeonCell[i].panel:SetActive(false)
  end
  local record, npcShapeRecorder, scale
  for i, v in ipairs(self._dungeonList) do
    if self._dungeonCell[i] then
      self._dungeonCell[i].leftTimeTagTxt:SetText(TextManager.GetText(CStringres:GetRecorder(1788).msgTextID))
      self._dungeonCell[i].panel:SetActive(true)
      self._dungeonCell[i].name:SetText(TextManager.GetText(v.dungeonnametext))
      self._dungeonCell[i].leftTimeTxt:SetText(v.leftTimes .. "/" .. self._maxTime)
      for j, d in ipairs(v.dungeonDifficultyList) do
        self._dungeonCell[i].levelBtn[j]:SetActive(true)
        self._dungeonCell[i].levelBtnTxt[j]:SetText(TextManager.GetText(d.dungeondifficultytext))
      end
      for j = #v.dungeonDifficultyList + 1, 3 do
        self._dungeonCell[i].levelBtn[j]:SetActive(false)
      end
      if v.dungeonDifficultyList[1] then
        record = CMonster_Handbook:GetRecorder(v.dungeonDifficultyList[1].handbookid)
        npcShapeRecorder = CNPCShape:GetRecorder(record.shapeID)
        if self._dungeonCell[i].handler then
          self._dungeonCell[i].model:ReleaseModel(self._dungeonCell[i].handler)
          self._dungeonCell[i].handler = nil
        end
        self._dungeonCell[i].handler = self._dungeonCell[i].model:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
        scale = v.dungeonDifficultyList[1].scale
        self._dungeonCell[i].model:SetLocalScale(scale, scale, scale)
      else
        LogErrorFormat("AprilFoolsTowerDungeonDialog", "(cclowndungeo) dungeontype %s has no dungeonDifficultyList", v.dungeonType)
      end
    else
      LogErrorFormat("AprilFoolsTowerDungeonDialog", "UI dont match SOpenFoolsCopyBattle.battleInfo. Index is %s", i)
    end
  end
end

function AprilFoolsTowerDungeonDialog:OnLevelBtnClicked(dungeonIndex, level)
  if self._dungeonList[dungeonIndex].leftTimes <= 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100464)
    return
  end
  if not self._havePlayIntoAnimation then
    self._battleUI.panel:SetActive(true)
    self._rootWindowAnimator:SetTrigger("Into")
    self._havePlayIntoAnimation = true
  end
  self._currentChooseDungeonIndex = dungeonIndex
  self._currentChooseLevel = level
  self._battleUI.levelTxt:SetText(TextManager.GetText(self._dungeonList[dungeonIndex].dungeonDifficultyList[level].dungeondifficultytext))
  self._battleUI.title:SetText(TextManager.GetText(self._dungeonList[dungeonIndex].dungeonnametext))
  self._battleUI.attackNumTxt:SetText(self._dungeonList[dungeonIndex].dungeonDifficultyList[level].enemyATK)
  self._battleUI.healthNumTxt:SetText(self._dungeonList[dungeonIndex].dungeonDifficultyList[level].enemyHP)
  self._battleUI.detail:SetText(TextManager.GetText(self._dungeonList[dungeonIndex].dungeonDifficultyList[level].eventtext))
  local record = CMonster_Handbook:GetRecorder(self._dungeonList[dungeonIndex].dungeonDifficultyList[level].handbookid)
  local npcShapeRecorder = CNPCShape:GetRecorder(record.shapeID)
  if self._battleUI_Model_handler ~= 0 then
    self._battleUI.model:ReleaseModel(self._battleUI_Model_handler)
    self._battleUI_Model_handler = 0
  end
  self._battleUI_Model_handler = self._battleUI.model:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
  local scale = self._dungeonList[dungeonIndex].dungeonDifficultyList[level].scale
  self._battleUI.model:SetLocalScale(scale, scale, scale)
  local posLs = string.split(self._dungeonList[dungeonIndex].dungeonDifficultyList[level].position, ";")
  if 1 < #posLs then
    self._battleUI.model:SetPosition(self._battleUI.modelPosX, tonumber(posLs[1]) - self._battleUI.modelPivotDeltaX, self._battleUI.modelPosY, tonumber(posLs[2]) - self._battleUI.modelPivotDeltaY)
  end
end

function AprilFoolsTowerDungeonDialog:OnAddBtnClicked(dungeonIndex)
  if self._dungeonList[dungeonIndex].leftTimes < self._maxTime then
    local allIds = CClownDungeonRefresh:GetAllIds()
    local timesNum = self._bm:GetGardenPartyResetConfigTimes()
    if timesNum > #allIds then
      timesNum = #allIds
    end
    local record = CClownDungeonRefresh:GetRecorder(timesNum)
    local item = Item.Create(record.item)
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(136, {
      record.itemnum,
      item:GetName(),
      TextManager.GetText(self._dungeonList[dungeonIndex].dungeonnametext)
    }, function()
      local csend = LuaNetManager.CreateProtocol("protocol.activity.cresetbattlestimes")
      csend.bossId = self._dungeonList[dungeonIndex].dungeonType
      csend:Send()
    end, {}, nil, {})
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100470)
  end
end

function AprilFoolsTowerDungeonDialog:OnBackBtnClicked()
  self:Destroy()
end

function AprilFoolsTowerDungeonDialog:OnBattleBtnClicked()
  if not self._sendStartBattleProtocol then
    local dungeonIndex = self._currentChooseDungeonIndex
    local level = self._currentChooseLevel
    LogInfoFormat("AprilFoolsTowerDungeonDialog", "dungeonindex %s levelindex %s cclowndungeo id %s dungeontype %s dungeondifficulty %s", dungeonIndex, level, self._dungeonList[dungeonIndex].dungeonDifficultyList[level].battleId, self._dungeonList[dungeonIndex].dungeonType, self._dungeonList[dungeonIndex].dungeonDifficultyList[level].dungeonDifficulty)
    if self._dungeonList[dungeonIndex].leftTimes > 0 then
      local csend = LuaNetManager.CreateProtocol("protocol.activity.cstartfoolsdaybattle")
      self._battleData = self._dungeonList[dungeonIndex].dungeonDifficultyList[level]
      self._sendStartBattleProtocol = true
      self._canShowItemGotten = false
      csend.battleType = CStartFoolsDayBattleDef.COPY_BATTLE
      csend.battleId = self._dungeonList[dungeonIndex].dungeonDifficultyList[level].battleId
      csend:Send()
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100464)
    end
  end
end

function AprilFoolsTowerDungeonDialog:OnAprilFoolsSRefreshBattlesTimes(notification)
  for i, v in ipairs(self._dungeonList) do
    if v.dungeonType == notification.userInfo.bossId then
      v.leftTimes = notification.userInfo.leftTimes
      if self._dungeonCell[i] then
        self._dungeonCell[i].leftTimeTxt:SetText(v.leftTimes .. "/" .. self._maxTime)
      end
      break
    end
  end
end

function AprilFoolsTowerDungeonDialog:OnAprilFoolsSEndFoolsDayBattle(notification)
  if notification.userInfo.battleType == CStartFoolsDayBattleDef.COPY_BATTLE then
    self._sendStartBattleProtocol = false
    self._battleResult = notification.userInfo.result
    DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolstowerbattledialog"):SetData(self._battleResult, self._battleData)
  end
end

function AprilFoolsTowerDungeonDialog:OnAprilFoolsClientBattleProcessOver(notification)
  if self._canShowItemGotten then
    self._canShowItemGotten = false
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.AprilFoolsDayActivityItems,
      data = self._bm:GetGardenPartyGottenItemList()
    })
  else
    self._canShowItemGotten = true
  end
end

function AprilFoolsTowerDungeonDialog:OnSReceiveActivtyItem(notification)
  if notification.userInfo.activityLineId == SReceiveActivtyItemDef.FOOLSDAY then
    if self._canShowItemGotten then
      self._canShowItemGotten = false
      NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
        tag = DataCommon.ShowDialogType.AprilFoolsDayActivityItems,
        data = self._bm:GetGardenPartyGottenItemList()
      })
    else
      self._canShowItemGotten = true
    end
  end
end

function AprilFoolsTowerDungeonDialog:OnRefreshMoney()
  self._diamondNumTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
end

return AprilFoolsTowerDungeonDialog
