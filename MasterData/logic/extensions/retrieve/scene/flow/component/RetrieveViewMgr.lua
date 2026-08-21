-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/flow/component/RetrieveViewMgr.lua

module("logic.extensions.retrieve.scene.flow.component.RetrieveViewMgr", package.seeall)

local M = class("RetrieveViewMgr", ISceneFlowComp)

function M:onEnter()
	self:_setEvent(true)
end

function M:onEnterDone()
	M.super.onEnterDone(self)
	ViewMgr.instance:open(ViewName.RetrieveMainViewViewPresentor)

	if not ViewMgr.instance:isOpen(ViewName.ScenePicker) then
		ScenePickerViewFacade.instance:open(RetrieveEnum.ScenePickerKey)
	end
end

function M:onExit()
	self:_setEvent(false)
	ScenePickerViewFacade.instance:close(RetrieveEnum.ScenePickerKey)
end

function M:_closeAllLotteryView()
	ViewMgr.instance:close(ViewName.RetrieveMainViewViewPresentor)
	ViewMgr.instance:close(ViewName.RetrieveRoleShowViewViewPresentor)
end

function M:_setEvent(add)
	if add then
		RetrieveDispatcher:addEventListener(RetrieveEventType.Retrieve_Show_Phone_End, self._onEndShowPhone, self)
	else
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Retrieve_Show_Phone_End, self._onEndShowPhone, self)
	end
end

function M:_onShowPhone(evt)
	return
end

function M:_onEndShowPhone(evt)
	ViewMgr.instance:close(ViewName.RetrieveDialView)
end

function M:onReturnScene()
	ViewMgr.instance:_openPreFullUpView()
	RetrieveController.instance:loadAndSetDefault()
	ScenePickerViewFacade.instance:open(RetrieveEnum.ScenePickerKey)
end

return M
