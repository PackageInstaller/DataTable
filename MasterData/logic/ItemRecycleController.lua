-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/controller/ItemRecycleController.lua

module("logic.extensions.itembag.controller.ItemRecycleController", package.seeall)

local ItemRecycleController = class("ItemRecycleController", BaseController)

function ItemRecycleController:onInit()
	self:onReset()
end

function ItemRecycleController:onReset()
	return
end

function ItemRecycleController:sendGetInfo()
	ResourceConversionAgent.instance:sendPM_ResourceConvertGetInfoReq()
end

function ItemRecycleController:handlePM_ResourceConvertGetInfoRes(msg)
	ItemRecycleModel.instance:updateTodayTimes(msg.convertTimesList)
	GlobalDispatcher:dispatch(GlobalNotify.ITEM_RECYCLE_INFO_UPDATE)
end

function ItemRecycleController:sendQualiytList(list)
	local req = ResourceConversionExtension_pb.PM_RCQualityConvertReq()

	for i, v in ipairs(list) do
		local item = req.qualityItemList:add()

		item.materialType = v.materialType
		item.periodId = v.periodId

		for j, id in ipairs(v.itemIds) do
			item.itemIds:append(id)
		end
	end

	ResourceConversionAgent.instance:sendMsg(req)
end

function ItemRecycleController:sendDefineList(list)
	local req = ResourceConversionExtension_pb.PM_RCDefineConvertReq()

	for i, v in ipairs(list) do
		local item = req.defineItemList:add()

		item.materialType = v.materialType
		item.periodId = v.periodId
		item.defineId = v.defineId
		item.num = v.num
	end

	ResourceConversionAgent.instance:sendMsg(req)
end

ItemRecycleController.instance = ItemRecycleController.New()

return ItemRecycleController
