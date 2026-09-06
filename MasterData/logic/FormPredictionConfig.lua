-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/config/FormPredictionConfig.lua

module("logic.extensions.formprediction.config.FormPredictionConfig", package.seeall)

local FormPredictionConfig = class("FormPredictionConfig", BaseConfig)

function FormPredictionConfig:getNames()
	return {
		"form_prediction",
		"form_prediction_formation",
		"form_prediction_prize",
		"form_prediction_pet",
		"form_prediction_rank_prize"
	}
end

function FormPredictionConfig:handleConfig(name, content)
	if name == "form_prediction" then
		self._form_prediction = content
	elseif name == "form_prediction_formation" then
		self._form_prediction_formation = content
	elseif name == "form_prediction_prize" then
		self._form_prediction_prize = content
	elseif name == "form_prediction_pet" then
		self._form_prediction_pet = content
	elseif name == "form_prediction_rank_prize" then
		self._form_prediction_rank_prize = content
	end
end

function FormPredictionConfig:getInfoCfgById(id)
	return self._form_prediction[id]
end

function FormPredictionConfig:getFormationListCfgById(actId)
	return self._form_prediction_formation[actId]
end

function FormPredictionConfig:getFormationCfgById(actId, formid)
	if self._form_prediction_formation[actId] then
		return self._form_prediction_formation[actId][formid]
	end
end

function FormPredictionConfig:getPrizeCfgById(id)
	return self._form_prediction_prize[id]
end

function FormPredictionConfig:getPetListCfgById(id)
	return self._form_prediction_pet[id]
end

function FormPredictionConfig:getPetCfgById(petPlanId, petId)
	if self._form_prediction_pet[petPlanId] then
		return self._form_prediction_pet[petPlanId][petId]
	end
end

function FormPredictionConfig:getRankPrizeCfgById(id)
	return self._form_prediction_rank_prize[id]
end

function FormPredictionConfig:getRankCfg(id, rank)
	local result
	local list = self._form_prediction_rank_prize[id]

	if list then
		for i = #list, 1, -1 do
			local cfg = list[i]

			if cfg.rankList and #cfg.rankList > 0 and rank >= cfg.rankList[1] and rank <= cfg.rankList[2] then
				result = cfg

				break
			end
		end
	end

	return result
end

FormPredictionConfig.instance = FormPredictionConfig.New()

return FormPredictionConfig
