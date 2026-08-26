-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3PickHeroEntryView.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3PickHeroEntryView", package.seeall)

local Season123_2_3PickHeroEntryView = class("Season123_2_3PickHeroEntryView", BaseView)

function Season123_2_3PickHeroEntryView:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "Right/#go_list/#go_item")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_start/#btn_start")
	self._btndisstart = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_start/#btn_disstart")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnmaincard1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_supercard1/#btn_supercardclick")
	self._btnmaincard2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_supercard2/#btn_supercardclick")
	self._btndetails = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_details")
	self._gorecomment = gohelper.findChild(self.viewGO, "Right/#go_recommend")
	self._gorecommentnone = gohelper.findChild(self.viewGO, "Right/#go_recommend/txt_none")
	self._gorecommentexist = gohelper.findChild(self.viewGO, "Right/#go_recommend/Career")
	self._gocareeritem = gohelper.findChild(self.viewGO, "Right/#go_recommend/Career/career")
	self._gorecommendLine = gohelper.findChild(self.viewGO, "Right/#go_recommend/Line")
	self._gorecommendTagContent = gohelper.findChild(self.viewGO, "Right/#go_recommend/Tag")
	self._gorecommendTagItem = gohelper.findChild(self.viewGO, "Right/#go_recommend/Tag/go_tagItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_3PickHeroEntryView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btndisstart:AddClickListener(self._btnstartOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnmaincard1:AddClickListener(self._btnmaincardOnClick, self, 1)
	self._btnmaincard2:AddClickListener(self._btnmaincardOnClick, self, 2)
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
end

function Season123_2_3PickHeroEntryView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btndisstart:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnmaincard1:RemoveClickListener()
	self._btnmaincard2:RemoveClickListener()
	self._btndetails:RemoveClickListener()
end

function Season123_2_3PickHeroEntryView:_editableInitView()
	self._heroItems = {}
	self._careerItems = {}
end

function Season123_2_3PickHeroEntryView:onDestroyView()
	if self._heroItems then
		for index, item in pairs(self._heroItems) do
			item.component:dispose()
		end

		self._heroItems = nil
	end

	Season123PickHeroEntryController.instance:onCloseView()
end

function Season123_2_3PickHeroEntryView:onOpen()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.PickEntryRefresh, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.EnterStageSuccess, self.handleEnterStageSuccess, self)
	Season123PickHeroEntryController.instance:onOpenView(self.viewParam.actId, self.viewParam.stage)

	local actMO = ActivityModel.instance:getActMO(self.viewParam.actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self:refreshUI()
	gohelper.setActive(self._goitem, false)
end

function Season123_2_3PickHeroEntryView:onClose()
	return
end

function Season123_2_3PickHeroEntryView:refreshUI()
	self:refreshItems()
	self:refreshButton()
	self:refreshRecommendCareer()
	self:refreshRecommendTag()
	self:refreshRecommendUI()
end

function Season123_2_3PickHeroEntryView:refreshButton()
	local count = Season123PickHeroEntryModel.instance:getSelectCount()
	local limitCount = Season123PickHeroEntryModel.instance:getLimitCount()
	local canStart = count > 0

	gohelper.setActive(self._btndisstart, not canStart)
	gohelper.setActive(self._btnstart, canStart)
end

function Season123_2_3PickHeroEntryView:refreshItems()
	local cutHeroList = Season123PickHeroEntryModel.instance:getCutHeroList()

	for index = 1, Activity123Enum.PickHeroCount do
		local item = self:getOrCreateItem(index)

		item.component:refreshUI()

		local isCutHero = cutHeroList and LuaUtil.tableContains(cutHeroList, index)

		item.component:cutHeroAnim(isCutHero)
	end

	Season123PickHeroEntryModel.instance:refeshLastHeroList()
end

function Season123_2_3PickHeroEntryView:getOrCreateItem(index)
	local item = self._heroItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goitem, "item_" .. tostring(index))
		item.component = Season123_2_3PickHeroEntryItem.New()

		item.component:init(item.go)
		item.component:initData(index)
		gohelper.setActive(item.go, true)

		self._heroItems[index] = item
	end

	return item
end

function Season123_2_3PickHeroEntryView:refreshRecommendCareer()
	local careers = Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)

	if careers and #careers > 0 then
		gohelper.setActive(self._gorecommentexist, true)

		for index = 1, #careers do
			local item = self:getOrCreateCareer(index)

			gohelper.setActive(item.go, true)
			UISpriteSetMgr.instance:setHeroGroupSprite(item.imageicon, "career_" .. tostring(careers[index]))
		end

		for i = #careers + 1, #careers do
			local item = self._careerItems[i]

			if item then
				gohelper.setActive(item.go, false)
			end
		end
	else
		gohelper.setActive(self._gorecommentexist, false)
	end
end

function Season123_2_3PickHeroEntryView:getOrCreateCareer(index)
	local item = self._careerItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gocareeritem, "career_" .. tostring(index))
		item.imageicon = gohelper.findChildImage(item.go, "")
		self._careerItems[index] = item
	end

	return item
end

function Season123_2_3PickHeroEntryView:refreshRecommendTag()
	local tagCoList = Season123Config.instance:getRecommendTagCoList(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)

	if tagCoList and #tagCoList > 0 then
		gohelper.setActive(self._gorecommendTagContent, true)
		gohelper.CreateObjList(self, self.tagItemShow, tagCoList, self._gorecommendTagContent, self._gorecommendTagItem)
	else
		gohelper.setActive(self._gorecommendTagContent, false)
	end
end

function Season123_2_3PickHeroEntryView:tagItemShow(obj, data, index)
	local tagItemGO = obj
	local tagItemDesc = gohelper.findChildText(tagItemGO, "txt_tag")

	tagItemDesc.text = data.desc
end

function Season123_2_3PickHeroEntryView:refreshRecommendUI()
	local careers = Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)
	local tagCoList = Season123Config.instance:getRecommendTagCoList(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)
	local hasCareers = careers and #careers > 0
	local hasTags = tagCoList and #tagCoList > 0

	gohelper.setActive(self._gorecommendLine, hasCareers and hasTags)
	gohelper.setActive(self._gorecommentnone, not hasCareers and not hasTags)
end

function Season123_2_3PickHeroEntryView:_btnstartOnClick()
	Season123PickHeroEntryController.instance:sendEnterStage()
end

function Season123_2_3PickHeroEntryView:_btncloseOnClick()
	self:closeThis()
end

function Season123_2_3PickHeroEntryView:_btndetailsOnClick()
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, 1)
end

function Season123_2_3PickHeroEntryView:handleEnterStageSuccess()
	local finishCall = self.viewParam.finishCall
	local finishCallObj = self.viewParam.finishCallObj

	self:closeThis()

	if finishCall then
		self.viewParam.finishCall(finishCallObj)
	end
end

return Season123_2_3PickHeroEntryView
