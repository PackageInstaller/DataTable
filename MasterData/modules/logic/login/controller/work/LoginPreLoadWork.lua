-- chunkname: @modules/logic/login/controller/work/LoginPreLoadWork.lua

module("modules.logic.login.controller.work.LoginPreLoadWork", package.seeall)

local LoginPreLoadWork = class("LoginPreLoadWork", BaseWork)
local PreLoadPathList = {
	"ui/viewres/scene/loadingview.prefab",
	"ui/viewres/scene/loadingblackview.prefab",
	"ui/viewres/scene/loadingheadsetview.prefab"
}

function LoginPreLoadWork:onStart(context)
	if not self._loader then
		UIBlockMgr.instance:startBlock(UIBlockKey.Loading)

		self._loader = MultiAbLoader.New()

		self._loader:setPathList(PreLoadPathList)
		self._loader:startLoad(self._onLoaded, self)
	else
		self:_done()
	end
end

function LoginPreLoadWork:_onLoaded()
	UIBlockMgr.instance:endBlock(UIBlockKey.Loading)
	self:_done()
end

function LoginPreLoadWork:_isFirstGuide()
	local finished = GuideModel.instance:isGuideFinish(101)

	finished = finished or GuideController.instance:isForbidGuides()

	return not finished
end

function LoginPreLoadWork:_done()
	local bgGo = gohelper.find("UIRoot/OriginBg")

	gohelper.setActive(bgGo, false)
	ViewMgr.instance:closeView(ViewName.LoginView)

	if self:_isFirstGuide() then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingHeadsetView)
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	self:onDone(true)
end

return LoginPreLoadWork
