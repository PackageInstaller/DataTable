-- chunkname: @modules/logic/achievement/view/AchievementEntryView.lua

module("modules.logic.achievement.view.AchievementEntryView", package.seeall)

local AchievementEntryView = class("AchievementEntryView", BaseView)

function AchievementEntryView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txttotal = gohelper.findChildText(self.viewGO, "go_righttop/Total/#txt_total")
	self._txtlevel1 = gohelper.findChildText(self.viewGO, "go_righttop/Level1/#txt_level1")
	self._txtlevel2 = gohelper.findChildText(self.viewGO, "go_righttop/Level2/#txt_level2")
	self._txtlevel3 = gohelper.findChildText(self.viewGO, "go_righttop/Level3/#txt_level3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementEntryView:addEvents()
	return
end

function AchievementEntryView:removeEvents()
	return
end

function AchievementEntryView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_mainfullbg"))

	self._focusTypes = {
		AchievementEnum.Type.Story,
		AchievementEnum.Type.Normal,
		AchievementEnum.Type.GamePlay,
		AchievementEnum.Type.Activity,
		AchievementEnum.Type.NamePlate
	}
	self._typeItems = {}
end

function AchievementEntryView:onDestroyView()
	AchievementEntryController.instance:onCloseView()

	for _, item in pairs(self._typeItems) do
		item.btnself:RemoveClickListener()

		if item.simageicon then
			item.simageicon:UnLoadImage()
		end
	end

	self._simagebg:UnLoadImage()
end

function AchievementEntryView:onOpen()
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, self.refreshCategoryItems, self)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievementState, self.updateAchievementState, self)
	AchievementEntryController.instance:onOpenView()
	self:refreshUI()
end

function AchievementEntryView:updateAchievementState()
	AchievementEntryController.instance:updateAchievementState()
	self:refreshUI()
end

function AchievementEntryView:onClose()
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, self.refreshCategoryItems, self)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievementState, self.updateAchievementState, self)
end

function AchievementEntryView:refreshUI()
	self:refreshCategoryItems()
	self:refreshLevelCollect()
end

AchievementEntryView.LevelNum = 3

function AchievementEntryView:refreshLevelCollect()
	self._txttotal.text = tostring(AchievementEntryModel.instance:getTotalFinishedCount())

	for level = 1, AchievementEntryView.LevelNum do
		local finishCount = AchievementEntryModel.instance:getLevelCount(level)

		self["_txtlevel" .. tostring(level)].text = string.format("%s", finishCount)
	end
end

function AchievementEntryView:refreshCategoryItems()
	for index, achieveType in ipairs(self._focusTypes) do
		self:refreshCategoryItem(index, achieveType)
	end
end

function AchievementEntryView:refreshCategoryItem(index, achieveType)
	local item = self:getOrCreateCategory(index, achieveType)
	local cur, max = AchievementEntryModel.instance:getFinishCount(achieveType)

	if achieveType ~= AchievementEnum.Type.NamePlate then
		item.txtname.text = luaLang("achievemententryview_type_" .. achieveType)

		item.simageicon:LoadImage(ResUrl.getAchievementIcon("achievement_mainitem" .. index))
	end

	item.txtprogress.text = string.format("<color=#c9c9c9><size=56>%s</size><size=40>/</size></color>%s", cur, max)
end

function AchievementEntryView:getOrCreateCategory(index, achieveType)
	local item = self._typeItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.achieveType = achieveType

		if item.achieveType ~= AchievementEnum.Type.NamePlate then
			item.go = gohelper.findChild(self.viewGO, "go_books/#go_item" .. tostring(index))
			item.txtprogress = gohelper.findChildText(item.go, "#txt_progress")
			item.txtname = gohelper.findChildText(item.go, "#txt_name")
			item.btnself = gohelper.findChildButtonWithAudio(item.go, "#btn_self")

			item.btnself:AddClickListener(self.onClickCategory, self, index)

			local goreddot = gohelper.findChild(item.go, "go_reddot")

			item.reddot = RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.AchievementFinish, self._focusTypes[index])
			item.simageicon = gohelper.findChildSingleImage(item.go, "#btn_self")
		else
			item.go = gohelper.findChild(self.viewGO, "#go_misihai_entrance")
			item.txtprogress = gohelper.findChildText(item.go, "#txt_progress")
			item.txtname = gohelper.findChildText(item.go, "#txt_name")
			item.btnself = gohelper.findChildButtonWithAudio(item.go, "image_misihai_entrance")

			item.btnself:AddClickListener(self.onClickCategory, self, index)
		end

		self._typeItems[index] = item
	end

	return item
end

function AchievementEntryView:onClickCategory(index)
	local categoryType = self._focusTypes[index]

	AchievementController.instance:openAchievementMainView(categoryType)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
end

return AchievementEntryView
