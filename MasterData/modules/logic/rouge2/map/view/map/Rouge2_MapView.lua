-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapView", package.seeall)

local Rouge2_MapView = class("Rouge2_MapView", BaseView)

function Rouge2_MapView:onInitView()
	self._txtTitleName = gohelper.findChildText(self.viewGO, "Top/#txt_TitleName")
	self._goNormalAttribute = gohelper.findChild(self.viewGO, "Left/#go_Attribute_Normal")
	self._goPathSelectAttribute = gohelper.findChild(self.viewGO, "Left/#go_Attribute_PathSelect")
	self._goMask = gohelper.findChild(self.viewGO, "#go_Mask")
	self._goFocusPos = gohelper.findChild(self.viewGO, "#go_focusposition")
	self.goswitchmapanim = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapView:addEvents()
	return
end

function Rouge2_MapView:removeEvents()
	return
end

function Rouge2_MapView:_editableInitView()
	self.viewRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	local screenPosX = recthelper.uiPosToScreenPos2(self._goFocusPos.transform)

	Rouge2_MapModel.instance:setFocusScreenPosX(screenPosX)

	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.openRightView = false

	gohelper.setActive(self.goswitchmapanim, false)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onBeforeChangeMapInfo, self.onBeforeChangeMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onCreateMapDoneFlowDone, self.onCreateMapDoneFlowDone, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.backToMainScene, nil)
	Rouge2_AttributeToolBar.Load(self._goNormalAttribute, Rouge2_Enum.AttributeToolType.Enter_Skill_Detail)
	Rouge2_AttributeToolBar.Load(self._goPathSelectAttribute, Rouge2_Enum.AttributeToolType.Enter)
end

function Rouge2_MapView:_initNeedPlayOpenAnimView()
	if self.needPlayOpenAnimViewDict then
		return
	end

	self.needPlayOpenAnimViewDict = {
		[ViewName.Rouge2_MapChoiceView] = true,
		[ViewName.Rouge2_MapExploreChoiceView] = true,
		[ViewName.Rouge2_MapPieceChoiceView] = true
	}
end

function Rouge2_MapView:onOpenView(viewName)
	self:_initNeedPlayOpenAnimView()

	if self.needPlayOpenAnimViewDict[viewName] then
		self.animator:Play("close", 0, 0)
	end
end

function Rouge2_MapView:onCloseView(viewName)
	self:_initNeedPlayOpenAnimView()

	if self.needPlayOpenAnimViewDict[viewName] then
		self.animator:Play("open", 0, 0)
	end
end

function Rouge2_MapView:onBeforeChangeMapInfo()
	if Rouge2_MapModel.instance:isNormalLayer() then
		gohelper.setActive(self.goswitchmapanim, false)

		return
	end

	gohelper.setActive(self.goswitchmapanim, true)
	TaskDispatcher.runDelay(self.onAnimDone, self, Rouge2_MapEnum.SwitchMapAnimDuration)
end

function Rouge2_MapView:onCreateMapDoneFlowDone()
	self:playNormalLayerAudio()
end

function Rouge2_MapView:onChangeMapInfo()
	self._txtTitleName.text = Rouge2_MapModel.instance:getMapName()

	self:refreshAttrTool()
end

function Rouge2_MapView:onAnimDone()
	gohelper.setActive(self.goswitchmapanim, false)
end

function Rouge2_MapView:onOpen()
	self._txtTitleName.text = Rouge2_MapModel.instance:getMapName()

	self:refreshAttrTool()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onFocusNormalLayerActor)
end

function Rouge2_MapView:playNormalLayerAudio()
	if Rouge2_MapModel.instance:isNormalLayer() then
		AudioMgr.instance:trigger(AudioEnum.UI.LineExpanded)
	end
end

function Rouge2_MapView:refreshAttrTool()
	local isPathSelect = Rouge2_MapModel.instance:isPathSelect()

	gohelper.setActive(self._goNormalAttribute, not isPathSelect)
	gohelper.setActive(self._goPathSelectAttribute, isPathSelect)
end

function Rouge2_MapView:onClose()
	TaskDispatcher.cancelTask(self.onAnimDone, self)
end

function Rouge2_MapView:onDestroyView()
	return
end

return Rouge2_MapView
