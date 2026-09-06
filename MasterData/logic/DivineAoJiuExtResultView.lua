-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuExtResultView.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuExtResultView", package.seeall)

local DivineAoJiuExtResultView = class("DivineAoJiuExtResultView", ViewComponent)

function DivineAoJiuExtResultView:ctor()
	DivineAoJiuExtResultView.super.ctor(self)
end

function DivineAoJiuExtResultView:unbindEvents()
	DivineAoJiuExtResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSureSingle)
	GameUtil.rmClickHandler(self._btnCancelSwitch)
	GameUtil.rmClickHandler(self._btnSureSwitch)
end

function DivineAoJiuExtResultView:bindEvents()
	DivineAoJiuExtResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSureSingle, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancelSwitch, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnSureSwitch, self._onClickSure, self)
end

function DivineAoJiuExtResultView:buildUI()
	DivineAoJiuExtResultView.super.buildUI(self)

	self._singleResult = self:getGo("singleResult")
	self._txtTypeSingle = self:getTxt("singleResult/txtType")
	self._txtScoreSingle = self:getTxt("singleResult/txtScore")
	self._btnSureSingle = self:getGo("singleResult/btnSure")
	self._imgType = self:getGo("singleResult/imgType")
	self._imgTypeChange = self._imgType:GetComponent(ComponentType.UIImageSpriteChange)
	self._switchResult = self:getGo("switchResult")
	self._txtOldType = self:getTxt("switchResult/txtOldType")
	self._txtOldScore = self:getTxt("switchResult/txtOldScore")
	self._imgTypeOld = self:getGo("switchResult/imgTypeOld")
	self._imgTypeOldChange = self._imgTypeOld:GetComponent(ComponentType.UIImageSpriteChange)
	self._txtNewType = self:getTxt("switchResult/txtNewType")
	self._txtNewScore = self:getTxt("switchResult/txtNewScore")
	self._imgTypeNew = self:getGo("switchResult/imgTypeNew")
	self._imgTypeNewChange = self._imgTypeNew:GetComponent(ComponentType.UIImageSpriteChange)
	self._btnCancelSwitch = self:getGo("switchResult/btnCancel")
	self._btnSureSwitch = self:getGo("switchResult/btnSure")
end

function DivineAoJiuExtResultView:onExit()
	DivineAoJiuExtResultView.super.onExit(self)
end

function DivineAoJiuExtResultView:onEnter()
	DivineAoJiuExtResultView.super.onEnter(self)

	local data = DivineAoJiuModel.instance:getTempResultData()

	self._activityId = data.activityId
	self._stageId = data.stageId

	local curBuffCfg = DivineAoJiuConfig.instance:getBuffCfg(self._activityId, data.selectBuffId)
	local curBuffTypeName = DivineAoJiuConfig.instance:getBuffName(self._activityId, curBuffCfg.buffType)

	self._txtTypeSingle.text = curBuffTypeName

	self._imgTypeChange:SetState(curBuffCfg.buffType - 1)

	self._txtNewType.text = curBuffTypeName

	self._imgTypeNewChange:SetState(curBuffCfg.buffType - 1)

	self._txtScoreSingle.text = langPara("存活精灵：<color=#62cf2d>%d</color>", data.curActivePetCount)
	self._txtNewScore.text = langPara("存活精灵：<color=#62cf2d>%d</color>", data.curActivePetCount)

	if checknumber(data.oldSelectBuffId) ~= 0 then
		local oldBuffCfg = DivineAoJiuConfig.instance:getBuffCfg(self._activityId, data.oldSelectBuffId)

		self._txtOldType.text = DivineAoJiuConfig.instance:getBuffName(self._activityId, oldBuffCfg.buffType)
		self._txtOldScore.text = langPara("存活精灵：<color=#62cf2d>%d</color>", data.oldActivePetCount)

		self._imgTypeOldChange:SetState(oldBuffCfg.buffType - 1)
	end

	GameUtil.SetActive(self._singleResult, checknumber(data.oldSelectBuffId) == 0)
	GameUtil.SetActive(self._switchResult, checknumber(data.oldSelectBuffId) ~= 0)
end

function DivineAoJiuExtResultView:_onClickSure()
	DivineAoJiuClgAgent.instance:sendPM_DivineAoJiuClgConfirmReq(self._activityId, self._stageId)
	self:close()
end

function DivineAoJiuExtResultView:_onClickCancel()
	DivineAoJiuModel.instance:resetTempResultData()
	self:close()
end

return DivineAoJiuExtResultView
