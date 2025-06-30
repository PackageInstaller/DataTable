-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossrankbosscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuildBossRankBossCell = class("GuildBossRankBossCell", Dialog)
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CMonsterBookCfg = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CGuildBossInfo = (BeanManager.GetTableByName)("guild.cguildchallengebossinfo")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
GuildBossRankBossCell.AssetBundleName = "ui/layouts.guild"
GuildBossRankBossCell.AssetName = "GuildBossRankBossCell"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
GuildBossRankBossCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossRankBossCell
  ((GuildBossRankBossCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GuildBossRankBossCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Boss")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Select")
  self._difficulty = self:GetChild("Difficulty")
  ;
  (self._difficulty):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

GuildBossRankBossCell.OnDestroy = function(self)
  -- function num : 0_2
end

GuildBossRankBossCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : CGuildBossInfo, CMonsterBookCfg, _ENV, CImagePathTable
  if (self._cellData).bossid ~= 0 then
    local recorder = CGuildBossInfo:GetRecorder((self._cellData).bossid)
    if recorder then
      local record = CMonsterBookCfg:GetRecorder(recorder.monsterHandbookId)
      if record then
        (self._name):SetText((TextManager.GetText)(record.nameTextID))
      end
      local spriteRecord = CImagePathTable:GetRecorder(recorder.rankicon)
      ;
      (self._img):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
    end
  else
    do
      ;
      (self._name):SetText("公会排行")
      do
        local spriteRecord = CImagePathTable:GetRecorder(16108)
        ;
        (self._img):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
        ;
        (self._select):SetActive((self._cellData).bossid == (self._delegate)._selectBossId)
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
      end
    end
  end
end

GuildBossRankBossCell.OnCellClicked = function(self)
  -- function num : 0_4
  if not self._cellData then
    return 
  end
  ;
  (self._delegate):OnSelectBossCell(self._cellData)
end

GuildBossRankBossCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if self._cellData and eventName == "ChooseBossRush" then
    if (self._cellData).id == arg then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

return GuildBossRankBossCell

