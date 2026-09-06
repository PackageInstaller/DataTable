-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoohatchcancelView.lua

module("logic.extensions.zoo.view.ZoohatchcancelView", package.seeall)

local ZoohatchcancelView = class("ZoohatchcancelView", ViewComponent)

function ZoohatchcancelView:buildUI()
	ZoohatchcancelView.super.buildUI(self)

	self._enterBtn = self:getBtn("enterBtn")
	self._cancelBtn = self:getBtn("cancelBtn")
	self._time = self:getTxt("time")
	self._eggIcon = self:getGo("hatch/eggIcon")
end

function ZoohatchcancelView:bindEvents()
	ZoohatchcancelView.super.bindEvents(self)
	self._enterBtn:AddClickListener(self._onClickEnter, self)
	self._cancelBtn:AddClickListener(self.close, self)
end

function ZoohatchcancelView:unbindEvents()
	ZoohatchcancelView.super.unbindEvents(self)
	self._enterBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function ZoohatchcancelView:onEnter()
	ZoohatchcancelView.super.onEnter(self)

	local myZoo = ZooModel.instance:getMyZoo()

	self._hatchInfo = myZoo:getHatchInfoByIndex(self:getFirstParam())

	self:_tickHatching()
	settimer(1, self._tickHatching, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooCancelHatch, self._onZooCancelHatch, self)
end

function ZoohatchcancelView:onExit()
	ZoohatchcancelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooCancelHatch, self._onZooCancelHatch, self)
	removetimer(self._tickHatching, self)
	uGuiUtil.clearImage(self._eggIcon)
end

function ZoohatchcancelView:_onClickEnter()
	local tag = self:getFirstParam()
	local surplusTime = self._hatchInfo:getHatchSurplusTime()
	local cfg = ZooConfig.instance:getAnimalById(self._hatchInfo.animalRace)

	if surplusTime <= 0 then
		FloatWordMgr.instance:show(lang("petzoo_hatchfisnish_cantcancel"))
	else
		ZooController.instance:sendPM_ZooCancelHatchEggReq(tag)
	end
end

function ZoohatchcancelView:_tickHatching()
	local surplusTime = self._hatchInfo:getHatchSurplusTime()
	local cfg = ZooConfig.instance:getAnimalById(self._hatchInfo.animalRace)

	if surplusTime <= 0 then
		self._time.text = lang("petzoo_hatch_finished")

		uGuiUtil.setSpriteToImage(self._eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.adultShow))
		removetimer(self._tickHatching, self)
	else
		self._time.text = string.format(lang("petzoo_hatch_surplustimer"), GameUtil.FormatTimeSymbol(surplusTime))

		local stateTime = self._hatchInfo.hatchCD * (1 - cfg.hatchProgress[1] / cfg.hatchProgress[2])

		if stateTime < surplusTime then
			uGuiUtil.setSpriteToImage(self._eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.eggShow))
		else
			uGuiUtil.setSpriteToImage(self._eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.groupShow))
		end
	end
end

function ZoohatchcancelView:_onZooCancelHatch()
	self:close()
end

return ZoohatchcancelView
