-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/mo/TRMyPlayerMo.lua

module("logic.extensions.treasureraider.model.mo.TRMyPlayerMo", package.seeall)

local TRMyPlayerMo = class("TRMyPlayerMo", TRPlayerMo)

function TRMyPlayerMo:ctor()
	TRMyPlayerMo.super.ctor(self)

	self.isGhost = false
	self.isRevenge = false
	self.serverGridId = 1
	self.clientGridId = 1
	self.pathIndex = 1
	self.movePathList = {}
	self._fixDiceCountRemain = 0
	self._fixDiceCountMax = 0
	self._attackNumToday = 0
	self._attackTotalNum = 0
	self._attackNumTodayMax = 0
	self._editCountRemain = 0
	self._editCountMax = 0
	self._revengeNumToday = 0
	self._revengeNumTodayMax = 0
	self._attackRandomDiceCountRemain = 0
	self._attackRandomDiceCountMax = 0
	self._attackForm = nil
	self._attackPrize = nil
	self._attackChangeSetId = nil
	self._defendNews = 0
	self._extendBuffMap = {}
end

function TRMyPlayerMo:updateByServerData(params)
	self:updateMainCampData(params)

	self._attackNumTodayMax = TreasureRaiderConfig.instance:getCommonValue("DailyAttack", true)
	self._revengeNumTodayMax = TreasureRaiderConfig.instance:getCommonValue("DailyRevenge", true)
	self.userName = RoleModel.instance:getUserName()
	self.userId = LoginModel.instance.userId
	self.playerInfo = {
		userId = LoginModel.instance.userId,
		userName = RoleModel.instance:getUserName(),
		headIconId = RoleModel.instance:getHeadIconId(),
		headFrameId = RoleModel.instance:getHeadFrameId(),
		gender = RoleModel.instance:getGender()
	}

	local configInstance = TreasureRaiderConfig.instance
	local mapPlanId = configInstance:getMapPlanId()
	local config = configInstance:getPathConfig(mapPlanId)

	self.movePathList = config.movePathGridIds
	self.serverGridId = params.step
	self.clientGridId = self.serverGridId
	self.pathIndex = table.indexof(self.movePathList, params.step)
	self._fixDiceCountRemain = params.fixRollLast
	self._fixDiceCountMax = params.fixRollMax
	self._attackNumToday = params.attackNumToday
	self._attackTotalNum = params.attackTotalNum
	self._editCountRemain = params.mapEditLast
	self._editCountMax = params.mapEditMax
	self._revengeNumToday = params.revengeNumToday

	self:setDefendNewNum(params.defendNews)

	self._attackForm = params.form

	self:updateBuff(params.extendBuff)
end

function TRMyPlayerMo:updateBeforeUpdateOpMapGetInfo(isRevenge)
	if isRevenge then
		self._revengeNumToday = self._revengeNumToday + 1
	else
		self._attackTotalNum = math.max(checknumber(self._attackTotalNum) - 1, 0)
		self._attackNumToday = checknumber(self._attackNumToday) + 1
	end
end

function TRMyPlayerMo:updateBuff(extendBuff)
	self._extendBuffMap = {}

	if not string.nilorempty(extendBuff) then
		local array = string.split(extendBuff, ",")

		for _, v in ipairs(array) do
			local group = string.split(v, ":")

			self._extendBuffMap[group[1]] = checknumber(group[2])
		end
	end
end

function TRMyPlayerMo:updateServerDataAfterMySceneWalk(params)
	self:updateMainCampData(params)

	self.serverGridId = params.step
	self.pathIndex = table.indexof(self.movePathList, params.step)
	self._fixDiceCountRemain = params.fixRollLast
	self._fixDiceCountMax = params.fixRollMax
	self._attackTotalNum = params.attackTotalNum

	if not params.trigger then
		for _, triggerType in ipairs(params.trigger) do
			if triggerType == TreasureRaiderConst.TriggerType_AttackAwardAddition then
				self._extendBuffMap[TreasureRaiderConst.BuffType_AttackPercent] = (self._extendBuffMap[TreasureRaiderConst.BuffType_AttackPercent] or 0) + TreasureRaiderConfig.instance:getCommonValue("AttackAwardAddition", true)
			elseif triggerType == TreasureRaiderConst.TriggerType_NextUpgrade then
				self._extendBuffMap[TreasureRaiderConst.BuffType_UpgradePercent] = (self._extendBuffMap[TreasureRaiderConst.BuffType_UpgradePercent] or 0) + TreasureRaiderConfig.instance:getCommonValue("NextUpgrade", true)
			elseif triggerType == TreasureRaiderConst.TriggerType_AddMapEdit then
				self._editCountRemain = math.min(self._editCountRemain + TreasureRaiderConfig.instance:getCommonValue("AddMapEdit", true), self._editCountMax)
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderPlayerServerGridUpdated, self.userId)
	end
end

function TRMyPlayerMo:updateServerDataAfterOpSceneWalk(params, isRandom)
	self.serverGridId = params.step
	self.pathIndex = table.indexof(self.movePathList, params.step)

	if isRandom then
		self._attackRandomDiceCountRemain = self._attackRandomDiceCountRemain - 1
	else
		self._fixDiceCountRemain = self._fixDiceCountRemain - 1
	end

	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderPlayerServerGridUpdated, self.userId)
end

function TRMyPlayerMo:updateEditMapCount(params)
	self._editCountRemain = params.mapEditLast
	self._editCountMax = params.mapEditMax
end

function TRMyPlayerMo:updatePlayerClientPos(gridId)
	self.clientGridId = gridId

	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderPlayerClientGridUpdated, self.userId)
end

function TRMyPlayerMo:isClientServerSameGrid()
	return self.clientGridId == self.serverGridId
end

function TRMyPlayerMo:getBirthPos()
	local model = TreasureRaiderSceneModel.instance
	local gridX, gridY = model:id2Grid(self.serverGridId)
	local x, y = model:grid2Pos(gridX, gridY)

	return x, y
end

function TRMyPlayerMo:updatePlayerAttackFormation(form)
	self._attackForm = form
end

function TRMyPlayerMo:getAttackFormationData()
	return self._attackForm
end

function TRMyPlayerMo:createGhostMo(isRevenge)
	local playerMo = TRMyPlayerMo.New()

	playerMo.userId = self.userId
	playerMo.userName = self.userName
	playerMo.playerInfo = {
		userId = LoginModel.instance.userId,
		userName = RoleModel.instance:getUserName(),
		headIconId = RoleModel.instance:getHeadIconId(),
		headFrameId = RoleModel.instance:getHeadFrameId(),
		gender = RoleModel.instance:getGender()
	}
	playerMo.isGhost = true
	playerMo.isRevenge = checkbool(isRevenge)

	local configInstance = TreasureRaiderConfig.instance
	local mapPlanId = configInstance:getMapPlanId()
	local config = configInstance:getPathConfig(mapPlanId)

	playerMo.movePathList = config.movePathGridIds
	playerMo.serverGridId = configInstance:getCommonValue("AttackInitPos", true)
	playerMo.clientGridId = playerMo.serverGridId
	playerMo.pathIndex = table.indexof(playerMo.movePathList, playerMo.serverGridId)
	playerMo._fixDiceCountRemain = configInstance:getCommonValue("AttackFixedRollNum", true)
	playerMo._fixDiceCountMax = playerMo._fixDiceCountRemain
	playerMo._attackRandomDiceCountRemain = configInstance:getCommonValue("AttackRollNum", true)
	playerMo._attackRandomDiceCountMax = playerMo._attackRandomDiceCountRemain
	playerMo._attackCountRemain = 0
	playerMo._attackCountMax = 0
	playerMo._editCountRemain = 0
	playerMo._editCountMax = 0
	playerMo._defendNews = 0
	playerMo._extendBuffMap = {}

	for k, v in pairs(self._extendBuffMap) do
		playerMo._extendBuffMap[k] = v
	end

	playerMo._attackForm = self._attackForm

	return playerMo
end

function TRMyPlayerMo:getFixDiceCountRemain()
	return self._fixDiceCountRemain
end

function TRMyPlayerMo:getFixDiceCountMax()
	return self._fixDiceCountMax
end

function TRMyPlayerMo:getRandomDiceCountRemain()
	if self.isGhost then
		return self._attackRandomDiceCountRemain
	else
		return EnergyModel.instance:getCurEnergy(TreasureRaiderConst.RandomDiceId) or 0
	end
end

function TRMyPlayerMo:getRandomDiceCountMax()
	if self.isGhost then
		return self._attackRandomDiceCountMax
	else
		local cfg = EnergyConfig.instance:getEnergyCfg(TreasureRaiderConst.RandomDiceId) or {}

		return cfg.recoveryLimit
	end
end

function TRMyPlayerMo:getRandomDiceCd()
	if self.isGhost then
		return 0
	else
		return EnergyModel.instance:getCurEnergyLeftTime(TreasureRaiderConst.RandomDiceId) or 0
	end
end

function TRMyPlayerMo:getAttackCountRemain()
	return self._attackTotalNum
end

function TRMyPlayerMo:isAttackCountReachMax()
	return checknumber(self._attackNumToday) >= self._attackNumTodayMax
end

function TRMyPlayerMo:getEditCountRemain()
	return self._editCountRemain
end

function TRMyPlayerMo:getEditCountMax()
	return self._editCountMax
end

function TRMyPlayerMo:getRevengeCountRemain()
	return self._revengeNumTodayMax - self._revengeNumToday
end

function TRMyPlayerMo:isBuffActive(buffType)
	local buffValue = self:getBuffValue(buffType)

	return buffValue ~= nil and buffValue > 0
end

function TRMyPlayerMo:getBuffValue(buffType)
	return self._extendBuffMap[buffType]
end

function TRMyPlayerMo:setAttackPrize(params)
	self._attackPrize = {}

	if not string.nilorempty(params.prize) then
		self._attackPrize = string.split(params.prize, "#")
	end

	if params.changeSetId then
		self._attackChangeSetId = params.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._attackChangeSetId)
	end
end

function TRMyPlayerMo:getChangeSetIdAndReset()
	self._attackChangeSetId = nil

	return self._attackChangeSetId
end

function TRMyPlayerMo:getAttackPrize()
	return self._attackPrize or {}
end

function TRMyPlayerMo:getDefendNewNum()
	return self._defendNews
end

function TRMyPlayerMo:setDefendNewNum(num)
	self._defendNews = checknumber(num)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TREASURE_DEFENDNEW, self:getDefendNewNum() > 0)
end

return TRMyPlayerMo
