-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluoMainView.lua

module("logic.extensions.lailisi.view.xingluo.XingluoMainView", package.seeall)

local XingluoMainView = class("XingluoMainView", LailisiMainView)

function XingluoMainView:ctor()
	XingluoMainView.super.ctor(self)
end

function XingluoMainView:unbindEvents()
	XingluoMainView.super.unbindEvents(self)
	self._wishBtn:RemoveClickListener()
	self._btnLottery:RemoveClickListener()
end

function XingluoMainView:bindEvents()
	XingluoMainView.super.bindEvents(self)
	self._wishBtn:AddClickListener(self._onClickWish, self)
	self._btnLottery:AddClickListener(self._onClickLottery, self)
end

function XingluoMainView:buildUI()
	XingluoMainView.super.buildUI(self)

	self._wishBtn = self:getBtn("wishBtn")
	self._btnLottery = self:getBtn("btnLottery")
end

function XingluoMainView:_setActivityId()
	self._activityId = checknumber(LailisiConfig.instance:getCommonCfg("xingluo_Id"))

	LailisiModel.instance:setFinalActIdActivityId(self._activityId)
end

function XingluoMainView:_showEffect()
	return
end

function XingluoMainView:_onClickWish()
	GotoMgr.gotoByString(self._challengeCfg.jump_shop)
end

function XingluoMainView:_onClickLottery()
	GotoMgr.gotoByString(self._challengeCfg.jump_lottery)
end

return XingluoMainView
