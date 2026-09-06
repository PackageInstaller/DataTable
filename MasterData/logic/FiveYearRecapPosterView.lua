-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapPosterView.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapPosterView", package.seeall)

local FiveYearRecapPosterView = class("FiveYearRecapPosterView", ViewComponent)

function FiveYearRecapPosterView:ctor()
	FiveYearRecapPosterView.super.ctor(self)
end

function FiveYearRecapPosterView:buildUI()
	FiveYearRecapPosterView.super.buildUI(self)

	self._txtOpenTime = self:getTxt("txtOpenTime/txt")

	local prizeScrView = self:getGo("prizeCol/scrView")
	local prizeScrCell = self:getGo("prizeCol/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._progressCol = self:getGo("progressCol")
	self._progressScrView = self:getGo("progressCol/scrView")
	self._progressScrCell = self:getGo("progressCol/scrCell")
	self._progressBar = self:getGo("progressCol/scrView/Viewport/Content/progressBar")
	self._progressSliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._progressScrollerList = ScrollerList.create(self._progressScrView, self._progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._txtScoreScrCell = self:getTxt("progressCol/scrCell/txtScore")
	self._strTxtScoreScrCell = self._txtScoreScrCell.text
	self._txtProgress = self:getTxt("progressCol/total/txtProgress")
	self._puzzleView = self:getGo("puzzleCol/puzzleView")
	self._puzzleCell = self:getGo("puzzleCol/puzzleCell")
	self._imgPuzzleBoard = self:getGo("puzzleCol/imgPuzzleBoard")
	self._txtTimes = self:getTxt("times/txt")
	self._txtBubbleDesc = self:getTxt("bubble/txtDesc")

	GameUtil.SetActive(self._puzzleCell, false)
end

function FiveYearRecapPosterView:bindEvents()
	FiveYearRecapPosterView.super.bindEvents(self)
end

function FiveYearRecapPosterView:unbindEvents()
	FiveYearRecapPosterView.super.unbindEvents(self)
end

function FiveYearRecapPosterView:onEnter()
	FiveYearRecapPosterView.super.onEnter(self)

	self._activityId = FiveYearRecapController.instance:getActivityId()
	self._subMo = FiveYearRecapController.instance:getSubMo(self._activityId)
	self._actData = FiveYearRecapConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_FiveYearRecapGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FiveYearRecapUnlockRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function FiveYearRecapPosterView:onExit()
	FiveYearRecapPosterView.super.onExit(self)
	self:_onClearPrizeCol()
	self:_onClearProgressCol()
	self:_onClearPuzzleCol()
end

function FiveYearRecapPosterView:_onSetUI()
	self:_onUpdatePrizeCol()

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function FiveYearRecapPosterView:_onUpdate()
	self:_onUpdateProgressCol()
	self:_onUpdatePuzzleCol()
end

function FiveYearRecapPosterView:_onUpdatePrizeCol()
	local prizeList = {}
	local actData = FiveYearRecapConfig.instance:getActivityData(self._activityId)
	local arr = string.split(actData.posterPrize, "#")

	table.insertto(prizeList, arr)

	local onlineDatas = FiveYearRecapConfig.instance:getOnlinePrizeDatas(self._activityId)

	for _, data in ipairs(onlineDatas) do
		local arr = string.split(data.prize, "#")

		table.insertto(prizeList, arr)
	end

	local list = MaterialMgr.mergeMatStrList(prizeList)

	self._prizeScrollerList:reloadData(list)
end

function FiveYearRecapPosterView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function FiveYearRecapPosterView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function FiveYearRecapPosterView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function FiveYearRecapPosterView:_onUpdateProgressCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		index = idx - 1

		if not self._subMo:isActivatedOnline(data.onlineMinute) then
			break
		end
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(index)

	self._txtProgress.text = curProgress
end

function FiveYearRecapPosterView:_onClearProgressCol()
	self._progressScrollerList:dispose()
end

function FiveYearRecapPosterView:_getProgressDataList()
	local dataList = FiveYearRecapConfig.instance:getOnlineUnlockDataList(self._activityId)

	return dataList or {}
end

function FiveYearRecapPosterView:_getSliderComp()
	return self._progressSliderComp
end

function FiveYearRecapPosterView:_getCurProgress()
	return self._subMo:getOnlineMinute()
end

function FiveYearRecapPosterView:_getProgressByData(data)
	return data.onlineMinute
end

function FiveYearRecapPosterView:_updateProgressCell(view, cell, data, tag)
	local onlineMinute = data.onlineMinute
	local unlockCount = data.unlockCount
	local isActivated = self._subMo:isActivatedOnline(onlineMinute)
	local mainGo = cell.gameObject
	local tagPoint = goutil.findChild(mainGo, "tagPoint")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	GameUtil.SetActive(tagPoint, isActivated)

	txtScore.text = string.format(self._strTxtScoreScrCell, onlineMinute, unlockCount)
end

function FiveYearRecapPosterView:_clearProgressCell(cell)
	return
end

function FiveYearRecapPosterView:_onUpdatePuzzleCol()
	local datas = FiveYearRecapConfig.instance:getOnlinePrizeDatas(self._activityId)

	GameUtil.updateCellsList(self._puzzleView, self._puzzleCell, datas, self._updatePuzzleCell, self)

	self._txtTimes.text = self._subMo:getWithPieceCount()
end

function FiveYearRecapPosterView:_onClearPuzzleCol()
	GameUtil.clearCells(self._puzzleView, self._clearPuzzleCell, self)
end

function FiveYearRecapPosterView:_updatePuzzleCell(mainGo, data, tabIdx)
	local isUnlock = self._subMo:isPieceUnlocked(data.pieceId)
	local tagLock = goutil.findChild(mainGo, "tagLock")

	GameUtil.SetActive(tagLock, not isUnlock)
	GameUtil.addClickHandler(mainGo, function()
		if isUnlock then
			return
		end

		if not self._subMo:isEnoughUnlockPiece() then
			FloatWordMgr.instance:show("拼图次数不足")

			return
		end

		FiveYearRecapController.instance:sendPM_FiveYearRecapUnlockReq(self._activityId, data.pieceId)
	end)
end

function FiveYearRecapPosterView:_clearPuzzleCell(mainGo)
	return
end

return FiveYearRecapPosterView
