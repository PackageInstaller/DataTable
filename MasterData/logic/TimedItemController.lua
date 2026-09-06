-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeditem/controller/TimedItemController.lua

module("logic.extensions.timeditem.controller.TimedItemController", package.seeall)

local TimedItemController = class("TimedItemController", BaseController)

function TimedItemController:ctor()
	TimedItemController.super.ctor(self)
end

function TimedItemController:onInit()
	GlobalDispatcher:addListener(MaterialAgent.NotifyTimedItemChangeRes, self.onTimedItemChange, self)
	GlobalDispatcher:addListener(MaterialAgent.LoadAllMaterialsRes, self.onLoadAll, self)
	GlobalDispatcher:addListener(MaterialAgent.NotifyExpirableItemChangeRes, self.onExpirableItemChange, self)
	self:onReset()
end

function TimedItemController:onReset()
	return
end

function TimedItemController:onLoadAll(status, msg)
	TimedItemModel.instance:loadAllItems(msg.timedItems)
	TimedItemModel.instance:loadAllExpirableItems(msg.expirableItems)
end

function TimedItemController:onTimedItemChange(status, msg)
	TimedItemModel.instance:addItems(msg.timedItems)
	TimedItemModel.instance:deleteItems(msg.deletedItemIds)
	GlobalDispatcher:dispatch(GlobalNotify.TimedItemChange)
end

function TimedItemController:onExpirableItemChange(status, msg)
	TimedItemModel.instance:addExpirableItems(msg.changeList)
	TimedItemModel.instance:deleteExpirableItems(msg.deleteItemIds)
	GlobalDispatcher:dispatch(GlobalNotify.ExpirableItemChange)
end

function TimedItemController:getOperationSignInBuffId()
	local actId = OperationSignInModel.instance:getActivityId()

	if actId then
		local extraCfg = OperationSignInConfig.instance:getSignInExtra(actId)

		if extraCfg and extraCfg.itemBuff then
			local list = string.split(extraCfg.itemBuff, ",")

			for k, v in pairs(list) do
				local str = string.split(v, ":")
				local itemId = checknumber(str[1])
				local itemMo = TimedItemModel.instance:getTimedItemInfo(itemId)

				if itemMo then
					return checknumber(str[2]), itemMo
				end
			end
		end
	end

	return nil
end

TimedItemController.instance = TimedItemController.New()

return TimedItemController
