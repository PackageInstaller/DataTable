-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaTipView.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaTipView", package.seeall)

local DivineNuoYaTipView = class("DivineNuoYaTipView", ViewComponent)

function DivineNuoYaTipView:buildUI()
	DivineNuoYaTipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tip = self:getGo("tip")
	self._txtDesc1 = self:getTxt("img/txtDesc1")
	self._txtDesc2 = self:getTxt("txtDesc2")
end

function DivineNuoYaTipView:bindEvents()
	DivineNuoYaTipView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function DivineNuoYaTipView:unbindEvents()
	DivineNuoYaTipView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineNuoYaTipView:onEnter()
	DivineNuoYaTipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._viewType = params[2]

	self:_initCloseBtn()
	self:_initDescTxt()
end

function DivineNuoYaTipView:onExit()
	DivineNuoYaTipView.super.onExit(self)
end

function DivineNuoYaTipView:_initCloseBtn()
	goutil.setActive(self._btnClose.gameObject, false)
	goutil.setActive(self._tip, false)
	TweenUtil.DoDelay(1, function()
		goutil.setActive(self._btnClose.gameObject, true)
		goutil.setActive(self._tip, true)
	end)
end

function DivineNuoYaTipView:_initDescTxt()
	self._txtDesc1.text = self._viewType == DivineNuoYaChallengeModel.ResetPet and "关卡已重置" or "挑战成功"

	local txt1 = "已将挑战中的关卡进度重置\n可重新选择精灵进行挑战"
	local txt2 = "您已完成本关卡的所有挑战"

	self._txtDesc2.text = self._viewType == DivineNuoYaChallengeModel.ResetPet and txt1 or txt2
end

return DivineNuoYaTipView
