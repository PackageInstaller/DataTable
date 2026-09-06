-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplaceshowtipView.lua

module("logic.extensions.nineplace.view.NineplaceshowtipView", package.seeall)

local NineplaceshowtipView = class("NineplaceshowtipView", ViewComponent)

function NineplaceshowtipView:ctor()
	NineplaceshowtipView.super.ctor(self)
end

function NineplaceshowtipView:buildUI()
	NineplaceshowtipView.super.buildUI(self)

	self.btnClose = self:getBtn("btnclose")
	self.iconFor = self:getGo("icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self.txtName = self:getTxt("name/txt")
	self.showTips1 = self:getTxt("showTips/txt1")
	self.showTips2 = self:getTxt("showTips/txt2")
	self.showTips3 = self:getTxt("showTips/txt3")
	self.showTips4 = self:getTxt("showTips/txt4")
	self.showTips5 = self:getTxt("showTips/txt5")
	self.showTips6 = self:getTxt("showTips/txt6")
end

function NineplaceshowtipView:bindEvents()
	NineplaceshowtipView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
end

function NineplaceshowtipView:unbindEvents()
	NineplaceshowtipView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
end

function NineplaceshowtipView:destroyUI()
	NineplaceshowtipView.super.destroyUI(self)
end

function NineplaceshowtipView:onEnter()
	NineplaceshowtipView.super.onEnter(self)

	local param = self:getFirstParam()
	local cfg = NinePlaceConfig.instance:getStageCfgById(param)
	local maxLv = BattleConfig.instance:getFormStrengthMaxLv(param)

	self.iconFor:SetState(param - 1)

	local str = cfg.name .. "法"
	local setStr = str

	self.txtName.text = lang(str)
	setStr = string.format("解锁后为%s1级", str)
	self.showTips1.text = lang(setStr)
	setStr = string.format("%s最高%s级", str, maxLv)
	self.showTips4.text = lang(setStr)

	local stageCfg = BattleConfig.instance:getFormStrengthLvCfg(param, 1)

	str = self:getShowsAttrStr(stageCfg.properties)
	setStr = string.format("激活效果：%s", str)
	self.showTips2.text = lang(setStr)
	str = self:getShowsAttrStr(stageCfg.passiveProperties)
	setStr = string.format("全体加成：%s", str)
	self.showTips3.text = lang(setStr)
	stageCfg = BattleConfig.instance:getFormStrengthLvCfg(param, maxLv)
	str = self:getShowsAttrStr(stageCfg.properties)
	setStr = string.format("激活效果：%s", str)
	self.showTips5.text = lang(setStr)
	str = self:getShowsAttrStr(stageCfg.passiveProperties)
	setStr = string.format("全体加成：%s", str)
	self.showTips6.text = lang(setStr)
end

function NineplaceshowtipView:onEnterFinished()
	NineplaceshowtipView.super.onEnterFinished(self)
end

function NineplaceshowtipView:onExit()
	NineplaceshowtipView.super.onExit(self)
end

function NineplaceshowtipView:onExitFinished()
	NineplaceshowtipView.super.onExitFinished(self)
end

function NineplaceshowtipView:getShowsAttrStr(attrs)
	local attrList = FightingPowerFormula.instance:parseAttrValues(attrs) or {}
	local showStr = {}

	for k, v in pairs(attrList) do
		local name, value = GameUtil.getPropertyInfo(k, v)
		local addstr = string.format("%s+%s", name, value)

		table.insert(showStr, addstr)
	end

	return table.concat(showStr, ",")
end

return NineplaceshowtipView
