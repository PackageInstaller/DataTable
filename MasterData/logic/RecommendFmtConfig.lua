-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/config/RecommendFmtConfig.lua

module("logic.extensions.recommendfmt.config.RecommendFmtConfig", package.seeall)

local RecommendFmtConfig = class("RecommendFmtConfig", BaseConfig)

function RecommendFmtConfig:onInit()
	RecommendFmtConfig.super.onInit(self)

	self._recommendFormationCfg = nil
end

function RecommendFmtConfig:getNames()
	return {
		"recommend_formation",
		"recommend_formation_max",
		"recommend_form_pos",
		"recommend_formation_max_common",
		"recommend_psychic_formation"
	}
end

function RecommendFmtConfig:handleConfig(name, content)
	if name == "recommend_formation" then
		self._recommendFormationCfg = content
	elseif name == "recommend_formation_max" then
		self._recommendFormationMaxCfg = content
	elseif name == "recommend_form_pos" then
		self._recommendFormationPosCfg = content
	elseif name == "recommend_formation_max_common" then
		self.recommend_formation_max_commonCfg = content
	elseif name == "recommend_psychic_formation" then
		self._recommend_psychic_formation = content
	end
end

function RecommendFmtConfig:getCfgsById(id)
	return self._recommendFormationCfg[id]
end

function RecommendFmtConfig:getFmtMaxCfg(id)
	return self._recommendFormationMaxCfg[id]
end

function RecommendFmtConfig:getFmtCreeps(id)
	return self._recommendFormationPosCfg[id]
end

function RecommendFmtConfig:getCommonValue(id)
	if self.recommend_formation_max_commonCfg[id] then
		return self.recommend_formation_max_commonCfg[id].value
	end

	return ""
end

function RecommendFmtConfig:getCfgsList()
	return self._recommendFormationCfg.dataList
end

function RecommendFmtConfig:getPsychicCfgsList()
	return self._recommend_psychic_formation.dataList
end

function RecommendFmtConfig:getPsychicCfg(id)
	for i, v in ipairs(self._recommend_psychic_formation.dataList) do
		if v.id == id then
			return v
		end
	end
end

RecommendFmtConfig.instance = RecommendFmtConfig.New()

return RecommendFmtConfig
