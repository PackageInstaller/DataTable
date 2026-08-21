-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\GiftRecommendPanel.lua

local WelfarePanelBase = require("UI/Welfare/WelfarePanelBase")
local ResRechargeGuideSubTab = require("ClientData/ResRechargeGuideSubTab")
local ResRechargeGuideConfig = require("ClientData/ResRechargeGuideConfig")
local ResRechargeGuideMain = require("ClientData/ResRechargeGuideMain")
local CommonGiftCell = require("UI/Common/CommonGiftCell")
local strClassName = "GiftRecommendTabCell"
local GiftRecommendTabCell = Class(strClassName, UIControls.Child)

function GiftRecommendTabCell:ctor()
	self.btnSensor = UIControls.Button(self, "", "Text")

	self.btnSensor:addEventClick(self.onSensorClick)
end

function GiftRecommendTabCell:setData(subTabData)
	self.subTabData = subTabData

	self.btnSensor:setText(subTabData.name)
end

function GiftRecommendTabCell:onSensorClick()
	self.mParent:onTabCellClick(self)
end

function GiftRecommendTabCell:setSelected(isSelected)
	self.btnSensor:setEnable(not isSelected)
end

local strClassName = "GiftRecommendContentCell"
local GiftRecommendContentCell = Class(strClassName, UIControls.Child)

function GiftRecommendContentCell:ctor()
	self.imgBg = UIControls.Image(self, "ContentPanel/Bg")
	self.iconNml = UIControls.Image(self, "ContentPanel/IconAward")
	self.imgNameNml = UIControls.Image(self, "ContentPanel/ImgTitle")
	self.imgSlogenNml = UIControls.Image(self, "ContentPanel/ImgSlogan")
	self.bgTime = UIControls.Panel(self, "ContentPanel/BgTime")
	self.textTime = UIControls.Label(self, "ContentPanel/BgTime/TextTime")
	self.btnJump = UIControls.Button(self, "")

	self.btnJump:addEventClick(self.onJumpClick)
end

function GiftRecommendContentCell:setData(contentData)
	self.contentData = contentData

	if contentData.bg_icon_path then
		self.imgBg:setImage("Atlas/" .. contentData.bg_icon_path, contentData.bg_icon)
	end

	self.actObj = nil

	if self.contentData.relate_activity then
		self.actObj = CurAvatar:getActivityObj(self.contentData.relate_activity)
	end

	if self.actObj and self.actObj:inOpenState() then
		self.bgTime:setVisible(true)
		ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.actObj:getRemainOpenTime(), false, "%s")
	else
		self.bgTime:setVisible(false)
	end

	if contentData.icon_path then
		self.iconNml:setImage("Atlas/" .. contentData.icon_path, contentData.icon)
	end

	if contentData.title_icon_path then
		self.imgNameNml:setVisible(true)
		self.imgNameNml:setImage("Atlas/" .. contentData.title_icon_path, contentData.title_icon)
	else
		self.imgNameNml:setVisible(false)
	end

	if contentData.slogen_icon_path then
		self.imgSlogenNml:setVisible(true)
		self.imgSlogenNml:setImage("Atlas/" .. contentData.slogen_icon_path, contentData.slogen_icon)
	else
		self.imgSlogenNml:setVisible(false)
	end
end

function GiftRecommendContentCell:onJumpClick()
	self.mParent:onContentCellClick(self)
end

local strClassName = "GiftRecommendPanel"
local GiftRecommendPanel = Class(strClassName, WelfarePanelBase)

function GiftRecommendPanel:ctor()
	self:initUI()
end

function GiftRecommendPanel:initUI()
	self.tabCells = {}
	self.giftCells = {}
	self.textDesc = UIControls.Label(self, "TipsPanel/TextTime")
end

function GiftRecommendPanel:initPanel()
	for subId, subData in ipairs(ResRechargeGuideSubTab) do
		if not self.tabCells[subId] then
			local newSubCell = GiftRecommendTabCell(self, "SubTabContent", "System/Store/SubTabGuide")

			self.tabCells[subId] = newSubCell

			newSubCell:setData(subData)
		end
	end
end

function GiftRecommendPanel:onOpenPanel()
	self:refreshData()
end

function GiftRecommendPanel:refreshData()
	self.showData = CurAvatar:getValidRechargeGuideData()

	local initSubCell

	for subId, cell in ipairs(self.tabCells) do
		if self.showData[subId] then
			cell:setVisible(true)

			initSubCell = cell
		else
			cell:setVisible(false)
		end
	end

	if not self.selSubId and initSubCell then
		self:onTabCellClick(initSubCell)
	end
end

function GiftRecommendPanel:onTabCellClick(sender)
	for index, cell in ipairs(self.tabCells) do
		cell:setSelected(cell == sender)
	end

	for index, cell in ipairs(self.giftCells) do
		cell:destroy()
	end

	self.giftCells = {}
	self.selSubId = sender.subTabData.sub_id
	self.selShowData = self.showData[self.selSubId]

	self.textDesc:setText(sender.subTabData.desc)

	for index, showData in ipairs(self.selShowData) do
		if showData.show_type == 3 and showData.recharge_id then
			local newCell = CommonGiftCell(self, "AwardList/Content", showData.prefab_path or "System/Common/Grid/GridStoreGiftDaily")

			newCell:setData(showData.recharge_id, showData.relate_activity)

			newCell.contentData = showData
			newCell.mEventClick = Slot(self.onContentCellClick, self)

			newCell:setVisible(true)
			table.insert(self.giftCells, newCell)
		else
			local newCell = GiftRecommendContentCell(self, "AwardList/Content", showData.prefab_path or "System/Common/Grid/GridStoreGiftGuide")

			newCell:setData(showData)
			newCell:setVisible(true)
			table.insert(self.giftCells, newCell)
		end
	end
end

function GiftRecommendPanel:onClosePanel()
	GiftRecommendPanel.super.onClosePanel(self)
end

function GiftRecommendPanel:onContentCellClick(cell)
	local showData = cell.contentData

	if showData and showData.jump_id then
		JumpGuideManager.jump(showData.jump_id, nil, "recommendShowGift", {
			showData.recharge_id
		})
	elseif showData and showData.relate_activity then
		CurAvatar:jumpToShowActivity(showData.relate_activity, {
			"recommendShowGift",
			{
				showData.recharge_id
			}
		})
	end
end

return GiftRecommendPanel
