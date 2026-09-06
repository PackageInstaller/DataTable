-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/model/MiMengLiBossFmtMo.lua

module("logic.extensions.mimengli.model.MiMengLiBossFmtMo", package.seeall)

local MiMengLiBossFmtMo = class("MiMengLiBossFmtMo", BaseCustomFmtMo)

function MiMengLiBossFmtMo:onInit()
	MiMengLiBossFmtMo.super.onInit(self)

	self.isOnlyUpdateExistPet = true
	self.isShowTab = true
	self.curTabIndex = 1
	self.maxTabCount = 2
end

function MiMengLiBossFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local cfg = MiMengLiConfig.instance:getStageCfgById(self.activityId, self.stageId) or {}

	self.creepsMasterId = checknumber(cfg.creepsMasterId)
	self.masterCfg = MiMengLiConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = MiMengLiConfig.instance:getCreepsById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "MiMengLiBossFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true

	self:clearAllPetList()

	local cfgList = MiMengLiConfig.instance:getBuffTagCfgList(activityId) or {}

	self._buffIdxMap = {}

	for i, v in ipairs(cfgList) do
		local arr = string.split(v.job or "", "#")

		for j, key in ipairs(arr) do
			self._buffIdxMap[key] = v.tagType
		end
	end
end

function MiMengLiBossFmtMo:initPetList()
	local info = MiMengLiModel.instance:getInfo(self.activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}

		if not clgInfo.selectedPetHpInfo then
			local selectedPetHpInfo = {}

			if not clgInfo.tagNumInfo then
				self._hpMap = {}

				for i, v in ipairs(selectedPetHpInfo) do
					local petMo = BagPetsController.instance:getPet(v.left)

					if petMo then
						self:addPetToList(self:_changePetMo(petMo))
					end

					self._hpMap[v.left] = v.right
				end
			end
		end
	end
end

function MiMengLiBossFmtMo:_changePetMo(petMo)
	petMo = petMo:GetClone()

	return petMo
end

function MiMengLiBossFmtMo:updateCellTop(cell, petMo)
	local luaCls = MimengliPetHpSlider
	local url = MimengliPetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local right = checknumber(self._hpMap[petMo.petId])

		if right == -1 then
			proxy.binder:onUpdateHp(1, petMo, self._buffIdxMap)
		else
			local percent = right / petMo._maxHp

			proxy.binder:onUpdateHp(percent, petMo, self._buffIdxMap)
		end
	end
end

function MiMengLiBossFmtMo:getMonsterConfigList()
	return self.creeps
end

function MiMengLiBossFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function MiMengLiBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local list = {}

		for i = 1, self.maxTabCount do
			self.forMationMap[i] = self.forMationMap[i] or FormationMO.New(GameUtil.handler(self.getPetMoById, self))

			local curFmtMo = self.forMationMap[i]
			local pb = CustomFmtController.instance:createFormPb(curFmtMo)

			table.insert(list, pb)

			if curFmtMo:isEmpty() then
				TipsFacade.instance:openTipWindow("提示", langPara("[%s]阵是空阵不能进行挑战，请返回布阵", i), function()
					self.curTabIndex = i

					GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
				end, "去布阵")
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		MiMengLiController.instance:sendStartBossFight(self.activityId, list)
	end, nil)
end

function MiMengLiBossFmtMo:checkPetIsForbit(petMo, baseCheck)
	if self:checkPetIsInOtherTab(petMo) then
		return true
	end

	local right = checknumber(self._hpMap[petMo.petId])

	if right == -1 then
		return false
	else
		return right == 0
	end
end

return MiMengLiBossFmtMo
