local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_buffId

function SetBuff(buffId)
  m_buffId = buffId
  REF.SpriteBuff.UISprite.spriteName = "guild_skill_" .. buffId
  REF.LabelName.UILabel.text = WU.GetString("GuildSkillName_" .. buffId)
  REF.LabelDesc.UIHtmlLabel.text = WU.GetString("GuildSkillDesc_" .. buffId)
end
