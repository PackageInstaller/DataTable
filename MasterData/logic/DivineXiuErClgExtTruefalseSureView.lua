-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtTruefalseSureView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtTruefalseSureView", package.seeall)

local DivineXiuErClgExtTruefalseSureView = class("DivineXiuErClgExtTruefalseSureView", ViewComponent)

function DivineXiuErClgExtTruefalseSureView:buildUI()
	DivineXiuErClgExtTruefalseSureView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtAttackCount = goutil.findChildTextComponent(self.mainGO, "txtAttackCount")
	self._txtTitle1 = goutil.findChildTextComponent(self.mainGO, "txtTitle1")
	self._txtTitle2 = goutil.findChildTextComponent(self.mainGO, "txtTitle2")
	self._txtDesc1 = goutil.findChildTextComponent(self.mainGO, "txtDesc1")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview/Viewport/Content")
	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")

	GameUtil.SetActive(self._petScrollercell, false)

	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
end

function DivineXiuErClgExtTruefalseSureView:bindEvents()
	DivineXiuErClgExtTruefalseSureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function DivineXiuErClgExtTruefalseSureView:unbindEvents()
	DivineXiuErClgExtTruefalseSureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function DivineXiuErClgExtTruefalseSureView:onEnter()
	DivineXiuErClgExtTruefalseSureView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local info = {}

		self._activityId = info.activityId
		self._tierId = info.tierId
		self._dataBitId = info.dataBitId
		self._sureCallBack = info.sureCallBack
		self._cancelCallBack = info.cancelCallBack

		local msg = DivineXiuErClgController.instance:getDxecMo(self._activityId):getFightResultResOfExt()

		if msg == nil or msg.activityId ~= self._activityId or msg.dataBitId ~= self._dataBitId then
			self:_onClickBtnCancel()

			return
		end

		local stageData = DivineXiuErClgConfig.instance:getDxecExtStageData(self._activityId, self._tierId, self._dataBitId)
		local stageType = stageData.stageType
		local typeData = DivineXiuErClgConfig.instance:getDxecExtStageTruefalseTypeData(self._activityId, stageType)

		self._txtTitle1.text = typeData.clgResultTitle
		self._txtDesc1.text = string.format("<color=#20b376>%s</color>", msg.curFightScore or 0)

		local parentTran = self._petScrollerview.transform
		local childGo = self._petScrollercell
		local children = GameUtil.getChildren(parentTran)
		local array = msg.curFightRaceIdLocked
		local length = #array

		for idx, raceId in ipairs(array) do
			local mainGo = children[idx]

			if mainGo == nil then
				mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
			end

			local item = goutil.findChild(mainGo, "item")
			local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

			if proxy then
				proxy.binder:setAutoTips(false)
			end
		end

		for idx = 1, parentTran.childCount do
			local mainGo = parentTran:GetChild(idx - 1)

			GameUtil.SetActive(mainGo, idx <= length)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(parentTran:GetComponent(goutil.Type_RectTransform))
	end
end

function DivineXiuErClgExtTruefalseSureView:onExit()
	DivineXiuErClgExtTruefalseSureView.super.onExit(self)

	local parentTran = self._petScrollerview.transform
	local children = GameUtil.getChildren(parentTran)

	for i, mainGo in ipairs(children) do
		local item = goutil.findChild(mainGo, "item")

		MaterialMgr.resetAll(item)
	end
end

function DivineXiuErClgExtTruefalseSureView:_onClickBtnSure()
	GameUtil.callBack(self._sureCallBack)
	self:close()
end

function DivineXiuErClgExtTruefalseSureView:_onClickBtnCancel()
	GameUtil.callBack(self._cancelCallBack)
	self:close()
end

return DivineXiuErClgExtTruefalseSureView
