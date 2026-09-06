-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/controller/PowerCrystalController.lua

module("logic.extensions.powercrystal.controller.PowerCrystalController", package.seeall)

local PowerCrystalController = class("PowerCrystalController", BaseController)

function PowerCrystalController:ctor()
	self.model = PowerCrystalModel.instance
end

function PowerCrystalController:OpenView()
	if ViewMgr.instance:isOpen(ViewName.PowerCrystal) then
		local view = ViewMgr.instance._views[ViewName.PowerCrystal]._views[1]

		view:UpdateView()
	else
		local pet_num = self.model:getPetNum()

		if pet_num < 5 then
			FloatWordMgr.instance:show("当前身上精灵不足5只，无法开启力量之核")

			return
		end

		UIStateManager.instance:push(ViewName.PowerCrystal)
	end
end

function PowerCrystalController:CloseView()
	ViewMgr.instance:close(ViewName.PowerCrystal)
end

function PowerCrystalController:sendPM_PowerCrystalGetInfoReq()
	local function resFunc(msg)
		local leaderpetids = msg.leaderPetIds
		local slotinfos = msg.slotInfos
		local useUnlockItemItems = msg.useUnlockItemTimes

		self.model:setUseUnlockItemItems(useUnlockItemItems)
		self.model:setLeaderpetids(leaderpetids)
		self.model:setSlotInfos(slotinfos)
		self.model:initInPowerCrystalPetList()
		self.model:resProtoSuccessed()
		self.model:checkRedDot()
		self:localNotify(PowerCrystalModel.RefreshMainView)
		GlobalDispatcher:dispatch(PowerCrystalModel.GetInfoSuccessed)
	end

	PowerCrystalAgent.instance:sendPM_PowerCrystalGetInfoReq(resFunc)
end

function PowerCrystalController:sendPM_PowerCrystalPutInSlotReq(slotId, petId)
	local function resFunc(msg)
		local slotid = msg.slotId
		local petid = msg.petId
		local curlv = msg.curLv
		local curtalent = msg.curTalent
		local originallv = msg.originalLv
		local originaltalent = msg.originalTalent

		self.model:putInPetSuccessed(slotid, petid, curlv, curtalent, originallv, originaltalent)
		self:localNotify(PowerCrystalModel.PutInPetSuccess, slotid)
	end

	PowerCrystalAgent.instance:sendPM_PowerCrystalPutInSlotReq(slotId, petId, resFunc)
end

function PowerCrystalController:sendPM_PowerCrystalTakeOutOfSlotReq(slotId)
	local function resFunc(msg)
		local slotid = msg.slotId
		local cdinternval = msg.cdInternval

		self.model:putOffPetSuccessed(slotid, cdinternval)
		GlobalDispatcher:dispatch(GlobalNotify.PetBattleChange)
		self:localNotify(PowerCrystalModel.RefreshMainView)
	end

	PowerCrystalAgent.instance:sendPM_PowerCrystalTakeOutOfSlotReq(slotId, resFunc)
end

function PowerCrystalController:sendPM_PowerCrystalClearSlotCdReq(slotId)
	local function resFunc(msg)
		local slotid = msg.slotId

		self.model:clearCoolSuccessed(slotid)
		GlobalDispatcher:dispatch(GlobalNotify.PetBattleChange)
	end

	PowerCrystalAgent.instance:sendPM_PowerCrystalClearSlotCdReq(slotId, resFunc)
end

function PowerCrystalController:sendPM_PowerCrystalUnlockSlotReq(slotId)
	local function resFunc(msg)
		self.model:unLockSlotSuccess(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PetBattleChange)
	end

	PowerCrystalAgent.instance:sendPM_PowerCrystalUnlockSlotReq(slotId, resFunc)
end

PowerCrystalController.instance = PowerCrystalController.New()

return PowerCrystalController
