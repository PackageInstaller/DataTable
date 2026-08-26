-- chunkname: @modules/logic/versionactivity3_6/doubledrop/view/V3a6DoubleDropView.lua

module("modules.logic.versionactivity3_6.doubledrop.view.V3a6DoubleDropView", package.seeall)

local V3a6DoubleDropView = class("V3a6DoubleDropView", BaseView)

function V3a6DoubleDropView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "go_time/go_deadline/#txt_time")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "go_desc/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "go_desc/#scroll_desc/Viewport/#txt_desc")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content/go_times")
	self._txttotal = gohelper.findChildText(self.viewGO, "#scroll_view/Viewport/Content/go_times/go_total/#txt_total")
	self._txttotaltimes = gohelper.findChildText(self.viewGO, "#scroll_view/Viewport/Content/go_times/go_total/#txt_totaltimes")
	self._txttoday = gohelper.findChildText(self.viewGO, "#scroll_view/Viewport/Content/go_times/go_today/#txt_today")
	self._txttotalday = gohelper.findChildText(self.viewGO, "#scroll_view/Viewport/Content/go_times/go_today/#txt_totalday")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6DoubleDropView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function V3a6DoubleDropView:removeEvents()
	self._btnjump:RemoveClickListener()
end

function V3a6DoubleDropView:_btnjumpOnClick()
	if self._mo then
		local jumpId = self._mo:getJumpId()

		if self._mo and self._mo > 0 then
			GameFacade.jump(self._mo)
		end
	end
end

function V3a6DoubleDropView:_editableInitView()
	self._points = self:getUserDataTb_()

	for i = 1, 2 do
		self._points[i] = self:getUserDataTb_()

		for j = 1, i do
			self._points[i][j] = gohelper.findChild(self.viewGO, string.format("point/%s/point%s", i, j))
		end
	end

	self._items = self:getUserDataTb_()
	self._items[Activity217Enum.ActType.MultiExp] = gohelper.findChild(self.viewGO, "item_401")
	self._items[Activity217Enum.ActType.MultiCoin] = gohelper.findChild(self.viewGO, "item_501")

	for _, item in pairs(self._items) do
		gohelper.setActive(item, false)
	end

	self._descItems = self:getUserDataTb_()
end

function V3a6DoubleDropView:onUpdateParam()
	self.actId = self.viewParam.actId

	self:refresh()
end

function V3a6DoubleDropView:onOpen()
	StatController.instance:track(StatEnum.EventName.EnterDoubleEquip)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_page_turn)

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.actId = self.viewParam.actId

	self:refresh()
end

local color1 = "#DE9854"
local color2 = "#BF2E11"

function V3a6DoubleDropView:refresh()
	local actId = self.actId

	self._mo = Activity217Model.instance:getActInfoById(actId)
	self._configList = Activity217Config.instance:getControlCos(actId)

	local count = tabletool.len(self._configList)
	local pointList = self._points[count]
	local index = 0

	for _, config in pairs(self._configList) do
		local type = config.type
		local limit = config.limit
		local dailyLimit = config.dailyLimit
		local dayUseTimes = self._mo:getDailyUseCountByType(type)
		local totalUseTimes = self._mo:getTotalUseCountByType(type)
		local totalRemainTime = limit - totalUseTimes
		local dailyRemainTime = dailyLimit - dayUseTimes

		if totalRemainTime < dailyRemainTime and not totalRemainTime then
			-- block empty
		end

		if totalRemainTime > 0 then
			local colorformat1 = string.format("<color=%s>", color1 or color2)

			if dailyRemainTime > 0 then
				local colorformat2 = string.format("<color=%s>", color1 or color2)
				local format = "%s%s</color>/%s"
				local str1 = string.format(format, colorformat1, totalRemainTime, limit)
				local str2 = string.format(format, colorformat2, dailyRemainTime, dailyLimit)

				index = index + 1

				local item = self:_getItem(index)

				item.txttotaltimes.text = str1
				item.txttotalday.text = str2

				local lang = luaLang("v3a6_doubledrop_txt_title")
				local chapterCo = lua_chapter.configDict[Activity217Enum.DungeonChapter[config.showtype]]
				local magnification = (config.magnification - 1) * 100

				item.txttitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, chapterCo.name)

				local lang1 = luaLang("add_percent_value")

				item.txtrate.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang1, magnification)

				local point = pointList[index]
				local item = self._items[config.showtype]

				gohelper.addChild(point, item)
				recthelper.setAnchor(item.transform, 0, 0)
				gohelper.setActive(item, true)
			end
		end
	end

	for i = 1, #self._descItems do
		local item = self._descItems[i]

		gohelper.setActive(item.go, i <= index)
	end

	local actCo = ActivityConfig.instance:getActivityCo(actId)

	if actCo then
		self._txtdesc.text = actCo.actDesc or ""
	end

	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function V3a6DoubleDropView:_getItem(index)
	local item = self._descItems[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			item.go = self._goitem or gohelper.cloneInPlace(self._goitem)
		end

		item.txttotal = gohelper.findChildText(item.go, "go_total/#txt_total")
		item.txttotaltimes = gohelper.findChildText(item.go, "go_total/#txt_totaltimes")
		item.txttoday = gohelper.findChildText(item.go, "go_today/#txt_today")
		item.txttotalday = gohelper.findChildText(item.go, "go_today/#txt_totalday")
		item.txttitle = gohelper.findChildText(item.go, "bg/txt_desc")
		item.txtrate = gohelper.findChildText(item.go, "bg/#txt_rate")
		self._descItems[index] = item
	end

	return item
end

function V3a6DoubleDropView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")
end

function V3a6DoubleDropView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function V3a6DoubleDropView:onDestroyView()
	return
end

return V3a6DoubleDropView
