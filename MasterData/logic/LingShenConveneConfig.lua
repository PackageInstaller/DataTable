-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/config/LingShenConveneConfig.lua

module("logic.extensions.lingshenconvene.config.LingShenConveneConfig", package.seeall)

local LingShenConveneConfig = class("LingShenConveneConfig", BaseConfig)

function LingShenConveneConfig:onInit()
	LingShenConveneConfig.super.onInit(self)
end

function LingShenConveneConfig:getNames()
	return {
		"ling_shen_convene",
		"ling_shen_convene_tab",
		"ling_shen_convene_pet_icon",
		"ling_shen_convene_prize",
		"ling_shen_convene_progress_prize",
		"ling_shen_convene_pet_detail"
	}
end

function LingShenConveneConfig:handleConfig(name, content)
	if name == "ling_shen_convene" then
		self._actCfgs = content
	elseif name == "ling_shen_convene_tab" then
		self._tabCfgs = content
	elseif name == "ling_shen_convene_pet_icon" then
		self._unlockPetCfgs = content
	elseif name == "ling_shen_convene_prize" then
		self._revealCfgs = content
	elseif name == "ling_shen_convene_progress_prize" then
		self._progressCfgs = content
	elseif name == "ling_shen_convene_pet_detail" then
		self._detailCfgs = content
	end
end

function LingShenConveneConfig:getActCfg(actId)
	return self._actCfgs[actId]
end

function LingShenConveneConfig:getTabCfgs(actId)
	return self._tabCfgs[actId]
end

function LingShenConveneConfig:getUnlockPetCfgs(planId)
	return self._unlockPetCfgs[planId]
end

function LingShenConveneConfig:getProgressCfgs(actId)
	return self._progressCfgs[actId]
end

function LingShenConveneConfig:getRevealCfgs(actId)
	return self._revealCfgs[actId]
end

function LingShenConveneConfig:getPetDetailCfg(detailId)
	return self._detailCfgs[detailId]
end

LingShenConveneConfig.instance = LingShenConveneConfig.New()

return LingShenConveneConfig
