-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/model/FruitNinjaModel.lua

module("logic.extensions.fruitninja.model.FruitNinjaModel", package.seeall)

local FruitNinjaModel = class("FruitNinjaModel", BaseModel)

function FruitNinjaModel:onInit()
	self:onReset()
end

function FruitNinjaModel:onReset()
	self._moPool = {}
end

function FruitNinjaModel:getFruitNinjaMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = FruitNinjaMo.New(activityId)
	end

	return self._moPool[activityId]
end

FruitNinjaModel.instance = FruitNinjaModel.New()

return FruitNinjaModel
