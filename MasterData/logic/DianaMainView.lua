-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/diana/DianaMainView.lua

module("logic.extensions.lailisi.view.diana.DianaMainView", package.seeall)

local DianaMainView = class("DianaMainView", LailisiMainView)

function DianaMainView:ctor()
	DianaMainView.super.ctor(self)
end

function DianaMainView:unbindEvents()
	DianaMainView.super.unbindEvents(self)
	self._btnReturn:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnRank:RemoveClickListener()
end

function DianaMainView:bindEvents()
	DianaMainView.super.bindEvents(self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnShop:AddClickListener(self._onClickShop, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
end

function DianaMainView:buildUI()
	DianaMainView.super.buildUI(self)

	self._btnReturn = self:getBtn("btnReturn")
	self._btnShop = self:getBtn("btnShop")
	self._btnRank = self:getBtn("btnRank")
end

function DianaMainView:_setActivityId()
	self._activityId = checknumber(LailisiConfig.instance:getCommonCfg("daianna_Id"))
end

function DianaMainView:_showEffect()
	LailisiController.instance:showUIEff(self.mainGO, "fx_ui_xjs_llstz.prefab", self)
end

function DianaMainView:_onClickReturn()
	GotoMgr.gotoByString(self._challengeCfg.jump_diamond)
end

function DianaMainView:_onClickShop()
	GotoMgr.gotoByString(self._challengeCfg.jump_shop)
end

function DianaMainView:_onClickRank()
	GotoMgr.gotoByString(self._challengeCfg.jump_rank)
end

return DianaMainView
