-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/entrance/view/EntranceAdmitCertificateView.lua

module("logic.extensions.entrance.view.EntranceAdmitCertificateView", package.seeall)

local EntranceAdmitCertificateView = class("EntranceAdmitCertificateView", ViewComponent)

function EntranceAdmitCertificateView:ctor()
	EntranceAdmitCertificateView.super.ctor(self)
end

function EntranceAdmitCertificateView:buildUI()
	EntranceAdmitCertificateView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._title = goutil.findChildTextComponent(self.mainGO, "bg/title")
	self._titleColor = goutil.findChildComponent(self.mainGO, "bg/title", "UITextColorChange")
	self._content = goutil.findChildTextComponent(self.mainGO, "bg/content")
	self._contentColor = goutil.findChildComponent(self.mainGO, "bg/content", "UITextColorChange")
	self._continueBtn = self:getBtn("bg/continueBtn")
	self._continueBtnIcon = goutil.findChildComponent(self.mainGO, "bg/continueBtn", "UIImageSpriteChange")
	self._txtColor = goutil.findChildComponent(self.mainGO, "bg/txt", "UITextColorChange")
	self._admitSeal = self:getGo("bg/admitSeal")
	self._animationTime = 0
end

function EntranceAdmitCertificateView:bindEvents()
	EntranceAdmitCertificateView.super.bindEvents(self)
	self._continueBtn:AddClickListener(self._onClickContinue, self)
end

function EntranceAdmitCertificateView:unbindEvents()
	EntranceAdmitCertificateView.super.unbindEvents(self)
	self._continueBtn:RemoveClickListener()
end

function EntranceAdmitCertificateView:destroyUI()
	EntranceAdmitCertificateView.super.destroyUI(self)
end

function EntranceAdmitCertificateView:onEnter()
	EntranceAdmitCertificateView.super.onEnter(self)

	self._animationTime = 0

	local sp = string.split(EntranceConfig.instance:getCommonValue("ADMIT"), "#")

	self._entranceInfo = EntranceConfig.instance:getTextById(tonumber(sp[RoleModel.instance:getPlayerType()]))
	self._title.text = self._entranceInfo.title
	self._content.text = string.gsub(self._entranceInfo.content, "#username#", RoleModel.instance:getUserName())

	goutil.setActive(self:getGo("bg/successSeal"), false)

	goutil.findChildTextComponent(self.mainGO, "bg/txt").text = EntranceConfig.instance:getCommonValue("NOT_TITLE")

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, "ui/bigbg/ruxuetongzhidan/board_yqh_03.png")
	self._titleColor:SetState(RoleModel.instance:getPlayerType() - 1)
	self._contentColor:SetState(RoleModel.instance:getPlayerType() - 1)
	self._continueBtnIcon:SetState(RoleModel.instance:getPlayerType() - 1)
	self._txtColor:SetState(RoleModel.instance:getPlayerType() - 1)
	GameUtil.setLocalScale(self._admitSeal, 3.5, 3.5, 3.5)
end

function EntranceAdmitCertificateView:onEnterFinished()
	EntranceAdmitCertificateView.super.onEnterFinished(self)
	settimer(0.02, self._animation, self)
end

function EntranceAdmitCertificateView:onExit()
	EntranceAdmitCertificateView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)
	removetimer(self._animation, self)
end

function EntranceAdmitCertificateView:onExitFinished()
	EntranceAdmitCertificateView.super.onExitFinished(self)
end

function EntranceAdmitCertificateView:_animation()
	local scale = 1

	if self._animationTime <= 5 then
		scale = 0.52 * math.abs(self._animationTime - 5) + 0.9

		GameUtil.setLocalScale(self._admitSeal, scale, scale, scale)

		self._animationTime = self._animationTime + 1
	elseif self._animationTime > 5 and self._animationTime <= 10 then
		scale = 0.02 * math.abs(self._animationTime - 5) + 0.9

		GameUtil.setLocalScale(self._admitSeal, scale, scale, scale)

		self._animationTime = self._animationTime + 1
	else
		GameUtil.setLocalScale(self._admitSeal, 1, 1, 1)
		removetimer(self._animation, self)
	end
end

function EntranceAdmitCertificateView:_onClickContinue()
	self:close()
end

return EntranceAdmitCertificateView
