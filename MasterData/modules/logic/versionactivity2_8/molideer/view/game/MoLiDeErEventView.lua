-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErEventView.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEventView", package.seeall)

local MoLiDeErEventView = class("MoLiDeErEventView", BaseView)

function MoLiDeErEventView:onInitView()
	self._btnCloseBg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_CloseBg")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._simagePic = gohelper.findChildSingleImage(self.viewGO, "#simage_Pic")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_Desc")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#scroll_Desc/Viewport/Content/#txt_Desc")
	self._goBtn = gohelper.findChild(self.viewGO, "Btns/#go_Btn")
	self._goBG1 = gohelper.findChild(self.viewGO, "Btns/#go_Btn/#go_BG1")
	self._goBG2 = gohelper.findChild(self.viewGO, "Btns/#go_Btn/#go_BG2")
	self._txtName = gohelper.findChildText(self.viewGO, "Btns/#go_Btn/#txt_Name")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Btns/#go_Btn/#txt_Descr")
	self._txtNum = gohelper.findChildText(self.viewGO, "Btns/#go_Btn/image_Icon/#txt_Num")
	self._gooptions = gohelper.findChild(self.viewGO, "Btns/#go_options")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Skip")
	self._goDispatchParent = gohelper.findChild(self.viewGO, "#go_DispatchParent")
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErEventView:addEvents()
	self._btnCloseBg:AddClickListener(self._btnCloseBgOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnSkip:AddClickListener(self._btnSkipOnClick, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, self.onOptionSelect, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, self.onTeamSelect, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameDispatchTeam, self.onDispatchTeam, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameWithdrawTeam, self.onWithdrawTeam, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameUseItem, self.onItemUse, self)
end

function MoLiDeErEventView:removeEvents()
	self._btnCloseBg:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, self.onOptionSelect, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, self.onTeamSelect, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameDispatchTeam, self.onDispatchTeam, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameWithdrawTeam, self.onWithdrawTeam, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameUseItem, self.onItemUse, self)
end

function MoLiDeErEventView:_btnCloseBgOnClick()
	self:closeThis()
end

function MoLiDeErEventView:_btnCloseOnClick()
	self:closeThis()
end

function MoLiDeErEventView:_btnSkipOnClick()
	self:onDescShowEnd()
end

function MoLiDeErEventView:_editableInitView()
	local prefabPath = self.viewContainer._viewSetting.otherRes[1]
	local prefab = self:getResInst(prefabPath, self._goDispatchParent)

	self._goDispatch = prefab
	self._dispatchItem = MonoHelper.addNoUpdateLuaComOnceToGo(prefab, MoLiDeErDispatchItem)
	self._optionItemList = {}
	self._optionParentPointList = {}

	local childCount = self._gooptions.transform.childCount

	for i = 1, childCount do
		local childGo = self._gooptions.transform:GetChild(i - 1).gameObject

		table.insert(self._optionParentPointList, childGo)
	end

	gohelper.setActive(self._goBtn, false)
	gohelper.setActive(self._goDispatch, false)
end

function MoLiDeErEventView:onUpdateParam()
	return
end

function MoLiDeErEventView:onOpen()
	local eventId = self.viewParam.eventId
	local state = self.viewParam.state

	self._eventId = eventId
	self._state = state
	self._optionId = self.viewParam.optionId
	self._eventConfig = MoLiDeErConfig.instance:getEventConfig(eventId)

	local gameInfo = MoLiDeErGameModel.instance:getCurGameInfo()

	self._eventInfo = gameInfo:getEventInfo(eventId)

	if state == MoLiDeErEnum.DispatchState.Finish then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_molu_jlbn_open)
	end

	self:refreshInfo()
end

function MoLiDeErEventView:refreshUI()
	self:playAnim()
	self:refreshState()
	self:refreshOptions()
	self:refreshDispatch()
end

function MoLiDeErEventView:onItemUse()
	self:refreshOptions()

	local optionId = MoLiDeErGameModel.instance:getSelectOptionId()
	local itemList = self._optionItemList

	for _, item in ipairs(itemList) do
		if item.optionId and item.optionId == optionId and item._canSelect == false then
			MoLiDeErGameModel.instance:setSelectOptionId(nil)

			return
		end
	end
end

function MoLiDeErEventView:playAnim()
	if self._state == MoLiDeErEnum.DispatchState.Finish then
		if not MoLiDeErEnum.AnimName.EventViewFinishOpen then
			local animName = MoLiDeErEnum.AnimName.EventViewSwitchOpen

			if self._animator then
				self._animator:Play(animName, 0, 0)
			else
				logError("莫莉德尔角色活动 关卡页面动画组件不存在 动画名：" .. animName)
			end
		end
	end
end

function MoLiDeErEventView:refreshState()
	local state = self._state

	gohelper.setActive(self._gooptions, state ~= MoLiDeErEnum.DispatchState.Finish)
	gohelper.setActive(self._goDispatch, state ~= MoLiDeErEnum.DispatchState.Finish)
end

function MoLiDeErEventView:refreshOptions()
	local state = self._state

	if state ~= MoLiDeErEnum.DispatchState.Dispatch then
		gohelper.setActive(self._gooptions, false)

		return
	end

	local eventInfo = self._eventInfo
	local optionInfoList = eventInfo.options

	gohelper.setActive(self._gooptions, optionInfoList ~= nil)

	if optionInfoList == nil then
		return
	end

	local optionCount = #optionInfoList

	gohelper.setActive(self._gooptions, optionCount > 0)

	if optionCount <= 0 then
		return
	end

	local itemList = self._optionItemList
	local itemCount = #itemList
	local parentList = self._optionParentPointList
	local parentListCount = #self._optionParentPointList

	for index, optionInfo in ipairs(optionInfoList) do
		local item

		if itemCount < index then
			if parentListCount < index then
				logError("莫莉德尔角色活动 选项数量超过上限")
			else
				local parent = parentList[index]
				local itemGo = gohelper.clone(self._goBtn, parent)

				item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MoLiDeErOptionItem)

				table.insert(itemList, item)
			end
		else
			item = itemList[index]
		end

		item:setActive(true)
		item:setData(optionInfo)
	end

	if optionCount < itemCount then
		for i = optionCount + 1, itemCount do
			local item = itemList[i]

			item:setActive(false)
		end
	end
end

function MoLiDeErEventView:autoSpeak()
	if not self._curTxtData then
		return
	end

	if not self._curTxtData.index then
		local curIndex = 0

		curIndex = curIndex + 1
		self._curTxtData.index = curIndex
		self._curTxtData.txt.text = table.concat(self._curTxtData.chars, "", 1, curIndex)
		self._curTxtData.isEnd = curIndex >= self._curTxtData.charCount

		if self._curTxtData.isEnd then
			self:onDescShowEnd()
		end
	end
end

function MoLiDeErEventView:onDescShowEnd()
	if self._curTxtData.isEnd == false then
		local config = self._eventConfig

		self._txtDesc.text = config.desc
	end

	TaskDispatcher.cancelTask(self.autoSpeak, self)
	gohelper.setActive(self._btnSkip, false)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
	TaskDispatcher.runDelay(self.onDescShowDelayTimEnd, self, MoLiDeErEnum.DelayTime.DescBtnShowDelay)
	self:_lockScreen(true)
end

function MoLiDeErEventView:onDescShowDelayTimEnd()
	TaskDispatcher.cancelTask(self.onDescShowDelayTimEnd, self)
	self:_lockScreen(false)
	self:refreshUI()
end

function MoLiDeErEventView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("MoLiDeErEventView")
	else
		UIBlockMgr.instance:endBlock("MoLiDeErEventView")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function MoLiDeErEventView:refreshDispatch()
	local state = self._state
	local showDispatch = state == MoLiDeErEnum.DispatchState.Dispatch or state == MoLiDeErEnum.DispatchState.Dispatching

	gohelper.setActive(self._goDispatch, showDispatch)

	if not showDispatch then
		return
	end

	local dispatchItem = self._dispatchItem

	dispatchItem:setData(self._state, self._eventId, self._optionId)
end

function MoLiDeErEventView:refreshInfo()
	local config = self._eventConfig

	if self._optionId then
		local showFinishDesc = not (self._optionId == 0 or self._state ~= MoLiDeErEnum.DispatchState.Finish)

		gohelper.setActive(self._btnSkip, self._state == MoLiDeErEnum.DispatchState.Dispatch)

		if showFinishDesc then
			local optionId = self._optionId
			local optionConfig = MoLiDeErConfig.instance:getOptionConfig(optionId)
			local optionResultConfig = MoLiDeErConfig.instance:getOptionResultConfig(optionConfig.optionResultId)
			local valueList = MoLiDeErHelper.getOptionResultEffectParamList(optionConfig.optionResultId)

			self._txtTitle.text = optionResultConfig.name
			self._txtDesc.text = GameUtil.getSubPlaceholderLuaLang(optionResultConfig.desc, valueList)

			self:refreshUI()
		else
			self._txtTitle.text = config.name

			if self._state == MoLiDeErEnum.DispatchState.Dispatch then
				local chars = GameUtil.getUCharArrWithLineFeedWithoutRichTxt(config.desc)

				self._curTxtData = {
					isEnd = false,
					txt = self._txtDesc,
					chars = chars,
					charCount = #chars
				}

				TaskDispatcher.runRepeat(self.autoSpeak, self, MoLiDeErEnum.DelayTime.DescTextShowDelay)
			else
				self._txtDesc.text = config.desc

				self:refreshUI()
			end
		end
	end
end

function MoLiDeErEventView:onOptionSelect(optionId)
	if optionId == self._selectOptionId then
		return
	end

	self._selectOptionId = optionId

	for _, item in ipairs(self._optionItemList) do
		item:setSelect(optionId)
	end
end

function MoLiDeErEventView:onTeamSelect(teamId)
	if teamId == nil then
		return
	end

	local state = self._state

	if state == MoLiDeErEnum.DispatchState.Dispatch then
		self:refreshOptions()
	end
end

function MoLiDeErEventView:onDispatchTeam()
	if self._state == MoLiDeErEnum.DispatchState.Dispatch then
		self:closeThis()
	end
end

function MoLiDeErEventView:onWithdrawTeam()
	if self._state == MoLiDeErEnum.DispatchState.Dispatching then
		self:closeThis()
	end
end

function MoLiDeErEventView:onClose()
	MoLiDeErGameModel.instance:resetSelect()
	TaskDispatcher.cancelTask(self._autoSpeak, self)
end

function MoLiDeErEventView:onDestroyView()
	return
end

return MoLiDeErEventView
