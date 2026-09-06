-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/model/MiMengLiNorFmtMo.lua

module("logic.extensions.mimengli.model.MiMengLiNorFmtMo", package.seeall)

local MiMengLiNorFmtMo = class("MiMengLiNorFmtMo", BaseCustomFmtMo)

function MiMengLiNorFmtMo:onInit()
	MiMengLiNorFmtMo.super.onInit(self)

	self.isOnlyUpdateExistPet = true
end

function MiMengLiNorFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local cfg = MiMengLiConfig.instance:getStageCfgById(self.activityId, self.stageId) or {}

	self.creepsMasterId = checknumber(cfg.creepsMasterId)
	self.masterCfg = MiMengLiConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = MiMengLiConfig.instance:getCreepsById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "MiMengLiNorFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
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

function MiMengLiNorFmtMo:initPetList()
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

function MiMengLiNorFmtMo:_changePetMo(petMo)
	petMo = petMo:GetClone()

	return petMo
end

function MiMengLiNorFmtMo:updateCellTop(cell, petMo)
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

function MiMengLiNorFmtMo:getMonsterConfigList()
	return self.creeps
end

function MiMengLiNorFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function MiMengLiNorFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		MiMengLiController.instance:sendStartNorFight(self.activityId, self:getCurSimpleForm())
	end, nil)
end

function MiMengLiNorFmtMo:checkPetIsForbit(petMo, baseCheck)
	local right = checknumber(self._hpMap[petMo.petId])

	if right == -1 then
		return false
	else
		return right == 0
	end
end

return MiMengLiNorFmtMo
