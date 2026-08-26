-- chunkname: @modules/logic/survival/controller/work/SurvivalMsgPushWork.lua

module("modules.logic.survival.controller.work.SurvivalMsgPushWork", package.seeall)

local SurvivalMsgPushWork = class("SurvivalMsgPushWork", BaseWork)

function SurvivalMsgPushWork:ctor(msgName, msg)
	self._msgName = msgName or ""
	self._msg = msg
end

function SurvivalMsgPushWork:onStart(context)
	local handler = self["onReceive" .. self._msgName]

	if handler and handler(self, self._msg) then
		return
	end

	self:onDone(true)
end

function SurvivalMsgPushWork:onReceiveSurvivalHeroUpdatePush(msg)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo then
		weekInfo:updateHeroHealth(msg.hero)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSurvivalHeroHealthUpdate)
	end
end

function SurvivalMsgPushWork:onReceiveSurvivalBagUpdatePush(msg)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	local bag = weekInfo:getBag(msg.type)

	if not bag then
		return
	end

	bag:addOrUpdateItems(msg.updateItems)
	bag:removeItems(msg.delItemUids)

	if msg.type == SurvivalEnum.ItemSource.Map then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapBagUpdate, msg)
	elseif msg.type == SurvivalEnum.ItemSource.Shelter then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterBagUpdate, msg)

		local survivalShelterBuildingMo = weekInfo:getTechBuild()

		survivalShelterBuildingMo.survivalTechShelterMo:refreshRedDot()
	end

	SurvivalEquipRedDotHelper.instance:checkRed()
end

function SurvivalMsgPushWork:onReceiveSurvivalTaskUpdatePush(msg)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo then
		weekInfo.taskPanel:addOrUpdateTasks(msg.boxs)
		weekInfo.taskPanel:removeTasks(msg.removeTaskInfo)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTaskDataUpdate)
	end
end

return SurvivalMsgPushWork
