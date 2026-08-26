-- chunkname: @modules/logic/room/view/critter/train/RoomCritterTrainStoryView.lua

module("modules.logic.room.view.critter.train.RoomCritterTrainStoryView", package.seeall)

local RoomCritterTrainStoryView = class("RoomCritterTrainStoryView", BaseView)

function RoomCritterTrainStoryView:onInitView()
	self._gomask2 = gohelper.findChild(self.viewGO, "mask2")
	self._gomask = gohelper.findChild(self.viewGO, "mask")
	self._golefttopbtns = gohelper.findChild(self.viewGO, "#go_lefttopbtns")
	self._gorighttopbtns = gohelper.findChild(self.viewGO, "#go_righttopbtns")
	self._btncurrency = gohelper.findChildButtonWithAudio(self.viewGO, "#go_righttopbtns/#go_container/currency/#btn_currency")
	self._imagecurrency = gohelper.findChildImage(self.viewGO, "#go_righttopbtns/#go_container/currency/#image")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_righttopbtns/#go_container/currency/#btn_add")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "#go_righttopbtns/#go_container/currency/content/#txt")
	self._gospine = gohelper.findChild(self.viewGO, "#go_spine")
	self._scrollselect = gohelper.findChildScrollRect(self.viewGO, "#scroll_select")
	self._golist = gohelper.findChild(self.viewGO, "#scroll_select/Viewport/#go_list")
	self._txtnum = gohelper.findChildText(self.viewGO, "#scroll_select/Viewport/#go_list/selectitem/bgdark/#txt_num")
	self._gopcbtn = gohelper.findChild(self.viewGO, "#scroll_select/Viewport/#go_list/selectitem/bgdark/#go_pcbtn")
	self._goconversation = gohelper.findChild(self.viewGO, "#go_conversation")
	self._goname = gohelper.findChild(self.viewGO, "#go_conversation/#go_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_conversation/#go_name/#txt_nameen")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "#go_conversation/#go_name/#txt_namecn")
	self._gocontents = gohelper.findChild(self.viewGO, "#go_conversation/#go_contents")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#go_conversation/#go_contents/#txt_content")
	self._gotrainprogress = gohelper.findChild(self.viewGO, "#go_trainprogress")
	self._imagetotalBarValue = gohelper.findChildImage(self.viewGO, "#go_trainprogress/progressbg/#image_totalBarValue")
	self._goexittips = gohelper.findChild(self.viewGO, "#go_exittips")
	self._goexittxt = gohelper.findChild(self.viewGO, "#go_exittips/txt")
	self._goattribute = gohelper.findChild(self.viewGO, "#go_attribute")
	self._goattributeup = gohelper.findChild(self.viewGO, "#go_attributeup")
	self._goattributeupitem = gohelper.findChild(self.viewGO, "#go_attributeup/attributeup")
	self._btntrainstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_trainstart")
	self._goattributeupeffect = gohelper.findChild(self.viewGO, "#attributeup_effect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainStoryView:addEvents()
	self._btncurrency:AddClickListener(self._btncurrencyOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btntrainstart:AddClickListener(self._btntrainstartOnClick, self)
end

function RoomCritterTrainStoryView:removeEvents()
	self._btncurrency:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btntrainstart:RemoveClickListener()
end

function RoomCritterTrainStoryView:_btncurrencyOnClick()
	local eventCo = CritterConfig.instance:getCritterTrainEventCfg(self.viewParam.eventId)
	local currencys = string.splitToNumber(eventCo.cost, "#")

	MaterialTipController.instance:showMaterialInfo(currencys[1], currencys[2], false, nil, false)
end

function RoomCritterTrainStoryView:_btnaddOnClick()
	local eventCo = CritterConfig.instance:getCritterTrainEventCfg(self.viewParam.eventId)
	local currencys = string.splitToNumber(eventCo.cost, "#")

	RoomCritterController.instance:openExchangeView(currencys)
end

function RoomCritterTrainStoryView:_btntrainstartOnClick()
	local eventCfg = CritterConfig.instance:getCritterTrainEventCfg(self.viewParam.eventId)
	local costs = string.splitToNumber(eventCfg.cost, "#")
	local hasCount = math.floor(ItemModel.instance:getItemQuantity(costs[1], costs[2]) / costs[3])
	local totalCount = RoomTrainCritterModel.instance:getSelectOptionTotalCount()
	local itemCo = ItemModel.instance:getItemConfig(costs[1], costs[2])

	if hasCount < totalCount then
		GameFacade.showToast(ToastEnum.RoomCritterTrainCountNotEnoughCurrency, itemCo.name)

		return
	end

	local infos = RoomTrainCritterModel.instance:getSelectOptionInfos()

	CritterRpc.instance:sendSelectMultiEventOptionRequest(self.viewParam.critterUid, self.viewParam.eventId, infos, self._attributeSelected, self)
end

function RoomCritterTrainStoryView:_attributeSelected(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_showEnterBtn(false)
	gohelper.setActive(self._goattribute, false)
	gohelper.setActive(self._scrollselect.gameObject, false)
	gohelper.setActive(self._goconversation, false)
	self._critterItem:fadeOut()

	if self.viewParam.skipStory then
		self.viewContainer:getSetting().viewType = ViewType.Full
	else
		gohelper.setActive(self._storyViewGo, true)

		self.viewContainer:getSetting().viewType = ViewType.Normal
	end

	for _, v in ipairs(msg.infos) do
		local info = {}

		info.optionId = v.optionId
		info.count = v.count
		self._optionInfos[info.optionId] = info
	end

	self._attributeItem:playBarAdd(false)
	self._viewAnim:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._showTrainProgress, self, 0.17)
end

function RoomCritterTrainStoryView:_addEvents()
	self._exitBtn:AddClickListener(self._onExitClick, self)
	StoryController.instance:registerCallback(StoryEvent.DialogConFinished, self._onDialogConFinished, self)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	RoomController.instance:registerCallback(RoomEvent.CritterTrainAttributeSelected, self._onAttributeSelected, self)
	RoomController.instance:registerCallback(RoomEvent.CritterTrainAttributeCancel, self._onAttributeCancel, self)
	StoryController.instance:registerCallback(StoryEvent.OnReplaceHero, self._onStoryReplaceHero, self)
end

function RoomCritterTrainStoryView:_removeEvents()
	self._exitBtn:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, self._onDialogConFinished, self)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainAttributeSelected, self._onAttributeSelected, self)
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainAttributeCancel, self._onAttributeCancel, self)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, self._onAttributeStoryFinished, self)
	StoryController.instance:unregisterCallback(StoryEvent.OnReplaceHero, self._onStoryReplaceHero, self)
end

function RoomCritterTrainStoryView:_onDialogConFinished()
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, self._onDialogConFinished, self)
	self:_showAttributeSelect()
end

function RoomCritterTrainStoryView:_showAttributeSelect()
	gohelper.setActive(self._goattribute, true)
	gohelper.setActive(self._scrollselect.gameObject, true)
	gohelper.setActive(self._goconversation, true)

	if self._storyViewGo then
		gohelper.setActive(self._storyViewGo, false)

		self.viewContainer:getSetting().viewType = ViewType.Full

		self._critterItem:fadeIn()
		self._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	else
		self._critterItem:showByEffectType(self._critterMO, CritterEnum.PosType.Middle, false)
		self._critterItem:fadeIn()
	end

	StoryController.instance:closeStoryView()
	gohelper.setActive(self._gorighttopbtns, true)
	self:_refreshCurrency()
	self:_refreshAttribute()
	self:_refreshSelect()
	self:_playConversation()

	local optionInfos = self._critterMO.trainInfo:getEventOptions(self.viewParam.eventId)

	self._attributeItem:playBarAdd(true, optionInfos)
	self._viewAnim:Play("open", 0, 0)
end

function RoomCritterTrainStoryView:_onAttributeSelected(attributeId, optionId)
	RoomTrainCritterModel.instance:addSelectOptionCount(attributeId)
	self:_refreshAttribute()

	local optionInfos = self._critterMO.trainInfo:getEventOptions(self.viewParam.eventId)

	self._attributeItem:playBarAdd(true, optionInfos)
	self:_refreshSelect()
	self:_showEnterBtn(true)
end

function RoomCritterTrainStoryView:_onAttributeCancel(attributeId, optionId)
	RoomTrainCritterModel.instance:cancelSelectOptionCount(attributeId)
	self:_refreshAttribute()

	local optionInfos = self._critterMO.trainInfo:getEventOptions(self.viewParam.eventId)

	self._attributeItem:playBarAdd(true, optionInfos)
	self:_refreshSelect()
	self:_showEnterBtn(true)
end

local spineAnim = {
	[203] = "taming3",
	[202] = "taming",
	[201] = "taming2"
}
local timeIndexs = {
	[203] = 3,
	[202] = 1,
	[201] = 2
}

function RoomCritterTrainStoryView:_showTrainProgress()
	self.viewContainer:getSetting().viewType = ViewType.Full

	gohelper.setActive(self._gospine, true)
	self._critterItem:showTamingEffects(true, timeIndexs[self.viewParam.eventId])
	self._critterItem:setCritterEffectOffset(0, 30)
	self._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	self._critterItem:fadeIn()
	gohelper.setActive(self._gotrainprogress, true)
	gohelper.setActive(self._gorighttopbtns, false)

	local bodyName = spineAnim[self.viewParam.eventId]

	self._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	self._critterItem:playBodyAnim(bodyName, true)

	self._progressTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._progressTime, self._progressUpdate, self._progressFinished, self, nil, EaseType.Linear)
end

function RoomCritterTrainStoryView:_progressUpdate(value)
	self._imagetotalBarValue.fillAmount = value
end

function RoomCritterTrainStoryView:_progressFinished()
	self._trainShowing = true

	gohelper.setActive(self._goexittips, true)
	gohelper.setActive(self._goexittxt, false)

	local processTime = string.splitToNumber(CritterConfig.instance:getCritterCfg(self._critterMO.defineId).eventTimes, "#")[timeIndexs[self.viewParam.eventId]]
	local delayTime = processTime - self._progressTime

	if delayTime <= 0 then
		self:_critterAniFinished()
	else
		TaskDispatcher.runDelay(self._critterAniFinished, self, delayTime)
	end
end

function RoomCritterTrainStoryView:_critterAniFinished()
	self._critterItem:playBodyAnim(RoomCharacterEnum.CharacterAnimStateName.Idle, true)
	gohelper.setActive(self._gotrainprogress, false)
	self._critterItem:fadeOut()
	self._critterItem:showTamingEffects(false)
	self._trainAnim:Play("close", 0, 0)

	self._trainShowing = false

	gohelper.setActive(self._goexittips, false)
	TaskDispatcher.runDelay(self._startAttributeStory, self, 0.17)
end

function RoomCritterTrainStoryView:_startAttributeStory()
	if self.viewParam.skipStory then
		self:_onAttributeStoryFinished()
	else
		self.viewContainer:getSetting().viewType = ViewType.Normal

		RoomCritterController.instance:startAttributeResult(self.viewParam.eventId, self.viewParam.critterUid, self.viewParam.heroId, self.optionId)
		StoryController.instance:registerCallback(StoryEvent.Finish, self._onAttributeStoryFinished, self)
	end
end

function RoomCritterTrainStoryView:_onAttributeStoryFinished()
	self.viewContainer:getSetting().viewType = ViewType.Full

	StoryController.instance:unregisterCallback(StoryEvent.Finish, self._onAttributeStoryFinished, self)
	StoryController.instance:unregisterCallback(StoryEvent.OnReplaceHero, self._onStoryReplaceHero, self)
	self._critterItem:fadeOut()
	TaskDispatcher.runDelay(self._startShowResult, self, 0.17)
end

function RoomCritterTrainStoryView:_onExitClick()
	if self._trainShowing then
		if self._progressTweenId then
			ZProj.TweenHelper.KillById(self._progressTweenId)

			self._progressTweenId = nil
		end

		TaskDispatcher.cancelTask(self._startAttributeStory, self)
		TaskDispatcher.cancelTask(self._critterAniFinished, self)
		self:_critterAniFinished()

		return
	end

	self:closeThis()
end

function RoomCritterTrainStoryView:_editableInitView()
	self._selectItems = {}
	self._optionInfos = {}
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local go = self:getResInst(RoomCritterTrainDetailItem.prefabPath, self._goattribute)

	self._attributeItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterTrainDetailItem, self)
	self._critterItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gospine, RoomCritterTrainCritterItem, self)

	self._critterItem:init(self._gospine)

	self._goselectitem = gohelper.findChild(self.viewGO, "#scroll_select/Viewport/#go_list/selectitem")
	self._trainAnim = self._gotrainprogress:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goselectitem, false)

	self._exitBtn = gohelper.getClick(self._goexittips)

	self:_addEvents()
	gohelper.setActive(self._goattribute, false)
	gohelper.setActive(self._scrollselect.gameObject, false)
	gohelper.setActive(self._goconversation, false)
	gohelper.setActive(self._goexittips, false)
	gohelper.setActive(self._gospine, false)
	gohelper.setActive(self._gotrainprogress, false)
	gohelper.setActive(self._gorighttopbtns, false)
	gohelper.setActive(self._goattributeup, false)
	gohelper.setActive(self._goattributeupitem, false)
	self:_showEnterBtn(false)

	self._progressTime = tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterTrainKeepTime)) / 1000
end

function RoomCritterTrainStoryView:onUpdateParam()
	self._critterMO = CritterModel.instance:getCritterMOByUid(self.viewParam.critterUid)
end

function RoomCritterTrainStoryView:_refreshAttribute()
	local slotMO = RoomTrainSlotListModel.instance:getSlotMOByCritterUi(self.viewParam.critterUid)

	self._attributeItem:onUpdateMO(slotMO.critterMO)
end

function RoomCritterTrainStoryView:_refreshSelect()
	local options = self._critterMO.trainInfo:getEventOptions(self.viewParam.eventId)

	for i = 1, #options do
		if not self._selectItems[i] then
			self._selectItems[i] = RoomCritterTrainStorySelectItem.New()

			self._selectItems[i]:init(self._goselectitem, i)
		end

		local count = RoomTrainCritterModel.instance:getSelectOptionCount(options[i].optionId)

		self._selectItems[i]:show(options[i].optionId, self._critterMO, self.viewParam.eventId, count)
	end
end

function RoomCritterTrainStoryView:_playConversation()
	local heroCo = HeroConfig.instance:getHeroCO(self.viewParam.heroId)

	self._txtnameen.text = heroCo.nameEn
	self._txtnamecn.text = heroCo.name

	local eventCo = CritterConfig.instance:getCritterTrainEventCfg(self.viewParam.eventId)
	local costValue = string.splitToNumber(eventCo.cost, "#")[3]
	local eventInfo = self._critterMO.trainInfo:getEvents(self.viewParam.eventId)

	self._txtcontent.text = string.format(eventCo.content, eventInfo.remainCount, string.format("%s <sprite=0>", costValue))

	self:_showEnterBtn(true)
end

function RoomCritterTrainStoryView:_showEnterBtn(show)
	local totalCount = RoomTrainCritterModel.instance:getSelectOptionTotalCount()
	local showEnter = show and totalCount > 0

	gohelper.setActive(self._btntrainstart, showEnter)
end

function RoomCritterTrainStoryView:_refreshCurrency()
	local eventCo = CritterConfig.instance:getCritterTrainEventCfg(self.viewParam.eventId)
	local currencyID = string.splitToNumber(eventCo.cost, "#")[2]
	local currencyMO = CurrencyModel.instance:getCurrency(currencyID)
	local currencyCO = CurrencyConfig.instance:getCurrencyCo(currencyID)

	self._txtcurrency.text = GameUtil.numberDisplay(currencyMO.quantity)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrency, currencyCO.icon .. "_1")
end

function RoomCritterTrainStoryView:_onStoryReplaceHero(heroMo)
	gohelper.setLayer(self._gomask, UnityLayer.UI, true)
	gohelper.setLayer(self._gomask2, UnityLayer.UI, true)
	gohelper.setActive(self._gospine, true)

	local effCo = heroMo.effs[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if effCo == "" then
		self._critterItem:setEffectByType(0)
		self._critterItem:hideEffects()
	else
		local effectCos = GameUtil.splitString2(effCo, false, "|", "#")

		for _, v in ipairs(effectCos) do
			self._critterItem:setEffectByName(v[2])
			self._critterItem:setCritterEffectOffset(tonumber(v[3]), tonumber(v[4]))
			self._critterItem:setCritterEffectScale(tonumber(v[5]))
		end
	end

	if self._critterItem:getCritterPos() ~= heroMo.heroDir + 1 then
		self._critterItem:fadeIn()
	end

	self._critterItem:setCritterPos(heroMo.heroDir + 1, true)
end

function RoomCritterTrainStoryView:_startShowResult()
	RoomTrainCritterModel.instance:setEventTrainStoryPlayed(self.viewParam.heroId)
	gohelper.setActive(self._gospine, true)
	gohelper.setActive(self._goexittips, true)
	gohelper.setActive(self._goexittxt, true)
	gohelper.setActive(self._goattributeup, true)
	gohelper.setActive(self._goattribute, true)
	gohelper.setActive(self._goattributeupeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_peixun)
	self._critterItem:fadeIn()
	self._critterItem:showTamingEffects(false)
	self._critterItem:setEffectByType(3)
	self._critterItem:setCritterEffectOffset(0, 30)
	self._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	self._critterItem:playBodyAnim(RoomCharacterEnum.CharacterAnimStateName.Idle, true)
	self._viewAnim:Play("open", 0, 0)

	self._resultAttributeMOs = {}

	for _, info in pairs(self._optionInfos) do
		local optionId = info.optionId
		local attributeMo = self._critterMO.trainInfo:getEventOptionMOByOptionId(self.viewParam.eventId, optionId).addAttriButes

		self._resultAttributeMOs[optionId] = LuaUtil.deepCopy(attributeMo[1])
		self._resultAttributeMOs[optionId].value = info.count * attributeMo[1].value
	end

	self._attributeItem:playLevelUp(self._resultAttributeMOs)

	self._repeatCount = 0

	TaskDispatcher.runRepeat(self._showAttribute, self, 0.3, #self._resultAttributeMOs)
end

function RoomCritterTrainStoryView:_showAttribute()
	self._repeatCount = self._repeatCount + 1

	local parentGo = gohelper.findChild(self._goattributeup, tostring(self._repeatCount))
	local go = gohelper.clone(self._goattributeupitem)

	gohelper.addChild(parentGo, go)

	local txtattributeup = gohelper.findChildText(go, "up/#txt_up")
	local attName = CritterConfig.instance:getCritterAttributeCfg(self._resultAttributeMOs[self._repeatCount].attributeId).name
	local attValue = self._resultAttributeMOs[self._repeatCount].value

	if attValue <= 0 then
		gohelper.setActive(go, false)

		return
	end

	gohelper.setActive(go, true)

	txtattributeup.text = string.format("%s + %s", attName, attValue)
end

local tagHeroIndex = 2223

function RoomCritterTrainStoryView:onOpen()
	self._critterMO = CritterModel.instance:getCritterMOByUid(self.viewParam.critterUid)

	local skinCo = CritterConfig.instance:getCritterSkinCfg(self._critterMO:getSkinId())
	local path = ResUrl.getSpineUIPrefab(skinCo.spine)

	StoryModel.instance:setReplaceHero(tagHeroIndex, path)
	gohelper.setActive(self._gospine, true)

	if self.viewParam.skipStory then
		self:_showAttributeSelect()
	else
		self._storyViewGo = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

		self._critterItem:showByEffectName(self._critterMO, CritterEnum.PosType.Right, true)
		self._critterItem:fadeIn()
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterTrainStarted)
end

function RoomCritterTrainStoryView:_onCurrencyChanged()
	return
end

function RoomCritterTrainStoryView:onClose()
	CritterController.instance:dispatchEvent(CritterEvent.CritterTrainFinished)
	RoomCritterController.instance:endTrain(self.viewParam.eventId)
end

function RoomCritterTrainStoryView:onDestroyView()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._startAttributeStory, self)
	TaskDispatcher.cancelTask(self._showTrainProgress, self)
	TaskDispatcher.cancelTask(self._startShowResult, self)
	TaskDispatcher.cancelTask(self._showAttribute, self)
	TaskDispatcher.cancelTask(self._critterAniFinished, self)

	if self._selectItems then
		for _, v in pairs(self._selectItems) do
			v:destroy()
		end

		self._selectItems = nil
	end

	self._attributeItem:onDestroy()

	if self._critterItem then
		self._critterItem:onDestroy()

		self._critterItem = nil
	end

	if self._progressTweenId then
		ZProj.TweenHelper.KillById(self._progressTweenId)

		self._progressTweenId = nil
	end
end

return RoomCritterTrainStoryView
