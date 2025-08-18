-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\ChooseBadgePanel.lua

local strClassName = "BtnChooseBadge"
local BtnChooseBadge = Class(strClassName, UIControls.Child)

function BtnChooseBadge:ctor()
	self:initUI()
end

function BtnChooseBadge:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)
	self.btnTips:setVisible(false)
end

function BtnChooseBadge:onBtnSelfClick()
	self.mParent:onBtnSelectClick(self.btnSelf)
end

function BtnChooseBadge:setBadge(badge)
	self.badge = badge
	self.badgeGrid = UIControls.ArtifactGridChild(self, "GridBadgeItemPanel", "System/Common/Grid/GridBadgeSmallItem", 0, 0, true)

	self.badgeGrid:setObj(self.badge)
end

function BtnChooseBadge:onBtnTipsClick()
	UIManager.getUI("artifactTips"):show(self.badgeGrid)
end

local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local strClassName = "ChooseBadgeTipsPanel"
local ChooseBadgeTipsPanel = Class(strClassName, UIControls.Panel)

function ChooseBadgeTipsPanel:ctor()
	self:initUI()
end

function ChooseBadgeTipsPanel:initUI()
	self.txtBadgeName = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.imgCareer = UIControls.Image(self, self.mPath .. "/JobPanel/IconJob")
	self.txtCareer = UIControls.Label(self, self.mPath .. "/JobPanel/TextJob")
	self.txtSkillDes = UIControls.Label(self, self.mPath .. "/TextBuff")
	self.attrList = {}

	for i = 1, 2 do
		local attrPanel = HeroAttrPanel(self, self.mPath .. "/AttrPanel/Attr0" .. i)

		table.insert(self.attrList, attrPanel)
	end
end

function ChooseBadgeTipsPanel:setBadge(badge)
	self.badge = badge

	self.txtBadgeName:setText(self.badge.name)

	local props = self.badge:getArtifactAttrs()
	local index = 1

	for propName, propValue in pairs(props) do
		if self.attrList[index] then
			local zhName, attrValue = ClientUtils.getRolePropZhName(propName, propValue)
			local attriconInfo = ClientUtils.getRolePropIcon(propName)

			self.attrList[index].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
			self.attrList[index]:setData(zhName, attrValue)

			index = index + 1
		end
	end

	for i = index, #self.attrList do
		self.attrList[i]:setVisible(false)
	end

	self.txtCareer:setText(Const.CAREER_CONFIG[self.badge.career].name)

	local careerIcon = self.badge:getCareerIconPath()

	if careerIcon then
		self.imgCareer:setImage(careerIcon[1], careerIcon[2])
	end

	local skill = self.badge.skill

	if skill then
		self.txtSkillDes:setText(skill.desc)
	end
end

local ChoosePanel = require("UI/MainState/Item/OpenChoose/ChoosePanel")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "ChooseBadgePanel"
local ChooseBadgePanel = Class(strClassName, ChoosePanel)

function ChooseBadgePanel:ctor()
	self:_initUI()
end

function ChooseBadgePanel:_initUI()
	self.cells = {}
	self.panelTips = ChooseBadgeTipsPanel(self, self.mPath .. "/TipsPanel")
end

function ChooseBadgePanel:setItem(itemGift)
	self.itemGift = itemGift

	self.txtTitle:setText(self.itemGift.name)
	self.txtTimes:setText(self.itemGift.num)

	for i, random_id in ipairs(self.itemGift.resData.extend_args3) do
		local badgeId = ResRandClient[random_id].show_ids[1]
		local badgeCell = BtnChooseBadge(self, self.mPath .. "/BadgeList/Content", "System/Bag/BtnChooseBadge", 0, 0, true)
		local fakeBadge = BaseObject.GetObject(badgeId)

		badgeCell:setBadge(fakeBadge)

		self.btnList[i] = badgeCell.btnSelf
		self.btnList[i].idx = i
		self.cells[i] = badgeCell
	end

	self:onBtnSelectClick(self.btnList[1])
end

function ChooseBadgePanel:onBtnSelectClick(sender)
	for i, btn in ipairs(self.btnList) do
		self.btnList[i]:setEnable(sender ~= btn)

		if sender == btn then
			self.curSelectIdx = btn.idx

			self.panelTips:setBadge(self.cells[self.curSelectIdx].badge)
		end
	end
end

return ChooseBadgePanel
