-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/father/FatherDungeonView.lua

module("logic.extensions.scenariocopy.view.father.FatherDungeonView", package.seeall)

local FatherDungeonView = class("FatherDungeonView", ViewComponent)

function FatherDungeonView:ctor()
	FatherDungeonView.super.ctor(self)
end

function FatherDungeonView:buildUI()
	FatherDungeonView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtChapterName = goutil.findChildTextComponent(self.mainGO, "bgChapterName/txtChapterName")
	self._bg = self:getGo("bg")
	self._mainIcon = goutil.findChild(self.mainGO, "left/mainIcon")
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
		self._chapters[i].txtChapter = self:getTxt(string.format("chapters/btnChapter%d/txtChapter", i))
		self._chapters[i].txtPass = self:getGo(string.format("chapters/btnChapter%d/txtPass", i))
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
		self._levels[i].btnLevel = Framework.ButtonAdapter.Get(go)
		self._levels[i].videoGo = goutil.findChild(go, "video")
		self._levels[i].battleGo = goutil.findChild(go, "battle")
		self._levels[i].passGo = goutil.findChild(go, "txtPass")
		self._levels[i].videoLockGo = goutil.findChild(go, "videoLock")
		self._levels[i].battleLockGo = goutil.findChild(go, "battleLock")
		self._levels[i].txtName = goutil.findChildTextComponent(go, "txtName")
		self._levels[i].txtChapter = goutil.findChildTextComponent(go, "txtChapter")
		self._levels[i].selectGo = goutil.findChild(go, "select")
	end
end

function FatherDungeonView:bindEvents()
	FatherDungeonView.super.bindEvents(self)

	if self._closeButton then
		self._closeButton:AddClickListener(self._onClickClose, self)
	end

	if self:needChaptersSwitch() then
		for i = 1, self:_getChapterMaxNum() do
			self._chapters[i].btnChapter:AddClickListener(function()
				self:_onClickChapter(i)
			end)
		end
	end

	for i = 1, self:_getStageMaxNum() do
		self._levels[i].btnLevel:AddClickListener(function()
			self:_onClickLevel(i)
		end)
	end
end

function FatherDungeonView:unbindEvents()
	FatherDungeonView.super.unbindEvents(self)

	if self._closeButton then
		self._closeButton:RemoveClickListener()
	end

	if self:needChaptersSwitch() then
		for i = 1, self:_getChapterMaxNum() do
			self._chapters[i].btnChapter:RemoveClickListener()
		end
	end

	for i = 1, self:_getStageMaxNum() do
		self._levels[i].btnLevel:RemoveClickListener()
	end
end

function FatherDungeonView:onEnter()
	FatherDungeonView.super.onEnter(self)

	if not self:_isInActivityTime() then
		return
	end

	ScenariocopyController.instance:markFirstClickRedPoint()

	self._curHighChapterTypeId = 0
	self._curHighChapterIndex = 0
	self._curSelectChapterTypeId = 0
	self._curSelectChapterIndex = 0

	local isSuccess = self:_setConfigs()

	if isSuccess == false then
		self:_onClickClose()

		return
	end

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

	self:_loadMainIconEffect()
	self:_loadChapterSelectEffect()
	GlobalDispatcher:addListener(GlobalNotify.ScenariocopyStageUpdate, self._onStageUpdate, self)
	ScenariocopyController.instance:getInfo()
end

function FatherDungeonView:onExit()
	FatherDungeonView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ScenariocopyStageUpdate, self._onStageUpdate, self)
	self:_removeMainIcon()
	self:_removeMainIconEffect()
	self:_removeBgEffect()
	self:_removeChapterSelectEffect()
	self:_removeLevelEffect()
end

function FatherDungeonView:_getSortPlotChapterCfgs(typeId)
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

function FatherDungeonView:_isInActivityTime()
	if not ScenariocopyModel.instance:refreshActIdandPlotId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))

		return false
	end

	return true
end

function FatherDungeonView:_setConfigs()
	local plotId = ScenariocopyModel.instance:getPlotId()

	if plotId == nil then
		printError("没获取到plotId，界面退出")

		return false
	end

	local cfgs = ScenariocopyConfig.instance:getStoryCfgs(plotId)

	if cfgs == nil then
		printError(string.format("plotId = %s, 没获取到StoryCfgs，界面退出", plotId))

		return false
	end

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

	return true
end

function FatherDungeonView:_initChapters()
	self:_updateChapters(true)
	self:_setSelectChapter()
end

function FatherDungeonView:_updateChapters(isResetSelect)
	local highChapterTypeId = 0
	local index = 1

	for i, v in ipairs(self._chapters) do
		self:setTextIngoreNil(v.txtName, self._plotStoryCfgs[i].storyName)
		self:setTextIngoreNil(v.txtChapter, i)

		local isUnlock, tipDesc = ScenariocopyController.instance:getStoryIfUnlockAndText(self._plotStoryCfgs[i].typeId)

		self:setActiveIngoreNil(v.lockGo, not isUnlock)

		if isResetSelect then
			self:setActiveIngoreNil(v.selectGo, false)
		end

		if v.txtPass then
			local isLevelAllPass = true
			local plotChapterCfgs = self:_getSortPlotChapterCfgs(self._plotStoryCfgs[i].typeId)

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

			self:setActiveIngoreNil(v.txtPass, isLevelAllPass)
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

function FatherDungeonView:_setSelectChapter(index)
	local selectIndex = index
	local selectTypeId = 0

	if selectIndex ~= nil then
		local isSameSelect = selectIndex == self._curSelectChapterIndex

		if isSameSelect == true then
			return
		end
	end

	if selectIndex == nil then
		selectIndex = self._curHighChapterIndex
		selectTypeId = self._curHighChapterTypeId
	else
		local isUnlock = self._chapters[selectIndex].isUnlock

		if isUnlock == false then
			FloatWordMgr.instance:show(self._chapters[selectIndex].tipDesc)

			selectIndex = self._curHighChapterIndex
			selectTypeId = self._curHighChapterTypeId
		else
			selectTypeId = self._chapters[selectIndex].typeId
		end
	end

	self._curSelectChapterIndex = selectIndex
	self._curSelectChapterTypeId = selectTypeId

	for i, v in ipairs(self._chapters) do
		self:setActiveIngoreNil(v.selectGo, i == self._curSelectChapterIndex)
	end

	self:_loadMainIcon(self._curSelectChapterIndex)

	if self._txtChapterName then
		self._txtChapterName.text = langPara("第%s章：%s", GameUtil.getChineseNumber(self._curSelectChapterIndex), self._plotStoryCfgs[self._curSelectChapterIndex].storyName)
	end

	self:_updateLevels(self._curSelectChapterTypeId)
	self:_selectEndChange(self._curSelectChapterIndex)
end

function FatherDungeonView:_updateLevelCellSpec(go, index, typeId, plotChapterCfg)
	return
end

function FatherDungeonView:_updateLevels(typeId)
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

			self:setTextIngoreNil(v.txtName, plotChapterCfgs[i].chapterName)
			self:setTextIngoreNil(v.txtChapter, plotChapterCfgs[i].orderNumber)
			self:setActiveIngoreNil(v.videoLockGo, not isUnlock and cfgStage.purePlot)
			self:setActiveIngoreNil(v.battleLockGo, not isUnlock and not cfgStage.purePlot)
			self:setActiveIngoreNil(v.videoGo, isUnlock and cfgStage.purePlot)
			self:setActiveIngoreNil(v.battleGo, isUnlock and not cfgStage.purePlot)
			self:setActiveIngoreNil(v.passGo, isUnlock and isPass)
			self:setActiveIngoreNil(v.selectGo, isUnlock and not isPass)

			if isUnlock and not isPass then
				targetIndex = i
			end

			self:_updateLevelCellSpec(v.parentGo, i, typeId, plotChapterCfgs[i])
		end
	end

	if targetIndex > 0 and self._levels[targetIndex] then
		local cfgStage = ScenariocopyConfig.instance:getStageCfg(plotChapterCfgs[targetIndex].chapterId, 1)

		self:_loadLevelEffect(self._levels[targetIndex].selectGo, cfgStage.purePlot)
	else
		self:_removeLevelEffect()
	end

	for idx, level in ipairs(self._levels) do
		self:setActiveIngoreNil(level.selectGo, idx == targetIndex)
	end
end

function FatherDungeonView:_onStageUpdate()
	self:_initChapters()
end

function FatherDungeonView:_loadMainIcon(index)
	local path = self:_getMainIconPath(index)

	if string.nilorempty(path) or self._mainIcon == nil then
		return
	end

	self:_removeMainIcon()
	uGuiUtil.setSpriteToImage(self._mainIcon, uGuiUtil.SpriteType.BigBg, path)
end

function FatherDungeonView:_removeMainIcon()
	if self._mainIcon == nil then
		return
	end

	Framework.ImageBigBG.Get(self._mainIcon):ClearImage()
end

function FatherDungeonView:_startMainIconAnim()
	if self._mainIcon == nil then
		return
	end

	local tp = UnityTweens.TweenPosition.StartTween(self._mainIcon, Vector3.New(79, -15, 0), Vector3.New(79, 30, 0), 1.9, UnityTweens.EaseType.easeInOutQuad, 0, UnityTweens.CoordSpace.Anchor)

	tp.loopType = UnityTweens.LoopType.pingPong
end

function FatherDungeonView:_loadMainIconEffect()
	local path = self:_getMainIconEffectPath()

	if string.nilorempty(path) or self._mainIconEffectParent == nil then
		return
	end

	self._mainIconEffectParent:SetActive(false)
	self:_removeMainIconEffect()

	local eff = UIEffectManager.instance:playEffect(self, path, self._mainIconEffectParent.transform, 0, 0, true, false)

	eff:setParent(self._mainIconEffectParent.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainIconEffect = eff
end

function FatherDungeonView:_removeMainIconEffect()
	if self._mainIconEffect == nil then
		return
	end

	UIEffectManager.instance:stopEffect(self._mainIconEffect)

	self._mainIconEffect = nil
end

function FatherDungeonView:_selectEndChange(index)
	self:_loadBgEffect(index)
	self:_setBgPicture(index)
end

function FatherDungeonView:_loadBgEffect(index)
	self:_removeBgEffect()

	local path = self:_getBgEffectPath(index)

	if string.nilorempty(path) or self._bg == nil then
		return
	end

	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

	uiEffect:setParent(self._bg.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._bgUIEffect = uiEffect
end

function FatherDungeonView:_removeBgEffect()
	if self._bgUIEffect == nil then
		return
	end

	UIEffectManager.instance:stopEffect(self._bgUIEffect)

	self._bgUIEffect = nil
end

function FatherDungeonView:_setBgPicture(index)
	if index == nil then
		index = 1
	end

	bgPath = self:_getBgPicturePath(index)

	if string.nilorempty(bgPath) or self._bg == nil then
		return
	end

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, bgPath)
end

function FatherDungeonView:_clearBg()
	if self._bg == nil then
		return
	end

	uGuiUtil.clearImage(self._bg)
end

function FatherDungeonView:_loadChapterSelectEffect()
	self:_removeChapterSelectEffect()

	local path = self:_getChapterSelectEffectPath()

	if string.nilorempty(path) then
		return
	end

	self._chapterUIEffects = {}

	for i = 1, self:_getChapterMaxNum() do
		local uiEffect = UIEffectManager.instance:playEffect(self, path, self._chapters[i].selectGo.transform, 0, 0, true, false)

		uiEffect:setParent(self._chapters[i].selectGo.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(0, 0, 0)

		self._chapterUIEffects[i] = uiEffect
	end
end

function FatherDungeonView:_removeChapterSelectEffect()
	if self._chapterUIEffects == nil then
		return
	end

	for _, eff in pairs(self._chapterUIEffects) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._chapterUIEffects = nil
end

function FatherDungeonView:_loadLevelEffect(go, isPurePlot)
	self:_removeLevelEffect()

	local effPath = self:_getLevelSelectEffectPath(isPurePlot)

	if string.nilorempty(effPath) or go == nil then
		return
	end

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
		eff:setLocalPos(0, 0, 0)
		eff:setScale(scale)
	end

	self._levelUIEffect = UIEffectManager.instance:playEffect(self, effPath, go.transform, 0, 0, true, false, nil, func)
end

function FatherDungeonView:_removeLevelEffect()
	if self._levelUIEffect ~= nil then
		UIEffectManager.instance:stopEffect(self._levelUIEffect)

		self._levelUIEffect = nil
	end
end

function FatherDungeonView:_onClickClose()
	self:close()
end

function FatherDungeonView:_onClickChapter(index)
	self:_setSelectChapter(index)
end

function FatherDungeonView:_onClickLevel(index)
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

		local npcCfg = ScenariocopyConfig.instance:getNpcCfg(plotChapterCfg.chapterId)

		if npcCfg ~= nil and GameUtil.isTable(npcCfg) and checknumber(npcCfg.npcId) > 0 then
			ScenariocopyController.instance:setViewName(self._viewPresentor.viewName, self:_getStageViewName(), self:getRollbackView())
			ScenariocopyController.instance:startNpcStory()

			return
		end

		if curStageCfg.pureAnimId > 0 then
			ScenariocopyController.instance:enterMissionOrStory(curStageCfg)
		else
			UIStateManager.instance:open(self:_getStageViewName(), curStageCfg, self._viewPresentor.viewName, self._curSelectChapterIndex, self:getRollbackView())
		end
	else
		local name1 = ScenariocopyController.instance:getStageName(self._curSelectChapterTypeId, chapterId, stageId, true)
		local name2 = ScenariocopyController.instance:getStageName(self._curSelectChapterTypeId, plotChapterCfg.chapterId, 1, false)

		FloatWordMgr.instance:show(langPara("通关[%s]后开启", name1))
	end
end

function FatherDungeonView:_getChapterMaxNum()
	return 3
end

function FatherDungeonView:_getStageMaxNum()
	return 6
end

function FatherDungeonView:_getIndexRange()
	return 1, 3
end

function FatherDungeonView:_getStageViewName()
	return ViewName.FatherStageView
end

function FatherDungeonView:_getBgEffectPath(index)
	return (string.format("%s.prefab", self._plotStoryCfgs[index].effectName))
end

function FatherDungeonView:_getBgPicturePath(index)
	return (string.format("ui/bigbg/views/huodong/juqingfuben/%s.png", self._plotStoryCfgs[index].bigBg))
end

function FatherDungeonView:_getChapterSelectEffectPath()
	return ""
end

function FatherDungeonView:_getLevelSelectEffectPath(isPurePlot)
	if isPurePlot == true then
		return ""
	elseif isPurePlot == false then
		return ""
	else
		return nil
	end
end

function FatherDungeonView:_getMainIconPath(index)
	return (string.format("ui/bigbg/%s.png", self._plotStoryCfgs[index].mainIconPath))
end

function FatherDungeonView:_getMainIconEffectPath()
	return ""
end

function FatherDungeonView:getRollbackView()
	return self._viewPresentor.viewName
end

function FatherDungeonView:setTextIngoreNil(textGo, msg)
	if textGo == nil or goutil.isNil(textGo) then
		return
	end

	textGo.text = msg
end

function FatherDungeonView:setActiveIngoreNil(go, value)
	goutil.setActive(go, value)
end

function FatherDungeonView:needChaptersSwitch()
	return self:_getChapterMaxNum() > 1
end

return FatherDungeonView
