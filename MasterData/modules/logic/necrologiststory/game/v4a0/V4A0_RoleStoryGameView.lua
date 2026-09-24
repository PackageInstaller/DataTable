-- chunkname: @modules/logic/necrologiststory/game/v4a0/V4A0_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v4a0.V4A0_RoleStoryGameView", package.seeall)

local V4A0_RoleStoryGameView = class("V4A0_RoleStoryGameView", BaseView)
local ViewState = {
	Level = 2,
	Enter = 1,
	End = 3
}

function V4A0_RoleStoryGameView:onInitView()
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.goEnter = gohelper.findChild(self.viewGO, "#go_enter")
	self.btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_enter/#btn_enter")
	self.goLevel = gohelper.findChild(self.viewGO, "#go_level")
	self.goLineRoot = gohelper.findChild(self.viewGO, "#go_level/ScrollView/Viewport/Content/lineRoot")
	self.goLevelRoot = gohelper.findChild(self.viewGO, "#go_level/ScrollView/Viewport/Content/levelRoot")
	self.btnResult = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_result")
	self.txtResult = gohelper.findChildTextMesh(self.viewGO, "#go_topright/#btn_result/txt_result")
	self.goResult = gohelper.findChild(self.viewGO, "#go_result")
	self.simageResult = gohelper.findChildSingleImage(self.viewGO, "#go_result/#simage_mask01")
	self.simageResult2 = gohelper.findChildSingleImage(self.viewGO, "#go_result/#simage_mask01/#simage_mask01_add")
	self.txtResultTitle = gohelper.findChildTextMesh(self.viewGO, "#go_result/#txt_title")
	self.txtResultDesc1 = gohelper.findChildTextMesh(self.viewGO, "#go_result/#txt_desc_1")
	self.txtResultDesc2 = gohelper.findChildTextMesh(self.viewGO, "#go_result/#txt_desc_2")
	self.goEnd = gohelper.findChild(self.viewGO, "#go_end")
	self.btnEndEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_end/#btn_enter")
	self.goTopRight = gohelper.findChild(self.viewGO, "#go_topright")
	self.scroll = gohelper.findChildComponent(self.viewGO, "#go_level/ScrollView", typeof(ZProj.LimitedScrollRect))

	self:initLine()
	self:initLevel()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4A0_RoleStoryGameView:addEvents()
	self.addClickCb(self, self.btnEndEnter, self.onClickEndEnter, self)
	self.addClickCb(self, self.btnEnter, self.onClickEnter, self)
	self.addClickCb(self, self.btnResult, self.onClickResult, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V4A0_RoleStoryGameView:removeEvents()
	self:removeClickCb(self.btnEndEnter)
	self:removeClickCb(self.btnEnter)
	self:removeClickCb(self.btnResult)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V4A0_RoleStoryGameView:_editableInitView()
	return
end

function V4A0_RoleStoryGameView:onClickEndEnter()
	if self:getResultVisible() then
		return
	end

	self.viewState = ViewState.Level

	self:refreshView()
end

function V4A0_RoleStoryGameView:onClickEnter()
	if self:getResultVisible() then
		return
	end

	local todayStr = TimeUtil.timestampToString1(ServerTime.now() - 18000)

	NecrologistStoryPlayerPrefs.instance:setExist(NecrologistStoryEnum.PrefsKey.V4A0EnterLevel, todayStr)

	self.viewState = ViewState.Level

	self:refreshView()
end

function V4A0_RoleStoryGameView:trySwitchEnter()
	if self.viewState == ViewState.Level then
		if self.gameBaseMO:isComplete() then
			self.viewState = ViewState.End or ViewState.Enter
		end

		self:refreshView()

		return true
	end
end

function V4A0_RoleStoryGameView:onClickResult()
	if self.gameBaseMO:isLevelListComplete() then
		self:showResult()
	else
		GameFacade.showToast(ToastEnum.NecrologistStoryV4A0Tips)
	end
end

function V4A0_RoleStoryGameView:initLine()
	self.enterLineDict = {}
	self.lineDict = {}
	self.endLineDict = {}

	local transform = self.goLineRoot.transform
	local childCount = transform.childCount

	for i = 0, childCount - 1 do
		local child = transform:GetChild(i)

		self:createLine(child, self.lineDict)
	end

	local goEnterLineRoot = gohelper.findChild(self.goEnter, "Content/lineRoot")

	transform = goEnterLineRoot.transform
	childCount = goEnterLineRoot.transform.childCount

	for i = 0, goEnterLineRoot.transform.childCount - 1 do
		local child = transform:GetChild(i)

		self:createLine(child, self.enterLineDict)
	end

	local goEndLineRoot = gohelper.findChild(self.goEnd, "Content/lineRoot")

	transform = goEndLineRoot.transform
	childCount = goEndLineRoot.transform.childCount

	for i = 0, goEndLineRoot.transform.childCount - 1 do
		local child = transform:GetChild(i)

		self:createLine(child, self.endLineDict)
	end
end

function V4A0_RoleStoryGameView:createLine(child, dict)
	local num1, num2 = string.match(child.name, "go_line(%d+)_(%d+)")

	if num1 and num2 then
		num1 = tonumber(num1)
		num2 = tonumber(num2)
		dict[num1] = dict[num1] or {}

		local item = self:getUserDataTb_(child)

		item.go = child.gameObject
		item.goFinish = gohelper.findChild(item.go, "finish")
		item.goUnFinish = gohelper.findChild(item.go, "unfinish")
		item.anim = gohelper.findComponentAnim(item.go)
		dict[num1][num2] = item
	end
end

function V4A0_RoleStoryGameView:initLevel()
	self.levelItemList = {}
	self.enterLevelItemList = {}
	self.endLevelItemList = {}

	local transform = self.goLevelRoot.transform
	local childCount = transform.childCount

	for i = 0, childCount - 1 do
		local child = transform:GetChild(i)

		self:createLevel(child, self.levelItemList)
	end

	local goEnterLevelRoot = gohelper.findChild(self.goEnter, "Content/levelRoot")

	transform = goEnterLevelRoot.transform
	childCount = goEnterLevelRoot.transform.childCount

	for i = 0, goEnterLevelRoot.transform.childCount - 1 do
		local child = transform:GetChild(i)

		self:createLevel(child, self.enterLevelItemList)
	end

	local goEndLevelRoot = gohelper.findChild(self.goEnd, "Content/levelRoot")

	transform = goEndLevelRoot.transform
	childCount = goEndLevelRoot.transform.childCount

	for i = 0, goEndLevelRoot.transform.childCount - 1 do
		local child = transform:GetChild(i)

		self:createLevel(child, self.endLevelItemList)
	end
end

function V4A0_RoleStoryGameView:createLevel(child, dict)
	local num1 = string.match(child.name, "go_level_(%d+)")

	if num1 then
		num1 = tonumber(num1)

		local item = self:getUserDataTb_(child)

		item.go = child.gameObject
		item.id = num1
		item.goFinish = gohelper.findChild(item.go, "finshed")
		item.goUnFinish = gohelper.findChild(item.go, "unfinish")
		item.btnClick = gohelper.findChildButtonWithAudio(item.go, "#btn_click")

		if item.btnClick then
			self.addClickCb(self, item.btnClick, self.onClickLevelItem, self, item)
		end

		item.anim = gohelper.findComponentAnim(item.go)
		dict[num1] = item
	end
end

function V4A0_RoleStoryGameView:onClickLevelItem(item)
	if self:getResultVisible() then
		return
	end

	local config = NecrologistStoryV4A0Config.instance:getBaseConfig(item.id)

	if not config then
		return
	end

	if config.storyId ~= 0 then
		local isFinish = self.gameBaseMO:isStoryFinish(config.storyId)

		NecrologistStoryController.instance:openStoryView(config.storyId, not isFinish and self.gameBaseMO.id)

		return
	end

	if config.questionId ~= 0 then
		ViewMgr.instance:openView(ViewName.V4A0_RoleStoryQuestionView, {
			roleStoryId = self.heroStoryId,
			questionId = config.questionId
		})

		return
	end
end

function V4A0_RoleStoryGameView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	self:refreshView()
end

function V4A0_RoleStoryGameView:onOpen()
	self.isFirstOpen = true

	self:refreshParam()

	self.viewState = self:getViewState()

	self:refreshView()

	self.isFirstOpen = false
end

function V4A0_RoleStoryGameView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V4A0_RoleStoryGameView:onOpenFinish()
	return
end

function V4A0_RoleStoryGameView:refreshParam()
	if not self.viewParam then
		local viewParam = {}
		local storyId = viewParam.roleStoryId

		self.heroStoryId = storyId

		if storyId then
			self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
		end
	end
end

function V4A0_RoleStoryGameView:refreshData()
	return
end

function V4A0_RoleStoryGameView:refreshView()
	self:refreshViewState()
	self:refreshLevel()
	self:refreshLine()
	self:refreshResultBtn()
end

function V4A0_RoleStoryGameView:getViewState()
	local isComplete = self.gameBaseMO:isComplete()

	if isComplete then
		return ViewState.End
	end

	local todayStr = TimeUtil.timestampToString1(ServerTime.now() - 18000)
	local isExist = NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V4A0EnterLevel, todayStr)

	return (isExist or nil) and (ViewState.Level or ViewState.Enter)
end

function V4A0_RoleStoryGameView:refreshViewState()
	local lastState = self._curViewState
	local curState = self.viewState

	self._curViewState = curState

	if lastState == curState then
		return
	end

	if curState == ViewState.Enter then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_jiemian)

		if lastState == ViewState.Level then
			self.anim:Play("switch_enter")
		else
			self.anim:Play("open_enter")
		end
	elseif curState == ViewState.Level then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_resonate_unlock_01)

		if lastState == ViewState.End then
			self.anim:Play("end_switch_level")
		else
			self.anim:Play("switch_level")
		end
	elseif curState == ViewState.End then
		local isExist = NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V4A0PlayFnishedAnim, true)

		if isExist then
			if lastState == ViewState.Level then
				self.anim:Play("level_switch_end")
			else
				AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_jiemian)
				self.anim:Play("open_end")
			end
		else
			NecrologistStoryPlayerPrefs.instance:setExist(NecrologistStoryEnum.PrefsKey.V4A0PlayFnishedAnim, true)
			self.anim:Play("open_end_first")
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_tangren_pen2)
		end
	end
end

function V4A0_RoleStoryGameView:refreshLevel()
	for k, v in pairs(self.levelItemList) do
		self:refreshLevelItem(v)
	end

	for k, v in pairs(self.enterLevelItemList) do
		self:refreshLevelItem(v)
	end

	for k, v in pairs(self.endLevelItemList) do
		self:refreshLevelItem(v)
	end
end

function V4A0_RoleStoryGameView:refreshLevelItem(item)
	local episodeId = item.id
	local isFinished = self.gameBaseMO:isBaseFinished(episodeId)

	gohelper.setActive(item.goFinish, isFinished)
	gohelper.setActive(item.goUnFinish, not isFinished)

	if item.anim then
		if isFinished then
			if item.isFinished == false then
				item.anim:Play("open_finished")
				AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_resonate_fm)
			else
				item.anim:Play("idel_finished")
			end
		else
			item.anim:Play("idel_unfinish")
		end
	end

	item.isFinished = isFinished
end

function V4A0_RoleStoryGameView:refreshLine()
	for k1, v in pairs(self.lineDict) do
		for k2, v2 in pairs(v) do
			self:refreshLineItem(v2, k1, k2)
		end
	end

	for k1, v in pairs(self.enterLineDict) do
		for k2, v2 in pairs(v) do
			self:refreshLineItem(v2, k1, k2)
		end
	end

	for k1, v in pairs(self.endLineDict) do
		for k2, v2 in pairs(v) do
			self:refreshLineItem(v2, k1, k2)
		end
	end
end

function V4A0_RoleStoryGameView:refreshLineItem(item, episodeId1, episodeId2)
	local isFinished = self.gameBaseMO:isBaseFinished(episodeId1) and self.gameBaseMO:isBaseFinished(episodeId2)

	gohelper.setActive(item.goFinish, isFinished)
	gohelper.setActive(item.goUnFinish, not isFinished)

	if item.anim then
		if isFinished then
			if item.isFinished == false then
				item.anim:Play("open_finish")
			else
				item.anim:Play("idel_finish")
			end
		else
			item.anim:Play("idel_unfinish")
		end
	end

	item.isFinished = isFinished
end

function V4A0_RoleStoryGameView:refreshResultBtn()
	if self.viewState ~= ViewState.Level then
		gohelper.setActive(self.btnResult, false)

		return
	end

	local isComplete = self.gameBaseMO:isLevelListComplete()
	local hasResult = self.gameBaseMO:hasResult()
	local showBtn = isComplete or hasResult

	gohelper.setActive(self.btnResult, showBtn)

	if not showBtn then
		return
	end

	if isComplete then
		self.txtResult.text = luaLang("v4a0_rolestorygameview_txt_result")
	else
		local questionCount = 0
		local finishCount = 0
		local baseList = NecrologistStoryV4A0Config.instance:getBaseList()

		for _, baseConfig in ipairs(baseList) do
			if baseConfig.questionId ~= 0 then
				questionCount = questionCount + 1

				if self.gameBaseMO:getQuestionOption(baseConfig.questionId) ~= nil then
					finishCount = finishCount + 1
				end
			end
		end

		self.txtResult.text = string.format("%s/%s", finishCount, questionCount)
	end

	if not isComplete then
		return
	end

	local resultConfig = self.gameBaseMO:getResultConfig()

	if not resultConfig then
		return
	end

	if self.gameBaseMO:isSameResult(resultConfig) then
		return
	end

	self.gameBaseMO:setLastShowResult(resultConfig.id)
	self:showResult()
end

function V4A0_RoleStoryGameView:showResult()
	self:setResultVisible(true)
end

function V4A0_RoleStoryGameView:setResultVisible(visible)
	if self.resultVisible == visible then
		return
	end

	self.resultVisible = visible

	gohelper.setActive(self.goResult, visible)
	gohelper.setActive(self.goTopRight, not visible)

	if not visible then
		local unlock = RoleStoryModel.instance:isCGUnlock(self.heroStoryId)

		if unlock then
			local canPlay = RoleStoryModel.instance:canPlayDungeonUnlockAnim(self.heroStoryId)

			if canPlay then
				NecrologistStoryController.instance:openCgUnlockView(self.heroStoryId)
			end
		end

		return
	end

	local config = self.gameBaseMO:getResultConfig()

	if not config then
		return
	end

	local path = ResUrl.getRoleStoryIcon(string.format("3134/rolestory_3134_fullmask_%s", config.id))

	self.simageResult:LoadImage(path)
	self.simageResult2:LoadImage(path)

	self.txtResultTitle.text = config.title
	self.txtResultDesc1.text = config.desc1
	self.txtResultDesc2.text = config.desc2

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_jiemian)
end

function V4A0_RoleStoryGameView:getResultVisible()
	return self.resultVisible
end

function V4A0_RoleStoryGameView:onDestroyView()
	for k, v in pairs(self.levelItemList) do
		self:removeClickCb(v.btnClick)
	end

	self.simageResult:UnLoadImage()
	self.simageResult2:UnLoadImage()

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function V4A0_RoleStoryGameView:getBaseItemPath(baseId)
	local item = self.levelItemList[baseId]

	if not item then
		return
	end

	self.viewState = ViewState.Level

	self:refreshView()

	local go = item.btnClick.gameObject

	self:moveToLevelItem(baseId)

	return SLFramework.GameObjectHelper.GetPath(go)
end

function V4A0_RoleStoryGameView:moveToLevelItem(baseId)
	local item = self.levelItemList[baseId]

	if not item then
		return
	end

	local contentRect = self.scroll.content
	local viewportRect = self.scroll.viewport
	local contentHeight = recthelper.getHeight(contentRect)
	local viewportHeight = recthelper.getHeight(viewportRect)

	if viewportHeight < contentHeight then
		local childRect = item.go.transform
		local childPosY = recthelper.getAnchorY(childRect)
		local heightOffset = contentHeight - viewportHeight
		local contentPos = math.min(heightOffset, math.abs(childPosY))

		if self.tweenId then
			ZProj.TweenHelper.KillById(self.tweenId)

			self.tweenId = nil
		end

		self.tweenId = ZProj.TweenHelper.DOAnchorPosY(contentRect, contentPos, 0.2)
	end
end

function V4A0_RoleStoryGameView.checkGuide()
	local baseList = NecrologistStoryV4A0Config.instance:getBaseList()
	local gameMo = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V4A0)
	local finishCount = 0

	for _, baseConfig in ipairs(baseList) do
		if gameMo:isBaseFinished(baseConfig.id) then
			finishCount = finishCount + 1
		end
	end

	return finishCount == 1
end

function V4A0_RoleStoryGameView.getFinishGO()
	local baseList = NecrologistStoryV4A0Config.instance:getBaseList()
	local gameMo = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V4A0)
	local baseId

	for _, baseConfig in ipairs(baseList) do
		if gameMo:isBaseFinished(baseConfig.id) then
			baseId = baseConfig.id

			break
		end
	end

	if not baseId then
		return
	end

	local viewContainer = ViewMgr.instance:getContainer(ViewName.V4A0_RoleStoryGameView)

	if not viewContainer then
		return
	end

	return viewContainer.gameView:getBaseItemPath(baseId)
end

function V4A0_RoleStoryGameView.getUnFinishGO()
	local baseList = NecrologistStoryV4A0Config.instance:getBaseList()
	local gameMo = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V4A0)
	local baseId = gameMo:isBaseFinished(2) and 2 or 3
	local viewContainer = ViewMgr.instance:getContainer(ViewName.V4A0_RoleStoryGameView)

	if not viewContainer then
		return
	end

	return viewContainer.gameView:getBaseItemPath(baseId)
end

return V4A0_RoleStoryGameView
