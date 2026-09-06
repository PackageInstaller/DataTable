-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/view/HeartOfAoJiuClgStageSurePopView.lua

module("logic.extensions.heartofaojiuclg.view.HeartOfAoJiuClgStageSurePopView", package.seeall)

local HeartOfAoJiuClgStageSurePopView = class("HeartOfAoJiuClgStageSurePopView", ViewComponent)

function HeartOfAoJiuClgStageSurePopView:buildUI()
	HeartOfAoJiuClgStageSurePopView.super.buildUI(self)

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._imgEmpty = self:getGo("imgEmpty")
	self._txtLastScore = self:getTxt("score/txtLast")
	self._txtCurScore = self:getTxt("score/txtCur")
	self._strTxtLastScore = self._txtLastScore.text
	self._strTxtCurScore = self._txtCurScore.text
end

function HeartOfAoJiuClgStageSurePopView:bindEvents()
	HeartOfAoJiuClgStageSurePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, GameUtil.handler(self._onClickBtnSure, self, true))
	GameUtil.addClickHandler(self._btnCancel, GameUtil.handler(self._onClickBtnSure, self, false))
end

function HeartOfAoJiuClgStageSurePopView:unbindEvents()
	HeartOfAoJiuClgStageSurePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function HeartOfAoJiuClgStageSurePopView:onEnter()
	HeartOfAoJiuClgStageSurePopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
	self._subMo = HeartOfAoJiuClgController.instance:getSubMo(self._activityId)

	local msg = self._subMo:getClgResultMsg()
	local petMoDic = {}
	local fmo = self._fmtMo:getCurFormation()
	local positions = fmo:GetPositions()

	for i = 1, 9 do
		local petId = checknumber(positions[i])

		if petId > 0 then
			local petMo = fmo:_getPet(petId)

			if petMo then
				petMoDic[petMo:getDefineId()] = petMo
			end
		end
	end

	local petInfoList = {}

	for _, v in pairs(msg.raceIdAndLeftHp) do
		local raceId = v.left
		local hp = v.right
		local petMo = petMoDic[raceId]

		if petMo then
			local info = {}

			info.petMo = petMo
			info.hp = hp

			table.insert(petInfoList, info)
		end
	end

	self._petScrollerList:reloadData(petInfoList)

	local lastScore = self._subMo:getLastStageScore(msg.stageId)

	self._txtLastScore.text = string.format(self._strTxtLastScore, lastScore)
	self._txtCurScore.text = string.format(self._strTxtCurScore, msg.score)

	self.addGEvent(self, GlobalNotify.HandlePM_HeartOfAoJiuClgConfirmRes, self._handlePM_HeartOfAoJiuClgConfirmRes, self)
end

function HeartOfAoJiuClgStageSurePopView:onExit()
	HeartOfAoJiuClgStageSurePopView.super.onExit(self)
	self._petScrollerList:dispose()
end

function HeartOfAoJiuClgStageSurePopView:_handlePM_HeartOfAoJiuClgConfirmRes(status, msg)
	self:close()
	BattleController.instance:endBattle()
end

function HeartOfAoJiuClgStageSurePopView:_updatePetCell(view, cell, info, tag)
	local petMo = info.petMo
	local hp = info.hp
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local str = ""

	if hp <= 0 then
		str = "<color=#FF4300FF>0%</color>"
	else
		local value = Mathf.Ceil(hp / 100)

		str = string.format("%d%%", value)
	end

	txtValue.text = str

	local raceId = petMo:getDefineId()
	local skinId = petMo.curFaceId
	local proxy = MaterialMgr.setCell(MatType.Pet, skinId, item)

	if proxy then
		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(petMo, false)
		end)
	end
end

function HeartOfAoJiuClgStageSurePopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function HeartOfAoJiuClgStageSurePopView:_onClickBtnSure(isSave)
	HeartOfAoJiuClgController.instance:sendPM_HeartOfAoJiuClgConfirmReq(self._activityId, self._stageId, isSave)
end

return HeartOfAoJiuClgStageSurePopView
