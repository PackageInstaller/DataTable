-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawGroupActivityPanel.lua

local DrawGroupActivityHeroCell = require("UI/DrawCard/DrawGroupActivityHeroCell")
local strClassName = "DrawGroupActivityPanel"
local DrawGroupActivityPanel = Class(strClassName, UIControls.Child)

function DrawGroupActivityPanel:ctor(...)
	self:initUI()
end

function DrawGroupActivityPanel:initUI(...)
	self.activityRootPanel = UIControls.Panel(self, "ActivityPanel")
	self.activityTimeTxt = UIControls.Label(self, "ActivityPanel/TextActivityTime")
	self.actSwitchBtn = UIControls.Button(self, "SwitchPanel/BtnSwitch")

	self.actSwitchBtn:addEventClick(self._onClickSwitch)

	self.btnCommonStatePanel = UIControls.Panel(self, "SwitchPanel/BtnSwitch/ImgSpecial")
	self.btnActStatePanel = UIControls.Panel(self, "SwitchPanel/BtnSwitch/ImgNormal")
end

function DrawGroupActivityPanel:setActivityInfo(actObj)
	self.opId = actObj.opId

	local startEndTime = actObj:getStartEndTime()
	local startTime = startEndTime[1]
	local endTime = startEndTime[2]
	local startTimeTxt = ClientUtils.getServerTimeData(startTime, Lang.get(30270))
	local endTimeTxt = ClientUtils.getServerTimeData(endTime, Lang.get(30270))

	self.activityTimeTxt:setText(startTimeTxt .. "-" .. endTimeTxt)
end

function DrawGroupActivityPanel:refresActivityPanel(skipReplace, detailData)
	self.activityRootPanel:setVisible(not skipReplace)
	self.btnCommonStatePanel:setVisible(skipReplace)
	self.btnActStatePanel:setVisible(not skipReplace)

	if skipReplace then
		if self.showHeroPanel1 then
			self.showHeroPanel1:setVisible(false)
		end

		if self.showHeroPanel2 then
			self.showHeroPanel2:setVisible(false)
		end
	elseif detailData and detailData.show_hero_id then
		local heroId1 = detailData.show_hero_id[1]

		if heroId1 then
			if not self.showHeroPanel1 and UIControls.checkControlFunc(self, "SloganPanel1") then
				self.showHeroPanel1 = DrawGroupActivityHeroCell(self, "SloganPanel1")
			end

			if self.showHeroPanel1 then
				self.showHeroPanel1:setHero(heroId1)
				self.showHeroPanel1:setVisible(true)
			end
		end

		local heroId2 = detailData.show_hero_id[2]

		if heroId2 then
			if not self.showHeroPanel2 and UIControls.checkControlFunc(self, "SloganPanel2") then
				self.showHeroPanel2 = DrawGroupActivityHeroCell(self, "SloganPanel2")
			end

			if self.showHeroPanel2 then
				self.showHeroPanel2:setHero(heroId2)
				self.showHeroPanel2:setVisible(true)
			end
		end
	end
end

function DrawGroupActivityPanel:_onClickSwitch()
	if self.mParent.slotOfSwitchActPool then
		self.mParent.slotOfSwitchActPool()
	end
end

return DrawGroupActivityPanel
