-- chunkname: @modules/logic/critter/controller/CritterIncubateController.lua

module("modules.logic.critter.controller.CritterIncubateController", package.seeall)

local CritterIncubateController = class("CritterIncubateController", BaseController)

function CritterIncubateController:onInit()
	self._incubateCritterList = nil
	self._incubateCritterList = 1
end

function CritterIncubateController:onInitFinish()
	return
end

function CritterIncubateController:addConstEvents()
	return
end

function CritterIncubateController:reInit()
	self._incubateCritterList = nil
	self._incubateCritterList = 1
end

function CritterIncubateController:getIncubateCritterIds()
	local uid1 = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(1)
	local uid2 = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(2)

	return uid1, uid2
end

function CritterIncubateController:onIncubateCritterPreview()
	local parent1, parent2 = self:getIncubateCritterIds()

	CritterRpc.instance:sendIncubateCritterPreviewRequest(parent1, parent2)
end

function CritterIncubateController:openRoomCritterDetailView()
	local critterMos = CritterIncubateModel.instance:getChildMOList()

	CritterController.instance:openRoomCritterDetailView(true, nil, true, critterMos)
end

function CritterIncubateController:onIncubateCritterPreviewReply(msg)
	CritterIncubateModel.instance:setCritterPreviewInfo(msg.childes)
	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onIncubateCritterPreviewReply)
end

function CritterIncubateController:onIncubateCritter()
	local parent1, parent2 = self:getIncubateCritterIds()

	CritterRpc.instance:sendIncubateCritterRequest(parent1, parent2)
end

function CritterIncubateController:incubateCritterReply(msg)
	self._incubateCritterList = msg.childes
	self._showCritterIndex = 1

	if not LuaUtil.tableNotEmpty(self._incubateCritterList) then
		return
	end

	local critterInfo = self._incubateCritterList[self._showCritterIndex]

	if LuaUtil.tableNotEmpty(critterInfo) then
		local critterMo = CritterModel.instance:addCritter(critterInfo)
		local param = {
			mode = RoomSummonEnum.SummonType.Incubate,
			parent1 = msg.parent1,
			parent2 = msg.parent2,
			critterMo = critterMo
		}

		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onStartSummon, param)
	end
end

function CritterIncubateController:checkHasChildCritter()
	if not LuaUtil.tableNotEmpty(self._incubateCritterList) then
		return
	end

	if not self._showCritterIndex then
		return
	end

	if self._showCritterIndex >= #self._incubateCritterList then
		return
	end

	self._showCritterIndex = self._showCritterIndex + 1

	local critterInfo = self._incubateCritterList[self._showCritterIndex]

	if LuaUtil.tableNotEmpty(critterInfo) then
		return (CritterModel.instance:addCritter(critterInfo))
	end
end

CritterIncubateController.instance = CritterIncubateController.New()

return CritterIncubateController
