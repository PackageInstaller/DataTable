-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/singlerecharge/model/SinglerechargeModel.lua

module("logic.extensions.singlerecharge.view.SinglerechargeModel", package.seeall)

local SinglerechargeModel = class("SinglerechargeModel", BaseModel)
local SinglerechargeRedID_WholeLife = "SinglerechargeRedID_WholeLife"

function SinglerechargeModel:ctor()
	return
end

function SinglerechargeModel:onInit()
	self:onReset()
end

function SinglerechargeModel:onReset()
	self._items = {}
end

function SinglerechargeModel:setItems(items)
	self._items = items
end

function SinglerechargeModel:getItems()
	return self._items
end

function SinglerechargeModel:gainPrizeRes(itemId)
	for i, v in ipairs(self._items) do
		if v.itemId == itemId then
			v.gainTimes = v.gainTimes + 1

			break
		end
	end
end

function SinglerechargeModel:checkFirstOpenRedPoint()
	local str = GameUtil.getUserData(SinglerechargeRedID_WholeLife)

	return string.nilorempty(str)
end

function SinglerechargeModel:recordFirstOpenRedPoint()
	GameUtil.saveUserData(SinglerechargeRedID_WholeLife, "isOk")
end

SinglerechargeModel.instance = SinglerechargeModel.New()

return SinglerechargeModel
