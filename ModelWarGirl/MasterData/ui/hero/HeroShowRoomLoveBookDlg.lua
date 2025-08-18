-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomLoveBookDlg.lua

local ResVowContent = require("ClientData/ResVowContent")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local UserData = require("Helper/UserData")
local UserDataShareKey = "VowShare"
local strClassName = "HeroShowRoomLoveBookDlg"
local HeroShowRoomLoveBookDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomLoveBookDlg:ctor()
	self:initUI()
end

function HeroShowRoomLoveBookDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self.onAniFinish)

	self.bgPicture = UIControls.Image(self, "MainInfoPanel/BgBookLeft/BgPicture")
	self.bgLockPicture = UIControls.Image(self, "MainInfoPanel/BgBookLeft/BgLockPicture")
	self.btnReturnPv = UIControls.Button(self, "MainInfoPanel/BgBookLeft/BtnReturnPv")

	self.btnReturnPv:addEventClick(self.onBtnReturnPvClick)

	self.iconTeam = UIControls.Image(self, "MainInfoPanel/BgBookRight/BgTeam/iconTeam")
	self.textContentScrollList = UIControls.ScrollView(self, "MainInfoPanel/BgBookRight/TextContentList")

	self.textContentScrollList:addEventValueChanged(self.onScrollValueChanged)

	self.textContent = UIControls.Label(self, "MainInfoPanel/BgBookRight/TextContentList/Content/TextContent")
	self.arrowNext = UIControls.Panel(self, "MainInfoPanel/BgBookRight/ArrowNext")
	self.textLock = UIControls.Panel(self, "MainInfoPanel/BgBookRight/TextLock")
	self.textPlayerName = UIControls.Label(self, "MainInfoPanel/BgBookRight/BgPlayerName/TextName")
	self.textModelName = UIControls.Label(self, "MainInfoPanel/BgBookRight/BgModelName/TextName")
	self.imgVowProve = UIControls.Panel(self, "MainInfoPanel/BgBookRight/ImgVowProve")
	self.sharePanel = ShareAchievePanel(self, "MainInfoPanel/SharePanel")
	self.imgBow = UIControls.Image(self, "MainInfoPanel/FrontPanel/ImgBow")
	self.imgBow1 = UIControls.Image(self, "MainInfoPanel/FrontPanel/ImgBow/ImgBow1")
	self.imgSemicircle = UIControls.Image(self, "MainInfoPanel/FrontPanel/ImgSemicircle")
	self.imgHerat1 = UIControls.Image(self, "MainInfoPanel/FrontPanel/ImgSemicircle/ImgHerat1")
	self.imgHerat2 = UIControls.Image(self, "MainInfoPanel/FrontPanel/ImgSemicircle/ImgHerat2")
	self.imgSemicircle1 = UIControls.Image(self, "MainInfoPanel/FrontPanel/ImgSemicircle1")
	self.imgHerat = UIControls.Image(self, "MainInfoPanel/FrontPanel/ImgSemicircle1/ImgHerat")
	self.bgLogo = UIControls.Image(self, "MainInfoPanel/FrontPanel/BgLogo")
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function HeroShowRoomLoveBookDlg:setLoveBookData(heroId, isUnLock, name, colorData, avgId, showSign)
	if isUnLock then
		local vowContentData = ResVowContent[heroId]

		if vowContentData.voiceId then
			CueManager.playVocal(vowContentData.voiceId)
		end

		self:playAni("OpenLoveBookUnLockCanvas", nil, true)
		self.bgPicture:setImage(vowContentData.icon_path, vowContentData.icon_name)
		self.textLock:setVisible(false)
		self.textContent:setText(vowContentData.desc)

		self.avgId = avgId

		if showSign then
			self.signData = {
				vowContentData.sign_path,
				vowContentData.sign_name
			}
		end

		local isShowPanel = UserData.loadCommonData(CurAvatar.uid .. UserDataShareKey) ~= "1"

		if isShowPanel then
			self.sharePanel:setBeforeAction(function()
				UserData.saveCommonData(CurAvatar.uid .. UserDataShareKey, "1")
			end)
		end

		self.sharePanel:setNoAwardInfo("heroShowRoomLoveBookDlg")
		self.sharePanel:setVisible(isShowPanel)
		self.sharePanel:hideAwardPanel(true)
	else
		self:playAni("OpenLoveBookCanvas", nil, true)
	end

	self.textPlayerName:setText(CurAvatar:getPlayerName())
	self.textModelName:setText(name)
	self.imgBow:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.imgBow1:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.imgSemicircle:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.imgHerat1:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.imgHerat2:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.imgSemicircle1:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.imgHerat:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.bgLogo:setColorByRGBA(colorData[1], colorData[2], colorData[3])
end

function HeroShowRoomLoveBookDlg:onAniFinish()
	local contentSize = self.textContentScrollList:getContentSize()
	local maxHeight = self.textContentScrollList:getSize().height

	if maxHeight >= contentSize[2] then
		self.textContentScrollList:cancelScroll()
		self.arrowNext:setVisible(false)
	else
		self.arrowNext:setVisible(true)
		self.textContentScrollList:openScroll(true)

		self.isScroll = true
	end
end

function HeroShowRoomLoveBookDlg:onScrollValueChanged()
	if not self.isScroll then
		return
	end

	local barValue = self.textContentScrollList:getVerticalValue()

	if barValue == self.oldBarValue then
		return
	end

	self.oldBarValue = barValue

	if barValue == 0 then
		self.arrowNext:setVisible(false)
	else
		self.arrowNext:setVisible(true)
	end
end

function HeroShowRoomLoveBookDlg:onBtnCloseClick()
	self:setVisible(false)

	if self.signData then
		local heroShowRoomAcquireDlg = UIManager.getUI("heroShowRoomAcquireDlg", true)

		heroShowRoomAcquireDlg:setAcquireData(false, self.signData)
	end
end

function HeroShowRoomLoveBookDlg:onBtnReturnPvClick()
	UIManager.playAVG(self.avgId)
end

return HeroShowRoomLoveBookDlg
