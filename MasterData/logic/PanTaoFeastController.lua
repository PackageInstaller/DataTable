-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/controller/PanTaoFeastController.lua

module("logic.extensions.pantaofeast.controller.PanTaoFeastController", package.seeall)

local PanTaoFeastController = class("PanTaoFeastController", BaseController)

function PanTaoFeastController:onInit()
	self._keyStrMap = {}
	self._iconPathMap = {}

	self:onReset()
end

function PanTaoFeastController:onReset()
	table.clear(self._keyStrMap)
	table.clear(self._iconPathMap)
end

function PanTaoFeastController:getInfo(activityId)
	PanTaoFeastAgent.instance:sendPM_PanTaoFeastGetInfoReq(activityId)
end

function PanTaoFeastController:handlePM_PanTaoFeastGetInfoRes(msg)
	PanTaoFeastModel.instance:onGetInfo(msg)
	PanTaoFeastGameController.instance:initGameData(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastGetInfoRes)
end

function PanTaoFeastController:moveElements(activityId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastMoveElementsReq(activityId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastMoveElementsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastMoveElementsRes)
end

function PanTaoFeastController:produceElement(activityId, toolGridId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastProduceElementReq(activityId, toolGridId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastProduceElementRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastProduceElementRes)
end

function PanTaoFeastController:moveToStore(activityId, fromGridId, targetStashId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastMoveToStoreReq(activityId, fromGridId, targetStashId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastMoveToStoreRes(msg)
	PanTaoFeastModel.instance:onMoveToStore(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastMoveToStoreRes)
end

function PanTaoFeastController:mergeElements(activityId, beMergedGridId, mainGridId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastMergeElementsReq(activityId, beMergedGridId, mainGridId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastMergeElementsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastMergeElementsRes)
end

function PanTaoFeastController:autoMerge(activityId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastAutoMergeReq(activityId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastAutoMergeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastAutoMergeRes)
end

function PanTaoFeastController:useEnergyPack(activityId, gridId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastUseEnergyPackReq(activityId, gridId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastUseEnergyPackRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastUseEnergyPackRes)
end

function PanTaoFeastController:cookDish(activityId, cookToolId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastCookDishReq(activityId, cookToolId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastCookDishRes(msg)
	PanTaoFeastModel.instance:onCookDish(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastCookDishRes)
end

function PanTaoFeastController:stashToGrid(activityId, stashId, elementId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastStashToGridReq(activityId, stashId, elementId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastStashToGridRes(msg)
	PanTaoFeastModel.instance:onStashToGrid(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastStashToGridRes)
end

function PanTaoFeastController:deleteGridElement(activityId, gridId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastDeleteGridElementReq(activityId, gridId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastDeleteGridElementRes(msg)
	PanTaoFeastModel.instance:onDeleteGridElement(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastDeleteGridElementRes)
end

function PanTaoFeastController:submitOrder(activityId, orderId, costGridIds_i32_Ary)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastSubmitOrderReq(activityId, orderId, costGridIds_i32_Ary, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastSubmitOrderRes(msg)
	PanTaoFeastModel.instance:onSubmitOrder(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastSubmitOrderRes)
end

function PanTaoFeastController:gainRoundPrize(activityId, roundPrizeId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastGainRoundPrizeReq(activityId, roundPrizeId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastGainRoundPrizeRes(msg)
	PanTaoFeastModel.instance:onGainRoundPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastGainRoundPrizeRes)
end

function PanTaoFeastController:repairBuilding(activityId, buildingId)
	PanTaoFeastAgent.instance:sendPM_PanTaoFeastRepairBuildingReq(activityId, buildingId)
end

function PanTaoFeastController:handlePM_PanTaoFeastRepairBuildingRes(msg)
	PanTaoFeastModel.instance:onRepairBuilding(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastRepairBuildingRes)
end

function PanTaoFeastController:gainBookPrize(activityId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastGainBookPrizeReq(activityId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastGainBookPrizeRes(msg)
	PanTaoFeastModel.instance:onGainBookPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastGainBookPrizeRes)
end

function PanTaoFeastController:gainDailyGift(activityId)
	local changedGridElements_pb_Ary = self:getCurChangedGridElements(activityId)

	if changedGridElements_pb_Ary and #changedGridElements_pb_Ary > 0 then
		PanTaoFeastModel.instance:syncTempGridDataToModel(activityId)
	end

	PanTaoFeastAgent.instance:sendPM_PanTaoFeastGainDailyGiftReq(activityId, changedGridElements_pb_Ary)
end

function PanTaoFeastController:handlePM_PanTaoFeastGainDailyGiftRes(msg)
	PanTaoFeastModel.instance:onGainDailyGift(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastGainDailyGiftRes)
end

function PanTaoFeastController:getRankInfo(activityId)
	PanTaoFeastAgent.instance:sendPM_PanTaoFeastGetRankInfoReq(activityId)
end

function PanTaoFeastController:handlePM_PanTaoFeastGetRankInfoRes(msg)
	PanTaoFeastModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastGetRankInfoRes)
end

function PanTaoFeastController:handlePM_PanTaoFeastNotifyChangeRes(msg)
	PanTaoFeastModel.instance:onNotifyChange(msg)
	PanTaoFeastGameController.instance:syncBoardGridElements(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastNotifyChangeRes)

	local data = GameUtil.pbToTable(msg)
	local changeSocre = checknumber(data.score)

	if changeSocre > 0 then
		PanTaoFeastGameController.instance:tryPopScoreCI(changeSocre)
	end
end

function PanTaoFeastController:getCurChangedGridElements(activityId)
	return (PanTaoFeastGameController.instance:getDiffGridDataList(activityId))
end

function PanTaoFeastController:getDefaultActivityId()
	return 622001
end

function PanTaoFeastController:getKeyStrByActivityIdAndElementId(activityId, elementId)
	if not self._keyStrMap[activityId] then
		local keyMap = {}
		local keyStr = keyMap[elementId]

		if not keyStr then
			keyStr = string.format("pan_tao_feast_%s_%s", activityId, elementId)
			keyMap[elementId] = keyStr
			self._keyStrMap[activityId] = keyMap
		end

		return keyStr
	end
end

function PanTaoFeastController:getElementIconPathById(activityId, elementId)
	local key = self:getKeyStrByActivityIdAndElementId(activityId, elementId)
	local path = self._iconPathMap[key]

	if not path then
		local cfg = PanTaoFeastConfig.instance:getElementCfgByElementId(activityId, elementId)

		if cfg then
			path = cfg.iconPath
			self._iconPathMap[key] = cfg.iconPath
		end
	end

	return path
end

function PanTaoFeastController:getToolIconPathById(activityId, toolId)
	local key = self:getKeyStrByActivityIdAndElementId(activityId, toolId)
	local path = self._iconPathMap[key]

	if not path then
		local cfg = PanTaoFeastConfig.instance:getStashCfg(activityId, toolId)

		if cfg then
			path = cfg.iconPath
			self._iconPathMap[key] = cfg.iconPath
		end
	end

	return path
end

function PanTaoFeastController:forcePushView(viewName, ...)
	local isOpen = ViewMgr.instance:isOpen(viewName)

	if isOpen then
		UIStateManager.instance:popByName(viewName)
	end

	UIStateManager.instance:push(viewName, ...)
end

PanTaoFeastController.instance = PanTaoFeastController.New()

return PanTaoFeastController
