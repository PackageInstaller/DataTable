-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmEntireFeelView.lua

module("logic.extensions.kingmengmeng.view.KingmmEntireFeelView", package.seeall)

local KingmmEntireFeelView = class("KingmmEntireFeelView", ViewComponent)

function KingmmEntireFeelView:ctor()
	KingmmEntireFeelView.super.ctor(self)
end

function KingmmEntireFeelView:buildUI()
	KingmmEntireFeelView.super.buildUI(self)

	self._btnReset = self:getBtn("btn/btnReset")
	self._btnSure = self:getBtn("btn/btnSure")
	self._txtDesc = self:getTxt("txtDesc")
	self._imgCoin = self:getGo("imgCoin")
	self._txtNum = MaterialMgr.findGraphicText(self.mainGO, "imgCoin/txtNum")
end

function KingmmEntireFeelView:bindEvents()
	KingmmEntireFeelView.super.bindEvents(self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function KingmmEntireFeelView:unbindEvents()
	KingmmEntireFeelView.super.unbindEvents(self)
	self._btnReset:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function KingmmEntireFeelView:onEnter()
	KingmmEntireFeelView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_initCost()
	self:_initDesc()
	self:_initBtn()
end

function KingmmEntireFeelView:onExit()
	KingmmEntireFeelView.super.onExit(self)
end

function KingmmEntireFeelView:_onClickReset()
	KingmmController.instance:openFeelView(self._activityId)
	self:close()
end

function KingmmEntireFeelView:_onClickSure()
	self:close()
end

function KingmmEntireFeelView:_initCost()
	local curTime = KingmmModel.instance:getTodayResetTimes()
	local cfg = KingmmConfig.instance:getResetCfg(self._activityId, curTime + 1)

	if not cfg then
		self._txtNum.text = ""

		return
	end

	local matType, id, matNum = MaterialMgr.getMatParams(cfg.cost)

	self._txtNum.text = string.format("<quad name=%d:%d|icon size=26 width=1 offsetY=-8/> %d", matType, id, matNum)
end

function KingmmEntireFeelView:_initDesc()
	self._txtDesc.text = KingmmController.instance:getLevelDesc(self._activityId)
end

function KingmmEntireFeelView:_initBtn()
	local maxFeelNum = KingmmController.instance:getMaxFeelNum(self._activityId)
	local curTime = KingmmModel.instance:getTodayResetTimes()
	local isNoneNum = maxFeelNum <= curTime

	goutil.setActive(self._btnReset.gameObject, not isNoneNum)
	goutil.setActive(self._imgCoin, not isNoneNum)
end

return KingmmEntireFeelView
