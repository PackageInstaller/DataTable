-- chunkname: @modules/logic/patface/controller/PatFaceController.lua

module("modules.logic.patface.controller.PatFaceController", package.seeall)

local PatFaceController = class("PatFaceController", BaseController)

function PatFaceController:onInit()
	return
end

function PatFaceController:onInitFinish()
	return
end

function PatFaceController:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function PatFaceController:reInit()
	self:_destroyPopupFlow()
end

function PatFaceController:_onFinishAllPatFace()
	if self._skipBlurViewName then
		PostProcessingMgr.instance:setCloseSkipRefreshBlur(self._skipBlurViewName, nil)

		self._skipBlurViewName = nil

		PostProcessingMgr.instance:forceRefreshCloseBlur()
	end
end

function PatFaceController:_onOpenViewFinish(viewName)
	if not PatFaceModel.instance:getIsPatting() or not self._patFaceViewNameMap or not self._patFaceFlow then
		return
	end

	if self._patFaceViewNameMap[viewName] then
		self._skipBlurViewName = viewName

		PostProcessingMgr.instance:setCloseSkipRefreshBlur(self._skipBlurViewName, true)
		self:_checkAndCloseTryCallView(viewName)
	end
end

function PatFaceController:_checkAndCloseTryCallView(viewName)
	if ViewMgr.instance:isOpenFinish(viewName) then
		local viewContainer = ViewMgr.instance:getContainer(viewName)

		if viewContainer and viewContainer.isHasTryCallFail and viewContainer:isHasTryCallFail() then
			logError(string.format("PatFace view open has error, try close . name:[%s] .", viewName))
			ViewMgr.instance:closeView(viewName)
		end
	end
end

function PatFaceController:_initPatFaceFlow()
	self:_destroyPopupFlow()

	self._patFaceFlow = PatFaceFlowSequence.New()
	self._patFaceViewNameMap = {}

	local list = PatFaceConfig.instance:getPatFaceConfigList()

	for _, v in ipairs(list) do
		local patFaceId = v.id

		self._patFaceViewNameMap[v.config.patFaceViewName] = true

		if not PatFaceEnum.patFaceCustomWork[patFaceId] then
			local workCls = PatFaceWorkBase
			local work = workCls.New(patFaceId)

			self._patFaceFlow:addWork(work)
		end
	end

	self._patFaceFlow:registerDoneListener(self._finishAllPatFace, self)
end

function PatFaceController:startPatFace(patFaceType)
	local isSkip = PatFaceModel.instance:getIsSkipPatFace()

	if isSkip then
		return false
	end

	local isDoingClickGuide = GuideModel.instance:isDoingClickGuide()
	local isForbidGuides = GuideController.instance:isForbidGuides()

	if isDoingClickGuide and not isForbidGuides then
		return false
	end

	local isPatting = PatFaceModel.instance:getIsPatting()

	if isPatting then
		return false
	end

	if not self._patFaceFlow then
		self:_initPatFaceFlow()
	end

	PatFaceModel.instance:setIsPatting(true)
	self._patFaceFlow:start({
		patFaceType = patFaceType
	})

	return true
end

function PatFaceController:_finishAllPatFace()
	PatFaceModel.instance:setIsPatting(false)

	if self._patFaceFlow then
		self._patFaceFlow:reset()
	end

	self:_onFinishAllPatFace()
	self:dispatchEvent(PatFaceEvent.FinishAllPatFace)
end

function PatFaceController:_destroyPopupFlow()
	PatFaceModel.instance:setIsPatting(false)

	if not self._patFaceFlow then
		return
	end

	self._patFaceFlow:destroy()

	self._patFaceFlow = nil
end

PatFaceController.instance = PatFaceController.New()

return PatFaceController
