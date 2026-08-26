-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueGameView.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueGameView", package.seeall)

local LiangYueGameView = class("LiangYueGameView", BaseView)

function LiangYueGameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._simagePanelPaper = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_PanelPaper")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Left/Top/#txt_Descr")
	self._txtTarget = gohelper.findChildText(self.viewGO, "Left/Game/Target/#txt_Target")
	self._goTick = gohelper.findChild(self.viewGO, "Left/Game/Target/#go_Tick")
	self._goGridBg = gohelper.findChild(self.viewGO, "Left/Game/Grid/image_Grid")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer")
	self._txtattribute = gohelper.findChildText(self.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer/image/#txt_attribute")
	self._goillustrationContainer = gohelper.findChild(self.viewGO, "Left/Game/Grid/#go_Grid/#go_illustrationContainer")
	self._godragItem = gohelper.findChild(self.viewGO, "Left/Game/Grid/#go_Grid/#go_illustrationContainer/#go_dragItem")
	self._goPiecesList = gohelper.findChild(self.viewGO, "Right/#go_PiecesList")
	self._scrollPieces = gohelper.findChildScrollRect(self.viewGO, "Right/#go_PiecesList/#scroll_Pieces")
	self._goillstrationItem = gohelper.findChild(self.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem")
	self._imagePiece = gohelper.findChildImage(self.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem/#image_Piece")
	self._goLine = gohelper.findChild(self.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem/#go_Line")
	self._scrollText = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_Text")
	self._goItem = gohelper.findChild(self.viewGO, "Right/#scroll_Text/Viewport/Content/#go_Item")
	self._goCompleted = gohelper.findChild(self.viewGO, "Right/#go_Completed")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._btnfinished = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Finished")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Reset")
	self._txtTitle = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Title")
	self._goContent = gohelper.findChild(self.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content")
	self._goScrollIllustration = gohelper.findChild(self.viewGO, "Right/#go_PiecesList/#scroll_Pieces")
	self._goScrollText = gohelper.findChild(self.viewGO, "Right/#scroll_Text")
	self._goImageBg = gohelper.findChild(self.viewGO, "Left/Game/Grid/image_Grid")
	self._clickMeshContainer = gohelper.findChildClick(self.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer")
	self._txtYear = gohelper.findChildText(self.viewGO, "Left/Top/txt_1999")
	self._txtMonth = gohelper.findChildText(self.viewGO, "Left/Top/txt_Month")
	self._txtDay = gohelper.findChildText(self.viewGO, "Left/Top/txt_Day")
	self._txtStory = gohelper.findChildTextMesh(self._goItem, "")
	self._goVxEnable = gohelper.findChild(self.viewGO, "Left/Game/vx_enough")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LiangYueGameView:addEvents()
	self._clickMeshContainer:AddClickListener(self._onMeshContainerClick, self)
	self._btnfinished:AddClickListener(self.onClickFinished, self)
	self._btnreset:AddClickListener(self.onBtnResetClick, self)
	self.addEventCb(self, LiangYueController.instance, LiangYueEvent.OnFinishEpisode, self.onEpisodeFinish, self)
	self.addEventCb(self, LiangYueController.instance, LiangYueEvent.OnReceiveEpisodeInfo, self._refreshView, self)
	self._illustrationDragListener:AddDragBeginListener(self._onItemBeginDrag, self)
	self._illustrationDragListener:AddDragListener(self._onItemDrag, self)
	self._illustrationDragListener:AddDragEndListener(self._onItemEndDrag, self)
end

function LiangYueGameView:removeEvents()
	self._clickMeshContainer:RemoveClickListener()
	self._btnfinished:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self.removeEventCb(self, LiangYueController.instance, LiangYueEvent.OnFinishEpisode, self.onEpisodeFinish, self)
	self.removeEventCb(self, LiangYueController.instance, LiangYueEvent.OnReceiveEpisodeInfo, self._refreshView, self)
	self._illustrationDragListener:RemoveDragBeginListener()
	self._illustrationDragListener:RemoveDragListener()
	self._illustrationDragListener:RemoveDragEndListener()
end

function LiangYueGameView:onClickFinished()
	if self._isDrag then
		return
	end

	local meshWidth = self._meshSize[1]
	local result = {}

	for index, id in pairs(self._illustrationIndexDic) do
		if not self:_isStaticIllustration(index) then
			local tempX = (index - 1) % meshWidth + 1
			local tempY = math.floor((index - 1) / meshWidth) + 1
			local param = string.format("%s#%s#%s", tempX, tempY, id)

			table.insert(result, param)
		end
	end

	local resultStr = table.concat(result, "|")

	logNormal("Result: " .. resultStr)
	LiangYueController.instance:finishEpisode(self._actId, self._episodeId, resultStr)
end

function LiangYueGameView:onEpisodeFinish(actId, episodeId)
	if self._actId ~= actId or self._episodeId ~= episodeId then
		return
	end

	local isFinish = LiangYueModel.instance:isEpisodeFinish(actId, episodeId)

	if isFinish then
		self:statData(LiangYueEnum.StatGameState.Finish)
	end

	self._animator:Play("finish", 0, 0)

	self._isFinish = isFinish

	self:_lockScreen(true)
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_aizila_forward_paper)
	TaskDispatcher.runDelay(self.delayFinishAnim, self, LiangYueEnum.FinishAnimDelayTime)
	TaskDispatcher.runDelay(self.delayFinishAnimEnd, self, LiangYueEnum.FinishAnimDelayTimeEnd)
end

function LiangYueGameView:delayFinishAnim()
	TaskDispatcher.cancelTask(self.delayFinishAnim, self)

	for _, item in pairs(self._usedDragItemDic) do
		item:setAttributeState(false)
	end

	self:_refreshCompleteState()
end

function LiangYueGameView:delayFinishAnimEnd()
	TaskDispatcher.cancelTask(self.delayFinishAnimEnd, self)
	self:_lockScreen(false)
	self:_refreshFinishBtnState()
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_pen2)
end

function LiangYueGameView:onBtnResetClick()
	if self._isDrag then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.LiangYueResetTip, MsgBoxEnum.BoxType.Yes_No, self.resetGame, nil, nil, self)
end

function LiangYueGameView:resetGame()
	if next(self._illustrationUseDic) == nil then
		return
	end

	self:_beforeAttributeChanged()
	self:statData(LiangYueEnum.StatGameState.Restart)

	self._resetTime = ServerTime.now()
	self._enterTime = ServerTime.now()

	local meshWidth = self._meshSize[1]

	for index, id in pairs(self._illustrationIndexDic) do
		if not self:_isStaticIllustration(index) then
			local tempX = (index - 1) % meshWidth + 1
			local tempY = math.floor((index - 1) / meshWidth) + 1

			self:_ClearMesh(tempX, tempY, id)
		end
	end

	self:_afterAttributeChanged()
end

function LiangYueGameView:_beforeAttributeChanged()
	self._tempParam = tabletool.copy(self._paramDic)

	TaskDispatcher.cancelTask(self._resetAttributeState, self)
end

function LiangYueGameView:_afterAttributeChanged()
	for id, animComp in ipairs(self._attributeAnimList) do
		if not self._tempParam[id] then
			if not self._paramDic[id] then
				local currentNum = 0
				local animName

				if self._tempParam[id] < currentNum then
					animName = LiangYueEnum.AttributeAnim.Up
				elseif currentNum < self._tempParam[id] then
					animName = LiangYueEnum.AttributeAnim.Down

					local item = self._targetDescItemList[id]

					if item == nil then
						logError("动画组件和实际lua脚本组件数量不对应")
					else
						item:setTxtColor(LiangYueEnum.AttributeDownColor)
					end
				else
					animName = LiangYueEnum.AttributeAnim.Empty
				end

				animComp.enabled = true

				animComp:Play(animName, 0, 0)
			end
		end
	end

	TaskDispatcher.runDelay(self._resetAttributeState, self, LiangYueEnum.AttributeAnimRevertTime)

	self._tempParam = nil
end

function LiangYueGameView:_resetAttributeState()
	TaskDispatcher.cancelTask(self._resetAttributeState, self)

	for id, animComp in ipairs(self._attributeAnimList) do
		if animComp.gameObject.activeSelf == true then
			if not self._paramDic[id] then
				if not self._targetParamDic[id] then
					local targetParam = 0
					local item = self._targetDescItemList[id]

					if targetParam <= self._paramDic[id] then
						if not LiangYueEnum.AttributeColor[id] then
							local color = LiangYueEnum.AttributeNotEnoughColor

							animComp:Play(LiangYueEnum.AttributeAnim.Empty, 0, 0)
							item:setTxtColor(color)
						end
					end
				end
			end
		end
	end
end

function LiangYueGameView:_onMeshContainerClick(param, pointerEventData, offset, ignoreAudio)
	if self._isFinish or self._isDrag then
		return nil, nil, nil
	end

	local currentDragPos = recthelper.screenPosToAnchorPos(pointerEventData, self._gomeshContainer.transform)
	local x, y = self:_getMeshPosByIndex(currentDragPos.x, currentDragPos.y)

	if not self._meshData[y] or not self._meshData[y][x] then
		return nil, nil, nil
	end

	local illustrationIndex = self._meshData[y][x]

	if self:_isStaticIllustration(illustrationIndex) then
		ToastController.instance:showToast(ToastEnum.Act184PuzzleCanNotMove)

		return nil, nil, nil
	end

	if not ignoreAudio then
		AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_delete)
	end

	local illustrationPos = self._illustrationPosDic[illustrationIndex]
	local illustrationId = self._illustrationIndexDic[illustrationIndex]

	self:_beforeAttributeChanged()
	self:_ClearMesh(illustrationPos[1], illustrationPos[2], illustrationId)
	self:_afterAttributeChanged()

	return illustrationId, illustrationPos[1], illustrationPos[2]
end

function LiangYueGameView:_editableInitView()
	self._illustrationDragListener = SLFramework.UGUI.UIDragListener.Get(self._gomeshContainer)

	gohelper.setActive(self._godragItem, false)
	gohelper.setActive(self._goillstrationItem, false)
	self:_initAttributeComp()
end

function LiangYueGameView:onUpdateParam()
	return
end

function LiangYueGameView:_initAttributeComp()
	self._targetDescItemList = {}

	local goTarget = gohelper.findChild(self.viewGO, "Left/Game/TargetIcon")

	self._goTarget = goTarget
	self._attributeAnimList = {}

	local childCount = self._goTarget.transform.childCount

	for i = 1, childCount do
		local child = goTarget.transform:GetChild(i - 1)
		local item = LiangYueAttributeDescItem.New()

		item:init(child.gameObject)
		table.insert(self._targetDescItemList, item)

		local anim = gohelper.findChildAnim(child.gameObject, "")

		table.insert(self._attributeAnimList, anim)
	end

	self._animator = gohelper.findChildAnim(self.viewGO, "")
end

function LiangYueGameView:_initGameData()
	self._actId = self.viewParam.actId
	self._episodeId = self.viewParam.episodeId
	self._episodeGameId = self.viewParam.episodeGameId
	self._enterTime = ServerTime.now()
	self._resetTime = ServerTime.now()
	self._meshItemList = {}
	self._dyeingMeshItemList = {}
	self._dyeingMeshItemCount = 0
	self._meshData = {}
	self._illustrationIndexDic = {}
	self._illustrationIndexList = {}
	self._illustrationCountDic = {}
	self._illustrationUseDic = {}
	self._illustrationScrollItemList = {}
	self._unusedDragItemList = {}
	self._usedDragItemDic = {}
	self._illustrationPosDic = {}
	self._staticIllustrationDic = {}
	self._paramDic = {}
	self._targetParamDic = {}
end

function LiangYueGameView:onOpen()
	self._animator:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_aizila_forward_paper)
	self:_initGameData()
	self:_refreshView()
end

function LiangYueGameView:_refreshView()
	local episodeConfig = LiangYueConfig.instance:getEpisodePuzzleConfigByActAndId(self._actId, self._episodeGameId)

	if episodeConfig == nil then
		return
	end

	self._episodeConfig = episodeConfig

	local isFinish = LiangYueModel.instance:isEpisodeFinish(self._actId, self._episodeId)

	self._isEnable = isFinish
	self._isFinish = isFinish

	if not isFinish then
		self:_refreshIllustration(episodeConfig)
	end

	self:_refreshTargetParam(episodeConfig)
	self:_resetMeshContent(episodeConfig)
	self:_refreshTitle(episodeConfig)
	self:_refreshFinishBtnState()
	self:_refreshCompleteState()
end

function LiangYueGameView:_resetMeshContent(episodeConfig)
	self._meshSize = string.splitToNumber(episodeConfig.size, "#")

	self:_rebuildMesh()
	self:_refreshMeshData()
end

function LiangYueGameView:_refreshTitle(episodeConfig)
	self._txtDescr.text = episodeConfig.titleTxt

	local timeStamp = TimeUtil.stringToTimestamp(episodeConfig.date)
	local timeParam = TimeUtil.timestampToTable(timeStamp)

	self._txtYear.text = timeParam.year
	self._txtMonth.text = string.upper(LiangYueEnum.MonthEn[timeParam.month])
	self._txtDay.text = timeParam.day
	self._txtStory.text = episodeConfig.txt
end

function LiangYueGameView:_refreshTargetParam(episodeConfig)
	tabletool.clear(self._targetParamDic)

	local param = episodeConfig.target
	local singleTargets = string.split(param, "|")

	if #singleTargets <= 0 then
		logError("no target param")

		return
	end

	for _, singleTarget in ipairs(singleTargets) do
		local singleParam = string.splitToNumber(singleTarget, "#")

		self._targetParamDic[singleParam[1]] = self._targetParamDic[singleParam[1]] or singleParam[2]
	end

	for type, item in ipairs(self._targetDescItemList) do
		item:setActive(self._targetParamDic[type] ~= nil)
	end

	self:_updateAttributeInfo()
end

function LiangYueGameView:_refreshIllustration(episodeConfig)
	self:_refreshIllustrationData(episodeConfig)
	self:_refreshIllustrationContent()
end

function LiangYueGameView:_refreshIllustrationData(episodeConfig)
	tabletool.clear(self._illustrationCountDic)
	tabletool.clear(self._illustrationUseDic)

	local param = episodeConfig.illustrationCount

	if string.nilorempty(param) then
		logError("episode puzzle count data is nil")

		return
	end

	local countDatas = string.split(param, "|")

	for _, countData in ipairs(countDatas) do
		local data = string.splitToNumber(countData, "#")

		self._illustrationCountDic[data[1]] = data[2]
	end
end

function LiangYueGameView:_refreshIllustrationContent()
	local index = 0
	local illustrationItemCount = #self._illustrationScrollItemList

	for id, count in pairs(self._illustrationCountDic) do
		index = index + 1

		local item = illustrationItemCount < index and self:_createIllustrationItem(id, index) or self._illustrationScrollItemList[index]
		local config = LiangYueConfig.instance:getIllustrationConfigById(self._actId, id)
		local meshSize = LiangYueConfig.instance:getIllustrationShape(self._actId, id)
		local aspect = #meshSize / #meshSize[1]

		if item == nil then
			logError("have no item index :" .. index)
		else
			item:setActive(true)
			item:setInfo(id, index, count, config.imageId, aspect, self._actId)
		end
	end

	if index < illustrationItemCount then
		for i = index + 1, illustrationItemCount do
			local item = self._illustrationScrollItemList[i]

			item:setActive(false)
		end
	end
end

function LiangYueGameView:_refreshMeshData()
	self._meshData = {}

	local staticIllustrationDic = LiangYueConfig.instance:getEpisodeStaticIllustrationDic(self._actId, self._episodeGameId)

	if staticIllustrationDic ~= nil then
		for y, horizontalDic in pairs(staticIllustrationDic) do
			for x, id in pairs(horizontalDic) do
				if self._meshData[y] and self._meshData[y][x] then
					logError("固定格子位置重复 位置: x:" .. y .. "y:" .. x)
				else
					self:_fillMesh(y, x, id, true)
				end
			end
		end
	end

	local mo = LiangYueModel.instance:getEpisodeInfoMo(self._actId, self._episodeId)

	if string.nilorempty(mo.puzzle) then
		return
	end

	local params = string.split(mo.puzzle, "|")

	for _, param in ipairs(params) do
		local data = string.splitToNumber(param, "#")

		if data ~= nil then
			self:_fillMesh(data[1], data[2], data[3])
		else
			logError("玩家插画数据错误： 数据格式：" .. mo.puzzle)
		end
	end
end

function LiangYueGameView:_refreshCompleteState()
	local episodeConfig = LiangYueConfig.instance:getEpisodePuzzleConfigByActAndId(self._actId, self._episodeGameId)
	local isFinish = self._isFinish

	gohelper.setActive(self._goPiecesList, not isFinish)
	gohelper.setActive(self._goScrollText, isFinish)
	gohelper.setActive(self._goCompleted, isFinish)
	gohelper.setActive(self._btnreset, not isFinish)
	gohelper.setActive(self._goGridBg.gameObject, not isFinish)

	self._txtTarget.text = self._isFinish and luaLang("act184_target_complete") or luaLang("act184_target_not_complete")

	if self._isFinish then
		if not episodeConfig.titile then
			self._txtTitle.text = luaLang("act184_puzzle_title")
		end
	end
end

function LiangYueGameView:_refreshFinishBtnState()
	if self._isEnable then
		gohelper.setActive(self._btnfinished, self._isEnable)
		gohelper.setActive(self._goVxEnable, self._isEnable)
		gohelper.setActive(self._goTick, self._isFinish)

		if self._isEnable then
			AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_pen1)
		end
	end
end

function LiangYueGameView:_fillMesh(posX, posY, id, isStatic, item)
	local meshData = self._meshData
	local offsetX = 0
	local offsetY = 0
	local isPos = false
	local params = LiangYueConfig.instance:getIllustrationShape(self._actId, id)
	local columnLength = #params
	local rowLength = #params[1]
	local illustrationIndex = (posY - 1) * self._meshSize[1] + posX

	for y = 1, columnLength do
		local data = params[y]

		for x = 1, rowLength do
			local fill = data[x] == 1

			if not isPos and fill then
				offsetX = x - 1
				offsetY = y - 1
				isPos = true
			end

			if isPos and fill then
				local meshPosY = posY - offsetY + y - 1
				local meshPosX = posX - offsetX + x - 1

				meshData[meshPosY] = meshData[meshPosY] or {}

				if meshData[meshPosY][meshPosX] then
					logError("meshFill failed posX: " .. meshPosX .. " Y " .. meshPosY)
				else
					meshData[meshPosY][meshPosX] = illustrationIndex
				end
			end
		end
	end

	local rectangleBeginPosX = posX - offsetX
	local dragItemPosStartX = (rectangleBeginPosX - 1) * self._meshWidth
	local dragItemPosEndX = (rectangleBeginPosX - 1 + rowLength) * self._meshWidth
	local centerX = (dragItemPosStartX + dragItemPosEndX) * 0.5 - self._meshMaxX
	local rectangleBeginPosY = posY - offsetY
	local startY = self._meshSize[2] - rectangleBeginPosY + 1
	local dragItemPosStartY = startY * self._meshHeight
	local endY = startY - columnLength
	local dragItemPosEndY = endY * self._meshHeight
	local centerY = (dragItemPosStartY + dragItemPosEndY) * 0.5 - self._meshMaxY

	item = item or self:_getDragItem(id, isStatic, self._isFinish)
	self._illustrationIndexDic[illustrationIndex] = id

	table.insert(self._illustrationIndexList, illustrationIndex)

	self._illustrationPosDic[illustrationIndex] = {
		posX,
		posY
	}
	self._usedDragItemDic[illustrationIndex] = item

	if isStatic then
		self._staticIllustrationDic[illustrationIndex] = id
	else
		self._illustrationUseDic[id] = not self._illustrationUseDic[id] and 1 or self._illustrationUseDic[id] + 1
	end

	self:_refreshIllustrationIndex()
	self:_refreshIllustrationCount()

	if isStatic or self._isFinish == true then
		recthelper.setAnchor(item.go.transform, centerX, centerY)
	else
		self._tweenItem = item

		item:setAttributeInfo(self._actId, item.id)

		self._tweenPos = ZProj.TweenHelper.DOAnchorPos(item.go.transform, centerX, centerY, LiangYueEnum.TweenDuration, self._onTweenEnd, self)
	end

	logNormal(string.format("fill illustration: pos x:%s y:%s index : x: %s y: %s", centerX, centerY, posX, posY))
end

function LiangYueGameView:_onTweenEnd()
	local item = self._tweenItem

	if item ~= nil then
		item:setItemPosY()
	end

	self._tweenItem = nil
	self._tweenPos = nil
end

function LiangYueGameView:_ClearMesh(posX, posY, id)
	local meshData = self._meshData
	local offsetX = 0
	local offsetY = 0
	local isPos = false
	local params = LiangYueConfig.instance:getIllustrationShape(self._actId, id)
	local columnLength = #params
	local rowLength = #params[1]

	for y = 1, columnLength do
		local data = params[y]

		for x = 1, rowLength do
			local fill = data[x] == 1

			if not isPos and fill then
				offsetX = x - 1
				offsetY = y - 1
				isPos = true
			end

			if isPos and fill then
				local meshPosY = posY - offsetY + y - 1
				local meshPosX = posX - offsetX + x - 1

				if not meshData[meshPosY] or not meshData[meshPosY][meshPosX] then
					logError("clear mesh failed posX: " .. meshPosX .. " Y " .. meshPosY)
				else
					meshData[meshPosY][meshPosX] = nil
				end
			end
		end
	end

	local illustrationIndex = (posY - 1) * self._meshSize[1] + posX

	self._illustrationIndexDic[illustrationIndex] = nil

	tabletool.removeValue(self._illustrationIndexList, illustrationIndex)

	local item = self._usedDragItemDic[illustrationIndex]

	self._usedDragItemDic[illustrationIndex] = nil
	self._illustrationPosDic[illustrationIndex] = nil

	if not self._illustrationUseDic[id] then
		logError("not such illustration use")
	else
		local count = self._illustrationUseDic[id] - 1

		if count <= 0 then
			self._illustrationUseDic[id] = nil
		else
			self._illustrationUseDic[id] = count
		end
	end

	self:_recycleDragItem(item)
	self:_refreshIllustrationIndex()
	self:_refreshIllustrationCount()
end

function LiangYueGameView:_refreshIllustrationCount()
	for _, item in pairs(self._illustrationScrollItemList) do
		if self._illustrationCountDic[item.id] and self._illustrationCountDic[item.id] ~= 0 then
			if not self._illustrationUseDic[item.id] then
				local useCount = 0
				local remainCount = self._illustrationCountDic[item.id] - useCount

				item:setCount(remainCount)
				item:setEnoughState(remainCount > 0)
			end
		end
	end
end

function LiangYueGameView:_getMeshPosByIndex(posX, posY)
	local minIndex = 1
	local maxIndexX = self._meshSize[1]
	local maxIndexY = self._meshSize[2]
	local mesh_X = Mathf.Clamp(math.floor((posX + self._meshMaxX) / self._meshWidth) + 1, minIndex, maxIndexX)
	local mesh_Y = Mathf.Clamp(maxIndexY - math.floor((posY + self._meshMaxY) / self._meshHeight), minIndex, maxIndexY)

	logNormal("button click mesh x:" .. mesh_X .. "mesh y:" .. mesh_Y)

	return mesh_X, mesh_Y
end

function LiangYueGameView:_refreshIllustrationIndex()
	table.sort(self._illustrationIndexList)
	tabletool.clear(self._paramDic)

	local count = 0

	for index, illustrationIndex in ipairs(self._illustrationIndexList) do
		local item = self._usedDragItemDic[illustrationIndex]

		if item == nil then
			logError("item is null index:" .. illustrationIndex)
		else
			item:setIndex(index)

			local illustrationId = self._illustrationIndexDic[illustrationIndex]
			local config = LiangYueConfig.instance:getIllustrationConfigById(self._actId, illustrationId)
			local param = config.attribute

			self:_calculateAttribute(param, self._paramDic)

			if not self._staticIllustrationDic[index] then
				count = count + 1
			end
		end
	end

	if not self._isFinish then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnDragIllustration, count)
		logNormal("OnDragIllustration Count: " .. tostring(count))
	end

	self:_updateAttributeInfo()
end

function LiangYueGameView:_updateAttributeInfo()
	local currentParamDic = self._paramDic
	local disableCount = 0

	for attributeType, target in pairs(self._targetParamDic) do
		if not currentParamDic[attributeType] then
			local currentNum = 0
			local enable = target <= currentNum

			if not enable then
				disableCount = disableCount + 1
			end

			local item = self._targetDescItemList[attributeType]

			if enable then
				if not LiangYueEnum.AttributeColor[attributeType] then
					local color = LiangYueEnum.AttributeNotEnoughColor

					item:setTargetInfo(currentNum, target, color)
				end
			end
		end
	end

	self._isEnable = disableCount <= 0

	if not self._isFinish and self._isEnable then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnAttributeMeetConditions, self._episodeId)
		logNormal("OnAttributeMeetConditions  episodeId:" .. tostring(self._episodeId))
	end

	self:_refreshFinishBtnState()
end

function LiangYueGameView:_calculateAttribute(param, paramDic)
	local singleParams = string.split(param, "|")

	for _, singleParam in ipairs(singleParams) do
		local attributeParam = string.splitToNumber(singleParam, "#")
		local attributeType = attributeParam[1]
		local calculateType = attributeParam[2]
		local attribute = attributeParam[3]

		if paramDic[attributeType] == nil then
			paramDic[attributeType] = 0
		end

		local tempNum = paramDic[attributeType]

		if calculateType == LiangYueEnum.CalculateType.Add then
			tempNum = tempNum + attribute
		elseif calculateType == LiangYueEnum.CalculateType.Minus then
			tempNum = tempNum - attribute
		elseif calculateType == LiangYueEnum.CalculateType.Multiply then
			tempNum = tempNum * attribute
		elseif calculateType == LiangYueEnum.CalculateType.Divide then
			tempNum = tempNum / attribute
		end

		paramDic[attributeType] = math.floor(tempNum)
	end
end

function LiangYueGameView:_onItemBeginDrag(param, pointerEventData, id)
	if self._isFinish then
		return
	end

	local currentItem
	local currentDragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._goillustrationContainer.transform)
	local posX, posY
	local isExistIllustration = id == nil

	if isExistIllustration then
		id, posX, posY = self:_onMeshContainerClick(param, pointerEventData.position, nil, true)

		if id == nil then
			return
		end

		self._previousPosX = posX
		self._previousPosY = posY
	end

	if self:_CheckDragItemCount(id) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotEnough)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_anzhu)

	if isExistIllustration then
		if not LiangYueEnum.NormalAlpha then
			local alpha = LiangYueEnum.DragAlpha

			self:_setScrollItemAlpha(id, alpha)

			currentItem = self:_getDragItem(id)

			logNormal("Start Drag")
			gohelper.setAsLastSibling(currentItem.go)

			self._currentDragItem = currentItem
			self._isDrag = true
			self._dragShapeId = id

			recthelper.setAnchor(currentItem.rectTran, currentDragPos.x, currentDragPos.y)

			self._previousDragPos = currentDragPos

			self:_onSelectShape(id)
			self:_resetMeshItemEnableState()
		end
	end
end

function LiangYueGameView:_onSelectShape(shapeId)
	local params = LiangYueConfig.instance:getIllustrationShape(self._actId, shapeId)
	local yCount = #params
	local xCount = #params[1]
	local height = yCount * self._meshHeight
	local width = xCount * self._meshWidth

	self._dragItemMaxX = width * 0.5
	self._dragItemMinX = -self._dragItemMaxX
	self._dragItemMaxY = height * 0.5
	self._dragItemMinY = -self._dragItemMaxY
	self._dragItemHeight = height
	self._dragItemWidth = width
	self._currentDragCheckList = params
	self._dragItemSize = {
		xCount,
		yCount
	}
	self._needCheckMeshCount = LiangYueConfig.instance:getIllustrationShapeCount(self._actId, shapeId)
end

function LiangYueGameView:_setScrollItemAlpha(id, alpha)
	for _, item in ipairs(self._illustrationScrollItemList) do
		if item.id == id then
			item:setAlpha(alpha)

			return
		end
	end
end

function LiangYueGameView:_CheckDragItemCount(id)
	local limitCount = self._illustrationCountDic[id]

	if not limitCount or limitCount == 0 then
		return false
	end

	if not self._illustrationUseDic[id] then
		local useCount = 0

		return limitCount <= useCount
	end
end

function LiangYueGameView:_updateItemPos(pointerEventData)
	local rectTran = self._currentDragItem.rectTran
	local currentDragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._gomeshContainer.transform)
	local offsetX = currentDragPos.x - self._previousDragPos.x
	local offsetY = currentDragPos.y - self._previousDragPos.y
	local positionX, positionY = recthelper.getAnchor(rectTran)
	local finalPositionX = positionX + offsetX
	local finalPositionY = positionY + offsetY

	recthelper.setAnchor(rectTran, finalPositionX, finalPositionY)

	self._previousDragPos = currentDragPos

	return finalPositionX, finalPositionY
end

function LiangYueGameView:_onItemDrag(param, pointerEventData)
	if self._currentDragItem == nil then
		return
	end

	self:_resetMeshItemEnableState()
	self:_onItemMove(pointerEventData)
end

function LiangYueGameView:_onItemMove(pointerEventData)
	local finalPositionX, finalPositionY = self:_updateItemPos(pointerEventData)
	local itemMinX = self._dragItemMinX + finalPositionX
	local itemMaxX = self._dragItemMaxX + finalPositionX
	local itemMinY = self._dragItemMinY + finalPositionY
	local itemMaxY = self._dragItemMaxY + finalPositionY
	local halfItemWidth = self._meshWidth * 0.5
	local halfItemHeight = self._meshHeight * 0.5
	local halfMeshWidth = self._meshMaxX
	local halfMeshHeight = self._meshMaxY

	if itemMaxX < -halfMeshWidth + halfItemWidth or itemMinX > halfMeshWidth - halfItemWidth or itemMaxY < -halfMeshHeight + halfItemHeight or itemMinY > halfMeshHeight - halfItemHeight then
		return false, nil, nil
	end

	local intersection_x_min = math.max(itemMinX, -halfMeshWidth) - finalPositionX + self._dragItemMaxX
	local intersection_x_max = math.min(itemMaxX, halfMeshWidth) - finalPositionX + self._dragItemMaxX
	local intersection_y_min = math.max(itemMinY, -halfMeshHeight) - finalPositionY + self._dragItemMaxY
	local intersection_y_max = math.min(itemMaxY, halfMeshHeight) - finalPositionY + self._dragItemMaxY
	local minIndex = 1
	local maxIndexX = self._dragItemSize[1]
	local maxIndexY = self._dragItemSize[2]
	local start_Index_X, end_Index_X, start_Index_Y, end_Index_Y = self:_calculateOverlapMeshBoundary(intersection_x_min, intersection_x_max, intersection_y_min, intersection_y_max, self._meshWidth, self._meshHeight, maxIndexX, maxIndexY)
	local meshMaxIndexX = self._meshSize[1]
	local meshMaxIndexY = self._meshSize[2]
	local dyeingCount = 0
	local enableCount = 0
	local dragItemPosX, dragItemPosY
	local isPosDragItem = false

	for y = start_Index_Y, end_Index_Y do
		for x = start_Index_X, end_Index_X do
			if self._currentDragCheckList[y] and self._currentDragCheckList[y][x] == 1 then
				local meshItemPosX = (x - 1) * self._meshWidth + self._dragItemMinX + halfItemWidth

				meshItemPosX = meshItemPosX + finalPositionX + self._meshMaxX

				local meshItemPosY = (maxIndexY - y + 1) * self._meshHeight + self._dragItemMinY

				meshItemPosY = meshItemPosY + finalPositionY + self._meshMaxY

				local index_x = math.floor(meshItemPosX / self._meshWidth) + 1

				index_x = Mathf.Clamp(index_x, minIndex, meshMaxIndexX)

				local index_y = math.floor(meshItemPosY / self._meshWidth + 0.5)

				index_y = Mathf.Clamp(index_y, minIndex, meshMaxIndexY)
				index_y = meshMaxIndexY - index_y + 1

				local index = meshMaxIndexX * (index_y - 1) + index_x
				local item = self._meshItemList[index]

				if item then
					if not isPosDragItem then
						dragItemPosX = index_x
						dragItemPosY = index_y
						isPosDragItem = true
					end

					if self._meshData[index_y] then
						local haveFilled = self._meshData[index_y][index_x] ~= nil

						table.insert(self._dyeingMeshItemList, item)

						dyeingCount = dyeingCount + 1

						if not haveFilled then
							enableCount = enableCount + 1
						end
					end
				end
			end
		end
	end

	local enable = enableCount >= self._needCheckMeshCount

	if enable then
		if not LiangYueEnum.MeshItemColor.Enable then
			local color = LiangYueEnum.MeshItemColor.Disable

			if dyeingCount > 0 then
				for _, item in ipairs(self._dyeingMeshItemList) do
					item:setActive(true)
					item:setBgColor(color)
				end
			end

			self._dyeingMeshItemCount = dyeingCount

			if not enable then
				return true, nil, nil
			end

			return true, dragItemPosX, dragItemPosY
		end
	end
end

function LiangYueGameView:_calculateOverlapMeshBoundary(min_x, max_x, min_y, max_y, width, height, maxIndexX, maxIndexY)
	local minIndex = 1
	local temp_Start_Index_X = min_x / width
	local temp_End_Index_X = max_x / width
	local temp_Start_Index_Y = min_y / height
	local temp_End_Index_Y = max_y / height
	local start_Index_X = Mathf.Clamp(math.floor(temp_Start_Index_X + 0.5) + 1, minIndex, maxIndexX)
	local end_Index_X = Mathf.Clamp(math.floor(temp_End_Index_X + 0.5), minIndex, maxIndexX)
	local start_Index_Y = maxIndexY - Mathf.Clamp(math.floor(temp_End_Index_Y + 0.5), minIndex, maxIndexY) + 1
	local end_Index_Y = maxIndexY - Mathf.Clamp(math.floor(temp_Start_Index_Y + 0.5) + 1, minIndex, maxIndexY) + 1

	return start_Index_X, end_Index_X, start_Index_Y, end_Index_Y
end

function LiangYueGameView:_resetMeshItemEnableState()
	if self._dyeingMeshItemCount > 0 then
		for _, item in ipairs(self._dyeingMeshItemList) do
			item:setActive(false)
		end

		tabletool.clear(self._dyeingMeshItemList)

		self._dyeingMeshItemCount = 0
	end
end

function LiangYueGameView:_onItemEndDrag(param, pointerEventData)
	if self._currentDragItem == nil then
		return
	end

	logNormal("End Drag")

	self._isDrag = false

	local isOverlap, itemPosX, itemPosY = self:_onItemMove(pointerEventData)

	itemPosX = itemPosX or self._previousPosX
	itemPosY = itemPosY or self._previousPosY

	self:_setScrollItemAlpha(self._dragShapeId, LiangYueEnum.NormalAlpha)
	self:_beforeAttributeChanged()

	if isOverlap and itemPosX and itemPosY then
		logNormal("放置插画")
		self:_fillMesh(itemPosX, itemPosY, self._dragShapeId, false, self._currentDragItem)
		AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_fangru)
	else
		logNormal("回收插画")
		self:_recycleDragItem(self._currentDragItem)
	end

	self:_afterAttributeChanged()

	self._dragShapeId = nil
	self._previousPosX = nil
	self._previousPosX = nil
	self._currentDragItem = nil

	self:_resetMeshItemEnableState()
end

function LiangYueGameView:_rebuildMesh()
	local imageWidth = recthelper.getWidth(self._goImageBg.transform)
	local imageHeight = recthelper.getHeight(self._goImageBg.transform)
	local xCount = self._meshSize[1]
	local yCount = self._meshSize[2]

	self._meshWidth = imageWidth / xCount
	self._meshHeight = imageHeight / yCount

	local meshWidth = self._meshWidth * xCount
	local meshHeight = self._meshHeight * yCount
	local xOffset = (meshWidth + self._meshWidth) * 0.5
	local yOffset = (meshHeight + self._meshHeight) * 0.5

	recthelper.setSize(self._gomeshContainer.transform, meshWidth, meshHeight)
	recthelper.setSize(self._goillustrationContainer.transform, meshWidth, meshHeight)
	recthelper.setAnchor(self._gomeshContainer.transform, 0, 0)
	recthelper.setAnchor(self._goillustrationContainer.transform, 0, 0)

	self._meshMaxX = meshWidth * 0.5
	self._meshMinX = -self._meshMaxX
	self._meshMaxY = meshHeight * 0.5
	self._meshMinY = -self._meshMaxY

	local needCount = xCount * yCount
	local itemCount = #self._meshItemList

	for y = 1, yCount do
		for x = 1, xCount do
			local index = (y - 1) * xCount + x
			local item = itemCount < index and self:_createMeshItem(index) or self._meshItemList[index]
			local itemPosX = x * self._meshWidth - xOffset
			local itemPosY = meshHeight - (y - 1) * self._meshHeight - yOffset

			item:setPos(itemPosX, itemPosY)
			item:setActive(false)
		end
	end

	if needCount < itemCount then
		for i = needCount + 1, itemCount do
			local item = self._meshItemList[i]

			item:setActive(false)
		end
	end
end

function LiangYueGameView:_createIllustrationItem(id, index)
	local name = string.format("item_%s_%s", id, index)
	local itemInstance = gohelper.clone(self._goillstrationItem, self._goContent, name)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemInstance, LiangYueScrollItem)

	item:setParentView(self)
	table.insert(self._illustrationScrollItemList, item)

	return item
end

function LiangYueGameView:_createMeshItem(index)
	local itemObj = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gomeshContainer, "meshItem" .. index)

	recthelper.setSize(itemObj.transform, self._meshHeight, self._meshHeight)

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemObj, LiangYueMeshItem)

	table.insert(self._meshItemList, item)

	return item
end

function LiangYueGameView:_getDragItem(id, isStatic, isFinish)
	local item
	local itemCount = #self._unusedDragItemList

	if itemCount <= 0 then
		local itemObj = gohelper.clone(self._godragItem, self._goillustrationContainer)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(itemObj, LiangYueDragItem)
	else
		item = self._unusedDragItemList[itemCount]
		self._unusedDragItemList[itemCount] = nil
	end

	local config = LiangYueConfig.instance:getIllustrationConfigById(self._actId, id)

	item:setActive(true)
	item:setInfo(id, config, isStatic, isFinish)

	return item
end

function LiangYueGameView:_recycleDragItem(item)
	if item ~= nil then
		item:setActive(false)
		table.insert(self._unusedDragItemList, item)
	end
end

function LiangYueGameView:_isStaticIllustration(index)
	if self._staticIllustrationDic[index] then
		return true
	end

	return false
end

function LiangYueGameView:statData(state)
	local illustrationList = {}

	for _, index in pairs(self._illustrationIndexList) do
		local id = self._illustrationIndexDic[index]

		if not self:_isStaticIllustration(index) then
			table.insert(illustrationList, id)
		end
	end

	local statStartTime

	LiangYueController.instance:statExitData(state == LiangYueEnum.StatGameState.Restart and self._resetTime or self._enterTime, self._episodeGameId, state, illustrationList)
end

function LiangYueGameView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("LiangYueGameLock")
	else
		UIBlockMgr.instance:endBlock("LiangYueGameLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function LiangYueGameView:onClose()
	LiangYueModel.instance:setCurActId(nil)
	LiangYueModel.instance:setCurEpisodeId(nil)
	TaskDispatcher.cancelTask(self.delayFinishAnim, self)
	TaskDispatcher.cancelTask(self.delayFinishAnimEnd, self)
	TaskDispatcher.cancelTask(self._resetAttributeState, self)

	if self._tweenPos then
		ZProj.TweenHelper.KillById(self._tweenPos)

		self._tweenPos = nil
	end
end

function LiangYueGameView:onDestroyView()
	return
end

return LiangYueGameView
