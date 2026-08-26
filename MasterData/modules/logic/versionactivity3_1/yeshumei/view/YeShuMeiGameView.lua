-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiGameView.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiGameView", package.seeall)

local YeShuMeiGameView = class("YeShuMeiGameView", BaseView)

YeShuMeiGameView.GuideId = 31401

function YeShuMeiGameView:onInitView()
	self._gogame = gohelper.findChild(self.viewGO, "#go_Game")
	self._goshadow = gohelper.findChild(self._gogame, "#go_shadow")
	self._goComplete = gohelper.findChild(self._gogame, "#go_Complete")
	self._simageshadow = gohelper.findChildSingleImage(self._gogame, "#go_shadow/#simage_shadow")
	self._imageshadow = gohelper.findChildImage(self._gogame, "#go_shadow/#simage_shadow")
	self._goreview = gohelper.findChild(self._gogame, "#btn_review")
	self._btnreview = gohelper.findChildButtonWithAudio(self._gogame, "#btn_review")
	self._goreviewoff = gohelper.findChild(self._gogame, "#btn_review/#go_State1")
	self._goreviewon = gohelper.findChild(self._gogame, "#btn_review/#go_State2")
	self._gopointroot = gohelper.findChild(self._gogame, "pointroot")
	self._gopoint = gohelper.findChild(self._gogame, "pointroot/#go_point")
	self._golineroot = gohelper.findChild(self._gogame, "lineroot")
	self._goline = gohelper.findChild(self._gogame, "lineroot/#go_line")
	self._goshowline = gohelper.findChild(self._gogame, "#go_showline")
	self._godrag = gohelper.findChild(self._gogame, "#go_drag")
	self._goguid = gohelper.findChild(self._gogame, "#go_guid")
	self._gotarget = gohelper.findChild(self._gogame, "LeftTop/TargetList")
	self._gotargetitem = gohelper.findChild(self._gogame, "LeftTop/TargetList/#go_TargetItem")
	self._goconditiontip = gohelper.findChild(self.viewGO, "#go_conditiontip")
	self._txtconditiontip = gohelper.findChildText(self.viewGO, "#go_conditiontip/Target/#txt_TargetDescr")
	self._btncomplete = gohelper.findChildButtonWithAudio(self._gogame, "#go_Complete/#btn_complete")
	self._isHidePoint = false
	self._isReviewing = false

	gohelper.setActive(self._goreviewoff, not self._isReviewing)
	gohelper.setActive(self._goreviewon, self._isReviewing)
	gohelper.setActive(self._btncomplete.gameObject, false)

	self._shadowAnimator = self._goshadow:GetComponent(typeof(UnityEngine.Animator))
	self._pointRootAnimator = self._gopointroot:GetComponent(typeof(UnityEngine.Animator))
	self._lineRootAnimator = self._golineroot:GetComponent(typeof(UnityEngine.Animator))
	self._shadowAnimOutTime = 0.333

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YeShuMeiGameView:addEvents()
	self._btnreview:AddClickListener(self._onClickReview, self)
	self._btncomplete:AddClickListener(self._onBtnComlete, self)
	CommonDragHelper.instance:registerDragObj(self._godrag, self._onDragBeginPoint, self._onDragPoint, self._onDragEndPoint, nil, self, nil, true)
	self.addEventCb(self, YeShuMeiController.instance, YeShuMeiEvent.ShowGuideDrag, self._showGuideDrag, self)
	self.addEventCb(self, YeShuMeiController.instance, YeShuMeiEvent.OnClickShadowGuide, self._onClickShadow, self)
end

function YeShuMeiGameView:removeEvents()
	self._btnreview:RemoveClickListener()
	self._btncomplete:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(self._godrag)
	self.removeEventCb(self, YeShuMeiController.instance, YeShuMeiEvent.ShowGuideDrag, self._showGuideDrag, self)
	self.removeEventCb(self, YeShuMeiController.instance, YeShuMeiEvent.OnClickShadowGuide, self._onClickShadow, self)
end

function YeShuMeiGameView:_onClickShadow()
	gohelper.setActive(self._goshadow, false)
	self._pointRootAnimator:Play("in", 0, 0)
	self._lineRootAnimator:Play("in", 0, 0)
	self:_initPoint()
	gohelper.setActive(self._godrag, true)
end

function YeShuMeiGameView:_onClickReview()
	if GuideModel.instance:isGuideRunning(YeShuMeiGameView.GuideId) then
		return
	end

	if self._pointItem == nil then
		return
	end

	if self._isReviewing then
		return
	end

	local list = YeShuMeiGameModel.instance:getNeedCheckPointList()

	if list and #list >= 2 then
		GameFacade.showMessageBox(MessageBoxIdDefine.V3A1YeShuMei_ResetGame, MsgBoxEnum.BoxType.Yes_No, self.resetGame, nil, nil, self)
	else
		self:_reviewShadow()
	end
end

function YeShuMeiGameView:_reviewShadow()
	self:_hidePoint()
	gohelper.setActive(self._goshadow, true)
	gohelper.setActive(self._godrag, false)

	self._isReviewing = true

	gohelper.setActive(self._goreviewoff, not self._isReviewing)
	gohelper.setActive(self._goreviewon, self._isReviewing)
	TaskDispatcher.runDelay(self._onClickUp, self, self._reviewShowShadowTime)
end

function YeShuMeiGameView:_onClickUp()
	TaskDispatcher.cancelTask(self._onClickUp, self)
	self._shadowAnimator:Play("out", 0, 0)
	TaskDispatcher.runDelay(self._onClickShadowOut, self, self._shadowAnimOutTime)
end

function YeShuMeiGameView:_onClickShadowOut()
	TaskDispatcher.cancelTask(self._onClickShadowOut, self)
	self:_showPoint()
	gohelper.setActive(self._goshadow, false)
	gohelper.setActive(self._godrag, true)
	self:_clearReview()
end

function YeShuMeiGameView:_clearReview()
	self._isReviewing = false

	gohelper.setActive(self._goreviewoff, not self._isReviewing)
	gohelper.setActive(self._goreviewon, self._isReviewing)
end

function YeShuMeiGameView:onOpen()
	self._episodeId = self.viewParam
	self._config = YeShuMeiGameModel.instance:getCurGameConfig()
	self._beforeShowShadowTime = YeShuMeiConfig.instance:getConstValueNumber(YeShuMeiEnum.BeForePlayGame)
	self._finishShowShadowTime = YeShuMeiConfig.instance:getConstValueNumber(YeShuMeiEnum.AfterPlayGame)
	self._reviewShowShadowTime = YeShuMeiConfig.instance:getConstValueNumber(YeShuMeiEnum.ReViewTime)
	self._switchShowShadowTime = 1.5

	self:_initView()
end

function YeShuMeiGameView:_initView()
	self._gameMo = YeShuMeiGameModel.instance:getGameMo()

	self:_initCondition()
	self:_showCondition()
end

function YeShuMeiGameView:_initCondition()
	self._txtconditiontip.text = self._config and self._config.desc
end

function YeShuMeiGameView:_showCondition()
	gohelper.setActive(self._goconditiontip, true)
	AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_mubiao)
	gohelper.setActive(self._gogame, false)
	TaskDispatcher.runDelay(self._initGame, self, 2.8)
end

function YeShuMeiGameView:_initGame()
	gohelper.setActive(self._gogame, true)
	gohelper.setActive(self._goconditiontip, false)
	gohelper.setActive(self._goComplete, false)
	self:_initTargetList()

	local isFinishedGuide = GuideModel.instance:isStepFinish(YeShuMeiGameView.GuideId, 2)

	if isFinishedGuide or GuideController.instance:isForbidGuides() then
		self:_showShadow()
	else
		local index = YeShuMeiGameModel.instance:getCurrentLevelIndex()

		if not self._bgList then
			if not self._config or not self._config.shadowBg then
				return
			end

			self._bgList = string.split(self._config.shadowBg, "#")
		end

		if self._bgList and #self._bgList > 0 then
			local url = self._bgList[index]

			self._simageshadow:LoadImage(ResUrl.getV3a1YeShuMeiSingleBg(url), self._loadedImage, self)
		end

		gohelper.setActive(self._goshadow, true)
		gohelper.setActive(self._godrag, false)
	end
end

function YeShuMeiGameView:resetGame()
	YeShuMeiStatHelper.instance:sendGameReset()
	self:_deletePoint()
	self:_clearLines()
	YeShuMeiGameModel.instance:_onStart()
	self:_initPoint()
	self:_reviewShadow()
end

function YeShuMeiGameView:_initTargetList()
	self._targetDescList = {}
	self._targetItemList = {}

	if self._config then
		if not string.nilorempty(self._config) then
			self._targetdescList = string.split(self._config, "#")
		end

		if #self._targetdescList > 0 then
			gohelper.CreateObjList(self, self._createTargetItem, self._targetdescList, self._gotarget, self._gotargetitem)
		end
	end
end

function YeShuMeiGameView:_createTargetItem(obj, data, index)
	local item = self:getUserDataTb_()

	item.index = index
	item.gook = gohelper.findChild(obj, "#go_TargetOK")
	item.txtdesc = gohelper.findChildText(obj, "#txt_TargetDesc")
	item.govx = gohelper.findChild(obj, "vx_glow")
	item.txtdesc.text = data
	self._targetItemList[index] = item
end

function YeShuMeiGameView:_showShadow(isNext)
	local index = YeShuMeiGameModel.instance:getCurrentLevelIndex()

	if not self._bgList then
		if not self._config or not self._config.shadowBg then
			return
		end

		self._bgList = string.split(self._config.shadowBg, "#")
	end

	if self._bgList and #self._bgList > 0 then
		local url = self._bgList[index]

		self._simageshadow:LoadImage(ResUrl.getV3a1YeShuMeiSingleBg(url), self._loadedImage, self)
	end

	gohelper.setActive(self._goshadow, true)
	gohelper.setActive(self._godrag, false)

	if isNext then
		self._shadowAnimator:Play("insp", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_wipe)
		TaskDispatcher.runDelay(self._switchShowShadow, self, self._switchShowShadowTime)
	else
		TaskDispatcher.runDelay(self._afterShowShadow, self, self._beforeShowShadowTime)
	end
end

function YeShuMeiGameView:_switchShowShadow()
	TaskDispatcher.cancelTask(self._switchShowShadow, self)
	TaskDispatcher.runDelay(self._afterShowShadow, self, self._beforeShowShadowTime)
end

function YeShuMeiGameView:_loadedImage()
	self._imageshadow:SetNativeSize()
end

function YeShuMeiGameView:_afterShowShadow()
	TaskDispatcher.cancelTask(self._afterShowShadow, self)
	gohelper.setActive(self._btnreview.gameObject, true)
	gohelper.setActive(self._goshadow, false)
	gohelper.setActive(self._godrag, true)
	self._pointRootAnimator:Play("in", 0, 0)
	self._lineRootAnimator:Play("in", 0, 0)
	self:_initPoint()
	self:_showPoint()
end

function YeShuMeiGameView:_hidePoint()
	if self._isHidePoint then
		return
	end

	self._isHidePoint = true

	if self._pointItem and #self._pointItem > 0 then
		for _, point in ipairs(self._pointItem) do
			gohelper.setActive(point.go, false)
		end
	end
end

function YeShuMeiGameView:_showPoint()
	self._isHidePoint = false

	if self._pointItem and #self._pointItem > 0 then
		for _, point in ipairs(self._pointItem) do
			gohelper.setActive(point.go, true)
		end
	end

	AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_dian)
end

function YeShuMeiGameView:_deletePoint()
	if not self._pointItem then
		return
	end

	for _, item in ipairs(self._pointItem) do
		gohelper.destroy(item.go)
		item.mo:clearPoint()
	end

	self._pointItem = nil
end

function YeShuMeiGameView:_initPoint()
	if self._pointItem == nil then
		self._pointItem = self:getUserDataTb_()
	end

	local allPoint = self._gameMo:getAllPoint()

	if allPoint == nil then
		return
	end

	for _, pointmo in pairs(allPoint) do
		local item = self._pointItem[pointmo.id]

		if item == nil then
			local point = self:getUserDataTb_()

			point.go = gohelper.clone(self._gopoint, self._gopointroot, "point" .. pointmo.id)
			point.comp = MonoHelper.addNoUpdateLuaComOnceToGo(point.go, YeShuMeiPointItem)
			point.mo = pointmo
			self._pointItem[pointmo.id] = point

			point.comp:updateInfo(pointmo)
		end
	end
end

function YeShuMeiGameView:_onDragBeginPoint(_, pointerEventData)
	if self._isReviewing then
		return
	end

	local position = pointerEventData.position
	local mousePosX, mousePosY = recthelper.screenPosToAnchorPos2(position, self.viewGO.transform)

	if YeShuMeiGameModel.instance:checkNeedCheckListEmpty() then
		local curStartPointIds = YeShuMeiGameModel.instance:getStartPointIds()

		if curStartPointIds then
			for index, pointId in ipairs(curStartPointIds) do
				local pointMo = YeShuMeiGameModel.instance:getPointById(pointId)

				if pointMo and pointMo:isInCanConnectionRange(mousePosX, mousePosY) then
					self._canDrag = true

					break
				end
			end
		end
	else
		local curStartPointId = YeShuMeiGameModel.instance:getCurStartPointId()
		local pointMo = YeShuMeiGameModel.instance:getPointById(curStartPointId)

		self._canDrag = not not (pointMo and pointMo:isInCanConnectionRange(mousePosX, mousePosY))
	end
end

function YeShuMeiGameView:_onDragPoint(_, pointerEventData)
	if not self._canDrag then
		return
	end

	local position = pointerEventData.position
	local mousePosX, mousePosY = recthelper.screenPosToAnchorPos2(position, self.viewGO.transform)
	local hasNewValidPoint = YeShuMeiGameModel.instance:checkDiffPosAndConnection(mousePosX, mousePosY)

	if hasNewValidPoint then
		local isStart = YeShuMeiGameModel.instance:getStartState()
		local pointIdList = YeShuMeiGameModel.instance:getNeedCheckPointList()
		local curStartPointIds = YeShuMeiGameModel.instance:getConfigStartPointIds()

		if not isStart then
			for _, pointId in ipairs(curStartPointIds) do
				local point = self._pointItem[pointId]

				if point and point.comp then
					point.comp:updateUI()
				end
			end

			YeShuMeiGameModel.instance:setStartState(true)
		end

		if pointIdList and #pointIdList > 0 then
			for _, pointId in ipairs(pointIdList) do
				local point = self._pointItem[pointId]

				if point and point.comp then
					point.comp:updateUI()
				end
			end

			self:checkCreateLine(pointIdList)
		end
	end

	if YeShuMeiGameModel.instance:getCurrentLevelComplete() then
		self:_updateTargetList()

		if YeShuMeiGameModel.instance:checkHaveNextLevel() then
			UIBlockMgr.instance:startBlock("YeShuMeiGameView_NextLevel")
			self:updateCurLine(nil, false)
			gohelper.setActive(self._goshadow, true)
			AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_shadow)
			gohelper.setActive(self._godrag, false)
			gohelper.setActive(self._btnreview.gameObject, false)
			TaskDispatcher.runDelay(self._toNextLevel, self, self._finishShowShadowTime)
		else
			self:_finishGame()
		end
	else
		local currentPointList = YeShuMeiGameModel.instance:getNeedCheckPointList() or {}

		self:updateCurLine(currentPointList, true, mousePosX, mousePosY)
	end
end

function YeShuMeiGameView:_toNextLevel()
	UIBlockMgr.instance:endBlock("YeShuMeiGameView_NextLevel")
	TaskDispatcher.cancelTask(self._toNextLevel, self)
	self._shadowAnimator:Play("out", 0, 0)
	self._pointRootAnimator:Play("out", 0, 0)
	self._lineRootAnimator:Play("out", 0, 0)
	TaskDispatcher.runDelay(self._animShadowOut, self, self._shadowAnimOutTime)
end

function YeShuMeiGameView:_animShadowOut()
	TaskDispatcher.cancelTask(self._animShadowOut, self)
	gohelper.setActive(self._goshadow, false)
	gohelper.setActive(self._godrag, true)
	self:_updateTargetList()
	YeShuMeiGameModel.instance:setNextLevelGame()
	self:setNextLevelGame()
end

function YeShuMeiGameView:_updateTargetList()
	local index = YeShuMeiGameModel.instance:getCurrentLevelIndex()
	local item = self._targetItemList[index]

	if item then
		gohelper.setActive(item.gook, true)
		gohelper.setActive(item.govx, true)
	end
end

function YeShuMeiGameView:_finishGame()
	self:updateCurLine(nil, false)
	gohelper.setActive(self._goshadow, true)
	gohelper.setActive(self._godrag, false)
	gohelper.setActive(self._goreview, false)
	gohelper.setActive(self._goComplete, true)
	AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_finish)
	TaskDispatcher.runDelay(self._gameFinish, self, self._finishShowShadowTime)
end

function YeShuMeiGameView:_gameFinish()
	TaskDispatcher.cancelTask(self._gameFinish, self)
	gohelper.setActive(self._btncomplete.gameObject, true)
end

function YeShuMeiGameView:_onDragEndPoint(_, pointerEventData)
	if YeShuMeiGameModel.instance:getCurrentLevelComplete() then
		self:_updateTargetList()

		if YeShuMeiGameModel.instance:checkHaveNextLevel() then
			UIBlockMgr.instance:startBlock("YeShuMeiGameView_NextLevel")
			self:updateCurLine(nil, false)
			TaskDispatcher.runDelay(self._toNextLevel, self, self._finishShowShadowTime)
		else
			self:_finishGame()
		end
	else
		local pointIdList = YeShuMeiGameModel.instance:getNeedCheckPointList()

		if pointIdList and #pointIdList < 2 then
			self:resetPoint(pointIdList)
			YeShuMeiGameModel.instance:setStartState(false)
			YeShuMeiGameModel.instance:resetToLastConnection()

			local curStartPointIds = YeShuMeiGameModel.instance:getConfigStartPointIds()

			for _, pointId in ipairs(curStartPointIds) do
				local point = self._pointItem[pointId]

				if point and point.comp then
					point.comp:updateUI()
				end
			end
		else
			local errorIdList = YeShuMeiGameModel.instance:getCurStartPointAfter()

			YeShuMeiGameModel.instance:checkCorrectConnection()
			self:checkDeleteLineAndResetPoint(errorIdList)
		end
	end

	self:updateCurLine(nil, false)
	YeShuMeiController.instance:dispatchEvent(YeShuMeiEvent.OnDragGuideFinish)

	self._canDrag = false
end

function YeShuMeiGameView:checkCreateLine(pointIdList)
	if not pointIdList or #pointIdList < 2 then
		return
	else
		for i = 1, #pointIdList - 1 do
			local beginPoint = self._pointItem[pointIdList[i]]
			local endPoint = self._pointItem[pointIdList[i + 1]]

			if beginPoint and endPoint and not YeShuMeiGameModel.instance:checkLineExist(beginPoint.comp.id, endPoint.comp.id) then
				local lineMo = YeShuMeiGameModel.instance:addLines(beginPoint.comp.id, endPoint.comp.id)
				local line = self:createLine()

				line.comp:initData(lineMo)
				line.comp:updatePoint(beginPoint.comp, endPoint.comp)

				if self._lineItemList == nil then
					self._lineItemList = {}
				end

				self._lineItemList[lineMo.id] = line

				if YeShuMeiGameModel.instance:getWrong() then
					AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_wrong)
				else
					AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_right)
				end
			end
		end

		YeShuMeiController.instance:dispatchEvent(YeShuMeiEvent.OnDragGuideFinish)
	end
end

function YeShuMeiGameView:checkDeleteLineAndResetPoint(errorIdList)
	local pointIdList = YeShuMeiGameModel.instance:getNeedCheckPointList()

	if not pointIdList then
		self:_clearLines()
	else
		if #pointIdList < 2 then
			self:resetPoint(pointIdList)
			YeShuMeiGameModel.instance:resetToLastConnection()
			YeShuMeiGameModel.instance:setStartState(false)

			local curStartPointIds = YeShuMeiGameModel.instance:getConfigStartPointIds()

			for _, pointId in ipairs(curStartPointIds) do
				local point = self._pointItem[pointId]

				if point and point.comp then
					point.comp:updateUI()
				end
			end
		end

		if errorIdList and #errorIdList > 0 then
			for index, errorId in ipairs(errorIdList) do
				local lineMo = YeShuMeiGameModel.instance:getLineMoByErrorId(errorId)

				if lineMo then
					local lineItem = self._lineItemList[lineMo.id]

					lineItem.comp:onDestroy()
					gohelper.destroy(lineItem.go)

					lineItem = nil

					YeShuMeiGameModel.instance:deleteLines({
						lineMo.id
					})
				end
			end

			self:resetPoint(errorIdList)
		end
	end
end

function YeShuMeiGameView:createLine()
	local line = self:getUserDataTb_()

	line.go = gohelper.clone(self._goline, self._golineroot, "line")
	line.comp = MonoHelper.addNoUpdateLuaComOnceToGo(line.go, YeShuMeiLineItem)

	gohelper.setActive(line.go, true)

	return line
end

function YeShuMeiGameView:_clearLines()
	YeShuMeiGameModel.instance:deleteLines()

	if self._lineItemList and #self._lineItemList > 0 then
		for _, item in ipairs(self._lineItemList) do
			item.comp:onDestroy()
			gohelper.destroy(item.go)
		end
	end
end

function YeShuMeiGameView:resetPoint(errorIdList)
	if errorIdList and #errorIdList > 0 then
		for _, pointId in ipairs(errorIdList) do
			local pointMo = YeShuMeiGameModel.instance:getPointById(pointId)

			pointMo:clearPoint()

			local point = self._pointItem[pointId]

			point.comp:updateUI()
		end
	end
end

function YeShuMeiGameView:updateCurLine(pointIdList, active, posX, posY)
	if not active and self._curShowLine and self._curLinePointId then
		self:recycleLineGo(self._curShowLine)

		self._curShowLine = nil

		return
	end

	if pointIdList == nil or #pointIdList == 0 then
		return
	end

	local pointId = pointIdList[#pointIdList]

	if self._curLinePointId ~= pointId and self._curShowLine ~= nil then
		self:recycleLineGo(self._curShowLine)

		self._curShowLine = nil
	end

	if pointId ~= nil and active and self._curShowLine == nil then
		self._curShowLine = self:getLineObject()

		local point = YeShuMeiGameModel.instance:getPointById(pointId)

		if point then
			local startX, startY = point:getPosXY()

			self:setLineData(self._curShowLine, startX, startY, posX or startX, posY or startY)
			gohelper.setActive(self._curShowLine.go, true)
		end

		self._curLinePointId = pointId
	end

	if self._curShowLine ~= nil then
		local point = YeShuMeiGameModel.instance:getPointById(pointId)

		if point then
			local startX, startY = point:getPosXY()

			self:setLineData(self._curShowLine, startX, startY, posX or startX, posY or startY)
		end
	end
end

function YeShuMeiGameView:setLineData(showLine, beginX, beginY, endX, endY)
	local lineTr = showLine.transform

	transformhelper.setLocalPosXY(lineTr, beginX, beginY)

	local width = MathUtil.vec2_length(beginX, beginY, endX, endY)

	recthelper.setWidth(lineTr, width)

	local angle = MathUtil.calculateV2Angle(endX, endY, beginX, beginY)

	transformhelper.setEulerAngles(lineTr, 0, 0, angle)

	local isWrong = YeShuMeiGameModel.instance:getWrong()

	gohelper.setActive(showLine.gonormal, not isWrong)
	gohelper.setActive(showLine.godisturb, isWrong)
end

function YeShuMeiGameView:getLineObject()
	if self._lineItemPools == nil then
		local maxCount = 20

		self._lineItemPools = LuaObjPool.New(maxCount, function()
			local showLine = self:getUserDataTb_()

			showLine.go = gohelper.cloneInPlace(self._goshowline, "showLine")
			showLine.transform = showLine.go.transform
			showLine.gonormal = gohelper.findChild(showLine.go, "#go_normal")
			showLine.godisturb = gohelper.findChild(showLine.go, "#go_disturb")

			return showLine
		end, function(showLine)
			if showLine then
				gohelper.destroy(showLine.go)
			end
		end, function(showLine)
			if showLine then
				gohelper.setActive(showLine.go, false)
				gohelper.setActive(showLine.gonormal, true)
				gohelper.setActive(showLine.godisturb, false)
			end
		end)
	end

	return (self._lineItemPools:getObject())
end

function YeShuMeiGameView:recycleLineGo(showLine)
	if showLine == nil then
		return
	end

	gohelper.setActive(showLine.gameObject, false)

	if self._lineItemPools ~= nil then
		self._lineItemPools:putObject(showLine)
	end
end

function YeShuMeiGameView:setNextLevelGame()
	self:_deletePoint()
	self:_clearLines()
	self:_showShadow(true)

	self._canDrag = false
	self._gameMo = YeShuMeiGameModel.instance:getGameMo()
end

function YeShuMeiGameView:_onBtnComlete()
	YeShuMeiController.instance:_onGameFinished(VersionActivity3_1Enum.ActivityId.YeShuMei, self._episodeId)
end

function YeShuMeiGameView:_showGuideDrag(param)
	local visible = tonumber(param) == 1

	gohelper.setActive(self._goguid, visible)
end

function YeShuMeiGameView:onClose()
	TaskDispatcher.cancelTask(self._toNextLevel, self)
	TaskDispatcher.cancelTask(self._afterShowShadow, self)
	TaskDispatcher.cancelTask(self._initGame, self)
	TaskDispatcher.cancelTask(self._gameFinish, self)
	TaskDispatcher.cancelTask(self._animShadowOut, self)
	TaskDispatcher.cancelTask(self._switchShowShadow, self)
	TaskDispatcher.cancelTask(self._onClickUp, self)
	TaskDispatcher.cancelTask(self._onClickShadowOut, self)
end

return YeShuMeiGameView
