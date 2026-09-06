-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/agent/MMDrinkShopAgent.lua

module("logic.extensions.mmdrinkshop.agent.MMDrinkShopAgent", package.seeall)

local MMDrinkShopAgent = class("MMDrinkShopAgent", BaseAgent)

function MMDrinkShopAgent:sendPM_MMDrinkShopGetInfoReq(activityId)
	local req = MMDrinkShopExtension_pb.PM_MMDrinkShopGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MMDrinkShopAgent:handlePM_MMDrinkShopGetInfoRes(status, msg)
	if status == 0 then
		MMDrinkShopController.instance:handlePM_MMDrinkShopGetInfoRes(msg)
	end
end

function MMDrinkShopAgent:sendPM_MMDrinkShopStartMakeReq(activityId, slotId, steps_pb_Ary)
	local req = MMDrinkShopExtension_pb.PM_MMDrinkShopStartMakeReq()

	req.activityId = activityId
	req.slotId = slotId

	if steps_pb_Ary ~= nil then
		for i, v1 in ipairs(steps_pb_Ary) do
			local steps = req.steps:add()

			steps.stepId = v1.stepId

			for j, v2 in ipairs(v1.toppingsIds) do
				steps.toppingsIds:append(v2)
			end
		end
	end

	self:sendMsg(req)
end

function MMDrinkShopAgent:handlePM_MMDrinkShopStartMakeRes(status, msg)
	if status == 0 then
		MMDrinkShopController.instance:handlePM_MMDrinkShopStartMakeRes(msg)
	end
end

function MMDrinkShopAgent:sendPM_MMDrinkShopFinishMakeReq(activityId, slotId)
	local req = MMDrinkShopExtension_pb.PM_MMDrinkShopFinishMakeReq()

	req.activityId = activityId
	req.slotId = slotId

	self:sendMsg(req)
end

function MMDrinkShopAgent:handlePM_MMDrinkShopFinishMakeRes(status, msg)
	if status == 0 then
		MMDrinkShopController.instance:handlePM_MMDrinkShopFinishMakeRes(msg)
	end
end

function MMDrinkShopAgent:sendPM_MMDrinkShopGainPrizeReq(activityId, prizeId)
	local req = MMDrinkShopExtension_pb.PM_MMDrinkShopGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function MMDrinkShopAgent:handlePM_MMDrinkShopGainPrizeRes(status, msg)
	if status == 0 then
		MMDrinkShopController.instance:handlePM_MMDrinkShopGainPrizeRes(msg)
	end
end

MMDrinkShopAgent.instance = MMDrinkShopAgent.New()

return MMDrinkShopAgent
