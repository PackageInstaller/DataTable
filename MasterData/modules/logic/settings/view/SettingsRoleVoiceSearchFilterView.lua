-- chunkname: @modules/logic/settings/view/SettingsRoleVoiceSearchFilterView.lua

module("modules.logic.settings.view.SettingsRoleVoiceSearchFilterView", package.seeall)

local SettingsRoleVoiceSearchFilterView = class("SettingsRoleVoiceSearchFilterView", BaseView)

function SettingsRoleVoiceSearchFilterView:onInitView()
	local dropfilterTemplate = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang/Template")

	self._dropfilterTemplateTrans = dropfilterTemplate.transform
	self._gosearchfilter = gohelper.findChild(self.viewGO, "#go_searchfilter")
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/#btn_closefilterview")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._goclassifyUnSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify/btn1")
	self._goclassifySelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify/btn2")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_reset")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_ok")
	self._dropfilter = gohelper.findChildDropdown(self.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang")
	self._transArrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang/go_arrow").transform
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btntrustrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank")
	self._golvrankUnSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/btn1")
	self._golvrankSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/btn2")
	self._gotrustrankUnSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank/btn1")
	self._gotrustrankSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank/btn2")
	self._transrareArrow = gohelper.findChild(self._golvrankSelected, "txt/arrow").transform
	self._transfaithArrow = gohelper.findChild(self._gotrustrankSelected, "txt/arrow").transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsRoleVoiceSearchFilterView:addEvents()
	self._btnclosefilterview:AddClickListener(self._btnclosefilterviewOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btntrustrank:AddClickListener(self._btntrustrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnlvrankOnClick, self)
	self._dropfilter:AddOnValueChanged(self._onDropFilterValueChanged, self)
end

function SettingsRoleVoiceSearchFilterView:removeEvents()
	self._btnclosefilterview:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btntrustrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._dropfilter:RemoveOnValueChanged()
end

function SettingsRoleVoiceSearchFilterView:_btnresetOnClick()
	for i = 1, 6 do
		self._selectAttrs[i] = false
		self._selectCharTypes[i] = false
	end

	self:_refreshView()
end

function SettingsRoleVoiceSearchFilterView:_btnconfirmOnClick()
	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	careers = #careers == 0 and {
		1,
		2,
		3,
		4,
		5,
		6
	} or careers

	local charTypes = {}

	for i = 1, 6 do
		if self._selectCharTypes[i] then
			charTypes[#charTypes + 1] = i
		end
	end

	charTypes = #charTypes == 0 and {
		1,
		2,
		3,
		4,
		5,
		6
	} or charTypes

	local filterParam = {}

	filterParam.careers = careers
	filterParam.charTypes = charTypes
	filterParam.charLang = self._filterLang

	CharacterModel.instance:filterCardListByCareerAndCharType(filterParam, false, CharacterEnum.FilterType.CharVoiceSetting)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleFiltered)
	self:_refreshClassifyBtnStateView(false)
end

function SettingsRoleVoiceSearchFilterView:_btntrustrankOnClick()
	CharacterModel.instance:setCardListByLangType(CharacterEnum.FilterType.CharVoiceSetting, false, true)
	self:_refreshRankMode()
end

function SettingsRoleVoiceSearchFilterView:_btnlvrankOnClick()
	CharacterModel.instance:setCardListByLangType(CharacterEnum.FilterType.CharVoiceSetting, true, false)
	self:_refreshRankMode()
end

function SettingsRoleVoiceSearchFilterView:_btnclosefilterviewOnClick()
	self._selectAttrs = LuaUtil.deepCopy(self._attrsCopy)
	self._selectCharTypes = LuaUtil.deepCopy(self._charTypesCopy)

	self:_refreshClassifyBtnStateView(false)
end

function SettingsRoleVoiceSearchFilterView:_btnclassifyOnClick()
	self._attrsCopy = LuaUtil.deepCopy(self._selectAttrs)
	self._charTypesCopy = LuaUtil.deepCopy(self._selectCharTypes)

	self:_refreshClassifyBtnStateView(true)
	self:_refreshView()
end

function SettingsRoleVoiceSearchFilterView:_onDropFilterValueChanged(index)
	if self._languageOptions[index + 1] then
		self._filterLang = self._languageOptions[index + 1] or 0
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	careers = #careers == 0 and {
		1,
		2,
		3,
		4,
		5,
		6
	} or careers

	local charTypes = {}

	for i = 1, 6 do
		if self._selectCharTypes[i] then
			charTypes[#charTypes + 1] = i
		end
	end

	charTypes = #charTypes == 0 and {
		1,
		2,
		3,
		4,
		5,
		6
	} or charTypes

	local filterParam = {}

	filterParam.careers = careers
	filterParam.charTypes = charTypes
	filterParam.charLang = self._filterLang

	CharacterModel.instance:filterCardListByCareerAndCharType(filterParam, false, CharacterEnum.FilterType.CharVoiceSetting)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleFiltered)
end

function SettingsRoleVoiceSearchFilterView:onFilterDropShow()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	self._isPopUpFilterList = true

	self:refreshFilterDropDownArrow()

	local curLangId = self._filterLang
	local optionListContentTrans = gohelper.findChild(self._dropfilter.gameObject, "Dropdown List/Viewport/Content").transform

	for idx, languageId in ipairs(self._languageOptions) do
		local optionTrans = optionListContentTrans:GetChild(idx)
		local optionText = gohelper.findChildText(optionTrans.gameObject, "Text")

		optionText.text = languageId == curLangId and string.format("<color=#efb785ff>%s</color>", self._optionsName[idx]) or string.format("<color=#c3beb6ff>%s</color>", self._optionsName[idx])
	end
end

function SettingsRoleVoiceSearchFilterView:onFilterDropHide()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	self._isPopUpFilterList = false

	self:refreshFilterDropDownArrow()
end

function SettingsRoleVoiceSearchFilterView:refreshFilterDropDownArrow()
	transformhelper.setLocalScale(self._transArrow, 1, self._isPopUpFilterList and -1 or 1, 1)
end

function SettingsRoleVoiceSearchFilterView:_editableInitView()
	self._attrSelects = self:getUserDataTb_()
	self._attrUnselects = self:getUserDataTb_()
	self._attrBtnClicks = self:getUserDataTb_()

	for i = 1, 6 do
		self._attrUnselects[i] = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/unselected")
		self._attrSelects[i] = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/selected")
		self._attrBtnClicks[i] = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/click")

		self._attrBtnClicks[i]:AddClickListener(self._attrBtnOnClick, self, i)
	end

	self._charTypeSelects = self:getUserDataTb_()
	self._charTypeUnselects = self:getUserDataTb_()
	self._charTypeBtnClicks = self:getUserDataTb_()

	for i = 1, 6 do
		self._charTypeUnselects[i] = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/unselected")
		self._charTypeSelects[i] = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/selected")
		self._charTypeBtnClicks[i] = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/click")

		self._charTypeBtnClicks[i]:AddClickListener(self._charTypeBtnOnClick, self, i)
	end

	self._filterLang = 0
end

function SettingsRoleVoiceSearchFilterView:_attrBtnOnClick(i)
	self._selectAttrs[i] = not self._selectAttrs[i]

	self:_refreshView()
end

function SettingsRoleVoiceSearchFilterView:_charTypeBtnOnClick(i)
	self._selectCharTypes[i] = not self._selectCharTypes[i]

	self:_refreshView()
end

function SettingsRoleVoiceSearchFilterView:onOpen()
	self.addEventCb(self, SettingsRoleVoiceController.instance, SettingsEvent.OnCharVoiceTypeChanged, self._onCharVoiceTypeChanged, self)

	self._selectAttrs = {}
	self._selectCharTypes = {}

	for i = 1, 6 do
		self._selectAttrs[i] = false
		self._selectCharTypes[i] = false
	end

	self.filterDropExtend = DropDownExtend.Get(self._dropfilter.gameObject)

	self.filterDropExtend:init(self.onFilterDropShow, self.onFilterDropHide, self)
	self:initOptions()
	self:_refreshView()
	self:_refreshClassifyBtnStateView(false)
	CharacterBackpackCardListModel.instance:updateModel()
	self:_updateHeroList()
	self:_refreshRankMode()
end

function SettingsRoleVoiceSearchFilterView:onClose()
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(nil)
end

function SettingsRoleVoiceSearchFilterView:onDestroyView()
	for i = 1, #self._attrBtnClicks do
		self._attrBtnClicks[i]:RemoveClickListener()
		self._charTypeBtnClicks[i]:RemoveClickListener()
	end
end

function SettingsRoleVoiceSearchFilterView:_onCharVoiceTypeChanged()
	return
end

function SettingsRoleVoiceSearchFilterView:_refreshView(selectAttrs, selectCharTypes)
	selectAttrs = selectAttrs or self._selectAttrs
	selectCharTypes = selectCharTypes or self._selectCharTypes

	for i = 1, 6 do
		gohelper.setActive(self._attrUnselects[i], not selectAttrs[i])
		gohelper.setActive(self._attrSelects[i], selectAttrs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._charTypeUnselects[i], not selectCharTypes[i])
		gohelper.setActive(self._charTypeSelects[i], selectCharTypes[i])
	end
end

function SettingsRoleVoiceSearchFilterView:_refreshRankMode()
	local state = CharacterModel.instance:getRankState()
	local rankTag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.CharVoiceSetting)
	local rareTag = 2
	local trustTag = 3

	gohelper.setActive(self._golvrankSelected, rankTag == rareTag)
	gohelper.setActive(self._golvrankUnSelected, rankTag ~= rareTag)
	gohelper.setActive(self._gotrustrankSelected, rankTag == trustTag)
	gohelper.setActive(self._gotrustrankUnSelected, rankTag ~= trustTag)
	transformhelper.setLocalScale(self._transrareArrow, 1, state[2], 1)
	transformhelper.setLocalScale(self._transfaithArrow, 1, state[3], 1)
end

function SettingsRoleVoiceSearchFilterView:_refreshClassifyBtnStateView(selected)
	local hasFilter = self:_checkHasFilter()

	gohelper.setActive(self._goclassifyUnSelected, not hasFilter)
	gohelper.setActive(self._goclassifySelected, hasFilter)
	gohelper.setActive(self._gosearchfilter, selected)
end

function SettingsRoleVoiceSearchFilterView:_updateHeroList()
	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			careers[#careers + 1] = i
		end
	end

	local charTypes = {}

	for i = 1, 6 do
		if self._selectCharTypes[i] then
			charTypes[#charTypes + 1] = i
		end
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

	if #charTypes == 0 then
		charTypes = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local filterParam = {}

	filterParam.careers = careers
	filterParam.charTypes = charTypes
	filterParam.charLang = self._filterLang

	CharacterModel.instance:filterCardListByCareerAndCharType(filterParam, false, CharacterEnum.FilterType.CharVoiceSetting)
end

function SettingsRoleVoiceSearchFilterView:initOptions()
	self._languageOptions = {
		0,
		LangSettings.en,
		LangSettings.zh,
		LangSettings.kr,
		LangSettings.jp
	}

	recthelper.setHeight(self._dropfilterTemplateTrans, #self._languageOptions * 70)

	self._optionsName = {}

	for idx, languageId in ipairs(self._languageOptions) do
		self._optionsName[#self._optionsName + 1] = luaLang(languageId == 0 and "all_language_filter_option" or LangSettings.shortcutTab[languageId])
	end

	self._dropfilter:ClearOptions()
	self._dropfilter:AddOptions(self._optionsName)
	gohelper.setActive(self._goarrowup, false)
end

function SettingsRoleVoiceSearchFilterView:_checkHasFilter()
	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			careers[#careers + 1] = i
		end
	end

	local charTypes = {}

	for i = 1, 6 do
		if self._selectCharTypes[i] then
			charTypes[#charTypes + 1] = i
		end
	end

	return #careers ~= 0 or #charTypes ~= 0
end

return SettingsRoleVoiceSearchFilterView
