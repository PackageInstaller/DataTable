-- chunkname: @modules/logic/necrologiststory/game/v3a8/V3A8_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a8.V3A8_RoleStoryGameView", package.seeall)

local V3A8_RoleStoryGameView = class("V3A8_RoleStoryGameView", BaseView)

function V3A8_RoleStoryGameView:onInitView()
	self.goMiddle = gohelper.findChild(self.viewGO, "Middle")
	self.animMiddle = gohelper.findComponentAnim(self.goMiddle)
	self.goChapter = gohelper.findChild(self.viewGO, "Middle/#go_chapter")
	self.goRefresh = gohelper.findChild(self.viewGO, "Middle/#go_chapter/vx_refresh")
	self.refreshAnimEvent = gohelper.findChildComponent(self.viewGO, "Middle/#go_chapter/vx_refresh", typeof(ZProj.AnimationEventWrap))
	self.txtChapterName = gohelper.findChildTextMesh(self.viewGO, "Middle/#go_chapter/#txt_chapterName")
	self.txtCurIndex = gohelper.findChildTextMesh(self.viewGO, "Middle/#go_chapter/#txt_currency")
	self.txtTotal = gohelper.findChildTextMesh(self.viewGO, "Middle/#go_chapter/#txt_total")
	self.imgWeather = gohelper.findChildImage(self.viewGO, "Middle/#go_date/#image_weather")
	self.txtWeather = gohelper.findChildTextMesh(self.viewGO, "Middle/#go_date/#txt_weather")
	self.txtDate = gohelper.findChildText(self.viewGO, "Middle/#go_date/#txt_date")
	self.txtYear = gohelper.findChildText(self.viewGO, "Middle/#go_date/#txt_year")
	self.btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_goto")
	self.goEnd = gohelper.findChild(self.viewGO, "Middle/#go_end")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A8_RoleStoryGameView:addEvents()
	self.addClickCb(self, self.btnStart, self.onClickBtnStart, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.refreshAnimEvent:AddEventListener("refresh", self.onRefreshAnim, self)
end

function V3A8_RoleStoryGameView:removeEvents()
	self:removeClickCb(self.btnStart)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.refreshAnimEvent:RemoveAllEventListener()
end

function V3A8_RoleStoryGameView:_editableInitView()
	return
end

function V3A8_RoleStoryGameView:onClickBtnStart()
	if not self.curPlotConfig then
		return
	end

	NecrologistStoryController.instance:openStoryView(self.curPlotConfig.id, self.curPlotConfig.storyId)
end

function V3A8_RoleStoryGameView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	self:refreshView()
end

function V3A8_RoleStoryGameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_mingdi_gsn_open2)
	self:refreshParam()
	self:refreshView()
end

function V3A8_RoleStoryGameView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A8_RoleStoryGameView:refreshParam()
	if not self.viewParam then
		local viewParam = {}
		local storyId = viewParam.roleStoryId

		self.heroStoryId = storyId

		if storyId then
			self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
		end
	end
end

function V3A8_RoleStoryGameView:refreshData()
	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(self.heroStoryId)

	self.curIndex = 0
	self.totalIndex = #plotList
	self.curPlotConfig = nil
	self.isFinish = true

	for i, config in ipairs(plotList) do
		if not self.gameBaseMO:isStoryFinish(config.id) then
			self.curIndex = i
			self.curPlotConfig = config
			self.isFinish = false

			break
		end
	end

	if self.curPlotConfig == nil then
		self.curPlotConfig = plotList[self.totalIndex]
	end

	self.isChange = self.lastIndex and self.lastIndex ~= self.curIndex
	self.lastIndex = self.curIndex
end

function V3A8_RoleStoryGameView:refreshView()
	self:refreshData()
	self:refreshDate()

	if self.isChange then
		self.animMiddle:Play("open", 0, 0)
		gohelper.setActive(self.goRefresh, false)
		gohelper.setActive(self.goRefresh, true)
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_mingdi_gsn_open2)
	else
		self:refreshChapter()
	end
end

function V3A8_RoleStoryGameView:refreshChapter()
	gohelper.setActive(self.goEnd, self.isFinish)
	gohelper.setActive(self.btnStart, not self.isFinish)
	gohelper.setActive(self.goChapter, not self.isFinish)

	if not self.isFinish then
		self.txtCurIndex.text = string.format("%02d", self.curIndex)
		self.txtTotal.text = string.format("%02d", self.totalIndex)
		self.txtChapterName.text = self.curPlotConfig.storyName
	end
end

function V3A8_RoleStoryGameView:refreshDate()
	local weather = self.curPlotConfig.weather

	NecrologistStoryHelper.setWeatherWihteIcon(self.imgWeather, weather, true)
	NecrologistStoryHelper.setWeatherTxt(self.txtWeather, weather)

	local success, y, m1, d = NecrologistStoryHelper.stringTotimeData(self.curPlotConfig.date)

	if success then
		self.txtDate.text = string.format("%02d.%02d", d, m1)
		self.txtYear.text = y
	else
		self.txtDate.text = ""
		self.txtYear.text = ""
	end
end

function V3A8_RoleStoryGameView:onRefreshAnim()
	self:refreshChapter()
end

function V3A8_RoleStoryGameView:onDestroyView()
	return
end

return V3A8_RoleStoryGameView
