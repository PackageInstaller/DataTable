-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CGuildBossInfo = (BeanManager.GetTableByName)("guild.cguildchallengebossinfo")
local CGuildchallengechance = (BeanManager.GetTableByName)("guild.cguildchallengechance")
local LogicCell = require("framework.ui.frame.grid.logiccell")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local GuildBossMainDialog = class("GuildBossMainDialog", Dialog)
GuildBossMainDialog.AssetBundleName = "ui/layouts.guild"
GuildBossMainDialog.AssetName = "GuildBossChoose"
GuildBossMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossMainDialog
  ((GuildBossMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._cellData = {}
  self._bossList = {}
  self._battleLogList = {}
end

GuildBossMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, TableFrame
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._guildTime = self:GetChild("Time")
  ;
  (self._guildTime):SetText("")
  self._guildPoints = self:GetChild("TopBack/Num1")
  ;
  (self._guildPoints):SetText("")
  self._curRank = self:GetChild("TopBack/Num2")
  ;
  (self._curRank):SetText("")
  self._rankBtn = self:GetChild("TopBack/GoBtn")
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._leftBattleTimes = self:GetChild("Progress/NumTimes")
  ;
  (self._leftBattleTimes):SetText("")
  self._tiliLimitText = self:GetChild("Progress/TxtLimit")
  ;
  (self._tiliLimitText):SetActive(false)
  self._progress = self:GetChild("Progress/Line1")
  self._progressPreView = self:GetChild("Progress/Line2")
  self._dot = {}
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R5 in 'UnsetPending'

    (self._dot)[i] = {num = self:GetChild("Progress/Dot" .. i .. "/Num"), addnum = self:GetChild("Progress/Dot" .. i .. "/NumAdd"), dotGrey = self:GetChild("Progress/Dot" .. i .. "/DotGrey"), dot = self:GetChild("Progress/Dot" .. i .. "/Dot")}
  end
  self._battleLogPanel = self:GetChild("RecordArea/RecordFrame")
  self._frame = (GridFrame.Create)(self._battleLogPanel, self, true, 1, true)
  self._mainScrollView = self:GetChild("Frame")
  self._mainScrollViewHelper = (TableFrame.Create)(self._mainScrollView, self, false, true, false)
  self._baseCells = {}
  self._bossList = {}
  self:SetData()
  self._tipsBtn = self:GetChild("Tips/Ibtn")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
end

GuildBossMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_2
  self:Destroy()
end

GuildBossMainDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

GuildBossMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

GuildBossMainDialog.Init = function(self)
  -- function num : 0_5 , upvalues : _ENV, CGuildchallengechance, CGuildBossInfo
  self._data = ((NekoData.BehaviorManager).BM_Guild):GetGuildBossData()
  local startTime = ""
  startTime = startTime .. (os.date)("%m-%d", (self._data).startime // 1000) .. " "
  startTime = startTime .. (os.date)("%H", (self._data).startime // 1000) .. ":"
  startTime = startTime .. (os.date)("%M", (self._data).startime // 1000)
  local endTime = ""
  endTime = endTime .. (os.date)("%m-%d", (self._data).endtime // 1000) .. " "
  endTime = endTime .. (os.date)("%H", (self._data).endtime // 1000) .. ":"
  endTime = endTime .. (os.date)("%M", (self._data).endtime // 1000)
  local timestamp = (os.time)()
  if (self._data).endtime < timestamp * 1000 then
    (self._guildTime):SetText(startTime .. "~" .. endTime .. "已结束")
  else
    ;
    (self._guildTime):SetText(startTime .. "~" .. endTime)
  end
  ;
  (self._guildPoints):SetText((self._data).score)
  if (self._data).rank == -1 then
    (self._curRank):SetText("未上榜")
  else
    if (self._data).rank == -2 then
      (self._curRank):SetText("未挑战")
    else
      ;
      (self._curRank):SetText((self._data).rank)
    end
  end
  ;
  (self._leftBattleTimes):SetText((self._data).chances)
  local maxTili = 0
  local allIds = CGuildchallengechance:GetAllIds()
  for i = 1, #allIds do
    local recorder = CGuildchallengechance:GetRecorder(allIds[i])
    ;
    (((self._dot)[i]).num):SetText(recorder.ap)
    ;
    (((self._dot)[i]).addnum):SetText("+" .. recorder.chance .. "次")
    if maxTili < recorder.ap then
      maxTili = recorder.ap
    end
  end
  if maxTili <= (self._data).costspirit then
    (self._tiliLimitText):SetActive(true)
  else
    ;
    (self._tiliLimitText):SetActive(false)
  end
  ;
  (self._progress):SetFillAmount((self._data).costspirit / maxTili)
  ;
  (self._progressPreView):SetFillAmount(1)
  self._battleLogList = {}
  for k,v in pairs((self._data).damagerecords) do
    (table.insert)(self._battleLogList, v)
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToBottom()
  self._bossList = {}
  local allIds = CGuildBossInfo:GetAllIds()
  for i = 1, #allIds do
    local recorder = CGuildBossInfo:GetRecorder(allIds[i])
    local data = {}
    data.record = recorder
    data.serverData = ((self._data).bossstates)[i]
    ;
    (table.insert)(self._bossList, data)
  end
  ;
  (self._mainScrollViewHelper):ReloadAllCell()
end

GuildBossMainDialog.SetData = function(self)
  -- function num : 0_6
end

GuildBossMainDialog.NumberOfCell = function(self, helper)
  -- function num : 0_7
  if helper == self._mainScrollViewHelper then
    return #self._bossList
  else
    return #self._battleLogList
  end
end

GuildBossMainDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_8
  if helper == self._mainScrollViewHelper then
    if (((self._bossList)[index]).serverData).state == 0 then
      return "guildboss.guildbossinfocelllock"
    else
      return "guildboss.guildbossinfocell"
    end
  else
    return "guildboss.guildbossbattlelogcell"
  end
end

GuildBossMainDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_9
  if helper == self._mainScrollViewHelper then
    return (self._bossList)[index]
  else
    return (self._battleLogList)[index]
  end
end

GuildBossMainDialog.OnRankBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.boss.crequestpartybossrank")
  csend.bossid = 0
  csend:Send()
end

GuildBossMainDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("guildboss.guildbosstipsdialog")):SetData(2255)
end

return GuildBossMainDialog

