-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfoTab.lua

local RoleInfoCollectPanel = require("UI/RoleInfo/RoleInfoCollectPanel")
local RoleInfoSignetPanel = require("UI/RoleInfo/RoleInfoSignetPanel")
local RoleInfoSignetSelectPanel = require("UI/RoleInfo/RoleInfoSignetSelectPanel")
local strClassName = "RoleInfoTabPanel"
local RoleInfoTabPanel = Class(strClassName, UIControls.Panel)

function RoleInfoTabPanel:ctor()
	self:initUI()
end

function RoleInfoTabPanel:initUI()
	self.btnInfor = UIControls.Button(self, self.mPath .. "/BtnInfor")

	self.btnInfor:addEventClick(Functor(self.onSelectTabClick, self, "Infor"))

	self.btnCollect = UIControls.Button(self, self.mPath .. "/BtnCollect", "Text")

	self.btnCollect:addEventClick(Functor(self.onSelectTabClick, self, "Collect"))

	self.btnSignet = UIControls.Button(self, self.mPath .. "/BtnAchievement", "Text")

	self.btnSignet:addEventClick(Functor(self.onSelectTabClick, self, "Signet"))

	if UIControls.checkControlFunc(self, self.mPath .. "/BtnCollect/IconNew") then
		self.redHintCollect = UIControls.RedDot(self, self.mPath .. "/BtnCollect/IconNew")

		self.redHintCollect:addHint({
			UIConst.RD_HINT_SIGN
		})
	end

	self.btnInfor:setEnable(false)

	self.curSelectType = "Infor"
end

function RoleInfoTabPanel:setTabData(canEdit, vowList, uid, signetDataList)
	self.canEdit = canEdit
	self.vowData = vowList
	self.signetDataList = signetDataList

	local isSelf = CurAvatar.uid == uid
	local checkShowVow = vowList and #vowList > 0

	self.btnCollect:setVisible(checkShowVow)

	if checkShowVow then
		local collentDesc = isSelf and Lang.get(61163) or Lang.get(66182)

		self.btnCollect:setText(collentDesc)
	end

	local checkSignetOpen = signetDataList and #signetDataList > 0 or isSelf and CurAvatar:checkSignetOpen()

	self.btnSignet:setVisible(checkSignetOpen)
	self:refreshTabView()
end

function RoleInfoTabPanel:onSelectTabClick(type)
	if self.curSelectType == type then
		return
	end

	if self.curSelectType then
		if self.curSelectType == "Infor" then
			self.mWindow.inforPanel:setVisible(false)
			self.btnInfor:setEnable(true)
		elseif self.curSelectType == "Collect" then
			self.collectPanel:setVisible(false)
			self.btnCollect:setEnable(true)
		elseif self.curSelectType == "Signet" then
			self.signetPanel:setVisible(false)
			self.btnSignet:setEnable(true)
		end
	end

	self.curSelectType = type or "Infor"

	self:refreshTabView()
end

function RoleInfoTabPanel:refreshTabView()
	if self.curSelectType == "Infor" then
		self.mWindow.inforPanel:setVisible(true)
		self.btnInfor:setEnable(false)
	elseif self.curSelectType == "Collect" then
		if not self.collectPanel then
			self.collectPanel = RoleInfoCollectPanel(self.mWindow, "CollectPanel")

			local vowData = self.mWindow.roleInfo.vow

			self.collectPanel:setVowData(vowData)
			self.collectPanel:setEditState(self.canEdit)
		end

		self.collectPanel:setVisible(true)
		self.btnCollect:setEnable(false)
	elseif self.curSelectType == "Signet" then
		if not self.signetPanel then
			self.signetPanel = RoleInfoSignetPanel(self.mWindow, "AchievementPanel")

			local selectPanel

			if UIControls.checkControlFunc(self.mWindow, "AchievementListPanel") then
				selectPanel = RoleInfoSignetSelectPanel(self.mWindow, "AchievementListPanel")
			end

			self.signetPanel:init(selectPanel)
		end

		self.signetPanel:setVisible(true)
		self.btnSignet:setEnable(false)
		self.signetPanel:setData(self.signetDataList, self.canEdit)
	end
end

function RoleInfoTabPanel:refreshVowSing()
	if self.collectPanel then
		self.collectPanel:refreshSignData()
	end
end

return RoleInfoTabPanel
