-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanresultView.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanresultView", package.seeall)

local DivinewatertianyanresultView = class("DivinewatertianyanresultView", ViewComponent)

function DivinewatertianyanresultView:ctor()
	DivinewatertianyanresultView.super.ctor(self)
end

function DivinewatertianyanresultView:unbindEvents()
	DivinewatertianyanresultView.super.unbindEvents(self)
end

function DivinewatertianyanresultView:bindEvents()
	DivinewatertianyanresultView.super.bindEvents(self)
end

function DivinewatertianyanresultView:buildUI()
	DivinewatertianyanresultView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")

	self:_buildWaterCon()
	self:_buildFireCon()
end

function DivinewatertianyanresultView:_buildWaterCon()
	self._waterconGo = self:getGo("watercon")
	self._waterTxtNum = self:getTxt("watercon/txtNum")
	self._waterCheck = self:getGo("watercon/checkGo"):GetComponent(ComponentType.UIImageSpriteChange)
end

function DivinewatertianyanresultView:_buildFireCon()
	self._fireconGo = self:getGo("firecon")
	self._fireTxtAdd = self:getTxt("firecon/txtAdd")
	self._fireTxtNew = self:getTxt("firecon/txtNew")
	self._fireTxtOld = self:getTxt("firecon/txtOld")
	self._fireCheck = self:getGo("firecon/checkGo"):GetComponent(ComponentType.UIImageSpriteChange)
end

function DivinewatertianyanresultView:onExit()
	DivinewatertianyanresultView.super.onExit(self)
end

function DivinewatertianyanresultView:onEnter()
	DivinewatertianyanresultView.super.onEnter(self)

	self._msg = self:getFirstParam()
	self._activityId = self._msg.activityId
	self._stageCfg = DivinewatertianyanConfig.instance:getStageCfg(self._activityId, self._msg.stageId)
	self._isFire = self._stageCfg.stageType == DivinewatertianyanController.StageType.Fire
	self._isWin = self:_calIsWin()

	self:_updateUI()
end

function DivinewatertianyanresultView:_updateUI()
	goutil.setActive(self._waterconGo, not self._isFire)
	goutil.setActive(self._fireconGo, self._isFire)

	self._txtTitle.text = string.format("挑战%s", self._isWin and "成功" or "失败")

	if self._isFire then
		self:_updateFireCon()
	else
		self:_updateWaterCon()
	end
end

function DivinewatertianyanresultView:_calIsWin()
	if self._isFire then
		return self._msg.isWin and self._msg.isPass
	end

	return self._msg.isPass
end

function DivinewatertianyanresultView:_updateWaterCon()
	local passNeedValue = self._stageCfg.passNeedValue
	local isPass = passNeedValue <= self._msg.curStageValue

	self._waterTxtNum.text = string.format("(<color=%s>%s</color>/%s)", isPass and "green" or "red", self._msg.curStageValue, passNeedValue)

	self._waterCheck:SetState(isPass and 0 or 1)
end

function DivinewatertianyanresultView:_updateFireCon()
	self._fireTxtOld.text = string.format("x%s", self._msg.oldStageValue)
	self._fireTxtNew.text = string.format("x%s", self._msg.curStageValue)

	local addNum = self._msg.curStageValue - self._msg.oldStageValue

	if addNum > 0 then
		self._fireTxtAdd.text = "+" .. addNum or ""
	end

	self._fireCheck:SetState(self._isWin and 0 or 1)
end

return DivinewatertianyanresultView
