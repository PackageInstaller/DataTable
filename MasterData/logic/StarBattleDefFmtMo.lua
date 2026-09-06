-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/model/StarBattleDefFmtMo.lua

module("logic.extensions.starbattle.model.StarBattleDefFmtMo", package.seeall)

local StarBattleDefFmtMo = class("StarBattleDefFmtMo", BaseCustomFmtMo)

function StarBattleDefFmtMo:initParams(activityId, periodId, isNew)
	self.activityId = activityId
	self.periodId = periodId
	self.isNew = isNew
	self.preiodCfg = StarBattleConfig.instance:getPeriodCfg(self.activityId, self.periodId)
	self.isShowBtnSave = true
	self.addShowTips = ""

	local eleFilterStr = ""

	if self.preiodCfg then
		eleFilterStr = self.preiodCfg.eleFilter

		if not self.isNew then
			self.addShowTips = self.preiodCfg.defTipDesc
		end
	end

	self._eles = {}

	if not GameUtil.isEmptyString(eleFilterStr) then
		self._eles = string.split(eleFilterStr, "#")
	end

	self:refreshMyFmts()
end

function StarBattleDefFmtMo:refreshMyFmts()
	local info = StarBattleModel.instance:getBaseInfo(self.activityId, self.periodId)

	if info then
		local formMo = self:getCurFormation()

		formMo:SetData(info.form)
	end
end

function StarBattleDefFmtMo:refreshPetList(changePetMoMap)
	if changePetMoMap and _G.next(changePetMoMap) and self._rightPetMap then
		local indexMap, removeIdxMap

		for petId, petMo in pairs(changePetMoMap) do
			local mo = self._rightPetMap[petMo.petId]

			if self.isOnlyUpdateExistPet then
				if mo == nil then
					-- block empty
				elseif petMo.isSupportedPet == mo.isSupportedPet and petMo.isMyPackPet == mo.isMyPackPet then
					if indexMap == nil then
						removeIdxMap = {}
						indexMap = {}

						for i, v in ipairs(self._rightPetList) do
							indexMap[v.petId] = i
						end
					end

					self:_updatePetMoEx(petMo, indexMap, removeIdxMap)
				end
			else
				if indexMap == nil then
					removeIdxMap = {}
					indexMap = {}

					for i, v in ipairs(self._rightPetList) do
						indexMap[v.petId] = i
					end
				end

				if self:_checkPetMoEle(petMo) then
					self:_updatePetMoEx(petMo, indexMap, removeIdxMap)
				end
			end
		end

		if removeIdxMap and _G.next(removeIdxMap) then
			for i = #self._rightPetList, 1, -1 do
				if removeIdxMap[i] then
					table.remove(self._rightPetList, i)
				end
			end
		end
	end
end

function StarBattleDefFmtMo:_checkPetMoEle(mo)
	if self.isNew then
		return true
	elseif mo then
		for i, ele in ipairs(self._eles) do
			if mo:checkHasRace(ele) then
				return true
			end
		end
	end

	return false
end

function StarBattleDefFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		if self:_checkPetMoEle(petMo) then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function StarBattleDefFmtMo:initSaveHandler()
	local function handler(fmtMo, fromBtnSave)
		if fromBtnSave == true then
			StarBattleController.instance:saveDefense(self.activityId, self:getCurSimpleForm(), self.periodId)
		end
	end

	self.setSaveHandler(self, handler, self)
end

function StarBattleDefFmtMo:getFormationExtendViewName()
	return ViewName.StarBattleDefFmtExView
end

return StarBattleDefFmtMo
