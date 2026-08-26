-- chunkname: @modules/logic/commandstation/view/CommandStationPaperView.lua

module("modules.logic.commandstation.view.CommandStationPaperView", package.seeall)

local CommandStationPaperView = class("CommandStationPaperView", BaseView)

function CommandStationPaperView:onInitView()
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._goTaskRed = gohelper.findChild(self.viewGO, "#btn_task/#go_reddot")
	self._btnCompose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Panel/#btn_compose")
	self._animCompose = self._btnCompose:GetComponent(typeof(UnityEngine.Animation))
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Panel/#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Panel/#btn_Right")
	self._goRightRed = gohelper.findChild(self.viewGO, "Right/Panel/#btn_Right/#go_reddot")
	self._goschedule = gohelper.findChild(self.viewGO, "Right/Schedule")
	self._godone = gohelper.findChild(self.viewGO, "Right/Done")
	self._btnDish = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Done/#simage_Disk")
	self._simageDish = gohelper.findChildSingleImage(self.viewGO, "Right/Done/#simage_Disk")
	self._txtNum1 = gohelper.findChildText(self.viewGO, "Right/Schedule/#txt_Num1")
	self._txtNum2 = gohelper.findChildText(self.viewGO, "Right/Schedule/#txt_Num1/#txt_Num2")
	self._gobuttom = gohelper.findChild(self.viewGO, "Right/Panel/Bottom")
	self._goitem = gohelper.findChild(self.viewGO, "Right/Panel/Bottom/Layout/#go_Item")
	self._paperRoot = gohelper.findChild(self.viewGO, "Right/Panel/#go_paper")
end

function CommandStationPaperView:addEvents()
	self._btnDish:AddClickListener(self.onClickDish, self)
	self._btnTask:AddClickListener(self._onTaskClick, self)
	self._btnCompose:AddClickListener(self._onComposeClick, self)
	self._btnLeft:AddClickListener(self._onChangePage, self, -1)
	self._btnRight:AddClickListener(self._onChangePage, self, 1)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnPaperUpdate, self.onPaperUpdate, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

function CommandStationPaperView:removeEvents()
	self._btnDish:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnCompose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnPaperUpdate, self.onPaperUpdate, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

function CommandStationPaperView:onOpen()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tocode_video", false)

	self._viewOpenTime = Time.realtimeSinceStartup
	self._itemNum = CommandStationConfig.instance:getCurPaperCount()

	RedDotController.instance:addRedDot(self._goTaskRed, RedDotEnum.DotNode.CommandStationTask)

	self._paperList = CommandStationConfig.instance:getPaperList()
	self._curPaperIndex = Mathf.Clamp(CommandStationModel.instance.paper + 1, 1, #self._paperList)

	gohelper.setActive(self._gobuttom, #self._paperList > 1)
	self:initPaper()

	self._goPoints = self._goPoints or self:getUserDataTb_()

	if #self._paperList > 1 then
		gohelper.CreateObjList(self, self._createPoint, self._paperList, nil, self._goitem)
	end

	self:_checkCanCompose()
	self:refreshPaperCountAndPlayAudio()
end

function CommandStationPaperView:_createPoint(obj, data, index)
	self._goPoints[index] = gohelper.findChild(obj, "#go_Light")
end

function CommandStationPaperView:_checkCanCompose()
	self._canCompose = false

	local nowPaperCo = self._paperList[CommandStationModel.instance.paper + 1]

	if not nowPaperCo then
		return
	end

	if self._itemNum >= CommandStationConfig.instance:getCurTotalPaperCount(nowPaperCo.versionId) then
		self._canCompose = true
	end
end

function CommandStationPaperView:_onViewClose(viewName)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if viewName == ViewName.FullScreenVideoView then
		return
	end

	local itemNum = CommandStationConfig.instance:getCurPaperCount()
	local itemChange = false

	if itemNum ~= self._itemNum then
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_wenming_cards_effect)

		itemChange = true
		self._itemNum = itemNum
		self._curPaperIndex = Mathf.Clamp(CommandStationModel.instance.paper + 1, 1, #self._paperList)

		self:_checkCanCompose()
	end

	self:refreshPaperCount(itemChange)

	if self._needPlayDoneAnim then
		self._needPlayDoneAnim = nil

		ZProj.TweenHelper.DOAnchorPosY(self._paperContents[self._curPaperIndex], 0, 0.2, self._playDoneAnim, self)
		UIBlockHelper.instance:startBlock("CommandStationPaperView_tweenPosY", 0.2)
	end
end

function CommandStationPaperView:refreshPaperCountAndPlayAudio()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_paper2)
	self:refreshPaperCount()
end

function CommandStationPaperView:refreshPaperCount(isPlayAnim)
	local totalNum = self._paperList[self._curPaperIndex].allNum
	local nowNum = totalNum
	local isLastUnlock = self._curPaperIndex == CommandStationModel.instance.paper + 1

	if isLastUnlock then
		local prePaperCo = self._paperList[self._curPaperIndex - 1]
		local preTotalNum = prePaperCo and CommandStationConfig.instance:getCurTotalPaperCount(prePaperCo.versionId) or 0

		nowNum = CommandStationConfig.instance:getCurPaperCount() - preTotalNum
	elseif self._curPaperIndex > CommandStationModel.instance.paper + 1 then
		nowNum = 0
	end

	nowNum = Mathf.Clamp(nowNum, 0, totalNum)

	local preCount = self._preItemCount

	preCount = isLastUnlock and isPlayAnim and preCount or nowNum

	if preCount < nowNum then
		self:scrollTo(preCount + 1)
	end

	if isLastUnlock then
		self._preItemCount = nowNum
	end

	local isDone = self._curPaperIndex <= CommandStationModel.instance.paper

	gohelper.setActive(self._paperDones[self._curPaperIndex], isDone and not self._needPlayDoneAnim)
	gohelper.setActive(self._goschedule, not isDone)
	gohelper.setActive(self._godone, isDone)

	if isDone then
		self._simageDish:LoadImage(ResUrl.getCommandStationPaperIcon(self._paperList[self._curPaperIndex].diskIcon))
	end

	self._txtNum1.text = nowNum
	self._txtNum2.text = totalNum

	for index, go in pairs(self._paperRoots) do
		gohelper.setActive(go, index == self._curPaperIndex)
	end

	local markInfo = self._paperMarkDict[self._curPaperIndex]

	if markInfo then
		local paperConfig = self._paperList[self._curPaperIndex]

		self:_playAnim(markInfo.afterMark, nowNum, preCount, paperConfig)
		self:_playAnim(markInfo.beforeMark, nowNum, preCount, paperConfig)
	end

	gohelper.setActive(self._btnCompose, totalNum <= nowNum and isLastUnlock and not isPlayAnim)
	gohelper.setActive(self._btnLeft, self._curPaperIndex ~= 1)
	gohelper.setActive(self._btnRight, self._curPaperIndex ~= #self._paperList)
	gohelper.setActive(self._goRightRed, self._canCompose and not isLastUnlock)

	for index, go in pairs(self._goPoints) do
		gohelper.setActive(go, index == self._curPaperIndex)
	end

	if isPlayAnim and totalNum <= nowNum and isLastUnlock then
		TaskDispatcher.runDelay(self._delayShowComposeBtn, self, 0.667)
	else
		TaskDispatcher.cancelTask(self._delayShowComposeBtn, self)
	end
end

function CommandStationPaperView:_delayShowComposeBtn()
	if not self._animCompose then
		return
	end

	gohelper.setActive(self._btnCompose, true)
	self._animCompose:Play()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_tangren_pen1)
end

function CommandStationPaperView:_playAnim(list, nowNum, preCount, paperConfig)
	for i, comp in pairs(list) do
		local orderIndex = self:_getOrderIndex(i, paperConfig)

		if nowNum < orderIndex then
			comp:playAnim(1)
		elseif preCount < orderIndex then
			comp:playAnim(2)
		else
			comp:playAnim(3)
		end
	end
end

function CommandStationPaperView:_getOrderIndex(i, paperConfig)
	local index = i

	if paperConfig.order and #paperConfig.order > 0 then
		index = tabletool.indexOf(paperConfig.order, i)

		if not index then
			index = i

			logError(string.format("paperConfig id:%s,order is not contain index %s", paperConfig.id, i))
		end
	end

	return index
end

function CommandStationPaperView:scrollTo(orderIndex)
	local paperConfig = self._paperList[self._curPaperIndex]

	if not paperConfig.order[orderIndex] then
		local index = orderIndex
		local markInfo = self._paperMarkDict[self._curPaperIndex]

		if not markInfo or not markInfo.afterMark[index] then
			return
		end

		local trans = markInfo.afterMark[index].transform
		local content = self._paperContents[self._curPaperIndex]
		local localPos = content:InverseTransformPoint(trans.position)
		local height = 80
		local contentHeight = recthelper.getHeight(content)
		local contentParentHeight = recthelper.getHeight(content.parent)
		local posY = -localPos.y - height / 2 - 5 - 200

		posY = Mathf.Clamp(posY, 0, contentHeight - contentParentHeight)

		recthelper.setAnchorY(content, posY)
	end
end

function CommandStationPaperView:_playDoneAnim()
	gohelper.setActive(self._paperDones[self._curPaperIndex], true)
	self._paperDonesAnim[self._curPaperIndex]:Play()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_diqiu_yure_success)
end

function CommandStationPaperView:_onChangePage(num)
	if self._curPaperIndex + num > CommandStationModel.instance.paper + 1 then
		GameFacade.showToast(ToastEnum.CommandStationPaperSwitch)

		return
	end

	self._curPaperIndex = self._curPaperIndex + num
	self._anim.enabled = true

	if num > 0 then
		self._anim:Play("switchright", 0, 0)
	else
		self._anim:Play("switchleft", 0, 0)
	end

	UIBlockHelper.instance:startBlock("CommandStationPaperView_switch", 0.167)
	TaskDispatcher.runDelay(self.refreshPaperCountAndPlayAudio, self, 0.167)
end

function CommandStationPaperView:_showBgByUid(bgSingleImage)
	if not bgSingleImage then
		logError("_showBgByUid bgSingleImage is nil")

		return
	end

	local uid = tostring(PlayerModel.instance:getMyUserId())
	local uidLength = string.len(uid)

	if uidLength < 2 then
		logError("_showBgByUid uidLength < 2")

		return
	end

	local str = string.sub(uid, uidLength - 1, uidLength)
	local value = tonumber(str)

	if not value then
		logError("_showBgByUid value is nil")

		return
	end

	if value <= 24 then
		bgSingleImage:LoadImage("singlebg/commandstation/paper/commandstation_paper_panelbg7_1_2.png")
	elseif value <= 49 then
		bgSingleImage:LoadImage("singlebg/commandstation/paper/commandstation_paper_panelbg7_1_3.png")
	elseif value <= 74 then
		bgSingleImage:LoadImage("singlebg/commandstation/paper/commandstation_paper_panelbg7_1_4.png")
	else
		bgSingleImage:LoadImage("singlebg/commandstation/paper/commandstation_paper_panelbg7_1_5.png")
	end
end

function CommandStationPaperView:initPaper()
	if self._paperRoots then
		return
	end

	self._paperRoots = self:getUserDataTb_()
	self._paperContents = self:getUserDataTb_()
	self._paperDones = self:getUserDataTb_()
	self._paperDonesAnim = self:getUserDataTb_()
	self._paperMarkDict = {}

	local trans = self._paperRoot.transform

	for i = 0, trans.childCount - 1 do
		local child = trans:GetChild(i)
		local index = string.match(child.name, "^#go_paper(%d+)$")

		index = tonumber(index)

		if index then
			self._paperRoots[index] = child.gameObject
			self._paperContents[index] = gohelper.findChild(self._paperRoots[index], "Panel/ViewPort/Content").transform
			self._paperDones[index] = gohelper.findChild(self._paperRoots[index], "Panel/ViewPort/Content/#go_Done")
			self._paperDonesAnim[index] = gohelper.findChild(self._paperRoots[index], "Panel/ViewPort/Content/#go_Done/ani"):GetComponent(typeof(UnityEngine.Animation))
			self._paperMarkDict[index] = {
				afterMark = self:getUserDataTb_(),
				beforeMark = self:getUserDataTb_()
			}

			local afterMarkRoot = gohelper.findChild(self._paperRoots[index], "Panel/ViewPort/Content/AfterMark")
			local beforeMarkRoot = gohelper.findChild(self._paperRoots[index], "Panel/ViewPort/Content/BeforeMark")

			afterMarkRoot = afterMarkRoot and afterMarkRoot.transform
			beforeMarkRoot = beforeMarkRoot and beforeMarkRoot.transform

			local paperConfig = self._paperList[index]

			if paperConfig and paperConfig.viewType == CommandStationEnum.PaperViewType.Uid then
				local bgSingleImage = gohelper.findChildSingleImage(self._paperRoots[index], "Panel/ViewPort/Content/image_PanelBG1")

				self:_showBgByUid(bgSingleImage)
			end

			if afterMarkRoot then
				for j = 0, afterMarkRoot.childCount - 1 do
					local afterChild = afterMarkRoot:GetChild(j)
					local afterIndex, style = string.match(afterChild.name, "^#go_(%d+)_(%d+)$")

					afterIndex = tonumber(afterIndex)
					style = tonumber(style)

					if afterIndex then
						self._paperMarkDict[index].afterMark[afterIndex] = MonoHelper.addNoUpdateLuaComOnceToGo(afterChild.gameObject, CommandStationPaperMarkItem, {
							after = true,
							style = style
						})
					end
				end
			end

			if beforeMarkRoot then
				for j = 0, beforeMarkRoot.childCount - 1 do
					local beforeChild = beforeMarkRoot:GetChild(j)
					local beforeIndex, style = string.match(beforeChild.name, "^#go_(%d+)_(%d+)$")

					beforeIndex = tonumber(beforeIndex)
					style = tonumber(style)

					if beforeIndex then
						self._paperMarkDict[index].beforeMark[beforeIndex] = MonoHelper.addNoUpdateLuaComOnceToGo(beforeChild.gameObject, CommandStationPaperMarkItem, {
							after = false,
							style = style
						})
					end
				end
			end
		end
	end
end

function CommandStationPaperView:_onTaskClick()
	CommandStationController.instance:openCommandStationTaskView()
end

function CommandStationPaperView:_onComposeClick()
	CommandStationRpc.instance:sendCommandPostPaperRequest()
end

function CommandStationPaperView:onPaperUpdate()
	self:_checkCanCompose()

	self._anim.enabled = true

	self._anim:Play("rightout", 0, 0)
	TaskDispatcher.runDelay(self._delayShowVideo, self, 0.333)
	UIBlockHelper.instance:startBlock("CommandStationPaperView_rightout", 0.333)
end

function CommandStationPaperView:_delayShowVideo()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_poyi)
	VideoController.instance:openFullScreenVideoView("commandstation_decode", nil, 10, self._onVideoEnd, self)
end

function CommandStationPaperView:_onVideoEnd()
	ViewMgr.instance:openView(ViewName.CommandStationPaperGetView, {
		paperCo = self._paperList[self._curPaperIndex]
	})
	self._anim:Play("rightin", 0, 0)
	TaskDispatcher.runDelay(self.refreshPaperCountAndPlayAudio, self, 0.633)
	UIBlockHelper.instance:startBlock("CommandStationPaperView_rightin", 0.633)

	self._needPlayDoneAnim = true
end

function CommandStationPaperView:onClickDish()
	ViewMgr.instance:openView(ViewName.CommandStationPaperGetView, {
		isDone = true,
		paperCo = self._paperList[self._curPaperIndex]
	})
end

function CommandStationPaperView:onClose()
	TaskDispatcher.cancelTask(self._delayShowComposeBtn, self)
	TaskDispatcher.cancelTask(self.refreshPaperCount, self)
	TaskDispatcher.cancelTask(self._delayShowVideo, self)
	CommandStationController.StatCommandStationViewClose(self.viewName, Time.realtimeSinceStartup - self._viewOpenTime)
end

function CommandStationPaperView:onDestroyView()
	if self._paperMarkDict then
		for _, v in pairs(self._paperMarkDict) do
			for _, vv in pairs(v.afterMark) do
				vv:destroy()
			end

			for _, vv in pairs(v.beforeMark) do
				vv:destroy()
			end
		end
	end
end

return CommandStationPaperView
