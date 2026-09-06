-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdiNorDetailView.lua

module("logic.extensions.nvdi.view..NvdiNorDetailView", package.seeall)

local NvdiNorDetailView = class("NvdiNorDetailView", ViewComponent)

function NvdiNorDetailView:buildUI()
	NvdiNorDetailView.super.buildUI(self)

	self._cellParent = goutil.findChild(self.mainGO, "detailCol/content")
	self._detailScrollercell = goutil.findChild(self.mainGO, "detailCol/detailScrollercell")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtScore = self:getTxt("txtScore")
	self._txtScoreTitle = self:getTxt("txtScoreTitle")
	self._singleLine = self:getGo("detailCol/content"):GetComponent(ComponentType.UILayoutSingleLine)
end

function NvdiNorDetailView:bindEvents()
	NvdiNorDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function NvdiNorDetailView:unbindEvents()
	NvdiNorDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function NvdiNorDetailView:onExit()
	NvdiNorDetailView.super.onExit(self)
end

function NvdiNorDetailView:onEnter()
	NvdiNorDetailView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._dataBitId = checknumber(params[2])
	self._curFightScore = checknumber(params[3])
	self._immunityAttackCount = checknumber(params[4])

	self:_onUpdate()
end

function NvdiNorDetailView:_onUpdate()
	self._txtScoreTitle.text = "本次挑战总分"
	self._txtScore.text = self._curFightScore

	local cfg = NvdiChallengeConfig.instance:getActivityCfgById(self._activityId) or {}

	goutil.clearChildren(self._cellParent.transform)

	local score = checknumber(cfg.normalClgWinBaseScore)

	self:_updateScoreDetailCell("击败敌阵", 1, score)

	local buffScore = checknumber(cfg.normalClgBuffCounterScoreUnit)

	self:_updateScoreDetailCell("免疫攻击", self._immunityAttackCount, buffScore)
	self._singleLine:Layout()
end

function NvdiNorDetailView:_updateScoreDetailCell(name, count, perScore)
	local cellName = "cell_" .. self._cellParent.transform.childCount + 1
	local cell = goutil.cloneAndSetParent(self._detailScrollercell, self._cellParent.transform, cellName)

	goutil.setActive(cell, true)

	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtCond = goutil.findChildTextComponent(mainGo, "txtCond")
	local txtSouilCount = goutil.findChildTextComponent(mainGo, "txtSouilCount")

	txtName.text = name
	txtCond.text = string.format("%s次", count)

	local color = ""
	local score = perScore * count

	if score > 0 then
		color = GameEnum.ColorConst.Green
	elseif score <= 0 then
		color = GameEnum.ColorConst.Red
	end

	txtSouilCount.text = string.format("<color=%s>%s</color>", color, score)
end

function NvdiNorDetailView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return NvdiNorDetailView
