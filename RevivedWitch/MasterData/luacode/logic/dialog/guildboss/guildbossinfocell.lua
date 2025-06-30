-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossinfocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CMonsterBookCfg = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local GuildBossInfoCell = class("GuildBossInfoCell", Dialog)
GuildBossInfoCell.AssetBundleName = "ui/layouts.guild"
GuildBossInfoCell.AssetName = "GuildBossChooseCell"
GuildBossInfoCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossInfoCell
  ((GuildBossInfoCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GuildBossInfoCell.OnCreate = function(self)
  -- function num : 0_1
  self._BossName = self:GetChild("Cell/Name")
  ;
  (self._BossName):SetText("")
  self._BossImage = self:GetChild("Cell/Boss")
  self._battleBtn = self:GetChild("Cell/StartBtn")
  ;
  (self._battleBtn):SetActive(false)
  ;
  (self._battleBtn):Subscribe_PointerClickEvent(self.OnBattleBtnClicked, self)
  self._progressBar = self:GetChild("Cell/HPBar/HPBarBoss")
  self._finishImage = self:GetChild("Finish")
  ;
  (self._finishImage):SetActive(false)
  self._hpNum = self:GetChild("Cell/HPBar/HPNum/Num")
  ;
  (self._hpNum):SetText("")
end

GuildBossInfoCell.OnDestroy = function(self)
  -- function num : 0_2
end

GuildBossInfoCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : CImagePathTable, CMonsterBookCfg, _ENV
  local spriteRecord = CImagePathTable:GetRecorder(((self._cellData).record).icon)
  ;
  (self._BossImage):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  local record = CMonsterBookCfg:GetRecorder(((self._cellData).record).monsterHandbookId)
  if record then
    (self._BossName):SetText((TextManager.GetText)(record.nameTextID))
  end
  if ((self._cellData).serverData).state == 0 then
    (self._progressBar):SetFirstValue(1)
    ;
    (self._progressBar):SetSecondValue(1)
    ;
    (self._battleBtn):SetActive(true)
    ;
    (self._finishImage):SetActive(false)
  else
    if ((self._cellData).serverData).state == 1 then
      local progress = ((self._cellData).serverData).hp / ((self._cellData).record).point1
      local Num = (string.format)("%.2f", progress * 100)
      Num = Num .. "%"
      ;
      (self._hpNum):SetText(Num)
      ;
      (self._progressBar):SetFirstValue(progress)
      ;
      (self._progressBar):SetSecondValue(progress)
      ;
      (self._battleBtn):SetActive(true)
      ;
      (self._finishImage):SetActive(false)
    else
      do
        if ((self._cellData).serverData).state == 2 then
          (self._progressBar):SetFirstValue(0)
          ;
          (self._progressBar):SetSecondValue(0)
          ;
          (self._battleBtn):SetActive(false)
          ;
          (self._finishImage):SetActive(true)
          ;
          (self._hpNum):SetText("0%")
        end
      end
    end
  end
end

GuildBossInfoCell.OnBattleBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._cellData).serverData).state == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100499)
  else
    local InfoDlg = (DialogManager.CreateSingletonDialog)("guildboss.guildbossbattleinfodialog")
    if InfoDlg then
      InfoDlg:Init(self._cellData)
    end
  end
end

return GuildBossInfoCell

