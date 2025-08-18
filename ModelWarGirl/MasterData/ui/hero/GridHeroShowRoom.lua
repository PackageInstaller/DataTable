-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\GridHeroShowRoom.lua

local ResDevelopMisc = require("ClientData/ResDevelopMisc")
local strClassName = "GridHeroShowRoom"
local GridHeroShowRoom = Class(strClassName, UIControls.Child)

function GridHeroShowRoom:ctor()
	self:initUI()
end

function GridHeroShowRoom:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.panelArea = UIControls.Panel(self, "AreaPanel")
	self.txtAreaTitle = UIControls.Label(self, "AreaPanel/Text")
	self.panelNml = UIControls.Panel(self, "NmlPanel")
	self.txtNmlHeroName = UIControls.Label(self, "NmlPanel/TextName")
	self.imgNmlHero = UIControls.Image(self, "NmlPanel/ImgHero")
	self.panelLock = UIControls.Panel(self, "LockPanel")
	self.imgIconNew = UIControls.Panel(self, "IconNew1")
	self.imgIconNewSweep = UIControls.Panel(self, "IconNew2")

	if self.mParent.onPinchFunc then
		self.panelDrag = UIControls.DragClickPanel(self, "")

		self.panelDrag:setPinchFunc(Slot(self.mParent.onPinchFunc, self.mParent))
	end

	self.panelSlider = UIControls.Panel(self, "SliderPanel")
	self.sliderImgList = {}

	for i = 1, 6 do
		self.sliderImgList[i] = UIControls.Image(self, "SliderPanel/Img" .. i)
	end

	self.imgBgNml = UIControls.Image(self, "NmlPanel/BgNml")
	self.vowPanel = UIControls.Panel(self, "VowPanel")
end

function GridHeroShowRoom:setRoomHero(roomHero)
	self.roomHero = roomHero

	self.panelArea:setVisible(false)

	if self.roomHero.roomInfo.area then
		self.panelArea:setVisible(self.roomHero.isGeted)
		self.txtAreaTitle:setText(self.roomHero.roomInfo.area or "")
	end

	if self.roomHero.roomInfo.group then
		-- block empty
	end

	if self.roomHero.isGeted then
		self.panelNml:setVisible(true)
		self.panelLock:setVisible(false)

		local iconPath = self.roomHero:getIconPath(true)

		if iconPath then
			self.imgNmlHero:setImage(iconPath[1], iconPath[2])
		end

		self.txtNmlHeroName:setText(self.roomHero.name)
		self.panelSlider:setVisible(true)

		local unLockStage = self.roomHero:getRelationUnlockStage()
		local curRelationPoint = self.roomHero:getCurRelationPoint()

		if curRelationPoint > 0 then
			for relationPoint, sliderImg in ipairs(self.sliderImgList) do
				if curRelationPoint == relationPoint then
					sliderImg:setImage("Atlas/ShowRoomAtlas/ShowRoomAtlas03", "BgProgressUnlock")
				elseif unLockStage >= ResDevelopMisc[relationPoint].develop_stage then
					local spriteName = curRelationPoint < relationPoint and "BgProgressUnlock" or "BgProgressActive"

					sliderImg:setImage("Atlas/ShowRoomAtlas/ShowRoomAtlas03", spriteName)
				else
					sliderImg:setImage("Atlas/ShowRoomAtlas/ShowRoomAtlas03", "BgProgressLock")
				end
			end
		else
			for relationPoint, sliderImg in ipairs(self.sliderImgList) do
				if unLockStage >= ResDevelopMisc[relationPoint].develop_stage then
					sliderImg:setImage("Atlas/ShowRoomAtlas/ShowRoomAtlas03", "BgProgressActive")
				else
					sliderImg:setImage("Atlas/ShowRoomAtlas/ShowRoomAtlas03", "BgProgressLock")
				end
			end
		end

		local vowMiscData = ResDevelopMisc[7]

		if vowMiscData then
			local curVowLevel = self.roomHero:getRelationPointLevel(7)

			if unLockStage >= vowMiscData.develop_stage and curVowLevel >= vowMiscData.max_level then
				self.vowPanel:setVisible(true)
			else
				self.vowPanel:setVisible(false)
			end
		else
			self.vowPanel:setVisible(false)
		end

		self.imgNmlHero:setImageGray(unLockStage <= 0)

		local spriteName = unLockStage <= 0 and "BgCardDis" or "BgCardSel"

		self.imgBgNml:setImage("Atlas/ShowRoomAtlas/ShowRoomAtlas03", spriteName)
	else
		self.panelNml:setVisible(false)
		self.panelSlider:setVisible(false)
		self.panelLock:setVisible(true)
		self.vowPanel:setVisible(false)
	end

	self:setPosition(self.roomHero.roomInfo.position[1], self.roomHero.roomInfo.position[2])
	self:refreshHintShow()
end

function GridHeroShowRoom:refreshHintShow()
	self.imgIconNew:setVisible(false)
	self.imgIconNewSweep:setVisible(false)

	if CurAvatar.newRoomHeroIdDic and CurAvatar.newRoomHeroIdDic[self.roomHero.id] == 1 then
		self.imgIconNew:setVisible(true)
	elseif CurAvatar.realtionHeroListTop3 and CurAvatar.realtionHeroListTop3[self.roomHero.id] == 1 then
		self.imgIconNewSweep:setVisible(true)
	end
end

function GridHeroShowRoom:setHero(hero)
	self.hero = hero

	local iconPath = self.hero:getIconPath(true)

	if iconPath then
		self.imgNmlHero:setImage(iconPath[1], iconPath[2])
	end

	self.txtNmlHeroName:setText(self.hero.name)
end

function GridHeroShowRoom:onBtnSelfClick()
	if self.roomHero then
		if not self.roomHero.isGeted then
			MsgManager.clientNotice(627)

			return
		end

		if self.roomHero:getRelationUnlockStage() <= 0 then
			MsgManager.clientNotice(628)

			return
		end

		local heroShowRoomGrowUpDlg = UIManager.getUI("heroShowRoomGrowUpDlg", true)

		heroShowRoomGrowUpDlg:setRoomHero(self.roomHero)
	end
end

return GridHeroShowRoom
