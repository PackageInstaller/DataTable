-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportBirthdayPopupView.lua

module("logic.extensions.passport.view.PassportBirthdayPopupView", package.seeall)

local PassportBirthdayPopupView = class("PassportBirthdayPopupView", ViewComponent)

function PassportBirthdayPopupView:ctor()
	PassportBirthdayPopupView.super.ctor(self)
end

function PassportBirthdayPopupView:unbindEvents()
	PassportBirthdayPopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PassportBirthdayPopupView:bindEvents()
	PassportBirthdayPopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PassportBirthdayPopupView:buildUI()
	PassportBirthdayPopupView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtContent = self:getTxt("contentView/Viewport/Content/txtContent")
	self._posterCon = self:getGo("posterCol/posterCon")
	self._txtPosterName = self:getTxt("posterName/txt")
end

function PassportBirthdayPopupView:onExit()
	PassportBirthdayPopupView.super.onExit(self)
	uGuiUtil.clearImage(self._posterCon)
end

function PassportBirthdayPopupView:onEnter()
	PassportBirthdayPopupView.super.onEnter(self)

	local config = self:getFirstParam()

	self._txtTitle.text = config.strTitle
	self._txtPosterName.text = config.petName
	self._txtTitle.text = langPara("%s的小故事", config.petName)
	self._txtContent.text = config.strContent

	local imgPath = GameUrl.getPassportBGUrl(config.imgPath)

	uGuiUtil.setSpriteToImage(self._posterCon, uGuiUtil.SpriteType.BigBg, imgPath)
end

return PassportBirthdayPopupView
