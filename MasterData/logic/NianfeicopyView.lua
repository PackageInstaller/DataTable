-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/nainfei/NianfeicopyView.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.NianfeicopyView", package.seeall)

local NianfeicopyView = class("NianfeicopyView", FatherDungeonView)

function NianfeicopyView:ctor()
	NianfeicopyView.super.ctor(self)
end

function NianfeicopyView:_getChapterMaxNum()
	return 0
end

function NianfeicopyView:_getStageMaxNum()
	return 6
end

function NianfeicopyView:_getIndexRange()
	return 1, 4
end

function NianfeicopyView:_getStageViewName()
	return ViewName.NianfeistageView
end

function NianfeicopyView:buildUI()
	NianfeicopyView.super.buildUI(self)

	self.btnShip = goutil.findChild(self.mainGO, "btnShip")
	self.shipRedPoint = goutil.findChild(self.mainGO, "btnShip/redpoint")
	self.bubble = goutil.findChild(self.mainGO, "bubble")
	self.itemBubble = goutil.findChild(self.mainGO, "bubble/item")
	self.txtBubble = goutil.findChildTextComponent(self.mainGO, "bubble/txt")
	self.ScrollerGo = goutil.findChild(self.mainGO, "tableview")

	local cellGo = goutil.findChild(self.mainGO, "chapters")
	local updateCellCallBack = GameUtil.handler(self._updateChaptersCell, self)
	local clearCellCallBack = GameUtil.handler(self._clearChaptersCell, self)

	self.chaptersScrollList = ScrollerList.create(self.ScrollerGo, cellGo, updateCellCallBack, clearCellCallBack)
	self.chapterL = goutil.findChild(self.mainGO, "chapterL")
	self.txtChapterL = goutil.findChildTextComponent(self.mainGO, "chapterL/txt")
	self.chapterLRed = goutil.findChild(self.mainGO, "chapterL/redpoint")
	self.chapterLLock = goutil.findChild(self.mainGO, "chapterL/lock")
	self.txtChapterLLockTime = goutil.findChildTextComponent(self.mainGO, "chapterL/lock/time/txtTime")
	self.chapterR = goutil.findChild(self.mainGO, "chapterR")
	self.txtChapterR = goutil.findChildTextComponent(self.mainGO, "chapterR/txt")
	self.chapterRRed = goutil.findChild(self.mainGO, "chapterR/redpoint")
	self.chapterRLock = goutil.findChild(self.mainGO, "chapterR/lock")
	self.txtChapterRLockTime = goutil.findChildTextComponent(self.mainGO, "chapterR/lock/time/txtTime")
end

function NianfeicopyView:bindEvents()
	NianfeicopyView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnShip, self._onClickBtnShip, self)

	local handler = GameUtil.handler(self._onClickBtnChapterChange, self, false)

	GameUtil.addClickHandler(self.chapterL, handler)

	handler = GameUtil.handler(self._onClickBtnChapterChange, self, true)

	GameUtil.addClickHandler(self.chapterR, handler)
end

function NianfeicopyView:unbindEvents()
	NianfeicopyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnShip)
	GameUtil.rmClickHandler(self.chapterL)
	GameUtil.rmClickHandler(self.chapterR)
end

function NianfeicopyView:onEnter()
	NianfeicopyView.super.onEnter(self)

	if self.itemBubble then
		-- block empty
	end

	RedPointController.instance:regRedPoint(self.shipRedPoint, 216)
end

function NianfeicopyView:onExit()
	NianfeicopyView.super.onExit(self)
	self.chaptersScrollList:dispose()

	if self.itemBubble then
		-- block empty
	end

	RedPointController.instance:unregRedPoint(self.shopRedPoint)
	RedPointController.instance:unregRedPoint(self.trialRedPoint)
end

function NianfeicopyView:_updateChapters()
	local highChapterTypeId = 0
	local index = 1

	for i, data in ipairs(self._plotStoryCfgs) do
		self._chapters[i] = self._chapters[i] or {}

		local typeId = data.typeId
		local isUnlock, tipDesc = ScenariocopyController.instance:getStoryIfUnlockAndText(typeId)

		self._chapters[i].typeId = typeId
		self._chapters[i].tipDesc = tipDesc
		self._chapters[i].isUnlock = isUnlock

		local isLevelAllPass = true
		local plotChapterCfgs = self:_getSortPlotChapterCfgs(typeId)

		for idx, _ in ipairs(self._levels) do
			local chapterCfg = plotChapterCfgs[idx]

			if chapterCfg then
				local unlockCondition = chapterCfg.unlockCondition
				local isUnlock = ScenariocopyModel.instance:getStagePass(unlockCondition[2], unlockCondition[3])
				local isPass = ScenariocopyModel.instance:getStagePass(chapterCfg.chapterId, 1)

				if not isUnlock or not isPass then
					isLevelAllPass = false
				end
			end
		end

		self._chapters[i].isLevelAllPass = isLevelAllPass

		if isUnlock == true then
			highChapterTypeId = typeId
			index = i
		end
	end

	self._curHighChapterTypeId = highChapterTypeId
	self._curHighChapterIndex = index

	self:_onUpdateChaptersScroller()
	self:_onUpdateAllBtnChapterChange()
end

function NianfeicopyView:_setSelectChapter(index)
	NianfeicopyView.super._setSelectChapter(self, index)
	self:_onUpdateChaptersScroller()
	self:_onUpdateAllBtnChapterChange()
end

function NianfeicopyView:_onUpdateChaptersScroller()
	local dataList = {}

	for index, data in ipairs(self._plotStoryCfgs) do
		data.index = index

		table.insert(dataList, data)
	end

	self.chaptersScrollList:reloadData(dataList)
end

function NianfeicopyView:_updateChaptersCell(view, cell, data, tag)
	local btnChapter = goutil.findChild(cell, "btnChapter")
	local txtName = goutil.findChildTextComponent(btnChapter, "txtName")
	local txtChapter = goutil.findChildTextComponent(btnChapter, "txtChapter")
	local selectGo = goutil.findChild(btnChapter, "select")
	local lockGo = goutil.findChild(btnChapter, "lock")
	local txtPass = goutil.findChild(btnChapter, "txtPass")
	local timeGo = goutil.findChild(btnChapter, "lock/time")
	local txtTime = goutil.findChildTextComponent(btnChapter, "lock/time/txtTime")
	local redpoint = goutil.findChild(btnChapter, "redpoint")
	local pos = GameUtil.getLocalPos(btnChapter)
	local x = Mathf.Abs(pos.x)
	local parity = data.index % 2 == 0

	if parity then
		x = x * -1
	end

	GameUtil.setLocalPos(btnChapter, x, pos.y, pos.z)
	self:setTextIngoreNil(txtName, data.storyName)
	self:setTextIngoreNil(txtChapter, data.index)

	local isLevelAllPass = self._chapters[data.index].isLevelAllPass

	GameUtil.SetActive(txtPass, isLevelAllPass)

	local isUnlock, tipDesc = ScenariocopyController.instance:getStoryIfUnlockAndText(data.typeId)
	local isNeedRed = not isLevelAllPass and isUnlock

	self:setActiveIngoreNil(redpoint, isNeedRed)
	self:setActiveIngoreNil(lockGo, not isUnlock)

	local openDay = data.openDay
	local isTimeUnLock = ScenariocopyController.instance:getIfOpenByStartDay(openDay)

	self:setActiveIngoreNil(timeGo, not isTimeUnLock)

	if not string.nilorempty(openDay) and not isTimeUnLock then
		local openMon, openDay = ScenariocopyController.instance:parseOpenTime(openDay)

		txtTime.text = langPara("%s月%s日 5:00 解锁", openMon, openDay)
	end

	GameUtil.addClickHandler(btnChapter, function()
		self:_onClickChapter(data.index, cell)
	end)
	self:setActiveIngoreNil(selectGo, data.index == self._curSelectChapterIndex)
end

function NianfeicopyView:_onClickChapter(index)
	NianfeicopyView.super._onClickChapter(self, index)
end

function NianfeicopyView:_clearChaptersCell(cell)
	return
end

function NianfeicopyView:_onUpdateAllBtnChapterChange()
	self:_updateBtnChapterChange(false, self.chapterL, self.txtChapterL, self.chapterLLock, self.txtChapterLLockTime, self.chapterLRed)
	self:_updateBtnChapterChange(true, self.chapterR, self.txtChapterR, self.chapterRLock, self.txtChapterRLockTime, self.chapterRRed)
end

function NianfeicopyView:_updateBtnChapterChange(isNext, chapterGo, txtChapterTitle, lockGo, txtLockTime, redPoint)
	local chapterNum = #self._plotStoryCfgs
	local targetIdx = 1
	local isNeedShow = false

	if isNext then
		isNeedShow = self._curSelectChapterIndex ~= chapterNum
		targetIdx = math.min(self._curSelectChapterIndex + 1, chapterNum)
	else
		isNeedShow = self._curSelectChapterIndex ~= 1
		targetIdx = math.max(self._curSelectChapterIndex - 1, 1)
	end

	GameUtil.SetActive(chapterGo, isNeedShow)

	if not isNeedShow then
		return
	end

	local data = self._plotStoryCfgs[targetIdx]

	self:setTextIngoreNil(txtChapterTitle, string.format("第%s章", targetIdx))

	local isUnlock, tipDesc = ScenariocopyController.instance:getStoryIfUnlockAndText(data.typeId)

	GameUtil.SetActive(lockGo, not isUnlock)

	local openDay = data.openDay
	local isTimeUnLock = ScenariocopyController.instance:getIfOpenByStartDay(openDay)

	if not string.nilorempty(openDay) and not isTimeUnLock then
		local openMon, openDay = ScenariocopyController.instance:parseOpenTime(openDay)

		self:setTextIngoreNil(txtLockTime, string.format("%s.%s 5:00 后\n开启第%s章", openMon, openDay, targetIdx))
	end

	if isTimeUnLock and not isUnlock then
		self:setTextIngoreNil(txtLockTime, tipDesc)
	end

	local isLevelAllPass = self._chapters[targetIdx].isLevelAllPass
	local isNeedRed = not isLevelAllPass and isUnlock

	GameUtil.SetActive(redPoint, isNeedRed)
end

function NianfeicopyView:_onClickBtnChapterChange(isNext)
	local index = 1

	if isNext then
		local chapterNum = #self._plotStoryCfgs

		index = math.min(self._curSelectChapterIndex + 1, chapterNum)
	else
		index = math.max(self._curSelectChapterIndex - 1, 1)
	end

	local data = self._plotStoryCfgs[index]
	local isUnlock, tipDesc = ScenariocopyController.instance:getStoryIfUnlockAndText(data.typeId)

	if not isUnlock then
		FloatWordMgr.instance:show(self._chapters[index].tipDesc)
	else
		self:_onClickChapter(index)
	end
end

function NianfeicopyView:_onClickBtnShip()
	UIStateManager.instance:push(ViewName.RoleRelationshipView)
end

return NianfeicopyView
