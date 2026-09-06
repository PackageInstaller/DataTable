-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgResultSureView.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgResultSureView", package.seeall)

local OriginKingOrderClgResultSureView = class("OriginKingOrderClgResultSureView", ViewComponent)

function OriginKingOrderClgResultSureView:buildUI()
	OriginKingOrderClgResultSureView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._curFmtView = self:getGo("horBar/curFmt/fmtView")
	self._curFmtCell = self:getGo("horBar/curFmt/fmtCell")

	GameUtil.SetActive(self._curFmtCell, false)

	self._nextFmt = self:getGo("horBar/nextFmt")
	self._nextFmtCell = self:getGo("horBar/nextFmt/fmtCell")
	self._nextFmtView = self:getGo("horBar/nextFmt/fmtView")

	GameUtil.SetActive(self._nextFmtCell, false)
end

function OriginKingOrderClgResultSureView:bindEvents()
	OriginKingOrderClgResultSureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginKingOrderClgResultSureView:unbindEvents()
	OriginKingOrderClgResultSureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginKingOrderClgResultSureView:onEnter()
	OriginKingOrderClgResultSureView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
	self._subMo = OriginKingOrderClgController.instance:getSubMo(self._activityId)
	self._maxStageId = self._subMo:getMaxStageId()

	local resultMsg = self._subMo:getFightResultMsg()

	if resultMsg then
		self._formationSoul = resultMsg.formationSoul or {}
	end

	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingOrderClgConfirmRes, self._handlePM_OriginKingOrderClgConfirmRes, self)
	self:_onUpdate()
end

function OriginKingOrderClgResultSureView:onExit()
	OriginKingOrderClgResultSureView.super.onExit(self)
	self:_onClearCurFmt()
	self:_onClearNextFmt()
end

function OriginKingOrderClgResultSureView:_handlePM_OriginKingOrderClgConfirmRes(status, msg)
	self:close()
	BattleController.instance:endBattle()
end

function OriginKingOrderClgResultSureView:_onUpdate()
	self:_onUpdateCurFmt()
	self:_onUpdateNextFmt()
end

function OriginKingOrderClgResultSureView:_onUpdateCurFmt()
	local formation = self._fmtMo:getCurFormation()
	local childCount = self._curFmtView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._curFmtView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._curFmtCell, self._curFmtView.transform, self._curFmtCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local petId = checknumber(formation:GetPosition(posId))
		local petMo = petId > 0 and formation:_getPet(petId)
		local raceId = checknumber(petMo and petMo:getDefineId())
		local skinId = checknumber(petMo and petMo.curFaceId)
		local mask = goutil.findChild(mainGo, "mask")
		local icon = goutil.findChild(mainGo, "mask/icon")

		GameUtil.SetActive(mask, skinId > 0)

		if skinId > 0 then
			MaterialMgr.setIcon(icon, MatType.Pet, skinId)
		else
			MaterialMgr.clearIcon(icon)
		end

		GameUtil.addClickHandler(mainGo, function()
			if petMo then
				CommonTipsMgr.instance:showPetTips(petMo)
			end
		end, self)
	end
end

function OriginKingOrderClgResultSureView:_onClearCurFmt()
	local childCount = self._curFmtView.transform.childCount

	for idx = 1, childCount do
		local mainGo = self._curFmtView.transform:GetChild(idx - 1).gameObject
		local icon = goutil.findChild(mainGo, "mask/icon")

		MaterialMgr.clearIcon(icon)
		GameUtil.rmClickHandler(mainGo)
	end
end

function OriginKingOrderClgResultSureView:_onUpdateNextFmt()
	if self._maxStageId == self._stageId then
		self:_onClearNextFmt()
		GameUtil.SetActive(self._nextFmt, false)

		return
	end

	GameUtil.SetActive(self._nextFmt, true)

	local nextStageId = self._stageId + 1
	local signs = self._subMo:getNextFormationSigns(self._formationSoul, nextStageId)
	local stageType = self._subMo:getStageType(nextStageId)
	local defaultMap = {}
	local stageData = OriginKingOrderClgConfig.instance:getStageData(self._activityId, nextStageId)

	if stageData then
		for _, posId in ipairs(stageData.posSigns) do
			defaultMap[posId] = true
		end
	end

	local childCount = self._nextFmtView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._nextFmtView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._nextFmtCell, self._nextFmtView.transform, self._nextFmtCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local tagNingzhi = goutil.findChild(mainGo, "tagNingzhi")
		local tagNingzhiDefault = goutil.findChild(mainGo, "tagNingzhi/default")
		local tagStorm = goutil.findChild(mainGo, "tagStorm")
		local tagStormDefault = goutil.findChild(mainGo, "tagStorm/default")

		if not signs[posId] then
			GameUtil.SetActive(tagNingzhi, false)
			GameUtil.SetActive(tagStorm, false)
			GameUtil.SetActive(tagNingzhiDefault, false)
			GameUtil.SetActive(tagStormDefault, false)

			if stageType == OriginKingOrderClgEnum.StageType_Kong then
				GameUtil.SetActive(tagStorm, signs[posId])
				GameUtil.SetActive(tagStormDefault, defaultMap[posId])
			elseif stageType == OriginKingOrderClgEnum.StageType_Water then
				GameUtil.SetActive(tagNingzhi, signs[posId])
				GameUtil.SetActive(tagNingzhiDefault, defaultMap[posId])
			end
		end
	end
end

function OriginKingOrderClgResultSureView:_onClearNextFmt()
	local childCount = self._nextFmtView.transform.childCount

	for idx = 1, childCount do
		local mainGo = self._nextFmtView.transform:GetChild(idx - 1).gameObject
	end
end

function OriginKingOrderClgResultSureView:_onClickBtnCancel()
	OriginKingOrderClgController.instance:sendPM_OriginKingOrderClgConfirmReq(self._activityId, self._stageId, false)
end

function OriginKingOrderClgResultSureView:_onClickBtnSure()
	OriginKingOrderClgController.instance:sendPM_OriginKingOrderClgConfirmReq(self._activityId, self._stageId, true)
end

return OriginKingOrderClgResultSureView
