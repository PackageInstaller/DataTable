-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/config/ScriptKillConfig.lua

module("logic.extensions.scriptkill.config.ScriptKillConfig", package.seeall)

local ScriptKillConfig = class("ScriptKillConfig", BaseConfig)

function ScriptKillConfig:getNames()
	return {
		"script_killing_activity",
		"script_killing_chapter",
		"script_killing_zone",
		"script_killing_tips",
		"script_killing_clue",
		"script_killing_formula",
		"script_killing_scene",
		"script_killing_npc",
		"script_killing_npc_dialogue",
		"script_killing_suspect",
		"script_killing_suspect_prize",
		"script_killing_rank_prize"
	}
end

function ScriptKillConfig:handleConfig(name, content)
	if name == "script_killing_activity" then
		self._script_killing_activity = content
	elseif name == "script_killing_chapter" then
		self._script_killing_chapter = content
	elseif name == "script_killing_zone" then
		self._script_killing_zone = content
	elseif name == "script_killing_tips" then
		self._script_killing_tips = content
	elseif name == "script_killing_clue" then
		self._script_killing_clue = content

		self:_handleClues()
	elseif name == "script_killing_formula" then
		self._script_killing_formula = content
	elseif name == "script_killing_scene" then
		self._script_killing_scene = content
	elseif name == "script_killing_npc" then
		self._script_killing_npc = content
	elseif name == "script_killing_npc_dialogue" then
		self._script_killing_npc_dialogue = content
	elseif name == "script_killing_suspect" then
		self._script_killing_suspect = content
	elseif name == "script_killing_suspect_prize" then
		self._script_killing_suspect_prize = content
	elseif name == "script_killing_rank_prize" then
		self._script_killing_rank_prize = content
	end
end

function ScriptKillConfig:getActivityCfgById(id)
	return self._script_killing_activity[id]
end

function ScriptKillConfig:getTipsList()
	return self._script_killing_tips.dataList
end

function ScriptKillConfig:getChapterListById(activityId)
	return self._script_killing_chapter[activityId]
end

function ScriptKillConfig:getChapterCfgById(activityId, chapterId)
	if self._script_killing_chapter[activityId] then
		return self._script_killing_chapter[activityId][chapterId]
	end
end

function ScriptKillConfig:getZoneCfgById(activityId, chapterId, zoneId)
	if self._script_killing_zone[activityId] and self._script_killing_zone[activityId][chapterId] then
		return self._script_killing_zone[activityId][chapterId][zoneId]
	end
end

function ScriptKillConfig:_handleClues()
	self._script_killing_clue_Map = {}

	for i, v in ipairs(self._script_killing_clue.dataList) do
		local activityId = v.activityId
		local chapterId = v.chapterId

		self._script_killing_clue_Map[activityId] = self._script_killing_clue_Map[activityId] or {}
		self._script_killing_clue_Map[activityId][chapterId] = self._script_killing_clue_Map[activityId][chapterId] or {}

		table.insert(self._script_killing_clue_Map[activityId][chapterId], v)
	end
end

function ScriptKillConfig:getClueCfgListById(activityId, chapterId)
	if self._script_killing_clue_Map[activityId] then
		return self._script_killing_clue_Map[activityId][chapterId]
	end
end

function ScriptKillConfig:getClueCfgById(activityId, clueId)
	if self._script_killing_clue[activityId] then
		return self._script_killing_clue[activityId][clueId]
	end
end

function ScriptKillConfig:getFormulaCfgById(id)
	return self._script_killing_formula[id]
end

function ScriptKillConfig:getSceneCfgById(id)
	return self._script_killing_scene[id]
end

function ScriptKillConfig:getNpcCfgById(activityId, id)
	if self._script_killing_npc[activityId] then
		return self._script_killing_npc[activityId][id]
	end
end

function ScriptKillConfig:getDialogueCfgById(activityId, dialogueId, id)
	if self._script_killing_npc_dialogue[activityId] and self._script_killing_npc_dialogue[activityId][dialogueId] then
		return self._script_killing_npc_dialogue[activityId][dialogueId][id]
	end
end

function ScriptKillConfig:getSuspectCfgById(id)
	return self._script_killing_suspect[id]
end

function ScriptKillConfig:getSuspectPrizeCfgById(activityId, count)
	if self._script_killing_suspect_prize[activityId] then
		return self._script_killing_suspect_prize[activityId][count]
	end
end

function ScriptKillConfig:getSuspectPrizeCfgList(activityId)
	return self._script_killing_suspect_prize[activityId]
end

function ScriptKillConfig:getRankPrizeCfgById(activityId)
	return self._script_killing_rank_prize[activityId]
end

ScriptKillConfig.instance = ScriptKillConfig.New()

return ScriptKillConfig
