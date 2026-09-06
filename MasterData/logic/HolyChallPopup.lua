-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/HolyChallPopup.lua

module("logic.extensions.kingway.view.HolyChallPopup", package.seeall)

local HolyChallPopup = class("HolyChallPopup", ViewComponent)

function HolyChallPopup:ctor()
	HolyChallPopup.super.ctor(self)
end

function HolyChallPopup:buildUI()
	HolyChallPopup.super.buildUI(self)

	self.titleTxt = goutil.findChildTextComponent(self.mainGO, "titleTxt")
	self.msgTxt = goutil.findChildTextComponent(self.mainGO, "msgTxt")
	self.desTxt = goutil.findChildTextComponent(self.mainGO, "desTxt ")
	self.understoodBtn = self:getBtn("understoodBtn")
	self.titleTxt.text = ""
	self.msgTxt.text = ""
	self.desTxt.text = ""
end

function HolyChallPopup:bindEvents()
	HolyChallPopup.super.bindEvents(self)
	self.understoodBtn:AddClickListener(self.close, self)
end

function HolyChallPopup:unbindEvents()
	HolyChallPopup.super.unbindEvents(self)
	self.understoodBtn:RemoveClickListener()
end

function HolyChallPopup:onExit()
	HolyChallPopup.super.onExit(self)
	HolyChallModel.instance:SetChallengePopupData()
end

function HolyChallPopup:destroyUI()
	HolyChallPopup.super.destroyUI(self)
end

function HolyChallPopup:onEnter()
	HolyChallPopup.super.onEnter(self)

	local info = HolyChallModel.instance:GetChallengePopupData()

	if info == nil or checknumber(info.energyPrize) <= 0 then
		printError("sr------   HolyChallPopup:onEnter()     圣光飞龙    弹窗界面数据空！！")

		return
	end

	if info.isTrial then
		self.titleTxt.text = "战斗结束"

		local currStr = tostring(info.currHit)

		if info.currHit >= 1000 then
			local str = string.format("%.1f", info.currHit / 10000)

			currStr = str .. "万"
		end

		local allStr = tostring(info.allHit)

		if info.allHit >= 1000 then
			local str = string.format("%.1f", info.allHit / 10000)

			allStr = str .. "万"
		end

		self.msgTxt.text = string.format("本次伤害：%s\n今日累计伤害：%s", currStr, allStr)
		self.desTxt.text = string.format("恭喜你，当前获得了%s能量值！", info.energyPrize)

		return
	end

	self.titleTxt.text = "战斗胜利"
	self.msgTxt.text = string.format("恭喜你，成功击败了%s，获得了%s能量值", info.petName, info.energyPrize)
	self.desTxt.text = ""
end

return HolyChallPopup
