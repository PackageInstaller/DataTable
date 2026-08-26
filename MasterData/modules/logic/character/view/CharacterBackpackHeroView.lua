-- chunkname: @modules/logic/character/view/CharacterBackpackHeroView.lua

module("modules.logic.character.view.CharacterBackpackHeroView", package.seeall)

local CharacterBackpackHeroView = class("CharacterBackpackHeroView", BaseView)

function CharacterBackpackHeroView:onInitView()
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#scroll_card")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/#btn_rarerank")
	self._btnfaithrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/#btn_faithrank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/#btn_exskillrank")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolesort/#btn_exskillrank/#go_exarrow")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/#btn_classify")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#scroll_card/scrollcontent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterBackpackHeroView:addEvents()
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnfaithrank:AddClickListener(self._btnfaithrankOnClick, self)
	self._btnexskillrank:AddClickListener(self._btnexskillrankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
end

function CharacterBackpackHeroView:removeEvents()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnfaithrank:RemoveClickListener()
	self._btnexskillrank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
end

function CharacterBackpackHeroView:_editableInitView()
	self._ani = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(self._btnfaithrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)

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

	self._selectDmgs = {
		false,
		false
	}
	self._selectAttrs = {
		false,
		false,
		false,
		false,
		false,
		false
	}

	CharacterBackpackCardListModel.instance:updateModel()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.BackpackHero)
end

function CharacterBackpackHeroView:_btnclassifyOnClick()
	local param = {}

	param.dmgs = LuaUtil.deepCopy(self._selectDmgs)
	param.destiny = LuaUtil.deepCopy(self._selectDestiny)
	param.attrs = LuaUtil.deepCopy(self._selectAttrs)
	param.filterType = CharacterEnum.FilterType.BackpackHero

	CharacterController.instance:openCharacterFilterView(param)
end

function CharacterBackpackHeroView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.BackpackHero)
	self:_refreshBtnIcon()
end

function CharacterBackpackHeroView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.BackpackHero)
	self:_refreshBtnIcon()
end

function CharacterBackpackHeroView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.BackpackHero)
	self:_refreshBtnIcon()
end

function CharacterBackpackHeroView:_btnfaithrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(false, CharacterEnum.FilterType.BackpackHero)
	self:_refreshBtnIcon()
end

function CharacterBackpackHeroView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.BackpackHero)

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

function CharacterBackpackHeroView:onUpdateParam()
	return
end

function CharacterBackpackHeroView:onOpen()
	self._ani.enabled = #self.tabContainer._tabAbLoaders < 2

	self.addEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)

	self._scrollcard.verticalNormalizedPosition = 1

	self:_refreshBtnIcon()
	self:_updateHeroList()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)
end

function CharacterBackpackHeroView:_onFilterList(param)
	self._selectDmgs = param.dmgs
	self._selectDestiny = param.destiny
	self._selectAttrs = param.attrs
	self._selectTags = param.selectTags

	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	self:_refreshBtnIcon()
end

function CharacterBackpackHeroView:_updateHeroList()
	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6,
			101
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.destiny = self._selectDestiny
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.BackpackHero)
	self:_refreshBtnIcon()
end

function CharacterBackpackHeroView:onClose()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(nil)
	CharacterSearchFilterModel.instance:exitParentView()
end

function CharacterBackpackHeroView:onDestroyView()
	return
end

return CharacterBackpackHeroView
