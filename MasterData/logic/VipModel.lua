-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/model/VipModel.lua

module("logic.extensions.vip.model.VipModel", package.seeall)

local VipModel = class("VipModel", BaseModel)

VipModel.privilegeType_FamilyHoudingClg = 34

function VipModel:ctor()
	return
end

function VipModel:onInit()
	self:onReset()
end

function VipModel:onReset()
	self._curVipLv = 0
	self._curVipExp = 0
	self._curVipLvExpMax = 1
	self._isVipExpMax = false
	self._isDataInit = false
	self._gainDailyBonusState = nil
	self._onceBonusProgress = nil
	self._recordInfo = {}
	self._tryToChangeLv = nil
end

function VipModel:getIsDataInit()
	return self._isDataInit
end

function VipModel:getCurVipLv()
	return self._curVipLv
end

function VipModel:getCurVipExp()
	return self._curVipExp
end

function VipModel:isVip()
	return self._curVipLv > 0
end

function VipModel:getCurVipLvExpMax()
	return self._curVipLvExpMax
end

function VipModel:getIsVipExpMax()
	return self._isVipExpMax
end

function VipModel:getRecordInfo()
	return self._recordInfo
end

function VipModel:tryToChangeDailyBonusStateByLv(lv)
	self._tryToChangeLv = lv
end

function VipModel:getGainDailyBonusStateByLv(lv)
	if not self._gainDailyBonusState then
		return true
	end

	return checkbool(self._gainDailyBonusState[checkint(lv) + 1])
end

function VipModel:getGainBonusStateByLv(lv)
	if not self._onceBonusProgress then
		return 0
	end

	return checkint(self._onceBonusProgress[checkint(lv) + 1])
end

function VipModel:updateVipDataInputExp(inputExp)
	RoleModel.instance:updateVipExp(inputExp)

	self._curVipLv, self._curVipExp, self._curVipLvExpMax, self._isVipExpMax = self:calculateVipLvByExp(inputExp)
end

function VipModel:calculateVipLvByExp(inputExp)
	local exp = checkint(inputExp)
	local lv = 0
	local expMax = 1
	local isVipExpMax = false
	local baseCfgs = VipConfig.instance:getBaseCfgs()

	if not baseCfgs then
		printInfo("get Empty Vip Base Cfg")

		return
	end

	for i = 1, #baseCfgs do
		if baseCfgs[i + 1] then
			if exp >= baseCfgs[i].vipExp and exp < baseCfgs[i + 1].vipExp then
				lv = baseCfgs[i].vipLv
				expMax = baseCfgs[i + 1].vipExp

				break
			end
		elseif exp >= baseCfgs[i].vipExp then
			isVipExpMax = true
			exp = baseCfgs[i].vipExp
			lv = baseCfgs[i].vipLv
			expMax = baseCfgs[i].vipExp
		end
	end

	return lv, exp, expMax, isVipExpMax
end

function VipModel:updateData(msg)
	if msg == nil then
		printError("Get Empty Msg")

		return
	end
end

function VipModel:updateDataGetVipInfo(msg)
	if msg == nil then
		printError("Get Empty Msg")

		return
	end

	self:updateVipDataInputExp(msg.vipExp)

	self._gainDailyBonusState = {}

	for _, s in ipairs(msg.gainDailyBonus) do
		table.insert(self._gainDailyBonusState, checkbool(s))
	end

	self._onceBonusProgress = {}

	for _, p in ipairs(msg.onceBonusProgress) do
		table.insert(self._onceBonusProgress, checkint(p))
	end
end

function VipModel:updateDataGainVipDailyBonus(msg)
	if msg == nil then
		printError("Get Empty Msg")

		return
	end

	self._gainDailyBonusState = self._gainDailyBonusState or {}

	if self._tryToChangeLv then
		self._gainDailyBonusState[self._tryToChangeLv + 1] = true
	end

	self._tryToChangeLv = nil
end

function VipModel:updateDataGainVipBonus(msg)
	if msg == nil then
		printError("Get Empty Msg")

		return
	end

	local gainLv = checkint(msg.vipLevel)
	local newProgress = checkint(msg.onceBonusProgress)

	self._onceBonusProgress = self._onceBonusProgress or {}
	self._onceBonusProgress[gainLv + 1] = checkint(newProgress)
end

function VipModel:updateDataVipExpDailyChange(msg)
	if msg == nil then
		printError("Get Empty Msg")

		return
	end

	self:updateVipDataInputExp(msg.vipExp)
end

function VipModel:updateDataVipExpRecord(msg)
	if msg == nil then
		printError("Get Empty Msg")

		return
	end

	self._recordInfo = {}

	for _, info in ipairs(msg.recordInfos) do
		table.insert(self._recordInfo, info)
	end
end

function VipModel:dailyResetData()
	self._gainDailyBonusState = self._gainDailyBonusState or {}

	for k, v in pairs(self._gainDailyBonusState) do
		v = false
	end
end

function VipModel:getVipPrivilegeParm(type, isDefault, vipLv)
	local _vipLv = vipLv or self:getCurVipLv()
	local vipParmsCfgs = VipConfig.instance:getPrivilegeCfgsByLv((isDefault or nil) and 0)

	if vipParmsCfgs and vipParmsCfgs[type] then
		return vipParmsCfgs[type].params
	else
		print("nil Vip Privilege")
	end
end

function VipModel:getAvaiablePrivilegeVipLevel(type)
	local vipLevel = 0

	while true do
		local vipParmsCfgs = VipConfig.instance:getPrivilegeCfgsByLv(vipLevel)

		if not vipParmsCfgs then
			break
		end

		if checknumber(vipParmsCfgs[type].params) ~= 0 then
			return vipLevel
		end

		vipLevel = vipLevel + 1
	end

	return -1
end

function VipModel:getAbleToBuyTimesOfExpCopy(isDefault)
	local parm

	return parm and checkint(parm) or 9999
end

function VipModel:getAbleToBuyTimesOfCoinCopy(isDefault)
	local parm

	return parm and checkint(parm) or 9999
end

function VipModel:getAbleToBuyTimesOfEquipCopy(isDefault)
	local parm

	return parm and checkint(parm) or 9999
end

function VipModel:getAbleToBuyTimesOfStarCopy(isDefault)
	local parm

	return parm and checkint(parm) or 9999
end

function VipModel:getAbleToBuyTimesOfArena(isDefault)
	local parm = self:getVipPrivilegeParm(1, isDefault)

	return parm and checkint(parm) or 1
end

function VipModel:getFreeGetTimesOfEnergy(isDefault)
	local parm = self:getVipPrivilegeParm(2, isDefault)

	return parm and checkint(parm) or 1
end

function VipModel:getFreeGetTimesOfBreakFormation(isDefault)
	local parm = self:getVipPrivilegeParm(3, isDefault)

	return parm and checkint(parm) or 10
end

function VipModel:getPlayerIsAbleToPlayAction(isDefault)
	local parm = self:getVipPrivilegeParm(4, isDefault)

	return parm and checkbool(parm == 1) or false
end

function VipModel:getDispatchMissionGetRate(isDefault)
	local parm = self:getVipPrivilegeParm(5, isDefault)

	return parm and checkint(parm) or 10000
end

function VipModel:getFreeTimesOfMaterialCopy(isDefault, id)
	local parm

	return parm and checkint(parm) or 3
end

function VipModel:getIsAbleToChatWithVipFrame(isDefault, vipLevel)
	local parm = self:getVipPrivilegeParm(6, isDefault, vipLevel)

	return parm or 0
end

function VipModel:getFreeSweepTimesOfWarriorTower(isDefault)
	local parm = self:getVipPrivilegeParm(7, isDefault)

	return parm and checkint(parm) or 1
end

function VipModel:getOnHookGainRateOfWarriorTower(isDefault)
	local parm = self:getVipPrivilegeParm(8, isDefault)

	return parm and checkint(parm) or 10000
end

function VipModel:getFreeTimesOfChatOnWorld(isDefault)
	local parm = self:getVipPrivilegeParm(9, isDefault)

	return parm and checkint(parm) or 0
end

function VipModel:getFreeChallengeTimesOfFamilyBoss(isDefault)
	local parm = self:getVipPrivilegeParm(10, isDefault)

	return parm and checkint(parm) or 2
end

function VipModel:getFreeChallengeTimesOfPet(isDefault)
	local parm = self:getVipPrivilegeParm(11, isDefault)

	return parm and checkint(parm) or 5
end

function VipModel:getTimesOfSkipBattle(isDefault)
	local parm = self:getVipPrivilegeParm(12, isDefault)

	return parm and checkint(parm) or 0
end

function VipModel:getIsAbleToSkippedBattle(isDefault)
	local parm = self:getVipPrivilegeParm(12, isDefault)

	return parm and checkbool(parm > 0) or false
end

function VipModel:getNextSkipBattleTime(currTime)
	local time = currTime or self:getTimesOfSkipBattle()
	local currLv = self:getCurVipLv()
	local vipType = 12
	local nextTime = 0

	while true do
		currLv = currLv + 1

		local vipParmsCfgs = VipConfig.instance:getPrivilegeCfgsByLv(currLv)

		if vipParmsCfgs then
			nextTime = checkint(vipParmsCfgs[vipType].params)

			if nextTime ~= 0 and nextTime < time then
				return currLv, nextTime
			end
		else
			break
		end
	end
end

function VipModel:getAbleToSkippedBattleVipLevel()
	return self:getAvaiablePrivilegeVipLevel(12)
end

function VipModel:getBuyChallengeTimesOfWarriorTower(isDefault)
	local parm = self:getVipPrivilegeParm(13, isDefault)

	return parm and checkint(parm) or 2
end

function VipModel:getTimesWithoutEnergyOfExpCopy(isDefault)
	local parm = self:getVipPrivilegeParm(14, isDefault)

	return parm and checkint(parm) or 0
end

function VipModel:getTimesWithoutEnergyOfCoinCopy(isDefault)
	local parm = self:getVipPrivilegeParm(15, isDefault)

	return parm and checkint(parm) or 0
end

function VipModel:getTimesWithoutEnergyOfEquipCopy(isDefault)
	local parm = self:getVipPrivilegeParm(16, isDefault)

	return parm and checkint(parm) or 0
end

function VipModel:getTimesWithoutEnergyOfStarCopy(isDefault)
	local parm = self:getVipPrivilegeParm(17, isDefault)

	return parm and checkint(parm) or 0
end

function VipModel:getTimesDoubleGainOfExpCopy(isDefault)
	local parm

	return parm and checkint(parm) or 0
end

function VipModel:getTimesDoubleGainOfCoinCopy(isDefault)
	local parm

	return parm and checkint(parm) or 0
end

function VipModel:getTimesDoubleGainOfEquipCopy(isDefault)
	local parm

	return parm and checkint(parm) or 0
end

function VipModel:getTimesDoubleGainOfStarCopy(isDefault)
	local parm

	return parm and checkint(parm) or 0
end

function VipModel:getIsAbleToOneKeyToTouchPig(isDefault)
	local parm = self:getVipPrivilegeParm(18, isDefault)

	return parm and checkbool(parm == 1) or false
end

function VipModel:getIsAbleToPassportDiscount(isDefault)
	local parm = self:getVipPrivilegeParm(19, isDefault)

	return parm and checkbool(parm == 1) or false
end

function VipModel:getIsAbleToVipDiscount(isDefault)
	local parm = self:getVipPrivilegeParm(20, isDefault)

	return parm and checkbool(parm == 1) or false
end

function VipModel:getIsAbleToOneKeyDispatch(isDefault)
	local parm

	return parm and checkbool(parm == 1) or false
end

function VipModel:getIsAbleToUseVipMeme(isDefault)
	local parm = self:getVipPrivilegeParm(21, isDefault)

	return parm and checkint(parm) or 0
end

function VipModel:getIsAbleToUseVipNameBoard(isDefault, vipLv)
	local parm = self:getVipPrivilegeParm(22, isDefault, vipLv)

	return parm and checkbool(parm == 1) or false
end

function VipModel:getMoneyCat(isDefault, vipLv)
	local parm = self:getVipPrivilegeParm(23, isDefault, vipLv)

	return parm or 1
end

function VipModel:getIsAbleToSearchPetDirect(isDefault, vipLv)
	local parm = self:getVipPrivilegeParm(25, isDefault, vipLv)

	return parm and checkbool(parm == 1) or false
end

function VipModel:getIsAbleVipHatch(isDefault, vipLv)
	local parm = self:getVipPrivilegeParm(26, isDefault, vipLv)

	return parm and checkbool(parm >= 3) or false
end

function VipModel:getTimesOfChangeGender(isDefault, vipLv)
	local parm = self:getVipPrivilegeParm(27, isDefault, vipLv)

	return parm and checkint(parm) or 1
end

function VipModel:getPigTouchDailyCount(isDefault, vipLv)
	local parm = self:getVipPrivilegeParm(28, isDefault, vipLv)

	return parm and checkint(parm) or 5
end

function VipModel:getFreeTimesOfChatOnAll(isDefault)
	local parm = self:getVipPrivilegeParm(33, isDefault)

	return parm and checkint(parm) or 0
end

function VipModel:getPetSkinRenanePrivilege(isDefault)
	local parm = self:getVipPrivilegeParm(35, isDefault)

	return checkint(parm) > 0
end

VipModel.instance = VipModel.New()

return VipModel
