-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawGroupActivityMultiPanel.lua

local Hero = require("Common/Object/Hero")
local ResNewHeroMisc = require("ClientData/ResNewHeroMisc")
local DrawGroupActivityHeroCell = require("UI/DrawCard/DrawGroupActivityHeroCell")
local DrawGroupActivityHeroChild = Class("DrawGroupActivityHeroChild", UIControls.Child)

function DrawGroupActivityHeroChild:ctor()
	self:initUI()
end

function DrawGroupActivityHeroChild:initUI()
	self.panelSwitch = UIControls.Panel(self, "SwitchPanel")

	self.panelSwitch:setVisible(false)

	self.panelActivity = UIControls.Panel(self, "ActivityPanel")

	self.panelActivity:setVisible(false)

	self.panelSlogin = DrawGroupActivityHeroCell(self, "SloganPanel1")

	self.panelSlogin:setVisible(true)
end

function DrawGroupActivityHeroChild:setHero(heroId)
	self.panelSlogin:setHero(heroId)
end

local strClassName = "DrawGroupActivityMultiPanel"
local DrawGroupActivityMultiPanel = Class(strClassName, UIControls.Child)

function DrawGroupActivityMultiPanel:ctor(...)
	self:initUI()
end

function DrawGroupActivityMultiPanel:initUI(...)
	self.actSwitchBtn = UIControls.Button(self, "BtnSwitch")

	self.actSwitchBtn:addEventClick(self._onClickSwitch)

	self.btnCommonStatePanel = UIControls.Panel(self, "BtnSwitch/ImgSpecial")
	self.btnActStatePanel = UIControls.Panel(self, "BtnSwitch/ImgNormal")
end

function DrawGroupActivityMultiPanel:setActivityInfo(actObj)
	self.opId = actObj.opId
end

function DrawGroupActivityMultiPanel:refresActivityPanel(skipReplace, detailData)
	self.btnCommonStatePanel:setVisible(skipReplace)
	self.btnActStatePanel:setVisible(not skipReplace)

	if skipReplace then
		if self.gridHero then
			self.gridHero:destroy()

			self.gridHero = nil
		end

		if self.showHeroPanel1 then
			self.showHeroPanel1:setVisible(false)
		end
	else
		if detailData and detailData.fake_hero_id then
			if not self.gridHero then
				self.gridHero = UIControls.HeroGridChild(self, "HeroPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)
			end

			local hero = Hero({
				resid = detailData.fake_hero_id
			})

			self.gridHero:setObj(hero)
		end

		if detailData and detailData.show_hero_id then
			local heroId1 = detailData.show_hero_id[1]

			if ResNewHeroMisc[heroId1] and ResNewHeroMisc[heroId1].slogen_child then
				if not self.showHeroPanelDict then
					self.showHeroPanelDict = {}
				end

				if self.showHeroPanel1 then
					self.showHeroPanel1:setVisible(false)
				end

				if not self.showHeroPanelDict[heroId1] then
					self.showHeroPanelDict[heroId1] = DrawGroupActivityHeroChild(self, "", "System/HeroPool/ActivityGroup/" .. ResNewHeroMisc[heroId1].slogen_child)
				end

				self.showHeroPanel1 = self.showHeroPanelDict[heroId1]
			end

			if self.showHeroPanel1 then
				self.showHeroPanel1:setHero(heroId1)
				self.showHeroPanel1:setVisible(true)
			end
		elseif self.showHeroPanel1 then
			self.showHeroPanel1:setVisible(false)
		end
	end
end

function DrawGroupActivityMultiPanel:_onClickSwitch()
	if self.mParent.slotOfOpenChooseHero then
		self.mParent.slotOfOpenChooseHero()
	end
end

return DrawGroupActivityMultiPanel
