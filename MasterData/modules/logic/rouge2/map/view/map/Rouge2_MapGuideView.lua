-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapGuideView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapGuideView", package.seeall)

local Rouge2_MapGuideView = class("Rouge2_MapGuideView", BaseView)

function Rouge2_MapGuideView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapGuideView:addEvents()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnPopGuideView, self._onPopGuideView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateBagInfo, self.onUpdateBagInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)
end

function Rouge2_MapGuideView:removeEvents()
	return
end

function Rouge2_MapGuideView:_editableInitView()
	return
end

function Rouge2_MapGuideView:onOpen()
	self.close = false
end

function Rouge2_MapGuideView:_onPopGuideView(techniqueId)
	Rouge2_Controller.instance:openTechniqueView(tonumber(techniqueId))
end

function Rouge2_MapGuideView:checkCanTriggerGuide()
	if self.close then
		return
	end

	local state = Rouge2_MapModel.instance:getMapState()

	if state <= Rouge2_MapEnum.MapState.WaitFlow then
		return
	end

	local isTop = Rouge2_MapHelper.checkMapViewOnTop()

	if not isTop then
		return
	end

	local isInteract = Rouge2_MapModel.instance:isInteractiving()

	if isInteract then
		return
	end

	local isPop = Rouge2_PopController.instance:isPopping()

	if isPop then
		return
	end

	return true
end

function Rouge2_MapGuideView:tryTriggerNodeGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(Rouge2_MapEnum.GuideId.Node)

	if isGuideFinish then
		return
	end

	local curNode = Rouge2_MapModel.instance:getCurNode()
	local isStart = curNode and curNode:checkIsStart()

	if isStart then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideEventNode)

		return true
	end
end

function Rouge2_MapGuideView:tryTriggerTalentTreeGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(Rouge2_MapEnum.GuideId.TalentTree)

	if isGuideFinish then
		return
	end

	local hasAnyCanActiveTalent = Rouge2_BackpackController.instance:hasAnyCanActiveTalent()

	if not hasAnyCanActiveTalent then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideTalentTree)

	return true
end

function Rouge2_MapGuideView:tryTriggerBXSBoxGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(Rouge2_MapEnum.GuideId.BXSBox)
	local isUseBXS = Rouge2_Model.instance:isUseBXSCareer()
	local isMiddle = Rouge2_MapModel.instance:isMiddle()

	if isGuideFinish or not isUseBXS or isMiddle then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideBXSBox)

	return true
end

function Rouge2_MapGuideView:tryTriggerMiddleLayerGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(Rouge2_MapEnum.GuideId.MiddleLayer)
	local isMiddleLayer = Rouge2_MapModel.instance:isMiddle()

	if isGuideFinish or not isMiddleLayer then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideMiddleLayer)

	return true
end

function Rouge2_MapGuideView:tryTriggerPathSelectLayerGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(Rouge2_MapEnum.GuideId.Weather)
	local isPathSelect = Rouge2_MapModel.instance:isPathSelect()

	if isGuideFinish or not isPathSelect then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuidePathSelectLayer)

	return true
end

function Rouge2_MapGuideView:tryTriggerMapGuides()
	if not self:checkCanTriggerGuide() then
		return
	end

	if self:tryTriggerTalentTreeGuide() then
		return
	end

	if self:tryTriggerNodeGuide() then
		return
	end

	if self:tryTriggerBXSBoxGuide() then
		return
	end

	if self:tryTriggerMiddleLayerGuide() then
		return
	end

	if self:tryTriggerPathSelectLayerGuide() then
		return
	end
end

function Rouge2_MapGuideView:onPopViewDone()
	self:tryTriggerMapGuides()
end

function Rouge2_MapGuideView:onClearInteract()
	self:tryTriggerMapGuides()
end

function Rouge2_MapGuideView:onCloseViewFinish(viewName)
	if viewName == self.viewName then
		return
	end

	self:tryTriggerMapGuides()
end

function Rouge2_MapGuideView:onUpdateBagInfo()
	self:tryTriggerMapGuides()
end

function Rouge2_MapGuideView:onClose()
	self.close = true
end

function Rouge2_MapGuideView:onDestroyView()
	return
end

return Rouge2_MapGuideView
