-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/view/MakingMoonCakePrizeView.lua

module("logic.extensions.makingmooncake.view.MakingMoonCakePrizeView", package.seeall)

local MakingMoonCakePrizeView = class("MakingMoonCakePrizeView", ViewComponent)

function MakingMoonCakePrizeView:ctor()
	MakingMoonCakePrizeView.super.ctor(self)
end

function MakingMoonCakePrizeView:unbindEvents()
	MakingMoonCakePrizeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function MakingMoonCakePrizeView:bindEvents()
	MakingMoonCakePrizeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function MakingMoonCakePrizeView:buildUI()
	MakingMoonCakePrizeView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._score = self:getTxt("score/value")
	self._prize = self:getGo("prize/item")
end

function MakingMoonCakePrizeView:onExit()
	MakingMoonCakePrizeView.super.onExit(self)
	MaterialMgr.resetAll(self._prize)
	UIStateManager.instance:popByName(ViewName.MakingMoonCakeView)
end

function MakingMoonCakePrizeView:onEnter()
	MakingMoonCakePrizeView.super.onEnter(self)

	local score = self:getFirstParam()

	self._score.text = score

	local scorePrizeCfg = MakingMoonCakeConfig.instance:getParamByKey("SCORE_PRIZE")
	local matType, id, matNum = MaterialMgr.getMatParams(scorePrizeCfg)

	MaterialMgr.setCellByCfg(matType .. ":" .. id .. ":" .. matNum * score, self._prize)
end

return MakingMoonCakePrizeView
