-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/config/DrawandguessConfig.lua

module("logic.extensions.drawandguess.config.DrawandguessConfig", package.seeall)

local DrawandguessConfig = class("DrawandguessConfig", BaseConfig)

function DrawandguessConfig:onInit()
	return
end

function DrawandguessConfig:getNames()
	return {
		"draw_and_guess_talk",
		"draw_and_guess_common",
		"draw_and_guess_question",
		"draw_and_guess_score",
		"draw_and_guess_prize",
		"draw_and_guess_rank_prize",
		"draw_and_guess_draw_score",
		"draw_and_guess_emoji",
		"draw_and_guess_activity",
		"draw_and_guess_brush_color",
		"draw_and_guess_brush_size",
		"draw_and_guess_question_type"
	}
end

function DrawandguessConfig:handleConfig(name, content)
	if name == "draw_and_guess_talk" then
		self._draw_and_guess_talk = content
	elseif name == "draw_and_guess_common" then
		self._draw_and_guess_common = content
	elseif name == "draw_and_guess_question" then
		self._draw_and_guess_question = content
	elseif name == "draw_and_guess_score" then
		self._draw_and_guess_score = content
	elseif name == "draw_and_guess_prize" then
		self._draw_and_guess_prize = content
	elseif name == "draw_and_guess_rank_prize" then
		self._draw_and_guess_rank_prize = content
	elseif name == "draw_and_guess_draw_score" then
		self._draw_and_guess_draw_score = content
	elseif name == "draw_and_guess_emoji" then
		self._draw_and_guess_emoji = content
	elseif name == "draw_and_guess_activity" then
		self._draw_and_guess_activity = content
	elseif name == "draw_and_guess_brush_color" then
		self._draw_and_guess_brush_color = content
	elseif name == "draw_and_guess_brush_size" then
		self._draw_and_guess_brush_size = content
	elseif name == "draw_and_guess_question_type" then
		self._draw_and_guess_question_type = content
	end
end

function DrawandguessConfig:getActCfg(activityId)
	return self._draw_and_guess_activity[activityId]
end

function DrawandguessConfig:getCommonValue(key, isToNumber)
	local value = self._draw_and_guess_common[key].value

	if isToNumber then
		return checknumber(value)
	end

	return value
end

function DrawandguessConfig:getPrizeCfgs(activityId)
	return self._draw_and_guess_prize[activityId]
end

function DrawandguessConfig:getRankPrizeCfg(activityId, rank)
	for i, v in pairs(self._draw_and_guess_rank_prize[activityId]) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			return v
		end
	end
end

function DrawandguessConfig:getBrushColorCfgs()
	return self._draw_and_guess_brush_color.dataList
end

function DrawandguessConfig:getBrushColorCfg(id)
	return self._draw_and_guess_brush_color[id]
end

function DrawandguessConfig:getBrushColorStrList()
	local list = {}

	for i, v in ipairs(self._draw_and_guess_brush_color.dataList) do
		if v.id ~= DrawandguessController.CanvasColorId then
			table.insert(list, v.color)
		end
	end

	return list
end

function DrawandguessConfig:getBrushSizeCfgs()
	return self._draw_and_guess_brush_size.dataList
end

function DrawandguessConfig:getQuestionCfg(activityId, questionId)
	return self._draw_and_guess_question[activityId][questionId]
end

function DrawandguessConfig:getEmojiCfgs(activityId)
	return self._draw_and_guess_emoji[activityId]
end

function DrawandguessConfig:getEmojiCfg(activityId, id)
	return self._draw_and_guess_emoji[activityId][id]
end

function DrawandguessConfig:getTalkCfgs(activityId)
	return self._draw_and_guess_talk[activityId]
end

function DrawandguessConfig:getTalkCfg(activityId, id)
	return self._draw_and_guess_talk[activityId][id]
end

function DrawandguessConfig:getQuestionTypeCfg(typeId)
	return self._draw_and_guess_question_type[typeId]
end

DrawandguessConfig.instance = DrawandguessConfig.New()

return DrawandguessConfig
