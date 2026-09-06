-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/agent/DrawEquipmentsAgent.lua

module("logic.extensions.drawequipments.agent.DrawEquipmentsAgent", package.seeall)

local DrawEquipmentsAgent = class("DrawEquipmentsAgent", BaseAgent)

function DrawEquipmentsAgent:sendPM_EquipmentPoolDrawReq(poolId, times)
	local req = EquipmentPoolExtension_pb.PM_EquipmentPoolDrawReq()

	req.poolId = poolId
	req.times = times

	self:sendMsg(req)
end

function DrawEquipmentsAgent:handlePM_EquipmentPoolDrawRes(status, msg)
	DrawEquipmentsController.instance:onEquipmentPoolDraw(status, msg)
end

function DrawEquipmentsAgent:sendPM_EquipmentPoolInfoReq()
	local req = EquipmentPoolExtension_pb.PM_EquipmentPoolInfoReq()

	self:sendMsg(req)
end

function DrawEquipmentsAgent:handlePM_EquipmentPoolInfoRes(status, msg)
	DrawEquipmentsController.instance:onEquipmentPoolInfo(status, msg)
end

DrawEquipmentsAgent.instance = DrawEquipmentsAgent.New()

return DrawEquipmentsAgent
