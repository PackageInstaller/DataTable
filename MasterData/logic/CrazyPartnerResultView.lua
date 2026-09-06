-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazyPartnerResultView.lua

module("logic.extensions.crazypartner.view.CrazyPartnerResultView", package.seeall)

local CrazyPartnerResultView = class("CrazyPartnerResultView", ViewComponent)

function CrazyPartnerResultView:ctor()
	CrazyPartnerResultView.super.ctor(self)
end

function CrazyPartnerResultView:unbindEvents()
	CrazyPartnerResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CrazyPartnerResultView:bindEvents()
	CrazyPartnerResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickCloseT, self)
end

function CrazyPartnerResultView:buildUI()
	CrazyPartnerResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnLevelup = self:getBtn("levelup")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtDamage = self:getTxt("damage/txtNum")
	self._txtScore = self:getTxt("score/txtNum")
	self._txtTask = self:getTxt("comob/txt")
	self._txtTaskState = self:getTxt("comob/txtNum")
	self._comobGo = self:getGo("comob")
	self._imgStateGo = self:getGo("comob/imgState")
	self._imgState = self._imgStateGo:GetComponent("UIImageSpriteChange")
end

function CrazyPartnerResultView:onExit()
	CrazyPartnerResultView.super.onExit(self)
end

function CrazyPartnerResultView:onEnter()
	CrazyPartnerResultView.super.onEnter(self)

	local info = CrazyPartnerModel.instance.fightInfo

	self._txtScore.text = tostring(info.currentScore)
	self._txtDamage.text = tostring(info.currentDamage)
	self._txtDesc.text = info:getDescString()

	local taskConfMap = CrazyPartnerConfig.instance:getTaskConfMap()
	local curConf = taskConfMap[info.difficulty].conf

	if not curConf then
		self._comobGo:SetActive(false)
	else
		self._comobGo:SetActive(true)

		local strTaskDesc = curConf.resultDesc
		local strTaskState = ""
		local taskState = false
		local detectorParam = curConf.detectorParam

		if curConf.type == CrazyPartnerConfig.TaskType_1 then
			taskState = checknumber(info.taskState) >= checknumber(detectorParam)
		elseif curConf.type == CrazyPartnerConfig.TaskType_4 then
			if string.nilorempty(info.taskState) then
				taskState = string.nilorempty(detectorParam)
			else
				local arr1 = string.split(detectorParam, ",")
				local arr2 = string.split(info.taskState, ",")

				taskState = #arr1 == #arr2
			end
		else
			local request = checknumber(detectorParam)
			local reach = checknumber(info.taskState)

			taskState = request <= reach
			strTaskState = string.format("%d/%d", reach, request)
		end

		self._txtTask.text = strTaskDesc

		if not string.nilorempty(strTaskState) then
			self._txtTaskState.text = strTaskState

			self._imgStateGo:SetActive(false)
		else
			self._txtTaskState.text = ""

			self._imgStateGo:SetActive(true)
			self._imgState:SetState((not taskState or nil) and 1)
		end

		CrazyPartnerModel.instance:clearFightInfo()
	end
end

function CrazyPartnerResultView:_onClickCloseT()
	self:close()
	CrazyPartnerModel.instance:clearFightInfo()
	BattleController.instance:endBattle()
end

return CrazyPartnerResultView
