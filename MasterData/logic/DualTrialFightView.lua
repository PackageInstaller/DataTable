-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialFightView.lua

module("logic.extensions.dualtrial.view.DualTrialFightView", package.seeall)

local DualTrialFightView = class("DualTrialFightView", ViewComponent)

function DualTrialFightView:ctor()
	DualTrialFightView.super.ctor(self)
end

function DualTrialFightView:unbindEvents()
	DualTrialFightView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFinish)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
end

function DualTrialFightView:bindEvents()
	DualTrialFightView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnFinish, self._onClickBtnFinish, self)
end

function DualTrialFightView:buildUI()
	DualTrialFightView.super.buildUI(self)

	self._txt = self:getTxt("sv/Viewport/txt")
	self._btnFinish = self:getGo("btnFinish")
	self._btnClose = self:getGo("btnClose")
	self._btnStart = self:getGo("btnStart")
	self._petcard = self:getGo("petcard")
end

function DualTrialFightView:onExit()
	DualTrialFightView.super.onExit(self)
	uGuiUtil.clearImage(self._petcard)
end

function DualTrialFightView:onEnter()
	DualTrialFightView.super.onEnter(self)
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

function DualTrialFightView:_updateUIByInfo()
	local info = DualTrialModel.instance:getInfoByActId(self._activityId)
	local curEvent = info and info.event

	if curEvent then
		goutil.setActive(self._btnStart, false)
		goutil.setActive(self._btnFinish, false)

		local beginTimestamp = Mathf.Ceil(checknumber(curEvent.beginTimestamp) / 1000)

		if beginTimestamp > 0 then
			self._txt.text = self._eventCfg.dialogueEnd

			goutil.setActive(self._btnFinish, true)
		else
			self._txt.text = self._eventCfg.dialogueStart

			goutil.setActive(self._btnStart, true)
		end
	else
		self:close()
	end
end

function DualTrialFightView:_onClickBtnStart()
	self:close()
	DualTrialController.instance:openMissionView(self._activityId, self._eventCfg.creepsMasterId)
end

function DualTrialFightView:_onClickBtnFinish()
	DualTrialController.instance:endEvent(self._activityId)
end

function DualTrialFightView:_handleEndEvent()
	self:close()
	DualTrialController.instance:onepEventView(self._activityId, true)
end

return DualTrialFightView
