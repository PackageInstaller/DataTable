-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossbattleinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CGuildBossInfo = (BeanManager.GetTableByName)("guild.cguildchallengebossinfo")
local LogicCell = require("framework.ui.frame.grid.logiccell")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterBookCfg = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CForceHandBookCfg = (BeanManager.GetTableByName)("handbook.caffiliation_handbook")
local CHandBookPropertyImage = (BeanManager.GetTableByName)("handbook.chankbookpropertyimage")
local Item = require("logic.manager.experimental.types.item")
local GuildBossBattleInfoDialog = class("GuildBossBattleInfoDialog", Dialog)
GuildBossBattleInfoDialog.AssetBundleName = "ui/layouts.guild"
GuildBossBattleInfoDialog.AssetName = "GuildBossPrepare"
GuildBossBattleInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossBattleInfoDialog
  ((GuildBossBattleInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = nil
  self.battleRewardList = {}
  self.killRewardList = {}
end

GuildBossBattleInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, TableFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._detailBack = self:GetChild("Detail")
  self._icon = self:GetChild("Detail/MonsterImg")
  self._monsterBack = self:GetChild("Detail/MonsterBack")
  self._name = self:GetChild("Detail/Name")
  self._campIcon = self:GetChild("Detail/GroupImg")
  self._lockIcon = self:GetChild("Detail/Lock")
  self._detailText = self:GetChild("Detail/DetailTxt")
  self._propText = self:GetChild("Detail/Txt3")
  self._propText_Tiele = self:GetChild("Detail/Txt4")
  self._propFrameUI = self:GetChild("Detail/PropFrame")
  self._propFrame = (GridFrame.Create)(self._propFrameUI, self, true, 1)
  self._keyFrameUI = self:GetChild("Detail/KeyFrame")
  self._keyFrame = (GridFrame.Create)(self._keyFrameUI, self, true, 1)
  self._skillBack = self:GetChild("Detail/SkillBack")
  self._skillPanel = self:GetChild("Detail/SkillFrame")
  self._skillFrame = (TableFrame.Create)(self._skillPanel, self, true, true, true)
  ;
  (self._skillFrame):SetMargin(15, 0)
  self._skillScrollBar = self:GetChild("Detail/SkillScrollbar")
  ;
  (self._skillScrollBar):SetScrollDirection(2)
  self._battleRewardPanel = self:GetChild("Frame/CellPanel1")
  self._battleRewardFrame = (GridFrame.Create)(self._battleRewardPanel, self, false, 1, true)
  self._killRewardPanel = self:GetChild("Frame/CellPanel2")
  self._killRewardFrame = (GridFrame.Create)(self._killRewardPanel, self, false, 1, true)
  self._battleBtn = self:GetChild("Frame/GoBtn")
  ;
  (self._battleBtn):Subscribe_PointerClickEvent(self.OnBattleBtnClicked, self)
  self._skipBattleToggle = self:GetChild("Frame/_Toggle_0")
  ;
  (self._skipBattleToggle):Subscribe_PointerClickEvent(self.OnSkipBattleToggleClicked, self)
  ;
  (self._skipBattleToggle):SetIsOnType(false)
  self._progressBar = self:GetChild("Frame/HPBar/HPBarBoss")
  self._progressNum = self:GetChild("Frame/HPBar/HPNum/Num")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshData, Common.n_GuildBossInfo, nil)
end

GuildBossBattleInfoDialog.Init = function(self, data)
  -- function num : 0_2
  self._data = data
  self:Refresh()
  self:ShowRewardInfo()
end

GuildBossBattleInfoDialog.RefreshData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local GuildBossData = ((NekoData.BehaviorManager).BM_Guild):GetGuildBossData()
  for k,v in pairs(GuildBossData.bossstates) do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    if v.bossid == ((self._data).serverData).bossid then
      (self._data).serverData = v
      break
    end
  end
end

GuildBossBattleInfoDialog.ShowRewardInfo = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.battleRewardList = {}
  local battleRewardRec = (string.split)(((self._data).record).showaward1, ";")
  for _,v in ipairs(battleRewardRec) do
    local battleRewardStr = (string.split)(v, "@")
    local data = {}
    data.itemid = tonumber(battleRewardStr[1])
    data.itemnum = tonumber(battleRewardStr[2])
    data.itemtype = tonumber(battleRewardStr[3])
    ;
    (table.insert)(self.battleRewardList, data)
  end
  ;
  (self._battleRewardFrame):ReloadAllCell()
  ;
  (self._battleRewardFrame):MoveToLeft()
  self.killRewardList = {}
  local killRewardRec = (string.split)(((self._data).record).showaward3, ";")
  for _,v in ipairs(killRewardRec) do
    local killRewardStr = (string.split)(v, "@")
    local data = {}
    data.itemid = tonumber(killRewardStr[1])
    data.itemnum = tonumber(killRewardStr[2])
    data.itemtype = -1
    ;
    (table.insert)(self.killRewardList, data)
  end
  ;
  (self._killRewardFrame):ReloadAllCell()
  ;
  (self._killRewardFrame):MoveToLeft()
end

GuildBossBattleInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

GuildBossBattleInfoDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

GuildBossBattleInfoDialog.OnBattleBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV, CMonsterBookCfg
  if (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag and (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag == -1 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100510)
    return 
  end
  if ((self._data).serverData).state == 0 then
    return 
  else
    if ((self._data).serverData).state == 2 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100501)
      return 
    end
  end
  local GuildBossData = ((NekoData.BehaviorManager).BM_Guild):GetGuildBossData()
  if GuildBossData.chances < 1 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100500)
    return 
  end
  if (self._skipBattleToggle):GetIsOnType() then
    if ((self._data).serverData).mymaxdamage == 0 then
      return ((NekoData.BehaviorManager).BM_Message):SendMessageById(100502)
    end
    local monsterName = ""
    local record = CMonsterBookCfg:GetRecorder(((self._data).record).monsterHandbookId)
    if record then
      monsterName = (TextManager.GetText)(record.nameTextID)
    end
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(150, {monsterName, ((self._data).serverData).mymaxdamage}, function()
    -- function num : 0_7_0 , upvalues : _ENV, self
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.boss.cpartybossquickbattle")
    csend.bossid = ((self._data).record).id
    csend:Send()
  end
, {}, nil, {})
  else
    do
      local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
      csend.battleType = csend.PARTY_BOSS
      csend.id = ((self._data).record).id
      csend:Send()
    end
  end
end

GuildBossBattleInfoDialog.OnSkipBattleToggleClicked = function(self)
  -- function num : 0_8
end

GuildBossBattleInfoDialog.OnDestroy = function(self)
  -- function num : 0_9
  (self._propFrame):Destroy()
  ;
  (self._keyFrame):Destroy()
  ;
  (self._skillFrame):Destroy()
end

GuildBossBattleInfoDialog.Refresh = function(self)
  -- function num : 0_10 , upvalues : CMonsterBookCfg, _ENV
  local record = CMonsterBookCfg:GetRecorder(((self._data).record).monsterHandbookId)
  if record then
    self:OnSelectMonster(record)
  end
  if ((self._data).serverData).state == 0 then
    (self._progressNum):SetText("100%")
    ;
    (self._progressBar):SetFirstValue(1)
    ;
    (self._progressBar):SetSecondValue(1)
  else
    if ((self._data).serverData).state == 1 then
      local progress = ((self._data).serverData).hp / ((self._data).record).point1
      local Num = (string.format)("%.2f", progress * 100)
      Num = Num .. "%"
      ;
      (self._progressNum):SetText(Num)
      ;
      (self._progressBar):SetFirstValue(progress)
      ;
      (self._progressBar):SetSecondValue(progress)
    else
      do
        if ((self._data).serverData).state == 2 then
          (self._progressNum):SetText("0%")
          ;
          (self._progressBar):SetFirstValue(0)
          ;
          (self._progressBar):SetSecondValue(0)
        end
      end
    end
  end
end

local properList = {"hpScore", "adScore", "apScore", "mixScore", "pdScore", "mdScore"}
GuildBossBattleInfoDialog.OnSelectMonster = function(self, monsterBookInfo)
  -- function num : 0_11 , upvalues : _ENV, CNPCShape, CForceHandBookCfg, CImagePathTable, CHandBookPropertyImage, properList
  self._selectId = monsterBookInfo.id
  ;
  (self._detailBack):SetActive(true)
  ;
  (self._icon):SetActive(true)
  ;
  (self._campIcon):SetActive(true)
  ;
  (self._lockIcon):SetActive(false)
  ;
  (self._monsterBack):SetActive(true)
  ;
  (self._detailText):SetActive(true)
  ;
  (self._detailText):SetText((TextManager.GetText)(monsterBookInfo.descriptionTextID))
  ;
  (self._propText):SetActive(true)
  ;
  (self._name):SetText((TextManager.GetText)(monsterBookInfo.nameTextID))
  local npcShapeRecorder = CNPCShape:GetRecorder(monsterBookInfo.shapeID)
  if self._handler ~= 0 then
    (self._icon):ReleaseModel(self._handler)
    self._handler = 0
  end
  self._handler = (self._icon):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
  local scale = tonumber(npcShapeRecorder.live2DScale)
  ;
  (self._icon):SetLocalScale(scale, scale, scale)
  ;
  (self._campIcon):SetActive(monsterBookInfo.affiliation > 0)
  if monsterBookInfo.affiliation > 0 then
    local worldPowerCfg = CForceHandBookCfg:GetRecorder(monsterBookInfo.affiliation)
    local imageRecord = CImagePathTable:GetRecorder(worldPowerCfg.icon)
    ;
    (self._campIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  ;
  (self._keyFrameUI):SetActive(true)
  ;
  (self._propFrameUI):SetActive(true)
  ;
  (self._skillPanel):SetActive(true)
  local imgRec = CHandBookPropertyImage:GetRecorder(1)
  local book = monsterBookInfo
  self._propList = {}
  for _,v in ipairs(properList) do
    if book[v] > 0 then
      (table.insert)(self._propList, {num = book[v], icon = imgRec[v .. "Image"]})
    end
  end
  self._tagList = book.tag
  self._skillList = book.skillid
  ;
  (self._skillFrame):ReloadAllCell()
  ;
  (self._skillFrame):MoveToTop()
  ;
  (self._propFrame):ReloadAllCell()
  ;
  (self._keyFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

GuildBossBattleInfoDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_12
  if frame == self._monsterFrame then
    return #self._monsterList
  else
    if frame == self._propFrame then
      return #self._propList
    else
      if frame == self._keyFrame then
        return #self._tagList
      else
        if frame == self._skillFrame then
          return #self._skillList
        else
          if frame == self._battleRewardFrame then
            return #self.battleRewardList
          else
            if frame == self._killRewardFrame then
              return #self.killRewardList
            end
          end
        end
      end
    end
  end
end

GuildBossBattleInfoDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_13
  if frame == self._monsterFrame then
    return "handbook.monsterbookcell"
  else
    if frame == self._keyFrame then
      return "handbook.monsterbooktagcell"
    else
      if frame == self._propFrame then
        return "handbook.monsterbookpropcell"
      else
        if frame == self._skillFrame then
          return "handbook.monsterskillcell"
        else
          if frame == self._battleRewardFrame then
            return "guildboss.guildbossitemcell"
          else
            if frame == self._killRewardFrame then
              return "guildboss.guildbossitemcell"
            end
          end
        end
      end
    end
  end
end

GuildBossBattleInfoDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_14
  if frame == self._monsterFrame then
    return (self._monsterList)[index]
  else
    if frame == self._keyFrame then
      return (self._tagList)[index]
    else
      if frame == self._propFrame then
        return (self._propList)[index]
      else
        if frame == self._skillFrame then
          return (self._skillList)[index]
        else
          if frame == self._battleRewardFrame then
            return (self.battleRewardList)[index]
          else
            if frame == self._killRewardFrame then
              return (self.killRewardList)[index]
            end
          end
        end
      end
    end
  end
end

GuildBossBattleInfoDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_15
  self._screeningConditions = screeningConditions
  self:Refresh()
end

GuildBossBattleInfoDialog.OnFilterBtnClick = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "Monster", self._screeningConditions)
end

GuildBossBattleInfoDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_17
  if frame == self._monsterFrame then
    local _, height = (self._monsterPanel):GetRectSize()
    local total = (self._monsterFrame):GetTotalLength()
    frame:SetSlide(height < total)
    if height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      (self._scrollBar):SetActive(false)
    end
  elseif frame == self._skillFrame then
    local _, height = (self._skillPanel):GetRectSize()
    local total = (self._skillFrame):GetTotalLength()
    frame:SetSlide(height < total)
    if height < total then
      (self._skillScrollBar):SetActive(true)
      ;
      (self._skillScrollBar):SetScrollSize(height / total)
      ;
      (self._skillScrollBar):SetScrollValue(proportion)
    else
      (self._skillScrollBar):SetActive(false)
    end
  elseif frame == self._keyFrame then
    local _, height = (self._keyFrameUI):GetRectSize()
    local total = (self._keyFrame):GetTotalLength()
    frame:SetSlide(height < total)
  elseif frame == self._propFrame then
    local _, height = (self._propFrameUI):GetRectSize()
    local total = (self._propFrame):GetTotalLength()
    frame:SetSlide(height < total)
  end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

GuildBossBattleInfoDialog.ShouldLengthChange = function(self)
  -- function num : 0_18
  return true
end

return GuildBossBattleInfoDialog

