-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/model/SixartdaoguanModel.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanModel", package.seeall)

local SixartdaoguanModel = class("SixartdaoguanModel", BaseModel)

function SixartdaoguanModel:ctor()
	return
end

function SixartdaoguanModel:onInit()
	self:onReset()
end

function SixartdaoguanModel:onReset()
	self._msgInfos = {}
	self._fmtMos = {}
	self._battleResultMsg = nil
	self._rentPetMos = {}
end

function SixartdaoguanModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function SixartdaoguanModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function SixartdaoguanModel:getChallengeInfo(activityId, challengeId)
	local info = self:getInfo(activityId)

	if not info then
		return nil
	end

	for i, v in ipairs(info.challenges) do
		if v.challengeId == challengeId then
			return v
		end
	end
end

function SixartdaoguanModel:getFmtMo(challengeId)
	local fmtMo = self._fmtMos[challengeId]

	if not fmtMo then
		fmtMo = SixartdaoguanFmtMo.New()
		self._fmtMos[challengeId] = fmtMo
	end

	return fmtMo
end

function SixartdaoguanModel:updateFightResultRes(msg)
	self._battleResultMsg = msg

	local tab = GameUtil.pbToTable(msg)

	if msg.win then
		local info = self:getInfo(msg.activityId)

		for i, v in ipairs(info.challenges) do
			if v.challengeId == msg.challengeId then
				v.stageIdPassed = msg.stageId

				if v.challengeId == SixartdaoguanController.ChallengeType.Defense then
					v.dropBuffInfo = v.dropBuffInfo or GameUtil.pbToTable(SixArtDaoguanExtension_pb.PM_SixArtDaoguanDropBuffInfo())
					v.dropBuffInfo.selectingDropBuff = tab.selectingDropBuff
					v.dropBuffInfo.reRandomCount = 0
				end
			end
		end
	end
end

function SixartdaoguanModel:getBattleResultMsg()
	return self._battleResultMsg
end

function SixartdaoguanModel:clearBattleResultMsg()
	self._battleResultMsg = nil
end

function SixartdaoguanModel:onBuyRentPetRes(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		info.rentPetId = info.rentPetId or {}

		table.insert(info.rentPetId, msg.rentPetId)
	end
end

function SixartdaoguanModel:getRentPetMos(activityId)
	local info = self:getInfo(activityId)

	if not info or not info.rentPetId then
		return nil
	end

	for i, v in ipairs(info.rentPetId) do
		self:getRentPetMo(activityId, v)
	end

	return self._rentPetMos[activityId]
end

function SixartdaoguanModel:getRentPetMosByIds(activityId)
	local info = self:getInfo(activityId)

	if not info or not info.rentPetId then
		return nil
	end

	local mos = {}

	for i, v in ipairs(info.rentPetId) do
		local mo = self:getRentPetMo(activityId, v)

		table.insert(mos, mo)
	end

	return mos
end

function SixartdaoguanModel:getRentPetMo(activityId, creepsId)
	self._rentPetMos[activityId] = self._rentPetMos[activityId] or {}
	self._rentPetMos[activityId][creepsId] = self._rentPetMos[activityId][creepsId] or self:_creatRentPetMo(activityId, creepsId)
	self._rentPetMos[activityId][creepsId].isSupportedPet = true
	self._rentPetMos[activityId][creepsId].isMyPackPet = false

	return self._rentPetMos[activityId][creepsId]
end

function SixartdaoguanModel:_creatRentPetMo(activityId, creepsId)
	local rentCfg = SixartdaoguanConfig.instance:getRentPetCfg(activityId, creepsId)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(rentCfg)

	return fPowerPet:toBaseBagPetMo()
end

function SixartdaoguanModel:onSelectDropBuffRes(msg)
	local tab = GameUtil.pbToTable(msg)
	local info = self:getInfo(tab.activityId)

	for i, v in ipairs(info.challenges) do
		if v.challengeId == tab.challengeId then
			v.dropBuffInfo = tab.dropBuffInfo

			break
		end
	end
end

function SixartdaoguanModel:onReShuffleDropBuffRes(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		for i, v in ipairs(info.challenges) do
			if v.challengeId == msg.challengeId then
				v.dropBuffInfo = GameUtil.pbToTable(msg.dropBuffInfo)

				break
			end
		end
	end
end

SixartdaoguanModel.instance = SixartdaoguanModel.New()

return SixartdaoguanModel
