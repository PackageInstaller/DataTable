-- chunkname: @modules/logic/achievement/view/AchievementSelectView.lua

module("modules.logic.achievement.view.AchievementSelectView", package.seeall)

local AchievementSelectView = class("AchievementSelectView", BaseView)

function AchievementSelectView:onInitView()
	self._gocategoryitem = gohelper.findChild(self.viewGO, "#scroll_category/categorycontent/#go_categoryitem")
	self._goselectgroup = gohelper.findChild(self.viewGO, "#go_lefttop/#go_selectgroup")
	self._goselectsingle = gohelper.findChild(self.viewGO, "#go_lefttop/#go_selectsingle")
	self._gounselectgroup = gohelper.findChild(self.viewGO, "#go_lefttop/#go_unselectgroup")
	self._gounselectsingle = gohelper.findChild(self.viewGO, "#go_lefttop/#go_unselectsingle")
	self._btnswitchgroup = gohelper.findChildButtonWithAudio(self.viewGO, "#go_lefttop/#btn_switchgroup")
	self._btnsave = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_save")
	self._txtselectnum = gohelper.findChildText(self.viewGO, "#btn_save/#txt_selectnum")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._btnclear = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_clear")
	self._goempty = gohelper.findChild(self.viewGO, "#go_container/#go_empty")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_container/#scroll_content")
	self._goscrollnameplate = gohelper.findChild(self.viewGO, "#go_container/#scroll_content_misihai")
	self._goempty = gohelper.findChild(self.viewGO, "#go_container/#go_empty")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simageBottomBG = gohelper.findChildSingleImage(self.viewGO, "#simage_BottomBG")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementSelectView:addEvents()
	self._btnswitchgroup:AddClickListener(self._btnswitchgroupOnClick, self)
	self._btnsave:AddClickListener(self._btnsaveOnClick, self)
	self._btnclear:AddClickListener(self._btnclearOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function AchievementSelectView:removeEvents()
	self._btnswitchgroup:RemoveClickListener()
	self._btnsave:RemoveClickListener()
	self._btnclear:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function AchievementSelectView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_editfullbg"))
	self._simageBottomBG:LoadImage(ResUrl.getAchievementIcon("achievement_editbottombg"))
	self:initCategory()
end

function AchievementSelectView:onDestroyView()
	if self._categoryItems then
		for _, item in pairs(self._categoryItems) do
			item.btnself:RemoveClickListener()
		end

		self._categoryItems = nil
	end

	self._simagebg:UnLoadImage()
	self._simageBottomBG:UnLoadImage()
	AchievementSelectController.instance:onCloseView()
end

function AchievementSelectView:onOpen()
	if self.viewParam then
		self.isPlayerCard = self.viewParam.isPlayerCard
	end

	local isGroup = AchievementSelectController.instance:isCurrentShowGroupInPlayerView()

	if isGroup then
		if not self._focusTypes[4] then
			local focusType = self._focusTypes[1]

			AchievementSelectController.instance:onOpenView(focusType)
			self.addEventCb(self, AchievementSelectController.instance, AchievementEvent.SelectViewUpdated, self.refreshUI, self)

			for index, categoryType in pairs(self._focusTypes) do
				local categorySelectCount = AchievementSelectListModel.instance:getSelectCountByCategory(categoryType)

				if categorySelectCount > 0 and (not self._selectCategory or categoryType < self._selectCategory) then
					self._selectCategory = categoryType
				end
			end

			if not self._selectCategory then
				AchievementSelectController.instance:setCategory(self._selectCategory)
				self:refreshUI()
			end
		end
	end
end

function AchievementSelectView:onClose()
	return
end

function AchievementSelectView:refreshUI()
	local isGroup = AchievementSelectListModel.instance.isGroup
	local count = AchievementSelectListModel.instance:getCount()
	local selectCount = AchievementSelectListModel.instance:getSelectCount()
	local isNamePlate = AchievementSelectListModel.instance:checkIsNamePlate()
	local isEmpty = count <= 0

	gohelper.setActive(self._goselectgroup, isGroup)
	gohelper.setActive(self._gounselectsingle, isGroup)
	gohelper.setActive(self._goselectsingle, not isGroup)
	gohelper.setActive(self._gounselectgroup, not isGroup)
	gohelper.setActive(self._golefttop, not isNamePlate)
	gohelper.setActive(self._goempty, isEmpty)
	gohelper.setActive(self._goscrollcontent, not isEmpty and not isNamePlate)
	gohelper.setActive(self._goscrollnameplate, not isEmpty and isNamePlate)
	gohelper.setActive(self._btnclear.gameObject, selectCount > 0)

	if isNamePlate then
		local tag = {
			AchievementSelectListModel.instance:getGroupSelectedCount(),
			AchievementEnum.ShowMaxNamePlateCount
		}

		self._txtselectnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementselectview_selectsingle"), tag)
	elseif isGroup then
		local tag = {
			AchievementSelectListModel.instance:getGroupSelectedCount(),
			AchievementEnum.ShowMaxGroupCount
		}

		self._txtselectnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementselectview_selectgroup"), tag)
	else
		local tag = {
			AchievementSelectListModel.instance:getSingleSelectedCount(),
			AchievementEnum.ShowMaxSingleCount
		}

		self._txtselectnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementselectview_selectsingle"), tag)
	end

	self:refreshCategory()
end

function AchievementSelectView:refreshCategory()
	local curCategory = AchievementSelectListModel.instance:getCurrentCategory()

	for index, item in pairs(self._categoryItems) do
		local isSelected = curCategory == self._focusTypes[index]

		gohelper.setActive(item.goselected, isSelected)
		gohelper.setActive(item.gounselected, not isSelected)

		local categorySelectCount = AchievementSelectListModel.instance:getSelectCountByCategory(self._focusTypes[index])

		gohelper.setActive(item.goreddot, categorySelectCount > 0)

		item.txtselectcount.text = categorySelectCount
	end
end

function AchievementSelectView:initCategory()
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
		item.goreddot = gohelper.findChild(item.go, "go_reddot")
		item.txtselectcount = gohelper.findChildText(item.go, "go_reddot/txt_reddot")
		item.btnself = gohelper.findChildButtonWithAudio(item.go, "btn_self")

		item.btnself:AddClickListener(self.onClickCategory, self, index)

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

function AchievementSelectView:onClickCategory(index)
	local curCategory = AchievementSelectListModel.instance:getCurrentCategory()
	local category = self._focusTypes[index]

	if curCategory == category then
		return
	end

	self.viewContainer._scrollView._csMixScroll:ResetScrollPos()
	AchievementSelectListModel.instance:setItemAniHasShownIndex(0)
	AchievementSelectController.instance:setCategory(category)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
end

function AchievementSelectView:_btnswitchgroupOnClick()
	self.viewContainer._scrollView._csMixScroll:ResetScrollPos()
	AchievementSelectListModel.instance:setItemAniHasShownIndex(0)
	AchievementSelectController.instance:switchGroup()
end

function AchievementSelectView:_btnsaveOnClick()
	if self.isPlayerCard then
		PlayerCardController.instance:saveAchievement()
	else
		AchievementSelectController.instance:sendSave()
	end

	self:closeThis()
end

function AchievementSelectView:_btnclearOnClick()
	AchievementSelectController.instance:clearAllSelect()
end

function AchievementSelectView:_btncancelOnClick()
	AchievementSelectController.instance:popUpMessageBoxIfNeedSave(self._jump2AchievementMainView, nil, self._jump2AchievementMainView, self, nil, self)
end

function AchievementSelectView:_jump2AchievementMainView()
	AchievementSelectController.instance:resumeToOriginSelect()

	local curCategory = AchievementSelectListModel.instance:getCurrentCategory()

	ViewMgr.instance:openView(ViewName.AchievementMainView, {
		selectType = curCategory,
		jumpFrom = ViewName.AchievementSelectView
	})
	self:closeThis()
end

return AchievementSelectView
