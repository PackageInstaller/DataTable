-- chunkname: @modules/logic/critter/controller/CritterSummonController.lua

module("modules.logic.critter.controller.CritterSummonController", package.seeall)

local CritterSummonController = class("CritterSummonController", BaseController)

function CritterSummonController:onInit()
	return
end

function CritterSummonController:onInitFinish()
	return
end

function CritterSummonController:addConstEvents()
	return
end

function CritterSummonController:reInit()
	return
end

function CritterSummonController:summonCritterInfoReply(msg)
	CritterSummonModel.instance:initSummonPools(msg.poolInfos)
end

function CritterSummonController:summonCritterReply(msg)
	local critterInfos = msg.critterInfos
	local critterMOList = {}

	if critterInfos then
		for i, critterInfo in ipairs(critterInfos) do
			local critterMo = CritterModel.instance:addCritter(critterInfo)

			table.insert(critterMOList, critterMo)
		end
	end

	if critterMOList and #critterMOList > 0 then
		CritterSummonModel.instance:onSummon(msg.poolId, msg.hasSummonCritter)

		local param = {
			mode = RoomSummonEnum.SummonType.Summon,
			poolId = msg.poolId,
			critterMo = critterMOList[1],
			critterMOList = critterMOList
		}

		self:dispatchEvent(CritterSummonEvent.onStartSummon, param)
	end
end

function CritterSummonController:resetSummonCritterPoolReply(msg)
	self:dispatchEvent(CritterSummonEvent.onResetSummon, msg.poolId, msg.poolId)
end

function CritterSummonController:refreshSummon(poolId, callback, callbackObj)
	CritterRpc.instance:sendSummonCritterInfoRequest(callback, callbackObj)
end

function CritterSummonController:openSummonRuleTipView(type)
	ViewMgr.instance:openView(ViewName.RoomCritterSummonRuleTipsView, {
		type = type
	})
end

function CritterSummonController:openSummonView(buildingUid, param)
	if buildingUid and param then
		local cameraId = RoomSummonEnum.SummonMode[param.mode].CameraId

		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(buildingUid, cameraId, function()
			self:_reallyOpenSummonView(param)
		end)
	else
		self:_reallyOpenSummonView(param)
	end
end

function CritterSummonController:_reallyOpenSummonView(param)
	self:dispatchEvent(CritterSummonEvent.onStartSummonAnim, param)
	ViewMgr.instance:openView(ViewName.RoomCritterSummonSkipView, param)
end

function CritterSummonController:openSummonGetCritterView(param, isSkip)
	param = param or {}
	param.isSkip = isSkip

	ViewMgr.instance:openView(ViewName.RoomGetCritterView, param)
end

function CritterSummonController:onCanDrag()
	self:dispatchEvent(CritterSummonEvent.onCanDrag)
end

function CritterSummonController:onSummonDragEnd(mode, rare)
	self:dispatchEvent(CritterSummonEvent.onDragEnd, mode, rare)
end

function CritterSummonController:onFinishSummonAnim(mode)
	self:dispatchEvent(CritterSummonEvent.onEndSummon, mode)
end

CritterSummonController.instance = CritterSummonController.New()

return CritterSummonController
