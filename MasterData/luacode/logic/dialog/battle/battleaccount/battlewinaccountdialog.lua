local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local BattleResultType = require("protocols.bean.protocol.battle.battleresult")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local CEmotion = BeanManager.GetTableByName("npc.cemotion")
local CGuildBossInfo = BeanManager.GetTableByName("guild.cguildchallengebossinfo")
local BattleWinAccountDialog = class("BattleWinAccountDialog", Dialog)
BattleWinAccountDialog.AssetBundleName = "ui/layouts.battlewin"
BattleWinAccountDialog.AssetName = "BattleWinAccount"

function BattleWinAccountDialog:Ctor(...)
  BattleWinAccountDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._playerExpShowOver = ""
  self._itemShowOver = ""
  self._roleExpShowOver = ""
  self._roleShowOverCountTable = {}
  self._alternativeRoleNum = 0
end

function BattleWinAccountDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._itemField = self:GetChild("Panel/Item")
  self._roleFieldPanel = self:GetChild("Panel/CharFrame1")
  self._roleField = self:GetChild("Panel/CharFrame1/Frame")
  self._alternativeRoleFieldPanel = self:GetChild("Panel/CharFrame2")
  self._alternativeRoleField = self:GetChild("Panel/CharFrame2/Frame")
  self._nextBtn = self:GetChild("NextImage")
  self._battleTimeTitle = self:GetChild("Panel/TimeFrame/TimeTxt")
  self._battleTime = self:GetChild("Panel/TimeFrame/Time")
  self._live2DModel = self:GetChild("Role/Live2D")
  self._photo = self:GetChild("Role/Photo")
  self._winDialogPanel = self:GetChild("Panel/Dialog")
  self._winDialog = self:GetChild("Panel/Dialog/Text")
  self._reportBtn = self:GetChild("Panel/TimeFrame/ReportBtn")
  self._newYearFrame = self:GetChild("Panel/NewYearFrame")
  self._newYearScoreNum = self:GetChild("Panel/NewYearFrame/Num1")
  self._newYearStageNum = self:GetChild("Panel/NewYearFrame/Num2")
  self._playerExpPanel = self:GetChild("Panel/Level")
  self._playerExpProgress = self:GetChild("Panel/Level/ProgressLevel/BackGround/Progress")
  self._playerExpBackProgress = self:GetChild("Panel/Level/ProgressLevel/BackGround/Progress2")
  self._playerLevelNum = self:GetChild("Panel/Level/LevelNum")
  self._PlayerExpNum = self:GetChild("Panel/Level/EXPNum")
  self._PlayerExpMax = self:GetChild("Panel/Level/Max")
  self._playerExpFullText = self:GetChild("Panel/LevelUpTxt")
  self._playerExpProgress:SetFillAmount(0)
  self._playerExpBackProgress:SetFillAmount(0)
  self._playerExpPanel:SetActive(false)
  self._roleFieldPanel:SetActive(false)
  self._alternativeRoleFieldPanel:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self._reportBtn:Subscribe_PointerClickEvent(self.OnReportBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  if NekoData.BehaviorManager.BM_SBattleEnd:GetBattleResult() ~= BattleResultType.SETTLE then
    self._animator:Play("BattleWinAccount")
  else
    self._animator:Play("BattleWinAccount_newyear")
  end
  self._roleFrame = GridFrame.Create(self._roleField, self, true, 3, false)
  self._alternativeRoleFrame = GridFrame.Create(self._alternativeRoleField, self, true, 3, false)
  self._itemFrame = GridFrame.Create(self._itemField, self, true, 3)
  self._itemFrame:SetMargin(20, 0)
  self._isGuildBoss = false
  self._bossRemainHP = self:GetChild("Panel/RemainHP")
  if self._bossRemainHP then
    self._bossRemainHP:SetActive(false)
  end
  self._progress = self:GetChild("Panel/RemainHP/HPLevel/BackGround/Progress")
  self._progressPreView = self:GetChild("Panel/RemainHP/HPLevel/BackGround/Progress2")
  self._RemainNum1 = self:GetChild("Panel/RemainHP/RemainNumer")
  self._RemainNum1:SetText("")
  self._RemainNum2 = self:GetChild("Panel/RemainHP/ReduceNumber")
  self._RemainNum2:SetText("")
  if NekoData.BehaviorManager.BM_Dungeon:GetMode() == "auto" then
    if NekoData.BehaviorManager.BM_Battle:GetBattleType() ~= 19 then
      self._timer = GameTimer.AddTask(3, 3, self.OnNextClicked, self)
      return
    else
      NekoData.DataManager.DM_Dungeon:SetMode()
    end
  end
end

function BattleWinAccountDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._timer then
    GameTimer.RemoveTask(self._timer)
  end
  if self._freezeUITimeTask then
    GameTimer.RemoveTask(self._freezeUITimeTask)
    self._freezeUITimeTask = nil
  end
  if self._roleFrame then
    self._roleFrame:Destroy()
    self._roleFrame = nil
  end
  if self._alternativeRoleFrame then
    self._alternativeRoleFrame:Destroy()
    self._alternativeRoleFrame = nil
  end
  if self._itemFrame then
    self._itemFrame:Destroy()
    self._itemFrame = nil
  end
  self._data = {}
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
  DialogManager.DestroySingletonDialog("battle.battleaccount.battlereportdialog")
end

local function SortItemByPinji(self)
  local items = {}
  local equips = {}
  for _, v in ipairs(self._data) do
    local item
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(v.bagtype, v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v.id)
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = Item.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        item = Equip.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.SKILL then
        item = Skill.Create(v.id)
      end
      item:InitWithItemInfo(v)
    end
    if item then
      if item:GetItemType() == ItemTypeEnum.EQUIP then
        table.insert(equips, item)
      else
        table.insert(items, {
          item = item,
          num = v.number
        })
      end
    else
      LogErrorFormat("BattleWinAccountDialog", "get item id %s itemtype %s gain %s number %s not in [bagtype %s]'s bag", v.id, v.itemtype, v.gain, v.number, v.bagtype)
    end
  end
  
  local function tempFun(a, b)
    if a:GetPinJiID() > b:GetPinJiID() then
      return true
    elseif a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
      return true
    end
    return false
  end
  
  self._data = {}
  for _, item in ipairs(equips) do
    local temp = {}
    temp.item = item
    temp.num = 1
    table.insert(self._data, temp)
  end
  for _, item in ipairs(items) do
    local temp = {}
    temp.item = item.item
    temp.num = item.num
    table.insert(self._data, temp)
  end
  table.sort(self._data, function(a, b)
    return tempFun(a.item, b.item)
  end)
end

function BattleWinAccountDialog:SetIsGuildBoss(isBoss)
  self._isGuildBoss = isBoss
end

function BattleWinAccountDialog:Show(clientGM, roleId)
  self._clientGM = clientGM
  self._roleId = roleId
  if self._clientGM then
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
    if self._roleId == 1 then
      self._winDialogPanel:SetActive(false)
    end
    local live2dRecord = role:GetShapeLive2DRecord()
    local imageRecord = role:GetShapeLiHuiImageRecord()
    local victoryTalk = role:GetVictoryTalk()
    if victoryTalk then
      self._winDialog:SetText(victoryTalk)
    else
      self._winDialogPanel:SetActive(false)
    end
    NekoData.BehaviorManager.BM_Voice:Play(self._roleId, NekoData.BehaviorManager.BM_Voice.VoiceType.Victory, nil)
    if Live2DManager.CanUse() and role:IsFashionLive2D() and live2dRecord.live2DPrefabName and live2dRecord.live2DAssetBundleName then
      self._live2DModel:SetActive(true)
      self._photo:SetActive(false)
      if self._live2d then
        self._live2DModel:Release(self._live2d)
        self._live2d = nil
      end
      self._live2d = self._live2DModel:AddLive2D(live2dRecord.live2DAssetBundleName, live2dRecord.live2DPrefabName, live2dRecord.live2DScale)
      local emotionRecord = CEmotion:GetRecorder(role:GetBattleEmotion())
      if emotionRecord then
        self._live2DModel:PlayLive2DAnimation(emotionRecord.Name, self._live2d)
      else
        LogWarningFormat("BattleWinAccountDialog", "role id %s cnpcshape battleEmotion %s dont exist in cemotion", role:GetId(), role:GetBattleEmotion())
      end
    else
      self._live2DModel:SetActive(false)
      self._photo:SetActive(true)
      local photoScale = role:GetPhotoScale()
      self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._photo:SetLocalScale(photoScale, photoScale, photoScale)
      local photoPos = role:GetPhotoPosition()
      self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
    end
    return
  end
  local battleTime
  self._awardList, self._currency, self._roleInfo, battleTime, self._goodExpInfo, self._rolesIndex, self._playerExp = NekoData.BehaviorManager.BM_Dungeon:GetBattleAccountData()
  local battleType = NekoData.BehaviorManager.BM_SBattleStart:GetBattleType()
  if battleType == CBattleStartProtocol.SPRING_FESTIVAL then
    self:MergeSameTtems()
  end
  local str = TextManager.GetText(CStringRes:GetRecorder(1099).msgTextID)
  self._battleTime:SetText(string.gsub(str, "%$parameter1%$", tostring(math.floor(battleTime / 1000))))
  local roleList = {}
  local standRoleList = {}
  for key, exp in pairs(self._roleInfo) do
    table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(key))
  end
  if #roleList == 0 then
    local role
    self._roleInfo = {}
    if NekoData.BehaviorManager.BM_SBattleStart:GetLeftRoleMap() then
      for _, v in pairs(NekoData.BehaviorManager.BM_SBattleStart:GetLeftRoleMap()) do
        role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v.id)
        if role then
          table.insert(roleList, role)
        end
        self._roleInfo[v.id] = 0
      end
    end
  end
  local shouldCountAlternative = true
  if #roleList == 0 then
    table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(1))
    shouldCountAlternative = false
  end
  local hpList = {}
  self._alternativeRoleNum = 0
  local leftRoleListWithStationInfo = {}
  if NekoData.BehaviorManager.BM_SBattleStart:GetLeftRoleMap() then
    for station, v in pairs(NekoData.BehaviorManager.BM_SBattleStart:GetLeftRoleMap()) do
      leftRoleListWithStationInfo[v.id] = station
    end
  end
  for k, role in ipairs(roleList) do
    if (leftRoleListWithStationInfo[role:GetId()] == LineUpStation.ALTERNATE_FRONT_ROW or leftRoleListWithStationInfo[role:GetId()] == LineUpStation.ALTERNATE_MIDDLE_ROW or leftRoleListWithStationInfo[role:GetId()] == LineUpStation.ALTERNATE_BACK_ROW) and shouldCountAlternative then
      self._alternativeRoleNum = self._alternativeRoleNum + 1
    end
    table.insert(hpList, {
      id = role:GetId(),
      hp = role:GetCurrentHp()
    })
    if 0 >= role:GetCurrentHp() then
      local mainRoleStation = leftRoleListWithStationInfo[role:GetId()]
      if mainRoleStation == LineUpStation.FRONT_ROW then
        for inK, inRole in ipairs(roleList) do
          if leftRoleListWithStationInfo[inRole:GetId()] == LineUpStation.ALTERNATE_FRONT_ROW then
            table.insert(standRoleList, inRole)
            break
          end
        end
      elseif mainRoleStation == LineUpStation.MIDDLE_ROW then
        for inK, inRole in ipairs(roleList) do
          if leftRoleListWithStationInfo[inRole:GetId()] == LineUpStation.ALTERNATE_MIDDLE_ROW then
            table.insert(standRoleList, inRole)
            break
          end
        end
      elseif mainRoleStation == LineUpStation.BACK_ROW then
        for inK, inRole in ipairs(roleList) do
          if leftRoleListWithStationInfo[inRole:GetId()] == LineUpStation.ALTERNATE_BACK_ROW then
            table.insert(standRoleList, inRole)
            break
          end
        end
      end
    elseif leftRoleListWithStationInfo[role:GetId()] == LineUpStation.FRONT_ROW or leftRoleListWithStationInfo[role:GetId()] == LineUpStation.MIDDLE_ROW or leftRoleListWithStationInfo[role:GetId()] == LineUpStation.BACK_ROW then
      table.insert(standRoleList, role)
    end
  end
  if #standRoleList == 0 then
    standRoleList = roleList
  end
  local i = math.random(1, #standRoleList)
  if standRoleList[i]:GetIsLeader() then
    self._winDialogPanel:SetActive(false)
  end
  local live2dRecord = standRoleList[i]:GetShapeLive2DRecord()
  local imageRecord = standRoleList[i]:GetShapeLiHuiImageRecord()
  local victoryTalk = standRoleList[i]:GetVictoryTalk()
  if victoryTalk then
    self._winDialog:SetText(victoryTalk)
  else
    self._winDialogPanel:SetActive(false)
  end
  NekoData.BehaviorManager.BM_Voice:Play(standRoleList[i]:GetId(), NekoData.BehaviorManager.BM_Voice.VoiceType.Victory, nil)
  if Live2DManager.CanUse() and standRoleList[i]:IsFashionLive2D() and live2dRecord.live2DPrefabName and live2dRecord.live2DAssetBundleName then
    self._live2DModel:SetActive(true)
    self._photo:SetActive(false)
    if self._live2d then
      self._live2DModel:Release(self._live2d)
      self._live2d = nil
    end
    self._live2d = self._live2DModel:AddLive2D(live2dRecord.live2DAssetBundleName, live2dRecord.live2DPrefabName, live2dRecord.live2DScale)
    local emotionRecord = CEmotion:GetRecorder(standRoleList[i]:GetBattleEmotion())
    if emotionRecord then
      self._live2DModel:PlayLive2DAnimation(emotionRecord.Name, self._live2d)
    else
      LogWarningFormat("BattleWinAccountDialog", "role id %s cnpcshape battleEmotion %s dont exist in cemotion", standRoleList[i]:GetId(), standRoleList[i]:GetBattleEmotion())
    end
  else
    self._live2DModel:SetActive(false)
    self._photo:SetActive(true)
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local photoScale = standRoleList[i]:GetPhotoScale()
    self._photo:SetLocalScale(photoScale, photoScale, photoScale)
    local photoPos = standRoleList[i]:GetPhotoPosition()
    self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
  end
  local battleType = NekoData.BehaviorManager.BM_SBattleStart:GetBattleType()
  self._newYearFrame:SetActive(battleType == CBattleStartProtocol.SPRING_FESTIVAL)
  self._battleTime:SetActive(battleType ~= CBattleStartProtocol.SPRING_FESTIVAL)
  self._battleTimeTitle:SetActive(battleType ~= CBattleStartProtocol.SPRING_FESTIVAL)
  if battleType == CBattleStartProtocol.SPRING_FESTIVAL then
    local springBattleResult = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID):GetSpringBattleResult()
    self._newYearScoreNum:SetText(springBattleResult.score)
    self._newYearStageNum:SetText(springBattleResult.stage)
  end
end

function BattleWinAccountDialog:ShowPlayerExp()
  if self._isGuildBoss then
    if self._bossRemainHP then
      self._bossRemainHP:SetActive(true)
    end
    local battleResult = NekoData.BehaviorManager.BM_Guild:GetGuildBossBattleResult()
    local recorder = CGuildBossInfo:GetRecorder(battleResult.bossid)
    if recorder then
      self.mTotalHP = recorder.point1
      local leftHP = (battleResult.beforescore - battleResult.realscore) / recorder.point1
      local Num1 = string.format("%.2f", leftHP * 100)
      local Num2 = string.format("%.2f", battleResult.realscore / recorder.point1 * 100)
      self._RemainNum2:SetText("(-" .. Num2 .. "%)")
      self._progressPreView:SetFillAmount(1)
      local first = {
        value = battleResult.beforescore
      }
      local firstValue = battleResult.beforescore / self.mTotalHP
      local last = {
        value = battleResult.beforescore - battleResult.realscore
      }
      self._progress:SetFillAmount(firstValue)
      Num1 = string.format("%.2f", firstValue * 100)
      self._RemainNum1:SetText(Num1 .. "%")
      self._tweenHP = Tween.new(1, first, last, "linear")
    end
  else
    self._playerExpPanel:SetActive(true)
  end
  self._playerExpShowOver = "showing"
  local playerInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local recorder = CPlayerLevel:GetRecorder(playerInfo.userlevel)
  local currentLevelExpNum = playerInfo.userexp
  self._currentLevelExpMax = recorder.exp
  self._playerLevelNum:SetText(playerInfo.userlevel)
  local allIds = CPlayerLevel:GetAllIds()
  local maxLevel = CPlayerLevel:GetRecorder(#allIds).id
  local maxLevelMaxExp = CPlayerLevel:GetRecorder(#allIds).exp
  local isMax = playerInfo.userlevel == maxLevel
  self._PlayerExpMax:SetActive(isMax)
  self._PlayerExpNum:SetActive(not isMax)
  if isMax then
    self._playerExpProgress:SetFillAmount(1)
    self._playerExpBackProgress:SetFillAmount(1)
  else
    local str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
    str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
    if self._playerExp > 0 then
      local first = {
        value = currentLevelExpNum - self._playerExp
      }
      local last = {value = currentLevelExpNum}
      self._desBack = last.value / self._currentLevelExpMax
      if first.value < 0 then
        self._IsLevelUp = true
        self._playerLevelNum:SetText(playerInfo.userlevel - 1)
        self._preLevelExpMax = CPlayerLevel:GetRecorder(playerInfo.userlevel - 1).exp
        self._preLevelExpNum = self._preLevelExpMax - (self._playerExp - currentLevelExpNum)
        first.value = self._preLevelExpNum
        last.value = self._preLevelExpNum + self._playerExp
        local des = first.value / self._preLevelExpMax
        self._playerExpProgress:SetFillAmount(des)
        self._tween = Tween.new(1, first, last, "linear")
        str = string.gsub(str, "%$parameter1%$", tostring(self._preLevelExpNum))
        str = string.gsub(str, "%$parameter2%$", tostring(self._preLevelExpMax))
      else
        local des = first.value / self._currentLevelExpMax
        self._playerExpProgress:SetFillAmount(des)
        self._tween = Tween.new(1, first, last, "linear")
        str = string.gsub(str, "%$parameter1%$", tostring(currentLevelExpNum))
        str = string.gsub(str, "%$parameter2%$", tostring(self._currentLevelExpMax))
      end
    else
      local des = currentLevelExpNum / self._currentLevelExpMax
      self._desBack = des
      self._playerExpProgress:SetFillAmount(des)
      self._playerExpBackProgress:SetFillAmount(des)
      str = string.gsub(str, "%$parameter1%$", tostring(currentLevelExpNum))
      str = string.gsub(str, "%$parameter2%$", tostring(self._currentLevelExpMax))
    end
    self._PlayerExpNum:SetText(str)
  end
  if not self._tween then
    self:OnPlayerExpShowEnd()
  end
end

function BattleWinAccountDialog:ShowCharAccount()
  self:ShowPlayerExpFullText()
  self._roleFieldPanel:SetActive(true)
  if self._alternativeRoleNum > 0 then
    self._alternativeRoleFieldPanel:SetActive(true)
  end
  self._roleExpShowOver = "showing"
  self._itemField:SetActive(false)
  self._data = {}
  if not self._goodExpInfo then
    LogError("BattleWinAccountDialog", "battle account SBattleEnd.roleGoodExp is nil, why?")
  end
  if not self._rolesIndex then
    LogError("BattleWinAccountDialog", "battle account SBattleEnd.rolesIndex is nil, 所以没有顺序")
  end
  local printDataList = self._roleInfo
  printDataList = self._goodExpInfo
  for k, v in pairs(printDataList) do
    LogInfoFormat("BattleWinAccountDialog", "SBattleEnd.roleGoodExp key %s value %s", k, v)
  end
  printDataList = self._rolesIndex
  for k, v in pairs(printDataList) do
    LogInfoFormat("BattleWinAccountDialog", "SBattleEnd.rolesIndex key %s value %s", k, v)
  end
  for key, exp in pairs(self._roleInfo) do
    local goodExpNum = 0
    if self._goodExpInfo then
      for goodexpKey, goodexp in pairs(self._goodExpInfo) do
        if key == goodexpKey then
          goodExpNum = goodexp
          break
        end
      end
    end
    local sortIndex
    if self._rolesIndex then
      for sort, sortRoleKey in ipairs(self._rolesIndex) do
        if key == sortRoleKey then
          sortIndex = sort
        end
      end
    end
    table.insert(self._data, {
      roleKey = key,
      deltaExp = exp,
      index = sortIndex,
      hasShow = true,
      goodExp = goodExpNum
    })
  end
  table.sort(self._data, function(a, b)
    if a == b then
      return false
    end
    if a.index and b.index then
      return a.index > b.index
    elseif not a.index and b.index then
      return false
    elseif a.index and not b.index then
      return true
    else
      return false
    end
  end)
  self._roleFrame:ReloadAllCell()
  self._alternativeRoleFrame:ReloadAllCell()
  if self._data[1] then
    self:OnCharCellAnimationEnd(self._data[1].index)
  else
    self._roleExpShowOver = "true"
  end
end

function BattleWinAccountDialog:OnUpdate(notification)
  if self._tween then
    local finishi = self._tween:update(notification.userInfo.deltaTime)
    local des
    local str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
    if self._IsLevelUp then
      des = self._tween.subject.value / self._preLevelExpMax
      if 1 <= des then
        self._playerExpProgress:SetFillAmount(0)
        local value = self._tween.subject.value - self._preLevelExpMax
        des = value / self._currentLevelExpMax
        str = string.gsub(str, "%$parameter1%$", tostring(math.floor(value)))
        str = string.gsub(str, "%$parameter2%$", tostring(math.floor(self._currentLevelExpMax)))
        self._playerLevelNum:SetText(NekoData.BehaviorManager.BM_Game:GetUserLevel())
      else
        str = string.gsub(str, "%$parameter1%$", tostring(math.floor(self._tween.subject.value)))
        str = string.gsub(str, "%$parameter2%$", tostring(math.floor(self._preLevelExpMax)))
        self._playerLevelNum:SetText(NekoData.BehaviorManager.BM_Game:GetUserLevel() - 1)
      end
    else
      des = self._tween.subject.value / self._currentLevelExpMax
      str = string.gsub(str, "%$parameter1%$", tostring(math.floor(self._tween.subject.value)))
      str = string.gsub(str, "%$parameter2%$", tostring(math.floor(self._currentLevelExpMax)))
    end
    self._PlayerExpNum:SetText(str)
    self._playerExpBackProgress:SetFillAmount(des)
    if finishi then
      self._tween = nil
      self:OnPlayerExpShowEnd()
    end
  end
  if self._tweenHP then
    local finishi = self._tweenHP:update(notification.userInfo.deltaTime)
    local des = self._tweenHP.subject.value / self.mTotalHP
    local Num1 = string.format("%.2f", des * 100)
    self._RemainNum1:SetText(Num1 .. "%")
    self._progress:SetFillAmount(des)
    if finishi then
      self._tweenHP = nil
    end
  end
end

function BattleWinAccountDialog:ShowItemAccount()
  self._data = self._awardList or {}
  SortItemByPinji(self)
  local moneyData = {}
  for k, v in pairs(self._currency) do
    local item = Item.Create(k)
    table.insert(moneyData, {item = item, num = v})
  end
  table.sort(moneyData, function(a, b)
    local aId, bId = a.item:GetID(), b.item:GetID()
    return aId > bId
  end)
  for _, v in ipairs(moneyData) do
    table.insert(self._data, 1, v)
  end
  local battleId = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleId()
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  local isShowSummerEchoesRank = battleId and bm:IsChallengeBattle(battleId) and bm:GetBattleResult()
  if #self._data == 0 or isShowSummerEchoesRank then
    self._itemShowOver = "true"
    self._itemFrame:SetSlide(true)
    self._freezing = true
    if self._freezeUITimeTask then
      GameTimer.RemoveTask(self._freezeUITimeTask)
      self._freezeUITimeTask = nil
    end
    self._freezeUITimeTask = GameTimer.AddTask(0.6, -1, function()
      self._freezing = false
    end)
    if self._IsLevelUp then
      local data = {}
      local userlevel = NekoData.BehaviorManager.BM_Game:GetUserLevel()
      local recorder = CPlayerLevel:GetRecorder(userlevel)
      data.level = userlevel
      data.strengthLimit = recorder.strengthLimit
      data.strengthGet = recorder.strengthGet
      NekoData.DataManager.DM_Game:OnSPlayerLevelUp(data)
      DialogManager.CreateSingletonDialog("base.playerlevelupdialog"):SetData(data)
      LuaNotificationCenter.PostNotification(Common.n_StrengthLimitChanged, nil, nil)
    end
    if isShowSummerEchoesRank then
      self._showScoreDialog = DialogManager.CreateDialog("activity.swimsuitechoes.challenge.scoredialog", self._itemField._uiObject)
      self._showScoreDialog:Init()
    end
    return
  else
    self._itemShowOver = "showing"
  end
  for i, d in ipairs(self._data) do
    d.index = i
    d.hasShow = false
  end
  self._itemFrame:ReloadAllCell()
  self._itemFrame:SetSlide(false)
  self:OnItemCellAnimationEnd(self._data[1].index)
end

function BattleWinAccountDialog:NumberOfCell(frame)
  if frame == self._roleFrame then
    return #self._data - self._alternativeRoleNum
  elseif frame == self._alternativeRoleFrame then
    return self._alternativeRoleNum
  else
    return #self._data
  end
end

function BattleWinAccountDialog:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "battle.battleaccount.battlewinaccountcell"
  elseif frame == self._roleFrame then
    return "battle.battleaccount.battlewinaccountcharcell"
  elseif frame == self._alternativeRoleFrame then
    return "battle.battleaccount.battlewinaccountcharcell"
  end
end

function BattleWinAccountDialog:DataAtIndex(frame, index)
  if frame == self._roleFrame then
    return self._data[self._alternativeRoleNum + index]
  elseif frame == self._alternativeRoleFrame then
    return self._data[index]
  else
    return self._data[index]
  end
end

function BattleWinAccountDialog:StraightToPlayerExpShowEnd()
  if self._tween then
    self._playerExpBackProgress:SetFillAmount(self._desBack)
    if self._IsLevelUp then
      self._playerExpProgress:SetFillAmount(0)
    end
    local playerInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
    local currentLevelExpNum = playerInfo.userexp
    local str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(currentLevelExpNum))
    str = string.gsub(str, "%$parameter2%$", tostring(self._currentLevelExpMax))
    self._PlayerExpNum:SetText(str)
    self._playerLevelNum:SetText(NekoData.BehaviorManager.BM_Game:GetUserLevel())
    self._tween = nil
  end
  self:OnPlayerExpShowEnd()
end

function BattleWinAccountDialog:OnNextClicked()
  if self._clientGM then
    self:Destroy()
    return
  end
  if not self._freezing then
    LogInfoFormat("BattleWinAccountDialog", "clickedfunction _roleExpShowOver %s _itemShowOver %s _playerExpShowOver %s", self._roleExpShowOver, self._itemShowOver, self._playerExpShowOver)
    if self._itemShowOver == "showing" then
      self._itemFrame:FireEvent("PlayAllItemAnimation")
    elseif self._itemShowOver == "true" then
      self._itemShowOver = nil
      if self._itemFrame then
        self._itemFrame:Destroy()
        self._itemFrame = nil
      end
      self._itemField:SetActive(false)
      self._playerExpPanel:SetActive(false)
      if self._bossRemainHP then
        self._bossRemainHP:SetActive(false)
      end
      if self._showScoreDialog then
        self._showScoreDialog:Destroy()
      end
      self:ShowCharAccount()
    elseif self._roleExpShowOver == "showing" then
      self._roleFrame:FireEvent("PlayAllCharAnimation")
      self._alternativeRoleFrame:FireEvent("PlayAllCharAnimation")
    elseif self._roleExpShowOver == "true" then
      self:Destroy()
    elseif self._playerExpShowOver == "showing" then
      self:StraightToPlayerExpShowEnd()
    else
      self:Destroy()
    end
  end
end

function BattleWinAccountDialog:OnReportBtnClicked()
  DialogManager.CreateSingletonDialog("battle.battleaccount.battlereportdialog")
end

function BattleWinAccountDialog:OnTipsDestroy(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" and self._itemFrame then
    self._itemFrame:FireEvent("SetItemSelectedState", nil)
  end
end

function BattleWinAccountDialog:SetSelectedID(args)
  self._itemFrame:FireEvent("SetItemSelectedState", args)
end

function BattleWinAccountDialog:SetNotSelect()
  self._itemFrame:FireEvent("SetItemSelectedState", nil)
end

function BattleWinAccountDialog:OnCharCellAnimationEnd(index)
  self._roleFrame:FireEvent("PlayCharCellAnimation", index)
  self._alternativeRoleFrame:FireEvent("PlayCharCellAnimation", index)
end

function BattleWinAccountDialog:OnItemCellAnimationEnd(index)
  self._itemFrame:FireEvent("PlayItemCellAnimation", index)
end

function BattleWinAccountDialog:OnAnimationEnd(handler, stateName, normalizedTime)
  if not self._clientGM and (stateName == "BattleWinAccount" or stateName == "BattleWinAccount_newyear") and self._playerExpShowOver ~= "true" then
    self:ShowPlayerExp()
  end
end

function BattleWinAccountDialog:OnPlayerExpShowEnd()
  LogInfoFormat("BattleWinAccountDialog", "OnPlayerExpShowEnd #_data = %s, _roleExpShowOver %s, _itemShowOver %s", #self._data, self._roleExpShowOver, self._itemShowOver)
  self._playerExpShowOver = "true"
  self:ShowItemAccount()
end

function BattleWinAccountDialog:OnCharCellShowTaskOver(cellData)
  if cellData.index and not self._roleShowOverCountTable[cellData.index] then
    self._roleShowOverCountTable[cellData.index] = true
    self._roleShowOverCount = self._roleShowOverCount or 0
    self._roleShowOverCount = self._roleShowOverCount + 1
  elseif not cellData.index then
    self._roleShowOverCount = self._roleShowOverCount or 0
    self._roleShowOverCount = self._roleShowOverCount + 1
  end
  LogInfoFormat("BattleWinAccountDialog", "charshowover count %s, #_data = %s", self._roleShowOverCount, #self._data)
  if self._roleShowOverCount >= #self._data then
    self._roleExpShowOver = "true"
    self._freezing = true
    if self._freezeUITimeTask then
      GameTimer.RemoveTask(self._freezeUITimeTask)
      self._freezeUITimeTask = nil
    end
    self._freezeUITimeTask = GameTimer.AddTask(0.8, -1, function()
      self._freezing = false
    end)
  end
end

function BattleWinAccountDialog:OnItemCellShowTaskOver(cellData)
  self._itemShowOverCount = self._itemShowOverCount or 0
  self._itemShowOverCount = self._itemShowOverCount + 1
  if self._itemShowOverCount <= #self._data then
    self._itemFrame:MoveDownToIndex(self._itemShowOverCount)
  end
  LogInfoFormat("BattleWinAccountDialog", "itemshowover count %s, #_data = %s", self._itemShowOverCount, #self._data)
  if self._itemShowOverCount >= #self._data then
    self._itemShowOver = "true"
    self._itemFrame:SetSlide(true)
    self._freezing = true
    if self._freezeUITimeTask then
      GameTimer.RemoveTask(self._freezeUITimeTask)
      self._freezeUITimeTask = nil
    end
    self._freezeUITimeTask = GameTimer.AddTask(0.6, -1, function()
      self._freezing = false
    end)
    if self._IsLevelUp then
      local data = {}
      local userlevel = NekoData.BehaviorManager.BM_Game:GetUserLevel()
      local recorder = CPlayerLevel:GetRecorder(userlevel)
      data.level = userlevel
      data.strengthLimit = recorder.strengthLimit
      data.strengthGet = recorder.strengthGet
      NekoData.DataManager.DM_Game:OnSPlayerLevelUp(data)
      DialogManager.CreateSingletonDialog("base.playerlevelupdialog"):SetData(data)
      LuaNotificationCenter.PostNotification(Common.n_StrengthLimitChanged, nil, nil)
    end
  end
end

function BattleWinAccountDialog:ShowPlayerExpFullText()
  local CPlayerLevelTable = BeanManager.GetTableByName("role.cplayerlevel")
  local userLevel = NekoData.BehaviorManager.BM_Game:GetUserLevel()
  local recorder = CPlayerLevelTable:GetRecorder(userLevel)
  if recorder.typeid == 0 then
    self._playerExpFullText:SetActive(false)
    return
  end
  local currentMaxLevel = recorder.roleMaxLv
  if 90 <= currentMaxLevel then
    return
  else
    local allID = CPlayerLevelTable:GetAllIds()
    for i, v in ipairs(allID) do
      recorder = CPlayerLevelTable:GetRecorder(v)
      if currentMaxLevel < recorder.roleMaxLv then
        local str = CStringRes:GetRecorder(1438).msgTextID
        str = TextManager.GetText(str)
        str = string.gsub(str, "%$parameter1%$", tostring(recorder.id))
        str = string.gsub(str, "%$parameter2%$", tostring(CRoleLevelCfgTable:GetRecorder(recorder.roleMaxLv).clientBreakLevel))
        str = string.gsub(str, "%$parameter3%$", tostring(CRoleLevelCfgTable:GetRecorder(recorder.roleMaxLv).clientLevel))
        self._playerExpFullText:SetText(str)
        self._playerExpFullText:SetActive(true)
        break
      end
    end
  end
end

function BattleWinAccountDialog:MergeSameTtems()
  local resultList = {}
  local tempMap = {}
  for i, itemInfo in ipairs(self._awardList) do
    if tempMap[itemInfo.id] then
      tempMap[itemInfo.id].number = tempMap[itemInfo.id].number + itemInfo.number
    else
      tempMap[itemInfo.id] = itemInfo
    end
  end
  for k, v in pairs(tempMap) do
    table.insert(resultList, v)
  end
  self._awardList = resultList
end

return BattleWinAccountDialog
