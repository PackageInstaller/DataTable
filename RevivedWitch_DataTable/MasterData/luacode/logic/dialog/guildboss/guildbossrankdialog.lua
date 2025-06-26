-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossrankdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CGuildBossInfo = (BeanManager.GetTableByName)("guild.cguildchallengebossinfo")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local BossChallenge = (LuaNetManager.GetBeanDef)("protocol.ranking.bosschallenge")
local GuildBossRankDialog = class("GuildBossRankDialog", Dialog)
GuildBossRankDialog.AssetBundleName = "ui/layouts.guild"
GuildBossRankDialog.AssetName = "GuildBossRank"
local TableFrame = require("framework.ui.frame.table.tableframe")
GuildBossRankDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossRankDialog
  ((GuildBossRankDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bossList = {}
  self._rankList = {}
  self._selectBossId = 0
  self._timer = nil
  self._cacheRankData = {}
  self._personalRankData = {}
end

GuildBossRankDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._bossFrame = self:GetChild("BossFrame")
  self._bossHelper = (TableFrame.Create)(self._bossFrame, self, true, true, true)
  self._topArrow = self:GetChild("TopArrow")
  self._bottomArrow = self:GetChild("DownArrow")
  self._rankFrame = self:GetChild("Frame")
  self._rankHelper = (TableFrame.Create)(self._rankFrame, self, true, true, true)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:InitBossList()
  self._requestMyRankTime = nil
end

GuildBossRankDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._bossHelper):Destroy()
  ;
  (self._rankHelper):Destroy()
  self._cacheRankData = {}
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
end

GuildBossRankDialog.InitBossList = function(self)
  -- function num : 0_3 , upvalues : CGuildBossInfo, _ENV
  self._bossList = {}
  local guilddata = {}
  guilddata.bossid = 0
  local allIds = CGuildBossInfo:GetAllIds()
  for i = 1, #allIds do
    local recorder = CGuildBossInfo:GetRecorder(allIds[i])
    if i == 1 then
      guilddata.record = recorder
      ;
      (table.insert)(self._bossList, guilddata)
    end
    local data = {}
    data.record = recorder
    data.bossid = recorder.id
    ;
    (table.insert)(self._bossList, data)
  end
  ;
  (self._bossHelper):ReloadAllCell()
  ;
  (self._bossHelper):MoveToTop()
  if #self._bossList > 0 then
    self:OnSelectBossCell((self._bossList)[1])
  end
  if #self._bossList > 4 then
    (self._bottomArrow):SetActive(true)
  else
    ;
    (self._topArrow):SetActive(false)
    ;
    (self._bottomArrow):SetActive(false)
  end
end

GuildBossRankDialog.RefreshRankList = function(self, protocol)
  -- function num : 0_4
  local bossid = protocol.bossid
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._cacheRankData)[bossid] = protocol.ranking
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._personalRankData)[bossid] = protocol.myrank
  if self._selectBossId ~= protocol.bossid then
    return 
  end
  self:RefreshWithCache()
end

GuildBossRankDialog.RefreshWithCache = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not (self._cacheRankData)[self._selectBossId] then
    self._rankList = {}
    if self._selectBossId == 0 then
      local dialog = (DialogManager.GetDialog)("guildboss.guildbossrankplayerdialog")
      if dialog then
        (DialogManager.DestroySingletonDialog)("guildboss.guildbossrankplayerdialog")
      end
      local GuildDialog = (DialogManager.CreateSingletonChildDialog)("guildboss.guildbossrankguilddialog", "guildboss.guildbossrankdialog", self._rankFrame)
      if GuildDialog then
        GuildDialog:Refresh(self._selectBossId, self._rankList, (self._personalRankData)[self._selectBossId])
      end
    else
      do
        local dialog = (DialogManager.GetDialog)("guildboss.guildbossrankguilddialog")
        if dialog then
          (DialogManager.DestroySingletonDialog)("guildboss.guildbossrankguilddialog")
        end
        do
          local PlayerDialog = (DialogManager.CreateSingletonChildDialog)("guildboss.guildbossrankplayerdialog", "guildboss.guildbossrankdialog", self._rankFrame)
          if PlayerDialog then
            PlayerDialog:Refresh(self._selectBossId, self._rankList, (self._personalRankData)[self._selectBossId])
          end
          local ids = {}
          for k,v in pairs(self._bossList) do
            (table.insert)(ids, k)
          end
          ;
          (self._bossHelper):ReloadCellsAtIndex(ids, false)
          self:RefreshPersonalRank()
        end
      end
    end
  end
end

GuildBossRankDialog.RefreshPersonalRank = function(self)
  -- function num : 0_6
  local personalRankData = (self._personalRankData)[self._selectBossId]
  if personalRankData then
  end
end

GuildBossRankDialog.OnTeamClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.bossrushteaminfodialog")):InitDataInfo((self._personalRankData)[self._selectBossRushId], self._selectBossRushId)
end

GuildBossRankDialog.DoReq = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.boss.crequestpartybossrank")
  csend.bossid = self._selectBossId
  csend:Send()
  self:RefreshWithCache()
end

GuildBossRankDialog.StartTimer = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self._timer = (GameTimer.AddTask)(5, -1, function(self)
    -- function num : 0_9_0
    self._timer = nil
  end
, self)
end

GuildBossRankDialog.OnSelectBossCell = function(self, bossCellData)
  -- function num : 0_10 , upvalues : _ENV
  if self._selectBossId == bossCellData.bossid then
    return 
  end
  do
    if bossCellData.bossid > 0 then
      local data = ((NekoData.BehaviorManager).BM_Guild):GetGuildBossData()
      if (data.bossstates)[bossCellData.bossid] and ((data.bossstates)[bossCellData.bossid]).state == 0 then
        return 
      end
    end
    self._selectBossId = bossCellData.bossid
    local needReq = false
    if not (self._cacheRankData)[self._selectBossId] then
      needReq = true
    end
    if needReq or not self._timer then
      self:DoReq()
      if not self._timer then
        self:StartTimer()
      end
    else
      self:RefreshWithCache()
    end
  end
end

GuildBossRankDialog.NumberOfCell = function(self, helper)
  -- function num : 0_11
  if helper == self._bossHelper then
    return #self._bossList
  end
end

GuildBossRankDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_12
  if helper == self._bossHelper then
    return "guildboss.guildbossrankbosscell"
  end
end

GuildBossRankDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_13
  if helper == self._bossHelper then
    return (self._bossList)[index]
  end
end

GuildBossRankDialog.OnCurPosChange = function(self, helper, proportion)
  -- function num : 0_14
  if helper == self._bossHelper then
    local width, height = (self._bossFrame):GetRectSize()
    local total = (self._bossHelper):GetTotalLength()
    if height < total then
      if proportion == 1 then
        (self._topArrow):SetActive(false)
      else
        ;
        (self._topArrow):SetActive(true)
      end
      if proportion == 0 then
        (self._bottomArrow):SetActive(false)
      else
        ;
        (self._bottomArrow):SetActive(true)
      end
    else
      ;
      (self._topArrow):SetActive(false)
      ;
      (self._bottomArrow):SetActive(false)
    end
    return 
  end
end

GuildBossRankDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

GuildBossRankDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return GuildBossRankDialog

