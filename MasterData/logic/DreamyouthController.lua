-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/controller/DreamyouthController.lua

module("logic.extensions.dreamyouth.controller.DreamyouthController", package.seeall)

local DreamyouthController = class("DreamyouthController", BaseController)

function DreamyouthController:ctor()
	return
end

function DreamyouthController:onInit()
	self:onReset()
end

function DreamyouthController:onReset()
	return
end

function DreamyouthController:getTaskInfo()
	local activityId = DreamyouthConfig.instance:getActId()

	DreamyouthAgent.instance:sendPM_DreamYouthGetTaskInfosReq(activityId)
end

function DreamyouthController:handleTaskInfo(msg)
	DreamyouthModel.instance:initTaskData(msg)
	self:notify(DreamyouthController.DATA_CHANGE)
end

function DreamyouthController:getStrengthenInfo()
	local activityId = DreamyouthConfig.instance:getActId()

	DreamyouthAgent.instance:sendPM_GetDreamYouthStrengthenInfoReq(activityId)
end

function DreamyouthController:handleStrengthenInfo(msg)
	DreamyouthModel.instance:initStrengthenData(msg)
	self:notify(DreamyouthController.DATA_CHANGE)
end

function DreamyouthController:gainTaskPrize(taskId)
	local activityId = DreamyouthConfig.instance:getActId()

	DreamyouthAgent.instance:sendPM_DreamYouthGainTaskPrizeReq(activityId, taskId)
end

function DreamyouthController:handleGainTaskPrize(msg, idx)
	DreamyouthModel.instance:gainTaskPrize(msg, idx)
	self:notify(DreamyouthController.DATA_CHANGE)
end

function DreamyouthController:showTipNotEnoughCoin()
	local itemCfg = MaterialMgr.getMatCfgByStr(DreamyouthConfig.instance:getCoinItemStr())
	local name = itemCfg.name

	if string.nilorempty(name) then
		name = "代币"
	end

	FloatWordMgr.instance:show(name .. "不足")
end

function DreamyouthController:checkCanGainStrengthen(type)
	if not DreamyouthModel.instance:checkCoinEnoughForStrengthen(type) then
		self:showTipNotEnoughCoin()

		return false
	end

	if DreamyouthModel.instance:checkStrengthenCountTotalMax(type) then
		FloatWordMgr.instance:show("达到总上限")

		return false
	end

	if DreamyouthModel.instance:checkStrengthenCountWeekMax(type) then
		FloatWordMgr.instance:show("达到本周上限")

		return false
	end

	local raceId = checknumber(DreamyouthConfig.instance:getStrengthenCfg()[type].preRaceId)

	if raceId > 0 then
		local name = CharacterConfig.instance:getPetCo(raceId).name
		local myPetNum = BagModel.instance:getRaceIdCount(raceId)

		if myPetNum <= 0 then
			FloatWordMgr.instance:show("需要先获得" .. name)

			return false
		end
	end

	return true
end

function DreamyouthController:strengthenPet(isEnd, value)
	local type = DreamyouthConfig.instance.ST_Pet

	if not self:checkCanGainStrengthen(type) then
		self:_tryStrengthenPet()

		return
	end

	if DreamyouthModel.instance:checkHasGainPet() then
		self:_tryStrengthenPet()

		return
	end

	DreamyouthModel.instance:addUseNum(value)

	if isEnd then
		self:_tryStrengthenPet()

		return
	end
end

function DreamyouthController:_tryStrengthenPet()
	local type = DreamyouthConfig.instance.ST_Pet
	local num = DreamyouthModel.instance:useNum()

	if num >= 1 then
		self:strengthen(type, 0, num)
	end
end

function DreamyouthController:strengthenLevel()
	local type = DreamyouthConfig.instance.ST_Level

	if not self:checkCanGainStrengthen(type) then
		return
	end

	local raceId = checknumber(DreamyouthConfig.instance:getStrengthenCfg()[type].preRaceId)
	local name = CharacterConfig.instance:getPetCo(raceId).name
	local myPetNum = BagModel.instance:getRaceIdCount(raceId)

	if myPetNum == 1 then
		self:_strengthenLevel(BagModel.instance:getPetIdByRaceId(raceId))
	else
		local function onSeletCallBack(petId)
			self:_strengthenLevel(petId)
		end

		local function filterFunc(petMo)
			if petMo.raceId == raceId then
				return true
			end

			return false
		end

		local strTitle = "请选择验证精灵" .. name

		PetSelectController.instance:OpenView(true, strTitle, filterFunc, onSeletCallBack, nil)
	end
end

function DreamyouthController:_strengthenLevel(petId)
	self:strengthen(DreamyouthConfig.instance.ST_Level, petId, 0)
end

function DreamyouthController:strengthenWakeUp()
	local type = DreamyouthConfig.instance.ST_WakeUp

	if not self:checkCanGainStrengthen(type) then
		return
	end

	local raceId = checknumber(DreamyouthConfig.instance:getStrengthenCfg()[type].preRaceId)
	local petId = BagModel.instance:getPetIdByRaceId(raceId)

	self:strengthen(type, petId, 0)
end

function DreamyouthController:strengthen(type, petId, useNum)
	local activityId = DreamyouthConfig.instance:getActId()

	DreamyouthAgent.instance:sendPM_DreamYouthStrengthenReq(activityId, type, petId, useNum)
end

function DreamyouthController:handleStrengthen(msg, strengthenType)
	DreamyouthModel.instance:strengthen(msg, strengthenType)
	self:notify(DreamyouthController.STRENGTHEN, strengthenType)
end

DreamyouthController.DATA_CHANGE = "DreamyouthController_DATA_CHANGE"
DreamyouthController.STRENGTHEN = "DreamyouthController_STRENGTHEN"
DreamyouthController.instance = DreamyouthController.New()

return DreamyouthController
