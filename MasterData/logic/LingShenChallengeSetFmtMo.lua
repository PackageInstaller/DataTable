-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/model/LingShenChallengeSetFmtMo.lua

module("logic.extensions.lingshenchallenge.model.LingShenChallengeSetFmtMo", package.seeall)

local LingShenChallengeSetFmtMo = class("LingShenChallengeSetFmtMo", ICustomFmtMo)

LingShenChallengeSetFmtMo.ROWPOS = {
	{
		1,
		4,
		7
	},
	{
		2,
		5,
		8
	},
	{
		3,
		6,
		9
	}
}

function LingShenChallengeSetFmtMo:initParams(activityId)
	self.isSetEnemySimpleForm = true
	self.isShowOneKey = false
	self.isShowClean = false
	self.isShowBtnBuffForm = false
	self.isShowBtnCutePet = false
	self.isShowBtnContractPet = false
	self.isShowBtnFormationUse = false
	self.isShowBtnSave = true
	self.activityId = activityId
end

function LingShenChallengeSetFmtMo:updateData()
	self:initPetList()
	self:setFormCondition(190)

	local formPetList = LingShenChallengeModel.instance:getPetFormPosPet(self.activityId)

	if formPetList then
		for i = 1, 3 do
			if checknumber(formPetList[i]) > 0 and BagModel.instance:getBagPetById(formPetList[i]) then
				self:getCurFormation():SetPosition(LingShenChallengeSetFmtMo.ROWPOS[2][i], formPetList[i])
			end
		end
	end

	local info = LingShenChallengeModel.instance:getInfo(self.activityId)

	table.clear(self:getCurFormation():GetChangeRaceTypes())

	if info.form and info.form.extParams and info.form.extParams.changeRaceTypes then
		for i, v in ipairs(info.form.extParams.changeRaceTypes) do
			self:getCurFormation():updateChangeRaceTypes(v.petId, v.raceType)
		end
	end
end

function LingShenChallengeSetFmtMo:initSaveHandler()
	local function handler(fmtMo, fromBtnSave)
		if fromBtnSave == true then
			local simpleForm = self:getCurSimpleForm()
			local formPetList = LingShenChallengeModel.instance:getPetFormPosPet(self.activityId)

			for i = 1, 3 do
				formPetList[i] = simpleForm.pos[LingShenChallengeSetFmtMo.ROWPOS[2][i]]
			end

			LingShenChallengeAgent.instance:sendPM_LingShenClgSetPreFormReq(self.activityId, simpleForm)
		end
	end

	self.setSaveHandler(self, handler, self)
end

function LingShenChallengeSetFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function LingShenChallengeSetFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function LingShenChallengeSetFmtMo:_changePetMo(petMo)
	return petMo
end

function LingShenChallengeSetFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if self._formCondition then
		return FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._formCondition, self:getCurFormation(), isShowTip)
	else
		return true
	end
end

function LingShenChallengeSetFmtMo:isClickCanCloseInFomation()
	if self:getCurFormation():getCurExistPetNumber() < 3 then
		FloatWordMgr.instance:show(lang("请设置阵容后，再退出界面"))

		return false
	else
		return true
	end
end

function LingShenChallengeSetFmtMo:initFormationMo()
	self.formationMo = LingShenChallengeFormationMo.New(GameUtil.handler(self.getPetMoById, self))
	self.formationMo.isAutoSetSummonPet = false
end

function LingShenChallengeSetFmtMo:checkBlockClickBtn(buttonName)
	if buttonName == "HeroSkill" then
		FloatWordMgr.instance:show(lang("不可调整"))

		return true
	elseif buttonName == "PsychicSkill" then
		FloatWordMgr.instance:show(lang("不可调整"))

		return true
	end

	return false
end

return LingShenChallengeSetFmtMo
