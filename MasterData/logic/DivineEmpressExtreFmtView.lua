-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressExtreFmtView.lua

module("logic.extensions.divineempress.view.DivineEmpressExtreFmtView", package.seeall)

local DivineEmpressExtreFmtView = class("DivineEmpressExtreFmtView", ViewComponent)

function DivineEmpressExtreFmtView:ctor()
	DivineEmpressExtreFmtView.super.ctor(self)
end

function DivineEmpressExtreFmtView:unbindEvents()
	DivineEmpressExtreFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSelect)
end

function DivineEmpressExtreFmtView:bindEvents()
	DivineEmpressExtreFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickSelect, self)
end

function DivineEmpressExtreFmtView:buildUI()
	DivineEmpressExtreFmtView.super.buildUI(self)

	self._selectView = self:getGo("selectView")
	self._btnSelect = self:getGo("btnSelect")
	self._btnSure = self:getGo("selectView/btnSure")
	self._btnCancel = self:getGo("selectView/btnCancel")
	self._buffTableview = self:getGo("selectView/buffTableview")
	self._buffTablecell = self:getGo("selectView/buffTablecell")
	self._buffTableList = ScrollerList.create(self._buffTableview, self._buffTablecell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._txtBuffDesc = self:getTxt("selectView/txtBuffDesc")
	self._debuffTableview = self:getGo("selectView/debuffTableview")
	self._debuffTablecell = self:getGo("selectView/debuffTablecell")
	self._debuffTableList = ScrollerList.create(self._debuffTableview, self._debuffTablecell, GameUtil.handler(self._updateDebuffCell, self), GameUtil.handler(self._clearDebuffCell, self))
	self._txtDebuffDesc = self:getTxt("selectView/txtDebuffDesc")
	self._txtScore = self:getTxt("selectView/txtScore")
	self._txtScoreDesc = self:getTxt("selectView/txtScoreDesc")
end

function DivineEmpressExtreFmtView:onExit()
	DivineEmpressExtreFmtView.super.onExit(self)
end

function DivineEmpressExtreFmtView:onEnter()
	DivineEmpressExtreFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	self:_showBuffInfo()
end

function DivineEmpressExtreFmtView:_showBuffInfo()
	self._selectBuffId = self._fmtMo.selectBuffId
	self._selectDebuffId = self._fmtMo.selectDebuffId

	self:_refreshView()
	GameUtil.SetActive(self._selectView, true)
	GameUtil.SetActive(self._btnSelect, false)
end

function DivineEmpressExtreFmtView:_refreshView()
	local activityId = self._fmtMo.activityId
	local buffCfgs = DivineEmpressConfig.instance:getBuffCfgs(activityId)

	self._buffTableList:reloadData(buffCfgs)

	local debuffCfgs = DivineEmpressConfig.instance:getDebuffCfgs(activityId)

	self._debuffTableList:reloadData(debuffCfgs)

	local selectBuffCfg = DivineEmpressConfig.instance:getBuffCfg(activityId, self._selectBuffId)

	self._txtBuffDesc.text = selectBuffCfg.desc

	local selectDebuffCfg = DivineEmpressConfig.instance:getDebuffCfg(activityId, self._selectDebuffId)

	self._txtDebuffDesc.text = selectDebuffCfg.desc

	local totalScore = selectBuffCfg.buffScore + selectDebuffCfg.buffScore
	local scoreCfg = DivineEmpressController.instance:getScoreCfgByTotalScore(activityId, totalScore)

	self._txtScore.text = totalScore
	self._txtScoreDesc.text = langPara("破阵，且免疫次数大于等于%d", scoreCfg.immunityTimes)
end

function DivineEmpressExtreFmtView:_updateBuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local txtNumber = goutil.findChildTextComponent(go, "txtNumber")
	local useTag = goutil.findChild(go, "useTag")
	local select = goutil.findChild(go, "select")

	txtNumber.text = data.buffScore

	GameUtil.SetActive(select, data.buffId == self._selectBuffId)
	GameUtil.SetActive(useTag, DivineEmpressModel.instance:isBuffUsed(self._fmtMo.activityId, data.buffId))
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickSelectCard(true, data.buffId)
	end)
end

function DivineEmpressExtreFmtView:_clearBuffCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function DivineEmpressExtreFmtView:_updateDebuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local txtNumber = goutil.findChildTextComponent(go, "txtNumber")
	local useTag = goutil.findChild(go, "useTag")
	local select = goutil.findChild(go, "select")

	txtNumber.text = data.buffScore

	GameUtil.SetActive(select, data.buffId == self._selectDebuffId)
	GameUtil.SetActive(useTag, DivineEmpressModel.instance:isDebuffUsed(self._fmtMo.activityId, data.buffId))
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickSelectCard(false, data.buffId)
	end)
end

function DivineEmpressExtreFmtView:_clearDebuffCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function DivineEmpressExtreFmtView:_onClickSure()
	GameUtil.SetActive(self._selectView, false)
	GameUtil.SetActive(self._btnSelect, true)

	self._fmtMo.selectBuffId = self._selectBuffId
	self._fmtMo.selectDebuffId = self._selectDebuffId
end

function DivineEmpressExtreFmtView:_onClickCancel()
	GameUtil.SetActive(self._selectView, false)
	GameUtil.SetActive(self._btnSelect, true)
end

function DivineEmpressExtreFmtView:_onClickSelectCard(isBuff, buffId)
	if isBuff == true then
		if not DivineEmpressModel.instance:isBuffUsed(self._fmtMo.activityId, buffId) then
			self._selectBuffId = buffId
		else
			FloatWordMgr.instance:show(lang("已使用该塔罗牌"))
		end
	elseif not DivineEmpressModel.instance:isDebuffUsed(self._fmtMo.activityId, buffId) then
		self._selectDebuffId = buffId
	else
		FloatWordMgr.instance:show(lang("已使用该塔罗牌"))
	end

	self:_refreshView()
end

function DivineEmpressExtreFmtView:_onClickSelect()
	self:_showBuffInfo()
end

return DivineEmpressExtreFmtView
