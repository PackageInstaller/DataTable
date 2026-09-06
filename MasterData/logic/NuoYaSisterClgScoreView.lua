-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgScoreView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgScoreView", package.seeall)

local NuoYaSisterClgScoreView = class("NuoYaSisterClgScoreView", ViewComponent)

function NuoYaSisterClgScoreView:ctor()
	NuoYaSisterClgScoreView.super.ctor(self)
end

function NuoYaSisterClgScoreView:unbindEvents()
	NuoYaSisterClgScoreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NuoYaSisterClgScoreView:bindEvents()
	NuoYaSisterClgScoreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NuoYaSisterClgScoreView:buildUI()
	NuoYaSisterClgScoreView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NuoYaSisterClgScoreView:onExit()
	NuoYaSisterClgScoreView.super.onExit(self)
end

function NuoYaSisterClgScoreView:onEnter()
	NuoYaSisterClgScoreView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local day = NuoYaSisterClgModel.instance:getCommonDay(self._activityId)
	local cfg = NuoYaSisterClgConfig.instance:getCommonDamageCfg(self._activityId, day)

	self._tableList:reloadData(cfg)
end

function NuoYaSisterClgScoreView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtIndex = goutil.findChildTextComponent(go, "txtIndex")
	local txtDamage = goutil.findChildTextComponent(go, "txtDamage")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	txtIndex.text = data.id
	txtDamage.text = langPara("%d~%d", data.range[1], data.range[2])
	txtScore.text = data.addScore
end

function NuoYaSisterClgScoreView:_clearCell(cell)
	return
end

return NuoYaSisterClgScoreView
