local TableFrame = require("framework.ui.frame.table.tableframe")
local CSrChallengeBuff = BeanManager.GetTableByName("activity.csrchallengebuff")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activitysummer2"
MainDialog.AssetName = "ActivitySummer2ChallengeMain"

function MainDialog:Ctor(...)
  MainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._selectEntrys = {}
  self._functionID = 46001601
  self._constructionID = 21
end

function MainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2147))
  self:GetChild("BackBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2147))
  self:GetChild("BossFrame/BossDetail/Back/Txt3"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2157))
  self:GetChild("TopBtnFrame/RankBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2161))
  self:GetChild("TopBtnFrame/RewardBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2169))
  self:GetChild("Frame/TitleBack/Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2159))
  self:GetChild("BossFrame/BossDetail/Reward/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2158))
  self:GetChild("BossFrame/BossDetail/StartBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2162))
  self:GetChild("BossFrame/BossDetail/Back/Name"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2147))
  self:GetChild("BossFrame/BossDetail/Back/Txt2"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2156))
  self._noChallengeTxt = self:GetChild("BossFrame/BossDetail/Back/TxtNoRecord")
  self._noChallengeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1420))
  self._noRankTxt = self:GetChild("BossFrame/BossDetail/Back/Txt3NoRank")
  self._noRankTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1421))
  self._noRankTxt:SetActive(false)
  self._mosterImg = self:GetChild("BossFrame/BossDetail/Back/Photo")
  self._awardRedDot = self:GetChild("TopBtnFrame/RewardBtn/RedDot")
  self._awardRedDot:SetActive(false)
  self._totalTxt = self:GetChild("BossFrame/BossDetail/Reward/Num")
  self._timeTxt = self:GetChild("BossFrame/BossDetail/Back/Time")
  self._curRecordTxt = self:GetChild("BossFrame/BossDetail/Back/Txt2Num")
  self._rankTxt = self:GetChild("BossFrame/BossDetail/Back/Rank")
  self._scrollbar = self:GetChild("Scrollbar")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self:GetChild("TopBtnFrame/RankBtn"):Subscribe_PointerClickEvent(self.OnRankBtnClick, self)
  self:GetChild("TopBtnFrame/RewardBtn"):Subscribe_PointerClickEvent(self.OnRewardBtnClick, self)
  self:GetChild("BossFrame/BossDetail/StartBtn"):Subscribe_PointerClickEvent(self.OnStartBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.Init, Common.n_OnSOpenChallengeMode, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAwardReddot, Common.n_OnSOpensummerReward, nil)
end

function MainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function MainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function MainDialog:OnBackBtnClicked()
  self:Destroy()
end

function MainDialog:Init()
  local data = self._bm:GetChallengeModeData()
  self._buffList = {}
  for _, v in ipairs(CSrChallengeBuff:GetAllIds()) do
    local record = CSrChallengeBuff:GetRecorder(v)
    table.insert(self._buffList, {
      id = v,
      cfg = record,
      isUnlock = data.totalScore >= record.unlockCondition,
      state = 0
    })
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  self:Refresh()
  self:RefreshAwardReddot()
end

function MainDialog:Refresh()
  local data = self._bm:GetChallengeModeData()
  self._totalTxt:SetText(data.totalScore)
  self._curRecordTxt:SetText(data.curScore)
  if data.passTime > 0 and data.curScore then
    self._curRecordTxt:SetActive(true)
    local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
    str = TextManager.GetText(str)
    local num = data.passTime / 1000
    local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
    str = string.gsub(str, "%$parameter1%$", ret)
    self._timeTxt:SetText(str)
    self._noChallengeTxt:SetActive(false)
    self._timeTxt:SetActive(true)
  else
    self._noChallengeTxt:SetActive(true)
    self._timeTxt:SetActive(false)
    self._curRecordTxt:SetActive(false)
  end
  if 0 < data.rank then
    self._rankTxt:SetActive(true)
    self._rankTxt:SetText(data.rank)
    self._noRankTxt:SetActive(false)
  else
    self._rankTxt:SetActive(false)
    self._noRankTxt:SetActive(true)
  end
end

function MainDialog:OnRankBtnClick()
  DialogManager.CreateSingletonDialog("activity.swimsuitechoes.challenge.rank.rankmaindialog"):Init()
end

function MainDialog:OnRewardBtnClick()
  DialogManager.CreateSingletonDialog("activity.swimsuitechoes.challenge.awarddialog"):Refresh()
end

function MainDialog:OpenTeam()
  NekoData.DataManager.DM_Team:ClearSupportRole()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo("SwimSuitEchoesChallenge", self._functionID, self._constructionID)
  end
end

function MainDialog:OnStartBtnClick()
  local cprotocol = LuaNetManager.CreateProtocol("protocol.activity.cconfirmsummerentries")
  if cprotocol then
    cprotocol.entries = self._selectEntrys
    cprotocol:Send()
  end
end

function MainDialog:OnCellClicked(id)
  self:SelectCalculate(id)
end

function MainDialog:SelectCalculate(id)
  local entry = CSrChallengeBuff:GetRecorder(id)
  if not entry then
    LogErrorFormat("MainDialog", "No Exist  CSrChallengeBuff  %s", id)
    return
  end
  local index
  for i, v in pairs(self._selectEntrys) do
    if id == v then
      index = i
      break
    end
  end
  if not index then
    local existSameTypeIDIndex
    for i, v in pairs(self._selectEntrys) do
      local tempRecord = CSrChallengeBuff:GetRecorder(v)
      if tempRecord.typeID == entry.typeID then
        existSameTypeIDIndex = i
        break
      end
    end
    if existSameTypeIDIndex then
      table.remove(self._selectEntrys, existSameTypeIDIndex)
    end
    for i, v in ipairs(self._buffList) do
      if v.cfg.typeID == entry.typeID then
        if v.cfg.id == entry.id then
          self._buffList[i].state = 1
        else
          self._buffList[i].state = -1
        end
      end
    end
    table.insert(self._selectEntrys, id)
    self._frame:FireEvent("Selection", {
      entrytype = entry.typeID,
      id = id
    })
  else
    table.remove(self._selectEntrys, index)
    for i, v in ipairs(self._buffList) do
      if v.cfg.typeID == entry.typeID then
        self._buffList[i].state = 0
      end
    end
    self._frame:FireEvent("CancelSelection", {
      entrytype = entry.typeID
    })
  end
  local s = ""
  for k, v in pairs(self._selectEntrys) do
    s = s .. v .. ","
  end
  LogInfoFormat("MainDialog", "Selection:%s", s)
end

function MainDialog:NumberOfCell(frame)
  return #self._buffList
end

function MainDialog:CellAtIndex(frame, index)
  return "activity.swimsuitechoes.challenge.buffeditcell"
end

function MainDialog:DataAtIndex(frame, index)
  return self._buffList[index]
end

function MainDialog:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollbar:SetActive(true)
    self._scrollbar:SetScrollSize(height / total)
    self._scrollbar:SetScrollValue(proportion)
  else
    self._scrollbar:SetActive(false)
  end
end

function MainDialog:OnDialogDestroy(notification)
  local dialogName = notification.userInfo._dialogName
  if dialogName == "base.hidemaincitymodaldialog" then
    local cprotocol = LuaNetManager.CreateProtocol("protocol.activity.copenchallengemode")
    if cprotocol then
      cprotocol:Send()
    end
  end
end

function MainDialog:RefreshAwardReddot()
  self._awardRedDot:SetActive(self._bm:HasAwardRedDot())
end

return MainDialog
