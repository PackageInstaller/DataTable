-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/component/LoadingCompBase.lua

module(..., package.seeall)

local LoadingCompBase = class("LoadingCompBase")

function LoadingCompBase:ctor(loading)
	self._loading = loading

	NotifyDispatcher.extend(self)
end

function LoadingCompBase:onBuildView(mainGO)
	return
end

function LoadingCompBase:onInit()
	return
end

function LoadingCompBase:onEnter()
	return
end

function LoadingCompBase:onEnterFinish()
	return
end

function LoadingCompBase:onHide()
	return
end

function LoadingCompBase:onExit()
	return
end

function LoadingCompBase:onReset()
	return
end

function LoadingCompBase:onDestroy()
	return
end

return LoadingCompBase
