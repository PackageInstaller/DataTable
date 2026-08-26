-- chunkname: @modules/logic/versionactivity1_6/act152/model/Activity152Model.lua

module("modules.logic.versionactivity1_6.act152.model.Activity152Model", package.seeall)

local Activity152Model = class("Activity152Model", BaseModel)

function Activity152Model:onInit()
	self:reInit()
end

function Activity152Model:reInit()
	self._act152Presents = {}
end

function Activity152Model:setActivity152Infos(info)
	self._act152Presents = {}

	for _, present in ipairs(info) do
		table.insert(self._act152Presents, present)
	end
end

function Activity152Model:setActivity152PresentGet(id)
	table.insert(self._act152Presents, id)
end

function Activity152Model:getActivity152Presents()
	return self._act152Presents
end

function Activity152Model:isPresentAccepted(id)
	for _, v in pairs(self._act152Presents) do
		if v == id then
			return true
		end
	end

	local antiques = AntiqueModel.instance:getAntiqueList()
	local actCo = Activity152Config.instance:getAct152Co(id)
	local bonus = string.split(actCo.bonus, "|")

	for _, v in ipairs(bonus) do
		local rewards = string.splitToNumber(v, "#")

		if rewards[1] == MaterialEnum.MaterialType.Antique and rewards[2] == id then
			return true
		end
	end

	return false
end

function Activity152Model:getPresentUnaccepted()
	local presents = {}
	local allUnlockPresents = self:getAllUnlockPresents()

	for _, v in pairs(allUnlockPresents) do
		if not self:isPresentAccepted(v) then
			table.insert(presents, v)
		end
	end

	return presents
end

function Activity152Model:getAllUnlockPresents()
	local cos = Activity152Config.instance:getAct152Cos()
	local presents = {}

	for _, v in pairs(cos) do
		local unlockTime = TimeUtil.stringToTimestamp(v.acceptDate) + ServerTime.clientToServerOffset()

		if unlockTime <= ServerTime.now() then
			table.insert(presents, v.presentId)
		end
	end

	return presents
end

function Activity152Model:hasPresentAccepted()
	local allUnlockPresents = self:getAllUnlockPresents()

	for _, v in pairs(allUnlockPresents) do
		if self:isPresentAccepted(v) then
			return true
		end
	end

	return false
end

function Activity152Model:getNextUnlockLimitTime()
	local cos = Activity152Config.instance:getAct152Cos()
	local limitTime = -1

	for _, v in pairs(cos) do
		local unlockTime = TimeUtil.stringToTimestamp(v.acceptDate) + ServerTime.clientToServerOffset()

		if unlockTime >= ServerTime.now() and (limitTime == -1 or limitTime > unlockTime - ServerTime.now()) then
			limitTime = unlockTime - ServerTime.now()
		end
	end

	return limitTime
end

Activity152Model.instance = Activity152Model.New()

return Activity152Model
