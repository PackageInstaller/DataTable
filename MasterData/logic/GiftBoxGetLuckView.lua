-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxGetLuckView.lua

module("logic.extensions.giftbox.view.GiftBoxGetLuckView", package.seeall)

local GiftBoxGetLuckView = class("GiftBoxGetLuckView", ViewComponent)

function GiftBoxGetLuckView:ctor()
	GiftBoxGetLuckView.super.ctor(self)
end

function GiftBoxGetLuckView:unbindEvents()
	GiftBoxGetLuckView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GiftBoxGetLuckView:bindEvents()
	GiftBoxGetLuckView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GiftBoxGetLuckView:buildUI()
	GiftBoxGetLuckView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._successTip = self:getGo("successTip")
	self._txtScore = self:getTxt("successTip/txtScore")
	self._failTip_1 = self:getGo("failTip_1")
	self._failTip_2 = self:getGo("failTip_2")
end

function GiftBoxGetLuckView:onExit()
	GiftBoxGetLuckView.super.onExit(self)
end

function GiftBoxGetLuckView:onEnter()
	GiftBoxGetLuckView.super.onEnter(self)

	local actId = GiftBoxModel.instance:getCurActId()

	if actId <= 0 then
		self:close()

		return
	end

	local actCfg = GiftBoxConfig.instance:getActCfgById(actId)
	local params = self:getOpenParam()
	local isSuccess = params[1]

	GameUtil.SetActive(self._successTip, false)
	GameUtil.SetActive(self._failTip_1, false)
	GameUtil.SetActive(self._failTip_2, false)

	if isSuccess == true then
		local getScore = params[2]

		GameUtil.SetActive(self._successTip, true)

		self._txtScore.text = langPara("成功吸到<color=#eb4642>%d</color>欧气\n今日还可沾欧气<color=#eb4642>%d</color>次", checknumber(getScore), math.max(actCfg.dailyTimes - GiftBoxModel.instance:getGainLuckTimes(), 0))
	else
		local resultCode = params[2]

		if checknumber(resultCode) == -36 then
			GameUtil.SetActive(self._failTip_2, true)
		else
			GameUtil.SetActive(self._failTip_1, true)
		end
	end
end

return GiftBoxGetLuckView
