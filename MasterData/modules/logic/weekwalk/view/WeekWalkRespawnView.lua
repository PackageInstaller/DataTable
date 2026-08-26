-- chunkname: @modules/logic/weekwalk/view/WeekWalkRespawnView.lua

module("modules.logic.weekwalk.view.WeekWalkRespawnView", package.seeall)

local WeekWalkRespawnView = class("WeekWalkRespawnView", BaseView)

function WeekWalkRespawnView:onInitView()
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_card")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkRespawnView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function WeekWalkRespawnView:removeEvents()
	self._btnconfirm:RemoveClickListener()
end

function WeekWalkRespawnView:_btnconfirmOnClick()
	if not self._heroMO then
		GameFacade.showToast(ToastEnum.AdventureRespawn2)

		return
	end

	WeekwalkRpc.instance:sendWeekwalkRespawnRequest(self.info.elementId, self._heroMO.heroId)
end

function WeekWalkRespawnView:_editableInitView()
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")

	self._imgBg:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	HeroGroupEditListModel.instance:setParam(nil, WeekWalkModel.instance:getInfo())
end

function WeekWalkRespawnView:onUpdateParam()
	return
end

function WeekWalkRespawnView:onOpen()
	self.info = self.viewParam

	WeekWalkRespawnModel.instance:setRespawnList()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.WeekWalkRespawnReply, self._onWeekWalkRespawnReply, self)
end

function WeekWalkRespawnView:_onHeroItemClick(heroMO)
	self._heroMO = heroMO
end

function WeekWalkRespawnView:_onWeekWalkRespawnReply()
	GameFacade.showToast(ToastEnum.AdventureRespawn3)
	self:closeThis()
end

function WeekWalkRespawnView:onClose()
	return
end

function WeekWalkRespawnView:onDestroyView()
	self._imgBg:UnLoadImage()
end

return WeekWalkRespawnView
