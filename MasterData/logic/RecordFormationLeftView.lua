-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/RecordFormationLeftView.lua

module(..., package.seeall)

local RecordFormationLeftView = class("RecordFormationLeftView", FormationLeftView)

function RecordFormationLeftView:buildUI()
	self._noNeedDrag = true

	RecordFormationLeftView.super.buildUI(self)
end

function RecordFormationLeftView:onEnter()
	self._data = self._viewPresentor._openParam[1]
	self._key = self._viewPresentor._openParam[2]
	self._pos = self._data.myPlayer.form.pos

	RecordFormationLeftView.super.onEnter(self)
	self._Btn_Formation:SetActive(false)
	self:_setActiveBtnFormationUse(false)
	self:_setActiveBtnFormation(false)
	self._gotTipRoot:SetActive(true)

	for i = 1, 9 do
		if checknumber(self._pos[i]) > 0 then
			local bagPetInfo
			local raceId = BattleRecordFmtModel.instance:getPetInfoByPetId(self._pos[i]).raceId

			self._gotTips[i]:SetActive(((self._data.recordKey ~= nil and string.find(self._data.recordKey, BattleRecordRankController.TechingPrefix) or string.find(self._key, BattleRecordRankController.ChuangkongUnion)) and true or BagModel.instance:getPetIdByRaceId(raceId)) == nil)
		else
			self._gotTips[i]:SetActive(false)
		end
	end

	self:_onUpdateBuffFormById()
end

function RecordFormationLeftView:onExit()
	self:_onExitUnbindingEvent()
end

function RecordFormationLeftView:_SetFormationNameAndIcon(id)
	return
end

function RecordFormationLeftView:_onClickElementSkill()
	return
end

function RecordFormationLeftView:_OnClickBtnHeroSkill()
	if self.lastHeroSkollId and self.lastHeroSkollId > 0 then
		CommonTipsMgr.instance:openMaterialTips(self._Btn_HeroSkill, MatType.Skill, self.lastHeroSkollId)
	end
end

function RecordFormationLeftView:_SetHeroSkill(id)
	self._data = self._viewPresentor._openParam[1]

	if self._data and self._data.myPlayer and self._data.myPlayer.form and self._data.myPlayer.form.extParams and self._data.myPlayer.form.extParams.heroSkillId then
		id = self._data.myPlayer.form.extParams.heroSkillId
	end

	RecordFormationLeftView.super._SetHeroSkill(self, id)
end

function RecordFormationLeftView:_OnClickSeat(go, eventData)
	if self._dragSeat then
		self._dragSeat:ShowPet()
	end

	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat or not itemSeat:IsOpen() then
		return
	end

	if not itemSeat:isHasPet() then
		printInfo("当前位置没有精灵")

		return
	end

	local petId = itemSeat:GetData()
	local petData = self:_getPet(petId)
	local pet = {
		raceId = petData.raceId,
		level = petData.curLv,
		_curZdl = self:_getRecordZdl(petId),
		awakenLv = petData.awakenLv,
		contractSkillId = petData.contractSkillId,
		curFaceId = petData.curFaceId
	}

	CommonTipsMgr.instance:showPetTips(pet)
end

function RecordFormationLeftView:_OnClickBtnBuffForm()
	return
end

function RecordFormationLeftView:_getPowerAndSpeed()
	if self._data then
		local power = self._data.myPlayer.zdl
		local speed = self._data.myPlayer.speed

		return power, speed
	end

	return 0, 0
end

function RecordFormationLeftView:_getCurFormId()
	return BattleRecordFmtModel.instance:getCurFormationId()
end

function RecordFormationLeftView:_getCurFormation()
	return BattleRecordFmtModel.instance:getFormation()
end

function RecordFormationLeftView:_getPetsHeroSkills()
	return BattleRecordFmtModel.instance:getFormPetsHeroSkills()
end

function RecordFormationLeftView:_getHeroSkillId()
	return BattleRecordFmtModel.instance:getHeroSkillId()
end

function RecordFormationLeftView:_getPet(petId)
	return BattleRecordFmtModel.instance:getPet(petId)
end

function RecordFormationLeftView:_getRecordZdl(petId)
	return BattleRecordFmtModel.instance:getRecordPetZdl(petId)
end

function RecordFormationLeftView:_getCurrTeamId()
	return BattleRecordFmtModel.instance:getTeamId()
end

function RecordFormationLeftView:_getItemSeatCls()
	return RecordBattleItemSeat
end

function RecordFormationLeftView:_onUpdateBuffFormById()
	return
end

function RecordFormationLeftView:_refreshBuffForm()
	local formId = checknumber(self._data.myPlayer.form.extParams.formStrengthId)
	local formLv = checknumber(self._data.myPlayer.form.extParams.formStrengthLv)

	self:_onSelectBuffForm(formId, formLv)
	self:_SetPowerAndSpeed()
end

return RecordFormationLeftView
