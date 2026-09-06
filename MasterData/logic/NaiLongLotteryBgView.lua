-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/view/NaiLongLotteryBgView.lua

module("logic.extensions.nailonglottery.view.NaiLongLotteryBgView", package.seeall)

local NaiLongLotteryBgView = class("NaiLongLotteryBgView", ViewComponent)

function NaiLongLotteryBgView:buildUI()
	NaiLongLotteryBgView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._imgBg = self:getGo("imgBg")
end

function NaiLongLotteryBgView:bindEvents()
	NaiLongLotteryBgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NaiLongLotteryBgView:unbindEvents()
	NaiLongLotteryBgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NaiLongLotteryBgView:onEnter()
	NaiLongLotteryBgView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._bgName = params[1]

	local path = self._bgName
	local bgGo = self._imgBg

	if not string.nilorempty(path) and bgGo then
		local spriteName = GameUrl.getBigbgPngUrl(path)

		local function func()
			bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end

		uGuiUtil.setSpriteToImage(bgGo, uGuiUtil.SpriteType.BigBg, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end
end

function NaiLongLotteryBgView:onExit()
	NaiLongLotteryBgView.super.onExit(self)
	uGuiUtil.clearImage(self._imgBg)
end

return NaiLongLotteryBgView
