-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originbinglingwang/view/OriginbinglingwangmainView.lua

module("logic.extensions.originbinglingwang.view.OriginbinglingwangmainView", package.seeall)

local OriginbinglingwangmainView = class("OriginbinglingwangmainView", YinZhiClgMainView)

function OriginbinglingwangmainView:ctor()
	OriginbinglingwangmainView.super.ctor(self)
end

function OriginbinglingwangmainView:unbindEvents()
	OriginbinglingwangmainView.super.unbindEvents(self)
end

function OriginbinglingwangmainView:bindEvents()
	OriginbinglingwangmainView.super.bindEvents(self)
end

function OriginbinglingwangmainView:buildUI()
	OriginbinglingwangmainView.super.buildUI(self)

	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/redPoint")
end

function OriginbinglingwangmainView:onExit()
	OriginbinglingwangmainView.super.onExit(self)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginbinglingwangmainView:onEnter()
	OriginbinglingwangmainView.super.onEnter(self)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function OriginbinglingwangmainView:_onClickFight()
	UIStateManager.instance:push(ViewName.OriginbinglingwangstageView, self._activityId)
end

function OriginbinglingwangmainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

return OriginbinglingwangmainView
