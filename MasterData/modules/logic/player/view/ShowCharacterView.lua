-- chunkname: @modules/logic/player/view/ShowCharacterView.lua

module("modules.logic.player.view.ShowCharacterView", package.seeall)

local ShowCharacterView = class("ShowCharacterView", BaseView)

function ShowCharacterView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_card")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btnfaithrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_faithrank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgimg")
	self._goAssistReward = gohelper.findChild(self.viewGO, "#go_gather")
	self._txtAssistRewardCount = gohelper.findChildTextMesh(self.viewGO, "#go_gather/#txt_count")
	self._btnGetAssistReward = gohelper.findChildButtonWithAudio(self.viewGO, "#go_gather/#btn_gather")
	self._btnAssistTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_gather/#btn_tip")
	self._goCanGetAssistReward = gohelper.findChild(self.viewGO, "#go_gather/go_canget")
	self._goAssistRewardTip = gohelper.findChild(self.viewGO, "#go_gatherTip")
	self._btnCloseAssistTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_gatherTip/#btn_closeGatherTip")
	self._txtAssistTip = gohelper.findChildTextMesh(self.viewGO, "#go_gatherTip/#image_tipDescBg/#txt_tipDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShowCharacterView:addEvents()
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnfaithrank:AddClickListener(self._btnfaithrankOnClick, self)
	self._btnexskillrank:AddClickListener(self._btnexskillrankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btnGetAssistReward:AddClickListener(self._btnGetAssistRewardOnClick, self)
	self._btnAssistTip:AddClickListener(self._btnAssistTipOnClick, self)
	self._btnCloseAssistTip:AddClickListener(self._btnCloseAssistTipOnClick, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, self._refreshAssistRewardCount, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
end

function ShowCharacterView:removeEvents()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnfaithrank:RemoveClickListener()
	self._btnexskillrank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btnGetAssistReward:RemoveClickListener()
	self._btnAssistTip:RemoveClickListener()
	self._btnCloseAssistTip:RemoveClickListener()
	self.removeEventCb(self, PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, self._refreshAssistRewardCount, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
end

function ShowCharacterView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_btnfaithrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_btnclassifyOnClick()
	local param = {
		filterType = CharacterEnum.FilterType.ShowCharacter
	}

	CharacterController.instance:openCharacterFilterView(param)
end

function ShowCharacterView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.ShowCharacter)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)
	gohelper.setActive(self._faithBtns[1], tag ~= 3)
	gohelper.setActive(self._faithBtns[2], tag == 3)

	local hasFilter = CharacterSearchFilterModel.instance:hasFilter()

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
	transformhelper.setLocalScale(self._faithArrow[1], 1, state[3], 1)
	transformhelper.setLocalScale(self._faithArrow[2], 1, state[3], 1)
end

function ShowCharacterView:_btnGetAssistRewardOnClick()
	PlayerController.instance:getAssistReward()
end

function ShowCharacterView:_btnAssistTipOnClick()
	gohelper.setActive(self._goAssistRewardTip, true)
end

function ShowCharacterView:_btnCloseAssistTipOnClick()
	gohelper.setActive(self._goAssistRewardTip, false)
end

function ShowCharacterView:_refreshAssistRewardCount()
	local isFriendUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend)

	if not isFriendUnlock then
		gohelper.setActive(self._goAssistReward, false)

		return
	end

	gohelper.setActive(self._goAssistReward, true)

	local isReachingLimit = PlayerModel.instance:isGetAssistRewardReachingLimit()

	if isReachingLimit then
		self._txtAssistRewardCount.text = luaLang("reachUpperLimit")

		gohelper.setActive(self._goCanGetAssistReward, false)
	else
		self._txtAssistRewardCount.text = PlayerModel.instance:getAssistRewardCount()

		local isHasAssistReward = PlayerModel.instance:isHasAssistReward()

		gohelper.setActive(self._goCanGetAssistReward, isHasAssistReward)
	end

	local hasReceivedAssistRewardCount = PlayerModel.instance:getHasReceiveAssistBonus()
	local maxAssistRewardCount = PlayerModel.instance:getMaxAssistRewardCount()

	self._txtAssistTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("player_assist_reward_tips"), {
		hasReceivedAssistRewardCount,
		maxAssistRewardCount
	})
end

function ShowCharacterView:_updateHeroList()
	self:_refreshBtnIcon()
end

function ShowCharacterView:_editableInitView()
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnfaithrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	self._simagebgimg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))
	CharacterModel.instance:setCardListByCareerIndex(0)

	self._lvBtns = self:getUserDataTb_()
	self._lvArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()
	self._faithBtns = self:getUserDataTb_()
	self._faithArrow = self:getUserDataTb_()
	self._classifyBtns = self:getUserDataTb_()

	for i = 1, 2 do
		self._lvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._lvArrow[i] = gohelper.findChild(self._lvBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
		self._faithBtns[i] = gohelper.findChild(self._btnfaithrank.gameObject, "btn" .. tostring(i))
		self._faithArrow[i] = gohelper.findChild(self._faithBtns[i], "txt/arrow").transform
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
	end

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)

	self:_btnCloseAssistTipOnClick()
end

function ShowCharacterView:onUpdateParam()
	return
end

function ShowCharacterView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
	CharacterModel.instance:setCharacterList(true, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)
	self:updateAssistReward()

	if self.viewParam then
		if not self.viewParam then
			local updateFrequency = CommonConfig.instance:getConstNum(ConstEnum.AssistRewardUpdateFrequency)

			TaskDispatcher.cancelTask(self.updateAssistReward, self)
			TaskDispatcher.runRepeat(self.updateAssistReward, self, updateFrequency)
		end
	end
end

function ShowCharacterView:updateAssistReward()
	local isFriendUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend)

	gohelper.setActive(self._goAssistReward, isFriendUnlock)
	PlayerController.instance:updateAssistRewardCount()
end

function ShowCharacterView:_onFilterList(param)
	local dmgs, careers = param.dmgs1, param.careers2

	HeroGroupTrialModel.instance:setFilter(dmgs, careers)
	self:_refreshBtnIcon()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function ShowCharacterView:onClose()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)
	TaskDispatcher.cancelTask(self.updateAssistReward, self)
	CharacterController.instance:closeCharacterFilterView()
	CharacterSearchFilterModel.instance:exitParentView()
end

function ShowCharacterView:_onQuitAdventure()
	self:closeThis()
end

function ShowCharacterView:onDestroyView()
	self._simagebgimg:UnLoadImage()
end

return ShowCharacterView
