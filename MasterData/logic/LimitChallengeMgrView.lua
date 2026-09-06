-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/limit/LimitChallengeMgrView.lua

module("logic.extensions.legend.view.limit.LimitChallengeMgrView", package.seeall)

local LimitChallengeMgrView = class("LimitChallengeMgrView", ViewComponent)

function LimitChallengeMgrView:ctor()
	LimitChallengeMgrView.super.ctor(self)

	self._curClass = nil
end

function LimitChallengeMgrView:buildUI()
	local root = self:getGo("root")

	self._prefabLoader = PrefabLoader.Get(root)
end

function LimitChallengeMgrView:destroyUI()
	return
end

function LimitChallengeMgrView:bindEvents()
	return
end

function LimitChallengeMgrView:unbindEvents()
	return
end

function LimitChallengeMgrView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.CloseLimitChallengeShow, self._onClickClose, self)

	self._id = self:getFirstParam()
	self._cfg = TimeLimitedConfig.instance:getCfgById(self._id)

	local url = "ui/views/legend/limit/" .. self._cfg.viewName .. ".prefab"

	self._prefabLoader:load(url, self._onPrefabLoaded, self, true)
end

function LimitChallengeMgrView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CloseLimitChallengeShow, self._onClickClose, self)
	self._curClass:unbindEvents()
	self._curClass:onExit()
	self._prefabLoader:clear()

	self._curClass = nil
end

function LimitChallengeMgrView:_onClickClose()
	self:close()
end

function LimitChallengeMgrView:_onPrefabLoaded(loader)
	local go = self._prefabLoader:getInst()

	self._curClass = Framework.LuaComponentContainer.Add(go, LimitChallengeShowView)

	self._curClass:buildUI(go)
	self._curClass:bindEvents()
	self._curClass:onEnter(self._id)
end

return LimitChallengeMgrView
