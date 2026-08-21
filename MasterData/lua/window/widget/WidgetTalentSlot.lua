local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")

function SetData(data)
  AU.SetTalentBG(_ENV["$"](REF.SpriteTalentBGNode), data.bgIdx, data.isRatio)
  REF.SpriteTalent.UISprite.spriteName = "ActorTalent_" .. data.talentIcon
  REF.TalentTitleLabel.UILabel.text = data.talentName
  REF.TalentScoreLabel.UILabel.text = data.score
end
