-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonInteractView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonInteractView", package.seeall)

local AtomicDungeonInteractView = class("AtomicDungeonInteractView", BaseView)

function AtomicDungeonInteractView:onInitView()
	self._btnfullscreen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._txttitle = gohelper.findChildText(self.viewGO, "panel/titlebg/#txt_title")
	self._goalarm = gohelper.findChild(self.viewGO, "panel/layoutgroup_top/#go_alarm")
	self._txtAlarmText = gohelper.findChildText(self.viewGO, "panel/layoutgroup_top/#go_alarm/#txt_alarmtext")
	self._goAlarmUpIcon = gohelper.findChild(self.viewGO, "panel/layoutgroup_top/#go_alarm/#txt_alarmtext/#go_alarmUpIcon")
	self._goAlarmDownIcon = gohelper.findChild(self.viewGO, "panel/layoutgroup_top/#go_alarm/#txt_alarmtext/#go_alarmDownIcon")
	self._imageAddAlarm = gohelper.findChildImage(self.viewGO, "panel/layoutgroup_top/#go_alarm/alarmBar/#image_addAlarm")
	self._imageReduceAlarm = gohelper.findChildImage(self.viewGO, "panel/layoutgroup_top/#go_alarm/alarmBar/#image_reduceAlarm")
	self._imageCurAlarm = gohelper.findChildImage(self.viewGO, "panel/layoutgroup_top/#go_alarm/alarmBar/#image_curAlarm")
	self._txtrecommend = gohelper.findChildText(self.viewGO, "panel/layoutgroup_top/#txt_recommend")
	self._goline = gohelper.findChild(self.viewGO, "panel/layoutgroup_top/#go_line")
	self._gokeyInfo = gohelper.findChild(self.viewGO, "panel/layoutgroup_top/#go_keyInfo")
	self._txtneedKeyInfo = gohelper.findChildText(self.viewGO, "panel/layoutgroup_top/#go_keyInfo/#txt_needKeyInfo")
	self._txtneedKeyDesc = gohelper.findChildText(self.viewGO, "panel/layoutgroup_top/#go_keyInfo/#txt_needKeyDesc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "panel/layoutgroup_top/scroll_desc/viewport/#txt_desc")
	self._goreward = gohelper.findChild(self.viewGO, "panel/layoutgroup_bottom/#go_reward")
	self._scrollrewardlist = gohelper.findChildScrollRect(self.viewGO, "panel/layoutgroup_bottom/#go_reward/#scroll_rewardlist")
	self._gorewardContent = gohelper.findChild(self.viewGO, "panel/layoutgroup_bottom/#go_reward/#scroll_rewardlist/viewport/#go_rewardContent")
	self._gorewardItem = gohelper.findChild(self.viewGO, "panel/layoutgroup_bottom/#go_reward/#scroll_rewardlist/viewport/#go_rewardContent/#go_rewardItem")
	self._gooptionContent = gohelper.findChild(self.viewGO, "panel/layoutgroup_bottom/#go_optionContent")
	self._gooptionItem = gohelper.findChild(self.viewGO, "panel/layoutgroup_bottom/#go_optionContent/#go_optionItem")
	self._gonextStep = gohelper.findChild(self.viewGO, "panel/layoutgroup_bottom/#go_nextStep")
	self._btnpanelClick = gohelper.findChildButtonWithAudio(self.viewGO, "panel/#btn_panelClick")
	self._gofight = gohelper.findChild(self.viewGO, "panel/layoutgroup_bottom/#go_fight")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "panel/layoutgroup_bottom/#go_fight/#btn_fight")
	self._gopuzzle = gohelper.findChild(self.viewGO, "panel/layoutgroup_bottom/#go_puzzle")
	self._btnpuzzle = gohelper.findChildButtonWithAudio(self.viewGO, "panel/layoutgroup_bottom/#go_puzzle/#btn_puzzle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonInteractView:addEvents()
	self._btnfullscreen:AddClickListener(self._btnfullscreenOnClick, self)
	self._btnpanelClick:AddClickListener(self._btnpanelOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
	self._btnpuzzle:AddClickListener(self._btnpuzzleOnClick, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnAlarmValueChange, self.refreshUI, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.GameFinish, self.onGameFinish, self)
end

function AtomicDungeonInteractView:removeEvents()
	self._btnfullscreen:RemoveClickListener()
	self._btnpanelClick:RemoveClickListener()
	self._btnfight:RemoveClickListener()
	self._btnpuzzle:RemoveClickListener()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnAlarmValueChange, self.refreshUI, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.GameFinish, self.onGameFinish, self)
end

function AtomicDungeonInteractView:_btnfightOnClick()
	AtomicController.instance:setPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.CurFightMapId, AtomicDungeonModel.instance:getCurMapId())

	local hardFightElementMo = AtomicDungeonModel.instance:getHardFightElementMo(self.mapId)

	if hardFightElementMo then
		if not hardFightElementMo.id then
			local curElementId = self.elementConfig.id
			local param = {
				episodeId = self.fightEpisodeCo.id,
				elementId = curElementId
			}

			AtomicDungeonModel.instance:setLastElementFightParam(param)
			DungeonFightController.instance:enterFight(self.fightEpisodeCo.chapterId, self.fightEpisodeCo.id)
		end
	end
end

function AtomicDungeonInteractView:_btnpuzzleOnClick()
	local puzzleParam = {}

	puzzleParam.elementId = self.elementConfig.id

	local puzzleData = string.splitToNumber(self.elementConfig.parm, "#")

	puzzleParam.type = puzzleData[1]
	puzzleParam.gameId = puzzleData[2]

	AtomicDungeonController.instance:openPuzzleGameView(puzzleParam)
end

function AtomicDungeonInteractView:_btnpanelOnClick()
	local optionConfig = AtomicDungeonConfig.instance:getOptionElementConfig(self.elementConfig.id, self.curOptionStep)

	if not optionConfig or not string.nilorempty(optionConfig.optionList) then
		return
	end

	self.curOptionStep = optionConfig.nextStepId

	self:refreshOptionPanel()
end

function AtomicDungeonInteractView:_btnfullscreenOnClick()
	self:closeThis()

	self.isClose = true
end

function AtomicDungeonInteractView:optionItemClick(optionItem)
	self.curClickOptionItem = optionItem
	self.isNotFinish = optionItem.optionConfig.notFinish == 1
	self.curOptionStep = optionItem.optionData[2]
	self.rewardOptionConfig = nil

	if optionItem.optionConfig.warning ~= 0 or not string.nilorempty(optionItem.optionConfig.reward) then
		self.rewardOptionConfig = optionItem.optionConfig
		self.rewardOptionId = self.rewardOptionConfig.id
	end

	table.insert(self.optionIdList, optionItem.optionConfig.id)
	table.insert(self.optionDescList, optionItem.optionConfig.desc)

	local optionStoryId = optionItem.optionConfig.story
	local nextOptionConfig = AtomicDungeonConfig.instance:getOptionElementConfig(self.elementConfig.id, self.curOptionStep)

	if optionStoryId > 0 then
		StoryController.instance:playStory(optionStoryId)

		local storyOptionParam = {}

		storyOptionParam.elementId = self.elementConfig.id
		storyOptionParam.optionId = optionItem.optionConfig.id

		AtomicDungeonModel.instance:setStoryOptionParam(storyOptionParam)

		if not nextOptionConfig then
			return
		end
	elseif not string.nilorempty(optionItem.optionConfig.puzzle) then
		local puzzleData = string.splitToNumber(optionItem.optionConfig.puzzle, "#")
		local puzzleParam = {}

		puzzleParam.elementId = self.elementConfig.id
		puzzleParam.type = puzzleData[1]
		puzzleParam.gameId = puzzleData[2]
		puzzleParam.nextOptionConfig = nextOptionConfig
		puzzleParam.optionId = optionItem.optionConfig.id

		AtomicDungeonController.instance:openPuzzleGameView(puzzleParam)

		return
	end

	self:refreshOptionPanel()
end

function AtomicDungeonInteractView:_editableInitView()
	self.optionItemList = self:getUserDataTb_()
	self.rewardItemTab = self:getUserDataTb_()
	self.optionIdList = self:getUserDataTb_()
	self.optionDescList = self:getUserDataTb_()

	gohelper.setActive(self._gooptionItem, false)
	gohelper.setActive(self._gorewardItem, false)

	self._scrollDescLayoutElement = gohelper.findChild(self.viewGO, "panel/layoutgroup_top/scroll_desc"):GetComponent(typeof(UnityEngine.UI.LayoutElement))
end

function AtomicDungeonInteractView:onUpdateParam()
	return
end

function AtomicDungeonInteractView:onOpen()
	self.isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()
	self.elementComp = self.viewParam
	self.elementConfig = self.viewParam.config
	self.mapId = self.elementConfig.mapId
	self.elementType = self.elementConfig.type
	self.isClose = false
	self.alarmLevelUpValue = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AlarmLevelUpValue, true)
	self.maxAlarmLevel = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.MaxAlarmLevel, true)
	self.maxTalentCoinNum = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AtomicTalentMaxCoinNum, true)

	if self.isInPolygonState then
		self.elementComp:setSelectState(true)
	end

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_task_page)
end

function AtomicDungeonInteractView:refreshUI()
	if self.isClose then
		return
	end

	gohelper.setActive(self._goalarm, self.elementType == AtomicDungeonEnum.ElementType.Fight)
	gohelper.setActive(self._txtrecommend.gameObject, self.elementType == AtomicDungeonEnum.ElementType.Fight)
	gohelper.setActive(self._goreward, self.elementType ~= AtomicDungeonEnum.ElementType.Option and not string.nilorempty(self.elementConfig.reward))
	gohelper.setActive(self._gofight, self.elementType == AtomicDungeonEnum.ElementType.Fight)
	gohelper.setActive(self._gonextStep, self.elementType == AtomicDungeonEnum.ElementType.Option)
	gohelper.setActive(self._gopuzzle, self.elementType == AtomicDungeonEnum.ElementType.Puzzle)
	gohelper.setActive(self._gokeyInfo, self.elementType == AtomicDungeonEnum.ElementType.KeyDoor)

	if self.elementType == AtomicDungeonEnum.ElementType.Option then
		self.curOptionStep = 1
		self.rewardOptionConfig = nil
		self.rewardOptionId = nil

		self:refreshOptionPanel()
	elseif self.elementType == AtomicDungeonEnum.ElementType.Fight then
		self:refreshFightPanel()
	elseif self.elementType == AtomicDungeonEnum.ElementType.Puzzle then
		self:refreshPuzzlePanel()
	elseif self.elementType == AtomicDungeonEnum.ElementType.KeyDoor then
		self:refreshKeyDoorPanel()
	end

	self:refreshAlarmBar()
end

function AtomicDungeonInteractView:refreshOptionPanel()
	local optionConfig = AtomicDungeonConfig.instance:getOptionElementConfig(self.elementConfig.id, self.curOptionStep)

	if not optionConfig or self.curOptionStep == 0 then
		self:onOptionStepFinish()
		self:closeThis()

		self.isClose = true

		return
	end

	self._txttitle.text = GameUtil.setFirstStrSize(optionConfig.title, 68)
	self._txtdesc.text = optionConfig.desc

	gohelper.setActive(self._gonextStep, optionConfig.nextStepId > 0 and string.nilorempty(optionConfig.optionList))
	gohelper.setActive(self._gooptionContent, not string.nilorempty(optionConfig.optionList))

	if not string.nilorempty(optionConfig.optionList) then
		local optionList = GameUtil.splitString2(optionConfig.optionList, true)

		self:createAndRefreshOptionItem(optionList, self._gooptionContent, self._gooptionItem)
	end

	if self.rewardOptionConfig then
		if not string.nilorempty(self.rewardOptionConfig.reward) then
			gohelper.setActive(self._goreward, true)
			self:createAndRefreshReward(self.rewardOptionConfig.reward)
		end

		if self.rewardOptionConfig and self.rewardOptionConfig.warning ~= 0 then
			gohelper.setActive(self._goalarm, true)
			self:refreshAlarmBar()
		else
			gohelper.setActive(self._goalarm, false)
		end
	else
		gohelper.setActive(self._goreward, false)
		gohelper.setActive(self._goalarm, false)
	end

	self:refreshDescScrollHeight()
end

function AtomicDungeonInteractView:createAndRefreshOptionItem(optionList, parentGO, optionItemGO)
	for index, optionData in ipairs(optionList) do
		local optionItem = self.optionItemList[index]

		if not optionItem then
			optionItem = self:getUserDataTb_()
			optionItem.go = gohelper.clone(optionItemGO, parentGO, "optionItem_" .. index)
			optionItem.txtdesc = gohelper.findChildText(optionItem.go, "txt_optionDesc")
			optionItem.goRewardUp = gohelper.findChild(optionItem.go, "go_rewardUp")
			optionItem.goRewardDown = gohelper.findChild(optionItem.go, "go_rewardDown")
			optionItem.btnClick = gohelper.findChildButtonWithAudio(optionItem.go, "btn_click")

			optionItem.btnClick:AddClickListener(self.optionItemClick, self, optionItem)

			self.optionItemList[index] = optionItem
		end

		gohelper.setActive(optionItem.go, true)

		optionItem.optionData = optionData
		optionItem.optionConfig = AtomicDungeonConfig.instance:getOptionConfig(optionData[1])
		optionItem.txtdesc.text = optionItem.optionConfig.desc

		gohelper.setActive(optionItem.goRewardUp, not string.nilorempty(optionItem.optionConfig.reward) or optionItem.optionConfig.warning > 0)
		gohelper.setActive(optionItem.goRewardDown, optionItem.optionConfig.warning < 0)
	end

	for i = #optionList + 1, #self.optionItemList do
		gohelper.setActive(self.optionItemList[i].go, false)
	end
end

function AtomicDungeonInteractView:onOptionStepFinish()
	local optionParam = {}

	if self.curClickOptionItem then
		optionParam.optionId = self.curClickOptionItem.optionConfig.id or nil
	end

	if self.rewardOptionId then
		optionParam.optionId = self.rewardOptionId
	end

	if not self.isNotFinish then
		AtomicRpc.instance:sendAtomicMapInteractRequest(self.elementConfig.id, optionParam)

		local statData = AtomicDungeonModel.instance:getElementStatData(self.elementConfig.id)

		AtomicDungeonStatHelper.instance:sendOptionInteractInfo(statData, self.optionIdList, self.optionDescList)
	end
end

function AtomicDungeonInteractView:refreshFightPanel()
	local hardFightElementMo = AtomicDungeonModel.instance:getHardFightElementMo(self.mapId)

	if hardFightElementMo then
		if not hardFightElementMo.id then
			local elementId = self.elementConfig.id

			self.fightElementConfig = AtomicDungeonConfig.instance:getFightElementConfig(elementId)

			local curElementConfig = AtomicDungeonConfig.instance:getElementConfig(elementId)

			self._txttitle.text = GameUtil.setFirstStrSize(self.fightElementConfig.title, 68)
			self._txtdesc.text = self.fightElementConfig.desc

			if hardFightElementMo and hardFightElementMo.fightEpisodeId > 0 then
				if not hardFightElementMo.fightEpisodeId then
					local episodeId = self.fightElementConfig.episodeId

					self.fightEpisodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

					local recommendLevel = FightHelper.getBattleRecommendLevel(self.fightEpisodeCo.battleId)
					local recommendStr = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""

					self._txtrecommend.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("s02_atomic_recommend"), recommendStr)

					if not string.nilorempty(curElementConfig.reward) then
						self:createAndRefreshReward(curElementConfig.reward)
					end

					self:refreshDescScrollHeight()
				end
			end
		end
	end
end

function AtomicDungeonInteractView:createAndRefreshReward(rewardInfo)
	local isFinish = AtomicDungeonModel.instance:isElementFinish(self.elementConfig.id)
	local rewardList = GameUtil.splitString2(rewardInfo)
	local costTalentNum = AtomicModel.instance:getAllUnlockTalentCost()

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(self._gorewardItem, self._gorewardContent, "rewardItem_" .. index)
			}
			rewardItem.itemPos = gohelper.findChild(rewardItem.go, "pos")
			rewardItem.goGet = gohelper.findChild(rewardItem.go, "go_get")
			rewardItem.item = IconMgr.instance:getCommonPropItemIcon(rewardItem.itemPos)
			self.rewardItemTab[index] = rewardItem
		end

		rewardItem.item:setMOValue(rewardData[1], rewardData[2], rewardData[3])
		rewardItem.item:setHideLvAndBreakFlag(true)
		rewardItem.item:hideEquipLvAndBreak(true)
		rewardItem.item:setCountFontSize(51)

		local curTalentNum = ItemModel.instance:getItemQuantity(rewardData[1], rewardData[2])

		if curTalentNum + costTalentNum >= self.maxTalentCoinNum then
			rewardItem.item:setCountText(luaLang("sp02_atomic_talent_coinMax"))
		end

		gohelper.setActive(rewardItem.goGet, isFinish)
		gohelper.setActive(rewardItem.go, true)
	end

	for index = #rewardList + 1, #self.rewardItemTab do
		local rewardItem = self.rewardItemTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.go, false)
		end
	end
end

function AtomicDungeonInteractView:refreshPuzzlePanel()
	local puzzleData = string.splitToNumber(self.elementConfig.parm, "#")
	local puzzleConfig

	if puzzleData[1] == AtomicDungeonEnum.PuzzleType.Line then
		puzzleConfig = AtomicDungeonConfig.instance:getLineGameConfig(puzzleData[2])
	elseif puzzleData[1] == AtomicDungeonEnum.PuzzleType.Color then
		puzzleConfig = AtomicDungeonConfig.instance:getColorGameConfig(puzzleData[2])
	elseif puzzleData[1] == AtomicDungeonEnum.PuzzleType.Rhythm then
		puzzleConfig = AtomicDungeonConfig.instance:getRhythmGameConfig(puzzleData[2])
	end

	if not puzzleConfig then
		logError("解密事件额外参数配置异常，请检查：" .. self.elementConfig.id)

		return
	end

	self._txttitle.text = GameUtil.setFirstStrSize(puzzleConfig.title, 68)
	self._txtdesc.text = puzzleConfig.desc

	if not string.nilorempty(self.elementConfig.reward) then
		self:createAndRefreshReward(self.elementConfig.reward)
	end

	self:refreshDescScrollHeight()
end

function AtomicDungeonInteractView:refreshKeyDoorPanel()
	local isKeyElement = AtomicDungeonConfig.instance:checkElementIsKey(self.elementConfig)

	if isKeyElement then
		local keyElementConfig = AtomicDungeonConfig.instance:getKeyElementConfig(self.elementConfig.id)

		self._txttitle.text = GameUtil.setFirstStrSize(keyElementConfig.title, 68)
		self._txtdesc.text = keyElementConfig.desc
	else
		local doorElementConfig = AtomicDungeonConfig.instance:getDoorElementConfig(self.elementConfig.id)

		self._txttitle.text = GameUtil.setFirstStrSize(doorElementConfig.title, 68)
		self._txtdesc.text = doorElementConfig.desc
	end

	local isFinish = AtomicDungeonModel.instance:isElementFinish(self.elementConfig.id)

	gohelper.setActive(self._gokeyInfo, not isKeyElement and not isFinish)

	local elementMo = AtomicDungeonModel.instance:getElementMo(self.elementConfig.id)

	if not isKeyElement and elementMo and not isFinish then
		local keyPutCount = 0
		local needKeyElementList = {}
		local keyPointDataList = {}
		local curKeyElementDataMap = elementMo:getCurKeyElementDataMap()

		for _, keyElementData in pairs(curKeyElementDataMap) do
			table.insert(keyPointDataList, keyElementData)
		end

		table.sort(keyPointDataList, function(a, b)
			if a.isPut ~= b.isPut then
				return a.isPut
			else
				return a.index < b.index
			end
		end)

		for _, keyElementData in ipairs(keyPointDataList) do
			if keyElementData.isPut then
				keyPutCount = keyPutCount + 1
			else
				table.insert(needKeyElementList, keyElementData)
			end
		end

		self._txtneedKeyInfo.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("sp02_atomic_interact_needkey"), keyPutCount, #keyPointDataList)

		local needKeyStrList = {}

		for _, keyElementData in ipairs(needKeyElementList) do
			local keyElementConfig = AtomicDungeonConfig.instance:getKeyElementConfig(keyElementData.id)

			table.insert(needKeyStrList, keyElementConfig.title)
		end

		local sep = luaLang("common_comma_cn")

		self._txtneedKeyDesc.text = #needKeyStrList > 0 and table.concat(needKeyStrList, sep) or ""
	end

	self:refreshDescScrollHeight()
end

function AtomicDungeonInteractView:refreshAlarmBar()
	local hardFightElementMo = AtomicDungeonModel.instance:getHardFightElementMo(self.mapId)

	if not self.elementConfig.warning then
		local changeAlarm = 0

		if self.elementType == AtomicDungeonEnum.ElementType.Fight and hardFightElementMo then
			changeAlarm = hardFightElementMo.config.warning or 0
		end

		if self.rewardOptionConfig then
			changeAlarm = changeAlarm + self.rewardOptionConfig.warning
		end

		gohelper.setActive(self._goalarm, changeAlarm ~= 0)
		gohelper.setActive(self._goAlarmUpIcon, changeAlarm > 0)
		gohelper.setActive(self._imageAddAlarm.gameObject, changeAlarm > 0)
		gohelper.setActive(self._goAlarmDownIcon, changeAlarm < 0)
		gohelper.setActive(self._imageReduceAlarm.gameObject, changeAlarm < 0)
		gohelper.setActive(self._imageCurAlarm.gameObject, true)

		local arenaInfoData = AtomicDungeonModel.instance:getCurArenaInfoData()
		local curAlarm = arenaInfoData.currentAlarm % self.alarmLevelUpValue
		local curLevel = AtomicDungeonModel.instance:getCurAlarmLevel()

		if arenaInfoData.currentAlarm > 0 and curAlarm == 0 then
			if not self.alarmLevelUpValue then
				local showAlarm = curAlarm

				if changeAlarm < 0 then
					recthelper.setWidth(self._imageReduceAlarm.transform, showAlarm / self.alarmLevelUpValue * AtomicDungeonEnum.AlarmBarWidth)
				else
					local addAlarm = Mathf.Min(curAlarm + changeAlarm, self.alarmLevelUpValue)

					recthelper.setWidth(self._imageAddAlarm.transform, addAlarm / self.alarmLevelUpValue * AtomicDungeonEnum.AlarmBarWidth)
				end

				local curTargetAlarm = changeAlarm < 0 and Mathf.Max(0, showAlarm + changeAlarm) or curAlarm
				local curAlarmRate = curLevel == self.maxAlarmLevel and changeAlarm >= 0 and 1 or curTargetAlarm / self.alarmLevelUpValue

				recthelper.setWidth(self._imageCurAlarm.transform, curAlarmRate * AtomicDungeonEnum.AlarmBarWidth)

				if curAlarm + changeAlarm >= self.alarmLevelUpValue and curLevel <= self.maxAlarmLevel - 1 then
					local changeLevel = Mathf.Floor((curAlarm + changeAlarm) / self.alarmLevelUpValue)

					self._txtAlarmText.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_atomic_bar_alarmLevelUp"), Mathf.Min(self.maxAlarmLevel, curLevel + changeLevel))
				elseif curAlarm + changeAlarm < 0 and curLevel > 0 then
					local changeLevel = Mathf.Floor((curAlarm + changeAlarm) / self.alarmLevelUpValue)

					self._txtAlarmText.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_atomic_bar_alarmLevelDown"), Mathf.Max(0, curLevel + changeLevel))
				else
					self._txtAlarmText.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_atomic_bar_alarmLevel"), curLevel)
				end
			end
		end
	end
end

function AtomicDungeonInteractView:refreshDescScrollHeight()
	local curDescHeight = 300

	if self.elementType == AtomicDungeonEnum.ElementType.Option then
		local optionConfig = AtomicDungeonConfig.instance:getOptionElementConfig(self.elementConfig.id, self.curOptionStep)
		local optionList = GameUtil.splitString2(optionConfig.optionList, true)

		curDescHeight = AtomicDungeonEnum.InteractDescMaxH - (#optionList - 1) * AtomicDungeonEnum.InteractOptionH

		if self.rewardOptionConfig and not string.nilorempty(self.rewardOptionConfig.reward) then
			curDescHeight = curDescHeight - AtomicDungeonEnum.InteractRewardH
		end
	elseif not string.nilorempty(self.elementConfig.reward) then
		curDescHeight = AtomicDungeonEnum.InteractDescMaxH - AtomicDungeonEnum.InteractRewardH
	end

	self._scrollDescLayoutElement.preferredHeight = curDescHeight
end

function AtomicDungeonInteractView:onGameFinish()
	if self.elementType == AtomicDungeonEnum.ElementType.Option then
		self:refreshOptionPanel()
	else
		self:closeThis()

		self.isClose = true
	end
end

function AtomicDungeonInteractView:onRemoveElement(elementId)
	if elementId == self.elementConfig.id then
		self:closeThis()

		self.isClose = true
	end
end

function AtomicDungeonInteractView:onClose()
	if not self.isInPolygonState then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnCloseInteractView, self.elementConfig.id)
	else
		self.elementComp:setSelectState(false)
	end
end

function AtomicDungeonInteractView:onDestroyView()
	for index, optionItem in ipairs(self.optionItemList) do
		optionItem.btnClick:RemoveClickListener()
	end
end

return AtomicDungeonInteractView
