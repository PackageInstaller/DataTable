-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lianjinmm/LianjinMainView.lua

module("logic.extensions.timelimitedchallenge.view.lianjinmm.LianjinMainView", package.seeall)

local LianjinMainView = class("LianjinMainView", AthenaMainView)

function LianjinMainView:buildUI()
	LianjinMainView.super.buildUI(self)

	self._btnShenYao = self:getBtn("btnShenYao")
	self._btnShop = self:getBtn("btnShop")
	self._btnExchange = self:getBtn("btnExchange")
	self._txtName = self:getTxt("petInfo/txtName")
	self._time = self:getTxt("time/txt")
end

function LianjinMainView:bindEvents()
	LianjinMainView.super.bindEvents(self)
	self._btnShenYao:AddClickListener(self._onClickBtnShenYao, self)
	self._btnShop:AddClickListener(self._onClickBtnShop, self)
	self._btnExchange:AddClickListener(self._onClickBtnExchange, self)
end

function LianjinMainView:unbindEvents()
	LianjinMainView.super.unbindEvents(self)
	self._btnShenYao:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
end

function LianjinMainView:_getChallengeId()
	return AthenaModel.CHALLENGEID_LIANJIN
end

function LianjinMainView:_onClickWit()
	UIStateManager.instance:push(ViewName.LianjinForceView, self._challengeId)
end

function LianjinMainView:_onClickForce()
	UIStateManager.instance:push(ViewName.LianjinWitView, self._challengeId)
end

function LianjinMainView:_onClickBtnShenYao()
	GotoMgr.gotoByString(self._cfg and self._cfg.jumpShenYao)
end

function LianjinMainView:_onClickBtnShop()
	GotoMgr.gotoByString(self._cfg and self._cfg.jumpShop)
end

function LianjinMainView:_onClickBtnExchange()
	GotoMgr.gotoByString(self._cfg and self._cfg.jumpExchange)
end

function LianjinMainView:_onClickRank()
	GotoMgr.gotoByString("func#618#13007")
end

function LianjinMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "lianjinmainview_rule")
end

function LianjinMainView:onEnter()
	LianjinMainView.super.onEnter(self)

	local timeLimitedCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, timeLimitedCfg.raceId)
end

function LianjinMainView:_clickBtn()
	if AthenaModel.instance:getBattleType(self._challengeId) == 2 then
		self:_onClickWit()
	elseif AthenaModel.instance:getBattleType(self._challengeId) == 1 then
		self:_onClickForce()
	end
end

return LianjinMainView
