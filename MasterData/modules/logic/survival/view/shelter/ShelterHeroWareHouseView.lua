-- chunkname: @modules/logic/survival/view/shelter/ShelterHeroWareHouseView.lua

module("modules.logic.survival.view.shelter.ShelterHeroWareHouseView", package.seeall)

local ShelterHeroWareHouseView = class("ShelterHeroWareHouseView", BaseView)

function ShelterHeroWareHouseView:onInitView()
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#scroll_card")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/root/#btn_lvrank", AudioEnum.UI.UI_transverse_tabs_click)
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/root/#btn_rarerank", AudioEnum.UI.UI_transverse_tabs_click)
	self._btnfaithrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/root/#btn_faithrank", AudioEnum.UI.UI_transverse_tabs_click)
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/root/#btn_exskillrank")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolesort/root/#btn_exskillrank/#go_exarrow")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolesort/root/#btn_classify")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#scroll_card/viewport/scrollcontent")
	self.filterType = CharacterEnum.FilterType.Survival

	self:initBtnArrow()

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
	self._scrollcard.verticalNormalizedPosition = 1
	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)
end

function ShelterHeroWareHouseView:addEvents()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)
	self.addClickCb(self, self._btnlvrank, self._btnlvrankOnClick, self)
	self.addClickCb(self, self._btnrarerank, self._btnrarerankOnClick, self)
	self.addClickCb(self, self._btnfaithrank, self._btnfaithrankOnClick, self)
	self.addClickCb(self, self._btnexskillrank, self._btnexskillrankOnClick, self)
	self.addClickCb(self, self._btnclassify, self._btnclassifyOnClick, self)
end

function ShelterHeroWareHouseView:removeEvents()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)
	self:removeClickCb(self._btnlvrank)
	self:removeClickCb(self._btnrarerank)
	self:removeClickCb(self._btnfaithrank)
	self:removeClickCb(self._btnexskillrank)
	self:removeClickCb(self._btnclassify)
end

function ShelterHeroWareHouseView:initBtnArrow()
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
end

function ShelterHeroWareHouseView:_onFilterList(param)
	self._selectDmgs = param.dmgs
	self._selectAttrs = param.attrs

	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	self:_refreshBtnIcon()
end

function ShelterHeroWareHouseView:_btnclassifyOnClick()
	local param = {}

	param.dmgs = LuaUtil.deepCopy(self._selectDmgs)
	param.attrs = LuaUtil.deepCopy(self._selectAttrs)
	param.filterType = self.filterType

	CharacterController.instance:openCharacterFilterView(param)
end

function ShelterHeroWareHouseView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, self.filterType)
	self:_refreshBtnIcon()
end

function ShelterHeroWareHouseView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, self.filterType)
	self:_refreshBtnIcon()
end

function ShelterHeroWareHouseView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, self.filterType)
	self:_refreshBtnIcon()
end

function ShelterHeroWareHouseView:_btnfaithrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(false, self.filterType)
	self:_refreshBtnIcon()
end

function ShelterHeroWareHouseView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(self.filterType)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)
	gohelper.setActive(self._faithBtns[1], tag ~= 3)
	gohelper.setActive(self._faithBtns[2], tag == 3)

	local hasFilter = false

	for _, v in pairs(self._selectDmgs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectAttrs) do
		if v then
			hasFilter = true
		end
	end

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
	transformhelper.setLocalScale(self._faithArrow[1], 1, state[3], 1)
	transformhelper.setLocalScale(self._faithArrow[2], 1, state[3], 1)
end

function ShelterHeroWareHouseView:onUpdateParam()
	return
end

function ShelterHeroWareHouseView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
	self:refreshView()
	self.viewContainer:playCardOpenAnimation()
end

function ShelterHeroWareHouseView:refreshView()
	self:_updateHeroList()
end

function ShelterHeroWareHouseView:_updateHeroList()
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
			6
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
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.BackpackHero)
	self:_refreshBtnIcon()
end

function ShelterHeroWareHouseView:onClose()
	CharacterSearchFilterModel.instance:exitParentView()
end

function ShelterHeroWareHouseView:onDestroyView()
	return
end

return ShelterHeroWareHouseView
