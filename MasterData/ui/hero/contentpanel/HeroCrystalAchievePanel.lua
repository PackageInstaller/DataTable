-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroCrystalAchievePanel.lua

local ResHeroCrystalUnlock = require("ClientData/ResHeroCrystalUnlock")
local ResHeroCrystalStory = require("ClientData/ResHeroCrystalStory")
local ResHeroCrystalProp = require("ClientData/ResHeroCrystalProp")
local ResCommonModel = require("ClientData/ResCommonModel")
local HeroCrystalAchievePanelCell = Class("HeroCrystalAchievePanelCell", UIControls.Child)

function HeroCrystalAchievePanelCell:ctor()
	self:initUI()
end

function HeroCrystalAchievePanelCell:initUI()
	self.textTitle = UIControls.Label(self, "BgTitle/TextTitle")
	self.textDesc = UIControls.Label(self, "TextDes")
	self.panelAttr = UIControls.Panel(self, "AttrPanel")
	self.textAttr = UIControls.Label(self, "AttrPanel/TextAttr")
	self.textAttrLock = UIControls.Label(self, "AttrPanel/TextUnlock")
	self.textLock = UIControls.Label(self, "TextLock")
end

function HeroCrystalAchievePanelCell:setData(storyData, type, curLevel)
	self.textTitle:setText(storyData.title or "")
	self.textDesc:setText(storyData.desc or "")

	local phase = storyData.phase
	local propData = ResHeroCrystalProp[type][phase]

	self.allOver = false

	if curLevel < propData[1].need_level then
		self.textDesc:setVisible(false)
		self.panelAttr:setVisible(false)
		self.textLock:setVisible(true)
		self.textLock:setText(string.format(Lang.get(62568), math.floor(propData[1].need_level / 10)))
	else
		self.textDesc:setVisible(true)
		self.panelAttr:setVisible(true)
		self.textLock:setVisible(false)

		local propValue = 0
		local propType, hasNext

		for _, oneData in ipairs(propData) do
			if curLevel < oneData.need_level then
				hasNext = oneData

				break
			else
				propType = oneData.prop_type
				propValue = propValue + oneData.prop_value
			end
		end

		propType, propValue = ClientUtils.getRolePropZhNameByType(propType, propValue)

		self.textAttr:setText(propType .. "+" .. propValue)

		if hasNext then
			self.textAttrLock:setVisible(true)

			propType, propValue = ClientUtils.getRolePropZhNameByType(hasNext.prop_type, hasNext.prop_value)

			self.textAttrLock:setText(utils.format(Lang.get(75617), math.floor(hasNext.need_level / 10), propType, propValue))
		else
			self.textAttrLock:setVisible(false)

			self.allOver = true
		end
	end
end

local HeroCrystalPartBase = Class("HeroCrystalPartBase", UIControls.Panel)

function HeroCrystalPartBase:ctor()
	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.textLock = UIControls.Label(self, self.mPath .. "/LockPanel/TextDes")
	self.btnLockJump = UIControls.Button(self, self.mPath .. "/LockPanel/BtnBackyard")

	self.btnLockJump:addEventClick(self.onLockJumpClick)

	self.panelUnlock = UIControls.Panel(self, self.mPath .. "/UnlockPanel")
	self.btnUnlock = UIControls.Button(self, self.mPath .. "/UnlockPanel/BtnUnlcok")

	self.btnUnlock:addEventClick(self.onUnlockClick)

	self.gridUnlockMaterial = UIControls.getGridContainer(self, self.mPath .. "/UnlockPanel/GridUnlockItem")

	self.gridUnlockMaterial:setVisible(true)
end

function HeroCrystalPartBase:onRefresh(heroId)
	local unlockData = ResHeroCrystalUnlock[self.type]

	self.heroId = heroId

	local nowLevel = CurAvatar.crystalNewLevel
	local inLock = nowLevel < unlockData.need_level
	local showContent = false

	if inLock then
		self.panelLock:setVisible(true)
		self.panelUnlock:setVisible(false)
		self.textLock:setText(string.format(Lang.get(62570), math.floor(unlockData.need_level / 10)))
	elseif not CurAvatar:isHeroStoryUnlocked(self.mParent.heroId, self.type) then
		self.panelLock:setVisible(false)
		self.panelUnlock:setVisible(true)

		self.needItem = unlockData.cost_item
		self.needNum = unlockData.cost_num

		self.gridUnlockMaterial:setObj(BaseObject.GetObject(self.needItem, self.needNum))

		local hasNum = CurAvatar:getItemNumById(self.needItem)

		self.gridUnlockMaterial.grid.textNum:setText(hasNum .. "/" .. self.needNum)

		self.gridUnlockMaterial.grid.uiConfig = {
			CloseSrcWindow = 1,
			AutoOpenGuide = 1
		}

		if hasNum < self.needNum then
			self.gridUnlockMaterial.grid.textNum:setFontColor(ResColor.RED01)
		else
			self.gridUnlockMaterial.grid.textNum:setFontColor(ResColor.BLACK)
		end
	else
		showContent = true

		self.panelLock:setVisible(false)
		self.panelUnlock:setVisible(false)
	end

	self:_onRefresh(showContent, inLock)
end

function HeroCrystalPartBase:onLockJumpClick()
	JumpGuideManager.jump(49)
end

function HeroCrystalPartBase:onUnlockClick()
	local hasNum = CurAvatar:getItemNumById(self.needItem)

	if hasNum < self.needNum then
		MsgManager.notice(Lang.get(30678))
	else
		RPC.heroCrystalStoryUnlock(self.mParent.heroId, self.type)
	end
end

local HeroCrystalAchievePart = Class("HeroCrystalAchievePart", HeroCrystalPartBase)

function HeroCrystalAchievePart:ctor()
	self.scrollList = UIControls.Panel(self, self.mPath .. "/ArchiList")
	self.awardCells = {}
	self.btnJump = UIControls.Button(self, self.mPath .. "/BtnLevel")

	self.btnJump:addEventClick(self.onLockJumpClick)
end

function HeroCrystalAchievePart:onRefreshData()
	for index = #self.awardCells, #self.cellData - 1 do
		local newCell = HeroCrystalAchievePanelCell(self, self.mPath .. "/ArchiList/Content", "System/Hero/HeroArchiCell")

		table.insert(self.awardCells, newCell)
	end

	for index, cell in ipairs(self.awardCells) do
		if self.cellData[index] then
			cell:setVisible(true)
			cell:setData(self.cellData[index], self.type, CurAvatar.crystalNewLevel)
		else
			cell:setVisible(false)
		end
	end

	if self.awardCells[#self.cellData].allOver then
		self.btnJump:setVisible(false)
	else
		self.btnJump:setVisible(true)
	end
end

function HeroCrystalAchievePart:_onRefresh(showContent)
	if showContent then
		self.scrollList:setVisible(true)

		self.cellData = ResHeroCrystalStory[self.mParent.heroId][self.type]

		self:onRefreshData(true)
	else
		self.btnJump:setVisible(false)
		self.scrollList:setVisible(false)
	end
end

local HeroCrystalFilePart = Class("HeroCrystalFilePart", HeroCrystalPartBase)

function HeroCrystalFilePart:ctor()
	self.scrollList = UIControls.Panel(self, self.mPath .. "/FileList")
	self.awardCells = {}
	self.btnJump = UIControls.Button(self, self.mPath .. "/BtnLevel")

	self.btnJump:addEventClick(self.onLockJumpClick)
end

function HeroCrystalFilePart:onRefreshData()
	for index = #self.awardCells, #self.cellData - 1 do
		local newCell = HeroCrystalAchievePanelCell(self, self.mPath .. "/FileList/Content", "System/Hero/HeroArchiCell")

		table.insert(self.awardCells, newCell)
	end

	for index, cell in ipairs(self.awardCells) do
		if self.cellData[index] then
			cell:setVisible(true)
			cell:setData(self.cellData[index], self.type, CurAvatar.crystalNewLevel)
		else
			cell:setVisible(false)
		end
	end

	if self.awardCells[#self.cellData].allOver then
		self.btnJump:setVisible(false)
	else
		self.btnJump:setVisible(true)
	end
end

function HeroCrystalFilePart:_onRefresh(showContent)
	if showContent then
		self.scrollList:setVisible(true)

		self.cellData = ResHeroCrystalStory[self.mParent.heroId][self.type]

		self:onRefreshData(true)
	else
		self.btnJump:setVisible(false)
		self.scrollList:setVisible(false)
	end
end

local HeroCrystalLive2DCell = Class("HeroCrystalLive2DCell", UIControls.Child)

function HeroCrystalLive2DCell:ctor()
	self.heroPortrait = UIControls.Role(self, "ImgHero", 0, 0, true)
	self.iconLock = UIControls.Panel(self, "IconLock")
	self.panelNoRes = UIControls.Label(self, "TxtLock")
end

local HeroCrystalLive2DPart = Class("HeroCrystalLive2DPart", HeroCrystalPartBase)

function HeroCrystalLive2DPart:ctor()
	self.panelGrid2D = UIControls.Panel(self, self.mPath .. "/Live2dChooseList")
	self.gridUnLock = HeroCrystalLive2DCell(self, self.mPath .. "/Live2dChooseList/Content", "System/Common/Grid/GridLive2dCard", 0, 0, true)
	self.btnUnlockNoRes = UIControls.Button(self, self.mPath .. "/BtnUnlockDis")

	self.btnUnlockNoRes:addEventClick(self.onUnlockNoResClick)
end

function HeroCrystalLive2DPart:_onRefresh(showContent, typeLock)
	self.unlockDisable = false

	if typeLock then
		self.mParent.live2D:setVisible(false)
		self.btnUnlockNoRes:setVisible(false)
		self.panelGrid2D:setVisible(false)
	else
		self.panelGrid2D:setVisible(true)
		self.gridUnLock.heroPortrait:showRole(self.mParent.heroId, UIConst.ROLEIMAGE_SHOWTYPE_SHOW_SKIN)

		local modelData = self.mParent.modelData

		if modelData and modelData.live_path then
			self.gridUnLock.panelNoRes:setVisible(false)
			self.btnUnlockNoRes:setVisible(false)

			if showContent then
				self.mParent.bgLive2D:setVisible(true)
				self.mParent.panelLive2D:setVisible(true)
				self.mParent.live2D:setVisible(true)
				self.mParent.live2D:playLive2DByPath(modelData.live_path, modelData.live_scale, modelData.live_coord or {
					0,
					0
				})
				self.gridUnLock.iconLock:setVisible(false)
			else
				self.gridUnLock.iconLock:setVisible(true)
				self.mParent.live2D:setVisible(false)
			end
		else
			self.btnUnlockNoRes:setVisible(true)
			self.panelUnlock:setVisible(false)
			self.mParent.live2D:setVisible(false)
			self.gridUnLock.panelNoRes:setVisible(true)
			self.gridUnLock.iconLock:setVisible(true)
		end
	end
end

function HeroCrystalLive2DPart:onUnlockNoResClick()
	MsgManager.notice(Lang.get(61554))
end

local strClassName = "HeroCrystalAchievePanel"
local HeroCrystalAchievePanel = Class(strClassName, UIControls.Child)

function HeroCrystalAchievePanel:ctor()
	self:initUI()
end

local BTN_CONFIG = {
	{
		"Bg/TabPanel/BtnArchi",
		HeroCrystalAchievePart,
		"Bg/ArchiPanel"
	},
	{
		"Bg/TabPanel/BtnFile",
		HeroCrystalFilePart,
		"Bg/FilePanel"
	},
	{
		"Bg/TabPanel/BtnL2d",
		HeroCrystalLive2DPart,
		"Bg/L2dPanel"
	}
}

function HeroCrystalAchievePanel:initUI()
	self.btns = {}
	self.pages = {}

	for index, config in ipairs(BTN_CONFIG) do
		local newBtn = UIControls.Button(self, config[1])

		newBtn.type = index

		newBtn:addEventClick(self.onTabBtnClick)

		local newPage = config[2](self, config[3])

		newPage.type = index

		newPage:setVisible(false)

		self.btns[index] = newBtn
		self.pages[index] = newPage
	end

	self.bgLive2D = UIControls.Panel(self, "BgL2d")
	self.panelLive2D = UIControls.Panel(self, "Live2dMask")
	self.live2D = UIControls.LazyLivePlayer(self, "Live2dMask/Live2d")
end

function HeroCrystalAchievePanel:onTabBtnClick(sender)
	self.selectType = sender.type

	for index, btn in ipairs(self.btns) do
		btn:setEnable(btn ~= sender)
	end

	if self.currentPage then
		self.currentPage:setVisible(false)
	end

	self.bgLive2D:setVisible(false)
	self.panelLive2D:setVisible(false)

	self.currentPage = self.pages[self.selectType]

	self.currentPage:setVisible(true)
	self.currentPage:onRefresh()
end

function HeroCrystalAchievePanel:setHero(hero)
	if self.hero ~= hero then
		self.hero = hero
		self.heroId = hero.id
		self.modelData = ResCommonModel[hero.resData.model]

		self:onTabBtnClick(self.btns[1])
	else
		self.currentPage:onRefresh()
	end
end

function HeroCrystalAchievePanel:onHide()
	return
end

function HeroCrystalAchievePanel:onHeroCrystalStoryUnlockResp(heroId)
	if self.heroId == heroId then
		self.currentPage:onRefresh()
	end
end

return HeroCrystalAchievePanel
