-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/PetattrpowerupView.lua

module("logic.extensions.mainui.view.PetattrpowerupView", package.seeall)

local PetattrpowerupView = class("PetattrpowerupView", ViewComponent)

function PetattrpowerupView:ctor()
	PetattrpowerupView.super.ctor(self)
end

function PetattrpowerupView:buildUI()
	PetattrpowerupView.super.buildUI(self)

	self.petpowerupview = self:getGo("petpowerupview")
	self.txtName = self:getTxt("petpowerupview/txtName")
	self.old = self:getTxt("petpowerupview/old")
	self.new = self:getGo("petpowerupview/new"):GetComponent(ComponentType.UIImgNumeralText)
	self.txtNum = self:getTxt("petpowerupview/add/txtNum")
end

function PetattrpowerupView:bindEvents()
	PetattrpowerupView.super.bindEvents(self)
end

function PetattrpowerupView:unbindEvents()
	PetattrpowerupView.super.unbindEvents(self)
end

function PetattrpowerupView:destroyUI()
	PetattrpowerupView.super.destroyUI(self)
end

function PetattrpowerupView:onEnter()
	PetattrpowerupView.super.onEnter(self)

	local params = self:getOpenParam()

	self.txtName.text = tostring(params[1])
	self.old.text = checknumber(params[2])

	self.new:SetNum(checknumber(params[3]))

	self.txtNum.text = "+" .. checknumber(params[3]) - checknumber(params[2])

	local time = 1.5

	self.tweener = UnityTweens.UITweenFadeOut.StartTween(self.petpowerupview.gameObject, time)

	self.tweener:AddListener(function()
		self:close()
	end)
	removetimer(self.forceClose, self)
	settimer(time + 1, self.forceClose, self, false)
end

function PetattrpowerupView:onEnterFinished()
	PetattrpowerupView.super.onEnterFinished(self)
end

function PetattrpowerupView:onExit()
	PetattrpowerupView.super.onExit(self)
	removetimer(self.forceClose, self)

	self.tweener = nil
end

function PetattrpowerupView:onExitFinished()
	PetattrpowerupView.super.onExitFinished(self)
end

function PetattrpowerupView:forceClose()
	self:close()
end

return PetattrpowerupView
