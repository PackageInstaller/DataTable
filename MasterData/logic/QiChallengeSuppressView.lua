-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeSuppressView.lua

module("logic.extensions.qichallenge.view.QiChallengeSuppressView", package.seeall)

local QiChallengeSuppressView = class("QiChallengeSuppressView", ViewComponent)

function QiChallengeSuppressView:buildUI()
	QiChallengeSuppressView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._suppressPetTable = self:getGo("suppressPet/tableview")
	self._suppressPetCell = self:getGo("suppressPet/item")
	self._emptyGo = self:getGo("empty")
end

function QiChallengeSuppressView:bindEvents()
	QiChallengeSuppressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBlock, self._onClickBlock, self)
end

function QiChallengeSuppressView:unbindEvents()
	QiChallengeSuppressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBlock)
end

function QiChallengeSuppressView:onEnter()
	QiChallengeSuppressView.super.onEnter(self)

	self._suppressPetList = ScrollerList.create(self._suppressPetTable, self._suppressPetCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local params = self:getOpenParam()

	self._activityId = params[1]

	local isFromFmt = params[2]

	self._activityCfg = QiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._debuffCfg = QiChallengeConfig.instance:getDebuffCfgs(self._activityCfg.deBuffPlanId)

	local petList = QiChallengeModel.instance:getHardChallengePets()

	self._suppressPetList:reloadData(petList)
	GameUtil.SetActive(self._emptyGo, not petList or #petList <= 0)

	self._txtTitle.text = not isFromFmt and lang("已通关的精灵列表") or lang("减益精灵")
end

function QiChallengeSuppressView:onExit()
	QiChallengeSuppressView.super.onExit(self)
	self._suppressPetList:dispose()
end

function QiChallengeSuppressView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtDebuff = goutil.findChildTextComponent(go, "txtDebuff")

	MaterialMgr.resetAll(con)

	local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, con)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	local raceDebuffCfg = QiChallengeConfig.instance:getBuff(self._debuffCfg[(data.time > #self._debuffCfg or nil) and #self._debuffCfg].buffId)

	txtDebuff.text = raceDebuffCfg.desc
	txtNum.text = langPara("上阵次数：%d", data.time)
end

function QiChallengeSuppressView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

return QiChallengeSuppressView
