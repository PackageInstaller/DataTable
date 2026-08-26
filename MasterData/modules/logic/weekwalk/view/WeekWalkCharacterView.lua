-- chunkname: @modules/logic/weekwalk/view/WeekWalkCharacterView.lua

module("modules.logic.weekwalk.view.WeekWalkCharacterView", package.seeall)

local WeekWalkCharacterView = class("WeekWalkCharacterView", BaseView)

function WeekWalkCharacterView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_card")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btnfaithrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_faithrank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkCharacterView:addEvents()
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnfaithrank:AddClickListener(self._btnfaithrankOnClick, self)
	self._btnexskillrank:AddClickListener(self._btnexskillrankOnClick, self)
end

function WeekWalkCharacterView:removeEvents()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnfaithrank:RemoveClickListener()
	self._btnexskillrank:RemoveClickListener()
end

function WeekWalkCharacterView:_btnlvrankOnClick()
	WeekWalkCharacterModel.instance:setCardListByLevel()
	self:_refreshBtnIcon()
end

function WeekWalkCharacterView:_btnrarerankOnClick()
	WeekWalkCharacterModel.instance:setCardListByRare()
	self:_refreshBtnIcon()
end

function WeekWalkCharacterView:_btnfaithrankOnClick()
	WeekWalkCharacterModel.instance:setCardListByFaith()
	self:_refreshBtnIcon()
end

function WeekWalkCharacterView:_btnexskillrankOnClick()
	WeekWalkCharacterModel.instance:setCardListByExSkill()
	self:_refreshBtnIcon()
end

function WeekWalkCharacterView:_refreshBtnIcon()
	local state = WeekWalkCharacterModel.instance:getRankState()
	local tag = WeekWalkCharacterModel.instance:getBtnTag()

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)
	gohelper.setActive(self._faithBtns[1], tag ~= 3)
	gohelper.setActive(self._faithBtns[2], tag == 3)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
	transformhelper.setLocalScale(self._faithArrow[1], 1, state[3], 1)
	transformhelper.setLocalScale(self._faithArrow[2], 1, state[3], 1)
end

function WeekWalkCharacterView:_updateHeroList()
	WeekWalkCharacterModel.instance:updateCardList()
	WeekWalkCharacterModel.instance:setCharacterList()
end

function WeekWalkCharacterView:_editableInitView()
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))

	self._dropclassify = gohelper.findChildDropdown(self.viewGO, "#go_rolecontainer/#go_rolesort/#drop_classify")

	WeekWalkCharacterModel.instance:setCardListByCareerIndex(0)
	self._dropclassify:SetValue(WeekWalkCharacterModel.instance:getRankIndex())
	self._dropclassify:AddOnValueChanged(self._onValueChanged, self)

	self._lvBtns = self:getUserDataTb_()
	self._lvArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()
	self._faithBtns = self:getUserDataTb_()
	self._faithArrow = self:getUserDataTb_()

	for i = 1, 2 do
		self._lvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._lvArrow[i] = gohelper.findChild(self._lvBtns[i], "arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "arrow").transform
		self._faithBtns[i] = gohelper.findChild(self._btnfaithrank.gameObject, "btn" .. tostring(i))
		self._faithArrow[i] = gohelper.findChild(self._faithBtns[i], "arrow").transform
	end

	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(self._btnfaithrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(self._dropclassify.gameObject, AudioEnum.UI.play_ui_hero_card_property)
end

function WeekWalkCharacterView:onUpdateParam()
	return
end

function WeekWalkCharacterView:onOpen()
	WeekWalkCharacterModel.instance:setCharacterList()
	self:_refreshBtnIcon()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)
end

function WeekWalkCharacterView:onClose()
	CommonHeroHelper.instance:resetGrayState()
end

function WeekWalkCharacterView:_onValueChanged(index)
	WeekWalkCharacterModel.instance:setCardListByCareerIndex(index)
	WeekWalkCharacterModel.instance:setCharacterList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function WeekWalkCharacterView:onDestroyView()
	self._imgBg:UnLoadImage()
	self._dropclassify:RemoveOnValueChanged()
end

return WeekWalkCharacterView
