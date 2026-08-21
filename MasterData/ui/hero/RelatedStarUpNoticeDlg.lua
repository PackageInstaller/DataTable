-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\RelatedStarUpNoticeDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResVoidHero = require("ClientData/ResVoidHero")
local ResHero = require("ClientData/ResHero")
local strClassName = "RelatedStarUpNoticeDlg"
local RelatedStarUpNoticeDlg = Class(strClassName, UIControls.Window)

function RelatedStarUpNoticeDlg:ctor()
	self:initUI()
end

function RelatedStarUpNoticeDlg:initUI()
	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.textRule = UIControls.Label(self, "Bg/ContentPanel/TextContent")
	self.gridUniqueHero = UIControls.RelatedHeroGridChild(self, "Bg/VanityHeroPanel/GridLeftPanel", "System/Hero/GridVanityHeroStarUp", 0, 0, true)
	self.gridRelatedHero = UIControls.RelatedHeroGridChild(self, "Bg/VanityHeroPanel/GridRightPanel", "System/Hero/GridVanityHeroStarUp", 0, 0, true)
end

local MODE_STARTUP = 1
local MODE_BACKSTAR = 2
local MODE_EATED = 3

function RelatedStarUpNoticeDlg:setHero(heroId, mode, confirmCb)
	self.confirmCb = confirmCb

	local ruleDesc = ""

	if mode == MODE_STARTUP then
		self.relateData = Const.UNIQUE_HERO[heroId]

		if not self.relateData then
			return
		end

		ruleDesc = ResInfoNotice[252].content
	else
		self.relateData = ResVoidHero[heroId]

		if not self.relateData then
			return
		end

		if mode == MODE_BACKSTAR then
			ruleDesc = ResInfoNotice[253].content
		else
			ruleDesc = ResInfoNotice[254].content
		end
	end

	local uniqueHeroName = ResHero[self.relateData.voidhero_resid].full_name or ""
	local relatedHeroName = ResHero[self.relateData.resid].full_name or ""

	ruleDesc = utils.replaceString(ruleDesc, "#1", uniqueHeroName)
	ruleDesc = utils.replaceString(ruleDesc, "#2", relatedHeroName)

	self.textRule:setText(ruleDesc)
	self.gridUniqueHero:setHero(self.relateData.voidhero_resid)
	self.gridRelatedHero:setHero(self.relateData.resid)
end

function RelatedStarUpNoticeDlg:onDenyClick()
	self:setVisible(false)
end

function RelatedStarUpNoticeDlg:onConfirmClick()
	if self.confirmCb then
		self.confirmCb()
	end

	self:setVisible(false)
end

return RelatedStarUpNoticeDlg
