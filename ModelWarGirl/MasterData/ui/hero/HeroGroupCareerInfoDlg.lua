-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroGroupCareerInfoDlg.lua

local strClassName = "HeroGroupCareerInfoDlg"
local HeroGroupCareerInfoDlg = Class(strClassName, UIControls.Window)

function HeroGroupCareerInfoDlg:ctor()
	self:initUI()
end

function HeroGroupCareerInfoDlg:initUI()
	self.panelGroup = UIControls.Panel(self, "BgPanel/GroupInfo")
	self.panelCareer = UIControls.Panel(self, "BgPanel/CareerInfo")
	self.panelTeam = UIControls.Panel(self, "BgPanel/TeamInfo")
	self.panelList = {
		self.panelGroup,
		self.panelCareer,
		self.panelTeam
	}
	self.btnTabList = {}

	for i = 1, 3 do
		local btnTab = UIControls.Button(self, "BgPanel/TabPanel/Btn" .. i)

		btnTab:addEventClick(self.onBtnTabClick)
		table.insert(self.btnTabList, btnTab)
	end

	self.comGroupList = {}

	for i = 1, 5 do
		local txtName = UIControls.Label(self, "BgPanel/GroupInfo/Group" .. i .. "/TextGroupName")

		txtName:setVisible(not RegionUtils.isCurrentLanguage(RegionConst.LANGUAGE_ENG))
		txtName:setText(Const.CAMP_CONFIG[i].name)

		local txtDes = UIControls.Label(self, "BgPanel/GroupInfo/Group" .. i .. "/TextDes")

		txtDes:setText(Const.CAMP_CONFIG[i].des)
		table.insert(self.comGroupList, {
			txtName,
			txtDes
		})
	end

	self.comCareerList = {}

	for i = 1, 5 do
		local txtName = UIControls.Label(self, "BgPanel/CareerInfo/Career" .. i .. "/TextCareerName")

		txtName:setText(Const.CAREER_CONFIG[i].name)

		local txtDes = UIControls.Label(self, "BgPanel/CareerInfo/Career" .. i .. "/TextDes")

		txtDes:setText(Const.CAREER_CONFIG[i].des)

		local txtEnName = UIControls.Label(self, "BgPanel/CareerInfo/Career" .. i .. "/TextCareerEn")

		txtEnName:setVisible(not RegionUtils.isCurrentLanguage(RegionConst.LANGUAGE_ENG))
		txtEnName:setText(Const.CAREER_CONFIG[i].en_name)
		table.insert(self.comCareerList, {
			txtName,
			txtDes,
			txtEnName
		})
	end

	self.comTeamList = {}

	for i = 1, 6 do
		local txtName = UIControls.Label(self, "BgPanel/TeamInfo/Content/Career" .. i .. "/TextCareerName")

		txtName:setText(Const.HERO_TEAM_CONFIG[i].name)

		local txtDes = UIControls.Label(self, "BgPanel/TeamInfo/Content/Career" .. i .. "/TextDes")

		txtDes:setText(Const.HERO_TEAM_CONFIG[i].des or "")

		local txtEnName = UIControls.Label(self, "BgPanel/TeamInfo/Content/Career" .. i .. "/TextCareerEn")

		txtEnName:setVisible(not RegionUtils.isCurrentLanguage(RegionConst.LANGUAGE_ENG))
		txtEnName:setText(Const.HERO_TEAM_CONFIG[i].en_name or "")
		table.insert(self.comTeamList, {
			txtName
		})
	end

	self:onBtnTabClick(self.btnTabList[2])
end

function HeroGroupCareerInfoDlg:onBtnTabClick(sender)
	for i, btn in ipairs(self.btnTabList) do
		if btn == sender then
			btn:setEnable(false)
			self.panelList[i]:setVisible(true)
		else
			btn:setEnable(true)
			self.panelList[i]:setVisible(false)
		end
	end
end

return HeroGroupCareerInfoDlg
