local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local KillBossPage = class("KillBossPage", Dialog)
local charNumber = 1
KillBossPage.AssetBundleName = "ui/layouts.battlepassnew"
KillBossPage.AssetName = "BattlePassNewBossRush"

function KillBossPage:Ctor(...)
  KillBossPage.super.Ctor(self, ...)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID)
  self._sendStartBattleProtocol = false
  self._havePlayIntoAnimation = false
  self._canShowItemGotten = false
  self._battleShowOver = false
  self._curId = 0
end

function KillBossPage:OnCreate()
  self._panel = self:GetChild("MonFrame")
  self._time = self:GetChild("EndTime")
  self._tipBtn = self:GetChild("Tip")
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
  self._curNumTxt = self:GetChild("MoneyCell/Num1")
  self._curMaxNumTxt = self:GetChild("MoneyCell/Num2")
  self._moneyBack = self:GetChild("MoneyCell")
  self:GetChild("MoneyCell/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1972))
  self:GetChild("Tip/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1924))
  self._dailyTaskBtn = self:GetChild("DailyTask")
  self._startBattleBtn = self:GetChild("StartBattle")
  self._weeklyRewardBtn = self:GetChild("WeeklyReward")
  self._leftTime = self:GetChild("EndTime")
  self._startBattleBtn_Text = self:GetChild("StartBattle/Text")
  self._weeklyRewardBtn_Text = self:GetChild("WeeklyReward/Text")
  self._dailyTaskBtn_Text = self:GetChild("DailyTask/Text")
  self._weeklyRewardBtn_Dot = self:GetChild("WeeklyReward/Dot")
  self._dailyTaskBtn_Dot = self:GetChild("DailyTask/Dot")
  self._rightBtn = self:GetChild("RightBtn")
  self._leftBtn = self:GetChild("LeftBtn")
  self._progress = self:GetChild("MoneyCell/BackGround/Progress")
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._dailyTaskBtn:Subscribe_PointerClickEvent(self.OnDailyTaskClicked, self)
  self._startBattleBtn:Subscribe_PointerClickEvent(self.OnStartBattleClicked, self)
  self._weeklyRewardBtn:Subscribe_PointerClickEvent(self.OnWeeklyRewardBtnClicked, self)
  self._frame = TableFrame.Create(self._panel, self, false)
  LuaNotificationCenter.AddObserver(self, self.OnRoleLevelUp, Common.n_SWitchInAgainstBossUpLv, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEndBattle, Common.n_SEndAgainstBossBattle, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_SReturnAgainstBossInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleLevelUp, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskRedDot, Common.n_NewDreamSpiralTaskRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshChipInfo, Common.n_NewDreamSpiralRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  self._startBattleBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1950))
  self._dailyTaskBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1948))
  self._weeklyRewardBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1949))
end

function KillBossPage:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("activity.giftoftime.killbosstaskdialog")
  DialogManager.DestroySingletonDialog("activity.giftoftime.killbossawarddialog")
  if self._frame then
    self._frame:Destroy()
  end
end

function KillBossPage:Refresh()
  self._leftTimeData = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetWeeklyLeftTime()
  self:UpdateLeftTime()
  if self._timerId ~= 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
  end
  self._timerId = GameTimer.AddTask(1, 1, self.UpdateLeftTime, self)
  self._weeklyRewardBtn_Dot:SetActive(self._bm:HasWeekAward())
  self._dailyTaskBtn_Dot = self:GetChild("DailyTask/Dot")
  self._curBossId = self._bm:GetCurChallengingId()
  self:RefreshCharInfo()
  self:RefreshTaskRedDot()
  self:RefreshChipInfo()
  self:RefreshMonsterInfo()
end

function KillBossPage:RefreshChipInfo()
  self._info = self._bm:GetBaseInfo()
  local chipInfo = self._info.chipInfo
  if chipInfo then
    self._moneyBack:SetActive(true)
    self._curNumTxt:SetText(tostring(chipInfo.has))
    self._curMaxNumTxt:SetText(tostring(chipInfo.max))
    self._progress:SetFillAmount(chipInfo.has / chipInfo.max)
  else
    self._moneyBack:SetActive(false)
    LogWarning("nil chipinfo")
  end
end

function KillBossPage:RefreshTaskRedDot()
  self._dailyTaskBtn_Dot:SetActive(self._bm:HasTasksAward())
end

function KillBossPage:RefreshCharInfo()
  self._charList = self._bm:GetRoleList()
  for i = 1, charNumber do
    self._char[i].panel:SetActive(false)
  end
  local str = TextManager.GetText(CStringRes:GetRecorder(1773).msgTextID)
  local role, image
  local needNum = 0
  local currentNum = 0
  local redDotShow = self._bm:CanWitchLevelUp()
  for i, char in ipairs(self._charList) do
    self._char[i].panel:SetActive(true)
    self._char[i].level:SetText(string.gsub(str, "%$parameter1%$", char.roleLv))
    role = Role.Create(char.roleId)
    image = role:GetDiamondHeadImageRecord()
    self._char[i].headImg:SetSprite(image.assetBundle, image.assetName)
    self._char[i].healthTxt:SetText(char.blood)
    self._char[i].attackTxt:SetText(char.attack)
    self._char[i].redDot:SetActive(redDotShow)
  end
end

function KillBossPage:RefreshMonsterInfo()
  self._bossList = self._bm:GetMonsterList()
  self._frame:ReloadAllCell()
  local moveToIdx = 0
  for i, v in ipairs(self._bossList) do
    if v.result == 0 then
      moveToIdx = i
      break
    end
  end
  if moveToIdx ~= 0 then
    self._frame:MoveLeftToIndex(moveToIdx)
  else
    self._frame:MoveToRight()
    self._lastBossId = self._bossList[#self._bossList].id
  end
  self._startBattleBtn:SetActive(not self._lastBossId)
end

function KillBossPage:NumberOfCell(frame)
  return #self._bossList
end

function KillBossPage:CellAtIndex(frame, index)
  return "activity.giftoftime.killbosspagemonstercell"
end

function KillBossPage:DataAtIndex(frame, index)
  return self._bossList[index]
end

function KillBossPage:OnTipBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(3)
end

function KillBossPage:OnDailyTaskClicked()
  DialogManager.CreateSingletonDialog("activity.giftoftime.killbosstaskdialog"):Init()
end

function KillBossPage:OnStartBattleClicked()
  if not self._sendStartBattleProtocol and self._curBossId > 0 then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cstartagainstbossbattle")
    for i, v in ipairs(self._bossList) do
      if v.id == self._curBossId then
        self._battleData = v
        break
      end
    end
    self._sendStartBattleProtocol = true
    self._canShowItemGotten = false
    csend:Send()
  end
end

function KillBossPage:OnWeeklyRewardBtnClicked()
  DialogManager.CreateSingletonDialog("activity.giftoftime.killbossawarddialog"):Refresh()
end

function KillBossPage:OnCharPanelClicked(index)
  DialogManager.CreateSingletonDialog("activity.giftoftime.killbosscharacterinfodialog"):SetData(self._charList[index])
end

function KillBossPage:OnEndBattle(notification)
  local bossinfo = notification.userInfo.bossInfo
  self._sendStartBattleProtocol = false
  self._battleResult = bossinfo.result
  LogInfoFormat("KillBossPage", "server battle result %s,score:%s", bossinfo.result, bossinfo.bassPassExpRewards)
  local dialog = DialogManager.CreateSingletonDialog("smallbattle.smallbattledialog")
  dialog:SetData(dialog.TargetType.KillBoss, self._battleResult, self._battleData, self._charList, bossinfo.bassPassExpRewards)
end

function KillBossPage:OnRoleLevelUp()
  self:RefreshCharInfo()
  local dialog = DialogManager.GetDialog("activity.giftoftime.killbosscharacterinfodialog")
  if dialog then
    dialog:SetData(self._charList[1])
  end
end

local function format_str(id, value)
  local s = TextManager.GetText(CStringRes:GetRecorder(id).msgTextID)
  return string.gsub(s, "%$parameter1%$", value)
end

local function GetRemainTimeStr(endTime)
  local str
  if endTime and 0 < endTime then
    local time = endTime
    local day = time // 86400
    local hour = math.ceil(time / 3600)
    if 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(1935).msgTextID, string.format("%d", day), string.format("%d", hour - day * 24))
    else
      str = TextManager.GetText(CStringRes:GetRecorder(1936).msgTextID, hour)
    end
  else
    str = TextManager.GetText(CStringRes:GetRecorder(1936).msgTextID, 0)
  end
  return str
end

function KillBossPage:UpdateLeftTime()
  self._leftTimeData = self._leftTimeData - 1
  if self._leftTimeData < 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
    return
  end
  local str = GetRemainTimeStr(self._leftTimeData)
  self._leftTime:SetText(str)
end

function KillBossPage:OnCurPosChange(frame, proportion)
  if proportion <= 0 then
    self._rightBtn:SetActive(true)
    self._leftBtn:SetActive(false)
  elseif 1 <= proportion then
    self._rightBtn:SetActive(false)
    self._leftBtn:SetActive(true)
  else
    self._rightBtn:SetActive(true)
    self._leftBtn:SetActive(true)
  end
end

function KillBossPage:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "smallbattle.smallbattlefaileddialog" then
    LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
  end
end

return KillBossPage
