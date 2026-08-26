-- chunkname: @modules/logic/rouge/map/view/map/RougeMapView.lua

module("modules.logic.rouge.map.view.map.RougeMapView", package.seeall)

local RougeMapView = class("RougeMapView", BaseView)

function RougeMapView:onInitView()
	self._txtTitleName = gohelper.findChildText(self.viewGO, "Top/#txt_TitleName")
	self._gorougeherogroup = gohelper.findChild(self.viewGO, "Left/#go_rougeherogroup")
	self._goroucollection = gohelper.findChild(self.viewGO, "Left/#go_rougecollection")
	self._gorougelv = gohelper.findChild(self.viewGO, "Left/#go_rougelv")
	self._goMask = gohelper.findChild(self.viewGO, "#go_Mask")
	self._goFocusPos = gohelper.findChild(self.viewGO, "#go_focusposition")
	self.goswitchmapanim = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapView:addEvents()
	return
end

function RougeMapView:removeEvents()
	return
end

function RougeMapView:_editableInitView()
	self.goHeroGroup = self.viewContainer:getResInst(RougeEnum.ResPath.CommonHeroGroupItem, self._gorougeherogroup)
	self.goCollection = self.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, self._goroucollection)
	self.goLv = self.viewContainer:getResInst(RougeEnum.ResPath.CommonLvItem, self._gorougelv)
	self.groupComp = RougeHeroGroupComp.Get(self.goHeroGroup)
	self.collectionComp = RougeCollectionComp.Get(self.goCollection)
	self.lvComp = RougeLvComp.Get(self.goLv)
	self.viewRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	local screenPosX = recthelper.uiPosToScreenPos2(self._goFocusPos.transform)

	RougeMapModel.instance:setFocusScreenPosX(screenPosX)

	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.openRightView = false

	gohelper.setActive(self.goswitchmapanim, false)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onBeforeChangeMapInfo, self.onBeforeChangeMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onCreateMapDoneFlowDone, self.onCreateMapDoneFlowDone, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	NavigateMgr.instance:addEscape(self.viewName, RougeMapHelper.backToMainScene, nil)
end

function RougeMapView:_initNeedPlayOpenAnimView()
	if self.needPlayOpenAnimViewDict then
		return
	end

	self.needPlayOpenAnimViewDict = {
		[ViewName.RougeMapChoiceView] = true,
		[ViewName.RougeTeamView] = true,
		[ViewName.RougeCollectionChessView] = true,
		[ViewName.RougeTalentView] = true,
		[ViewName.RougeMapPieceChoiceView] = true
	}
end

function RougeMapView:onOpenView(viewName)
	self:_initNeedPlayOpenAnimView()

	if self.needPlayOpenAnimViewDict[viewName] then
		self.animator:Play("close", 0, 0)
	end
end

function RougeMapView:onCloseView(viewName)
	self:_initNeedPlayOpenAnimView()

	if self.needPlayOpenAnimViewDict[viewName] then
		self.animator:Play("open", 0, 0)
	end
end

function RougeMapView:onBeforeChangeMapInfo()
	gohelper.setActive(self.goswitchmapanim, true)
	TaskDispatcher.runDelay(self.onAnimDone, self, RougeMapEnum.SwitchMapAnimDuration)
end

function RougeMapView:onCreateMapDoneFlowDone()
	self:playNormalLayerAudio()
end

function RougeMapView:onChangeMapInfo()
	self._txtTitleName.text = RougeMapModel.instance:getMapName()
end

function RougeMapView:onAnimDone()
	gohelper.setActive(self.goswitchmapanim, false)
end

function RougeMapView:onOpen()
	self.groupComp:onOpen()
	self.collectionComp:onOpen(RougeEnum.CollectionEntryState.Icon)
	self.lvComp:onOpen()

	self._txtTitleName.text = RougeMapModel.instance:getMapName()

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onFocusNormalLayerActor)
end

function RougeMapView:playNormalLayerAudio()
	if RougeMapModel.instance:isNormalLayer() then
		AudioMgr.instance:trigger(AudioEnum.UI.LineExpanded)
	end
end

function RougeMapView:onClose()
	TaskDispatcher.cancelTask(self.onAnimDone, self)
	self.groupComp:onClose()
	self.collectionComp:onClose()
	self.lvComp:onClose()
end

function RougeMapView:onDestroyView()
	self.groupComp:destroy()
	self.collectionComp:destroy()
	self.lvComp:destroy()
end

return RougeMapView
