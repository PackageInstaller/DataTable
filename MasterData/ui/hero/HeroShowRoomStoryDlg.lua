-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomStoryDlg.lua

local strClassName = "StoryCoverPanel"
local StoryCoverPanel = Class(strClassName, UIControls.Panel)

function StoryCoverPanel:ctor()
	self:initUI()
end

function StoryCoverPanel:initUI()
	self.btnPanelStoryCover = UIControls.Button(self, self.mPath)

	self.btnPanelStoryCover:addEventClick(self.onBtnPanelStoryCoverClick)

	self.txtStoryTitle = UIControls.Label(self, self.mPath .. "/BgTitle/TextStoryTitle")
	self.panelStoryLock = UIControls.Panel(self, self.mPath .. "/StoryLockPanel")
	self.imgBgOtherTitle1 = UIControls.Image(self, self.mPath .. "/BgTitleOther/BgTitle1")
	self.imgBgOtherTitle3 = UIControls.Image(self, self.mPath .. "/BgTitleOther/BgTitle3")
	self.imgBgOnlyTeam = UIControls.Image(self, self.mPath .. "/BgOnlyTeam")
	self.imgBgTitle1 = UIControls.Image(self, self.mPath .. "/BgTitle/BgTitle1")
	self.imgBgTitle3 = UIControls.Image(self, self.mPath .. "/BgTitle/BgTitle3")
	self.imgBgStory1 = UIControls.Image(self, self.mPath .. "/BgStory1")
	self.imgBgFuli = UIControls.Image(self, self.mPath .. "/BgFuli")
	self.imgTextTeam = UIControls.Image(self, self.mPath .. "/BgTextTeam/TextTeam")
	self.imgBgFuliText = UIControls.Image(self, self.mPath .. "/BgFuliText")
	self.imgBgOnlyTeam1 = UIControls.Image(self, self.mPath .. "/BgOnlyTeam/BgTeam1")
	self.imgBgOnlyTeam2 = UIControls.Image(self, self.mPath .. "/BgOnlyTeam/BgTeam2")
	self.imgHeroHead = UIControls.Image(self, self.mPath .. "/BgTextTeam/ImgHeroHead")
	self.imgBgStoryCover = UIControls.Image(self, self.mPath .. "/BgStoryCover")
	self.imgBgStoryCoverGrain = UIControls.Image(self, self.mPath .. "/BgStoryCover/BgStoryCoverGrain")
end

function StoryCoverPanel:setRelationDescResData(descInfo, letterInfo, hero, isAutoOpen)
	self.descInfo = descInfo
	self.isUnLocked = self.descInfo ~= nil

	if letterInfo then
		local txtTeamPath = UIConst.getLargeTeamIconPath(letterInfo.team_id)

		if txtTeamPath then
			self.imgTextTeam:setImage(txtTeamPath[1], txtTeamPath[2])
		end
	end

	local iconPath = hero:getIconPath()

	if iconPath then
		self.imgHeroHead:setImage(iconPath[1], iconPath[2])
	end

	self.panelStoryLock:setVisible(not self.isUnLocked)

	if self.isUnLocked and letterInfo then
		self.txtStoryTitle:setText(letterInfo.letter_name)

		local textColor = letterInfo.color_text ~= nil and letterInfo.color_text or {
			255,
			255,
			255
		}

		self.imgBgStoryCoverGrain:setColorByRGBA(textColor[1], textColor[2], textColor[3])
		self.imgBgTitle3:setColorByRGBA(textColor[1], textColor[2], textColor[3])
		self.imgBgOtherTitle3:setColorByRGBA(textColor[1], textColor[2], textColor[3])
		self.imgBgStoryCover:setColorByRGBA(letterInfo.color_bg[1], letterInfo.color_bg[2], letterInfo.color_bg[3])
		self.txtStoryTitle:setColorByRGBA(letterInfo.color_bg[1] / 255, letterInfo.color_bg[2] / 255, letterInfo.color_bg[3] / 255)
		self.imgBgTitle1:setColorByRGBA(letterInfo.color_bg[1], letterInfo.color_bg[2], letterInfo.color_bg[3])
		self.imgBgOtherTitle1:setColorByRGBA(letterInfo.color_bg[1], letterInfo.color_bg[2], letterInfo.color_bg[3])
	else
		self:setPanelAllGray()
		self.txtStoryTitle:setText(ClientUtils.getClientNotice(621))
	end

	self.imgBgOnlyTeam:setVisible(letterInfo.team_id == 4)

	local spriteNameGrain = letterInfo.team_id == 4 and "BgSide5" or "BgSide4"

	self.imgBgStoryCoverGrain:setImage("Atlas/ShowRoomAtlas/ShowRoomStoryAtlas1", spriteNameGrain)

	local spriteBgTitle = letterInfo.team_id == 4 and "BgTitle2" or "BgTitle4"

	self.imgBgTitle3:setImage("Atlas/ShowRoomAtlas/ShowRoomStoryAtlas1", spriteBgTitle)
	self.imgBgOtherTitle3:setImage("Atlas/ShowRoomAtlas/ShowRoomStoryAtlas1", spriteBgTitle)
end

function StoryCoverPanel:setPanelAllGray()
	self.imgBgOnlyTeam:setImageGray(true)
	self.imgBgTitle1:setImageGray(true)
	self.imgBgTitle3:setImageGray(true)
	self.imgBgStory1:setImageGray(true)
	self.imgBgFuli:setImageGray(true)
	self.imgTextTeam:setImageGray(true)
	self.imgBgFuliText:setImageGray(true)
	self.imgBgOnlyTeam1:setImageGray(true)
	self.imgBgOnlyTeam2:setImageGray(true)
	self.imgHeroHead:setImageGray(true)
	self.imgBgStoryCover:setImageGray(true)
	self.imgBgStoryCoverGrain:setImageGray(true)
	self.txtStoryTitle:setColorByRGBA(0.28627450980392155, 0.28627450980392155, 0.28627450980392155)
end

function StoryCoverPanel:onBtnPanelStoryCoverClick()
	if not self.isUnLocked then
		MsgManager.clientNotice(625)
	end
end

local strClassName = "HeroShowRoomStoryDlg"
local HeroShowRoomStoryDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomStoryDlg:ctor()
	self:initUI()
end

function HeroShowRoomStoryDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)

	self.scrollStoryList = UIControls.ScrollView(self, "MainInfoPanel/BgStoryContent/TextContentList")

	self.scrollStoryList:addEventValueChanged(self._onScrollValueChanged)

	self.imgBgContentTitle = UIControls.Image(self, "MainInfoPanel/BgStoryContent/BgTextContentTitle")
	self.txtContentTitle = UIControls.Label(self, "MainInfoPanel/BgStoryContent/BgTextContentTitle/TextContentTitle")
	self.txtContent = UIControls.Label(self, "MainInfoPanel/BgStoryContent/TextContentList/Content/TextContent")
	self.panelArrow = UIControls.Panel(self, "MainInfoPanel/BgStoryContent/ArrowNext")
	self.coverPanel = StoryCoverPanel(self, "MainInfoPanel/StoryCoverPanel")
	self.coverPanel1 = StoryCoverPanel(self, "MainInfoPanel/StoryCoverPanel1")
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function HeroShowRoomStoryDlg:_onScrollValueChanged(sender, valueX, valueY)
	if not self.isSetedScroll then
		return
	end

	local barValue = self.scrollStoryList:getVerticalValue()

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

function HeroShowRoomStoryDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroShowRoomStoryDlg:setRelationDescResData(descInfo, letterInfo, hero, isAutoOpen)
	self.coverPanel:setRelationDescResData(descInfo, letterInfo, hero, isAutoOpen)
	self.coverPanel1:setRelationDescResData(descInfo, letterInfo, hero, isAutoOpen)
	self.coverPanel1:setPanelAllGray()

	self.descInfo = descInfo
	self.isUnLocked = self.descInfo ~= nil

	if self.isUnLocked and letterInfo then
		self.txtContentTitle:setText(self.descInfo.title)
		self.txtContent:setText(self.descInfo.content)
		self.imgBgContentTitle:setColorByRGBA(letterInfo.color_bg[1], letterInfo.color_bg[2], letterInfo.color_bg[3])
	end

	if isAutoOpen then
		self.uiAni:startAni("OpenStoryUnLockingCanvas", true)
	else
		local playAniName = self.isUnLocked and "OpenStoryUnLockCanvas" or "OpenStoryLockCanvas"

		self.uiAni:startAni(playAniName, true)
	end
end

function HeroShowRoomStoryDlg:yieldSetScrollStatus()
	self.scrollStoryList:gotoTop()
	coroutine.step()

	local contentSize = self.scrollStoryList:getContentSize()
	local maxHeight = self.scrollStoryList:getSize().height

	if maxHeight >= contentSize[2] then
		self.scrollStoryList:cancelScroll()
		self.panelArrow:setVisible(false)
	else
		self.panelArrow:setVisible(true)
		self.scrollStoryList:openScroll(true)

		self.isSetedScroll = true
	end
end

function HeroShowRoomStoryDlg:setVisible(isVisible)
	if not isVisible then
		local playAniName = self.isUnLocked and "CloseStoryUnLockCanvas" or "CloseStoryLockCanvas"

		self.uiAni:startAni(playAniName, true)
	else
		HeroShowRoomStoryDlg.super.setVisible(self, isVisible)
	end
end

function HeroShowRoomStoryDlg:_onAniFinish(aniCom, aniName)
	if aniName == "CloseStoryLockCanvas" or aniName == "CloseStoryUnLockCanvas" then
		HeroShowRoomStoryDlg.super.setVisible(self, false)
	end

	if aniName == "OpenStoryUnLockingCanvas" or aniName == "OpenStoryUnLockCanvas" or aniName == "OpenStoryLockCanvas" then
		self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
	end
end

return HeroShowRoomStoryDlg
