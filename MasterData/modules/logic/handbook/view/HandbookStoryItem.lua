-- chunkname: @modules/logic/handbook/view/HandbookStoryItem.lua

module("modules.logic.handbook.view.HandbookStoryItem", package.seeall)

local HandbookStoryItem = class("HandbookStoryItem", ListScrollCellExtend)

function HandbookStoryItem:onInitView()
	self._golinedown = gohelper.findChild(self.viewGO, "#go_layout/#go_linedown")
	self._golineup = gohelper.findChild(self.viewGO, "#go_layout/#go_lineup")
	self._golayout = gohelper.findChild(self.viewGO, "#go_layout")
	self._gofragmentinfolist = gohelper.findChild(self.viewGO, "#go_layout/#go_fragmentinfolist")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "")
	self._txtstorynamecn = gohelper.findChildText(self.viewGO, "#go_layout/basic/#txt_storynamecn")
	self._txtstorynameen = gohelper.findChildText(self.viewGO, "#go_layout/basic/#txt_storynameen")
	self._simagestoryicon = gohelper.findChildSingleImage(self.viewGO, "#go_layout/basic/mask/#simage_storyicon")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_layout/basic/#txt_time")
	self._txtdate = gohelper.findChildText(self.viewGO, "#go_layout/basic/#txt_date")
	self._gomessycode = gohelper.findChild(self.viewGO, "#go_layout/basic/#go_messycode")
	self._txtyear = gohelper.findChildText(self.viewGO, "#go_year/#txt_year")
	self._txtyearmessycode = gohelper.findChildText(self.viewGO, "#go_year/#txt_yearmessycode")
	self._txtid = gohelper.findChildText(self.viewGO, "#go_layout/basic/#txt_id")
	self._gofragmentitem = gohelper.findChild(self.viewGO, "#go_layout/#go_fragmentinfolist/#go_fragmentitem")
	self._goyear = gohelper.findChild(self.viewGO, "#go_year")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookStoryItem:addEvents()
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
end

function HandbookStoryItem:removeEvents()
	self._btnplay:RemoveClickListener()
end

function HandbookStoryItem:_btnplayOnClick()
	if not string.nilorempty(self._config.storyIdList) then
		local storyList = string.splitToNumber(self._config.storyIdList, "#")
		local levelIdDict = {}

		if not string.nilorempty(self._config.levelIdDict) then
			local levelIdPairs = string.split(self._config.levelIdDict, "|")

			for _, levelIdPair in ipairs(levelIdPairs) do
				local levelIdParam = string.splitToNumber(levelIdPair, "#")

				levelIdDict[levelIdParam[1]] = levelIdParam[2]
			end
		end

		local data = {}

		data.levelIdDict = levelIdDict
		data.isReplay = true

		local extendStory = DungeonConfig.instance:getExtendStory(self._config.episodeId)

		if extendStory then
			table.insert(storyList, extendStory)
		end

		StoryController.instance:playStories(storyList, data)
	end
end

function HandbookStoryItem:_editableInitView()
	gohelper.setActive(self._gofragmentitem, false)

	self._fragmentItemList = self._fragmentItemList or {}

	gohelper.addUIClickAudio(self._btnplay.gameObject, AudioEnum.UI.play_ui_screenplay_plot_playback)
end

function HandbookStoryItem:_refreshUI()
	self:_setUpDown()

	self._txtstorynamecn.text = self._config.name
	self._txtstorynameen.text = self._config.nameEn
	self._txttime.text = self._config.time
	self._txtdate.text = self._config.date

	gohelper.setActive(self._txttime.gameObject, not string.nilorempty(self._config.time))
	gohelper.setActive(self._txtdate.gameObject, not string.nilorempty(self._config.date))
	gohelper.setActive(self._gomessycode, string.nilorempty(self._config.time))

	local yearIsNum = GameUtil.utf8isnum(self._config.year)

	gohelper.setActive(self._goyear, not string.nilorempty(self._config.year))
	gohelper.setActive(self._txtyear.gameObject, yearIsNum)
	gohelper.setActive(self._txtyearmessycode.gameObject, not yearIsNum)

	if yearIsNum then
		self._txtyear.text = self._config.year or ""
	end

	self._txtyearmessycode.text = yearIsNum and "" or self._config.year

	self._simagestoryicon:LoadImage(ResUrl.getStorySmallBg(self._config.image))

	self._txtid.text = self._mo.index > 9 and tostring(self._mo.index) or "0" .. tostring(self._mo.index)

	self:_refreshFragment()
end

function HandbookStoryItem:_setUpDown()
	local isUp = self._mo.index % 2 ~= 0

	if isUp then
		recthelper.setAnchorY(self._golayout.transform, 0)

		self._golayout.transform.pivot = Vector2(0.5, 0)

		gohelper.setAsLastSibling(self._gofragmentinfolist)
	else
		recthelper.setAnchorY(self._golayout.transform, -72)

		self._golayout.transform.pivot = Vector2(0.5, 1)

		gohelper.setAsFirstSibling(self._gofragmentinfolist)
	end

	gohelper.setActive(self._golineup, isUp)
	gohelper.setActive(self._golinedown, not isUp)
end

function HandbookStoryItem:_refreshFragment()
	local fragmentIdList = {}

	if not string.nilorempty(self._config.fragmentIdList) then
		fragmentIdList = string.splitToNumber(self._config.fragmentIdList, "#")
	end

	for i, fragmentId in ipairs(fragmentIdList) do
		local fragmentItem = self._fragmentItemList[i]

		if not fragmentItem then
			fragmentItem = {
				go = gohelper.cloneInPlace(self._gofragmentitem, "item" .. i)
			}
			fragmentItem.txtinfo = gohelper.findChildText(fragmentItem.go, "info")
			fragmentItem.btnclick = gohelper.findChildButtonWithAudio(fragmentItem.go, "info/btnclick")

			fragmentItem.btnclick:AddClickListener(self._btnclickOnClick, self, fragmentItem)
			table.insert(self._fragmentItemList, fragmentItem)
		end

		local fragmentConfig = lua_chapter_map_fragment.configDict[fragmentId]

		fragmentItem.fragmentId = fragmentId
		fragmentItem.dialogIdList = HandbookModel.instance:getFragmentDialogIdList(fragmentId)
		fragmentItem.txtinfo.text = fragmentItem.dialogIdList and fragmentConfig.title or "???"

		gohelper.setActive(fragmentItem.go, true)
	end

	for i = #fragmentIdList + 1, #self._fragmentItemList do
		local fragmentItem = self._fragmentItemList[i]

		gohelper.setActive(fragmentItem.go, false)
	end
end

function HandbookStoryItem:_btnclickOnClick(fragmentItem)
	if fragmentItem.dialogIdList then
		local fragmentId = fragmentItem.fragmentId
		local fragmentType = lua_chapter_map_fragment.configDict[fragmentId].type

		if fragmentType == DungeonEnum.FragmentType.AvgStory then
			local elementCo = DungeonConfig.instance:getMapElementByFragmentId(fragmentId)
			local storyId = tonumber(elementCo.param)

			StoryController.instance:playStory(storyId)
		else
			local data = {}

			data.fragmentId = fragmentId
			data.dialogIdList = fragmentItem.dialogIdList
			data.isFromHandbook = true

			ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, data)
		end
	else
		GameFacade.showToast(ToastEnum.HandBook2)
	end
end

function HandbookStoryItem:onUpdateMO(mo)
	self._mo = mo
	self._config = HandbookConfig.instance:getStoryGroupConfig(self._mo.storyGroupId)

	self:_refreshUI()
end

function HandbookStoryItem:getAnimator()
	return self._anim
end

function HandbookStoryItem:onDestroy()
	self._simagestoryicon:UnLoadImage()

	for i, fragmentItem in ipairs(self._fragmentItemList) do
		fragmentItem.btnclick:RemoveClickListener()
	end
end

return HandbookStoryItem
