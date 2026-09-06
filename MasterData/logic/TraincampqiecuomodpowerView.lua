-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TraincampqiecuomodpowerView.lua

module("logic.extensions.traincampqiecuo.view.TraincampqiecuomodpowerView", package.seeall)

local TraincampqiecuomodpowerView = class("TraincampqiecuomodpowerView", ViewComponent)

function TraincampqiecuomodpowerView:ctor()
	TraincampqiecuomodpowerView.super.ctor(self)
end

function TraincampqiecuomodpowerView:unbindEvents()
	TraincampqiecuomodpowerView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTxtPower:RemoveClickListener()
end

function TraincampqiecuomodpowerView:bindEvents()
	TraincampqiecuomodpowerView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTxtPower:AddClickListener(self._onClickbtntxtPower, self)
end

function TraincampqiecuomodpowerView:buildUI()
	TraincampqiecuomodpowerView.super.buildUI(self)

	self._btnSure = self:getBtn("viewnode/btnSure")
	self._btnClose = self:getBtn("viewnode/btnClose")
	self._btnTxtPower = self:getBtn("childnode/pve/txtPetPower")
	self._txtTip = self:getTxt("txtTip")
	self._txtPower = self:getTxt("txtPower")
	self._txtPetTotalPower = self:getTxt("childnode/pve/txtPetTotalPower")
	self._txtPetPower = self:getTxt("childnode/pve/txtPetPower")
end

function TraincampqiecuomodpowerView:onExit()
	TraincampqiecuomodpowerView.super.onExit(self)
end

function TraincampqiecuomodpowerView:onEnter()
	TraincampqiecuomodpowerView.super.onEnter(self)

	local params = self:getOpenParam()

	self._perPetPower = params[1]
	self._lastPetPower = self._perPetPower
	self._callBack = params[2]

	self:_setPetPower()
end

function TraincampqiecuomodpowerView:_onClickbtntxtPower()
	UIStateManager.instance:push(ViewName.PksetenemypowerView, self._perPetPower, function(power)
		self._perPetPower = power

		self:_setPetPower()
	end)
end

function TraincampqiecuomodpowerView:_onClickbtnSure()
	if self._lastPetPower ~= self._perPetPower then
		self._callBack(self._perPetPower)
	end

	self:close()
end

function TraincampqiecuomodpowerView:_onClickbtnClose()
	self:close()
end

function TraincampqiecuomodpowerView:_setPetPower()
	local power = self:_getModPower()

	self._txtPetPower.text = string.format("%sW", power / 10000)
	self._txtPetTotalPower.text = string.format("%sW", power * 6 / 10000)
end

function TraincampqiecuomodpowerView:_getModPower()
	return math.ceil(self._perPetPower / 10000) * 10000
end

return TraincampqiecuomodpowerView
