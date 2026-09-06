-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redstargodsell/model/RedstargodsellModel.lua

module("logic.extensions.redstargodsell.model.RedstargodsellModel", package.seeall)

local RedstargodsellModel = class("RedstargodsellModel", BaseModel)

function RedstargodsellModel:ctor()
	return
end

function RedstargodsellModel:onInit()
	self:onReset()
end

function RedstargodsellModel:onReset()
	self._giftInfo = {}
end

function RedstargodsellModel:setGift(actId, id, data)
	self._giftInfo[actId] = self._giftInfo[actId] or {}
	self._giftInfo[actId][id] = data
end

function RedstargodsellModel:getGift(actId, id)
	return self._giftInfo[actId][id]
end

RedstargodsellModel.instance = RedstargodsellModel.New()

return RedstargodsellModel
