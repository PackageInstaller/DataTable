-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroListFunPanel.lua

local ResColor = require("ClientData/ResColor")
local UserData = require("Helper/UserData")
local FilterTitleBtnPanel = require("UI/MainState/FilterTitleBtnPanel")
local strClassName = "HeroListFunPanel"
local HeroListFunPanel = Class(strClassName, UIControls.Panel)

function HeroListFunPanel:ctor()
	self:initUI()
end

local HERO_FILTER_MAP = {
	{
		title = Lang.get(373),
		data = {
			{
				Const.CAMP_CONFIG[1].name,
				"camp",
				1
			},
			{
				Const.CAMP_CONFIG[2].name,
				"camp",
				2
			},
			{
				Const.CAMP_CONFIG[3].name,
				"camp",
				3
			}
		}
	},
	{
		title = Lang.get(374),
		data = {
			{
				Const.CAREER_CONFIG[1].name,
				"career",
				1
			},
			{
				Const.CAREER_CONFIG[2].name,
				"career",
				2
			},
			{
				Const.CAREER_CONFIG[3].name,
				"career",
				3
			},
			{
				Const.CAREER_CONFIG[4].name,
				"career",
				4
			},
			{
				Const.CAREER_CONFIG[5].name,
				"career",
				5
			}
		}
	}
}

function HeroListFunPanel:initUI()
	self.SORT_BTN_TYPE_CONFIG = {
		{
			property = "level",
			weight = 35,
			define_name = Lang.get(1203)
		},
		{
			property = "star",
			weight = 30,
			define_name = Lang.get(1204)
		},
		{
			property = "inCry",
			weight = 25,
			define_name = Lang.get(30342)
		},
		{
			property = "step",
			weight = 20,
			define_name = Lang.get(1105)
		},
		{
			property = "quality",
			weight = 10,
			define_name = Lang.get(372)
		}
	}
	self.btnListType = UIControls.Button(self, self.mPath .. "/BtnListType", "Text")
	self.btnListTypeArrow = UIControls.Image(self, self.mPath .. "/BtnListType/ImgArrow")

	self.btnListType:addEventClick(self.onBtnListTypeClick)

	self.listTypePanel = UIControls.Panel(self, self.mPath .. "/ListTypePanel")
	self.btnTypeList = {}
	self.btnTypeArrow = {}
	self.btnTypeName = {}
	self.btnTypeBg = {}

	for i = 1, 2 do
		local btn = UIControls.Button(self, self.mPath .. "/ListTypePanel/BtnType" .. i)

		btn:addEventClick(self.onBtnTypeClick)

		local arrow = UIControls.Image(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/ImgArrow")
		local name = UIControls.Label(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/Text")
		local imgBg = UIControls.Image(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/Bg")

		table.insert(self.btnTypeList, btn)
		table.insert(self.btnTypeArrow, arrow)
		table.insert(self.btnTypeName, name)
		table.insert(self.btnTypeBg, imgBg)
	end

	self.curSortType = 1
	self.SORT_BTN_TYPE_CONFIG[self.curSortType].weight = self.SORT_BTN_TYPE_CONFIG[self.curSortType].weight + 100
	self.sortSequence = 0

	self:refreshBtnTypeArrowControl()

	self.filterSelectPanel = self.mWindow.filterSelectPanel
	self.filterTitleBtnPanel = FilterTitleBtnPanel(self, self.mPath .. "/SelectPanel", 2, self.filterSelectPanel, Slot(self.filterHeroCard, self), UIConst.HERO_DEFAULT_FILTER_PANEL_MAP)
	self.btnHeroSell = UIControls.Button(self, self.mPath .. "/BtnHeroSell")

	self.btnHeroSell:addEventClick(self.onBtnHeroSellClick)

	local sellRD = UIControls.RedDot(self, self.mPath .. "/BtnHeroSell/IconNew")

	sellRD:addHint({
		UIConst.RD_HINT_HERO_SELL
	})

	self.btnBagAdd = UIControls.Button(self, self.mPath .. "/BtnBagAdd", "Text")

	self.btnBagAdd:addEventClick(self.onBtnBagClick)
	self.btnBagAdd:setText(CurAvatar:getHeroCount() .. "/" .. CurAvatar:getBagSize(Const.BAG_TYPE_HERO))

	self.btnSensor = UIControls.Button(self, self.mPath .. "/UIClickThrough")

	self.btnSensor:addEventClick(self.onBtnSensorClick)
end

function HeroListFunPanel:onBtnHeroSellClick()
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_RECYCLE)

	if isLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HERO_RECYCLE))

		return
	end

	local heroSellDlg = UIManager.getUI("heroSellDlg", true)
end

function HeroListFunPanel:onBtnBagClick()
	CurAvatar:openBagGridAddDlg(Const.BAG_TYPE_HERO)
end

function HeroListFunPanel:refreshBagBlankNum()
	self.btnBagAdd:setText(CurAvatar:getHeroCount() .. "/" .. CurAvatar:getBagSize(Const.BAG_TYPE_HERO))
end

function HeroListFunPanel:refreshBtnTypeArrowControl()
	local arrowSprite = self.sortSequence == 0 and "IconBtnLevelDown" or "IconBtnLevelUp"
	local sequenceAngle = self.sortSequence == 0 and 180 or 0

	for i, v in ipairs(self.btnTypeArrow) do
		self.btnTypeArrow[i]:setVisible(self.curSortType == i)
		self.btnTypeArrow[i]:setRotate(sequenceAngle)
		self.btnTypeBg[i]:setVisible(self.curSortType == i)

		local color = self.curSortType == i and ResColor.ORANGEBTN or ResColor.GREYLIGHT

		self.btnTypeName[i]:setFontColor(color)

		local arrow = UIControls.Panel(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/ImgArrow")
	end

	self.btnListType:setText(self.SORT_BTN_TYPE_CONFIG[self.curSortType].define_name)
	self.btnListTypeArrow:setImage("Atlas/CommonAtlas/OtherAtlas", arrowSprite)
end

function HeroListFunPanel:getSortBtnIdxByProperty(_property)
	for k, v in ipairs(self.SORT_BTN_TYPE_CONFIG) do
		if v.property == _property then
			return k
		end
	end
end

local function sortHeroCard(a, b)
	return a.weight > b.weight
end

function HeroListFunPanel:onBtnTypeClick(sender)
	for i, v in ipairs(self.btnTypeList) do
		if sender == v then
			if self.curSortType == i then
				self.sortSequence = self.sortSequence == 0 and 1 or 0
			else
				self.sortSequence = 0
				self.SORT_BTN_TYPE_CONFIG[self.curSortType].weight = self.SORT_BTN_TYPE_CONFIG[self.curSortType].weight - 100
				self.SORT_BTN_TYPE_CONFIG[i].weight = self.SORT_BTN_TYPE_CONFIG[i].weight + 100
				self.curSortType = i
			end
		end
	end

	self:refreshSortInfo()
	self:sortHeroCardList(self.sortInfo, true)
end

function HeroListFunPanel:refreshSortInfo()
	local tempSortHero = utils.deepcopy(self.SORT_BTN_TYPE_CONFIG)

	table.sort(tempSortHero, sortHeroCard)

	self.sortInfo = {}

	for i, v in ipairs(tempSortHero) do
		self.sortInfo[i] = {}
		self.sortInfo[i].property = v.property

		if i == 1 then
			self.sortInfo[i].sequence = self.sortSequence
		else
			self.sortInfo[i].sequence = 0
		end
	end
end

function HeroListFunPanel:sortHeroCardList(sortInfo, refreshUI)
	self.sortSequence = sortInfo[1].sequence

	if not self.managedHeroList then
		self:initManagedList()
	end

	local function sortHeroCard(a, b)
		if a[sortInfo[1].property] ~= b[sortInfo[1].property] then
			if self.sortSequence == 0 then
				return a[sortInfo[1].property] > b[sortInfo[1].property]
			else
				return a[sortInfo[1].property] < b[sortInfo[1].property]
			end
		else
			for i = 1, #sortInfo do
				if a[sortInfo[i].property] ~= b[sortInfo[i].property] then
					return a[sortInfo[i].property] > b[sortInfo[i].property]
				end
			end

			if a.id ~= b.id then
				return a.id > b.id
			else
				return a.gid > b.gid
			end
		end
	end

	table.sort(self.managedHeroList, sortHeroCard)
	self:filterHeroList(true)
	self:onBtnSensorClick()
	self:refreshBtnTypeArrowControl()

	if refreshUI then
		self:refreshHeroMainUI()
	end
end

function HeroListFunPanel:filterHeroCard(filterCheckFunc)
	self.filterCheckFunc = filterCheckFunc

	if not self.managedHeroList then
		self:initManagedList()
	end

	if self:filterHeroList() then
		local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

		if siftBoxDlg then
			siftBoxDlg:setVisible(false)
		end

		self:refreshHeroMainUI()
	end
end

function HeroListFunPanel:filterHeroList(noNotice)
	if self.filterCheckFunc then
		self.filterMangedList = {}

		local passCount = 0

		for i, v in ipairs(self.managedHeroList) do
			if self.filterCheckFunc(v) == true then
				passCount = passCount + 1
				self.managedHeroList[i].isHide = 0
			else
				self.managedHeroList[i].isHide = 1
			end
		end

		if passCount == 0 then
			return true
		end

		for i, v in ipairs(self.managedHeroList) do
			if self.managedHeroList[i].isHide and self.managedHeroList[i].isHide == 0 then
				table.insert(self.filterMangedList, self.managedHeroList[i])
			end
		end

		return true
	else
		self.filterMangedList = self.managedHeroList

		return true
	end
end

function HeroListFunPanel:refreshHeroMainUI()
	self.mWindow:refreshHeroCardList(nil, 1)
end

function HeroListFunPanel:onBtnSensorClick()
	self.listTypePanel:setVisible(false)
	self.btnSensor:setVisible(false)
end

function HeroListFunPanel:onBtnListTypeClick()
	self.listTypePanel:setVisible(not self.listTypePanel:getVisible())
	self.btnSensor:setVisible(self.listTypePanel:getVisible())
end

function HeroListFunPanel:getSortedFilterList()
	return self.filterMangedList
end

function HeroListFunPanel:refreshManagedList(gidRefreshFor)
	self:initManagedList(gidRefreshFor)

	if not self.sortInfo then
		self:refreshSortInfo()
	end

	self:sortHeroCardList(CurAvatar.heroCardSortConfig)
	self:filterHeroList(true)
end

function HeroListFunPanel:initManagedList(gidRefreshFor)
	if gidRefreshFor and self.managedHeroList then
		local listCount = #self.managedHeroList

		for i = 1, listCount do
			if self.managedHeroList[i].gid == gidRefreshFor then
				self.managedHeroList[i] = CurAvatar.heroDic[gidRefreshFor]
			end
		end
	else
		self.managedHeroList = {}

		for k, v in pairs(CurAvatar.heroDic) do
			table.insert(self.managedHeroList, CurAvatar.heroDic[k])
		end
	end
end

function HeroListFunPanel:getNewSortedFilterList(gidRefreshFor)
	self:refreshManagedList(gidRefreshFor)

	return self.filterMangedList
end

return HeroListFunPanel
