-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/controller/ElemeController.lua

module("logic.extensions.eleme.controller.ElemeController", package.seeall)

local ElemeController = class("ElemeController", BaseController)

function ElemeController:onInit()
	self:onReset()
end

function ElemeController:onReset()
	self._fmtMo = ElemeFmtMo.New()
end

function ElemeController:sendGetInfo(activityId)
	ElemeAgent.instance:sendPM_ElemeInfoReq(activityId)
end

function ElemeController:onGetInfo(msg)
	ElemeModel.instance:onGetInfo(msg)

	local activityId = msg.activityId
	local msgInfo = ElemeModel.instance:getMsgInfo(activityId) or {}

	if not msgInfo.orders then
		local list = {}

		for i, v in ipairs(list) do
			local npcCfg = ElemeConfig.instance:getNpcById(v.index)

			if v.state == 1 then
				SceneNpcsMgr.instance:createNpc(npcCfg.npcId)
			elseif v.state == 2 then
				SceneNpcsMgr.instance:removeNpc(npcCfg.npcId)
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.ElemeInfoUpdate)
	end
end

function ElemeController:sendRefreshOrder(activityId, index)
	ElemeAgent.instance:sendPM_ElemeRefreshOrderReq(activityId, index)
end

function ElemeController:onRefreshOrder(msg)
	ElemeModel.instance:onRefreshOrder(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ElemeInfoUpdate)
end

function ElemeController:sendTakeOrder(activityId, index)
	ElemeAgent.instance:sendPM_ElemeTakeOrderReq(activityId, index)
end

function ElemeController:onTakeOrder(msg)
	ElemeModel.instance:onTakeOrder(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ElemeInfoUpdate)
end

function ElemeController:sendGetPrize(activityId, index)
	ElemeAgent.instance:sendPM_ElemeGainPrizeReq(activityId, index)
end

function ElemeController:onGetPrize(msg)
	ElemeModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ElemeInfoUpdate)
end

function ElemeController:onClickNpc(npcId, activityId)
	local msgInfo = ElemeModel.instance:getMsgInfo(activityId) or {}

	if not msgInfo.orders then
		local list = {}

		for i, v in ipairs(list) do
			local npcCfg = ElemeConfig.instance:getNpcById(v.index)

			if npcCfg.npcId == npcId then
				self:openFmtView(activityId, v.index, v.orderId)
			end
		end
	end
end

function ElemeController:openFmtView(activityId, index, orderId)
	self._fmtMo:initParams(activityId, index, orderId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function ElemeController:sendStartFight(activityId, index, simpleForm)
	UIJumper.instance:pushOneStack(ViewName.ElememainView)
	ElemeAgent.instance:sendPM_ElemeFightReq(activityId, index, simpleForm)
end

function ElemeController:onFightEnd(msg)
	local activityId = msg.activityId
	local index = msg.index
	local isWin = msg.isWin

	if isWin then
		local msgInfo = ElemeModel.instance:getMsgInfo(activityId) or {}

		if not msgInfo.orders then
			local list = {}

			for i, v in ipairs(list) do
				local npcCfg = ElemeConfig.instance:getNpcById(v.index)

				if v.index == index then
					SceneNpcsMgr.instance:removeNpc(npcCfg.npcId)

					break
				end
			end
		end
	end
end

ElemeController.instance = ElemeController.New()

return ElemeController
