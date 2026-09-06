-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/model/MagicContestFormationFmtMo.lua

module("logic.extensions.magiccontest.model.MagicContestFormationFmtMo", package.seeall)

local MagicContestFormationFmtMo = class("MagicContestFormationFmtMo", BaseCustomFmtMo)

function MagicContestFormationFmtMo:updateCfg(activityId, batType)
	self._activityId = activityId
	self._batType = batType
	self._subMo = MagicContestController.instance:getSubMo(self._activityId)
	self.isShowBtnSave = true

	if self._batType == MagicContestEnum.BatType_Nor then
		self.useMaxFightPower = true
	elseif self._batType == MagicContestEnum.BatType_Ext then
		self.useMaxFightPower = false
	end

	self:initPetList()

	local simpleForm = self._subMo:getDefenseForms(self._batType)

	self:refreshMyFmts(simpleForm)
end

function MagicContestFormationFmtMo:refreshMyFmts(data)
	if data then
		self:getCurFormation():SetData(data)
	else
		self:getCurFormation():ResetPosition()
	end
end

function MagicContestFormationFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function MagicContestFormationFmtMo:fmtVerifyReq()
	if self:isEmptyFmt() then
		FloatWordMgr.instance:show("空阵不能保存作为守阵，请返回布阵")

		return
	end

	local simpleForm = self:getCurSimpleForm()

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_MagicContestSetDefenseFormRes, self._handlePM_MagicContestSetDefenseFormRes, self)
	MagicContestController.instance:sendPM_MagicContestSetDefenseFormReq(self._activityId, self._batType, simpleForm)
end

function MagicContestFormationFmtMo:_handlePM_MagicContestSetDefenseFormRes(status)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_MagicContestSetDefenseFormRes, self._handlePM_ShowDown_SetFormRes, self)

	if status ~= 0 then
		FloatWordMgr.instance:show("阵容保存失败")
	else
		FloatWordMgr.instance:show("阵容保存成功")
	end
end

function MagicContestFormationFmtMo:sendSaveMsg(fromBtnSave)
	if not fromBtnSave then
		return
	end

	MagicContestFormationFmtMo.super.sendSaveMsg(self, fromBtnSave)
end

function MagicContestFormationFmtMo:isEmptyFmt()
	return self:getCurFormation():isEmpty()
end

return MagicContestFormationFmtMo
