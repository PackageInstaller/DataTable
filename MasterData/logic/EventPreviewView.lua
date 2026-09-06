-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/view/EventPreviewView.lua

module("logic.extensions.eventpreview.view.EventPreviewView", package.seeall)

local EventPreviewView = class("EventPreviewView", ViewComponent)

function EventPreviewView:ctor()
	EventPreviewView.super.ctor(self)
end

function EventPreviewView:unbindEvents()
	EventPreviewView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._receive:RemoveClickListener()
	self._clickLike:RemoveClickListener()
end

function EventPreviewView:bindEvents()
	EventPreviewView.super.bindEvents(self)
	self._receive:AddClickListener(function()
		if self.isInActTime then
			EventPreviewController.instance:sendPM_UpcomingActivityGainPrizeReq(self._curActId, -1)

			return
		end

		FloatWordMgr.instance:show("没有到领取时间哦~")
	end)
	self._clickLike:AddClickListener(function()
		if not EventPreviewModel.instance:getIsAllZan() then
			FloatWordMgr.instance:show("今天已经点过赞了哦~")

			return
		end

		if not self._isBeforeLikeEndTime then
			FloatWordMgr.instance:show("点赞时间已经过了哦~")

			return
		end

		EventPreviewController:sendPM_UpcomingActivityLikeReq(self._curActId, -1)
	end)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "eventpreviewview_rule")
	end)
end

function EventPreviewView:onExit()
	EventPreviewView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpcomingActivity, self._updateAllInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpcomingActivityLike, self.sendAllInfo, self)
	removetimer(self._tickSendAllInfo, self)
end

function EventPreviewView:buildUI()
	EventPreviewView.super.buildUI(self)

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._tableCell = self:getGo("cell")
	self._tableView = self:getGo("tableview")
	self._btnTip = self:getBtn("btnTip")
	self._receive = self:getBtn("receive")
	self._clickLike = self:getBtn("clickLike")
	self._actScrollList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearItemCell, self))
end

function EventPreviewView:onEnter()
	EventPreviewView.super.onEnter(self)

	self._curActId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Event_Preview)

	GlobalDispatcher:addListener(GlobalNotify.UpcomingActivity, self._updateAllInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.UpcomingActivityLike, self.sendAllInfo, self)

	local cfg = EventPreviewConfig.instance:getCfgById(self._curActId)

	self.isInActTime = GameUtil.checkIsInTimePeriod(cfg.gainPrizeStartTime, cfg.gainPrizeEndTime)
	self._dailyCfg = EventPreviewConfig.instance:getDailyPrize(self._curActId)
	self._curTime = ServerTime.now()
	self._isBeforeLikeEndTime = self:checkIsBeforeTime(cfg.likeEndTime)

	self:_initPlayerParams()
	self:sendAllInfo()
	settimer(900, self._tickSendAllInfo, self, true)
end

function EventPreviewView:_clearItemCell(cell)
	local btnJump = goutil.findChild(cell, "btnJump")

	uGuiUtil.clearImage(btnJump)
end

function EventPreviewView:_updateCell(view, cell, data)
	local btnJump = goutil.findChild(cell, "btnJump")
	local btnLike = goutil.findChild(cell, "btnLike")
	local red = goutil.findChild(cell, "btnLike/red")
	local txtName = goutil.findChildTextComponent(btnJump, "txtName")
	local txtDesc = goutil.findChildTextComponent(btnJump, "txtDesc")
	local txtClick = goutil.findChildTextComponent(cell, "bg/txtClick")
	local cfg = self._dailyCfg[data.id]
	local isInTime = GameUtil.checkIsInTimePeriod(cfg.actStartTime, cfg.actEndTime)
	local params = string.split(cfg.params, "&")
	local jumpTo = string.split(cfg.jump, "#")

	txtName.text = params[1]
	txtDesc.text = params[2]
	txtClick.text = EventPreviewModel.instance:getLikeTimes(data.id)

	goutil.setActive(red, checknumber(data.likeTimes) <= 0 and self._isBeforeLikeEndTime)
	GameUtil.asBtn(btnJump):RemoveClickListener()
	GameUtil.asBtn(btnJump):AddClickListener(function()
		if isInTime then
			GotoMgr.gotoByString(cfg.jump)

			return
		end

		FloatWordMgr.instance:show(cfg.tips)
	end)
	GameUtil.asBtn(btnLike):RemoveClickListener()
	GameUtil.asBtn(btnLike):AddClickListener(function()
		if checknumber(data.likeTimes) > 0 then
			FloatWordMgr.instance:show("今天已经点过赞了哦~")

			return
		end

		if not self._isBeforeLikeEndTime then
			FloatWordMgr.instance:show("点赞时间已经过了哦~")

			return
		end

		EventPreviewController.instance:sendPM_UpcomingActivityLikeReq(self._curActId, data.id)
	end)
	uGuiUtil.setSpriteToImage(btnJump, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bonus/%s.png", cfg.bgImage))
end

function EventPreviewView:_initPlayerParams()
	local param = {}

	param.view = self
	param.prizeCfgs = EventPreviewConfig.instance:getProgressPrize(self._curActId)

	function param.getPlayerProgress()
		local progress = EventPreviewModel.instance:getAllInfo()

		return checknumber(progress.curProgress)
	end

	function param.getNeedScoreByRewardCfg(cfg)
		return cfg.progress
	end

	function param.isPlayerRewardCanGet(cfg)
		return EventPreviewModel.instance:isPlayerRewardCanGet(self.isInActTime, cfg.id, cfg.progress)
	end

	function param.isPlayerRewardGeted(cfg)
		return EventPreviewModel.instance:isPlayerRewardGeted(cfg.id)
	end

	function param.sendGainPlayerPrizeReq(cfg)
		if self.isInActTime then
			EventPreviewController.instance:sendPM_UpcomingActivityGainPrizeReq(self._curActId, cfg.id)

			return
		end

		FloatWordMgr.instance:show("没有到领取时间哦~")
	end

	function param.parseGetProgress(cfg)
		return cfg.progress
	end

	self._playerSliderMo:initParam(param, true)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function EventPreviewView:_updateAllInfo()
	self._playerSliderMo:updatePlayerReward()
	self:_updateUpcoming()
end

function EventPreviewView:_updateUpcoming()
	local info = EventPreviewModel.instance:getAllInfo()

	self._actScrollList:reloadData(info.infos)
end

function EventPreviewView:sendAllInfo()
	EventPreviewController.instance:sendPM_UpcomingActivityGetInfoReq(self._curActId)
end

function EventPreviewView:checkIsBeforeTime(time)
	local timeStart = GameUtil.string2time(time)

	return timeStart > self._curTime
end

function EventPreviewView:_tickSendAllInfo()
	self:sendAllInfo()
end

return EventPreviewView
