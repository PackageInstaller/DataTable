-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/config/PicturepuzzleConfig.lua

module("logic.extensions.picturepuzzle.config.PicturepuzzleConfig", package.seeall)

local PicturepuzzleConfig = class("PicturepuzzleConfig", BaseConfig)

function PicturepuzzleConfig:onInit()
	PicturepuzzleConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function PicturepuzzleConfig:getNames()
	return {
		"puzzle_jigsaw_activity",
		"puzzle_jigsaw_define",
		"puzzle_jigsaw_prize"
	}
end

function PicturepuzzleConfig:handleConfig(name, content)
	if name == "puzzle_jigsaw_activity" then
		self._activity = content
	elseif name == "puzzle_jigsaw_define" then
		self._define = content
	elseif name == "puzzle_jigsaw_prize" then
		self._prize = content
	end
end

function PicturepuzzleConfig:getActivity()
	return self._activity.dataList
end

function PicturepuzzleConfig:getActivityById(id)
	return self._activity[id]
end

function PicturepuzzleConfig:getDefine()
	return self._define.dataList
end

function PicturepuzzleConfig:getDefineById(id)
	return self._define[id]
end

function PicturepuzzleConfig:getPrize()
	return self._prize.dataList
end

function PicturepuzzleConfig:getPrizeById(id)
	return self._prize[id]
end

PicturepuzzleConfig.instance = PicturepuzzleConfig.New()

return PicturepuzzleConfig
