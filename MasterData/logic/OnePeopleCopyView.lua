-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/onepeople/OnePeopleCopyView.lua

module("logic.extensions.scenariocopy.view.onepeople.OnePeopleCopyView", package.seeall)

local OnePeopleCopyView = class("OnePeopleCopyView", ViewComponent)

function OnePeopleCopyView:ctor()
	OnePeopleCopyView.super.ctor(self)
end

function OnePeopleCopyView:buildUI()
	OnePeopleCopyView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtChapterName = self:getTxt("bgChapterName/txtChapterName")
	self._mainIcon = self:getGo("left/mainIcon")
	self._mainIconTrans = self._mainIcon:GetComponent(goutil.Type_RectTransform)
	self._cell = self:getGo("levelCell")

	self._cell:SetActive(false)

	self._chapters = {}

	local chapterNum = self:_getChapterMaxNum()

	for i = 1, chapterNum do
		self._chapters[i] = {}
		self._chapters[i].btnChapter = self:getBtn("chapters/btnChapter" .. i)
		self._chapters[i].txtName = self:getTxt(string.format("chapters/btnChapter%d/txtName", i))
		self._chapters[i].selectGo = self:getGo(string.format("chapters/btnChapter%d/select", i))
		self._chapters[i].lockGo = self:getGo(string.format("chapters/btnChapter%d/lock", i))
		self._chapters[i].tipDesc = ""
		self._chapters[i].isUnlock = false
	end

	self._levelsGo = self:getGo("levels")
	self._levelsPosPlan = self._levelsGo:GetComponent(typeof(TestRecordPos))
	self._levels = {}

	local stageMaxNum = self:_getStageMaxNum()

	for i = 1, stageMaxNum do
		local go = goutil.cloneAndSetParent(self._cell, self._levelsGo.transform, "level" .. i)

		go:SetActive(false)

		self._levels[i] = {}
		self._levels[i].parentGo = go
		self._levels[i].btnLevel = Framework.ButtonAdapter.Get(go)
		self._levels[i].videoGo = goutil.findChild(go, "video")
		self._levels[i].battleGo = goutil.findChild(go, "battle")
		self._levels[i].passGo = goutil.findChild(go, "txtPass")
		self._levels[i].lockGo = goutil.findChild(go, "lock")
		self._levels[i].txtName = goutil.findChildTextComponent(go, "txtName")
		self._levels[i].selectGo = goutil.findChild(go, "select")
	end

	self._bg = self:getGo("bg")
	self._mainIconEffectParent = self:getGo("left/mainIcon/effect")
end

function OnePeopleCopyView:bindEvents()
	OnePeopleCopyView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)

	for i = 1, self:_getChapterMaxNum() do
		self._chapters[i].btnChapter:AddClickListener(function()
			self:_onClickChapter(i)
		end)
	end

	for i = 1, self:_getStageMaxNum() do
		self._levels[i].btnLevel:AddClickListener(function()
			self:_onClickLevel(i)
		end)
	end
end

function OnePeopleCopyView:unbindEvents()
	OnePeopleCopyView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()

	for i = 1, self:_getChapterMaxNum() do
		self._chapters[i].btnChapter:RemoveClickListener()
	end

	for i = 1, self:_getStageMaxNum() do
		self._levels[i].btnLevel:RemoveClickListener()
	end
end

function OnePeopleCopyView:onEnter()
	OnePeopleCopyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ScenariocopyStageUpdate, self._onStageUpdate, self)
	self._mainIcon:SetActive(false)

	if not self:_isInActivityTime() then
		return
	end

	self:_markRedPoint()
	self._mainIcon:SetActive(true)

	self._curHighChapterTypeId = 0
	self._curHighChapterIndex = 0
	self._curSelectChapterTypeId = 0
	self._curSelectChapterIndex = 0

	self:_setConfigs()

	local params = self:getOpenParam()

	if params then
		local typeId = params[1]
		local index = 1

		for i, v in ipairs(self._plotStoryCfgs) do
			if v.typeId == typeId then
				index = i
			end
		end

		self:_updateChapters(true)
		self:_setSelectChapter(index)
	else
		self:_initChapters()
	end

	self:_startMainIconAnim()
	self:_loadBgEffect()
	self:_loadMainIconEffect()
	self:_loadChapterSelectEffect()
end

function OnePeopleCopyView:onExit()
	OnePeopleCopyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ScenariocopyStageUpdate, self._onStageUpdate, self)
	self:_removeMainIcon()
	self:_removeBgEffect()
	self:_removeMainIconEffect()
	self:_removeChapterSelectEffect()
	self:_removeLevelEffect()
end

function OnePeopleCopyView:_onClickClose()
	self:close()
end

function OnePeopleCopyView:_onClickChapter(index)
	self:_setSelectChapter(index)
end

function OnePeopleCopyView:_onClickLevel(index)
	self:_clickLevel(index)
end

function OnePeopleCopyView:_getPlotId()
	return ScenariocopyModel.instance:getPlotId()
end

function OnePeopleCopyView:_isInActivityTime()
	if not ScenariocopyModel.instance:isInActivityTime(ScenariocopyModel.OnePeoplePlotId) then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))

		return false
	end

	return true
end

function OnePeopleCopyView:_updateChapters(isResetSelect)
	local highChapterTypeId = 0
	local index = 1

	for i, v in ipairs(self._chapters) do
		v.txtName.text = self._plotStoryCfgs[i].storyName

		local isUnlock, tipDesc = ScenariocopyController.instance:getStoryIfUnlockAndText(self._plotStoryCfgs[i].typeId)

		v.lockGo:SetActive(not isUnlock)

		if isResetSelect then
			v.selectGo:SetActive(false)
		end

		v.typeId = self._plotStoryCfgs[i].typeId
		v.tipDesc = tipDesc
		v.isUnlock = isUnlock

		if isUnlock then
			highChapterTypeId = self._plotStoryCfgs[i].typeId
			index = i
		end
	end

	self._curHighChapterTypeId = highChapterTypeId
	self._curHighChapterIndex = index
end

function OnePeopleCopyView:_setSelectChapter(index)
	if index ~= nil then
		index = Mathf.Clamp(index, 1, self:_getChapterMaxNum())

		if index ~= self._curSelectChapterIndex then
			if self._chapters[index].isUnlock then
				self._curSelectChapterIndex = index
				self._curSelectChapterTypeId = self._chapters[index].typeId
			else
				FloatWordMgr.instance:show(self._chapters[index].tipDesc)

				return
			end
		else
			return
		end
	else
		index = self._curHighChapterIndex
		self._curSelectChapterIndex = self._curHighChapterIndex
		self._curSelectChapterTypeId = self._curHighChapterTypeId
	end

	for i, v in ipairs(self._chapters) do
		v.selectGo:SetActive(i == index)
	end

	self:_loadMainIcon(index)
	self:_updateLevels(self._curSelectChapterTypeId)

	self._txtChapterName.text = string.format("第%s章 %s", GameUtil.getChineseNumber(index), self._plotStoryCfgs[index].storyName)

	self:_selectEndChange(index)
end

function OnePeopleCopyView:_initChapters()
	self:_updateChapters(true)
	self:_setSelectChapter()
end

function OnePeopleCopyView:_getSortPlotChapterCfgs(typeId)
	local plotChapterCfgs = ScenariocopyConfig.instance:getChapterCfgs(typeId)
	local sortCfgs = {}

	for k, v in pairs(plotChapterCfgs) do
		table.insert(sortCfgs, v)
	end

	table.sort(sortCfgs, function(a, b)
		return a.chapterId < b.chapterId
	end)

	return sortCfgs
end

function OnePeopleCopyView:_updateLevels(typeId)
	if typeId <= 0 then
		for i, v in ipairs(self._levels) do
			v.parentGo:SetActive(false)
		end

		return
	end

	local plotChapterCfgs = self:_getSortPlotChapterCfgs(typeId)

	self._plotChapterCfgs = plotChapterCfgs

	local nums = #plotChapterCfgs

	self._levelsPosPlan:LoadPlan(nums - 1)

	local targetIndex = -1

	for i, v in ipairs(self._levels) do
		if i <= nums then
			v.parentGo:SetActive(true)

			v.txtName.text = plotChapterCfgs[i].chapterName .. "\n" .. plotChapterCfgs[i].orderNumber

			local unlockCondition = plotChapterCfgs[i].unlockCondition
			local isUnlock = ScenariocopyModel.instance:getStagePass(unlockCondition[2], unlockCondition[3])
			local isPass = ScenariocopyModel.instance:getStagePass(plotChapterCfgs[i].chapterId, 1)

			v.lockGo:SetActive(not isUnlock)

			v.isUnlock = isUnlock

			if isUnlock then
				local cfgStage = ScenariocopyConfig.instance:getStageCfg(plotChapterCfgs[i].chapterId, 1)

				v.videoGo:SetActive(cfgStage.purePlot)
				v.battleGo:SetActive(not cfgStage.purePlot)
				v.passGo:SetActive(isUnlock and isPass)
				v.selectGo:SetActive(isUnlock and not isPass)
			else
				v.videoGo:SetActive(false)
				v.battleGo:SetActive(false)
				v.passGo:SetActive(false)
				v.selectGo:SetActive(false)
			end

			if isUnlock and not isPass then
				targetIndex = i
			end
		else
			v.parentGo:SetActive(false)
		end
	end

	if targetIndex > 0 and self._levels[targetIndex] then
		self:_loadLevelEffect(self._levels[targetIndex].selectGo)
	else
		self:_removeLevelEffect()
	end
end

function OnePeopleCopyView:_clickLevel(index)
	local plotChapterCfg = self._plotChapterCfgs[index]
	local mainUnlockCondition = plotChapterCfg.unlockCondition
	local chapterId = mainUnlockCondition[2]
	local stageId = mainUnlockCondition[3]
	local isMainOpen = ScenariocopyModel.instance:getStagePass(chapterId, stageId)
	local stageCfg

	if chapterId ~= nil and stageId ~= nil then
		stageCfg = ScenariocopyConfig.instance:getStageCfg(chapterId, stageId)
	end

	local curStageCfg = ScenariocopyConfig.instance:getStageCfg(plotChapterCfg.chapterId, 1)

	if isMainOpen then
		if not ScenariocopyController.instance:isFinishTask(plotChapterCfg) then
			return
		end

		ScenariocopyModel.instance:setTypeId(self._curSelectChapterTypeId, false)
		ScenariocopyModel.instance:setStageCfg(curStageCfg)
		ScenariocopyModel.instance:setChapterCfg(plotChapterCfg)
		ScenariocopyModel.instance:setChapterId(plotChapterCfg.chapterId)
		ScenariocopyModel.instance:setStageId(1)

		if curStageCfg.pureAnimId > 0 then
			ScenariocopyController.instance:enterMissionOrStory(curStageCfg)
		else
			UIStateManager.instance:open(self:_getStageViewName(), curStageCfg, self:_getViewName())
		end
	else
		local name1 = ScenariocopyController.instance:getStageName(self._curSelectChapterTypeId, chapterId, stageId, true)
		local name2 = ScenariocopyController.instance:getStageName(self._curSelectChapterTypeId, plotChapterCfg.chapterId, 1, false)

		FloatWordMgr.instance:show(langPara("通关[%s]后\n开启[%s]", name1, name2))
	end
end

function OnePeopleCopyView:_onStageUpdate()
	printInfo("test _onStageUpdate")
	self:_initChapters()
end

function OnePeopleCopyView:_loadMainIcon(index)
	self:_removeMainIcon()

	index = Mathf.Clamp(index, 1, self:_getChapterMaxNum())

	uGuiUtil.setSpriteToImage(self._mainIcon, uGuiUtil.SpriteType.BigBg, OnePeopleCopyViewPresentor.IconPaths[index])
end

function OnePeopleCopyView:_removeMainIcon()
	Framework.ImageBigBG.Get(self._mainIcon):ClearImage()
end

function OnePeopleCopyView:_startMainIconAnim()
	local tp = UnityTweens.TweenPosition.StartTween(self._mainIcon, Vector3.New(79, -15, 0), Vector3.New(79, 30, 0), 1.9, UnityTweens.EaseType.easeInOutQuad, 0, UnityTweens.CoordSpace.Anchor)

	tp.loopType = UnityTweens.LoopType.pingPong
end

function OnePeopleCopyView:_loadBgEffect()
	self:_removeBgEffect()

	local path = self:_getBgEffectPath()
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

	uiEffect:setParent(self._bg.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._bgUIEffect = uiEffect
end

function OnePeopleCopyView:_removeBgEffect()
	if self._bgUIEffect then
		UIEffectManager.instance:stopEffect(self._bgUIEffect)

		self._bgUIEffect = nil
	end
end

function OnePeopleCopyView:_showMainIconEffect()
	self._mainIconEffectParent:SetActive(false)
	self._mainIconEffectParent:SetActive(true)
end

function OnePeopleCopyView:_loadChapterSelectEffect()
	self:_removeChapterSelectEffect()

	local path = self:_getChapterSelectEffectPath()

	if path then
		self._chapterUIEffects = {}

		for i = 1, self:_getChapterMaxNum() do
			local uiEffect = UIEffectManager.instance:playEffect(self, path, self._chapters[i].selectGo.transform, 0, 0, true, false)

			uiEffect:setParent(self._chapters[i].selectGo.transform)
			uiEffect:setScale(1)
			uiEffect:setLocalPos(0, 0, 0)

			self._chapterUIEffects[i] = uiEffect
		end
	end
end

function OnePeopleCopyView:_removeChapterSelectEffect()
	if self._chapterUIEffects then
		for i = 1, self:_getChapterMaxNum() do
			if self._chapterUIEffects[i] then
				UIEffectManager.instance:stopEffect(self._chapterUIEffects[i])
			end
		end

		self._chapterUIEffects = nil
	end
end

function OnePeopleCopyView:_loadLevelEffect(go)
	self:_removeLevelEffect()

	local path = self:_getLevelSelectEffectPath()
	local uiEffect = UIEffectManager.instance:playEffect(self, path, go.transform, 0, 0, true, false)

	uiEffect:setParent(go.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._levelUIEffect = uiEffect
end

function OnePeopleCopyView:_removeLevelEffect()
	if self._levelUIEffect then
		UIEffectManager.instance:stopEffect(self._levelUIEffect)

		self._levelUIEffect = nil
	end
end

function OnePeopleCopyView:_setConfigs()
	local cfgs = ScenariocopyConfig.instance:getStoryCfgs(self:_getPlotId())
	local list = {}

	for k, v in pairs(cfgs) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.typeId < b.typeId
	end)

	self._plotStoryCfgs = self:_clampList(list)
end

function OnePeopleCopyView:_clampList(list)
	local result = {}
	local startIndex, endIndex = self:_getIndexRange()

	for i, v in ipairs(list) do
		if startIndex <= i and i <= endIndex then
			table.insert(result, v)
		end
	end

	return result
end

function OnePeopleCopyView:_getChapterMaxNum()
	return 4
end

function OnePeopleCopyView:_getStageMaxNum()
	return 7
end

function OnePeopleCopyView:_getIndexRange()
	return 1, 4
end

function OnePeopleCopyView:_getViewName()
	return ViewName.OnePeopleCopyView
end

function OnePeopleCopyView:_getStageViewName()
	return ViewName.OnePeopleStageView
end

function OnePeopleCopyView:_markRedPoint()
	ScenariocopyController.instance:markOnePeopleCopyRedPoint()
end

function OnePeopleCopyView:_getBgEffectPath()
	return OnePeopleCopyViewPresentor.BgEffectPath
end

function OnePeopleCopyView:_getChapterSelectEffectPath()
	return OnePeopleCopyViewPresentor.ChapterEffectPath
end

function OnePeopleCopyView:_getLevelSelectEffectPath()
	return OnePeopleCopyViewPresentor.LevelEffectPath
end

function OnePeopleCopyView:_loadMainIconEffect()
	self._mainIconEffectParent:SetActive(false)
	self:_removeMainIconEffect()

	local path = OnePeopleCopyViewPresentor.SphereEffectPath
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._mainIconEffectParent.transform, 0, 0, true, false)

	uiEffect:setParent(self._mainIconEffectParent.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._mainIconUIEffect = uiEffect
end

function OnePeopleCopyView:_removeMainIconEffect()
	if self._mainIconUIEffect then
		UIEffectManager.instance:stopEffect(self._mainIconUIEffect)

		self._mainIconUIEffect = nil
	end
end

function OnePeopleCopyView:_selectEndChange()
	return
end

return OnePeopleCopyView
