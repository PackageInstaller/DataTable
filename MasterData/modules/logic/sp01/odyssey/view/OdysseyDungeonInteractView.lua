-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonInteractView.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonInteractView", package.seeall)

local OdysseyDungeonInteractView = class("OdysseyDungeonInteractView", BaseView)

function OdysseyDungeonInteractView:onInitView()
	self._btnfullscreen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._gooptionItem = gohelper.findChild(self.viewGO, "#go_optionItem")
	self._godialogOptionItem = gohelper.findChild(self.viewGO, "#go_dialogOptionItem")
	self._godialogPanel = gohelper.findChild(self.viewGO, "#go_dialogPanel")
	self._goheroIcon = gohelper.findChild(self.viewGO, "#go_dialogPanel/dialog/role/#go_heroIcon")
	self._imagedialogHero = gohelper.findChildSingleImage(self.viewGO, "#go_dialogPanel/dialog/role/#go_heroIcon/#image_dialogHero")
	self._goname = gohelper.findChild(self.viewGO, "#go_dialogPanel/dialog/role/#go_name")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_dialogPanel/dialog/role/#go_name/#txt_name")
	self._godialogOptionList = gohelper.findChild(self.viewGO, "#go_dialogPanel/#go_dialogOptionList")
	self._gooptionPanel = gohelper.findChild(self.viewGO, "#go_optionPanel")
	self._txtoptionTitle = gohelper.findChildText(self.viewGO, "#go_optionPanel/panel/title/#txt_optionTitle")
	self._txtoptionTitleEn = gohelper.findChildText(self.viewGO, "#go_optionPanel/panel/title/#txt_optionTitleEn")
	self._txtoptionDesc = gohelper.findChildText(self.viewGO, "#go_optionPanel/panel/#scroll_desc/Viewport/Content/#txt_optionDesc")
	self._gooption = gohelper.findChild(self.viewGO, "#go_optionPanel/panel/#go_option")
	self._imagepicture = gohelper.findChildSingleImage(self.viewGO, "#go_optionPanel/panel/#image_picture")
	self._gofightPanel = gohelper.findChild(self.viewGO, "#go_fightPanel")
	self._goheroLevel = gohelper.findChild(self.viewGO, "#go_heroLevel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyDungeonInteractView:addEvents()
	self._btnfullscreen:AddClickListener(self._btnfullscreenOnClick, self)
end

function OdysseyDungeonInteractView:removeEvents()
	self._btnfullscreen:RemoveClickListener()
end

function OdysseyDungeonInteractView:_btnfullscreenOnClick()
	if self.roleTmpFadeInComp and self.roleTmpFadeInComp:isPlaying() then
		self.roleTmpFadeInComp:conFinished()

		return
	end

	if self.narrationTmpFadeInComp and self.narrationTmpFadeInComp:isPlaying() then
		self.narrationTmpFadeInComp:conFinished()

		return
	end

	if self.elementType == OdysseyEnum.ElementType.Dialog then
		if not self.hasOption then
			self.curDialogStep = self.dialogConfig.nextStep

			if self.curDialogStep > 0 then
				self:doDialogStep()
			else
				self:onOptionStepFinish()
				self:closeThis()
			end
		end
	else
		self:closeThis()
	end
end

function OdysseyDungeonInteractView:optionItemClick(optionItem)
	if not optionItem.isUnlock then
		local canUnlock, unlockParam = OdysseyDungeonModel.instance:checkConditionCanUnlock(optionItem.optionConfig.unlockCondition)

		if unlockParam.type == OdysseyEnum.ConditionType.Item then
			local itemConfig = OdysseyConfig.instance:getItemConfig(unlockParam.itemId)

			GameFacade.showToast(ToastEnum.OdysseyLackItem, itemConfig.name)
		elseif unlockParam.type == OdysseyEnum.ConditionType.Level then
			GameFacade.showToast(ToastEnum.OdysseyLackLevel)
		end

		return
	end

	self.curClickOptionItem = optionItem
	self.isNotFinish = optionItem.optionConfig.notFinish == OdysseyEnum.ElementOptionNotFinish

	local optionStoryId = optionItem.optionConfig.story

	if self.elementType == OdysseyEnum.ElementType.Dialog then
		self.curDialogStep = optionItem.optionData[2]

		self:doDialogStep()
	elseif optionStoryId > 0 then
		StoryController.instance:playStory(optionStoryId)

		local storyOptionParam = {}

		storyOptionParam.elementId = self.elementConfig.id
		storyOptionParam.optionId = optionItem.optionConfig.id

		OdysseyDungeonModel.instance:setStoryOptionParam(storyOptionParam)
		self:closeThis()
	else
		self:onOptionStepFinish()
		self:closeThis()
	end
end

function OdysseyDungeonInteractView:_editableInitView()
	self.panelGOMap = self:getUserDataTb_()

	for type, root in ipairs(OdysseyEnum.ElementTypeRoot) do
		self.panelGOMap[type] = self["_go" .. root .. "Panel"]
	end

	self.optionItemList = self:getUserDataTb_()

	gohelper.setActive(self._gooptionItem, false)
	gohelper.setActive(self._godialogOptionItem, false)
	gohelper.setActive(self._goheroLevel, false)

	self.godialogNarration = gohelper.findChild(self.viewGO, "#go_dialogPanel/dialog/narration")
	self.godialogRole = gohelper.findChild(self.viewGO, "#go_dialogPanel/dialog/role")

	gohelper.setActive(self.godialogNarration, false)
	gohelper.setActive(self.godialogRole, false)
end

function OdysseyDungeonInteractView:onUpdateParam()
	return
end

function OdysseyDungeonInteractView:onOpen()
	self.elementConfig = self.viewParam.config
	self.elementType = self.elementConfig.type
	self.levelGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[2], self._goheroLevel)
	self.levelComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.levelGO, OdysseyDungeonLevelComp)

	self:refreshUI()
	self:setDungeonUIShowState(false)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, self.elementConfig.id, OdysseyEnum.ElementAnimName.Select)
end

function OdysseyDungeonInteractView:setDungeonUIShowState(showState)
	if self.elementType == OdysseyEnum.ElementType.Dialog then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.SetDungeonUIShowState, OdysseyEnum.DungeonUISideType.Bottom, showState)
	else
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.SetDungeonUIShowState, OdysseyEnum.DungeonUISideType.Right, showState)
	end
end

function OdysseyDungeonInteractView:refreshUI()
	for type, root in ipairs(OdysseyEnum.ElementTypeRoot) do
		gohelper.setActive(self.panelGOMap[type], type == self.elementType)
	end

	if self.elementType == OdysseyEnum.ElementType.Dialog then
		self.curDialogStep = 1
		self.dialogOptionMap = self:getUserDataTb_()

		TaskDispatcher.runDelay(self.doDialogStep, self, 0.4)
	elseif self.elementType == OdysseyEnum.ElementType.Option then
		self:refreshOptionPanel()
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_unfold)
	elseif self.elementType == OdysseyEnum.ElementType.Fight then
		self.fightPanelView = self.viewContainer:getInteractFightView()

		self.fightPanelView:refreshFightPanel()
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_unfold)
	end

	gohelper.setActive(self._btnfullscreen.gameObject, self.elementType == OdysseyEnum.ElementType.Dialog)
	self:refreshLevel()
end

function OdysseyDungeonInteractView:doDialogStep()
	self.dialogConfig = OdysseyConfig.instance:getDialogConfig(self.elementConfig.id, self.curDialogStep)

	if not self.dialogConfig then
		self:onOptionStepFinish()
		self:closeThis()

		return
	end

	local canShowHeroIcon = not string.nilorempty(self.dialogConfig.picture)

	gohelper.setActive(self._goheroIcon, canShowHeroIcon)

	if canShowHeroIcon then
		self._imagedialogHero:LoadImage(ResUrl.getSp01OdysseySingleBg("map/" .. self.dialogConfig.picture))
	end

	local canShowDialogName = not string.nilorempty(self.dialogConfig.name)

	gohelper.setActive(self._goname, canShowDialogName)
	gohelper.setActive(self.godialogRole, canShowDialogName)
	gohelper.setActive(self.godialogNarration, not canShowDialogName)

	self._txtname.text = self.dialogConfig.name

	local descContent = string.gsub(self.dialogConfig.desc, " ", " ")

	self.roleTmpFadeInComp = self.roleTmpFadeInComp or MonoHelper.addLuaComOnceToGo(self.godialogRole, TMPFadeIn)
	self.narrationTmpFadeInComp = self.narrationTmpFadeInComp or MonoHelper.addLuaComOnceToGo(self.godialogNarration, TMPFadeIn)
	self.hasOption = not string.nilorempty(self.dialogConfig.optionList)

	if self.hasOption then
		if canShowDialogName then
			self.roleTmpFadeInComp:playNormalText(descContent, self.showDialogOptionList, self)
		else
			self.narrationTmpFadeInComp:playNormalText(descContent, self.showDialogOptionList, self)
		end

		gohelper.setActive(self._godialogOptionList, false)

		local optionList = GameUtil.splitString2(self.dialogConfig.optionList, true)

		self:createAndRefreshOptionItem(optionList, self._godialogOptionList, self._godialogOptionItem)
	else
		if canShowDialogName then
			self.roleTmpFadeInComp:playNormalText(descContent)
		else
			self.narrationTmpFadeInComp:playNormalText(descContent)
		end

		gohelper.setActive(self._godialogOptionList, false)
	end
end

function OdysseyDungeonInteractView:showDialogOptionList()
	gohelper.setActive(self._godialogOptionList, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_choice)
end

function OdysseyDungeonInteractView:createAndRefreshOptionItem(optionList, parentGO, optionItemGO)
	local isDialogType = self.elementType == OdysseyEnum.ElementType.Dialog

	for index, optionData in ipairs(optionList) do
		local optionItem = self.optionItemList[index]

		if not optionItem then
			optionItem = self:getUserDataTb_()
			optionItem.go = gohelper.clone(optionItemGO, parentGO, "optionItem_" .. index)
			optionItem.normalbg = gohelper.findChild(optionItem.go, "go_normalbg")
			optionItem.lockbg = gohelper.findChild(optionItem.go, "go_lockbg")
			optionItem.txtdesc = gohelper.findChildText(optionItem.go, "content/txt_desc")
			optionItem.txtsubDesc = gohelper.findChildText(optionItem.go, "content/txt_subdesc")
			optionItem.btnClick = gohelper.findChildButtonWithAudio(optionItem.go, "btn_click")

			optionItem.btnClick:AddClickListener(self.optionItemClick, self, optionItem)

			self.optionItemList[index] = optionItem
		end

		gohelper.setActive(optionItem.go, true)

		local isUnlock, subDesc = self:getOptionUnlockAndSubDesc(optionData)

		gohelper.setActive(optionItem.lockbg, not isUnlock)
		gohelper.setActive(optionItem.normalbg, isUnlock)

		optionItem.isUnlock = isUnlock
		optionItem.optionData = optionData
		optionItem.optionConfig = OdysseyConfig.instance:getOptionConfig(optionData[1])
		optionItem.txtdesc.text = optionItem.optionConfig.desc

		local showSubDesc = not string.nilorempty(subDesc)

		gohelper.setActive(optionItem.txtsubDesc.gameObject, showSubDesc)

		optionItem.txtsubDesc.text = subDesc or ""

		if isDialogType then
			SLFramework.UGUI.GuiHelper.SetColor(optionItem.txtdesc, isUnlock and "#C5D9E6" or "#7F8D97")
		else
			SLFramework.UGUI.GuiHelper.SetColor(optionItem.txtdesc, isUnlock and "#1D313E" or "#7B868D")
		end

		SLFramework.UGUI.GuiHelper.SetColor(optionItem.txtsubDesc, isUnlock and "#21723B" or "#A54A4A")
	end

	for i = #optionList + 1, #self.optionItemList do
		gohelper.setActive(self.optionItemList[i].go, false)
	end
end

function OdysseyDungeonInteractView:getOptionUnlockAndSubDesc(optionData)
	local optionId = optionData[1]

	if not optionId then
		return true
	end

	local subDesc = ""
	local optionConfig = OdysseyConfig.instance:getOptionConfig(optionId)
	local canUnlock, unlockParam = OdysseyDungeonModel.instance:checkConditionCanUnlock(optionConfig.unlockCondition)

	if not unlockParam then
		return canUnlock, subDesc
	end

	if unlockParam.type == OdysseyEnum.ConditionType.Item then
		local itemConfig = OdysseyConfig.instance:getItemConfig(unlockParam.itemId)

		subDesc = self:replaceSubDescData(optionConfig.subDesc, {
			itemConfig.name,
			unlockParam.curItemCount,
			unlockParam.unlockItemCount
		})
	elseif unlockParam.type == OdysseyEnum.ConditionType.Level then
		subDesc = self:replaceSubDescData(optionConfig.subDesc, {
			unlockParam.unlockLevel
		})
	end

	return canUnlock, subDesc
end

function OdysseyDungeonInteractView:replaceSubDescData(desc, params)
	local curDesc = desc

	for index = 1, #params do
		curDesc = string.gsub(curDesc, "▩" .. index .. "%%s", params[index])
	end

	return curDesc
end

function OdysseyDungeonInteractView:onOptionStepFinish()
	local optionParam = {}

	if self.curClickOptionItem then
		optionParam.optionId = self.curClickOptionItem.optionConfig.id or nil
	end

	if not self.isNotFinish then
		OdysseyRpc.instance:sendOdysseyMapInteractRequest(self.elementConfig.id, optionParam)
	end
end

function OdysseyDungeonInteractView:refreshOptionPanel()
	local optionConfig = OdysseyConfig.instance:getElemenetOptionConfig(self.elementConfig.id)

	self._txtoptionTitle.text = optionConfig.title
	self._txtoptionDesc.text = optionConfig.desc

	local optionDataList = {}
	local optionList = string.splitToNumber(optionConfig.optionList, "#")

	for index, optionId in ipairs(optionList) do
		table.insert(optionDataList, {
			optionId
		})
	end

	self._imagepicture:LoadImage(ResUrl.getSp01OdysseySingleBg(optionConfig.image))
	self:createAndRefreshOptionItem(optionDataList, self._gooption, self._gooptionItem)
end

function OdysseyDungeonInteractView:refreshLevel()
	if self.elementType == OdysseyEnum.ElementType.Dialog then
		gohelper.setActive(self._goheroLevel, false)

		return
	end

	gohelper.setActive(self._goheroLevel, true)
	self.levelComp:refreshUI()
	self.levelComp:checkLevelDiffAndRefresh()
end

function OdysseyDungeonInteractView:onClose()
	for _, optionItem in ipairs(self.optionItemList) do
		optionItem.btnClick:RemoveClickListener()
	end

	OdysseyDungeonModel.instance:setJumpNeedOpenElement(0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, self.elementConfig.id, OdysseyEnum.ElementAnimName.Idle)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowInteractCloseBtn, false)
	AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, true)

	if self.elementType == OdysseyEnum.ElementType.Option or self.elementType == OdysseyEnum.ElementType.Fight then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_fold)
	end

	TaskDispatcher.cancelTask(self.doDialogStep, self)
end

function OdysseyDungeonInteractView:onDestroyView()
	self._imagepicture:UnLoadImage()
	self._imagedialogHero:UnLoadImage()
	self:setDungeonUIShowState(true)
end

return OdysseyDungeonInteractView
