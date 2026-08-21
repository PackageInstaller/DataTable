-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingReportDetailsView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingReportDetailsView", package.seeall)

local M = class("FacilityHoldingReportDetailsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

M.PageItemTyp = {
	FailExt = 2,
	Normal = 1
}

function M:buildUI()
	self._guiAni = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._cellItem = {}
	self._btnClose = self:getBtn("facility_holding_report_details_view_1098041689")
	self._txtHint = self:getText("facility_holding_report_details_view_-1708187518")
	self._scrollBar = self:getUIComponent("facility_holding_report_details_view_-464645726", UIComponentType.Scrollbar)
	self._uiClickScrollBar = UIComponentType.UIClickTrigger(self._scrollBar.gameObject)
	self._compositeTouch = UICompositeTouch.Get(self:getGo("facility_holding_report_details_view_1383254051"))

	local clickChecker = ClickTouchChecker.New()

	clickChecker:AddClickListener(self._onClickChangePage, self)

	local DragTouchChecker = DragTouchChecker.New()

	DragTouchChecker:SetBeginDragListener(self._onBeginDrag, self)
	DragTouchChecker:SetDragListener(self._onDrag, self)
	DragTouchChecker:SetEndDragListener(self._onEndDrag, self)
	self._compositeTouch:AddChecker(clickChecker)
	self._compositeTouch:AddChecker(DragTouchChecker)

	self._canvasGroupScrollBar = self._scrollBar.transform:GetComponent(ComponentType.CanvasGroup)
	self._goPageRoot = self:getGo("facility_holding_report_details_view_1014277288").gameObject
	self._goReportFailItem = self:getGo("facility_holding_report_details_view_-1092665846").gameObject
	self._goReportNormalItem = self:getGo("facility_holding_report_details_view_1150612007").gameObject
	self._goReplayRoot = self:getGo("facility_holding_report_details_view_273370511")
	self._rawImgReplay = self:getUIComponent("facility_holding_report_details_view_1395803903", UIComponentType.RawImage)
	self._txtFacilityName = self:getText("facility_holding_report_details_view_887013842")
	self._btnCloseReplay = self:getBtn("facility_holding_report_details_view_959401088")
	self._cellCollectionNormal = LocalReusableCollection.New(HoldingRoomReportDetailNormalCell, 2)
	self._cellCollectionFail = LocalReusableCollection.New(HoldingRoomReportDetailFailCell, 2)
end

function M:destroyUI()
	self._guiAni = nil

	for typ, typValTable in pairs(self._cellItem or {}) do
		for key, value in pairs(typValTable or {}) do
			value.shower:destroyUI()
		end
	end

	self._cellItem = nil
	self._btnClose = nil
	self._txtHint = nil
	self._scrollBar = nil
	self._uiClickScrollBar = nil

	self._compositeTouch:ClearCheckerList()

	self._compositeTouch = false
	self._canvasGroupScrollBar = nil
	self._goPageRoot = nil
	self._goReportFailItem = nil
	self._goReportNormalItem = nil
	self._goReplayRoot = nil
	self._rawImgReplay = nil
	self._txtFacilityName = nil
	self._btnCloseReplay = nil
	self._cellCollectionNormal = nil
	self._cellCollectionFail = nil
	self._isMovingPage = nil
	self._reportLst = nil
end

function M:bindEvents()
	self._btnCloseReplay:AddClickListener(self._onClickCloseReplay, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnCloseReplay:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for typ, typValTable in pairs(self._cellItem or {}) do
		for key, value in pairs(typValTable or {}) do
			value.shower:unbindEvents()
		end
	end
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Language)

	self._canvasGroupScrollBar.alpha = 1
	self._txtHint.color = Color.New(0.6352941176470588, 0.6352941176470588, 0.6352941176470588, 255)

	self._guiAni:StopTimelineAni()
	self._guiAni:PlayAniByName("open")
	goutil.setActive(self._goReplayRoot, false)

	local info = self:getFirstParam()

	self._roomId = info.roomId
	self._readFailMode = info.readFailMode
	self._barOrgVal = 0.5
	self._barVal = 0.5
	self._scrollBar.value = self._barOrgVal
	self._scrollBar.size = 0.3

	self:_duelReportLst(info.reportLst)
	self:_initPageShow()
	self._uiClickScrollBar:AddClickUpListener(self._onClickBarUp, self)
	self._uiClickScrollBar:AddClickDownListener(self._onClickBarDown, self)
end

function M:onExit()
	self._uiClickScrollBar:RemoveClickUpListener()
	self._uiClickScrollBar:RemoveClickDownListener()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Language)

	for typ, typValTable in pairs(self._cellItem or {}) do
		for key, value in pairs(typValTable or {}) do
			value.shower:onExit()

			value.isUse = false
		end
	end

	self._barOrgVal = nil
	self._barVal = nil
	self._roomId = nil
	self._reportIndex = nil
	self._frontPage = nil
	self._backPage = nil

	self._guiAni:StopTimelineAni()
	self._guiAni:PlayAniByName("close")
	self._cellCollectionNormal:clearAllInstance()
	self._cellCollectionFail:clearAllInstance()
	HouseDispatcher:dispatchEvent(HouseEventType.ON_REPORT_DETAIL_EXIST, nil)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickCloseReplay()
	goutil.setActive(self._goReplayRoot, false)

	if self.photoUnit then
		self.photoUnit:clear()
		HouseFacade.instance:endRecordShelterRoomInvalid()
	end

	self.photoUnit = nil
end

function M:replayFailReport(reportInfo)
	self._failReportInfo = reportInfo

	local cfgRoomId = reportInfo.roomId
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)

	if roomCO then
		HouseMainStateModel.instance:changeState(HouseMainEnum.State.FailReportReplay)
		self:initFailReportPlay()
	else
		printError(string.format("t_house_zone中无法找到[%d]的配置", cfgRoomId))
	end
end

function M:initFailReportPlay()
	local posReplayX, posReplayY, posReplayZ = -300, 266.8, -25.8
	local posOffsetX, posOffsetY, posOffsetZ = 0, 2.6, -10.2
	local cfgProtomerInfo = ContainmentConfig.instance:getProtomerInfoById(self._failReportInfo.protomerId)

	self._txtFacilityName.text = cfgProtomerInfo.roomname

	goutil.setActive(self._goReplayRoot, true)
	goutil.setActive(self._rawImgReplay.gameObject, true)

	self.photoUnit = PhotoEffect.Get(self._rawImgReplay.gameObject)

	local photoComp = Astral.PhotoBase.Add(self._rawImgReplay.gameObject)
	local _width = goutil.getWidth(self._rawImgReplay.transform)
	local _heigh = goutil.getHeight(self._rawImgReplay.transform)

	photoComp:TurnOn(_width, _heigh)

	local cullingMask = Astral.LayerUtil.GetLayerMask("Default", "Unit", "stone", "Sence_lightculing")
	local cam = PhotoBaseExtension.GetCamera(photoComp)
	local offsetX, offsetY, offsetZ = TransformUtils.GetLocalPosition(cam.transform.parent, 0, 0, 0)

	self.photoUnit:setCameraPosition(posReplayX - offsetX + posOffsetX, posReplayY - offsetY + posOffsetY, posReplayZ - offsetZ + posOffsetZ)
	self.photoUnit:setCameraRotation(0, 0, 0)

	cam.cullingMask = cullingMask

	PhotoBaseExtension.SetCameraPostProcessing(photoComp, true, 0)
	self.photoUnit:setCameraPerspective(27)

	local infoForReplay = {
		protomerId = self._failReportInfo.protomerId,
		heroId = self._failReportInfo.heroId or 0,
		beginCallback = self.onFailReportReplayBegin,
		beginTarget = self,
		finishCallback = self.onFailReportReplayFinish,
		finishTarget = self,
		totalDuration = self._failReportInfo.totalDuration
	}

	printWarn(string.format("准备回放收容失效，原体[%d],角色id[%d],时长[%d]", infoForReplay.protomerId, infoForReplay.heroId, infoForReplay.totalDuration))
	HouseFacade.instance:showRecordShelterRoomInvalid(infoForReplay)
end

function M:onFailReportReplayBegin()
	return
end

function M:onFailReportReplayFinish()
	goutil.setActive(self._goReplayRoot, false)
	self.photoUnit:clear()

	self.photoUnit = nil
end

function M:_onClickChangePage()
	if self._backPage then
		self._isMovingPage = true

		self._backPage:SetAsLastSibling()
		self._backPage:doAnchorPos(26, -3, 0.2)
		self._backPage:doRotateX(0, 0, 0, 0.2)
		self._frontPage:doAnchorPos(66, 19, 0.3, function()
			self._frontPage, self._backPage = self._backPage, self._frontPage
			self._isMovingPage = false
		end)
		self._frontPage:doRotateX(0, 0, -5, 0.2)
	else
		print("该报告无失效，不能切页")
	end
end

function M:_onBeginDrag(x, y)
	self._orgDragPosY = y
end

function M:_onDrag(x, y)
	if y < self._orgDragPosY then
		self._scrollBar.value = self._scrollBar.value + 0.3
	elseif y > self._orgDragPosY then
		self._scrollBar.value = self._scrollBar.value - 0.3
	end
end

function M:_onEndDrag(x, y)
	local offset = 0

	if self._orgDragPosY then
		offset = y - self._orgDragPosY
	end

	if offset >= 5 or offset <= -5 then
		self._scrollBar.value = offset > 0 and self._scrollBar.value - 0.3 or self._scrollBar.value + 0.3

		self:_onClickBarUp()
	end
end

function M:_onClickBarUp()
	local curVal = self._scrollBar.value
	local offset = curVal - self._barVal

	if self._frontPage ~= nil and not self._isMovingPage then
		local frontIndex = self._frontPage:getIndex()

		if offset <= -0.2 then
			if frontIndex ~= 1 then
				self._isMovingPage = true

				if self._backPage then
					self._backPage:doAnchorPos(100, 60, 0.2)
					self._backPage:doCanvasGroupAlpha(0, 0.2)
					self._backPage:doRotateX(0, 0, -10, 0.2)
				end

				self._frontPage:doAnchorPos(100, 60, 0.2, function()
					self:_turnPageUpFinish()
				end)
				self._frontPage:doCanvasGroupAlpha(0, 0.2)
				self._frontPage:doRotateX(0, 0, -10, 0.2)
			else
				print("上滑，上一条：别滑了，这是第一个报告")
			end
		elseif offset > 0.2 then
			if frontIndex ~= self:getReportCount() then
				self._isMovingPage = true

				if self._backPage then
					self._backPage:doAnchorPos(26, -57, 0.3)
					self._backPage:doCanvasGroupAlpha(0, 0.2)
					self._backPage:doRotateX(0, 0, 5, 0.2)
				end

				self._frontPage:doAnchorPos(26, -57, 0.3, function()
					self:_turnPageDownFinish()
				end)
				self._frontPage:doCanvasGroupAlpha(0, 0.2)
				self._frontPage:doRotateX(0, 0, 5, 0.2)
			else
				print("下滑，下一条：别滑了，这是最后一个报告")
			end
		end
	end

	self._scrollBar.value = self._barOrgVal
	self._barVal = self._scrollBar.value
end

function M:_onClickBarDown()
	self._barVal = self._scrollBar.value
end

function M:_turnPageUpFinish()
	local nextIndex = self._frontPage:getIndex() - 1
	local data = self._reportLst[nextIndex]

	if data then
		local frontPageTyp = self.PageItemTyp.Normal
		local backPageTyp = self.PageItemTyp.FailExt

		if self._readFailMode then
			frontPageTyp = self.PageItemTyp.FailExt
			backPageTyp = self.PageItemTyp.Normal
		end

		self:reportCellReturn(self._frontPage)
		self:reportCellReturn(self._backPage)

		self._frontPage = nil
		self._backPage = nil

		if data:getFailLevel() > 0 then
			self._backPage = self:_getItem(backPageTyp)

			self._backPage:setHandler(self)
			self._backPage:setCellData(data, nextIndex, 2)
			self._backPage:setAcnchorPos(66, 19, 0)
			self._backPage:setRotate(0, 0, 0)
		end

		self._frontPage = self:_getItem(frontPageTyp)

		self._frontPage:setHandler(self)
		self._frontPage:setCellData(data, nextIndex, 1)
		self._frontPage:setAcnchorPos(26, -57, 0)
		self._frontPage:setRotate(0, 0, 5)
		self._frontPage:setCanvasGroupAlpha(0)
		self._frontPage:SetAsLastSibling()
		self._frontPage:setShow(true)
		self._frontPage:doAnchorPos(26, -3, 0.2)
		self._frontPage:doRotateX(0, 0, 0, 0.2)
		self._frontPage:doCanvasGroupAlpha(1, 0.2)

		if self._backPage then
			self._backPage:setCanvasGroupAlpha(1)
			self._backPage:setShow(true)
			self._backPage:doRotateX(0, 0, -5, 0.2)
		end
	end

	self._isMovingPage = false
end

function M:_turnPageDownFinish()
	local nextIndex = self._frontPage:getIndex() + 1
	local data = self._reportLst[nextIndex]

	if data then
		self:reportCellReturn(self._frontPage)
		self:reportCellReturn(self._backPage)

		self._frontPage = nil
		self._backPage = nil

		local frontPageTyp = self.PageItemTyp.Normal
		local backPageTyp = self.PageItemTyp.FailExt

		if self._readFailMode then
			frontPageTyp = self.PageItemTyp.FailExt
			backPageTyp = self.PageItemTyp.Normal
		end

		if data:getFailLevel() > 0 then
			self._backPage = self:_getItem(backPageTyp)

			self._backPage:setHandler(self)
			self._backPage:setCellData(data, nextIndex, 2)
			self._backPage:setAcnchorPos(66, 19, 0)
			self._backPage:setRotate(0, 0, 0)
		end

		self._frontPage = self:_getItem(frontPageTyp)

		self._frontPage:setHandler(self)
		self._frontPage:setCellData(data, nextIndex, 1)
		self._frontPage:setAcnchorPos(66, 19, 0)
		self._frontPage:setRotate(0, 0, -5)
		self._frontPage:setCanvasGroupAlpha(0)
		self._frontPage:SetAsLastSibling()
		self._frontPage:setShow(true)
		self._frontPage:doAnchorPos(26, -3, 0.2)
		self._frontPage:doRotateX(0, 0, 0, 0.2)
		self._frontPage:doCanvasGroupAlpha(1, 0.2)

		if self._backPage then
			self._backPage:setCanvasGroupAlpha(1)
			self._backPage:setShow(true)
			self._backPage:doRotateX(0, 0, -5, 0.2)
		end
	end

	self._isMovingPage = false
end

function M:_duelReportLst(reportLst)
	self._reportLst = {}

	for _, value in pairs(reportLst) do
		if self._readFailMode then
			table.insert(self._reportLst, value)
		elseif not value:getIsRunning() and value:getRecive() then
			table.insert(self._reportLst, value)
		end
	end

	if self._readFailMode then
		if self._roomId > 0 then
			ContainmentReportModel.instance:removeUnReadFailReport(self._roomId)
		end
	elseif #self._reportLst == 1 then
		local uuid = self._reportLst[1]:getUuid()

		ContainmentReportModel.instance:removeSingleUnReadFailReport(self._roomId, uuid)
	end

	goutil.setActive(self._scrollBar.gameObject, #self._reportLst > 1)
end

function M:getReportCount()
	return self._reportCount or 0
end

function M:_initPageShow()
	self._cellItem = {}

	if self._cellCollectionNormal then
		self._cellCollectionNormal:clearAllInstance()
	end

	if self._cellCollectionFail then
		self._cellCollectionFail:clearAllInstance()
	end

	self._isMovingPage = false
	self._reportCount = self._reportLst and #self._reportLst or 0

	print(string.format("<color=#00FFFF>可展示报告数量[%d]</color>", self._reportCount))

	if self._reportCount > 0 then
		self._reportIndex = 1

		local data = self._reportLst[self._reportIndex]

		if data then
			local pageIndex = self._reportIndex
			local frontPageTyp = self.PageItemTyp.Normal
			local backPageTyp = self.PageItemTyp.FailExt

			if self._readFailMode then
				frontPageTyp = self.PageItemTyp.FailExt
				backPageTyp = self.PageItemTyp.Normal
			end

			if data:getFailLevel() > 0 then
				self._backPage = self:_getItem(backPageTyp)

				self._backPage:setHandler(self)
				self._backPage:setCellData(data, pageIndex, 2)
				self._backPage:setAcnchorPos(66, 19, 0)
				self._backPage:setRotate(0, 0, 0)
				self._backPage:setCanvasGroupAlpha(1)
				self._backPage:setShow(true)
			end

			self._frontPage = self:_getItem(frontPageTyp)

			self._frontPage:setHandler(self)
			self._frontPage:setCellData(data, pageIndex, 1)
			self._frontPage:setAcnchorPos(26, -3, 0)
			self._frontPage:setRotate(0, 0, 0)
			self._frontPage:setCanvasGroupAlpha(1)
			self._frontPage:setShow(true)

			if self._backPage then
				self._backPage:doRotateX(0, 0, -5, 0.2)
			end
		end
	end
end

function M:reportCellReturn(cell)
	if cell then
		local poolIndex = cell:getPoolIndex()
		local typ = cell:getTyp()

		cell:setShow(false)

		self._cellItem[typ][poolIndex].isUse = false
	end
end

function M:_getItem(typ)
	local shower

	if not self._cellItem[typ] then
		shower = self:_createItem(typ)
	else
		for _, myCellData in pairs(self._cellItem[typ]) do
			if not myCellData.isUse then
				shower = myCellData.shower
				myCellData.isUse = true

				break
			end
		end
	end

	if shower == nil then
		shower = self:_createItem(typ)
	end

	return shower
end

function M:_regItem(typ, luaCell)
	if not self._cellItem[typ] then
		self._cellItem[typ] = {}
	end

	local poolIndex = #self._cellItem[typ] + 1

	luaCell:setPoolIndex(poolIndex)
	table.insert(self._cellItem[typ], {
		isUse = true,
		shower = luaCell
	})
end

function M:_createItem(typ)
	local shower

	if typ == M.PageItemTyp.Normal then
		shower = self._cellCollectionNormal:createInstance(self._goReportNormalItem)
	else
		shower = self._cellCollectionFail:createInstance(self._goReportFailItem)
	end

	goutil.addChildToParent(shower.mainGO, self._goPageRoot)

	shower.view = self

	goutil.setActive(shower.mainGO, false)
	self:_regItem(typ, shower)

	return shower
end

return M
