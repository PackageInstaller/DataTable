-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petlease/controller/PetLeaseController.lua

module("logic.extensions.petlease.controller.PetLeaseController", package.seeall)

local PetLeaseController = class("PetLeaseController", BaseController)

function PetLeaseController:ctor()
	return
end

function PetLeaseController:onInit()
	PetLeaseController.super.onInit(self)
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
	PetLeaseAgent.instance:addHandler(PetLeaseAgent.PM_LoadHasRentPetRes, self.SCPushHirePetsData, self)
	PetLeaseAgent.instance:addHandler(PetLeaseAgent.PM_LeasePetGetInfoRes, self.SCPushRentPetsData, self)
	PetLeaseAgent.instance:addHandler(PetLeaseAgent.PM_NotifyRentPetUseTimesChangeRes, self.SCPushRentPetsTimes, self)
end

function PetLeaseController:onReset()
	return
end

function PetLeaseController:_TickDailyRefreshData()
	self:CSRequestHirePetsInfo()

	if ViewMgr.instance:isOpen(ViewName.PetLease) then
		self:CSRequestRentPetsInfo()
	end
end

function PetLeaseController:CSRequestHirePetsInfo()
	PetLeaseAgent.instance:sendPM_LoadHasRentPetReq()
end

function PetLeaseController:SCPushHirePetsData(msg)
	PetLeaseModel.instance:SCPushHirePetsData(msg)
end

function PetLeaseController:CSRequestHireUserPet(reqList)
	local req = PetLeaseExtension_pb.PM_RentPetReq()
	local arr = {}

	if reqList and #reqList > 0 then
		for i = 1, #reqList do
			local rentReqList = req.rentReqList:add()

			rentReqList.slotId = reqList[i].slotId
			rentReqList.leaseUserId = reqList[i].leaseUserId
			rentReqList.leasePetId = reqList[i].leasePetId

			table.insert(arr, rentReqList)
		end
	end

	PetLeaseAgent.instance:sendPM_RentPetReq(arr, function(msg)
		if msg == nil or msg.rentPet == nil then
			printError("sr--PetLeaseController:CSRequestHireUserPet()    上位借用精灵返回协议数据有误！！")

			return
		end

		FloatWordMgr.instance:show("已选择租用精灵！")
		PetLeaseModel.instance:SCPushHireSinglePet(msg.rentPet, msg.expireTime)
	end, nil, function()
		FloatWordMgr.instance:show("租用精灵选择失败！")
	end)
end

function PetLeaseController:CSRequestRentPetsInfo()
	PetLeaseAgent.instance:sendPM_LeasePetGetInfoReq()
end

function PetLeaseController:SCPushRentPetsData(msg)
	PetLeaseModel.instance:SCPushRentPetsData(msg)
end

function PetLeaseController:CSRequestRentMyPet(reqList)
	local req = PetLeaseExtension_pb.PM_LeasePetReq()
	local arr = {}

	if reqList and #reqList > 0 then
		for i = 1, #reqList do
			local leaseReqList = req.leaseReqList:add()

			leaseReqList.slotId = reqList[i].slotId
			leaseReqList.petId = reqList[i].petId

			table.insert(arr, leaseReqList)
		end
	end

	PetLeaseAgent.instance:sendPM_LeasePetReq(arr, function()
		FloatWordMgr.instance:show("出租精灵已派出！")
		PetLeaseModel.instance:SCPushRentSinglePet(reqList, true)
	end, nil, function()
		FloatWordMgr.instance:show("出租精灵派出失败！")
	end)
end

function PetLeaseController:CSRequestTakeOffRentMyPet(posId)
	PetLeaseAgent.instance:sendPM_PetLeaseTakeOffPetReq(posId, function()
		FloatWordMgr.instance:show("已下架出租精灵！")

		local reqList = {}

		reqList[1] = {
			petId = 0,
			slotId = posId
		}

		PetLeaseModel.instance:SCPushRentSinglePet(reqList, false)
	end, nil, function()
		FloatWordMgr.instance:show("下架出租精灵失败！")
	end)
end

function PetLeaseController:SCPushRentPetsTimes(msg)
	if msg == nil or msg.useTimes == nil then
		return
	end

	PetLeaseModel.instance:SCPushRentPetsTimes({
		msg.useTimes
	})
end

PetLeaseController.instance = PetLeaseController.New()

return PetLeaseController
