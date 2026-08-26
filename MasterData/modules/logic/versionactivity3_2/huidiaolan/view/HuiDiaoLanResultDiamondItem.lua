-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanResultDiamondItem.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanResultDiamondItem", package.seeall)

local HuiDiaoLanResultDiamondItem = class("HuiDiaoLanResultDiamondItem", LuaCompBase)

function HuiDiaoLanResultDiamondItem:ctor(param)
	self.param = param
	self.index = param.index
end

function HuiDiaoLanResultDiamondItem:init(go)
	self:__onInit()

	self.go = go
	self.anim = self.go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self.go, false)
end

function HuiDiaoLanResultDiamondItem:addEventListeners()
	return
end

function HuiDiaoLanResultDiamondItem:removeEventListeners()
	return
end

function HuiDiaoLanResultDiamondItem:showAnim(animTime)
	TaskDispatcher.runDelay(self.doShowItem, self, animTime)
end

function HuiDiaoLanResultDiamondItem:doShowItem()
	gohelper.setActive(self.go, true)
	self.anim:Play("go_diamond_open", 0, 0)
	self.anim:Update(0)
end

function HuiDiaoLanResultDiamondItem:stopAnim()
	TaskDispatcher.cancelTask(self.doShowItem, self)
end

function HuiDiaoLanResultDiamondItem:destroy()
	self:stopAnim()
end

return HuiDiaoLanResultDiamondItem
