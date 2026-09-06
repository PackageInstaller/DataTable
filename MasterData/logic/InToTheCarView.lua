-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/InToTheCarView.lua

module("logic.extensions.wishtree.view.InToTheCarView", package.seeall)

local InToTheCarView = class("InToTheCarView", ViewComponent)

function InToTheCarView:ctor()
	InToTheCarView.super.ctor(self)
end

function InToTheCarView:unbindEvents()
	InToTheCarView.super.unbindEvents(self)
end

function InToTheCarView:bindEvents()
	InToTheCarView.super.bindEvents(self)
end

function InToTheCarView:buildUI()
	InToTheCarView.super.buildUI(self)

	self._container = self:getGo("container")
end

function InToTheCarView:onExit()
	InToTheCarView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WishTreeGetInfoRes, self._gotoWhatView, self)
	GlobalDispatcher:removeListener(GlobalNotify.WishTreeClose, self._closeWishTree, self)
	GlobalDispatcher:removeListener(GlobalNotify.WishTreeGoToRunGame, self._gotoRunGame, self)
	GlobalDispatcher:removeListener(GlobalNotify.RunGameClose, self._closeRunGame, self)
	GlobalDispatcher:removeListener(GlobalNotify.RunGameGoToWishTree, self._gotoWishTree, self)
	GlobalDispatcher:removeListener(GlobalNotify.RunGameDemo, self._onClickRunGameDemo, self)
	GlobalDispatcher:removeListener(GlobalNotify.RunGameStart, self._onClickRunGameStart, self)
	GlobalDispatcher:removeListener(GlobalNotify.RunGameShowResult, self._showResult, self)
end

function InToTheCarView:onEnter()
	InToTheCarView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.WishTreeGetInfoRes, self._gotoWhatView, self)
	GlobalDispatcher:addListener(GlobalNotify.WishTreeClose, self._closeWishTree, self)
	GlobalDispatcher:addListener(GlobalNotify.WishTreeGoToRunGame, self._gotoRunGame, self)
	GlobalDispatcher:addListener(GlobalNotify.RunGameClose, self._closeRunGame, self)
	GlobalDispatcher:addListener(GlobalNotify.RunGameGoToWishTree, self._gotoWishTree, self)
	GlobalDispatcher:addListener(GlobalNotify.RunGameDemo, self._onClickRunGameDemo, self)
	GlobalDispatcher:addListener(GlobalNotify.RunGameStart, self._onClickRunGameStart, self)
	GlobalDispatcher:addListener(GlobalNotify.RunGameShowResult, self._showResult, self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.WISH_TREE)

	if actCfg then
		WishTreeController.instance:sendWishTreeInfoReq(actCfg.activityId)
	else
		self:showTabAt(self._container, ViewName.Run2023EnterView)
	end
end

function InToTheCarView:_gotoWhatView()
	GlobalDispatcher:removeListener(GlobalNotify.WishTreeGetInfoRes, self._gotoWhatView, self)

	local isGetAllWish = WishTreeController.instance:isGetAllWish()

	if isGetAllWish then
		self:showTabAt(self._container, ViewName.Run2023EnterView)
	else
		self:showTabAt(self._container, ViewName.WishTreeMainView)
	end
end

function InToTheCarView:_closeWishTree()
	self:close()
end

function InToTheCarView:_gotoRunGame()
	self:showTabAt(self._container, ViewName.Run2023EnterView)
end

function InToTheCarView:_closeRunGame()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.WISH_TREE)

	if actCfg then
		self:showTabAt(self._container, ViewName.WishTreeMainView)
	else
		self:close()
	end
end

function InToTheCarView:_gotoWishTree()
	self:showTabAt(self._container, ViewName.WishTreeMainView)
end

function InToTheCarView:_onClickRunGameDemo()
	self:showTabAt(self._container, ViewName.Run2023MainView, true)
end

function InToTheCarView:_onClickRunGameStart()
	self:showTabAt(self._container, ViewName.Run2023MainView, false)
end

function InToTheCarView:_showResult(changeSetId, prizeStrList, time, isDemo)
	self:showTabAt(self._container, ViewName.Run2023EnterView)
	UIStateManager.instance:push(ViewName.Run2023ResultView, changeSetId, prizeStrList, time, isDemo)
end

return InToTheCarView
