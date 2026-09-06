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
local OfflineSweepResultDialg = class("OfflineSweepResultDialg", Dialog)
OfflineSweepResultDialg.AssetBundleName = "ui/layouts.dispatchbattle"
OfflineSweepResultDialg.AssetName = "DispatchBattleWinAccount"

function OfflineSweepResultDialg:Ctor(...)
  OfflineSweepResultDialg.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_OfflineSweep
  self._data = {}
  self._playerExpShowOver = ""
  self._roleExpShowOver = ""
  self._roleShowOverCountTable = {}
  self._alternativeRoleNum = 0
end

function OfflineSweepResultDialg:OnCreate()
  self._back = self:GetChild("Back")
  self._roleFieldPanel = self:GetChild("Panel/CharFrame1")
  self._roleField = self:GetChild("Panel/CharFrame1/Frame")
  self._alternativeRoleFieldPanel = self:GetChild("Panel/CharFrame2")
  self._alternativeRoleField = self:GetChild("Panel/CharFrame2/Frame")
  self._live2DModel = self:GetChild("Role/Live2D")
  self._photo = self:GetChild("Role/Photo")
  self._winDialogPanel = self:GetChild("Panel/Dialog")
  self._winDialog = self:GetChild("Panel/Dialog/Text")
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
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  self._animator:Play("BattleWinAccount")
  self._roleFrame = GridFrame.Create(self._roleField, self, true, 3, false)
  self._alternativeRoleFrame = GridFrame.Create(self._alternativeRoleField, self, true, 3, false)
  if NekoData.BehaviorManager.BM_Dungeon:GetMode() == "auto" then
    self._timer = GameTimer.AddTask(3, 3, self.OnNextClicked, self)
    return
  end
end

function OfflineSweepResultDialg:OnDestroy()
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
  self._data = {}
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
  DialogManager.DestroySingletonDialog("battle.battleaccount.battlereportdialog")
end

function OfflineSweepResultDialg:Show(clientGM, roleId)
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
        LogWarningFormat("OfflineSweepResultDialg", "role id %s cnpcshape battleEmotion %s dont exist in cemotion", role:GetId(), role:GetBattleEmotion())
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
  self._roleInfo, self._goodExpInfo, self._rolesIndex, self._playerExp = NekoData.BehaviorManager.BM_OfflineSweep:GetAwardResult()
  local roleList = {}
  local standRoleList = {}
  for key, exp in pairs(self._roleInfo) do
    table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(key))
  end
  if #roleList == 0 then
    table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(1))
  end
  standRoleList = roleList
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
      LogWarningFormat("OfflineSweepResultDialg", "role id %s cnpcshape battleEmotion %s dont exist in cemotion", standRoleList[i]:GetId(), standRoleList[i]:GetBattleEmotion())
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
end

function OfflineSweepResultDialg:ShowPlayerExp()
  self._playerExpPanel:SetActive(true)
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
      if 0 > first.value then
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

function OfflineSweepResultDialg:ShowCharAccount()
  self:ShowPlayerExpFullText()
  self._roleFieldPanel:SetActive(true)
  self._roleExpShowOver = "showing"
  self._data = {}
  if not self._goodExpInfo then
    LogError("OfflineSweepResultDialg", "battle account SBattleEnd.roleGoodExp is nil, why?")
  end
  if not self._rolesIndex then
    LogError("OfflineSweepResultDialg", "battle account SBattleEnd.rolesIndex is nil, 所以没有顺序")
  end
  local printDataList = self._roleInfo
  for k, v in pairs(printDataList) do
    LogInfoFormat("OfflineSweepResultDialg", "SBattleEnd.roleExp key %s value %s", k, v)
  end
  printDataList = self._goodExpInfo
  for k, v in pairs(printDataList) do
    LogInfoFormat("OfflineSweepResultDialg", "SBattleEnd.roleGoodExp key %s value %s", k, v)
  end
  printDataList = self._rolesIndex
  for k, v in pairs(printDataList) do
    LogInfoFormat("OfflineSweepResultDialg", "SBattleEnd.rolesIndex key %s value %s", k, v)
  end
  self._alternativeRoleNum = 0
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
    if 3 < sortIndex then
      self._alternativeRoleNum = self._alternativeRoleNum + 1
    end
    table.insert(self._data, {
      roleKey = key,
      deltaExp = exp,
      index = sortIndex,
      hasShow = true,
      goodExp = goodExpNum
    })
  end
  if self._alternativeRoleNum > 0 then
    self._alternativeRoleFieldPanel:SetActive(true)
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

function OfflineSweepResultDialg:OnUpdate(notification)
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
end

function OfflineSweepResultDialg:NumberOfCell(frame)
  if frame == self._roleFrame then
    return #self._data - self._alternativeRoleNum
  elseif frame == self._alternativeRoleFrame then
    return self._alternativeRoleNum
  end
end

function OfflineSweepResultDialg:CellAtIndex(frame, index)
  if frame == self._roleFrame then
    return "battle.battleaccount.battlewinaccountcharcell"
  elseif frame == self._alternativeRoleFrame then
    return "battle.battleaccount.battlewinaccountcharcell"
  end
end

function OfflineSweepResultDialg:DataAtIndex(frame, index)
  if frame == self._roleFrame then
    return self._data[self._alternativeRoleNum + index]
  elseif frame == self._alternativeRoleFrame then
    return self._data[index]
  end
end

function OfflineSweepResultDialg:StraightToPlayerExpShowEnd()
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

function OfflineSweepResultDialg:OnNextClicked()
  if self._clientGM then
    self:Destroy()
    return
  end
  if not self._freezing then
    LogInfoFormat("OfflineSweepResultDialg", "clickedfunction _roleExpShowOver %s  _playerExpShowOver %s", self._roleExpShowOver, self._playerExpShowOver)
    if self._roleExpShowOver == "showing" then
      self._roleFrame:FireEvent("PlayAllCharAnimation")
      self._alternativeRoleFrame:FireEvent("PlayAllCharAnimation")
    elseif self._roleExpShowOver == "true" then
      local dialog = DialogManager.CreateSingletonDialog("mainline.offlinesweep.offlinesweepaccountdialog")
      self:Destroy()
    elseif self._playerExpShowOver == "showing" then
      self:StraightToPlayerExpShowEnd()
    end
  end
end

function OfflineSweepResultDialg:OnReportBtnClicked()
  DialogManager.CreateSingletonDialog("battle.battleaccount.battlereportdialog")
end

function OfflineSweepResultDialg:OnCharCellAnimationEnd(index)
  self._roleFrame:FireEvent("PlayCharCellAnimation", index)
  self._alternativeRoleFrame:FireEvent("PlayCharCellAnimation", index)
end

function OfflineSweepResultDialg:OnAnimationEnd(handler, stateName, normalizedTime)
  if not self._clientGM and (stateName == "BattleWinAccount" or stateName == "BattleWinAccount_newyear") and self._playerExpShowOver ~= "true" then
    self:ShowPlayerExp()
  end
end

function OfflineSweepResultDialg:OnPlayerExpShowEnd()
  LogInfoFormat("OfflineSweepResultDialg", "OnPlayerExpShowEnd #_data = %s, _roleExpShowOver %s", #self._data, self._roleExpShowOver)
  self._playerExpShowOver = "true"
  self:ShowCharAccount()
end

function OfflineSweepResultDialg:OnCharCellShowTaskOver(cellData)
  if cellData.index and not self._roleShowOverCountTable[cellData.index] then
    self._roleShowOverCountTable[cellData.index] = true
    self._roleShowOverCount = self._roleShowOverCount or 0
    self._roleShowOverCount = self._roleShowOverCount + 1
  elseif not cellData.index then
    self._roleShowOverCount = self._roleShowOverCount or 0
    self._roleShowOverCount = self._roleShowOverCount + 1
  end
  LogInfoFormat("OfflineSweepResultDialg", "charshowover count %s, #_data = %s", self._roleShowOverCount, #self._data)
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

function OfflineSweepResultDialg:ShowPlayerExpFullText()
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

return OfflineSweepResultDialg
