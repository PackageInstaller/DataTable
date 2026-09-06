-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/model/GoddessShopModel.lua

module("logic.extensions.goddessshop.model.GoddessShopModel", package.seeall)

local GoddessShopModel = class("GoddessShopModel", BaseModel)

function GoddessShopModel:onInit()
	self:onReset()
end

function GoddessShopModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function GoddessShopModel:getGoddessShopMo(activityId)
	self._moPool[activityId] = self._moPool[activityId] or GoddessShopMo.New(activityId)

	return self._moPool[activityId]
end

GoddessShopModel.instance = GoddessShopModel.New()

return GoddessShopModel
