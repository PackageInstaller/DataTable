-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/ChapterViewBase.lua

module("logic.extensions.plotcopy.view.ChapterViewBase", package.seeall)

local ChapterViewBase = class("ChapterViewBase", ViewComponent)

function ChapterViewBase:ctor()
	ChapterViewBase.super.ctor(self)
end

function ChapterViewBase:buildUI()
	ChapterViewBase.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getGo("txtTitle"):GetComponent(goutil.Type_UIText)
	self._tableview = self:getGo("scrollList"):GetComponent("UITableview")
	self._tableview.useAnchorPosition = true
	self._tableCell = self:getGo("scrollList/item")

	self._tableCell:SetActive(false)

	self._clipRectTrans = self:getGo("scrollList"):GetComponent(goutil.Type_RectTransform)
	self._goldBarCon = self:getGo("goldBarCon")
	self._doubleRewardTip = self:getGo("doubleRewardTip")
	self._tip = self:getGo("doubleRewardTip/tip")
	self._btnExplainCustomInput = UICustomInput.Get(self:getGo("doubleRewardTip/btnExplain"))
	self._txtTime = self:getTxt("doubleRewardTip/bg/txtTime")
	self._txtDesc = self:getTxt("doubleRewardTip/bg/txt")

	self._doubleRewardTip:SetActive(false)

	self._btnPre = self:getBtn("btnPre")
	self._btnNext = self:getBtn("btnNext")
	self._nearBg1 = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_UIImage)
	self._middleBg2 = self:getGo("dynamicBg/middleBg2"):GetComponent(goutil.Type_UIImage)
	self._farBg3 = self:getGo("dynamicBg/farBg3"):GetComponent(goutil.Type_UIImage)
	self._nearImageBigBG = self._nearBg1.gameObject:GetComponent("ImageBigBG")
	self._middleImageBigBG = self._middleBg2.gameObject:GetComponent("ImageBigBG")
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(self._tableview.gameObject)
	self._scrollRectTransform = self._tableview.gameObject:GetComponent(goutil.Type_RectTransform)
	self._contentRectTransform = self:getGo("scrollList/viewport/content"):GetComponent(goutil.Type_RectTransform)

	local nearBgRectTrans = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_RectTransform)

	self._nearBgWidth = goutil.getWidth(nearBgRectTrans)
end

function ChapterViewBase:bindEvents()
	ChapterViewBase.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnExplainCustomInput:AddListener(self._onClickExplain, self)
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
end

function ChapterViewBase:unbindEvents()
	ChapterViewBase.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnExplainCustomInput:RemoveListener()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._scrollAdapter:RemoveOnValueChanged()
end

function ChapterViewBase:onEnter()
	self._chapterId = self:getFirstParam()

	if not self._chapterId then
		return
	end

	local cfg = CopyConfig.instance:getChapter(self._chapterId)

	if not cfg then
		printError("剧情副本章节id不存在 chapterId = ", self._chapterId, type(self._chapterId))

		return
	end

	self:_cacheResources()

	self._cfg = cfg

	self:_initMaterial()

	self._isFirstLoadData = true

	GlobalDispatcher:addListener(GlobalNotify.UpdateChapterDetail, self._onUpdateChapterDetail, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyCloseChapterView, self._onClickClose, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyZdlSecKillRes, self._onCopyZdlSecKillRes, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish, self)
	self._tableview:RegisterOnUpdatePositionCallback(function(self, view)
		self:_onUpdatePosition(view)
	end)
	self:_initBtnArrow()
	self:_refreshCompleteChapter()
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor)
	self:_initActivityTipState()

	if ShareTaskModel.instance.isTriggerBoss then
		ShareTaskModel.instance.isTriggerBoss = false

		if ShareTaskModel.instance:IsOpenSharePopupView() then
			ShareTaskController.instance:popBossTriggerView()
		end
	end
end

function ChapterViewBase:_cacheResources()
	local dps = self._viewPresentor:dependWhatResources()
	local temp = self._viewPresentor:getTempResources()
	local chapterId = self._chapterId

	if dps then
		for i = 1, #dps do
			PlotCopyController.instance:cachePlotChapterviewRes(chapterId, dps[i])
		end
	end

	if temp then
		for i = 1, #temp do
			PlotCopyController.instance:cachePlotChapterviewRes(chapterId, temp[i])
		end
	end

	PlotCopyController.instance:clearPlotChapterviewCachesExcept(chapterId)
end

function ChapterViewBase:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.UpdateChapterDetail, self._onUpdateChapterDetail, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopyCloseChapterView, self._onClickClose, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopyZdlSecKillRes, self._onCopyZdlSecKillRes, self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
	removetimer(self._updateActivityTipState, self)
	self:_removeDynamicBg()
	self:_removeMaterial()
end

function ChapterViewBase:onExitFinished()
	return
end

function ChapterViewBase:_onClickClose()
	self:close()
end

function ChapterViewBase:_onReloadFinish()
	if self._isFirstLoadData then
		self:_checkMoveToCenterOffset(self._chapterId)
		self._tableview:ReloadData()
	end
end

function ChapterViewBase:_numInView()
	if self._isFirstLoadData then
		return 0
	end

	return #self._curViewDatas
end

function ChapterViewBase:_cellSize()
	return 202, 432
end

function ChapterViewBase:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function ChapterViewBase:_updateCell(view, cell, data)
	local idx = cell.index + 1
	local component = PlotStageItem.AddOnce(cell.gameObject)

	component:init(idx, data, self)
end

function ChapterViewBase:_clearTableview(cell)
	local component = PlotStageItem.AddOnce(cell.gameObject)

	component:reset()
end

function ChapterViewBase:_updateScrollList(chapterId)
	self._curViewDatas = {}

	local stageCfgs = CopyConfig.instance:getStages(chapterId)
	local num = PlotCopyModel.instance:curOpenStageNum(chapterId)
	local chapterType = PlotCopyModel.instance:getChapterType()
	local perfectList = {}

	if chapterType == GameEnum.Chapter.Plot then
		perfectList = PlotCopyModel.instance:getChapterPerfectPassedList(chapterId)
	end

	for i, vCfg in pairs(stageCfgs) do
		self._curViewDatas[i] = {}
		self._curViewDatas[i].view = self
		self._curViewDatas[i].index = i
		self._curViewDatas[i].cfg = vCfg

		local unlockState = PlotCopyModel.instance:getUnlockState(chapterId, vCfg.stageId)

		self._curViewDatas[i].unlockState = unlockState
		self._curViewDatas[i].isLock = num < i or unlockState ~= 0
		self._curViewDatas[i].isLast = i == #stageCfgs
		self._curViewDatas[i].openStageNum = num

		if chapterType == GameEnum.Chapter.Plot then
			self._curViewDatas[i].isHavePerfect = true

			if #perfectList == 0 then
				-- block empty
			end

			self._curViewDatas[i].isPerfect = perfectList[i]
		else
			self._curViewDatas[i].isHavePerfect = false
		end
	end

	self._tableview:ReloadData()
end

function ChapterViewBase:_checkMoveToCenterOffset(chapterId)
	if self._isFirstLoadData then
		self._isFirstLoadData = nil

		local numCells = self:_numInView()
		local stageId = PlotCopyModel.instance:curOpenStageNum(chapterId)

		if stageId and stageId >= 1 and stageId <= numCells then
			local cellWidth = self._tableview.gridWidth
			local offset = (stageId - 1) * cellWidth
			local viewSize = self._tableview:GetViewSize()
			local offsetTo = offset - viewSize * 0.5 + cellWidth * 0.5
			local minOfs = 0
			local maxOfs = (numCells - 1) * cellWidth
			local ofs = math.max(minOfs, math.min(offsetTo, maxOfs))

			self._tableview:SetOffsetWithoutRefresh(ofs)
		end
	end
end

function ChapterViewBase:_refreshScrollList()
	local chapterId = self._chapterId
	local perfectList = PlotCopyModel.instance:getChapterPerfectPassedList(chapterId)
	local num = PlotCopyModel.instance:curOpenStageNum(chapterId)

	for i, v in pairs(self._curViewDatas) do
		local unlockState = PlotCopyModel.instance:getUnlockState(chapterId, v.cfg.stageId)

		self._curViewDatas[i].unlockState = unlockState
		self._curViewDatas[i].isLock = num < i or unlockState ~= 0
		self._curViewDatas[i].openStageNum = num

		if #perfectList == 0 then
			-- block empty
		end

		self._curViewDatas[i].isPerfect = perfectList[i]
	end

	self._tableview:ReloadData()
end

function ChapterViewBase:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function ChapterViewBase:_refreshCompleteChapter()
	self:_loadDynamicBg()
	self:_setTxtTitle()
	self:_updateScrollList(self._chapterId)
	GlobalDispatcher:dispatch(GlobalNotify.CopyRefreshReward, self._chapterId)
end

function ChapterViewBase:_setTxtTitle()
	local cfg = CopyConfig.instance:getChapter(self._chapterId)

	if cfg then
		local num = cfg.chapterId % 1000
		local str1 = string.format("第%s章 ", GameUtil.getChineseNumber(num))

		self._txtTitle.text = str1 .. cfg.chapterName
	end
end

function ChapterViewBase:_onUpdateChapterDetail()
	self:_refreshScrollList()
end

function ChapterViewBase:_onCopyZdlSecKillRes()
	self._isFirstLoadData = true

	self:_refreshScrollList()
	GlobalDispatcher:dispatch(GlobalNotify.CopyRefreshReward, self._chapterId)
end

function ChapterViewBase:_initActivityTipState()
	goutil.setActive(self._tip, false)
	self:_updateActivityTipState()
	settimer(5, self._updateActivityTipState, self)
end

function ChapterViewBase:_updateActivityTipState()
	local isInTime, desc, startTime, endTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Plot, self._cfg.chapterType)
	local isOpen = isInTime

	if isOpen and not self._doubleRewardTip.activeSelf then
		self._doubleRewardTip:SetActive(true)
		self._tip:SetActive(false)

		self._txtDesc.text = desc

		local startTable = GameUtil.time2date(startTime)
		local endTable = GameUtil.time2date(endTime - 86400)

		self._txtTime.text = string.format("(%02d.%02d - %02d.%02d)", startTable.month, startTable.day, endTable.month, endTable.day)
	elseif not isOpen and self._doubleRewardTip.activeSelf then
		self._doubleRewardTip:SetActive(false)
		self._tip:SetActive(false)
	end
end

function ChapterViewBase:_onClickExplain(hover)
	if hover then
		if not self._tip.activeSelf then
			self._tip:SetActive(true)
		else
			self._tip:SetActive(false)
		end
	elseif self._tip.activeSelf then
		self._tip:SetActive(false)
	end
end

function ChapterViewBase:_getChapterType()
	return GameEnum.Chapter.Plot
end

function ChapterViewBase:_onClickPre()
	local newChapterId, newIndex = self:_changeChapterId(self._chapterId, -1)

	printInfo("test 向上翻页 newChapterId, oldChapterId", newChapterId, self._chapterId)
	self:_setBtnArrowActive(newIndex == 1, false)

	if newChapterId and newChapterId ~= self._chapterId then
		self._chapterId = newChapterId
		self._cfg = CopyConfig.instance:getChapter(self._chapterId)
		self._isFirstLoadData = true

		self:_refreshCompleteChapter(newIndex)
		self:_saveRecentOpenChapter(newIndex)
	end
end

function ChapterViewBase:_onClickNext()
	local newChapterId, newIndex = self:_changeChapterId(self._chapterId, 1)

	self:_setBtnArrowActive(false, self:_isLastAvailableChapter(newChapterId))

	if newChapterId and newChapterId ~= self._chapterId then
		self._chapterId = newChapterId
		self._cfg = CopyConfig.instance:getChapter(self._chapterId)
		self._isFirstLoadData = true

		self:_refreshCompleteChapter()
		self:_saveRecentOpenChapter(newIndex)
	end
end

function ChapterViewBase:_initBtnArrow()
	local newChapterId, newIndex = self:_changeChapterId(self._chapterId, 1)
	local isLast = newChapterId == self._chapterId
	local newChapterId2, newIndex2 = self:_changeChapterId(self._chapterId, -1)
	local isFirst = newChapterId2 == self._chapterId

	self:_setBtnArrowActive(isFirst, isLast)
end

function ChapterViewBase:_setBtnArrowActive(isFirst, isLast)
	if isLast then
		self._btnNext.gameObject:SetActive(false)
		self._btnPre.gameObject:SetActive(true)
	elseif isFirst then
		self._btnNext.gameObject:SetActive(true)
		self._btnPre.gameObject:SetActive(false)
	else
		self._btnNext.gameObject:SetActive(true)
		self._btnPre.gameObject:SetActive(true)
	end
end

function ChapterViewBase:_isLastAvailableChapter(chapterId)
	local chapterCfgs = CopyConfig.instance:getChapters(self:_getChapterType())
	local curIndex = 1

	for i, v in ipairs(chapterCfgs) do
		if chapterId == v.chapterId then
			curIndex = i
		end
	end

	local nextIndex = curIndex + 1

	if nextIndex > #chapterCfgs then
		return true
	end

	local isUnlock = PlotCopyModel.instance:isChapterUnlock(chapterCfgs[nextIndex].chapterId)

	return not isUnlock
end

function ChapterViewBase:_changeChapterId(curChapterId, num)
	if not curChapterId then
		return
	end

	local newChapterId = curChapterId
	local chapterCfgs = CopyConfig.instance:getChapters(self:_getChapterType())
	local totalCount = #chapterCfgs
	local curIndex = 1

	for i, v in ipairs(chapterCfgs) do
		if v.chapterId == curChapterId then
			curIndex = i
		end
	end

	local oldIndex = curIndex

	curIndex = curIndex + num

	if totalCount < curIndex then
		curIndex = totalCount
	elseif curIndex < 1 then
		curIndex = 1
	end

	newChapterId = chapterCfgs[curIndex].chapterId

	local isUnlock = PlotCopyModel.instance:isChapterUnlock(chapterCfgs[curIndex].chapterId)

	if not isUnlock then
		newChapterId = curChapterId
		curIndex = oldIndex
	end

	return newChapterId, curIndex
end

function ChapterViewBase:_saveRecentOpenChapter(newIndex)
	printInfo("test _saveRecentOpenChapter", self:_getChapterType(), newIndex)
	PlotCopyModel.instance:setRecentOpenChapter(self:_getChapterType(), newIndex)
end

function ChapterViewBase:_loadDynamicBg()
	if not self._cfg then
		return
	end

	local nearBgName = self._cfg.nearBg
	local middleBgName = self._cfg.middleBg
	local farBgName = self._cfg.farBg

	uGuiUtil.setSpriteToImage(self._nearBg1.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", nearBgName))
	uGuiUtil.setSpriteToImage(self._middleBg2.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", middleBgName))
	uGuiUtil.setSpriteToImage(self._farBg3.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", farBgName))
end

function ChapterViewBase:_removeDynamicBg()
	Framework.ImageBigBG.Get(self._nearBg1.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._middleBg2.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._farBg3.gameObject):ClearImage()
end

function ChapterViewBase:_initMaterial()
	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
end

function ChapterViewBase:_removeMaterial()
	self._nearBg1.material = nil
	self._middleBg2.material = nil

	goutil.destroy(self._nearBgMat1)
	goutil.destroy(self._middleBgMat2)

	self._nearBgMat1 = nil
	self._middleBgMat2 = nil
end

function ChapterViewBase:_onScrollValueChanged(vec2)
	if goutil.getWidth(self._contentRectTransform) < goutil.getWidth(self._scrollRectTransform) then
		self._nearBgMat1:SetTextureOffset("_MainTex", Vector2.zero)
		self._middleBgMat2:SetTextureOffset("_MainTex", Vector2.zero)
	else
		local percentPos = self._contentRectTransform.anchoredPosition.x / self._nearBgWidth

		percentPos = -1 * percentPos
		vec2.x = percentPos
		vec2.y = 0

		self._nearBgMat1:SetTextureOffset("_MainTex", vec2)
		self._middleBgMat2:SetTextureOffset("_MainTex", vec2 * 0.8)
	end
end

return ChapterViewBase
