-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EnemyTabList.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EnemyTabList", package.seeall)

local Season123_2_1EnemyTabList = class("Season123_2_1EnemyTabList", BaseView)

function Season123_2_1EnemyTabList:onInitView()
	self._simagebattlelistbg = gohelper.findChildSingleImage(self.viewGO, "go_battlelist/#simage_battlelistbg")
	self._gobattlebtntemplate = gohelper.findChild(self.viewGO, "go_battlelist/scroll_battle/Viewport/battlelist/#go_battlebtntemplate")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1EnemyTabList:_editableInitView()
	self._simagebattlelistbg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))

	self._tabItems = {}
end

function Season123_2_1EnemyTabList:onDestroyView()
	if self._tabItems then
		for _, item in ipairs(self._tabItems) do
			item.btn:RemoveClickListener()
		end

		self._tabItems = nil
	end

	self._simagebattlelistbg:UnLoadImage()
end

function Season123_2_1EnemyTabList:onOpen()
	self.addEventCb(self, Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, self.refreshSelect, self)
	self:refreshUI()
end

function Season123_2_1EnemyTabList:refreshUI()
	self:refreshItems()
	self:refreshSelect()
end

function Season123_2_1EnemyTabList:refreshItems()
	local battleIds = Season123EnemyModel.instance:getBattleIds()

	for i = 1, #battleIds do
		local item = self:getOrCreateTabItem(i)

		item.txt.text = "0" .. tostring(i)

		local starGot = 1

		for index = 1, item.starCount do
			local image = item["imageStar" .. index]

			if image then
				UISpriteSetMgr.instance:setWeekWalkSprite(image, index <= starGot and "star_highlight4" or "star_null4", true)
			end
		end
	end
end

function Season123_2_1EnemyTabList:getOrCreateTabItem(index)
	local item = self._tabItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gobattlebtntemplate)

		item.go = go

		gohelper.setActive(item.go, true)

		item.btn = gohelper.findChildButton(go, "btn")
		item.txt = gohelper.findChildText(go, "txt")
		item.selectIcon = gohelper.findChild(go, "selectIcon")
		item.starGo2 = gohelper.findChild(go, "star2")
		item.starGo3 = gohelper.findChild(go, "star3")
		item.starGo = item.starGo3

		gohelper.setActive(item.starGo2, false)
		gohelper.setActive(item.starGo3, false)
		gohelper.setActive(item.starGo, true)

		local tfStar = item.starGo.transform

		item.starCount = tfStar.childCount

		for index = 1, item.starCount do
			local child = tfStar:GetChild(index - 1)

			item["imageStar" .. index] = child:GetComponentInChildren(gohelper.Type_Image)
		end

		item.btn:AddClickListener(self.onClickTab, self, index)
		gohelper.addUIClickAudio(item.btn.gameObject, AudioEnum.WeekWalk.play_artificial_ui_checkpointswitch)

		self._tabItems[index] = item
	end

	return item
end

function Season123_2_1EnemyTabList:onClickTab(index)
	Season123EnemyController.instance:switchTab(index)
end

function Season123_2_1EnemyTabList:refreshSelect()
	local battleIds = Season123EnemyModel.instance:getBattleIds()

	for i, v in ipairs(battleIds) do
		local item = self:getOrCreateTabItem(i)
		local isSelected = Season123EnemyModel.instance.selectIndex == i

		gohelper.setActive(item.selectIcon, isSelected)

		if isSelected then
			SLFramework.UGUI.GuiHelper.SetColor(item.txt, "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(item.imageStar1, "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(item.imageStar2, "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(item.txt, "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(item.imageStar1, "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(item.imageStar2, "#C1C5B6")
		end

		if item.imageStar3 then
			SLFramework.UGUI.GuiHelper.SetColor(item.imageStar3, isSelected and "#FFFFFF" or "#C1C5B6")
		end
	end
end

return Season123_2_1EnemyTabList
