-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldStageResultView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldStageResultView", package.seeall)

local HolyDragonFieldStageResultView = class("HolyDragonFieldStageResultView", ViewComponent)

function HolyDragonFieldStageResultView:buildUI()
	HolyDragonFieldStageResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtMaxScore = self:getTxt("desc/txtMaxScore")
	self._txtCurScore = self:getTxt("desc/txtCurScore")
	self._tagNew = self:getGo("desc/txtCurScore/tagNew")
	self._scoreCellGos = {
		self:getGo("titleCol/cell1"),
		self:getGo("titleCol/cell2"),
		self:getGo("titleCol/cell3")
	}
end

function HolyDragonFieldStageResultView:bindEvents()
	HolyDragonFieldStageResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._endBattle, self)
	GameUtil.addClickHandler(self._btnSure, self._endBattle, self)
end

function HolyDragonFieldStageResultView:unbindEvents()
	HolyDragonFieldStageResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function HolyDragonFieldStageResultView:onEnter()
	HolyDragonFieldStageResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._fieldId = checknumber(params[2])
	self._stageId = checknumber(params[3])
	self._subMo = HolyDragonFieldController.instance:getSubMo(self._activityId)

	self:_onUpdate()
end

function HolyDragonFieldStageResultView:_onUpdate()
	local challengeMsg = self._subMo and self._subMo:getLastChallengeMsg() or nil

	if challengeMsg then
		if not challengeMsg.gainScore then
			local gainScore = 0
			local maxScore = self._subMo and self._subMo:getStageScore(self._fieldId, self._stageId) or 0

			self._txtCurScore.text = tostring(gainScore)
			self._txtMaxScore.text = tostring(maxScore)

			GameUtil.SetActive(self._tagNew, maxScore < gainScore)
			self:_updateScoreCells()
		end
	end
end

function HolyDragonFieldStageResultView:_updateScoreCells()
	local challengeMsg = self._subMo and self._subMo:getLastChallengeMsg() or nil

	if challengeMsg then
		if not challengeMsg.settleNum then
			local settleNums = {}

			for index, go in ipairs((not self._scoreCellGos or nil) and {}) do
				local settleNum = settleNums[index]
				local isActive = settleNum ~= nil

				GameUtil.SetActive(go, isActive)

				if isActive then
					local txtName = goutil.findChildTextComponent(go, "txtName")
					local txtValue = goutil.findChildTextComponent(go, "txtValue")
					local txtScore = goutil.findChildTextComponent(go, "txtScore")
					local score = self:_getSettleScore(settleNum)

					txtName.text = self:_getSettleTypeName(settleNum.settleType)
					txtValue.text = self:_getSettleValueText(settleNum)
					txtScore.text = string.format("+%s", tostring(score))
				end
			end
		end
	end
end

function HolyDragonFieldStageResultView:_getSettleValueText(settleNum)
	local settleTypeParam = HolyDragonFieldConfig.instance:getSettleTypeParam(self._activityId, settleNum.settleType)

	if settleTypeParam == HolyDragonFieldEnum.SettleType.Alive then
		return checknumber(settleNum.num) > 0 and lang("存活") or lang("阵亡")
	end

	return tostring(settleNum.num or 0)
end

function HolyDragonFieldStageResultView:_getSettleScore(settleNum)
	return HolyDragonFieldConfig.instance:getStageSettleScore(self._activityId, self._fieldId, self._stageId, settleNum.settleType, settleNum.num)
end

function HolyDragonFieldStageResultView:_getSettleTypeName(settleType)
	return HolyDragonFieldConfig.instance:getSettleTypeName(self._activityId, settleType)
end

function HolyDragonFieldStageResultView:_endBattle()
	BattleController.instance:endBattle()
end

return HolyDragonFieldStageResultView
