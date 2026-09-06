-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/heartsoul/HeartSoulDungeonView.lua

module("logic.extensions.scenariocopy.view.heartsoul.HeartSoulDungeonView", package.seeall)

local HeartSoulDungeonView = class("HeartSoulDungeonView", ViewComponent)

function HeartSoulDungeonView:ctor()
	HeartSoulDungeonView.super.ctor(self)
end

function HeartSoulDungeonView:buildUI()
	HeartSoulDungeonView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
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
		self._chapters[i].typeId = 0
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
		self._levels[i].UIChangeGroup = self._levels[i].parentGo:GetComponent("UIChangeGroup")
		self._levels[i].btnLevel = Framework.ButtonAdapter.Get(go)
		self._levels[i].videoGo = goutil.findChild(go, "video")
		self._levels[i].battleGo = goutil.findChild(go, "battle")
		self._levels[i].passGo = goutil.findChild(go, "txtPass")
		self._levels[i].lockGo = goutil.findChild(go, "lock")
		self._levels[i].txtName = goutil.findChildTextComponent(go, "txtName")
		self._levels[i].txtChapter = goutil.findChildTextComponent(go, "txtChapter")
		self._levels[i].selectGo = goutil.findChild(go, "select")
	end
end

function HeartSoulDungeonView:bindEvents()
	HeartSoulDungeonView.super.bindEvents(self)
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

function HeartSoulDungeonView:unbindEvents()
	HeartSoulDungeonView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()

	for i = 1, self:_getChapterMaxNum() do
		self._chapters[i].btnChapter:RemoveClickListener()
	end

	for i = 1, self:_getStageMaxNum() do
		self._levels[i].btnLevel:RemoveClickListener()
	end
end

function HeartSoulDungeonView:onEnter()
	HeartSoulDungeonView.super.onEnter(self)

	if not self:_isInActivityTime() then
		return
	end

	self:_markRedPoint()

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

	self:_loadBgEffect()
	GlobalDispatcher:addListener(GlobalNotify.ScenariocopyStageUpdate, self._onStageUpdate, self)
end

function HeartSoulDungeonView:onExit()
	HeartSoulDungeonView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ScenariocopyStageUpdate, self._onStageUpdate, self)
	self:_removeBgEffect()
	self:_removeLevelEffect()
end

function HeartSoulDungeonView:_onClickClose()
	self:close()
end

function HeartSoulDungeonView:_onClickChapter(index)
	self:_setSelectChapter(index)
end

function HeartSoulDungeonView:_onClickLevel(index)
	local plotChapterCfg = self._plotChapterCfgs[index]
	local mainUnlockCondition = plotChapterCfg.unlockCondition
	local chapterId = mainUnlockCondition[2]
	local stageId = mainUnlockCondition[3]
	local isMainOpen = ScenariocopyModel.instance:getStagePass(chapterId, stageId)
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
			UIStateManager.instance:open(self:_getStageViewName(), curStageCfg, self:_getViewName(), self._curSelectChapterIndex)
		end
	else
		local name1 = ScenariocopyController.instance:getStageName(self._curSelectChapterTypeId, chapterId, stageId, true)
		local name2 = ScenariocopyController.instance:getStageName(self._curSelectChapterTypeId, plotChapterCfg.chapterId, 1, false)

		FloatWordMgr.instance:show(langPara("通关[%s]后开启", name1))
	end
end

function HeartSoulDungeonView:_getPlotId()
	return ScenariocopyModel.instance:getPlotId()
end

function HeartSoulDungeonView:_getSortPlotChapterCfgs(typeId)
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

function HeartSoulDungeonView:_isInActivityTime()
	if not ScenariocopyModel.instance:refreshActIdandPlotId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))

		return false
	end

	return true
end

function HeartSoulDungeonView:_setConfigs()
	local cfgs = ScenariocopyConfig.instance:getStoryCfgs(self:_getPlotId())
	local list = {}

	for _, v in pairs(cfgs) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.typeId < b.typeId
	end)

	self._plotStoryCfgs = {}

	local startIndex, endIndex = self:_getIndexRange()

	for i, v in ipairs(list) do
		if startIndex <= i and i <= endIndex then
			table.insert(self._plotStoryCfgs, v)
		end
	end
end

function HeartSoulDungeonView:_initChapters()
	self:_updateChapters(true)
	self:_setSelectChapter()
end

function HeartSoulDungeonView:_updateChapters(isResetSelect)
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

		if isUnlock == true then
			highChapterTypeId = self._plotStoryCfgs[i].typeId
			index = i or index
		end
	end

	self._curHighChapterTypeId = highChapterTypeId
	self._curHighChapterIndex = index
end

function HeartSoulDungeonView:_setSelectChapter(index)
	local selectIndex = index
	local selectTypeId = 0

	if selectIndex ~= nil then
		selectIndex = Mathf.Clamp(selectIndex, 1, self:_getChapterMaxNum())

		local isSameSelect = selectIndex == self._curSelectChapterIndex

		if isSameSelect == true then
			return
		end

		local isUnlock = self._chapters[selectIndex].isUnlock

		if isUnlock == false then
			FloatWordMgr.instance:show(self._chapters[selectIndex].tipDesc)

			return
		end

		selectTypeId = self._chapters[selectIndex].typeId
	else
		selectIndex = self._curHighChapterIndex
		selectTypeId = self._curHighChapterTypeId
	end

	self._curSelectChapterIndex = selectIndex
	self._curSelectChapterTypeId = selectTypeId

	for i, v in ipairs(self._chapters) do
		v.selectGo:SetActive(i == self._curSelectChapterIndex)
	end

	self:_updateLevels(self._curSelectChapterTypeId)
	self:_selectEndChange(self._curSelectChapterIndex)
end

function HeartSoulDungeonView:_updateLevels(typeId)
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
		v.parentGo:SetActive(i <= nums)

		if i <= nums then
			local unlockCondition = plotChapterCfgs[i].unlockCondition
			local cfgStage = ScenariocopyConfig.instance:getStageCfg(plotChapterCfgs[i].chapterId, 1)
			local isUnlock = ScenariocopyModel.instance:getStagePass(unlockCondition[2], unlockCondition[3])
			local isPass = ScenariocopyModel.instance:getStagePass(plotChapterCfgs[i].chapterId, 1)

			v.isUnlock = isUnlock
			v.txtName.text = plotChapterCfgs[i].chapterName
			v.txtChapter.text = plotChapterCfgs[i].orderNumber

			v.lockGo:SetActive(not isUnlock)
			v.videoGo:SetActive(isUnlock and cfgStage.purePlot)
			v.battleGo:SetActive(isUnlock and not cfgStage.purePlot)
			v.passGo:SetActive(isUnlock and isPass)
			v.selectGo:SetActive(isUnlock and not isPass)

			if isUnlock and not isPass then
				targetIndex = i
			end

			v.UIChangeGroup:SetState(self._curSelectChapterIndex - 1)
		end
	end

	if targetIndex > 0 and self._levels[targetIndex] then
		local cfgStage = ScenariocopyConfig.instance:getStageCfg(plotChapterCfgs[targetIndex].chapterId, 1)

		self:_loadLevelEffect(self._levels[targetIndex].selectGo, cfgStage.purePlot)
	else
		self:_removeLevelEffect()
	end
end

function HeartSoulDungeonView:_onStageUpdate()
	printInfo("test _onStageUpdate")
	self:_initChapters()
end

function HeartSoulDungeonView:_loadMainIcon(index)
	self:_removeMainIcon()

	index = Mathf.Clamp(index, 1, self:_getChapterMaxNum())

	local path = self:_getMainIconPath(index)

	uGuiUtil.setSpriteToImage(self._mainIcon, uGuiUtil.SpriteType.BigBg, path)
end

function HeartSoulDungeonView:_removeMainIcon()
	Framework.ImageBigBG.Get(self._mainIcon):ClearImage()
end

function HeartSoulDungeonView:_startMainIconAnim()
	local tp = UnityTweens.TweenPosition.StartTween(self._mainIcon, Vector3.New(79, -15, 0), Vector3.New(79, 30, 0), 1.9, UnityTweens.EaseType.easeInOutQuad, 0, UnityTweens.CoordSpace.Anchor)

	tp.loopType = UnityTweens.LoopType.pingPong
end

function HeartSoulDungeonView:_loadBgEffect()
	self:_removeBgEffect()

	local path = self:_getBgEffectPath()
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

	uiEffect:setParent(self._bg.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._bgUIEffect = uiEffect
end

function HeartSoulDungeonView:_removeBgEffect()
	if self._bgUIEffect then
		UIEffectManager.instance:stopEffect(self._bgUIEffect)

		self._bgUIEffect = nil
	end
end

function HeartSoulDungeonView:_loadChapterSelectEffect()
	self:_removeChapterSelectEffect()

	local path = self:_getChapterSelectEffectPath()

	self._chapterUIEffects = {}

	for i = 1, self:_getChapterMaxNum() do
		local uiEffect = UIEffectManager.instance:playEffect(self, path, self._chapters[i].selectGo.transform, 0, 0, true, false)

		uiEffect:setParent(self._chapters[i].selectGo.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(0, 0, 0)

		self._chapterUIEffects[i] = uiEffect
	end
end

function HeartSoulDungeonView:_removeChapterSelectEffect()
	if self._chapterUIEffects then
		for i = 1, self:_getChapterMaxNum() do
			if self._chapterUIEffects[i] then
				UIEffectManager.instance:stopEffect(self._chapterUIEffects[i])
			end
		end

		self._chapterUIEffects = nil
	end
end

function HeartSoulDungeonView:_loadLevelEffect(go, isPurePlot)
	self:_removeLevelEffect()

	local effPath = self:_getLevelSelectEffectPath(isPurePlot)
	local x, y, z, scale

	if isPurePlot then
		z = 0
		y = 4.55
		x = -6
		scale = 1
	else
		z = 0
		y = -3.25
		x = -1.9
		scale = 1.1
	end

	local function func(_, eff)
		eff:setParent(go.transform)
		eff:setLocalPos(x, y, z)
		eff:setScale(scale)
	end

	if go ~= nil then
		self._levelUIEffect = UIEffectManager.instance:playEffect(self, effPath, go.transform, 0, 0, true, false, nil, func)
	end
end

function HeartSoulDungeonView:_removeLevelEffect()
	if self._levelUIEffect then
		UIEffectManager.instance:stopEffect(self._levelUIEffect)

		self._levelUIEffect = nil
	end
end

function HeartSoulDungeonView:_getChapterMaxNum()
	return 3
end

function HeartSoulDungeonView:_getStageMaxNum()
	return 6
end

function HeartSoulDungeonView:_getIndexRange()
	return 1, 3
end

function HeartSoulDungeonView:_getViewName()
	return ViewName.HeartSoulDungeonView
end

function HeartSoulDungeonView:_getStageViewName()
	return ViewName.HeartSoulStageView
end

function HeartSoulDungeonView:_markRedPoint()
	ScenariocopyController.instance:markHeartSoulRedPoint()
end

function HeartSoulDungeonView:_getBgEffectPath()
	return "fx_ui_20211014/fx_ui_xinxinniannian/fx_ui_mianban_xxnn.prefab"
end

function HeartSoulDungeonView:_getChapterSelectEffectPath()
	return "fx_ui_20211014/fx_ui_xinxinniannian/fx_ui_kuang_xxnn.prefab"
end

function HeartSoulDungeonView:_getLevelSelectEffectPath(isPurePlot)
	return isPurePlot == true and "fx_ui_20211014/fx_ui_xinxinniannian/fx_ui_xuanzhong_luxiang_xxnn.prefab" or "fx_ui_20211014/fx_ui_xinxinniannian/fx_ui_xuanzhong_zi_xxnn.prefab"
end

function HeartSoulDungeonView:_getMainIconPath(index)
	local iconPaths = {
		"ui/bigbg/onepeoplecopy/board_zhsdl_bg05.png",
		"ui/bigbg/onepeoplecopy/board_zhsdl_bg06.png",
		"ui/bigbg/onepeoplecopy/board_zhsdl_bg07.png",
		"ui/bigbg/onepeoplecopy/board_zhsdl_bg08.png"
	}

	return iconPaths[index]
end

function HeartSoulDungeonView:_loadMainIconEffect()
	self._mainIconEffectParent:SetActive(false)
	self:_removeMainIconEffect()

	local path = "fx_ui_yrzxjuqingfuben/fx_ui_qimenzhenhai_jqtz.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._mainIconEffectParent.transform, 0, 0, true, false)

	uiEffect:setParent(self._mainIconEffectParent.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._mainIconUIEffect = uiEffect
end

function HeartSoulDungeonView:_removeMainIconEffect()
	if self._mainIconUIEffect then
		UIEffectManager.instance:stopEffect(self._mainIconUIEffect)

		self._mainIconUIEffect = nil
	end
end

function HeartSoulDungeonView:_selectEndChange(index)
	self:_loadBgEffect(index)
	self:_setBg(index)
end

function HeartSoulDungeonView:_setBg(index)
	if index == nil then
		index = 1
	end

	bgPath = {
		"ui/bigbg/yyfb/bg_xxnn_01.png",
		"ui/bigbg/yyfb/bg_xxnn_02.png",
		"ui/bigbg/yyfb/bg_xxnn_03.png"
	}

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, bgPath[index])
end

function HeartSoulDungeonView:_levelChange(index)
	for _, level in ipairs(self._levels) do
		level.UIChangeGroup:SetState(index - 1)
	end
end

return HeartSoulDungeonView
