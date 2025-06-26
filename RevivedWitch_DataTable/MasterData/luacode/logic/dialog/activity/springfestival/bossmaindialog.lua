-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/bossmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local CBossNianPart = (BeanManager.GetTableByName)("activity.cbossnianpart")
local CBossNianRankAP = (BeanManager.GetTableByName)("activity.cbossnianrankap")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemTable = (BeanManager.GetTableByName)("item.citemattr")
local SpringBossState = (LuaNetManager.GetBeanDef)("protocol.activity.springboss")
local timeutils = require("logic.utils.timeutils")
local ChildDialogs = {"activity.springfestival.rankdialog", "activity.springfestival.spiritrecoverdialog", "activity.springfestival.bossdetailsdialog"}
local BossMainDialog = class("BossMainDialog", Dialog)
BossMainDialog.AssetBundleName = "ui/layouts.activitynewyear"
BossMainDialog.AssetName = "ActivityNewYearBattle"
BossMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossMainDialog
  ((BossMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BossMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._rankNum = self:GetChild("LevelPanel/RewardTitle/Num2")
  self._rankBtn = self:GetChild("LevelPanel/RankBtn")
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._totleScore = self:GetChild("LevelPanel/RewardTitle/Num1")
  self._instructBtn = self:GetChild("GetBtn")
  ;
  (self._instructBtn):Subscribe_PointerClickEvent(self.OnInstructBtnClicked, self)
  self._spiritRedDot = self:GetChild("TopGroup/Num0/RedDot")
  self._spiritNum = self:GetChild("TopGroup/Num0/Text")
  self._spiritAdd = self:GetChild("TopGroup/Num0/Add")
  self._spiritIcon = self:GetChild("TopGroup/Num0/Icon")
  self._spiritPanel = self:GetChild("TopGroup/Num0")
  ;
  (self._spiritPanel):Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._imgCloud = self:GetChild("TileGroup/Tile_04/Imgcloud")
  self._effect = self:GetChild("Effect")
  ;
  (self._effect):SetActive(false)
  self._bossUI = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R5 in 'UnsetPending'

      (self._bossUI)[i] = {}
      -- DECOMPILER ERROR at PC97: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._back = self:GetChild("TileGroup/Tile_0" .. i)
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._model = self:GetChild("TileGroup/Tile_0" .. i .. "/Model2")
      -- DECOMPILER ERROR at PC115: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._name = self:GetChild("TileGroup/Tile_0" .. i .. "/Name")
      -- DECOMPILER ERROR at PC124: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._weekText = self:GetChild("TileGroup/Tile_0" .. i .. "/Text")
      -- DECOMPILER ERROR at PC133: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._num = self:GetChild("TileGroup/Tile_0" .. i .. "/Loading/Num/Num")
      -- DECOMPILER ERROR at PC142: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._defectText = self:GetChild("TileGroup/Tile_0" .. i .. "/Loading/Num/Defect")
      -- DECOMPILER ERROR at PC151: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._unlockTimeText = self:GetChild("TileGroup/Tile_0" .. i .. "/Loading/Num/Text")
      -- DECOMPILER ERROR at PC160: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._progress = self:GetChild("TileGroup/Tile_0" .. i .. "/Loading/Loading/BackGround/Progress")
      -- DECOMPILER ERROR at PC169: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._grey = self:GetChild("TileGroup/Tile_0" .. i .. "/Loading/Loading/BackGround/Grey")
      -- DECOMPILER ERROR at PC178: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._imgBoxOn = self:GetChild("TileGroup/Tile_0" .. i .. "/ImgBoxOn")
      -- DECOMPILER ERROR at PC187: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._weekImage = self:GetChild("TileGroup/Tile_0" .. i .. "/Image")
      -- DECOMPILER ERROR at PC196: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._imgBoxOff = self:GetChild("TileGroup/Tile_0" .. i .. "/ImgBoxOff")
      -- DECOMPILER ERROR at PC205: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._lockText = self:GetChild("TileGroup/Tile_0" .. i .. "/Text1")
      -- DECOMPILER ERROR at PC214: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._line = self:GetChild("TileGroup/Tile_0" .. i .. "/Line_green")
      -- DECOMPILER ERROR at PC223: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._lockImg = self:GetChild("TileGroup/Tile_0" .. i .. "/Img")
      ;
      (((self._bossUI)[i])._back):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnBossClick(i)
  end
, self)
      -- DECOMPILER ERROR at PC239: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._bossUI)[i])._dot = self:GetChild("TileGroup/Tile_0" .. i .. "/Dot")
    end
  end
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  self._animator = ((self._rootWindow):GetUIObject()):GetComponent("Animator")
  ;
  (self._animator):Play("ActivityNewyearStart")
  ;
  (LuaAudioManager.PlayBGM)(1366, true)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpringSpirit, Common.n_RefreshSpringSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OpenRankDialog, Common.n_OnSSimpleRank, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetBossInfo, Common.n_SSpringBossState)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SReceiveSpringBossReward, Common.n_SReceiveSpringBossReward)
  ;
  (UIBackManager.SetUIBackShow)(true)
end

BossMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
end

BossMainDialog.SetData = function(self)
  -- function num : 0_3
  self:RefreshSpringSpirit()
end

BossMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

BossMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

BossMainDialog.SetBossInfo = function(self)
  -- function num : 0_6 , upvalues : _ENV, CItemTable, CImagePathTable, SpringBossState, CBossNianPart, CNPCShape, TransformStaticFunctions, AnimatorStaticFunctions, StateEventTriggerHelper, timeutils
  self._bossInfo = (self._bm):GetBossInfo()
  ;
  (self._totleScore):SetText((self._bossInfo).score)
  local rankNum = nil
  if (self._bossInfo).rank == -1 then
    rankNum = (TextManager.GetText)(701681)
  else
    rankNum = (self._bossInfo).rank
  end
  ;
  (self._rankNum):SetText(rankNum)
  local itemRecorder = CItemTable:GetRecorder(DataCommon.SpringFestivalFu)
  do
    if itemRecorder then
      local imageRecord = CImagePathTable:GetRecorder(itemRecorder.icon)
      ;
      (self._spiritIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    self._defeatCount = 0
    for k,v in pairs((self._bossInfo).bossList) do
      do
        if SpringBossState.DEFEAT <= v.state then
          do
            self._defeatCount = self._defeatCount + 1
            -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    ;
    (self._imgCloud):SetActive((((self._bossInfo).bossList)[4]).state < SpringBossState.DEFEAT)
    local recorder = nil
    for i,bossUi in ipairs(self._bossUI) do
      local data = ((self._bossInfo).bossList)[i]
      if not data then
        LogError("BossMainDialog", "没有boss数据！")
        return 
      end
      ;
      (bossUi._progress):SetFillAmount(data.bloodVolume / 100 / 100)
      ;
      (bossUi._num):SetText(data.bloodVolume / 100 .. "%")
      if data.state ~= SpringBossState.UNLOCK then
        (bossUi._lockText):SetActive(not bossUi._lockText)
        if data.state ~= SpringBossState.UNLOCK then
          (bossUi._lockImg):SetActive(not bossUi._lockImg)
          ;
          (bossUi._grey):SetActive(data.state == SpringBossState.UNLOCK)
          ;
          (bossUi._dot):SetActive(data.state == SpringBossState.DEFEAT)
          ;
          (bossUi._imgBoxOff):SetActive(data.state == SpringBossState.DEFEAT)
          ;
          (bossUi._imgBoxOn):SetActive(data.state == SpringBossState.OPENBOX)
          ;
          (bossUi._defectText):SetActive(data.state == SpringBossState.DEFEAT or data.state == SpringBossState.OPENBOX)
          if SpringBossState.DEFEAT > data.state then
            do
              (bossUi._line):SetActive(not bossUi._line)
              ;
              (bossUi._unlockTimeText):SetActive(data.state == SpringBossState.UNLOCK)
              ;
              (bossUi._num):SetActive(data.state == SpringBossState.PROCESS)
              recorder = CBossNianPart:GetRecorder(data.bossId)
              local npcShapeRecorder = CNPCShape:GetRecorder(recorder.bossModel)
              if bossUi._handler ~= 0 then
                (bossUi._model):ReleaseModel(self._handler)
                bossUi._handler = 0
              end
              if data.state == SpringBossState.PROCESS or data.state == SpringBossState.UNLOCK or self._defeatCount == i then
                if self._defeatCount == i then
                  local catchBossDeadIndex = (((CS.UnityEngine).PlayerPrefs).GetInt)("SpringFestivalBossDeadIndex")
                  if not catchBossDeadIndex or catchBossDeadIndex ~= i then
                    bossUi._handler = (bossUi._model):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
                    bossUi._modelobj = (TransformStaticFunctions.GetChild)((bossUi._model)._uiObject, "Model/" .. npcShapeRecorder.prefabNameUI .. "(Clone)")
                    bossUi._modelAnimator = (AnimatorStaticFunctions.Get)(bossUi._modelobj)
                    local scale = tonumber(recorder.bossSize)
                    ;
                    (bossUi._model):SetLocalScale(scale, scale, scale)
                    ;
                    (bossUi._dot):SetActive(false)
                    ;
                    (bossUi._imgBoxOff):SetActive(false)
                    ;
                    (bossUi._imgBoxOn):SetActive(false)
                    ;
                    (StateEventTriggerHelper.AddAnimationEventListener)(bossUi._modelobj, "DeadDisappear", function()
    -- function num : 0_6_0 , upvalues : bossUi, data, SpringBossState
    (bossUi._dot):SetActive(data.state == SpringBossState.DEFEAT)
    ;
    (bossUi._imgBoxOff):SetActive(data.state == SpringBossState.DEFEAT)
    ;
    (bossUi._imgBoxOn):SetActive(data.state == SpringBossState.OPENBOX)
    if bossUi._handler ~= 0 then
      (bossUi._model):ReleaseModel(bossUi._handler)
      bossUi._handler = 0
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
)
                    ;
                    (((CS.UnityEngine).PlayerPrefs).SetInt)("SpringFestivalBossDeadIndex", i)
                  end
                else
                  bossUi._handler = (bossUi._model):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
                  bossUi._modelobj = (TransformStaticFunctions.GetChild)((bossUi._model)._uiObject, "Model/" .. npcShapeRecorder.prefabNameUI .. "(Clone)")
                  bossUi._modelAnimator = (AnimatorStaticFunctions.Get)(bossUi._modelobj)
                  local scale = tonumber(recorder.bossSize)
                  ;
                  (bossUi._model):SetLocalScale(scale, scale, scale)
                end
              end
              if data.state == SpringBossState.UNLOCK then
                local time = (ServerGameTimer.GetServerTime)()
                local endtime = (timeutils.GetConfigFormatTimeStamp)(recorder.BossOpenTime)
                local limit = endtime - time
                ;
                (bossUi._unlockTimeText):SetText((TextManager.GetText)(recorder.bossUnlockWord, self:GetRemainTimeStr(limit)))
              end
              ;
              (bossUi._name):SetText((TextManager.GetText)(recorder.bossName))
              local imageRecord = CImagePathTable:GetRecorder(recorder.bossWeakIcon)
              if recorder.bossWeakIcon ~= -1 then
                (bossUi._weekImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
              end
              ;
              (bossUi._weekImage):SetActive(recorder.bossWeakIcon ~= -1)
              ;
              (bossUi._weekText):SetActive(recorder.bossWeakIcon ~= -1)
              -- DECOMPILER ERROR at PC380: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC380: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC380: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC380: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC380: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC380: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    -- DECOMPILER ERROR: 25 unprocessed JMP targets
  end
end

BossMainDialog.GetRemainTimeStr = function(self, endTime)
  -- function num : 0_7 , upvalues : _ENV
  if endTime and endTime > 0 then
    local time = endTime // 1000
    local day = time / 86400
    return (math.ceil)(day)
  end
end

BossMainDialog.OnBossClick = function(self, i)
  -- function num : 0_8 , upvalues : SpringBossState, _ENV
  if not self._doorIdOpen then
    return 
  end
  if (((self._bossInfo).bossList)[i]).state == SpringBossState.PROCESS or (((self._bossInfo).bossList)[i]).state == SpringBossState.OPENBOX then
    ((DialogManager.CreateSingletonDialog)("activity.springfestival.bossdetailsdialog")):SetData((self._bm):GetBossInfoByID(i))
  else
    if (((self._bossInfo).bossList)[i]).state == SpringBossState.DEFEAT then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivespringbossreward")
      if protocol then
        protocol.bossId = (((self._bossInfo).bossList)[i]).bossId
        protocol:Send()
      end
    end
  end
end

BossMainDialog.RefreshSpringSpirit = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self._spirit = (self._bm):GetSpringSpirit()
  ;
  (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)((self._bm):GetSpiritLimit()))
end

BossMainDialog.OnSpiritAddBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpringFestivalFu)
end

BossMainDialog.OnRankBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.csimplerank")
  if protocol then
    protocol.rankType = (((NekoData.BehaviorManager).BM_SimpleRank):GetRankTypeDef()).SPRING_FESTIVAL
    protocol.rankId = (self._bm):GetRankID()
    protocol:Send()
  end
end

BossMainDialog.OpenRankDialog = function(self, data)
  -- function num : 0_12 , upvalues : _ENV
  if (data.userInfo).rankType == (((NekoData.BehaviorManager).BM_SimpleRank):GetRankTypeDef()).SPRING_FESTIVAL then
    (DialogManager.CreateSingletonDialog)("activity.springfestival.rankdialog")
  end
end

BossMainDialog.OnInstructBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV, CBossNianRankAP
  ((DialogManager.CreateSingletonDialog)("activity.springfestival.tipsdialog")):SetData(701661, (CBossNianRankAP:GetRecorder(1)).rankForReward)
end

BossMainDialog.AddNewModal = function(self, dialog)
  -- function num : 0_14 , upvalues : _ENV, ChildDialogs
  if (table.contain)(ChildDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

BossMainDialog.OnSSpringBossState = function(self)
  -- function num : 0_15 , upvalues : _ENV, SpringBossState, CBossNianPart, CNPCShape, timeutils
  self._bossInfo = (self._bm):GetBossInfo()
  ;
  (self._totleScore):SetText((self._bossInfo).score)
  local rankNum = nil
  if (self._bossInfo).rank == -1 then
    rankNum = (TextManager.GetText)(701681)
  else
    rankNum = (self._bossInfo).rank
  end
  ;
  (self._rankNum):SetText(rankNum)
  self._defeatCount = 0
  for k,v in pairs((self._bossInfo).bossList) do
    if SpringBossState.DEFEAT <= v.state then
      self._defeatCount = self._defeatCount + 1
    end
  end
  local recorder = nil
  for i,bossUi in ipairs(self._bossUI) do
    local data = ((self._bossInfo).bossList)[i]
    if not data then
      LogError("BossMainDialog", "没有boss数据！")
      return 
    end
    ;
    (bossUi._progress):SetFillAmount(data.bloodVolume / 100 / 100)
    ;
    (bossUi._num):SetText(data.bloodVolume / 100 .. "%")
    if data.state ~= SpringBossState.UNLOCK then
      (bossUi._lockText):SetActive(not bossUi._lockText)
      if data.state ~= SpringBossState.UNLOCK then
        (bossUi._lockImg):SetActive(not bossUi._lockImg)
        ;
        (bossUi._grey):SetActive(data.state == SpringBossState.UNLOCK)
        ;
        (bossUi._dot):SetActive(data.state == SpringBossState.DEFEAT)
        ;
        (bossUi._imgBoxOff):SetActive(data.state == SpringBossState.DEFEAT)
        ;
        (bossUi._imgBoxOn):SetActive(data.state == SpringBossState.OPENBOX)
        ;
        (bossUi._defectText):SetActive(data.state == SpringBossState.DEFEAT or data.state == SpringBossState.OPENBOX)
        if SpringBossState.DEFEAT > data.state then
          (bossUi._line):SetActive(not bossUi._line)
          ;
          (bossUi._unlockTimeText):SetActive(data.state == SpringBossState.UNLOCK)
          ;
          (bossUi._num):SetActive(data.state == SpringBossState.PROCESS)
          recorder = CBossNianPart:GetRecorder(data.bossId)
          local npcShapeRecorder = CNPCShape:GetRecorder(recorder.bossModel)
          if bossUi._handler ~= 0 and data.state ~= SpringBossState.PROCESS then
            (bossUi._model):ReleaseModel(self._handler)
            bossUi._handler = 0
          end
          if data.state == SpringBossState.PROCESS and bossUi._handler == 0 then
            bossUi._handler = (bossUi._model):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
            local scale = tonumber(recorder.bossSize)
            ;
            (bossUi._model):SetLocalScale(scale, scale, scale)
          end
          if data.state == SpringBossState.UNLOCK then
            local time = (ServerGameTimer.GetServerTime)()
            local endtime = (timeutils.GetConfigFormatTimeStamp)(recorder.BossOpenTime)
            local limit = endtime - time
            local str = (TextManager.GetText)(recorder.bossUnlockWord, self:GetRemainTimeStr(limit))
            if limit < 0 then
              str = (TextManager.GetText)(701754)
            end
            ;
            (bossUi._unlockTimeText):SetText(str)
          end
          -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC244: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  -- DECOMPILER ERROR: 17 unprocessed JMP targets
end

BossMainDialog.SReceiveSpringBossReward = function(self, data)
  -- function num : 0_16 , upvalues : SpringBossState
  local bossId = (data.userInfo).bossId
  ;
  (((self._bossUI)[bossId])._dot):SetActive((((self._bossInfo).bossList)[bossId]).state == SpringBossState.DEFEAT)
  ;
  (((self._bossUI)[bossId])._imgBoxOff):SetActive((((self._bossInfo).bossList)[bossId]).state == SpringBossState.DEFEAT)
  ;
  (((self._bossUI)[bossId])._imgBoxOn):SetActive((((self._bossInfo).bossList)[bossId]).state == SpringBossState.OPENBOX)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BossMainDialog.OnAnimationEnd = function(self, handler, stateName, normalizedTime)
  -- function num : 0_17 , upvalues : _ENV
  if stateName == "ActivityNewyearStart" then
    self._doorIdOpen = true
    if (self._bossUI)[self._defeatCount] and ((self._bossUI)[self._defeatCount])._modelAnimator then
      (((self._bossUI)[self._defeatCount])._modelAnimator):Play("DeadDisappear")
    end
    if self._defeatCount == #self._bossUI then
      local flg = (((CS.UnityEngine).PlayerPrefs).GetInt)("SpringFestivalFireworksReleased")
      if not flg or flg ~= 2 then
        (self._effect):SetActive(true)
        ;
        (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1151))
        ;
        (((CS.UnityEngine).PlayerPrefs).SetInt)("SpringFestivalFireworksReleased", 2)
      end
      self._defeatCount = nil
    end
  end
end

BossMainDialog.ShowSpringFestivalFireworks = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self._defeatCount == #self._bossUI then
    local flg = (((CS.UnityEngine).PlayerPrefs).GetInt)("SpringFestivalFireworksReleased")
    if not flg or flg ~= 2 then
      (self._effect):SetActive(true)
      ;
      (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1151))
      ;
      (((CS.UnityEngine).PlayerPrefs).SetInt)("SpringFestivalFireworksReleased", 2)
    end
    self._defeatCount = nil
  end
end

return BossMainDialog

