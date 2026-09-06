-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elvesrevealed/view/ElvesrevealedPicruleView.lua

module("logic.extensions.elvesrevealed.view.ElvesrevealedPicruleView", package.seeall)

local ElvesrevealedPicruleView = class("ElvesrevealedPicruleView", ViewComponent)

function ElvesrevealedPicruleView:ctor()
	ElvesrevealedPicruleView.super.ctor(self)
end

function ElvesrevealedPicruleView:unbindEvents()
	ElvesrevealedPicruleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnPre)
end

function ElvesrevealedPicruleView:bindEvents()
	ElvesrevealedPicruleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickPreBtn, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNextBtn, self)
end

function ElvesrevealedPicruleView:buildUI()
	ElvesrevealedPicruleView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._btnNext = self:getGo("btnNext")
	self._btnPre = self:getGo("btnPre")
	self._btnClose = self:getGo("btnClose")
end

function ElvesrevealedPicruleView:onExit()
	ElvesrevealedPicruleView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)
end

function ElvesrevealedPicruleView:onEnter()
	ElvesrevealedPicruleView.super.onEnter(self)

	local rulePicPath = self:getFirstParam()

	self._picPathArr = string.split(rulePicPath, "#")
	self._curPicId = 1

	self:_switchPic()
end

function ElvesrevealedPicruleView:_switchPic()
	goutil.setActive(self._btnPre, self._curPicId > 1)
	goutil.setActive(self._btnNext, self._curPicId < #self._picPathArr)

	local path = self._picPathArr[self._curPicId]

	uGuiUtil.clearImage(self._bg)

	local function localFunc()
		local image = self._bg:GetComponent(goutil.Type_UIImage)

		if image then
			image:SetNativeSize()
		end
	end

	local bgUrl = string.format("ui/bigbg/views/elvesrevealed/%s.png", path)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, bgUrl, localFunc)
end

function ElvesrevealedPicruleView:_onClickPreBtn()
	self._curPicId = self._curPicId - 1

	self:_switchPic()
end

function ElvesrevealedPicruleView:_onClickNextBtn()
	self._curPicId = self._curPicId + 1

	self:_switchPic()
end

return ElvesrevealedPicruleView
