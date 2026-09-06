-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumepictureView.lua

module("logic.extensions.godgemconsume.view.GodgemconsumepictureView", package.seeall)

local GodgemconsumepictureView = class("GodgemconsumepictureView", ViewComponent)

function GodgemconsumepictureView:ctor()
	GodgemconsumepictureView.super.ctor(self)
end

function GodgemconsumepictureView:unbindEvents()
	GodgemconsumepictureView.super.unbindEvents(self)
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
end

function GodgemconsumepictureView:bindEvents()
	GodgemconsumepictureView.super.bindEvents(self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
end

function GodgemconsumepictureView:buildUI()
	GodgemconsumepictureView.super.buildUI(self)

	self._btnRight = self:getBtn("btnRight")
	self._btnLeft = self:getBtn("btnLeft")
	self._imgGo = self:getGo("img")
end

function GodgemconsumepictureView:onExit()
	GodgemconsumepictureView.super.onExit(self)
	uGuiUtil.clearImage(self._imgGo)
end

function GodgemconsumepictureView:onEnter()
	GodgemconsumepictureView.super.onEnter(self)
	self:_initView()
end

function GodgemconsumepictureView:_onClickbtnRight()
	self._currIndex = self._currIndex + 1
	self._currIndex = math.min(self._currIndex, self._maxLen)

	self:_updateView()
end

function GodgemconsumepictureView:_onClickbtnLeft()
	self._currIndex = self._currIndex - 1
	self._currIndex = math.max(self._currIndex, 1)

	self:_updateView()
end

function GodgemconsumepictureView:_updateView()
	goutil.setActive(self._btnLeft.gameObject, self._currIndex > 1)
	goutil.setActive(self._btnRight.gameObject, self._currIndex < self._maxLen)

	local cfg = self._picCfgs[self._currIndex]

	uGuiUtil.setSpriteToImage(self._imgGo, nil, GameUrl.getBigbgFolderUrl("godgem", cfg.iconName))
end

function GodgemconsumepictureView:_initView()
	self._picCfgs = GodgemconsumeConfig.instance:getPictureCfgs()
	self._currIndex = 1
	self._maxLen = #self._picCfgs

	self:_updateView()
end

return GodgemconsumepictureView
