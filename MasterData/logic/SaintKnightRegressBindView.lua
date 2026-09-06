-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressBindView.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressBindView", package.seeall)

local SaintKnightRegressBindView = class("SaintKnightRegressBindView", ViewComponent)

function SaintKnightRegressBindView:ctor()
	SaintKnightRegressBindView.super.ctor(self)
end

function SaintKnightRegressBindView:unbindEvents()
	SaintKnightRegressBindView.super.unbindEvents(self)
	self._inputComp:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnBind)
	GameUtil.rmClickHandler(self._btnClose)
end

function SaintKnightRegressBindView:bindEvents()
	SaintKnightRegressBindView.super.bindEvents(self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	GameUtil.addClickHandler(self._btnBind, self._onClickBtnSold, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SaintKnightRegressBindView:buildUI()
	SaintKnightRegressBindView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._inputComp = self:getInput("InputC_Search")
	self._btnBind = self:getGo("btnBind")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableList:setCenterMode(true)
end

function SaintKnightRegressBindView:onExit()
	SaintKnightRegressBindView.super.onExit(self)
end

function SaintKnightRegressBindView:onEnter()
	SaintKnightRegressBindView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SaintKnightRegressBindCodeRes, self.close, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._inviteStr = params[2]

	self._inputComp:SetText(self._inviteStr)

	local activityCfg = SaintKnightRegressConfig.instance:getActivityCfg(self._activityId)
	local prizeArr = string.split(activityCfg.bindCodePrize, "#")

	self._tableList:reloadData(prizeArr)
end

function SaintKnightRegressBindView:_inputValueChanged(text)
	local subStr = string.sub(text, 1, 150)

	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = subStr

	self._inputComp:SetText(subStr)
end

function SaintKnightRegressBindView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local receivedGo = goutil.findChild(go, "received")

	GameUtil.SetActive(receivedGo, SaintKnightRegressModel.instance:getBindInviteCode(self._activityId) ~= nil)
	MaterialMgr.setCellByCfg(data, con)
end

function SaintKnightRegressBindView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function SaintKnightRegressBindView:_onClickBtnSold()
	if not SaintKnightRegressModel.instance:getIsRegressPlayer(self._activityId) then
		FloatWordMgr.instance:show("非回归玩家，绑定邀请码失败")
		self:close()

		return
	elseif SaintKnightRegressModel.instance:getBindInviteCode(self._activityId) ~= nil then
		FloatWordMgr.instance:show("已领取过绑定奖励，绑定邀请码失败")
		self:close()

		return
	end

	local result = string.match(self._lastInputTxt, "%【(.-)%】")

	if result then
		self._lastInputTxt = result
	end

	if string.nilorempty(self._lastInputTxt) then
		FloatWordMgr.instance:show("分享码不存在，再仔细检查下~")

		return
	end

	SaintKnightRegressAgent.instance:sendPM_SaintKnightRegressBindCodeReq(self._activityId, self._lastInputTxt)
end

return SaintKnightRegressBindView
