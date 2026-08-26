-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerMainSceneSkin.lua

module("modules.logic.guide.controller.trigger.GuideTriggerMainSceneSkin", package.seeall)

local GuideTriggerMainSceneSkin = class("GuideTriggerMainSceneSkin", BaseGuideTrigger)

function GuideTriggerMainSceneSkin:ctor(triggerKey)
	GuideTriggerMainSceneSkin.super.ctor(self, triggerKey)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewChange, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onViewChange, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerMainSceneSkin:assertGuideSatisfy(param, configParam)
	return self:_isHasSkinItem() and self:_checkInMain()
end

function GuideTriggerMainSceneSkin:_isHasSkinItem()
	local list = MainSceneSwitchConfig.instance:getItemLockList()

	for i, itemId in ipairs(list) do
		if ItemModel.instance:getItemCount(itemId) > 0 then
			return true
		end
	end
end

function GuideTriggerMainSceneSkin:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerMainSceneSkin:_onViewChange()
	self:checkStartGuide()
end

function GuideTriggerMainSceneSkin:_checkInMain()
	local needView = ViewName.MainView
	local inMainScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Main
	local isLoading = GameSceneMgr.instance:isLoading()
	local isClosing = GameSceneMgr.instance:isClosing()

	if inMainScene and not isLoading and not isClosing then
		local hasOpenAnyView = false
		local openViewNameList = ViewMgr.instance:getOpenViewNameList()

		for _, viewName in ipairs(openViewNameList) do
			if viewName ~= needView and (ViewMgr.instance:isModal(viewName) or ViewMgr.instance:isFull(viewName)) then
				hasOpenAnyView = true

				break
			end
		end

		if not hasOpenAnyView and (string.nilorempty(needView) or ViewMgr.instance:isOpen(needView)) then
			return true
		end
	end
end

function GuideTriggerMainSceneSkin:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerMainSceneSkin
