-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomMissionFmtView.lua

module("logic.extensions.customfmt.view.CustomMissionFmtView", package.seeall)

local CustomMissionFmtView = class("CustomMissionFmtView", MissionFmtView)

function CustomMissionFmtView:onEnter()
	self.customFmtMo = self:getFirstParam()

	CustomMissionFmtView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onCurFormTabChange, self)
	GlobalDispatcher:addListener(GlobalNotify.RefreshEnemyFmt, self._onRefreshEnemyFmt, self)
end

function CustomMissionFmtView:onExit()
	CustomMissionFmtView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onCurFormTabChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshEnemyFmt, self._onRefreshEnemyFmt, self)
end

function CustomMissionFmtView:_onCurFormTabChange()
	self:_refreshFromation()
	self:_setHeroSkillEffect()
end

function CustomMissionFmtView:_onRefreshEnemyFmt()
	self:_refreshFromation()
	self:_setHeroSkillEffect()
end

function CustomMissionFmtView:_getCreepCos()
	return self.customFmtMo:getMonsterConfigList() or {}
end

function CustomMissionFmtView:_getMonsterCo()
	return self.customFmtMo:getFmtInfoConfig() or {}
end

function CustomMissionFmtView:_createExtParams(formations)
	CustomMissionFmtView.super._createExtParams(self, formations)

	local extParams = self.customFmtMo:getExtParams(formations)

	if extParams then
		self:setExtParams(extParams)
	end
end

function CustomMissionFmtView:getTeamAndFormation(creepCfg)
	return self.customFmtMo:getTeamAndFormation(creepCfg)
end

function CustomMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	if self.customFmtMo.isHideFmtZdl then
		self._powerTxt.text = "？？？"
		self._speed.text = "？？？"
	end
end

function CustomMissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		local customFmtMo = self.customFmtMo

		local function canJumpOut()
			local canJump = customFmtMo:checkIsCanJumpOut()

			if not canJump then
				customFmtMo:showIsNotCanJumpOutTip()
			end

			return canJump
		end

		CommonTipsMgr.instance:showPetTips(self._infoSeats[index], self.customFmtMo.isHideFmtZdl, canJumpOut)
	end
end

function CustomMissionFmtView:createFormPb()
	local formPb = FormationExtension_pb.PM_SimpleForm()

	for i = 1, 9 do
		if self._infoSeats[i] and checknumber(self._infoSeats[i].curFaceId) > 0 then
			local petId = self._infoSeats[i].petId

			formPb.pos:append(petId)
		else
			formPb.pos:append(0)
		end
	end

	formPb.formId = 10
	formPb.extParams.heroSkillId = self._heroSkillId
	formPb.extParams.psychicSkillId = self:_getPsychicedSkillId()

	local elementalMasterId, elementalTargetId = self:getElementMasterAndTarget()

	formPb.extParams.elementalMasterId = checknumber(elementalMasterId)
	formPb.extParams.elementalTargetId = checknumber(elementalTargetId)

	local cutePetRaceId, cutePetQuality = self:_getCutePetInfo()

	formPb.extParams.cutePetId = 0
	formPb.extParams.cutePetRaceId = checknumber(cutePetRaceId)
	formPb.extParams.cutePetQuality = checknumber(cutePetQuality)
	formPb.extParams.summonMasterPetId = checknumber(self._summonMasterPetId)
	formPb.extParams.summonedPetId = checknumber(self._summonedPetId)

	return formPb
end

function CustomMissionFmtView:setSimpleForm()
	if self.customFmtMo.isSetEnemySimpleForm then
		self.customFmtMo:setEnemySimpleForm(self:createFormPb())
	end
end

function CustomMissionFmtView:_setRightSpeedAndPower(_speed, _zdlRadix)
	local speed = self.customFmtMo:getSpeedInRight() or _speed
	local zdl = self.customFmtMo:getZdlInRight() or _zdlRadix

	CustomMissionFmtView.super._setRightSpeedAndPower(self, speed, zdl)
end

function CustomMissionFmtView:_initFixedEffs()
	self:_setFixedEffs(self.customFmtMo.fixedEffMapRight)
end

return CustomMissionFmtView
