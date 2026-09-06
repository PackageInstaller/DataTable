local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CMonsterBookCfg = BeanManager.GetTableByName("handbook.cmonster_handbook")
local CGuildBossInfo = BeanManager.GetTableByName("guild.cguildchallengebossinfo")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local GuildBossBattleLogCell = class("GuildBossBattleLogCell", Dialog)
GuildBossBattleLogCell.AssetBundleName = "ui/layouts.guild"
GuildBossBattleLogCell.AssetName = "GuildBossChooseRecordCell"

function GuildBossBattleLogCell:Ctor(...)
  GuildBossBattleLogCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function GuildBossBattleLogCell:OnCreate()
  self._LogText = self:GetChild("Bubble/Text")
  self._LogText:SetText("")
end

function GuildBossBattleLogCell:OnDestroy()
end

function GuildBossBattleLogCell:RefreshCell()
  local recorder = CGuildBossInfo:GetRecorder(self._cellData.bossid)
  if recorder then
    local record = CMonsterBookCfg:GetRecorder(recorder.monsterHandbookId)
    if record then
      if self._cellData.ifkill == 1 then
        local str = TextManager.GetText(CStringRes:GetRecorder(2248).msgTextID)
        str = string.gsub(str, "%$parameter1%$", self._cellData.username)
        str = string.gsub(str, "%$parameter2%$", TextManager.GetText(record.nameTextID))
        str = string.gsub(str, "%$parameter3%$", self._cellData.damage)
        str = string.gsub(str, "%$parameter4%$", TextManager.GetText(record.nameTextID))
        local time = self:GetStatusStr()
        local stringLen = string.len(time)
        if 0 < stringLen then
          self._LogText:SetText(str .. "    " .. time)
        else
          self._LogText:SetText(str)
        end
      else
        local str = TextManager.GetText(CStringRes:GetRecorder(2247).msgTextID)
        str = string.gsub(str, "%$parameter1%$", self._cellData.username)
        str = string.gsub(str, "%$parameter2%$", TextManager.GetText(record.nameTextID))
        str = string.gsub(str, "%$parameter3%$", self._cellData.damage)
        local time = self:GetStatusStr()
        local stringLen = string.len(time)
        if 0 < stringLen then
          self._LogText:SetText(str .. "    " .. time)
        else
          self._LogText:SetText(str)
        end
      end
    end
  end
end

function GuildBossBattleLogCell:GetStatusStr()
  if self._cellData.ts <= 0 then
    return ""
  end
  local time = ServerGameTimer.GetServerTime() - self._cellData.ts
  local day = math.floor(time / 86400000)
  if 0 < day then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1031).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(day))
  end
  local hour = math.floor(time / 3600000)
  if 0 < hour then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1030).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(hour))
  end
  local min = math.floor(time / 60000)
  if 0 < min then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1029).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(min))
  end
  local second = math.floor(time / 1000)
  if 0 < second then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1028).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(second))
  end
  local str = TextManager.GetText(CstringCfg:GetRecorder(1028).msgTextID)
  return string.gsub(str, "%$parameter1%$", tostring(1))
end

return GuildBossBattleLogCell
