inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local GU = require("Common/GuildUtil")
local m_summary, m_stage

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  m_summary = this:GetData("DungeonGuild/Summary")
  if GU.HandleGuildDungeonSummary(m_summary) ~= true then
    warning("DungeonGuild", "Handle summary info failed")
    return
  end
  m_stage = m_summary.challengeStatus
  REF.NodeEmpty.gameObject:SetActive(false)
  UpdateUI()
end

function UpdateUI()
  local buffList = _ENV["!"]({})
  for i = 1, #m_summary.dungeonRecords - 1 do
    local dungeonRecord = m_summary.dungeonRecords[i]
    local id = dungeonRecord.config.assistBuffId
    local ref = REF.NodeBuffList[i - 1]
    local fightBuffInfo = PB.get("FightBuff", id)
    local affixInfo = PB.get("AffixInfo", fightBuffInfo.team1[1].affixList[1])
    local buffIndex = PB.get("BuffIndex", affixInfo.index)
    local buffInfo = PB.get("BuffData", buffIndex.buffId[1], buffIndex.owner[1])
    local spriteName = buffInfo.iconName
    local tpl = WU.GetString("GuildFightBuff_" .. id)
    local tplParam = SE.GetTplParamByFightBuffId(id)
    local buffDesc = TU.render(tpl, tplParam)
    ref.SpriteBuff.UISprite.spriteName = spriteName
    local hasGotBuff = dungeonRecord.isFinished
    ref.SpriteUnlock.gameObject:SetActive(not hasGotBuff)
    if ref.SpriteUnlock.gameObject.activeSelf then
      ref.LabelWillOpen.UILabel.text = WU.GetString("DungeonGuild_NthDungeon", tostring(i))
    end
    ref.SpriteMask.gameObject:SetActive(not hasGotBuff)
    if ref.SpriteMask.gameObject.activeSelf then
      ref.SpriteMask.UISprite.fillAmount = 1 - dungeonRecord.progress / 100.0
    end
    ref.LabelDesc.UIHtmlLabel.text = buffDesc
  end
  return buffList
end
