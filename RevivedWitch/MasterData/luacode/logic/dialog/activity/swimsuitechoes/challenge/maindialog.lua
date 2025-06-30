-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CSrChallengeBuff = (BeanManager.GetTableByName)("activity.csrchallengebuff")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activitysummer2"
MainDialog.AssetName = "ActivitySummer2ChallengeMain"
MainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainDialog, _ENV
  ((MainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._selectEntrys = {}
  self._functionID = 46001601
  self._constructionID = 21
end

MainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self:GetChild("Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2147))
  ;
  (self:GetChild("BackBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2147))
  ;
  (self:GetChild("BossFrame/BossDetail/Back/Txt3")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2157))
  ;
  (self:GetChild("TopBtnFrame/RankBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2161))
  ;
  (self:GetChild("TopBtnFrame/RewardBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2169))
  ;
  (self:GetChild("Frame/TitleBack/Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2159))
  ;
  (self:GetChild("BossFrame/BossDetail/Reward/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2158))
  ;
  (self:GetChild("BossFrame/BossDetail/StartBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2162))
  ;
  (self:GetChild("BossFrame/BossDetail/Back/Name")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2147))
  ;
  (self:GetChild("BossFrame/BossDetail/Back/Txt2")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2156))
  self._noChallengeTxt = self:GetChild("BossFrame/BossDetail/Back/TxtNoRecord")
  ;
  (self._noChallengeTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1420))
  self._noRankTxt = self:GetChild("BossFrame/BossDetail/Back/Txt3NoRank")
  ;
  (self._noRankTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1421))
  ;
  (self._noRankTxt):SetActive(false)
  self._mosterImg = self:GetChild("BossFrame/BossDetail/Back/Photo")
  self._awardRedDot = self:GetChild("TopBtnFrame/RewardBtn/RedDot")
  ;
  (self._awardRedDot):SetActive(false)
  self._totalTxt = self:GetChild("BossFrame/BossDetail/Reward/Num")
  self._timeTxt = self:GetChild("BossFrame/BossDetail/Back/Time")
  self._curRecordTxt = self:GetChild("BossFrame/BossDetail/Back/Txt2Num")
  self._rankTxt = self:GetChild("BossFrame/BossDetail/Back/Rank")
  self._scrollbar = self:GetChild("Scrollbar")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self:GetChild("TopBtnFrame/RankBtn")):Subscribe_PointerClickEvent(self.OnRankBtnClick, self)
  ;
  (self:GetChild("TopBtnFrame/RewardBtn")):Subscribe_PointerClickEvent(self.OnRewardBtnClick, self)
  ;
  (self:GetChild("BossFrame/BossDetail/StartBtn")):Subscribe_PointerClickEvent(self.OnStartBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Init, Common.n_OnSOpenChallengeMode, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAwardReddot, Common.n_OnSOpensummerReward, nil)
end

MainDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

MainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

MainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

MainDialog.Init = function(self)
  -- function num : 0_5 , upvalues : _ENV, CSrChallengeBuff
  local data = (self._bm):GetChallengeModeData()
  self._buffList = {}
  for _,v in ipairs(CSrChallengeBuff:GetAllIds()) do
    local record = CSrChallengeBuff:GetRecorder(v)
    ;
    (table.insert)(self._buffList, {id = v, cfg = record, isUnlock = record.unlockCondition <= data.totalScore, state = 0})
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  self:Refresh()
  self:RefreshAwardReddot()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MainDialog.Refresh = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local data = (self._bm):GetChallengeModeData()
  ;
  (self._totalTxt):SetText(data.totalScore)
  ;
  (self._curRecordTxt):SetText(data.curScore)
  if data.passTime > 0 and data.curScore then
    (self._curRecordTxt):SetActive(true)
    local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1107)).msgTextID
    str = (TextManager.GetText)(str)
    local num = data.passTime / 1000
    local ret = ((NekoData.BehaviorManager).BM_Game):GetPreciseDecimal(num, 1)
    str = (string.gsub)(str, "%$parameter1%$", ret)
    ;
    (self._timeTxt):SetText(str)
    ;
    (self._noChallengeTxt):SetActive(false)
    ;
    (self._timeTxt):SetActive(true)
  else
    do
      ;
      (self._noChallengeTxt):SetActive(true)
      ;
      (self._timeTxt):SetActive(false)
      ;
      (self._curRecordTxt):SetActive(false)
      if data.rank > 0 then
        (self._rankTxt):SetActive(true)
        ;
        (self._rankTxt):SetText(data.rank)
        ;
        (self._noRankTxt):SetActive(false)
      else
        ;
        (self._rankTxt):SetActive(false)
        ;
        (self._noRankTxt):SetActive(true)
      end
    end
  end
end

MainDialog.OnRankBtnClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.challenge.rank.rankmaindialog")):Init()
end

MainDialog.OnRewardBtnClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.challenge.awarddialog")):Refresh()
end

MainDialog.OpenTeam = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((NekoData.DataManager).DM_Team):ClearSupportRole()
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo("SwimSuitEchoesChallenge", self._functionID, self._constructionID)
  end
end

MainDialog.OnStartBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local cprotocol = (LuaNetManager.CreateProtocol)("protocol.activity.cconfirmsummerentries")
  if cprotocol then
    cprotocol.entries = self._selectEntrys
    cprotocol:Send()
  end
end

MainDialog.OnCellClicked = function(self, id)
  -- function num : 0_11
  self:SelectCalculate(id)
end

MainDialog.SelectCalculate = function(self, id)
  -- function num : 0_12 , upvalues : CSrChallengeBuff, _ENV
  local entry = CSrChallengeBuff:GetRecorder(id)
  if not entry then
    LogErrorFormat("MainDialog", "No Exist  CSrChallengeBuff  %s", id)
    return 
  end
  local index = nil
  for i,v in pairs(self._selectEntrys) do
    if id == v then
      index = i
      break
    end
  end
  do
    if not index then
      local existSameTypeIDIndex = nil
      for i,v in pairs(self._selectEntrys) do
        local tempRecord = CSrChallengeBuff:GetRecorder(v)
        if tempRecord.typeID == entry.typeID then
          existSameTypeIDIndex = i
          break
        end
      end
      do
        do
          if existSameTypeIDIndex then
            (table.remove)(self._selectEntrys, existSameTypeIDIndex)
          end
          for i,v in ipairs(self._buffList) do
            -- DECOMPILER ERROR at PC65: Confused about usage of register: R10 in 'UnsetPending'

            if (v.cfg).typeID == entry.typeID then
              if (v.cfg).id == entry.id then
                ((self._buffList)[i]).state = 1
              else
                -- DECOMPILER ERROR at PC69: Confused about usage of register: R10 in 'UnsetPending'

                ;
                ((self._buffList)[i]).state = -1
              end
            end
          end
          ;
          (table.insert)(self._selectEntrys, id)
          ;
          (self._frame):FireEvent("Selection", {entrytype = entry.typeID, id = id})
          ;
          (table.remove)(self._selectEntrys, index)
          for i,v in ipairs(self._buffList) do
            -- DECOMPILER ERROR at PC102: Confused about usage of register: R9 in 'UnsetPending'

            if (v.cfg).typeID == entry.typeID then
              ((self._buffList)[i]).state = 0
            end
          end
          ;
          (self._frame):FireEvent("CancelSelection", {entrytype = entry.typeID})
          local s = ""
          for k,v in pairs(self._selectEntrys) do
            s = s .. v .. ","
          end
          LogInfoFormat("MainDialog", "Selection:%s", s)
        end
      end
    end
  end
end

MainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13
  return #self._buffList
end

MainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_14
  return "activity.swimsuitechoes.challenge.buffeditcell"
end

MainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  return (self._buffList)[index]
end

MainDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_16
  local width, height = (self._panel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollbar):SetActive(true)
    ;
    (self._scrollbar):SetScrollSize(height / total)
    ;
    (self._scrollbar):SetScrollValue(proportion)
  else
    ;
    (self._scrollbar):SetActive(false)
  end
end

MainDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_17 , upvalues : _ENV
  local dialogName = (notification.userInfo)._dialogName
  if dialogName == "base.hidemaincitymodaldialog" then
    local cprotocol = (LuaNetManager.CreateProtocol)("protocol.activity.copenchallengemode")
    if cprotocol then
      cprotocol:Send()
    end
  end
end

MainDialog.RefreshAwardReddot = function(self)
  -- function num : 0_18
  (self._awardRedDot):SetActive((self._bm):HasAwardRedDot())
end

return MainDialog

