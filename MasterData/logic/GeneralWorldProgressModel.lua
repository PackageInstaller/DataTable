-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/generalworldprogress/model/GeneralWorldProgressModel.lua

module("logic.extensions.generalworldprogress.model.GeneralWorldProgressModel", package.seeall)

local GeneralWorldProgressModel = class("GeneralWorldProgressModel", BaseModel)

function GeneralWorldProgressModel:onInit()
	self:onReset()
end

function GeneralWorldProgressModel:onReset()
	self._curActId = 0
	self._curProgress = 0
	self._gainPrizeIds = {}
end

function GeneralWorldProgressModel:onGetInfo(msg)
	self._curActId = msg.actId
	self._curProgress = msg.curProgress
	self._gainPrizeIds = {}

	for k, v in ipairs(msg.gainPrizeIds) do
		table.insert(self._gainPrizeIds, v)
	end
end

function GeneralWorldProgressModel:onGainPrize(msg)
	self._gainPrizeIds = {}

	for k, v in ipairs(msg.gainPrizeIds) do
		table.insert(self._gainPrizeIds, v)
	end
end

function GeneralWorldProgressModel:getCurActId()
	return self._curActId
end

function GeneralWorldProgressModel:getCurProgress()
	return self._curProgress
end

function GeneralWorldProgressModel:getIsGainPrize(prizeId)
	return table.keyof(self._gainPrizeIds, prizeId)
end

GeneralWorldProgressModel.instance = GeneralWorldProgressModel.New()

return GeneralWorldProgressModel
