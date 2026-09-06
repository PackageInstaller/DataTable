-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdiextsuccessView.lua

module("logic.extensions.nvdi.view.NvdiextsuccessView", package.seeall)

local NvdiextsuccessView = class("NvdiextsuccessView", ViewComponent)

function NvdiextsuccessView:buildUI()
	NvdiextsuccessView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtAttackCount = goutil.findChildTextComponent(self.mainGO, "txtAttackCount")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/Content")
	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")

	GameUtil.SetActive(self._petScrollercell, false)

	self._txtName = self:getTxt("txtName")
	self._icon = self:getGo("icon")
	self._txtEmpty = self:getGo("txtEmpty")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._emptyGo = self:getGo("petCol/empty")
	self._singleLine = self:getGo("petCol/Content"):GetComponent(ComponentType.UILayoutSingleLine)
end

function NvdiextsuccessView:bindEvents()
	NvdiextsuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function NvdiextsuccessView:unbindEvents()
	NvdiextsuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function NvdiextsuccessView:onEnter()
	NvdiextsuccessView.super.onEnter(self)

	local extMsgInfo = self:getFirstParam() or {}
	local activityId = checknumber(extMsgInfo.activityId)
	local buffIdUsed = checknumber(extMsgInfo.buffIdUsed)

	if not extMsgInfo.balancedInfo then
		local balancedInfo = {}

		if not extMsgInfo.stageInfo then
			local stageInfo = {}
			local lockMap = {}

			for j, raceId in ipairs(stageInfo.lockedRace) do
				lockMap[raceId] = true
			end

			GameUtil.SetActive(self._txtEmpty, true)
			GameUtil.SetActive(self._icon, false)

			self._txtName.text = ""

			if buffIdUsed > 0 then
				GameUtil.SetActive(self._txtEmpty, false)
				GameUtil.SetActive(self._icon, true)

				local cfg = NvdiChallengeConfig.instance:getBuffCfgById(activityId, buffIdUsed)

				self._txtName.text = tostring(cfg.name)

				uGuiUtil.setSpriteToImage(self._icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
			end

			local parentTran = self._petScrollerview.transform
			local childGo = self._petScrollercell
			local children = GameUtil.getChildren(parentTran)

			for i, mainGo in ipairs(children) do
				local item = goutil.findChild(mainGo, "item")

				MaterialMgr.resetAll(item)
			end

			goutil.clearChildren(parentTran)

			for i, value in ipairs(balancedInfo) do
				local mainGo = goutil.cloneAndSetParent(childGo, parentTran, "cell_" .. i)

				GameUtil.SetActive(mainGo, true)

				local item = goutil.findChild(mainGo, "item")
				local imgTop = goutil.findChild(mainGo, "imgTop")
				local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")

				MaterialMgr.setCell(MatType.Pet, value.left, item)

				txtCount.text = langPara("击杀数:%s", value.right)

				GameUtil.SetActive(imgTop, lockMap[value.left])
			end

			goutil.setActive(self._emptyGo, #balancedInfo == 0)
			self._singleLine:Layout()
		end
	end
end

function NvdiextsuccessView:onExit()
	NvdiextsuccessView.super.onExit(self)

	local parentTran = self._petScrollerview.transform
	local children = GameUtil.getChildren(parentTran)

	for i, mainGo in ipairs(children) do
		local item = goutil.findChild(mainGo, "item")

		MaterialMgr.resetAll(item)
	end
end

function NvdiextsuccessView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return NvdiextsuccessView
