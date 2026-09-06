-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/config/PetCommentConfig.lua

module("logic.extensions.equipment.config.PetCommentConfig", package.seeall)

local PetCommentConfig = class("PetCommentConfig", BaseConfig)

function PetCommentConfig:onInit()
	PetCommentConfig.super.onInit(self)

	self.petBaseCfg = nil
end

function PetCommentConfig:getNames()
	return {
		"pet_comment_common_config"
	}
end

function PetCommentConfig:handleConfig(name, content)
	if name == "pet_comment_common_config" then
		self.petBaseCfg = {
			jbTextCount = 200,
			coolTime = 60,
			plTextCount = 100,
			plLevel = 50,
			plDes = lang("精灵等级达到%s级后才能评论，评论限制%s字")
		}

		if content.PET_LEVEL_LIMIT then
			self.petBaseCfg.plLevel = tonumber(content.PET_LEVEL_LIMIT.value)
		end

		if content.WORLD_NUMBER then
			self.petBaseCfg.plTextCount = tonumber(content.WORLD_NUMBER.value)
		end

		if content.UPDATA_COOL_TIME then
			self.petBaseCfg.coolTime = tonumber(content.UPDATA_COOL_TIME.value)
		end

		if content.REPORT_TEXT_COUNT then
			self.petBaseCfg.jbTextCount = tonumber(content.REPORT_TEXT_COUNT.value)
		end
	end
end

function PetCommentConfig:GetPetCommentBase()
	return self.petBaseCfg
end

PetCommentConfig.instance = PetCommentConfig.New()

return PetCommentConfig
