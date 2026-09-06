-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/view/DivinehopeextView.lua

module("logic.extensions.divinehope.view.DivinehopeextView", package.seeall)

local DivinehopeextView = class("DivinehopeextView", ViewComponent)

function DivinehopeextView:buildUI()
	DivinehopeextView.super.buildUI(self)

	self._txtTopDesc = self:getTxt("topDesc/txtDesc")
	self._topDescGo = self:getGo("topDesc")
	self._btnHope = self:getGo("btnHope")
	self._txtAdd = self:getTxt("btnHope/txtAdd")
	self._txtYw = self:getTxt("btnHope/txtYw")
	self._txtDesc = self:getTxt("btnHope/txtDesc")
	self._txtXw = self:getTxt("btnHope/txtXw")
end

function DivinehopeextView:bindEvents()
	DivinehopeextView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHope, self._onClickbtnHope, self)
end

function DivinehopeextView:unbindEvents()
	DivinehopeextView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHope)
end

function DivinehopeextView:onEnter()
	DivinehopeextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	self:_updateUI()
end

function DivinehopeextView:onExit()
	DivinehopeextView.super.onExit(self)
end

function DivinehopeextView:_updateUI()
	local wishId = DivinehopeModel.instance:getSelectWishId(self._fmtMo._activityId)
	local wishCfg = DivinehopeConfig.instance:getWishCfg(self._fmtMo._activityId, wishId)

	if wishCfg then
		goutil.setActive(self._txtXw.gameObject, wishCfg.wishType == 1)
		goutil.setActive(self._txtYw.gameObject, wishCfg.wishType == 2)

		local typeStr = wishCfg.wishType == 1 and "希望" or "欲望"

		self._txtDesc.text = string.format("献祭效果：\n%s", wishCfg.buffDesc)
		self._txtAdd.text = string.format("%s+%s", typeStr, wishCfg.score)
		self._txtTopDesc.text = string.format("献祭效果：%s", wishCfg.buffDesc)

		goutil.setActive(self._topDescGo, not string.nilorempty(wishCfg.buffDesc))
	end
end

function DivinehopeextView:_onClickbtnHope()
	UIStateManager.instance:push(ViewName.DivinehopeselectView, self._fmtMo._activityId, self._fmtMo._floorId, function()
		self:_updateUI()
	end)
end

return DivinehopeextView
