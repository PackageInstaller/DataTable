-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/DivineluoshiqimainView.lua

module("logic.extensions.xiunuobrotherhood.view.copy.DivineluoshiqimainView", package.seeall)

local DivineluoshiqimainView = class("DivineluoshiqimainView", XiuNuoBrotherhoodMainView)

function DivineluoshiqimainView:ctor()
	self._selectViewName = ViewName.DivineluoshiqiselectView
end

function DivineluoshiqimainView:buildUI()
	DivineluoshiqimainView.super.buildUI(self)

	self._btnTehui = self:getBtn("btnTehui")
	self._btnBuff = self:getBtn("btnBuff")
	self._buffText = self:getTxt("btnBuff/txtBuff")
	self._buffRed = self:getGo("btnBuff/redPoint")
end

function DivineluoshiqimainView:bindEvents()
	DivineluoshiqimainView.super.bindEvents(self)
	self._btnTehui:AddClickListener(self._onClickbtnTehui, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function DivineluoshiqimainView:unbindEvents()
	DivineluoshiqimainView.super.unbindEvents(self)
	self._btnTehui:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnBuff)
end

function DivineluoshiqimainView:onEnter()
	DivineluoshiqimainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.XiuNuoBrotherhoodGetInfo, self._updateBuffUI, self)
	self.addGEvent(self, GlobalNotify.XiuNuoBrotherhoodUpgradeBuffRes, self._updateBuffUI, self)
	XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodInfoReq(self._activityId)
end

function DivineluoshiqimainView:initData()
	self._activityId = 208004
	self._actCfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(self._activityId)
end

function DivineluoshiqimainView:_setJumpViewNames()
	XiuNuoBrotherhoodModel.instance.instance:setJumpViewNames(ViewName.DivineluoshiqimainView, nil, ViewName.DivineluoshiqigameView)
end

function DivineluoshiqimainView:_onClickbtnQuanEFan()
	GotoMgr.gotoByString(self._actCfg.params.btnQuanEFanJump)
end

function DivineluoshiqimainView:_onClickbtnTehui()
	GotoMgr.gotoByString(self._actCfg.params.btnTehuiJump)
end

function DivineluoshiqimainView:_onClickBuff()
	local info = XiuNuoBrotherhoodModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local todayCheckIn = info.todayCheckIn

	if todayCheckIn then
		FloatWordMgr.instance:show("今日加成已生效")

		return
	end

	XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodUpgradeBuffReq(self._activityId)
end

function DivineluoshiqimainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.params.btnRankJump)
end

function DivineluoshiqimainView:_updateBuffUI()
	local info = XiuNuoBrotherhoodModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local signInBuffLv = info.signInBuffLv
	local todayCheckIn = info.todayCheckIn
	local buffCfg = XiuNuoBrotherhoodConfig.instance:getSignBuffCfg(self._activityId, signInBuffLv)

	self._buffText.text = buffCfg == nil and "未获得加成" or buffCfg.desc

	self._buffRed:SetActive(not todayCheckIn)
end

return DivineluoshiqimainView
