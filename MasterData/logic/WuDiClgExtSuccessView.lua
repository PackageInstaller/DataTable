-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgExtSuccessView.lua

module("logic.extensions.wudiclg.view.WuDiClgExtSuccessView", package.seeall)

local WuDiClgExtSuccessView = class("WuDiClgExtSuccessView", ViewComponent)

function WuDiClgExtSuccessView:buildUI()
	WuDiClgExtSuccessView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtAttackCount = goutil.findChildTextComponent(self.mainGO, "txtAttackCount")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview/Viewport/Content")
	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")

	GameUtil.SetActive(self._petScrollercell, false)

	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
end

function WuDiClgExtSuccessView:bindEvents()
	WuDiClgExtSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function WuDiClgExtSuccessView:unbindEvents()
	WuDiClgExtSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function WuDiClgExtSuccessView:onEnter()
	WuDiClgExtSuccessView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local msg = params[1]

		if msg == nil then
			self:_onClickBtnClose()

			return
		end

		self._activityId = msg.activityId
		self._stageId = msg.stageId

		local curFightGroupAttackCount = msg.curFightGroupAttackCount

		self._confirmNum = checknumber(msg.confirmNum)

		local stageData = WuDiClgConfig.instance:getWdcExtStageData(self._activityId, self._stageId)
		local needGroupAttackCount = stageData.groupAttackCount

		self._txtAttackCount.text = string.format("<color=#20b376>%s/%s</color>", curFightGroupAttackCount, needGroupAttackCount)

		local parentTran = self._petScrollerview.transform
		local childGo = self._petScrollercell
		local children = GameUtil.getChildren(parentTran)
		local array = {}
		local maxGroupAttackCount = 0

		for _, info in ipairs(msg.curFightNewGroupAttacks) do
			maxGroupAttackCount = Mathf.Max(maxGroupAttackCount, info.groupAttackCount)
		end

		for _, info in ipairs(msg.curFightNewGroupAttacks) do
			if maxGroupAttackCount <= info.groupAttackCount then
				table.insert(array, info)
			end
		end

		local length = #array

		for idx, info in ipairs(array) do
			local mainGo = children[idx]

			if mainGo == nil then
				mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
			end

			local item = goutil.findChild(mainGo, "item")
			local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")

			MaterialMgr.setCell(MatType.Pet, info.raceId, item)

			txtCount.text = string.format("群攻：%s", info.groupAttackCount)
		end

		for idx = 1, parentTran.childCount do
			local mainGo = parentTran:GetChild(idx - 1)

			GameUtil.SetActive(mainGo, idx <= length)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(parentTran:GetComponent(goutil.Type_RectTransform))
		self.addGEvent(self, GlobalNotify.WuDiClgExtremeFightConfirmRes, self._wuDiClgExtremeFightConfirmRes, self)
	end
end

function WuDiClgExtSuccessView:onExit()
	WuDiClgExtSuccessView.super.onExit(self)

	local parentTran = self._petScrollerview.transform
	local children = GameUtil.getChildren(parentTran)

	for i, mainGo in ipairs(children) do
		local item = goutil.findChild(mainGo, "item")

		MaterialMgr.resetAll(item)
	end
end

function WuDiClgExtSuccessView:_wuDiClgExtremeFightConfirmRes(status)
	if status == 0 then
		local activityId = self._activityId
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = WuDiClgController.instance:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end
	end

	BattleController.instance:endBattle()
end

function WuDiClgExtSuccessView:_onClickBtnClose()
	BattleController.instance:endBattle()
end

function WuDiClgExtSuccessView:_onClickBtnSure()
	WuDiClgController.instance:sendPM_WuDiClgExtremeFightConfirmReq(self._activityId, self._confirmNum, true)
end

function WuDiClgExtSuccessView:_onClickBtnCancel()
	WuDiClgController.instance:sendPM_WuDiClgExtremeFightConfirmReq(self._activityId, self._confirmNum, false)
end

return WuDiClgExtSuccessView
