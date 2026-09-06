-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/controller/FamilyCallOrderController.lua

module("logic.extensions.newfamily.controller.FamilyCallOrderController", package.seeall)

local FamilyCallOrderController = class("FamilyCallOrderController", BaseController)

function FamilyCallOrderController:ctor()
	return
end

function FamilyCallOrderController:onInit()
	FamilyCallOrderController.super.onInit(self)
end

function FamilyCallOrderController:onReset()
	return
end

function FamilyCallOrderController:isPrizeGetted(prizeId)
	local prizeIds = FamilyCallOrderModel.instance:getFamilGainedProgressPrizeIds()

	return table.indexof(prizeIds, prizeId) ~= false
end

function FamilyCallOrderController:sendPM_FamilySummonCommandGetInfoReq()
	local activityId = FamilyCallOrderConfig.instance:getOpenActivityId()

	if checknumber(activityId) <= 0 then
		activityId = 149001

		printError("没有获取到活动id哦！！！！！！！！")
	end

	FamilySummonCommandAgent.instance:sendPM_FamilySummonCommandGetInfoReq(activityId)
end

function FamilyCallOrderController:sendPM_FamilySummonCommandGainPrizeReq(prizeId)
	local activityId = FamilyCallOrderConfig.instance:getOpenActivityId()

	if checknumber(activityId) <= 0 then
		activityId = 149001

		printError("没有获取到活动id哦！！！！！！！！")
	end

	FamilySummonCommandAgent.instance:sendPM_FamilySummonCommandGainPrizeReq(activityId, prizeId)
end

function FamilyCallOrderController:sendPM_FamilySummonCommandViewFamilyRankReq()
	local activityId = FamilyCallOrderConfig.instance:getOpenActivityId()
	local startRank = 1
	local endRank = 100

	if checknumber(activityId) <= 0 then
		activityId = 149001

		printError("没有获取到活动id哦！！！！！！！！")
	end

	FamilySummonCommandAgent.instance:sendPM_FamilySummonCommandViewFamilyRankReq(activityId, startRank, endRank)
end

function FamilyCallOrderController:sendPM_FamilySummonCommandViewFamilyRankReq_TopThree()
	local activityId = FamilyCallOrderConfig.instance:getOpenActivityId()
	local startRank = 1
	local endRank = 3

	FamilySummonCommandAgent.instance:sendPM_FamilySummonCommandViewFamilyRankReq(activityId, startRank, endRank)
end

function FamilyCallOrderController:sendPM_FamilySummonCommandViewMemberRankReq()
	local activityId = FamilyCallOrderConfig.instance:getOpenActivityId()

	if checknumber(activityId) <= 0 then
		activityId = 149001

		printError("没有获取到活动id哦！！！！！！！！")
	end

	FamilySummonCommandAgent.instance:sendPM_FamilySummonCommandViewMemberRankReq(activityId)
end

function FamilyCallOrderController:getProgressCfgById(planId)
	local activityId = FamilyCallOrderConfig.instance:getOpenActivityId()

	if checknumber(activityId) <= 0 then
		activityId = 149001

		printError("没有获取到活动id哦！！！！！！！！")
	end
end

function FamilyCallOrderController:playEffect(cell, view, tableview)
	local effect = UIEffectManager.instance:playEffect(view, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(tableview) then
			eff:setClipping(tableview)
		end
	end)

	effect:setParent(cell.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(0.8)

	return effect
end

function FamilyCallOrderController:clearEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)
	end
end

FamilyCallOrderController.instance = FamilyCallOrderController.New()

return FamilyCallOrderController
