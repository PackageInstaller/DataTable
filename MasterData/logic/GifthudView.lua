-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paytempt/view/GifthudView.lua

module("logic.extensions.paytempt.view.GifthudView", package.seeall)

local GifthudView = class("GifthudView", ViewComponent)

function GifthudView:ctor()
	GifthudView.super.ctor(self)
end

function GifthudView:buildUI()
	GifthudView.super.buildUI(self)

	self._btnGift = self:getBtn("btnGift")
	self.mainImg = GameUtil.getUIImageSpriteChange(self:getGo("btnGift"))
	self.imgTitle = GameUtil.getUIImageSpriteChange(self:getGo("btnGift/imgTitle"))
	self.txtTime = self:getTxt("btnGift/txtTime")
end

function GifthudView:bindEvents()
	GifthudView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGift, self.onClick, self)
end

function GifthudView:unbindEvents()
	GifthudView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.mainGO)
end

function GifthudView:destroyUI()
	GifthudView.super.destroyUI(self)
end

function GifthudView:onEnter()
	GifthudView.super.onEnter(self)

	self.info = self:getFirstParam()

	local now = ServerTime.now() * 1000

	if now < checknumber(self.info.endTimeMillis) then
		local cfg = self.info.type == PaytemptModel.TYPE_CLIENT and PaytemptConfig.instance:getClientCfgById(self.info.id) or PaytemptConfig.instance:getCfgById(self.info.id)

		if cfg then
			self.mainImg:ChangeSprite(cfg.bgImg)
			self.imgTitle:ChangeSprite(cfg.hudImg)
			self:onTimer()
			settimer(1, self.onTimer, self)
		else
			self:close()
		end
	else
		self:close()
	end
end

function GifthudView:onEnterFinished()
	GifthudView.super.onEnterFinished(self)
end

function GifthudView:onExit()
	GifthudView.super.onExit(self)
	removetimer(self.onTimer, self)
end

function GifthudView:onExitFinished()
	GifthudView.super.onExitFinished(self)
end

function GifthudView:close()
	PaytemptModel.instance:showOrCloseHud()
end

function GifthudView:onClick()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_JINGZHUN_HUD)
	UIStateManager.instance:push(ViewName.PaytemptView)
end

function GifthudView:onTimer()
	local now = ServerTime.now()
	local left = checknumber(self.info.endTimeMillis) / 1000 - now

	if left > 0 then
		self.txtTime.text = GameUtil.FormatTimeSymbol(left, true) .. "后消失"
	else
		removetimer(self.onTimer, self)
		self:close()
	end
end

return GifthudView
