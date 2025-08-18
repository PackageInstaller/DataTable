-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomPartsDlg.lua

local strClassName = "HeroShowRoomPartsDlg"
local HeroShowRoomPartsDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomPartsDlg:ctor()
	self:initUI()
end

function HeroShowRoomPartsDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)

	self.txtStoryTitle = UIControls.Label(self, "MainInfoPanel/StoryCoverPanel/BgTextStoryTitle/TextStoryTitle")
	self.imgIconItem = UIControls.Image(self, "MainInfoPanel/StoryCoverPanel/IconStory/IconStory")
	self.txtContent = UIControls.Label(self, "MainInfoPanel/TextContentList/Content/TextContent")
	self.btnPanelStoryLock = UIControls.Button(self, "MainInfoPanel/StoryLockPanel")

	self.btnPanelStoryLock:addEventClick(self.onBtnPanelStoryLockClick)

	self.txtStoryLockRule1 = UIControls.Label(self, "MainInfoPanel/StoryLockPanel/TextStoryLockRule1")
	self.txtStoryLockTips = UIControls.Label(self, "MainInfoPanel/StoryLockPanel/TextStoryLocktips")
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.scrollList = UIControls.ScrollView(self, "MainInfoPanel/TextContentList")

	self.scrollList:addEventValueChanged(self._onScrollValueChanged)

	self.panelArrow = UIControls.Panel(self, "MainInfoPanel/ArrowNext")
end

function HeroShowRoomPartsDlg:yieldSetScrollStatus()
	self.scrollList:gotoTop()
	coroutine.step()

	local contentSize = self.scrollList:getContentSize()
	local maxHeight = self.scrollList:getSize().height

	if maxHeight >= contentSize[2] then
		self.scrollList:cancelScroll()
		self.panelArrow:setVisible(false)
	else
		self.panelArrow:setVisible(true)
		self.scrollList:openScroll(true)

		self.isSetedScroll = true
	end
end

function HeroShowRoomPartsDlg:_onScrollValueChanged(sender, valueX, valueY)
	if not self.isSetedScroll then
		return
	end

	local barValue = self.scrollList:getVerticalValue()

	if barValue == self.oldBarValue then
		return
	end

	self.oldBarValue = barValue

	if barValue == 0 then
		self.panelArrow:setVisible(false)
	else
		self.panelArrow:setVisible(true)
	end
end

function HeroShowRoomPartsDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroShowRoomPartsDlg:onBtnPanelStoryLockClick()
	if not self.isUnLocked then
		MsgManager.clientNotice(624)
	end
end

function HeroShowRoomPartsDlg:setRelationDescResData(descInfo, itemIconPath, autoOpen)
	self.descInfo = descInfo
	self.isUnLocked = self.descInfo ~= nil
	self.autoOpen = autoOpen

	self.btnPanelStoryLock:setVisible(not self.isUnLocked)

	if self.isUnLocked then
		self.txtStoryTitle:setText(self.descInfo.title)

		if itemIconPath then
			self.imgIconItem:setImage(itemIconPath[1], itemIconPath[2])

			if itemIconPath[3] then
				self.imgIconItem:setPosition(nil, itemIconPath[3])
			else
				self.imgIconItem:setPosition(nil, 0)
			end
		end

		self.txtContent:setText(self.descInfo.content)
	else
		self.imgIconItem:setImage("Atlas/CommonAtlas/IconAtlas/ShowRoomAticleAtlas/ShowRoomAticleAtlas05", "IconLockBox")
		self.txtStoryTitle:setText(ClientUtils.getClientNotice(620))
	end

	local playAniName = self.autoOpen and "OpenPartsUnLockCanvas" or "OpenPartsCanvas"

	self.uiAni:startAni(playAniName, true)
end

function HeroShowRoomPartsDlg:_onAniFinish(aniCom, aniName)
	if aniName == "OpenPartsUnLockCanvas" or aniName == "OpenPartsCanvas" then
		self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
	end
end

return HeroShowRoomPartsDlg
