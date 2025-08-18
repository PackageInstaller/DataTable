-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityShowBadgePage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResActivityArtifactNewOpen = require("ClientData/ResActivityArtifactNewOpen")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResHero = require("ClientData/ResHero")
local UserData = require("Helper/UserData")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local ResColor = require("ClientData/ResColor")

local function SortSkinPage(a, b)
	if a.order and b.order then
		return a.order < b.order
	elseif a.order then
		return true
	end
end

local NewBadgeTabBtn = Class("NewBadgeTabBtn", UIControls.Child)

function NewBadgeTabBtn:ctor()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.imgBg = UIControls.Image(self, "BadgePanel/Bg")
	self.imgIcon = UIControls.Image(self, "BadgePanel/Icon")
	self.imgType = UIControls.Image(self, "ImgStatus")
	self.imgNewOpen = UIControls.Panel(self, "IconNewOpen")
end

function NewBadgeTabBtn:setData(groupInfo)
	self.data = groupInfo
	self.artifactObj = BaseObject.GetObject(groupInfo.artifact_id)

	if self.artifactObj then
		local iconPath = self.artifactObj:getIconPath()

		if iconPath and iconPath[1] and iconPath[2] then
			self.imgIcon:setImage(iconPath[1], iconPath[2])
		end

		local bgPath = self.artifactObj:getCareerBgIconPath()

		if bgPath and bgPath[1] and bgPath[2] then
			self.imgBg:setImage(bgPath[1], bgPath[2])
		end
	end

	if self.data.type_icon_path then
		self.imgType:setVisible(true)
		self.imgType:setImage(self.data.type_icon_path, self.data.type_icon)
	else
		self.imgType:setVisible(false)
	end

	self.isNewOpen = CurAvatar:newOpenArtifactRedDot(self.data)

	self.imgNewOpen:setVisible(self.isNewOpen)
end

function NewBadgeTabBtn:setSelected(isSel)
	self.btnSensor:setEnable(not isSel)
end

function NewBadgeTabBtn:onSensorClick()
	self:_onClick()
end

function NewBadgeTabBtn:_onClick(isInit)
	if self.mEventClick then
		self:mEventClick()
	end

	self:setSelected(true)

	if not isInit and self.isNewOpen then
		self.isNewOpen = false

		self.imgNewOpen:setVisible(false)
		CurAvatar:saveNewOpenArtifactRedDot(self.data)
	end
end

local classNameStr = "ActivityShowBadgePage"
local ActivityShowBadgePage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityShowBadgePage, ActivityPanelMixin)

local MAX_JUMP_NUM = 3

function ActivityShowBadgePage:initUI()
	self.bg = UIControls.Image(self, "Bg")
	self.txtTime = UIControls.Label(self, "BgTime/TextTime")
	self.imgTitle = UIControls.Image(self, "TitlePanel/ImgTitle")
	self.titleNew = UIControls.Panel(self, "TitlePanel/TextStatusNew")
	self.titleReturn = UIControls.Panel(self, "TitlePanel/TextStatusReturn")
	self.imgBg = UIControls.Image(self, "BadgeInfoPanel/BadgePanel/Bg")
	self.imgIcon = UIControls.Image(self, "BadgeInfoPanel/BadgePanel/Icon")
	self.tabBtns = {}
	self.jumpBtns = {}

	for index = 1, MAX_JUMP_NUM do
		local newBtn = UIControls.Button(self, "BadgeInfoPanel/BgAccess/BtnGo" .. index, "Text")

		newBtn:addEventClick(self.onBtnGo)
		table.insert(self.jumpBtns, newBtn)
	end

	self.textDesc = UIControls.Label(self, "BadgeInfoPanel/BgFeature/Text")
	self.btnTips = UIControls.Button(self, "BadgeInfoPanel/BgFeature/BtnTips")

	self.btnTips:addEventClick(self.onTipsClick)
end

function ActivityShowBadgePage:_setData()
	self.clientData = {}

	for _, groupInfo in pairs(ResActivityArtifactNewOpen) do
		if ClientUtils.isNewArtifactValid(groupInfo) then
			local actId = groupInfo.relate_activity

			if actId then
				local actObj = CurAvatar:getActivityObj(actId)

				if actObj and actObj:isValid() then
					CurAvatar:addActivityRelated(actId, "activityMainDlg")
					table.insert(self.clientData, groupInfo)
				end
			else
				table.insert(self.clientData, groupInfo)
			end
		end
	end

	table.sort(self.clientData, SortSkinPage)
end

function ActivityShowBadgePage:_onShow(isOnPageShow)
	if not isOnPageShow then
		self:refreshCells()
	elseif self.tabBtns[1] then
		self.tabBtns[1]:onSensorClick()
	end
end

function ActivityShowBadgePage:refreshCells()
	for i = #self.tabBtns, #self.clientData - 1 do
		local newBtn = NewBadgeTabBtn(self, "ListPanel/Content", "System/Activity/ActivityNewBadgeCell", 0, 0)

		table.insert(self.tabBtns, newBtn)

		newBtn.mEventClick = Slot(self.onArtifactBtnClick, self)
	end

	for i, btn in ipairs(self.tabBtns) do
		if self.clientData[i] then
			btn:setData(self.clientData[i])
			btn:setVisible(true)
		else
			btn:setVisible(false)
		end
	end

	if self.tabBtns[1] then
		self.tabBtns[1]:_onClick(true)
	end
end

function ActivityShowBadgePage:onArtifactBtnClick(sender)
	if self.curSelCell then
		self.curSelCell:setSelected(false)
	end

	self.curSelCell = sender

	self:refreshInfoPanel()
end

function ActivityShowBadgePage:refreshInfoPanel()
	self.actObj = nil

	if self.curSelCell then
		local showData = self.curSelCell.data
		local artifactObj = self.curSelCell.artifactObj

		if showData.icon_path and showData.icon then
			self.bg:setImage(showData.icon_path, showData.icon)
		end

		if showData.title_icon_path and showData.title_icon then
			self.imgTitle:setImage(showData.title_icon_path, showData.title_icon)
		end

		local iconPath = artifactObj:getIconPath()

		if iconPath and iconPath[1] and iconPath[2] then
			self.imgIcon:setImage(iconPath[1], iconPath[2])
		end

		local bgPath = artifactObj:getCareerBgIconPath()

		if bgPath and bgPath[1] and bgPath[2] then
			self.imgBg:setImage(bgPath[1], bgPath[2])
		end

		if showData.relate_activity then
			local actObj = CurAvatar:getActivityObj(showData.relate_activity)

			if actObj and actObj:isValid() then
				self.actObj = actObj
			end
		end

		self.titleReturn:setVisible(showData.type_flag == 1)
		self.titleNew:setVisible(showData.type_flag ~= 1)

		if showData.timer_txt then
			ClientTimerManager.RemoveSecondTickUI(self.txtTime)
			self.txtTime:setText(showData.timer_txt or "")
		elseif self.actObj then
			ClientTimerManager.RemoveSecondTickUI(self.txtTime)
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actObj:getRemainOpenTime(), false, Lang.get(48657), Slot(self._timerOver, self))
		end

		self.textDesc:setText(artifactObj.resData.new_page_desc or "")

		for index, btn in ipairs(self.jumpBtns) do
			if showData["desc" .. index] then
				btn:setVisible(true)
				btn:setText(showData["desc" .. index])

				btn.jumpId = showData["jump" .. index .. "_id"]
			else
				btn:setVisible(false)
			end
		end
	end
end

function ActivityShowBadgePage:_timerOver()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	self.txtTime:setText(Lang.get(32785))
end

function ActivityShowBadgePage:onActivityDataRefresh(actObj)
	self:updateRelatedActivityData(actObj)
end

function ActivityShowBadgePage:updateRelatedActivityData(actObj)
	for index, cell in ipairs(self.tabBtns) do
		if cell.data and cell.data.relate_activity == actObj.actId then
			cell:setData(cell.data)

			break
		end
	end

	if self.curSelCell and self.curSelCell.data.relate_activity == actObj.actId then
		self:refreshInfoPanel()
	end
end

function ActivityShowBadgePage:onTipsClick()
	if self.curSelCell then
		BaseObject.ShowObjectTips(self.curSelCell.data.artifact_id, 1, self)
	end
end

function ActivityShowBadgePage:onBtnGo(sender)
	if sender.jumpId then
		JumpGuideManager.jump(sender.jumpId)
	end
end

return ActivityShowBadgePage
