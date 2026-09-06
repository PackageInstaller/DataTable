-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyparty/config/FamilyPartyConfig.lua

module("logic.extensions.familyparty.config.FamilyPartyConfig", package.seeall)

local FamilyPartyConfig = class("FamilyPartyConfig", BaseConfig)

function FamilyPartyConfig:onInit()
	FamilyPartyConfig.super.onInit(self)

	self.family_party_common_vars = nil
	self.family_party_question = nil
end

function FamilyPartyConfig:getNames()
	return {
		"family_party_common_vars",
		"family_party_question"
	}
end

function FamilyPartyConfig:handleConfig(name, content)
	if name == "family_party_common_vars" then
		self.family_party_common_vars = content
	elseif name == "family_party_question" then
		self.family_party_question = content
	end
end

function FamilyPartyConfig:getCommonValue(key)
	if self.family_party_common_vars[key] then
		return self.family_party_common_vars[key].value
	end
end

function FamilyPartyConfig:getQuestionCfg(questionId)
	return self.family_party_question[questionId]
end

FamilyPartyConfig.instance = FamilyPartyConfig.New()

return FamilyPartyConfig
