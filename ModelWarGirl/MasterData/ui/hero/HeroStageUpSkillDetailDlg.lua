-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroStageUpSkillDetailDlg.lua

local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local strClassName = "HeroStageUpSkillDetailDlg"
local HeroStageUpSkillDetailDlg = Class(strClassName, UIControls.Window)

function HeroStageUpSkillDetailDlg:ctor()
	self:initUI()
end

function HeroStageUpSkillDetailDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtBeforeLv = UIControls.Label(self, "BgPanel/ScrollView/Content/PrePanel/TextLv")
	self.txtAfterLv = UIControls.Label(self, "BgPanel/ScrollView/Content/AfterPanel/TextLv")
	self.txtBeforeDesc = UIControls.Label(self, "BgPanel/ScrollView/Content/PrePanel/Text")
	self.txtAfterDesc = UIControls.Label(self, "BgPanel/ScrollView/Content/AfterPanel/Text")
	self.imgBgPanel = UIControls.Image(self, "BgPanel")
	self.scrollSkillDesc = UIControls.ScrollView(self, "BgPanel/ScrollView")
	self.panelChange = UIControls.Panel(self, "BgPanel/ScrollView/Content/ChangePanel")
	self.txtChange = UIControls.Label(self, "BgPanel/ScrollView/Content/ChangePanel/TxtChange")
end

function HeroStageUpSkillDetailDlg:setSkillInfo(skill)
	self.skill = skill

	self.txtBeforeLv:setText(self.skill.level - 1)
	self.txtAfterLv:setText(self.skill.level)
	self.txtAfterDesc:setText(self.skill.desc)
	self.txtChange:setVisible(false)

	if self.skill.level == 1 then
		self.txtBeforeDesc:setText(Lang.get(195))
	else
		local lastDesc = ""
		local battleDesc = ""

		if self.skill.isPassive then
			lastDesc = ResPassiveSkill[self.skill.id][self.skill.level - 1].desc

			if ResPassiveSkill[self.skill.id][self.skill.level].battle_desc then
				self.txtChange:setVisible(true)

				battleDesc = "↑" .. ResPassiveSkill[self.skill.id][self.skill.level].battle_desc
			end
		else
			lastDesc = ResSkillConfig[self.skill.id][self.skill.level - 1].skill_desc

			if ResSkillConfig[self.skill.id][self.skill.level].battle_desc then
				self.txtChange:setVisible(true)

				battleDesc = "↑" .. ResSkillConfig[self.skill.id][self.skill.level].battle_desc
			end
		end

		self.txtChange:setText(battleDesc)
		self.txtBeforeDesc:setText(lastDesc)
	end

	self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
end

function HeroStageUpSkillDetailDlg:yieldSetScrollStatus()
	coroutine.step()

	local contentSize = self.scrollSkillDesc:getContentSize()
	local changeSize = self.panelChange:getRectSize()

	if contentSize[2] + changeSize.height <= 764 then
		self.scrollSkillDesc:cancelScroll()
	end

	self.imgBgPanel:setSize(contentSize[1], math.min(contentSize[2] + changeSize.height, 764) + 44)
end

function HeroStageUpSkillDetailDlg:destroy()
	if self.setScrollStatus then
		coroutine.stop(self.setScrollStatus)
	end

	HeroStageUpSkillDetailDlg.super.destroy(self)
end

function HeroStageUpSkillDetailDlg:onBtnCloseClick()
	self:setVisible(false)
end

return HeroStageUpSkillDetailDlg
