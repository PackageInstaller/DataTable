-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playersetting/model/PlayerLocalStorgeModel.lua

module("logic.extensions.playersetting.model.PlayerLocalStorgeModel", package.seeall)

local PlayerLocalStorgeModel = class("PlayerLocalStorgeModel", BaseModel)
local UserKey_Format = "%s_%s_%s"

PlayerLocalStorgeModel.MusicKeyStr = "Music"
PlayerLocalStorgeModel.SoundEffKeyStr = "SoundEff"
PlayerLocalStorgeModel.DungeonPlotToggleKeyStr = "DungeonPlotToggle"

function PlayerLocalStorgeModel:onInit()
	self:onReset()
end

function PlayerLocalStorgeModel:onReset()
	self._dungeonPlotToggleList = {}
end

function PlayerLocalStorgeModel:_getMusicKey()
	return PlayerLocalStorgeModel.MusicKeyStr
end

function PlayerLocalStorgeModel:setMusic(isOn)
	local key = self:_getMusicKey()

	if isOn then
		Astral.LocalStorage.Instance:SetInt(key, 1)
	else
		Astral.LocalStorage.Instance:SetInt(key, 0)
	end
end

function PlayerLocalStorgeModel:getMusic()
	local key = self:_getMusicKey()
	local i = Astral.LocalStorage.Instance:GetInt(key, 1)

	return i == 1
end

function PlayerLocalStorgeModel:_getSoundEffKey()
	return PlayerLocalStorgeModel.SoundEffKeyStr
end

function PlayerLocalStorgeModel:setSoundEff(isOn)
	local key = self:_getSoundEffKey()

	if isOn then
		Astral.LocalStorage.Instance:SetInt(key, 1)
	else
		Astral.LocalStorage.Instance:SetInt(key, 0)
	end
end

function PlayerLocalStorgeModel:getSoundEff()
	local key = self:_getSoundEffKey()
	local i = Astral.LocalStorage.Instance:GetInt(key, 1)

	return i == 1
end

function PlayerLocalStorgeModel:getDungeonPlotToggle(dungeonId)
	if self._dungeonPlotToggleList[dungeonId] ~= nil then
		return self._dungeonPlotToggleList[dungeonId]
	end

	local key = string.format(UserKey_Format, PlayerModel.instance:getId(), PlayerLocalStorgeModel.DungeonPlotToggleKeyStr, dungeonId)
	local i = Astral.LocalStorage.Instance:GetInt(key, 1)

	self._dungeonPlotToggleList[dungeonId] = i == 1

	return i == 1
end

function PlayerLocalStorgeModel:setDungeonPlotToggle(dungeonId, isOn)
	local key = string.format(UserKey_Format, PlayerModel.instance:getId(), PlayerLocalStorgeModel.DungeonPlotToggleKeyStr, dungeonId)

	if isOn then
		Astral.LocalStorage.Instance:SetInt(key, 1)
	else
		Astral.LocalStorage.Instance:SetInt(key, 0)
	end

	self._dungeonPlotToggleList[dungeonId] = isOn
end

PlayerLocalStorgeModel.instance = PlayerLocalStorgeModel.New()

return PlayerLocalStorgeModel
