-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextsuccessView.lua

module("logic.extensions.farnas.view.FarnasextsuccessView", package.seeall)

local FarnasextsuccessView = class("FarnasextsuccessView", ViewComponent)

function FarnasextsuccessView:buildUI()
	FarnasextsuccessView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtAttackCount = goutil.findChildTextComponent(self.mainGO, "txtAttackCount")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/Content")
	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")

	GameUtil.SetActive(self._petScrollercell, false)

	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._emptyGo = self:getGo("petCol/empty")
	self._singleLine = self:getGo("petCol/Content"):GetComponent(ComponentType.UILayoutSingleLine)
end

function FarnasextsuccessView:bindEvents()
	FarnasextsuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function FarnasextsuccessView:unbindEvents()
	FarnasextsuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function FarnasextsuccessView:onEnter()
	FarnasextsuccessView.super.onEnter(self)

	local msg = FarnasModel.instance:getExtFightResultRes()

	if msg == nil then
		self:_onClickBtnSure()

		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId
	local curCount = msg.dodgeCount
	local stageData = FarnasConfig.instance:getExtStageCfg(activityId, stageId)
	local needCount = stageData.dodgeCount

	self._txtAttackCount.text = string.format("我方精灵闪避总次数<color=#20b376>(%s/%s)</color>", curCount, needCount)

	local parentTran = self._petScrollerview.transform
	local childGo = self._petScrollercell
	local children = GameUtil.getChildren(parentTran)
	local array = {}

	if msg.stageInfo then
		array = msg.stageInfo.lockedRace
	end

	local length = #array

	for idx, raceId in ipairs(array) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		local item = goutil.findChild(mainGo, "item")

		MaterialMgr.setCell(MatType.Pet, raceId, item)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end

	goutil.setActive(self._emptyGo, length <= 0)
	self._singleLine:Layout()
end

function FarnasextsuccessView:onExit()
	FarnasextsuccessView.super.onExit(self)

	local parentTran = self._petScrollerview.transform
	local children = GameUtil.getChildren(parentTran)

	for i, mainGo in ipairs(children) do
		local item = goutil.findChild(mainGo, "item")

		MaterialMgr.resetAll(item)
	end
end

function FarnasextsuccessView:_onClickBtnSure()
	BattleController.instance:endBattle()
end

return FarnasextsuccessView
