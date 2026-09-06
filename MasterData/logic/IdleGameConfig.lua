-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/config/IdleGameConfig.lua

module("logic.extensions.idlegame.config.IdleGameConfig", package.seeall)

local IdleGameConfig = class("IdleGameConfig", BaseConfig)

function IdleGameConfig:onInit()
	IdleGameConfig.super.onInit(self)

	self._xiaonuoplace = nil
	self._xiaonuoplaceprize = nil
	self._xiaonuoplacerank = nil
end

function IdleGameConfig:getNames()
	return {
		"xiaonuoplace",
		"xiaonuoplaceprize",
		"xiaonuoplacerank",
		"xiaonuoplaceforeverprize"
	}
end

function IdleGameConfig:handleConfig(name, content)
	if name == "xiaonuoplace" then
		self._xiaonuoplace = content
		self._xiaonuoplaces = content.dataList
	elseif name == "xiaonuoplaceprize" then
		self._xiaonuoplaceprizes = content.dataList
		self._xiaonuoplaceprize = content

		print("len = " .. #self._xiaonuoplaceprize)
	elseif name == "xiaonuoplacerank" then
		self._xiaonuoplacerank = content.dataList
	elseif name == "xiaonuoplaceforeverprize" then
		self.xiaonuoplaceforeverprizeCfg = content
	end
end

function IdleGameConfig:getXiaoNuoPlaceCfg(level)
	return self._xiaonuoplace[level]
end

function IdleGameConfig:getProgressPrizes()
	return self._xiaonuoplaceprizes
end

function IdleGameConfig:getProgressPrize(id)
	return self._xiaonuoplaceprize[id]
end

function IdleGameConfig:getRankPrizes()
	return self._xiaonuoplacerank
end

function IdleGameConfig:getActPirzes(actId)
	return self.xiaonuoplaceforeverprizeCfg[actId]
end

function IdleGameConfig:getXiaoNuoPlaceCfgs()
	return self._xiaonuoplaces
end

IdleGameConfig.instance = IdleGameConfig.New()

return IdleGameConfig
