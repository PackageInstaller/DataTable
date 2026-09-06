-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/model/XiuNuoBrotherhoodFmtMo.lua

module("logic.extensions.xiunuobrotherhood.model.XiuNuoBrotherhoodFmtMo", package.seeall)

local XiuNuoBrotherhoodFmtMo = class("XiuNuoBrotherhoodFmtMo", ICustomFmtMo)

function XiuNuoBrotherhoodFmtMo:initParams(activityId, stageId, bossId, selectBuffs, gameId, mainViewName, selectViewName, gameViewName)
	self._stageId = stageId
	self._bossId = bossId
	self._activityId = activityId
	self._selectBuffs = selectBuffs
	self._gameActivityId = gameId
	self._stageCfg = XiuNuoBrotherhoodConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._bossCfg = XiuNuoBrotherhoodConfig.instance:getBossPlanCfg(self._stageCfg.bossPlanId, self._bossId)
	self._cfgEnemy = XiuNuoBrotherhoodConfig.instance:getEnemyTeam(self._bossCfg.creepsMasterId)
	self._masterList = XiuNuoBrotherhoodConfig.instance:getEnemyCreeosCfg(self._bossCfg.creepsMasterId)
	self._mainViewName = mainViewName
	self._selectViewName = selectViewName
	self._gameViewName = gameViewName
end

function XiuNuoBrotherhoodFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc
	self.isPopRuleDesc = true
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_DailyOnce

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function XiuNuoBrotherhoodFmtMo:initFightHandler()
	local function handler()
		if not string.nilorempty(self._mainViewName) then
			UIJumper.instance:pushOneStack(self._mainViewName, true)
		else
			UIJumper.instance:pushOneStack(ViewName.XiuNuoBrotherhoodMainView, true)
		end

		if not string.nilorempty(self._selectViewName) then
			UIJumper.instance:pushOneStack(self._selectViewName, true, self._activityId)
		end

		if not string.nilorempty(self._gameViewName) then
			UIJumper.instance:pushOneStack(self._gameViewName, true, self._activityId, self._stageId, self._gameActivityId, false)
		else
			UIJumper.instance:pushOneStack(ViewName.XiuNuoBrotherhoodGameView, true)
		end

		XiuNuoBrotherhoodModel.instance:setInBattle(true)

		local simpleForm = self:getCurSimpleForm()

		XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodFightReq(self._activityId, self._stageId, self._bossId, self._selectBuffs, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function XiuNuoBrotherhoodFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function XiuNuoBrotherhoodFmtMo:getMonsterConfigList()
	return self._masterList
end

function XiuNuoBrotherhoodFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function XiuNuoBrotherhoodFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

return XiuNuoBrotherhoodFmtMo
