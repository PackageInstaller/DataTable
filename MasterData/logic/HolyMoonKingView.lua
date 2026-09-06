-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syyueyingwang/view/HolyMoonKingView.lua

module("logic.extensions.syyueyingwang.view.HolyMoonKingView", package.seeall)

local HolyMoonKingView = class("HolyMoonKingView", DianaMainView)

function HolyMoonKingView:ctor()
	HolyMoonKingView.super.ctor(self)
end

function HolyMoonKingView:unbindEvents()
	HolyMoonKingView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGift, self)
end

function HolyMoonKingView:bindEvents()
	HolyMoonKingView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGift, self._onClickGift, self)
end

function HolyMoonKingView:buildUI()
	HolyMoonKingView.super.buildUI(self)

	self._btnGift = self:getBtn("btnGift")
end

function HolyMoonKingView:_setActivityId()
	local param = checknumber(self:getFirstParam())

	self._activityId = param > 0 and param or checknumber(LailisiConfig.instance:getCommonCfg("holymoonking_Id"))
end

function HolyMoonKingView:_showEffect()
	return
end

function HolyMoonKingView:_onClickGift()
	GotoMgr.gotoByString(self._challengeCfg.jump_mibao)
end

return HolyMoonKingView
