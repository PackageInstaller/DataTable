-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgNormalBuffView.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgNormalBuffView", package.seeall)

local DivineZhongFeiClgNormalBuffView = class("DivineZhongFeiClgNormalBuffView", ViewComponent)

function DivineZhongFeiClgNormalBuffView:ctor()
	DivineZhongFeiClgNormalBuffView.super.ctor(self)
end

function DivineZhongFeiClgNormalBuffView:unbindEvents()
	DivineZhongFeiClgNormalBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineZhongFeiClgNormalBuffView:bindEvents()
	DivineZhongFeiClgNormalBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineZhongFeiClgNormalBuffView:buildUI()
	DivineZhongFeiClgNormalBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._scoreTableCell = self:getGo("scoreTableCell")
	self._scoreTableView = self:getGo("scoreTableView")
	self._scoreTableList = ScrollerList.create(self._scoreTableView, self._scoreTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineZhongFeiClgNormalBuffView:onExit()
	DivineZhongFeiClgNormalBuffView.super.onExit(self)
end

function DivineZhongFeiClgNormalBuffView:onEnter()
	DivineZhongFeiClgNormalBuffView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local list = DivineZhongFeiClgConfig.instance:getNormalBattleBuffCfgs(self._activityId)

	self._scoreTableList:reloadData(list)
end

function DivineZhongFeiClgNormalBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgChange = goutil.findChildComponent(go, "bg", ComponentType.UIImageColorChange)
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local score = checknumber(data.damage)

	txtScore.text = langPara("%s", MmUtil.formatNumber(score, MmUtil.Units_CN, 0))
	txtDesc.text = data.desc

	if data.id % 2 == 1 then
		bgChange:SetState(0)
	else
		bgChange:SetState(1)
	end
end

function DivineZhongFeiClgNormalBuffView:_clearCell(cell)
	return
end

return DivineZhongFeiClgNormalBuffView
