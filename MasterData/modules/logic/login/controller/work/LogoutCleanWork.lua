-- chunkname: @modules/logic/login/controller/work/LogoutCleanWork.lua

module("modules.logic.login.controller.work.LogoutCleanWork", package.seeall)

local LogoutCleanWork = class("LogoutCleanWork", BaseWork)

function LogoutCleanWork:ctor()
	return
end

function LogoutCleanWork:onStart(context)
	LogoutCleanWork._tryFuncList_ = LogoutCleanWork._tryFuncList_ or {
		function()
			Activity114Model.instance:clearFlow()
		end,
		function()
			GuideStepController.instance:clearStep()
		end,
		function()
			UIBlockMgr.instance:endAll()
		end,
		function()
			UIBlockHelper.instance:clearAll()
		end,
		function()
			UIBlockMgrExtend.setNeedCircleMv(true)
		end,
		function()
			StoryController.instance:closeStoryView()
		end,
		function()
			ViewMgr.instance:closeAllViews()
		end,
		function()
			module_views_preloader.stopPreload()
		end,
		function()
			ModuleMgr.instance:reInit()
		end,
		function()
			GameSceneMgr.instance:closeScene(nil, nil, nil, true)
		end,
		function()
			SettingsVoicePackageController.instance:cancelDownload()
		end,
		function()
			VersionActivityBaseController.instance:clear()
		end,
		function()
			ActivityStageHelper.clear()
		end,
		function()
			PlayerModel.instance:logout()
		end,
		function()
			CommonDragHelper.instance:clear()
		end,
		function()
			RougeController.instance:clearAllData()
		end,
		function()
			Rouge2_Controller.instance:clearAllData()
		end
	}

	local tryFuncList = LogoutCleanWork._tryFuncList_
	local _xpcall = xpcall
	local _TRACKBACK = __G__TRACKBACK__

	for _, func in ipairs(tryFuncList) do
		_xpcall(func, _TRACKBACK, self)
	end

	TaskDispatcher.runDelay(self._delayDone, self, 0.1)
end

function LogoutCleanWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function LogoutCleanWork:_delayDone()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)
	self:onDone(true)
end

return LogoutCleanWork
