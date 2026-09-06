-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/view/OriginWelfareRedStarGodView.lua

module("logic.extensions.originwelfare.view.OriginWelfareRedStarGodView", package.seeall)

local OriginWelfareRedStarGodView = class("OriginWelfareRedStarGodView", ViewComponent)

function OriginWelfareRedStarGodView:ctor()
	OriginWelfareRedStarGodView.super.ctor(self)
end

function OriginWelfareRedStarGodView:unbindEvents()
	OriginWelfareRedStarGodView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginWelfareRedStarGodView:bindEvents()
	OriginWelfareRedStarGodView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function OriginWelfareRedStarGodView:buildUI()
	OriginWelfareRedStarGodView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCellTip, self), GameUtil.handler(self._clearCellTip, self))
end

function OriginWelfareRedStarGodView:onExit()
	OriginWelfareRedStarGodView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginWelfareRedStarGodView:onEnter()
	OriginWelfareRedStarGodView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 538001
	end

	self._actCfg = OriginWelfareConfig.instance:getActCfg(self._activityId)
	self._redGodJumpToCfgs = OriginWelfareConfig.instance:getRedGodJumpToCfgs(self._activityId)
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self._scrollList:reloadData(self._redGodJumpToCfgs)
end

function OriginWelfareRedStarGodView:_updateCellTip(view, cell, data)
	local btnJump = goutil.findChild(cell, "btnJump")
	local txtName = goutil.findChildTextComponent(btnJump, "txtName")
	local txtTip = goutil.findChildTextComponent(cell, "tip/txtTip")

	txtName.text = data.jumpToName
	txtTip.text = data.jumpToTipStr

	GameUtil.addClickHandler(btnJump, GameUtil.handler(self._onClickJump, self, data.jumpTo))
end

function OriginWelfareRedStarGodView:_clearCellTip(cell)
	local btnJump = goutil.findChild(cell, "btnJump")

	GameUtil.rmClickHandler(btnJump)
end

function OriginWelfareRedStarGodView:_onClickJump(jumpTo)
	GotoMgr.gotoByString(jumpTo)
end

function OriginWelfareRedStarGodView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return OriginWelfareRedStarGodView
