-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialAfkView.lua

module("logic.extensions.dualtrial.view.DualTrialAfkView", package.seeall)

local DualTrialAfkView = class("DualTrialAfkView", ViewComponent)

function DualTrialAfkView:ctor()
	DualTrialAfkView.super.ctor(self)
end

function DualTrialAfkView:unbindEvents()
	DualTrialAfkView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFinish)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
end

function DualTrialAfkView:bindEvents()
	DualTrialAfkView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnFinish, self._onClickBtnFinish, self)
end

function DualTrialAfkView:buildUI()
	DualTrialAfkView.super.buildUI(self)

	self._txt = self:getTxt("sv/Viewport/txt")
	self._btnFinish = self:getGo("btnFinish")
	self._btnClose = self:getGo("btnClose")
	self._btnStart = self:getGo("btnStart")
	self._tips = self:getGo("tips")
	self._txtTimeTips = self:getTxt("tips/txtTime")
	self._petcard = self:getGo("petcard")
end

function DualTrialAfkView:onExit()
	DualTrialAfkView.super.onExit(self)
	removetimer(self._updateTimer, self)
	uGuiUtil.clearImage(self._petcard)
end

function DualTrialAfkView:onEnter()
	DualTrialAfkView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DualTrialBeginEvent, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.DualTrialEndEvent, self._handleEndEvent, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._eventCfg = params[2]

	local faceId = self._eventCfg.showLihui
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.setSpriteToImage(self._petcard, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._actCfg = DualTrialConfig.instance:getActivityCfgById(self._activityId)

	self:_updateUIByInfo()
end

function DualTrialAfkView:_updateUIByInfo()
	removetimer(self._updateTimer, self)

	local info = DualTrialModel.instance:getInfoByActId(self._activityId)
	local curEvent = info and info.event

	self._InCD = false

	if curEvent then
		goutil.setActive(self._btnStart, false)
		goutil.setActive(self._btnFinish, false)
		goutil.setActive(self._tips, false)

		self._txt.text = self._eventCfg.dialogueStart

		local beginTimestamp = Mathf.Ceil(checknumber(curEvent.beginTimestamp) / 1000)

		if beginTimestamp > 0 then
			self._finishTimer = beginTimestamp + self._actCfg.hangingTime

			if ServerTime.now() > self._finishTimer then
				goutil.setActive(self._btnFinish, true)

				self._txt.text = self._eventCfg.dialogueEnd
			else
				goutil.setActive(self._tips, true)
				self:_updateTimer()
				settimer(1, self._updateTimer, self, true)

				self._InCD = true
			end
		else
			goutil.setActive(self._btnStart, true)
		end
	else
		self:close()
	end
end

function DualTrialAfkView:_updateTimer()
	local leftTime = ServerTime.now() - checknumber(self._finishTimer)

	if leftTime > 0 then
		self:_updateUIByInfo()
	else
		local timer = -leftTime
		local min = Mathf.Floor(timer / 60)
		local sec = timer % 60

		self._txtTimeTips.text = langPara("剩余<color=#EB4642>%d:%2d</color>", min, sec)
	end
end

function DualTrialAfkView:_onClickBtnStart()
	DualTrialController.instance:beginEvent(self._activityId)
end

function DualTrialAfkView:_onClickBtnFinish()
	if self._InCD then
		FloatWordMgr.instance:show("还需要等待一会")

		return
	end

	DualTrialController.instance:endEvent(self._activityId)
end

function DualTrialAfkView:_handleEndEvent()
	self:close()
	DualTrialController.instance:onepEventView(self._activityId, true)
end

return DualTrialAfkView
