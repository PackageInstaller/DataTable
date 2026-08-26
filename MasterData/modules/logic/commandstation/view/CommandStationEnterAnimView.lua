-- chunkname: @modules/logic/commandstation/view/CommandStationEnterAnimView.lua

module("modules.logic.commandstation.view.CommandStationEnterAnimView", package.seeall)

local CommandStationEnterAnimView = class("CommandStationEnterAnimView", BaseView)

function CommandStationEnterAnimView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationEnterAnimView:addEvents()
	return
end

function CommandStationEnterAnimView:removeEvents()
	return
end

function CommandStationEnterAnimView:_editableInitView()
	self._simagezhuanpan = gohelper.findChildSingleImage(self.viewGO, "#image_zhuanpan")

	local lightMode = WeatherController.instance:getCurLightMode() or WeatherEnum.LightModeDuring

	self._simagezhuanpan:LoadImage(string.format("singlebg/commandstation/enteranim/commandstation_enterzhuanpan_type%s.png", lightMode))
	self:_initCamera()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._OnOpenView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._openPostProcess, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._openPostProcess, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._openPostProcess, self, LuaEventSystem.Low)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_open)
end

function CommandStationEnterAnimView:_initCamera()
	local animator = CameraMgr.instance:getCameraRootAnimator()
	local path = self.viewContainer:getSetting().otherRes[1]

	animator.runtimeAnimatorController = self.viewContainer._abLoader:getAssetItem(path):GetResource()
	animator.enabled = true

	animator:Play("in", 0, 0)
end

function CommandStationEnterAnimView:_OnOpenView(viewName)
	if viewName == ViewName.CommandStationEnterView then
		gohelper.setAsLastSibling(self.viewGO)
		self:closeThis()

		local mainView = ViewMgr.instance:getContainer(ViewName.MainView)

		if mainView then
			mainView:setVisibleInternal(false)
		end
	end
end

function CommandStationEnterAnimView:onOpen()
	TaskDispatcher.cancelTask(self._openPostProcess, self)
	TaskDispatcher.runRepeat(self._openPostProcess, self, 0)
end

function CommandStationEnterAnimView:_openPostProcess()
	PostProcessingMgr.instance:setUIActive(true)
end

function CommandStationEnterAnimView:onOpenFinish()
	CommandStationController.instance:openCommandStationEnterView()
end

function CommandStationEnterAnimView:onClose()
	return
end

function CommandStationEnterAnimView:onCloseFinish()
	local animator = CameraMgr.instance:getCameraRootAnimator()

	animator.runtimeAnimatorController = nil

	TaskDispatcher.cancelTask(self._openPostProcess, self)
	PostProcessingMgr.instance:setUnitPPValue("radialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("RadialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("splitPercent", 0)
	PostProcessingMgr.instance:setUnitPPValue("SplitPercent", 0)

	local vec = Vector2(0.5, 0.5)

	PostProcessingMgr.instance:setUnitPPValue("rgbSplitCenter", vec)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitCenter", vec)
end

function CommandStationEnterAnimView:onDestroyView()
	return
end

return CommandStationEnterAnimView
