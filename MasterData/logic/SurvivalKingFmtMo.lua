-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/model/SurvivalKingFmtMo.lua

module("logic.extensions.survivalking.model.SurvivalKingFmtMo", package.seeall)

local SurvivalKingFmtMo = class("SurvivalKingFmtMo", BaseCustomFmtMo)

function SurvivalKingFmtMo:initParams(activityId, groupId)
	self.activityId = activityId
	self.groupId = groupId
	self.isShowBtnSave = true
	self.helpCfgs = SurvivalKingConfig.instance:getSupportPetCfgs(self.activityId) or {}
	self._lockedPetMap = {}

	local infoMap = SurvivalKingModel.instance:getDefFormInfos(self.activityId) or {}

	for gid, form in pairs(infoMap) do
		if gid ~= self.groupId then
			for _, petId in ipairs(form.pos or {}) do
				if petId > 100000000 then
					local cfg = SurvivalKingConfig.instance:getSupportPetCfgById(self._activityId, petId)

					if cfg then
						self._lockedPetMap[checknumber(cfg.raceId)] = true
					end
				else
					local petMo = BagPetsController.instance:getPet(petId)

					if petMo then
						self._lockedPetMap[checknumber(petMo.raceId)] = true
					end
				end
			end
		end
	end

	self:clearAllPetList()

	self.isOnlyUpdateExistPet = true

	self:refreshMyFmts()
end

function SurvivalKingFmtMo:refreshMyFmts()
	local info = SurvivalKingModel.instance:getDefFormInfo(self.activityId, self.groupId)

	if info then
		local formMo = self:getCurFormation()

		formMo:SetData(info)
	end
end

function SurvivalKingFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	if self.helpCfgs then
		local fmo = self:_getFightPowerPetMo()

		for _, helpData in pairs(self.helpCfgs) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function SurvivalKingFmtMo:_changePetMo(petMo)
	if not petMo then
		return
	end

	if petMo.isSupportedPet then
		return petMo:GetClone()
	end

	local maxPetMo = FightingPowerPetMo.getMaxPetMoByData(petMo)

	maxPetMo.attrMo:resetPublicAttr()
	maxPetMo.attrMo:calcTotalAttrs()
	maxPetMo:refreshAllAttr()

	return maxPetMo
end

function SurvivalKingFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function SurvivalKingFmtMo:initSaveHandler()
	local function handler(fmtMo, fromBtnSave)
		if fromBtnSave == true then
			if self:isEmptyFmt() then
				TipsFacade.instance:openCommonTips("当前阵容不能为空")

				return
			end

			local simpleForm = self:getCurSimpleForm()

			SurvivalKingController.instance:saveFmtInfo(self.activityId, self.groupId, simpleForm)
		end
	end

	self.setSaveHandler(self, handler, self)
end

function SurvivalKingFmtMo:isEmptyFmt()
	return self:getCurFormation():isEmpty()
end

function SurvivalKingFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedPetMap[petMo.raceId])
end

function SurvivalKingFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("同种精灵已在其他守阵中使用")
end

return SurvivalKingFmtMo
