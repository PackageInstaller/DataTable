-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/model/MagicSchoolPvPFormationFmtMo.lua

module("logic.extensions.magicschoolpvp.model.MagicSchoolPvPFormationFmtMo", package.seeall)

local MagicSchoolPvPFormationFmtMo = class("MagicSchoolPvPFormationFmtMo", BaseCustomFmtMo)

function MagicSchoolPvPFormationFmtMo:updateCfg(activityId, simpleForm, isBattle)
	self._activityId = activityId
	self._simpleForm = simpleForm
	self._isBattle = isBattle
	self._subMo = MagicSchoolPvPController.instance:getSubMo(self._activityId)
	self.isShowBtnSave = true
	self.isShowPetBag = false
	self.isShowBtnBuffForm = false

	self:refreshMyFmts(self._simpleForm)
end

function MagicSchoolPvPFormationFmtMo:getActivityId()
	return self._activityId
end

function MagicSchoolPvPFormationFmtMo:isBattle()
	return self._isBattle
end

function MagicSchoolPvPFormationFmtMo:refreshMyFmts(data)
	if data then
		self:getCurFormation():SetData(data)
	else
		self:getCurFormation():ResetPosition()
	end
end

function MagicSchoolPvPFormationFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function MagicSchoolPvPFormationFmtMo:fmtVerifyReq()
	if self:isEmptyFmt() then
		FloatWordMgr.instance:show("空阵不能保存作为守阵，请返回布阵")

		return
	end

	local simpleForm = self:getCurSimpleForm()

	if self._isBattle then
		GlobalDispatcher:addListener(GlobalNotify.HandlePM_MSPvPSetFormationRes, self._handleSaveRes, self)
		MagicSchoolPvPController.instance:sendPM_MSPvPSetFormationReq(self._activityId, simpleForm)
		self._subMo:setFormationSimpleFormBattle(simpleForm)
	else
		GlobalDispatcher:addListener(GlobalNotify.HandlePM_MSPvPSetPresetFormationRes, self._handleSaveRes, self)
		MagicSchoolPvPController.instance:sendPM_MSPvPSetPresetFormationReq(self._activityId, simpleForm)
	end
end

function MagicSchoolPvPFormationFmtMo:_handleSaveRes(status)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_MSPvPSetFormationRes, self._handleSaveRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_MSPvPSetPresetFormationRes, self._handleSaveRes, self)

	if status ~= 0 then
		FloatWordMgr.instance:show("阵容保存失败")
	else
		FloatWordMgr.instance:show("阵容保存成功")
	end
end

function MagicSchoolPvPFormationFmtMo:sendSaveMsg(fromBtnSave)
	if not fromBtnSave then
		return
	end

	MagicSchoolPvPFormationFmtMo.super.sendSaveMsg(self, fromBtnSave)
end

function MagicSchoolPvPFormationFmtMo:isEmptyFmt()
	return self:getCurFormation():isEmpty()
end

function MagicSchoolPvPFormationFmtMo:getFormationExtendViewName()
	return ViewName.MagicSchoolPvpFmtExtisonView
end

return MagicSchoolPvPFormationFmtMo
