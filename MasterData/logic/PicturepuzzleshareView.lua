-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/view/PicturepuzzleshareView.lua

module("logic.extensions.picturepuzzle.view.PicturepuzzleshareView", package.seeall)

local PicturepuzzleshareView = class("PicturepuzzleshareView", ViewComponent)

function PicturepuzzleshareView:buildUI()
	PicturepuzzleshareView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._shareImg = self:getGo("shareImg")
	self._btnShare = self:getBtn("btnShare")
end

function PicturepuzzleshareView:bindEvents()
	PicturepuzzleshareView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._btnShare:AddClickListener(self._onClickShare, self)
end

function PicturepuzzleshareView:unbindEvents()
	PicturepuzzleshareView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PicturepuzzleshareView:onEnter()
	PicturepuzzleshareView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._shareImgUrl = openParam[1]
	self._shareId = openParam[2]

	local prize = ShareController.instance.activeByTimes(self._shareId, goutil.findChild(self._btnShare.gameObject, "bubble"))

	MaterialMgr.setCellByCfg(prize, goutil.findChild(self._btnShare.gameObject, "bubble/reward"))
	uGuiUtil.setSpriteToImage(self._shareImg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("picturepuzzle/" .. self._shareImgUrl))
end

function PicturepuzzleshareView:onExit()
	PicturepuzzleshareView.super.onExit(self)
	uGuiUtil.clearImage(self._shareImg)
	MaterialMgr.resetAll(goutil.findChild(self._btnShare.gameObject, "bubble/reward"))
end

function PicturepuzzleshareView:onExitFinished()
	PicturepuzzleshareView.super.onExitFinished(self)
end

function PicturepuzzleshareView:_onClickShare()
	ShareController.instance:share(self._shareId, {
		self._closeBtn.gameObject,
		self._btnShare.gameObject
	}, nil, 200445, nil, nil)
end

return PicturepuzzleshareView
