local GuildBossRankBossCell = class("GuildBossRankBossCell", Dialog)
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CMonsterBookCfg = BeanManager.GetTableByName("handbook.cmonster_handbook")
local CGuildBossInfo = BeanManager.GetTableByName("guild.cguildchallengebossinfo")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
GuildBossRankBossCell.AssetBundleName = "ui/layouts.guild"
GuildBossRankBossCell.AssetName = "GuildBossRankBossCell"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")

function GuildBossRankBossCell:Ctor(...)
  GuildBossRankBossCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function GuildBossRankBossCell:OnCreate()
  self._img = self:GetChild("Boss")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Select")
  self._difficulty = self:GetChild("Difficulty")
  self._difficulty:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function GuildBossRankBossCell:OnDestroy()
end

function GuildBossRankBossCell:RefreshCell()
  if self._cellData.bossid ~= 0 then
    local recorder = CGuildBossInfo:GetRecorder(self._cellData.bossid)
    if recorder then
      local record = CMonsterBookCfg:GetRecorder(recorder.monsterHandbookId)
      if record then
        self._name:SetText(TextManager.GetText(record.nameTextID))
      end
      local spriteRecord = CImagePathTable:GetRecorder(recorder.rankicon)
      self._img:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
    end
  else
    self._name:SetText("公会排行")
    local spriteRecord = CImagePathTable:GetRecorder(16108)
    self._img:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  end
  self._select:SetActive(self._cellData.bossid == self._delegate._selectBossId)
end

function GuildBossRankBossCell:OnCellClicked()
  if not self._cellData then
    return
  end
  self._delegate:OnSelectBossCell(self._cellData)
end

function GuildBossRankBossCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "ChooseBossRush" then
    if self._cellData.id == arg then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
end

return GuildBossRankBossCell
