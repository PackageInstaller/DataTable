-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5ShowHeroView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5ShowHeroView", package.seeall)

local Season123_3_5ShowHeroView = class("Season123_3_5ShowHeroView", BaseView)

function Season123_3_5ShowHeroView:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "Right/#go_list/#go_item")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_reset")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnmaincard1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_supercard1/#btn_supercardclick")
	self._btnmaincard2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_supercard2/#btn_supercardclick")
	self._btndetails = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_details")
	self._gorecomment = gohelper.findChild(self.viewGO, "Right/#go_recommend")
	self._gorecommentnone = gohelper.findChild(self.viewGO, "Right/#go_recommend/txt_recommend/txt_none")
	self._gorecommentexist = gohelper.findChild(self.viewGO, "Right/#go_recommend/txt_recommend/recommends")
	self._gocareeritem = gohelper.findChild(self.viewGO, "Right/#go_recommend/txt_recommend/recommends/career")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5ShowHeroView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnmaincard1:AddClickListener(self._btnmaincardOnClick, self, 1)
	self._btnmaincard2:AddClickListener(self._btnmaincardOnClick, self, 2)
end

function Season123_3_5ShowHeroView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndetails:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnmaincard1:RemoveClickListener()
	self._btnmaincard2:RemoveClickListener()
end

function Season123_3_5ShowHeroView:_editableInitView()
	self._heroItems = {}
end

function Season123_3_5ShowHeroView:onDestroyView()
	if self._heroItems then
		for index, item in pairs(self._heroItems) do
			item.component:dispose()
		end

		self._heroItems = nil
	end

	Season123ShowHeroController.instance:onCloseView()
end

function Season123_3_5ShowHeroView:onOpen()
	self.addEventCb(self, Season123Controller.instance, Season123Event.OnResetSucc, self.closeThis, self)
	Season123ShowHeroController.instance:onOpenView(self.viewParam.actId, self.viewParam.stage, self.viewParam.layer)

	local actMO = ActivityModel.instance:getActMO(self.viewParam.actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self.refreshUI, self)
	self:refreshUI()
end

function Season123_3_5ShowHeroView:onClose()
	if self._heroItems then
		for index, item in pairs(self._heroItems) do
			item.component:onClose()
		end
	end
end

function Season123_3_5ShowHeroView:refreshUI()
	self:refreshItems()
	gohelper.setActive(self._gorecommentnone, false)
	gohelper.setActive(self._gorecommentexist, false)
end

function Season123_3_5ShowHeroView:refreshItems()
	for index = 1, Activity123Enum.PickHeroCount do
		local item = self:getOrCreateItem(index)

		item.component:refreshUI()
	end
end

function Season123_3_5ShowHeroView:getOrCreateItem(index)
	local item = self._heroItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goitem, "item_" .. tostring(index))
		item.component = Season123_3_5ShowHeroItem.New()

		item.component:init(item.go)
		item.component:initData(index)
		gohelper.setActive(item.go, true)

		self._heroItems[index] = item
	end

	return item
end

function Season123_3_5ShowHeroView:_btndetailsOnClick()
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123ShowHeroModel.instance.activityId, Season123ShowHeroModel.instance.stage, Season123ShowHeroModel.instance.layer)
end

function Season123_3_5ShowHeroView:_btnresetOnClick()
	Season123ShowHeroController.instance:openReset()
end

function Season123_3_5ShowHeroView:_btncloseOnClick()
	self:closeThis()
end

function Season123_3_5ShowHeroView:handleEnterStageSuccess()
	local finishCall = self.viewParam.finishCall
	local finishCallObj = self.viewParam.finishCallObj

	self:closeThis()

	if finishCall then
		self.viewParam.finishCall(finishCallObj)
	end
end

return Season123_3_5ShowHeroView
