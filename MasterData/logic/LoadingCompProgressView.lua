-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/component/LoadingCompProgressView.lua

module(..., package.seeall)

local LoadingCompProgressView = class("LoadingCompProgressView", LoadingCompBase)

function LoadingCompProgressView:onInit()
	self._progress = self._loading.progress
end

function LoadingCompProgressView:onBuildView(mainGO)
	LoadingCompProgressView.super.onBuildView(self, mainGO)

	self._tipsMsg = goutil.findChildTextComponent(mainGO, "content/tipsMsg")
	self._percentSlider = Framework.SliderAdapter.GetFrom(mainGO, "content/progressBar")

	self:onReset()
end

function LoadingCompProgressView:onEnter()
	self:_setEvent(true)
end

function LoadingCompProgressView:onExit()
	self:_setEvent(false)
end

function LoadingCompProgressView:onReset()
	self:_onProgressUpdate()
end

function LoadingCompProgressView:_onProgressUpdate()
	self._percentSlider:SetValue(self._progress:getCurProgress())
end

function LoadingCompProgressView:_onLoadingTipsUpdate(tips)
	self._tipsMsg.text = tips
end

function LoadingCompProgressView:_setEvent(add)
	if add then
		self._progress:addListener(LoadingNotify.OnProgressUpdate, self._onProgressUpdate, self)
		self._progress:addListener(LoadingNotify.OnLoadingTipsUpdate, self._onLoadingTipsUpdate, self)
	else
		self._progress:removeListener(LoadingNotify.OnProgressUpdate, self._onProgressUpdate, self)
		self._progress:removeListener(LoadingNotify.OnLoadingTipsUpdate, self._onLoadingTipsUpdate, self)
	end
end

return LoadingCompProgressView
