-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/model/ShareTaskModel.lua

module("logic.extensions.sharetask.model.ShareTaskModel", package.seeall)

local ShareTaskModel = class("ShareTaskModel", BaseModel)

function ShareTaskModel:ctor()
	self.baseInfo = nil
	self.bossInfo = nil
	self.otherBossInfo = nil
	self.bossAssistList = nil
	self.battleInfo = nil
	self.isTriggerBoss = false
end

function ShareTaskModel:onInit()
	ShareTaskModel.super.onInit(self)
	self:onReset()
end

function ShareTaskModel:onReset()
	self.baseInfo = nil
	self.bossInfo = nil
	self.otherBossInfo = nil
	self.bossAssistList = nil
	self.battleInfo = nil
	self.isTriggerBoss = false
end

function ShareTaskModel:GetShareTaskBaseInfo(isReset)
	if self.baseInfo == nil or isReset then
		local commonCfg = ShareTaskConfig.instance:GetCommonCfgs()

		self.baseInfo = {}
		self.baseInfo.trigHave = math.floor(commonCfg.maxChallengeCount / commonCfg.oneBossChallCount)

		local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.ShareTaskCount)
		local mul = 1

		if isInTime and cfg and checknumber(cfg.featureParam) > 0 then
			mul = checknumber(cfg.featureParam)
		end

		local newhandDoubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

		mul = mul + newhandDoubleValue
		self.baseInfo.trigHave = self.baseInfo.trigHave * checknumber(mul)
		self.baseInfo.trigUse = 0
		self.baseInfo.challHave = commonCfg.maxChallengeCount
		self.baseInfo.bossChallHave = commonCfg.oneBossChallCount
		self.baseInfo.helpHave = commonCfg.maxHelpCount
		self.baseInfo.helpUse = 0
		self.baseInfo.freeHelpHave = commonCfg.maxFreehelpCount
		self.baseInfo.freeHelpUse = 0
		self.baseInfo.bossMaxLv = 0
		self.baseInfo.challBossIds = {}
	end

	return self.baseInfo
end

function ShareTaskModel:InitShareTaskBaseInfo(data)
	self:GetShareTaskBaseInfo(true)

	if checknumber(data.challengeTimes) > 0 then
		self.baseInfo.trigUse = data.challengeTimes
	end

	if checknumber(data.helpTimes) > 0 then
		self.baseInfo.helpUse = data.helpTimes
	end

	if checknumber(data.freeHelpTimes) > 0 then
		self.baseInfo.freeHelpUse = data.freeHelpTimes
	end

	if checknumber(data.historyLevel) > 0 then
		self.baseInfo.bossMaxLv = data.historyLevel
	end

	if data.challengedBossIds then
		self.baseInfo.challBossIds = data.challengedBossIds
	end
end

function ShareTaskModel:GetMyShareBossInfo()
	if self.bossInfo == nil then
		return {}
	end

	self.bossInfo.isHaveBoss = false
	self.bossInfo.isKillBoss = false
	self.bossInfo.isFleeBoss = false
	self.bossInfo.isMaxChall = false

	if checknumber(self.bossInfo.bossId) < 1 then
		return self.bossInfo
	end

	self.bossInfo.isHaveBoss = true

	if self.bossInfo.curHp <= 0 then
		self.bossInfo.isKillBoss = true
	else
		local allTime = ShareTaskConfig.instance:GetBossShowTime()
		local supTime = self.bossInfo.startTime / 1000 + allTime - checknumber(ServerTime.now())

		if supTime <= 0 then
			self.bossInfo.isFleeBoss = true
		end
	end

	local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(self.bossInfo.bossTypeId)

	if bossCfg and checknumber(bossCfg.memberLimit) > 0 then
		local have = self.bossInfo.challCount

		if self.bossInfo.partnerList and have < #self.bossInfo.partnerList then
			have = #self.bossInfo.partnerList
		end

		if have >= bossCfg.memberLimit then
			self.bossInfo.isMaxChall = true
		end
	end

	return self.bossInfo
end

function ShareTaskModel:SetTriggerBossInfo(data)
	if data == nil then
		self.bossInfo = nil

		self:UpdataTriggerBossInfo()

		return
	end

	self.bossInfo = self.bossInfo or {}
	self.bossInfo.isChallenged = data.hadChallenged
	self.bossInfo.isFindReward = data.hadGainReward
	self.bossInfo.bossChallUse = checknumber(data.challengeTimes)

	self:UpdataTriggerBossInfo(data.simpleInfo, data.participant)
	self:OnCreateAndRemoveNpc()
end

function ShareTaskModel:UpdataTriggerBossInfo(simpleInfo, participant)
	if simpleInfo then
		self.bossInfo.bossId = checknumber(simpleInfo.bossId)
		self.bossInfo.bossTypeId = simpleInfo.bossTypeId
		self.bossInfo.bossLevel = simpleInfo.bossLevel
		self.bossInfo.userId = simpleInfo.userId
		self.bossInfo.startTime = simpleInfo.startTime
		self.bossInfo.curHp = simpleInfo.curHp
		self.bossInfo.maxHp = simpleInfo.maxHp
		self.bossInfo.challCount = simpleInfo.challengeMember
	end

	if participant then
		self.bossInfo.partnerList = participant

		if self.bossInfo.partnerList and #self.bossInfo.partnerList > 1 then
			table.sort(self.bossInfo.partnerList, function(a, b)
				return a.causeDamage > b.causeDamage
			end)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataShareTaskBossInfo)
end

function ShareTaskModel:ResetTriggerBossBase()
	self.bossInfo = {}
	self.bossInfo.isChallenged = false
	self.bossInfo.isFindReward = false
	self.bossInfo.curHp = 0
	self.bossInfo.bossChallUse = 0

	if self.baseInfo == nil then
		self:GetShareTaskBaseInfo()
	end
end

function ShareTaskModel:SetChallengedBossInfo(result)
	self.bossInfo = self.bossInfo or {}
	self.bossInfo.curHp = result.curBossHp
	self.bossInfo.isChallenged = true

	if result.participant and #result.participant > 0 then
		self.bossInfo.challCount = #result.participant
	end

	if checknumber(self.bossInfo.bossChallUse) <= 0 then
		self.baseInfo.trigUse = self.baseInfo.trigUse + 1
	end

	self.bossInfo.bossChallUse = self.bossInfo.bossChallUse + 1

	self:UpdataTriggerBossInfo(nil, result.participant)
end

function ShareTaskModel:UpdataHelpChallBossIds(bossId, isFree)
	if self.baseInfo == nil then
		self:GetShareTaskBaseInfo()
	end

	if isFree then
		self.baseInfo.freeHelpUse = self.baseInfo.freeHelpUse + 1
	else
		self.baseInfo.helpUse = self.baseInfo.helpUse + 1
	end

	for _, id in pairs(self.baseInfo.challBossIds) do
		if checknumber(id) == bossId then
			return
		end
	end

	table.insert(self.baseInfo.challBossIds, bossId)
end

function ShareTaskModel:OnCreateAndRemoveNpc(isForceRem)
	if self.bossInfo == nil or checknumber(self.bossInfo.bossTypeId) < 1 then
		return
	end

	local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(self.bossInfo.bossTypeId)

	if bossCfg == nil or checknumber(bossCfg.npcId) < 1 then
		return
	end

	if isForceRem or self.bossInfo.isChallenged then
		SceneNpcsMgr.instance:removeNpc(bossCfg.npcId)
	else
		SceneNpcsMgr.instance:createNpc(bossCfg.npcId)
	end
end

function ShareTaskModel:GetFriendIsHelpMyBoss(id)
	if checknumber(id) <= 0 then
		return
	end

	if self.bossInfo == nil or self.bossInfo.partnerList == nil then
		return false
	end

	for _, info in pairs(self.bossInfo.partnerList) do
		if info and info.userId == id then
			return true
		end
	end

	return false
end

function ShareTaskModel:UpdataFindRewardStage()
	self.bossInfo.isFindReward = true
end

function ShareTaskModel:GotoNpcCrossScene()
	local info = self:GetMyShareBossInfo()

	if info == nil or not info.isHaveBoss or info.isFleeBoss or info.isKillBoss then
		return
	end

	if info.isChallenged then
		return
	end

	local cfg = ShareTaskConfig.instance:GetBossBaseCfg(info.bossTypeId)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if cfg and mainPlayer then
		TaskController.instance:foreceClearState()
		mainPlayer:gotoNpcCrossScene(cfg.npcId)
	end
end

function ShareTaskModel:UpdataBossAssistList(data)
	self.bossAssistList = nil

	if data == nil or #data == 0 then
		return
	end

	self.bossAssistList = {}

	for i = 1, #data do
		local pb = data[i]

		if pb and pb.headInfo and pb.simpleInfo then
			table.insert(self.bossAssistList, {
				headInfo = pb.headInfo,
				userId = pb.headInfo.userId,
				userName = pb.headInfo.userName,
				userLevel = pb.headInfo.playerLv,
				everMaxZdl = data[i].everMaxZdl,
				bossId = checknumber(data[i].simpleInfo.bossId),
				bossTypeId = data[i].simpleInfo.bossTypeId,
				bossLevel = data[i].simpleInfo.bossLevel,
				startTime = data[i].simpleInfo.startTime,
				curHp = data[i].simpleInfo.curHp,
				maxHp = data[i].simpleInfo.maxHp,
				challTiems = data[i].simpleInfo.challengeMember
			})
		end
	end

	if #self.bossAssistList > 1 then
		table.sort(self.bossAssistList, function(a, b)
			if a.startTime == b.startTime then
				return a.bossLevel < b.bossLevel
			end

			return a.startTime < b.startTime
		end)
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataShareTaskBossAssistList)
end

function ShareTaskModel:GetBossAssistList()
	if self.bossAssistList and #self.bossAssistList > 0 then
		local allTime = ShareTaskConfig.instance:GetBossShowTime()
		local nowTime = checknumber(ServerTime.now())
		local tempList = {}

		for i = 1, #self.bossAssistList do
			if self.bossAssistList[i] and nowTime < self.bossAssistList[i].startTime / 1000 + allTime then
				table.insert(tempList, self.bossAssistList[i])
			end
		end

		return tempList
	end

	return self.bossAssistList
end

function ShareTaskModel:UpdataOtherBossList(simpleInfo, participant)
	self.otherBossInfo = self.otherBossInfo or {}

	if simpleInfo then
		self.otherBossInfo.bossId = checknumber(simpleInfo.bossId)
		self.otherBossInfo.bossTypeId = simpleInfo.bossTypeId
		self.otherBossInfo.bossLevel = simpleInfo.bossLevel
		self.otherBossInfo.userId = simpleInfo.userId
		self.otherBossInfo.startTime = simpleInfo.startTime
		self.otherBossInfo.curHp = simpleInfo.curHp
		self.otherBossInfo.maxHp = simpleInfo.maxHp
		self.otherBossInfo.challCount = simpleInfo.challengeMember
	end

	if participant then
		self.otherBossInfo.partnerList = participant

		if self.otherBossInfo.partnerList and #self.otherBossInfo.partnerList > 1 then
			table.sort(self.otherBossInfo.partnerList, function(a, b)
				return a.causeDamage > b.causeDamage
			end)
		end
	end
end

function ShareTaskModel:SetShareListOtherBossInfo(data)
	self.otherBossInfo = {}
	self.otherBossInfo.bossId = checknumber(data.bossId)
	self.otherBossInfo.bossTypeId = data.bossTypeId
	self.otherBossInfo.bossLevel = data.bossLevel
	self.otherBossInfo.userId = data.userId
	self.otherBossInfo.startTime = data.startTime
	self.otherBossInfo.curHp = data.curHp
	self.otherBossInfo.maxHp = data.maxHp
	self.otherBossInfo.challCount = data.challTiems
end

function ShareTaskModel:SetChallengedOtherBossInfo(result)
	self.otherBossInfo = self.otherBossInfo or {}
	self.otherBossInfo.curHp = result.curBossHp

	if result.participant and #result.participant > 0 then
		self.otherBossInfo.challCount = #result.participant
	end

	self:UpdataOtherBossList(nil, result.participant)
end

function ShareTaskModel:GetOtherShareBossInfo()
	if self.otherBossInfo == nil then
		return {}
	end

	self.otherBossInfo.isHaveBoss = false
	self.otherBossInfo.isKillBoss = false
	self.otherBossInfo.isFleeBoss = false
	self.otherBossInfo.isMaxChall = false

	if checknumber(self.otherBossInfo.bossId) < 1 then
		return self.otherBossInfo
	end

	self.otherBossInfo.isHaveBoss = true

	if self.otherBossInfo.curHp <= 0 then
		self.otherBossInfo.isKillBoss = true
	else
		local allTime = ShareTaskConfig.instance:GetBossShowTime()
		local supTime = self.otherBossInfo.startTime / 1000 + allTime - checknumber(ServerTime.now())

		if supTime <= 0 then
			self.otherBossInfo.isFleeBoss = true
		end
	end

	local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(self.otherBossInfo.bossTypeId)

	if bossCfg and checknumber(bossCfg.memberLimit) > 0 then
		local have = self.otherBossInfo.challCount

		if self.otherBossInfo.partnerList and have < #self.otherBossInfo.partnerList then
			have = #self.otherBossInfo.partnerList
		end

		if have >= bossCfg.memberLimit then
			self.otherBossInfo.isMaxChall = true
		end
	end

	return self.otherBossInfo
end

function ShareTaskModel:GetBattleUseAndTotalCount(isMyBoss)
	local use = 0
	local typeId = 0

	if isMyBoss then
		if self.bossInfo then
			if checknumber(self.bossInfo.challCount) > 0 then
				use = self.bossInfo.challCount
			end

			if checknumber(self.bossInfo.bossTypeId) > 0 then
				typeId = self.bossInfo.bossTypeId
			end
		end
	elseif self.otherBossInfo then
		if checknumber(self.otherBossInfo.challCount) > 0 then
			use = self.otherBossInfo.challCount
		end

		if checknumber(self.otherBossInfo.bossTypeId) > 0 then
			typeId = self.otherBossInfo.bossTypeId
		end
	end

	local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(typeId)

	if bossCfg == nil or checknumber(bossCfg.memberLimit) <= 0 then
		return use, use
	end

	return use, bossCfg.memberLimit
end

function ShareTaskModel:IsHelpFriendChallBossId(bossId)
	if self.baseInfo == nil or self.baseInfo.challBossIds == nil then
		return false
	end

	for _, id in pairs(self.baseInfo.challBossIds) do
		if checknumber(id) == bossId then
			return true
		end
	end

	return false
end

function ShareTaskModel:GetShareBossPower(typeId)
	local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(typeId)

	if bossCfg == nil or checknumber(bossCfg.creepsMasterId) < 1 then
		return 0
	end

	local enemyCfgs = ShareTaskConfig.instance:GetBossTeamPosCfgs(bossCfg.creepsMasterId)

	if enemyCfgs == nil then
		return 1
	end

	local power = 0

	for _, item in pairs(enemyCfgs) do
		if not string.nilorempty(item.extproperties) then
			local attrs = FightingPowerFormula.instance:parseAttrValues(item.extproperties) or {}

			power = power + AttrMo.calcFightPowerByAttrs(attrs)
		end
	end

	return power
end

function ShareTaskModel:IsOpenSharePopupView()
	local openId = ShareTaskConfig.instance:GetFuncOpenId()

	if not FuncOpenModel.instance:getFuncIsOpen(openId) then
		return false
	end

	if self.bossInfo == nil or checknumber(self.bossInfo.bossId) < 1 or self.bossInfo.isChallenged then
		return false
	end

	if self.baseInfo == nil or self.baseInfo.trigUse <= 0 or self.bossInfo.bossChallUse >= self.baseInfo.bossChallHave then
		return false
	end

	local allTime = ShareTaskConfig.instance:GetBossShowTime()

	if self.bossInfo.startTime / 1000 + allTime < checknumber(ServerTime.now()) then
		return false
	end

	return true
end

function ShareTaskModel:SetBattleBossInfo(data)
	self.battleInfo = data
end

function ShareTaskModel:GetBattleBossInfo()
	return self.battleInfo
end

function ShareTaskModel:GetBattleBossMVP()
	local info = self:GetMyShareBossInfo()

	if not info.isHaveBoss then
		return 0
	end

	if info.isFleeBoss then
		return 2
	end

	if not info.isKillBoss then
		return 0
	end

	if info.partnerList == nil or #info.partnerList == 0 then
		return 0
	end

	local ownId = RoleModel.instance:getUserId()
	local data = info.partnerList[1]

	if data == nil or data.headInfo == nil or data.headInfo.userId ~= ownId then
		return 0
	end

	return 1
end

function ShareTaskModel:GetMyBossChallengeStage()
	if self.bossInfo == nil or checknumber(self.bossInfo.bossId) < 1 then
		return -1
	end

	if self.bossInfo.curHp <= 0 then
		return 0
	end

	local allTime = ShareTaskConfig.instance:GetBossShowTime()
	local supTime = self.bossInfo.startTime / 1000 + allTime - checknumber(ServerTime.now())

	if supTime <= 0 then
		return 2
	elseif self.bossInfo.isChallenged then
		return 1
	end

	return -1
end

function ShareTaskModel:IsShowShareBossMianViewEntrance()
	local info = self:GetMyShareBossInfo()

	if info == nil then
		return false
	end

	if not info.isHaveBoss or info.isFleeBoss or info.isKillBoss then
		return false
	end

	return not info.isChallenged
end

function ShareTaskModel:GetShareBossRed()
	local info = self:GetMyShareBossInfo()

	if info == nil then
		return false
	end

	if not info.isHaveBoss or info.isFleeBoss or info.isKillBoss then
		return false
	end

	return true
end

function ShareTaskModel:GetShareBossFindRewardRed()
	local info = self:GetMyShareBossInfo()

	if info == nil then
		return false
	end

	if not info.isChallenged then
		return false
	end

	if not info.isHaveBoss or info.isFleeBoss or info.isKillBoss then
		return false
	end

	return not info.isFindReward
end

function ShareTaskModel:ParsingGoodsStr(goodsStr)
	if string.nilorempty(goodsStr) then
		return
	end

	local itemTb = string.split(goodsStr, "#")

	if itemTb == nil or #itemTb == 0 then
		return
	end

	local itemList = {}

	for i = 1, #itemTb do
		if not string.nilorempty(itemTb[i]) then
			local item = string.split(itemTb[i], ":")

			if item and #item > 2 then
				table.insert(itemList, {
					itemType = checknumber(item[1]),
					itemId = checknumber(item[2]),
					count = checknumber(item[3])
				})
			end
		end
	end

	return itemList
end

function ShareTaskModel:getOriginalCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function ShareTaskModel:_getCurFormation()
	return PetHireModel.instance:getFormationMoByFormId(PetHireModel.ID_TYPE_NORMAL)
end

function ShareTaskModel:getAllShowPetList()
	local pets = BagPetsController.instance:getBagPets() or {}

	pets = PetHireModel.instance:appendListByHirePets(pets)

	return pets
end

ShareTaskModel.instance = ShareTaskModel.New()

return ShareTaskModel
