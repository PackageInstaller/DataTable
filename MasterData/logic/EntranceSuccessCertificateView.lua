-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/entrance/view/EntranceSuccessCertificateView.lua

module("logic.extensions.entrance.view.EntranceSuccessCertificateView", package.seeall)

local EntranceSuccessCertificateView = class("EntranceSuccessCertificateView", ViewComponent)

function EntranceSuccessCertificateView:ctor()
	EntranceSuccessCertificateView.super.ctor(self)
end

function EntranceSuccessCertificateView:buildUI()
	EntranceSuccessCertificateView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._title = goutil.findChildTextComponent(self.mainGO, "bg/title")
	self._titleColor = goutil.findChildComponent(self.mainGO, "bg/title", "UITextColorChange")
	self._content = goutil.findChildTextComponent(self.mainGO, "bg/content")
	self._contentColor = goutil.findChildComponent(self.mainGO, "bg/content", "UITextColorChange")
	self._continueBtn = self:getBtn("bg/continueBtn")
	self._continueBtnIcon = goutil.findChildComponent(self.mainGO, "bg/continueBtn", "UIImageSpriteChange")
	self._txtColor = goutil.findChildComponent(self.mainGO, "bg/txt", "UITextColorChange")
	self._successSeal = self:getGo("bg/successSeal")
	self._animationTime = 0
end

function EntranceSuccessCertificateView:bindEvents()
	EntranceSuccessCertificateView.super.bindEvents(self)
	self._continueBtn:AddClickListener(self._onClickContinue, self)
end

function EntranceSuccessCertificateView:unbindEvents()
	EntranceSuccessCertificateView.super.unbindEvents(self)
	self._continueBtn:RemoveClickListener()
end

function EntranceSuccessCertificateView:destroyUI()
	EntranceSuccessCertificateView.super.destroyUI(self)
end

function EntranceSuccessCertificateView:onEnter()
	EntranceSuccessCertificateView.super.onEnter(self)

	self._animationTime = 0

	local sp = string.split(EntranceConfig.instance:getCommonValue("SUCCESS"), "#")
	local playerType = RoleModel.instance:getPlayerType()

	if playerType ~= 1 or playerType ~= 2 then
		playerType = 2

		RoleModel.instance:setPlayerType(2)
	end

	self._entranceInfo = EntranceConfig.instance:getTextById(tonumber(sp[playerType]))
	self._title.text = self._entranceInfo.title
	self._content.text = string.gsub(self._entranceInfo.content, "#username#", RoleModel.instance:getUserName())
	goutil.findChildTextComponent(self._continueBtn.gameObject, "Text").text = "完成考验"
	goutil.findChildTextComponent(self.mainGO, "bg/txt").text = EntranceConfig.instance:getCommonValue("GET_TITLE")

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, "ui/bigbg/ruxuetongzhidan/board_yqh_03.png")
	self._titleColor:SetState(playerType - 1)
	self._contentColor:SetState(playerType - 1)
	self._continueBtnIcon:SetState(playerType - 1)
	self._txtColor:SetState(playerType - 1)
	GameUtil.setLocalScale(self._successSeal, 3.5, 3.5, 3.5)
end

function EntranceSuccessCertificateView:onEnterFinished()
	EntranceSuccessCertificateView.super.onEnterFinished(self)
	settimer(0.02, self._animation, self)
end

function EntranceSuccessCertificateView:onExit()
	EntranceSuccessCertificateView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)
	removetimer(self._animation, self)
end

function EntranceSuccessCertificateView:onExitFinished()
	EntranceSuccessCertificateView.super.onExitFinished(self)
end

function EntranceSuccessCertificateView:_animation()
	local scale = 1

	if self._animationTime <= 5 then
		scale = 0.52 * math.abs(self._animationTime - 5) + 0.9

		GameUtil.setLocalScale(self._successSeal, scale, scale, scale)

		self._animationTime = self._animationTime + 1
	elseif self._animationTime > 5 and self._animationTime <= 10 then
		scale = 0.02 * math.abs(self._animationTime - 5) + 0.9

		GameUtil.setLocalScale(self._successSeal, scale, scale, scale)

		self._animationTime = self._animationTime + 1
	else
		GameUtil.setLocalScale(self._successSeal, 1, 1, 1)
		removetimer(self._animation, self)
	end
end

function EntranceSuccessCertificateView:_onClickContinue()
	self:close()
end

return EntranceSuccessCertificateView
