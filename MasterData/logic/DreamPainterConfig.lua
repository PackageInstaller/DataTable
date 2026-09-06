-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/config/DreamPainterConfig.lua

module("logic.extensions.dreampainter.config.DreamPainterConfig", package.seeall)

local DreamPainterConfig = class("DreamPainterConfig", BaseConfig)

function DreamPainterConfig:onInit()
	DreamPainterConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function DreamPainterConfig:getNames()
	return {
		"dream_painter_activity",
		"dream_painter_phase",
		"dream_painter_works",
		"dream_painter_prize",
		"dream_painter_common"
	}
end

function DreamPainterConfig:handleConfig(name, content)
	if name == "dream_painter_activity" then
		self._dream_painter_activity = content
	elseif name == "dream_painter_phase" then
		self._dream_painter_phase = content
	elseif name == "dream_painter_works" then
		self._dream_painter_works = content
	elseif name == "dream_painter_prize" then
		self._dream_painter_prize = content

		self:_dealPrize(content)
	elseif name == "dream_painter_common" then
		self._dream_painter_common = content
	end
end

function DreamPainterConfig:getCfgById(activietyId)
	return self._dream_painter_activity[activietyId]
end

function DreamPainterConfig:getPahseCfgById(activietyId)
	return self._dream_painter_phase[activietyId]
end

function DreamPainterConfig:getWorksCfgById(activietyId, workId)
	if self._dream_painter_works[activietyId] then
		return self._dream_painter_works[activietyId][workId]
	end
end

function DreamPainterConfig:getPahseCfgByIdAndPid(activietyId, pid)
	if self._dream_painter_phase[activietyId] then
		return self._dream_painter_phase[activietyId][pid]
	end
end

function DreamPainterConfig:_dealPrize(content)
	local dataList = content.dataList
	local map = {}

	for k, v in ipairs(dataList) do
		map[v.activityId] = map[v.activityId] or {}

		table.insert(map[v.activityId], v)
	end

	for k, v in pairs(map) do
		ArraySort.sortOn(v, "startRank")
	end

	self._dream_painter_prize_map = map
end

function DreamPainterConfig:getDreamPainterPrize(activietyId)
	return self._dream_painter_prize_map[activietyId]
end

function DreamPainterConfig:getDreamPainterPrizeByValue(activietyId, value)
	local list = self._dream_painter_prize_map[activietyId]

	if list then
		for i, v in ipairs(list) do
			if value >= v.startRank and value <= v.endRank then
				return v
			end
		end
	end
end

function DreamPainterConfig:getCommonValue(key, isToNumber)
	if self._dream_painter_common[key] then
		if isToNumber then
			return checknumber(self._dream_painter_common[key].value)
		else
			return self._dream_painter_common[key].value
		end
	end

	return ""
end

DreamPainterConfig.instance = DreamPainterConfig.New()

return DreamPainterConfig
