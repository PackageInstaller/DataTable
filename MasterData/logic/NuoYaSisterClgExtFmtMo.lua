-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/model/NuoYaSisterClgExtFmtMo.lua

module("logic.extensions.wuwenchallenge.model.NuoYaSisterClgExtFmtMo", package.seeall)

local NuoYaSisterClgExtFmtMo = class("NuoYaSisterClgExtFmtMo", ICustomFmtMo)

function NuoYaSisterClgExtFmtMo:initParams(activityId, stageId, teamId)
	self.activityId = activityId
	self.stageId = stageId
	self.teamId = teamId
	self._stageCfg = NuoYaSisterClgConfig.instance:getStageCfg(self.activityId, self.teamId, self.stageId)
	self._cfgEnemy = NuoYaSisterClgConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = NuoYaSisterClgConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
	self._activityType = NuoYaSisterClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self.activityId)
end

function NuoYaSisterClgExtFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function NuoYaSisterClgExtFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self.activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		NuoYaSisterClgController.instance:sendPM_NuoYaSisterExtremeClgReq(self.activityId, self.stageId, self.teamId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function NuoYaSisterClgExtFmtMo:initPetList()
	self:clearAllPetList()

	local teamInfo = NuoYaSisterClgModel.instance:getTeamInfo(self.activityId, self.teamId)
	local bagPetMoList = {}

	for i, v in ipairs(teamInfo.pets or {}) do
		local petMo = BagPetsController.instance:getPet(v)

		table.insert(bagPetMoList, petMo)
	end

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function NuoYaSisterClgExtFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function NuoYaSisterClgExtFmtMo:_changePetMo(petMo)
	return petMo
end

function NuoYaSisterClgExtFmtMo:getMonsterConfigList()
	return self._masterList
end

function NuoYaSisterClgExtFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function NuoYaSisterClgExtFmtMo:checkPetIsForbit(petMo, baseCheck)
	local petInfo = NuoYaSisterClgModel.instance:getPetInfo(self.activityId, petMo.petId)

	if petInfo and petInfo.hp == 0 then
		return true
	end

	return false
end

function NuoYaSisterClgExtFmtMo:showForbitPetAlert(petMo)
	local petInfo = NuoYaSisterClgModel.instance:getPetInfo(self.activityId, petMo.petId)

	if petInfo and petInfo.hp == 0 then
		FloatWordMgr.instance:show(lang("该精灵已阵亡"))
	end
end

function NuoYaSisterClgExtFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local petInfo = NuoYaSisterClgModel.instance:getPetInfo(self.activityId, petMo.petId)

		proxy.binder:onUpdateHp(((petInfo and petInfo.hp >= 0 or nil) and petInfo.hp / petMo._maxHp * 100) / 100)
	end
end

function NuoYaSisterClgExtFmtMo:clearCellTop(cell)
	MaterialMgr.resetAll(cell)
end

return NuoYaSisterClgExtFmtMo
