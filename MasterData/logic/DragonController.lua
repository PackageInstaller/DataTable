-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/controller/DragonController.lua

module("logic.extensions.lottery.controller.DragonController", package.seeall)

local DragonController = class("DragonController", BaseController)

DragonController.drawEffectsConfig = {
	soundId = 30229,
	effNodes = "chouka_all/kapai1_all",
	effectTime = 9,
	effectPath = "fx_ui_chouka_10_linshi/chouka_chaoshen.prefab"
}
DragonController.DragonActType = {
	Wuxian = 3,
	Xj = 4,
	Endless = 5,
	Vireta = 8,
	YanLuo = 14,
	SkyFlash = 10,
	Chaoshenlong = 9,
	FireGod = 13,
	FireDragon = 7,
	JiSummoner = 6,
	MiZong = 12,
	Halo = 11,
	ChaoshenlongCopy = 30,
	Zhixulong = 2,
	Shenlong = 1
}
DragonController.EquipEffsByQuality = {
	"fx_ui_chouka_10_linshi/qiu1_lan.prefab",
	"fx_ui_chouka_10_linshi/qiu1_lan.prefab",
	"fx_ui_chouka_10_linshi/qiu1_zi.prefab",
	"fx_ui_chouka_10_linshi/qiu1_huang.prefab"
}

function DragonController:onInit()
	self:onReset()
end

function DragonController:onReset()
	self._tempId = nil
	self._typeId = nil
	self._tempNum = nil
	self._changeSetId = nil
	self._lastDrawItems = nil
	self._lastDrawQuas = nil
	self.openActType = nil
	self.openTableId = nil
end

function DragonController:openDragonLotteryView(actId)
	if checknumber(actId) <= 0 then
		FloatWordMgr.instance:show(lang("text_activity_not_on_cozy_tips"))

		return
	end

	UIStateManager.instance:push(ViewName.DragonLottery, actId)
end

function DragonController:clickDragonTaskView(isTips)
	local actId = DragonConfig.instance:getOpenTaskActivityId()

	if checknumber(actId) <= 0 then
		if isTips then
			FloatWordMgr.instance:show(lang("text_activity_not_on_cozy_tips"))
		end

		return 0
	end

	return actId
end

function DragonController:getDrawChangesetId()
	return self._changeSetId
end

function DragonController:getLastDrawItems()
	return self._lastDrawItems
end

function DragonController:getLastDrawQualities()
	return self._lastDrawQuas
end

function DragonController:csGodLotteryGetInfoReq(actId, typeId)
	self.openActType = typeId

	GodLotteryAgent.instance:sendPM_GodLotteryGetInfoReq(actId, typeId)
end

function DragonController:scGodLotteryGetInfo(msg)
	DragonModel.instance:scGodLotteryGetInfo(msg, self.openActType)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataDragonInfo, "All")
end

function DragonController:csGodLotteryDoneReq(actId, typeId, index)
	self.openActType = typeId
	self._changeSetId = nil
	self._lastDrawItems = nil
	self._lastDrawQuas = nil

	GodLotteryAgent.instance:sendPM_GodLotteryDoneReq(actId, typeId, index)
end

function DragonController:scGodLotteryDone(msg)
	if msg == nil or msg.dailyTime == nil then
		return
	end

	local info = DragonModel.instance:getDragonBaseInfo(self.openActType)
	local times = msg.dailyTime

	if info and info.dailyTime > 0 then
		times = msg.dailyTime - info.dailyTime
	end

	DragonModel.instance:scGodLotteryDone(msg, self.openActType)

	local items = MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	for k, mo in pairs(items) do
		if mo.type == MatType.Pet then
			local pet = BagModel.instance:getPet(mo.id)

			if pet.rare == GameEnum.PetRare.SSR then
				ViewAutoShowController.instance:trySetAutoEvaluation(0.25, ViewAutoShowController.TAPTAP_FUNC_2)
			end
		end
	end

	self._changeSetId = msg.changeSetId
	self._lastDrawItems = MaterialController.instance:getTempItemsByChangeSetId(msg.changeSetId)

	local planId = msg.planId
	local itemIds = msg.itemIds

	self._lastDrawQuas = {}

	for i, v in ipairs(itemIds or {}) do
		local tmp = DragonConfig.instance:getDragonPrizeCfgsById(planId, v) or {}
		local matType, id, num = MaterialMgr.getMatParams(tmp.prize)
		local itemCo = MaterialMgr.getMatCfgByStr(tmp.prize)

		if matType == MatType.Equipment then
			table.insert(self._lastDrawQuas, itemCo.qualityBase)
		elseif matType == MatType.Pet then
			local rare = CharacterConfig.instance:getRareByAwakenLv(itemCo.initAwakenLv, itemCo.raceId)

			table.insert(self._lastDrawQuas, rare)
		else
			table.insert(self._lastDrawQuas, itemCo.quality)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataDragonInfo, "Dcj", times)
end

function DragonController:csGodLotteryBuyReq(actId, poolId, index)
	return
end

function DragonController:scGodLotteryBuy(msg)
	return
end

function DragonController:csGodLotteryGetTasksReq(actId, dcType)
	self._tempId = dcType

	GodLotteryTaskAgent.instance:sendPM_GodLotteryGetTasksReq(actId)
end

function DragonController:scGodLotteryGetTasks(msg)
	if msg == nil or msg.taskList == nil or self._tempId == nil then
		return
	end

	DragonModel.instance:scGodLotteryGetTasks(msg.taskList, self._tempId)
	DragonModel.instance:onGetGodLotteryGainLimit(msg.gainLimit, self._tempId)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataDragonInfo, "Trw")

	self._tempId = nil
end

function DragonController:csGodLotteryGainPrizeReq(dcType, actId, typeId, index)
	self._tempId = dcType
	self._typeId = typeId
	self._tempNum = index

	GodLotteryTaskAgent.instance:sendPM_GodLotteryGainPrizeReq(actId, typeId, index)
end

function DragonController:scGodLotteryGainPrize(msg)
	DragonModel.instance:scGodLotteryGainPrize(self._typeId, self._tempNum, self._tempId)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataDragonInfo, "Tlj")

	self._tempId = nil
	self._typeId = nil
	self._tempNum = nil
end

DragonController.instance = DragonController.New()

return DragonController
