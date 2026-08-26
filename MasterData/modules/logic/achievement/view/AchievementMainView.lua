-- chunkname: @modules/logic/achievement/view/AchievementMainView.lua

module("modules.logic.achievement.view.AchievementMainView", package.seeall)

local AchievementMainView = class("AchievementMainView", BaseView)

function AchievementMainView:onInitView()
	self._gocategoryitem = gohelper.findChild(self.viewGO, "#scroll_category/categorycontent/#go_categoryitem")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageBottomBG = gohelper.findChildSingleImage(self.viewGO, "#simage_BottomBG")
	self._btnedit = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/Edit/#btn_edit")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_groupTips/image_TipsBG/#txt_Descr")
	self._btnswitchscrolltype = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_switchscrolltype")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_content")
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_list")
	self._btnrare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_sort/#btn_rare")
	self._btnunlocktime = gohelper.findChildButtonWithAudio(self.viewGO, "#go_sort/#btn_unlocktime")
	self._txtunlockcount = gohelper.findChildText(self.viewGO, "Bottom/UnLockCount/image_UnLockBG/#txt_unlockcount")
	self._goempty = gohelper.findChild(self.viewGO, "#go_container/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementMainView:addEvents()
	self._btnedit:AddClickListener(self._btneditOnClick, self)
end

function AchievementMainView:removeEvents()
	self._btnedit:RemoveClickListener()
end

function AchievementMainView:_editableInitView()
	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.AchievementMainViewUpdate, self.refreshUI, self)
	self.addEventCb(self, AchievementController.instance, AchievementEvent.UpdateAchievementState, self.updateAchievementState, self)
	self._simageFullBG:LoadImage(ResUrl.getAchievementIcon("achievement_editfullbg"))
	self._simageBottomBG:LoadImage(ResUrl.getAchievementIcon("achievement_editbottombg"))
	self:initCategory()
end

function AchievementMainView:onDestroyView()
	if self._categoryItems then
		for _, item in pairs(self._categoryItems) do
			item.btnself:RemoveClickListener()
		end

		self._categoryItems = nil
	end

	self._simageFullBG:UnLoadImage()
	self._simageBottomBG:UnLoadImage()
	AchievementMainController.instance:onCloseView()
end

function AchievementMainView:onOpen()
	if self.viewParam then
		if self.viewParam then
			local viewType = self.viewParam.viewType

			if self.viewParam then
				local sortType = self.viewParam.sortType

				if self.viewParam then
					local filterType = self.viewParam.filterType

					if self.viewParam then
						local focusDataId = self.viewParam.focusDataId

						if self.viewParam then
							local achievementType = self.viewParam.achievementType

							if self.viewParam then
								local isOpenLevelView = self.viewParam.isOpenLevelView

								AchievementMainController.instance:onOpenView(self.viewParam, viewType, sortType, filterType)

								if isOpenLevelView and focusDataId and achievementType == AchievementEnum.AchievementType.Single then
									AchievementController.instance:openAchievementLevelView(focusDataId)
								end

								self:refreshUI()
							end
						end
					end
				end
			end
		end
	end
end

function AchievementMainView:updateAchievementState()
	AchievementMainController.instance:updateAchievementState()
	self:refreshUI()
end

function AchievementMainView:onClose()
	self.removeEventCb(self, AchievementMainController.instance, AchievementEvent.AchievementMainViewUpdate, self.refreshUI, self)
	self.removeEventCb(self, AchievementController.instance, AchievementEvent.UpdateAchievementState, self.updateAchievementState, self)
end

function AchievementMainView:refreshUI()
	self:refreshCategory()
	self:refreshUnlockCount()
	self:refreshEmptyUI()
end

function AchievementMainView:refreshCategory()
	local curCategory = AchievementMainCommonModel.instance:getCurrentCategory()

	for index, item in pairs(self._categoryItems) do
		local isSelected = curCategory == self._focusTypes[index]

		gohelper.setActive(item.goselected, isSelected)
		gohelper.setActive(item.gounselected, not isSelected)

		local hasNew = AchievementMainCommonModel.instance:categoryHasNew(self._focusTypes[index])

		gohelper.setActive(item.goreddot1, hasNew)
		gohelper.setActive(item.goreddot2, hasNew)
	end
end

function AchievementMainView:refreshUnlockCount()
	local curCategory = AchievementMainCommonModel.instance:getCurrentCategory()
	local totalAchievementCount, unlockAchievementCount = AchievementMainCommonModel.instance:getCategoryAchievementUnlockInfo(curCategory)
	local tag = {
		unlockAchievementCount,
		totalAchievementCount
	}

	self._txtunlockcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockTaskCount"), tag)
end

function AchievementMainView:refreshEmptyUI()
	local isEmpty = AchievementMainCommonModel.instance:isCurrentViewBagEmpty()

	gohelper.setActive(self._goempty, isEmpty)
end

function AchievementMainView:initCategory()
	self._focusTypes = {
		AchievementEnum.Type.Story,
		AchievementEnum.Type.Normal,
		AchievementEnum.Type.GamePlay,
		AchievementEnum.Type.Activity,
		AchievementEnum.Type.NamePlate
	}
	self._categoryItems = {}

	for index, categoryType in pairs(self._focusTypes) do
		local item = self:getUserDataTb_()

		item.go = gohelper.cloneInPlace(self._gocategoryitem, "category_" .. tostring(index))

		gohelper.setActive(item.go, true)

		item.gounselected = gohelper.findChild(item.go, "go_unselected")
		item.txtitemcn1 = gohelper.findChildText(item.go, "go_unselected/txt_itemcn1")
		item.txtitemen1 = gohelper.findChildText(item.go, "go_unselected/txt_itemen1")
		item.goselected = gohelper.findChild(item.go, "go_selected")
		item.txtitemcn2 = gohelper.findChildText(item.go, "go_selected/txt_itemcn2")
		item.txtitemen2 = gohelper.findChildText(item.go, "go_selected/txt_itemen2")
		item.btnself = gohelper.findChildButtonWithAudio(item.go, "btn_self")

		item.btnself:AddClickListener(self.onClickCategory, self, index)

		item.goreddot1 = gohelper.findChild(item.go, "go_unselected/txt_itemcn1/#go_reddot1")
		item.goreddot2 = gohelper.findChild(item.go, "go_selected/txt_itemcn2/#go_reddot2")

		local nameId = AchievementEnum.TypeName[categoryType]
		local nameEn = AchievementEnum.TypeNameEn[categoryType]

		if not string.nilorempty(nameId) then
			item.txtitemcn1.text = luaLang(nameId)
			item.txtitemcn2.text = luaLang(nameId)
			item.txtitemen1.text = tostring(nameEn)
			item.txtitemen2.text = tostring(nameEn)
		end

		self._categoryItems[index] = item
	end
end

function AchievementMainView:onClickCategory(index)
	local curCategory = AchievementMainCommonModel.instance:getCurrentCategory()
	local category = self._focusTypes[index]

	if curCategory == category then
		return
	end

	AchievementMainController.instance:setCategory(category)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
end

function AchievementMainView:_btneditOnClick()
	ViewMgr.instance:openView(ViewName.AchievementSelectView)

	if self.viewParam.jumpFrom == ViewName.AchievementSelectView then
		self:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_thumbnail_click)
end

return AchievementMainView
