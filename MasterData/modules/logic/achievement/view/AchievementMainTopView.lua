-- chunkname: @modules/logic/achievement/view/AchievementMainTopView.lua

module("modules.logic.achievement.view.AchievementMainTopView", package.seeall)

local AchievementMainTopView = class("AchievementMainTopView", BaseView)

function AchievementMainTopView:onInitView()
	self._btnView = gohelper.findChildButtonWithAudio(self.viewGO, "Title/Btns/#btn_View")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_content")
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_list")
	self._scrollnameplate = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_content_misihai")
	self._golist = gohelper.findChild(self.viewGO, "Title/Btns/#btn_View/#go_On")
	self._gotile = gohelper.findChild(self.viewGO, "Title/Btns/#btn_View/#go_Off")
	self._dropfilter = gohelper.findChildDropdown(self.viewGO, "Title/Btns/#drop_Fliter")
	self._goarrowup = gohelper.findChild(self.viewGO, "Title/Btns/#drop_Fliter/#go_arrowup")
	self._goarrowdown = gohelper.findChild(self.viewGO, "Title/Btns/#drop_Fliter/#go_arrowdown")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementMainTopView:addEvents()
	self._btnView:AddClickListener(self._btnviewOnClick, self)
	self._dropfilter:AddOnValueChanged(self._onDropFilterValueChanged, self)
	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnSwitchCategory, self.onSwitchCategory, self)
end

function AchievementMainTopView:removeEvents()
	self._btnView:RemoveClickListener()
	self._dropfilter:RemoveOnValueChanged()
	self.removeEventCb(self, AchievementMainController.instance, AchievementEvent.OnSwitchCategory, self.onSwitchCategory, self)
end

function AchievementMainTopView:_editableInitView()
	self.filterDropExtend = DropDownExtend.Get(self._dropfilter.gameObject)

	self.filterDropExtend:init(self.onFilterDropShow, self.onFilterDropHide, self)
	self:initSearchFilterBtns()
end

function AchievementMainTopView:onDestroyView()
	TaskDispatcher.cancelTask(self._onAchievementListItemOpenAnimPlayFinished, self)
end

function AchievementMainTopView:onOpen()
	self:refreshUI()
end

function AchievementMainTopView:refreshUI()
	local curViewType = AchievementMainCommonModel.instance:getCurrentViewType()

	self:refreshViewTypeBtns(curViewType)
	self:refreshScrollVisible(curViewType)
	self:refreshFilterDropDownArrow()
end

function AchievementMainTopView:_btnviewOnClick()
	local curViewType = AchievementMainCommonModel.instance:getCurrentViewType()

	if curViewType == AchievementEnum.ViewType.List then
		if not AchievementEnum.ViewType.Tile then
			local targetViewType = AchievementEnum.ViewType.List

			self:refreshViewTypeBtns(targetViewType)
			self:refreshScrollVisible(targetViewType)

			local isList = curViewType == AchievementEnum.ViewType.List

			AchievementMainListModel.instance:setNamePlateShowList(isList)

			if targetViewType == AchievementEnum.ViewType.List then
				AchievementMainListModel.instance:setIsCurTaskNeedPlayIdleAnim(false)
				UIBlockMgrExtend.setNeedCircleMv(false)
				UIBlockMgr.instance:startBlock("AchievementMainFocusView_openAnim")
				TaskDispatcher.cancelTask(self._onAchievementListItemOpenAnimPlayFinished, self)
				TaskDispatcher.runDelay(self._onAchievementListItemOpenAnimPlayFinished, self, 0.6)
			end

			AchievementMainController.instance:switchViewType(targetViewType)
		end
	end
end

function AchievementMainTopView:_onAchievementListItemOpenAnimPlayFinished()
	AchievementMainListModel.instance:setIsCurTaskNeedPlayIdleAnim(true)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainFocusView_openAnim")
end

function AchievementMainTopView:_onClickDropFilter()
	self._isPopUpFilterList = not self._isPopUpFilterList

	self:refreshFilterDropDownArrow()
end

function AchievementMainTopView:onFilterDropShow()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	self._isPopUpFilterList = true

	self:refreshFilterDropDownArrow()
end

function AchievementMainTopView:onFilterDropHide()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	self._isPopUpFilterList = false

	self:refreshFilterDropDownArrow()
end

function AchievementMainTopView:refreshFilterDropDownArrow()
	gohelper.setActive(self._goarrowdown, not self._isPopUpFilterList)
	gohelper.setActive(self._goarrowup, self._isPopUpFilterList)
end

function AchievementMainTopView:refreshViewTypeBtns(viewType)
	gohelper.setActive(self._golist, viewType == AchievementEnum.ViewType.List)
	gohelper.setActive(self._gotile, viewType == AchievementEnum.ViewType.Tile)
end

function AchievementMainTopView:refreshScrollVisible(viewType)
	local curCategory = AchievementMainCommonModel.instance:getCurrentCategory()

	if curCategory == AchievementEnum.Type.NamePlate and viewType == AchievementEnum.ViewType.Tile then
		gohelper.setActive(self._scrolllist.gameObject, false)
		gohelper.setActive(self._scrollcontent.gameObject, false)
		gohelper.setActive(self._scrollnameplate.gameObject, true)
	else
		gohelper.setActive(self._scrolllist.gameObject, viewType == AchievementEnum.ViewType.List)
		gohelper.setActive(self._scrollcontent.gameObject, viewType == AchievementEnum.ViewType.Tile)
		gohelper.setActive(self._scrollnameplate.gameObject, false)
	end
end

function AchievementMainTopView:onSwitchCategory()
	local curViewType = AchievementMainCommonModel.instance:getCurrentViewType()

	self:refreshScrollVisible(curViewType)
end

function AchievementMainTopView:_onDropFilterValueChanged(index)
	index = index + 1

	if self._filterTypeList then
		AchievementMainController.instance:switchSearchFilterType(self._filterTypeList)
	end
end

function AchievementMainTopView:initSearchFilterBtns()
	self._filterTypeList = {
		AchievementEnum.SearchFilterType.All,
		AchievementEnum.SearchFilterType.Locked,
		AchievementEnum.SearchFilterType.Unlocked
	}

	local searchFilterName = {}

	for _, filterType in ipairs(self._filterTypeList) do
		local filterTypeNameLangId = AchievementEnum.FilterTypeName[filterType]
		local filterTypeName = luaLang(filterTypeNameLangId)

		table.insert(searchFilterName, filterTypeName)
	end

	self._dropfilter:AddOptions(searchFilterName)
end

return AchievementMainTopView
