-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolstowerdungeondialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CClownDungeo = (BeanManager.GetTableByName)("activity.cclowndungeo")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CMonster_Handbook = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CClownSpecialCfg = (BeanManager.GetTableByName)("activity.cclownspecialcfg")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CClownDungeonRefresh = (BeanManager.GetTableByName)("activity.cclowndungeonrefresh")
local SReceiveActivtyItemDef = (LuaNetManager.GetProtocolDef)("protocol.activity.sreceiveactivtyitem")
local CStartFoolsDayBattleDef = (LuaNetManager.GetProtocolDef)("protocol.activity.cstartfoolsdaybattle")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local AprilFoolsTowerDungeonDialog = class("AprilFoolsTowerDungeonDialog", Dialog)
AprilFoolsTowerDungeonDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerDungeonDialog.AssetName = "ActivityAprilFoolsDungeon"
local dungeonNumber = 3
AprilFoolsTowerDungeonDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsTowerDungeonDialog, _ENV
  ((AprilFoolsTowerDungeonDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._sendStartBattleProtocol = false
  self._havePlayIntoAnimation = false
  self._canShowItemGotten = false
  self._battleShowOver = false
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)
end

AprilFoolsTowerDungeonDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : dungeonNumber, AnimatorStaticFunctions, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._title = self:GetChild("Title")
  self._battleUI = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).panel = self:GetChild("ActivityAprilFoolsbattle")
  ;
  ((self._battleUI).panel):SetActive(false)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).levelTxt = self:GetChild("ActivityAprilFoolsbattle/Name/text")
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).title = self:GetChild("ActivityAprilFoolsbattle/Name/Name")
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).model = self:GetChild("ActivityAprilFoolsbattle/Model")
  local modelPivotX, modelPivotY = ((self._battleUI).model):GetPivotPosition()
  local modelRectSizeX, modelRectSizeY = ((self._battleUI).model):GetRectSize()
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPivotDeltaX = modelRectSizeX * modelPivotX
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPivotDeltaY = modelRectSizeY * modelPivotY
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

  -- DECOMPILER ERROR at PC58: Confused about usage of register: R7 in 'UnsetPending'

  -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

  -- DECOMPILER ERROR at PC60: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPosX = ((self._battleUI).model):GetPosition()
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).attackNumTxt = self:GetChild("ActivityAprilFoolsbattle/Attack/AttackNum")
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).healthNumTxt = self:GetChild("ActivityAprilFoolsbattle/Health/HealthNum")
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).btn = self:GetChild("ActivityAprilFoolsbattle/Checkbtn")
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).btnTxt = self:GetChild("ActivityAprilFoolsbattle/Checkbtn/Text")
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).detail = self:GetChild("ActivityAprilFoolsbattle/LevelTxt")
  self._dungeonFrame = self:GetChild("DungeonBattleFrame")
  self._dungeonCell = {}
  for i = 1, dungeonNumber do
    do
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R9 in 'UnsetPending'

      (self._dungeonCell)[i] = {}
      -- DECOMPILER ERROR at PC105: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC107: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._dungeonCell)[i]).leftTimeTagTxt = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC110: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC111: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC114: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC116: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._dungeonCell)[i]).leftTimeTxt = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC119: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC120: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC123: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC125: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._dungeonCell)[i]).model = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC128: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC129: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC132: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC134: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._dungeonCell)[i]).name = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC137: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC138: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC140: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC142: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._dungeonCell)[i]).panel = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC145: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC146: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC149: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC151: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._dungeonCell)[i]).addBtn = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC155: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._dungeonCell)[i]).levelBtn = {}
      -- DECOMPILER ERROR at PC159: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._dungeonCell)[i]).levelBtnTxt = {}
      -- DECOMPILER ERROR at PC163: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC164: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC167: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC169: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._dungeonCell)[i]).levelBtn)[1] = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC173: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC174: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC177: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC179: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._dungeonCell)[i]).levelBtn)[2] = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC183: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC184: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC187: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC189: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._dungeonCell)[i]).levelBtn)[3] = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC193: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC194: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC197: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC199: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._dungeonCell)[i]).levelBtnTxt)[1] = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC203: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC204: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC207: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC209: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._dungeonCell)[i]).levelBtnTxt)[2] = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC213: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC214: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC217: Overwrote pending register: R12 in 'AssignReg'

      -- DECOMPILER ERROR at PC219: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._dungeonCell)[i]).levelBtnTxt)[3] = self:GetChild(R12_PC57)
      -- DECOMPILER ERROR at PC225: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC226: Overwrote pending register: R12 in 'AssignReg'

      ;
      ((((self._dungeonCell)[i]).levelBtn)[1]):Subscribe_PointerClickEvent(R11_PC58, R12_PC57)
      -- DECOMPILER ERROR at PC233: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC234: Overwrote pending register: R12 in 'AssignReg'

      ;
      ((((self._dungeonCell)[i]).levelBtn)[2]):Subscribe_PointerClickEvent(R11_PC58, R12_PC57)
      -- DECOMPILER ERROR at PC241: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC242: Overwrote pending register: R12 in 'AssignReg'

      ;
      ((((self._dungeonCell)[i]).levelBtn)[3]):Subscribe_PointerClickEvent(R11_PC58, R12_PC57)
      -- DECOMPILER ERROR at PC248: Overwrote pending register: R11 in 'AssignReg'

      -- DECOMPILER ERROR at PC249: Overwrote pending register: R12 in 'AssignReg'

      ;
      (((self._dungeonCell)[i]).addBtn):Subscribe_PointerClickEvent(R11_PC58, R12_PC57)
    end
  end
  self._topGroup = self:GetChild("TopGroup")
  self._diamondAddBtn = self:GetChild("TopGroup/Num0/Add")
  self._diamondImg = self:GetChild("TopGroup/Num0/Icon")
  self._diamondNumTxt = self:GetChild("TopGroup/Num0/Text")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  ((self._battleUI).btn):Subscribe_PointerClickEvent(self.OnBattleBtnClicked, self)
  self._rootWindowAnimator = (AnimatorStaticFunctions.Get)((self:GetRootWindow())._uiObject)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSRefreshBattlesTimes, Common.n_AprilFoolsSRefreshBattlesTimes, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSEndFoolsDayBattle, Common.n_AprilFoolsSEndFoolsDayBattle, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsClientBattleProcessOver, Common.n_AprilFoolsClientBattleProcessOver, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSReceiveActivtyItem, Common.n_SReceiveActivtyItem, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_AprilFoolsOpenTowerDungeonDialog, self, true)
  self:Init()
end

AprilFoolsTowerDungeonDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_AprilFoolsOpenTowerDungeonDialog, self, false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._battleUI_Model_handler ~= 0 then
    ((self._battleUI).model):ReleaseModel(self._battleUI_Model_handler)
    self._battleUI_Model_handler = 0
  end
  for _,v in ipairs(self._dungeonCell) do
    if v.handler then
      (v.model):ReleaseModel(v.handler)
      v.handler = nil
    end
  end
end

AprilFoolsTowerDungeonDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringres, Item, CClownDungeo, CClownSpecialCfg, dungeonNumber, CMonster_Handbook, CNPCShape
  (self._title):SetText((TextManager.GetText)((CStringres:GetRecorder(1775)).msgTextID))
  ;
  ((self._battleUI).btnTxt):SetText((TextManager.GetText)(701877))
  ;
  (self._diamondAddBtn):SetActive(false)
  local item = (Item.Create)(DataCommon.DiamodID)
  local image = item:GetIcon()
  ;
  (self._diamondImg):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._diamondNumTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.DiamodID))
  local dungeonList = (self._bm):GetGardenPartyDungeonBattle()
  local tempRecordList = {}
  local record = nil
  for _,id in ipairs(CClownDungeo:GetAllIds()) do
    record = CClownDungeo:GetRecorder(id)
    if not tempRecordList[record.dungeontype] then
      do
        tempRecordList[record.dungeontype] = {}
        -- DECOMPILER ERROR at PC70: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (tempRecordList[record.dungeontype])[record.dungeondifficulty] = record
        -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  self._dungeonList = {}
  local tempDifficulty = nil
  for _,v in ipairs(dungeonList) do
    tempDifficulty = {}
    for _,h in ipairs(v.difficult) do
      (table.insert)(tempDifficulty, {dungeonDifficulty = h, handbookid = ((tempRecordList[v.bossId])[h]).handbookid, enemyHP = ((tempRecordList[v.bossId])[h]).enemyHP, enemyATK = ((tempRecordList[v.bossId])[h]).enemyATK, battleId = ((tempRecordList[v.bossId])[h]).id, dungeondifficultytext = ((tempRecordList[v.bossId])[h]).dungeondifficultytext, eventtext = ((tempRecordList[v.bossId])[h]).eventtext, scale = ((tempRecordList[v.bossId])[h]).scale, position = ((tempRecordList[v.bossId])[h]).position})
    end
    ;
    (table.sort)(tempDifficulty, function(a, b)
    -- function num : 0_3_0
    do return a.dungeonDifficulty < b.dungeonDifficulty end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (table.insert)(self._dungeonList, {dungeonType = v.bossId, leftTimes = v.leftTimes, dungeonDifficultyList = tempDifficulty, dungeonnametext = ((tempRecordList[v.bossId])[(v.difficult)[1]]).dungeonnametext})
  end
  self._maxTime = tonumber((CClownSpecialCfg:GetRecorder(2)).Value)
  for i = 1, dungeonNumber do
    (((self._dungeonCell)[i]).panel):SetActive(false)
  end
  local record, npcShapeRecorder, scale = nil, nil, nil
  for i,v in ipairs(self._dungeonList) do
    if (self._dungeonCell)[i] then
      (((self._dungeonCell)[i]).leftTimeTagTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1788)).msgTextID))
      ;
      (((self._dungeonCell)[i]).panel):SetActive(true)
      ;
      (((self._dungeonCell)[i]).name):SetText((TextManager.GetText)(v.dungeonnametext))
      ;
      (((self._dungeonCell)[i]).leftTimeTxt):SetText(v.leftTimes .. "/" .. self._maxTime)
      for j,d in ipairs(v.dungeonDifficultyList) do
        ((((self._dungeonCell)[i]).levelBtn)[j]):SetActive(true)
        ;
        ((((self._dungeonCell)[i]).levelBtnTxt)[j]):SetText((TextManager.GetText)(d.dungeondifficultytext))
      end
      for j = #v.dungeonDifficultyList + 1, 3 do
        ((((self._dungeonCell)[i]).levelBtn)[j]):SetActive(false)
      end
      if (v.dungeonDifficultyList)[1] then
        record = CMonster_Handbook:GetRecorder(((v.dungeonDifficultyList)[1]).handbookid)
        npcShapeRecorder = CNPCShape:GetRecorder(record.shapeID)
        if ((self._dungeonCell)[i]).handler then
          (((self._dungeonCell)[i]).model):ReleaseModel(((self._dungeonCell)[i]).handler)
          -- DECOMPILER ERROR at PC291: Confused about usage of register: R15 in 'UnsetPending'

          ;
          ((self._dungeonCell)[i]).handler = nil
        end
        -- DECOMPILER ERROR at PC301: Confused about usage of register: R15 in 'UnsetPending'

        ;
        ((self._dungeonCell)[i]).handler = (((self._dungeonCell)[i]).model):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
        scale = ((v.dungeonDifficultyList)[1]).scale
        ;
        (((self._dungeonCell)[i]).model):SetLocalScale(scale, scale, scale)
      else
        LogErrorFormat("AprilFoolsTowerDungeonDialog", "(cclowndungeo) dungeontype %s has no dungeonDifficultyList", v.dungeonType)
      end
    else
      LogErrorFormat("AprilFoolsTowerDungeonDialog", "UI dont match SOpenFoolsCopyBattle.battleInfo. Index is %s", i)
    end
  end
end

AprilFoolsTowerDungeonDialog.OnLevelBtnClicked = function(self, dungeonIndex, level)
  -- function num : 0_4 , upvalues : _ENV, CMonster_Handbook, CNPCShape
  if ((self._dungeonList)[dungeonIndex]).leftTimes <= 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100464)
    return 
  end
  if not self._havePlayIntoAnimation then
    ((self._battleUI).panel):SetActive(true)
    ;
    (self._rootWindowAnimator):SetTrigger("Into")
    self._havePlayIntoAnimation = true
  end
  self._currentChooseDungeonIndex = dungeonIndex
  self._currentChooseLevel = level
  ;
  ((self._battleUI).levelTxt):SetText((TextManager.GetText)(((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).dungeondifficultytext))
  ;
  ((self._battleUI).title):SetText((TextManager.GetText)(((self._dungeonList)[dungeonIndex]).dungeonnametext))
  ;
  ((self._battleUI).attackNumTxt):SetText(((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).enemyATK)
  ;
  ((self._battleUI).healthNumTxt):SetText(((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).enemyHP)
  ;
  ((self._battleUI).detail):SetText((TextManager.GetText)(((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).eventtext))
  local record = CMonster_Handbook:GetRecorder(((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).handbookid)
  local npcShapeRecorder = CNPCShape:GetRecorder(record.shapeID)
  if self._battleUI_Model_handler ~= 0 then
    ((self._battleUI).model):ReleaseModel(self._battleUI_Model_handler)
    self._battleUI_Model_handler = 0
  end
  self._battleUI_Model_handler = ((self._battleUI).model):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
  local scale = ((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).scale
  ;
  ((self._battleUI).model):SetLocalScale(scale, scale, scale)
  local posLs = (string.split)(((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).position, ";")
  if #posLs > 1 then
    ((self._battleUI).model):SetPosition((self._battleUI).modelPosX, tonumber(posLs[1]) - (self._battleUI).modelPivotDeltaX, (self._battleUI).modelPosY, tonumber(posLs[2]) - (self._battleUI).modelPivotDeltaY)
  end
end

AprilFoolsTowerDungeonDialog.OnAddBtnClicked = function(self, dungeonIndex)
  -- function num : 0_5 , upvalues : CClownDungeonRefresh, Item, _ENV
  if ((self._dungeonList)[dungeonIndex]).leftTimes < self._maxTime then
    local allIds = CClownDungeonRefresh:GetAllIds()
    local timesNum = (self._bm):GetGardenPartyResetConfigTimes()
    if #allIds < timesNum then
      timesNum = #allIds
    end
    local record = CClownDungeonRefresh:GetRecorder(timesNum)
    local item = (Item.Create)(record.item)
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(136, {record.itemnum, item:GetName(), (TextManager.GetText)(((self._dungeonList)[dungeonIndex]).dungeonnametext)}, function()
    -- function num : 0_5_0 , upvalues : _ENV, self, dungeonIndex
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cresetbattlestimes")
    csend.bossId = ((self._dungeonList)[dungeonIndex]).dungeonType
    csend:Send()
  end
, {}, nil, {})
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100470)
    end
  end
end

AprilFoolsTowerDungeonDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

AprilFoolsTowerDungeonDialog.OnBattleBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV, CStartFoolsDayBattleDef
  if not self._sendStartBattleProtocol then
    local dungeonIndex = self._currentChooseDungeonIndex
    local level = self._currentChooseLevel
    LogInfoFormat("AprilFoolsTowerDungeonDialog", "dungeonindex %s levelindex %s cclowndungeo id %s dungeontype %s dungeondifficulty %s", dungeonIndex, level, ((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).battleId, ((self._dungeonList)[dungeonIndex]).dungeonType, ((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).dungeonDifficulty)
    if ((self._dungeonList)[dungeonIndex]).leftTimes > 0 then
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cstartfoolsdaybattle")
      self._battleData = (((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]
      self._sendStartBattleProtocol = true
      self._canShowItemGotten = false
      csend.battleType = CStartFoolsDayBattleDef.COPY_BATTLE
      csend.battleId = ((((self._dungeonList)[dungeonIndex]).dungeonDifficultyList)[level]).battleId
      csend:Send()
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100464)
      end
    end
  end
end

AprilFoolsTowerDungeonDialog.OnAprilFoolsSRefreshBattlesTimes = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  for i,v in ipairs(self._dungeonList) do
    if v.dungeonType == (notification.userInfo).bossId then
      v.leftTimes = (notification.userInfo).leftTimes
      if (self._dungeonCell)[i] then
        (((self._dungeonCell)[i]).leftTimeTxt):SetText(v.leftTimes .. "/" .. self._maxTime)
      end
      break
    end
  end
end

AprilFoolsTowerDungeonDialog.OnAprilFoolsSEndFoolsDayBattle = function(self, notification)
  -- function num : 0_9 , upvalues : CStartFoolsDayBattleDef, _ENV
  if (notification.userInfo).battleType == CStartFoolsDayBattleDef.COPY_BATTLE then
    self._sendStartBattleProtocol = false
    self._battleResult = (notification.userInfo).result
    ;
    ((DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolstowerbattledialog")):SetData(self._battleResult, self._battleData)
  end
end

AprilFoolsTowerDungeonDialog.OnAprilFoolsClientBattleProcessOver = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV
  if self._canShowItemGotten then
    self._canShowItemGotten = false
    ;
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).AprilFoolsDayActivityItems, data = (self._bm):GetGardenPartyGottenItemList()})
  else
    self._canShowItemGotten = true
  end
end

AprilFoolsTowerDungeonDialog.OnSReceiveActivtyItem = function(self, notification)
  -- function num : 0_11 , upvalues : SReceiveActivtyItemDef, _ENV
  if (notification.userInfo).activityLineId == SReceiveActivtyItemDef.FOOLSDAY then
    if self._canShowItemGotten then
      self._canShowItemGotten = false
      ;
      ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).AprilFoolsDayActivityItems, data = (self._bm):GetGardenPartyGottenItemList()})
    else
      self._canShowItemGotten = true
    end
  end
end

AprilFoolsTowerDungeonDialog.OnRefreshMoney = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (self._diamondNumTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.DiamodID))
end

return AprilFoolsTowerDungeonDialog

