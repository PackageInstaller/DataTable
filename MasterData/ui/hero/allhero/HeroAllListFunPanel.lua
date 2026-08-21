-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\AllHero\\HeroAllListFunPanel.lua

local ResColor = require("ClientData/ResColor")
local UserData = require("Helper/UserData")
local strClassName = "HeroAllListFunPanel"
local ResHero = require("ClientData/ResHero")
local HeroAllListFunPanel = Class(strClassName, UIControls.Panel)

function HeroAllListFunPanel:ctor()
	self:initUI()
end

local SORT_BTN_TYPE_CONFIG = {
	{
		property = "inTeam",
		weight = 30,
		define_name = Lang.get(30368)
	},
	{
		property = "step",
		weight = 25,
		define_name = Lang.get(1105)
	},
	{
		property = "star",
		weight = 15,
		define_name = Lang.get(1204)
	},
	{
		property = "quality",
		weight = 10,
		define_name = Lang.get(372)
	},
	{
		property = "level",
		weight = 20,
		define_name = Lang.get(1203)
	}
}

function HeroAllListFunPanel:initUI()
	self.btnListType = UIControls.Button(self, self.mPath .. "/BtnListType", "Text")
	self.btnListTypeArrow = UIControls.Image(self, self.mPath .. "/BtnListType/ImgArrow")

	self.btnListType:addEventClick(self.onBtnListTypeClick)

	self.listTypePanel = UIControls.Panel(self, self.mPath .. "/ListTypePanel")
	self.btnTypeList = {}
	self.btnTypeArrow = {}
	self.btnTypeName = {}

	for i = 1, 4 do
		local btn = UIControls.Button(self, self.mPath .. "/ListTypePanel/BtnType" .. i)

		btn:addEventClick(self.onBtnTypeClick)

		local arrow = UIControls.Label(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/ImgArrow")
		local name = UIControls.Label(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/Text")

		table.insert(self.btnTypeList, btn)
		table.insert(self.btnTypeArrow, arrow)
		table.insert(self.btnTypeName, name)
	end

	self.curSortType = self:getSortBtnIdxByProperty(CurAvatar.heroCardSortConfig[1].property)

	local weightInitValue = SORT_BTN_TYPE_CONFIG[self.curSortType].weight < 100 and 100 or -100

	SORT_BTN_TYPE_CONFIG[self.curSortType].weight = SORT_BTN_TYPE_CONFIG[self.curSortType].weight + weightInitValue
	self.sortSequence = CurAvatar.heroCardSortConfig[1].sequence

	self:refreshBtnTypeArrowControl()

	self.btnFilter = UIControls.Button(self, self.mPath .. "/BtnListCustom")

	self.btnFilter:addEventClick(self.onBtnFilterClick)

	self.btnHeroSell = UIControls.Button(self, self.mPath .. "/BtnHeroSell")

	self.btnHeroSell:setVisible(false)

	self.btnBagAdd = UIControls.Button(self, self.mPath .. "/BtnBagAdd", "Text")

	self.btnBagAdd:setVisible(false)

	self.btnSensor = UIControls.Button(self, self.mPath .. "/UIClickThrough")

	self.btnSensor:addEventClick(self.onBtnSensorClick)
end

function HeroAllListFunPanel:refreshBtnTypeArrowControl()
	local arrowSprite = self.sortSequence == 0 and "IconBtnLevelDown" or "IconBtnLevelUp"
	local sequenceStr = self.sortSequence == 0 and "↓" or "↑"

	for i, v in ipairs(self.btnTypeArrow) do
		self.btnTypeArrow[i]:setVisible(self.curSortType == i)
		self.btnTypeArrow[i]:setText(sequenceStr)

		local color = self.curSortType == i and ResColor.ORANGEBTN or ResColor.GREYLIGHT

		self.btnTypeName[i]:setFontColor(color)

		local arrow = UIControls.Panel(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/ImgArrow")
	end

	self.btnListType:setText(SORT_BTN_TYPE_CONFIG[self.curSortType].define_name)
	self.btnListTypeArrow:setImage("Atlas/CommonAtlas/OtherAtlas", arrowSprite)
end

function HeroAllListFunPanel:onBtnFilterClick()
	local heroCardListSetDlg = UIManager.getUI("heroCardListSetDlg", true)

	heroCardListSetDlg:setFilterConfig(self.toggleGroupTypeFilter)
	heroCardListSetDlg:setSelectCallback(Slot(self.filterHeroCard, self))
end

function HeroAllListFunPanel:getSortBtnIdxByProperty(_property)
	for k, v in ipairs(SORT_BTN_TYPE_CONFIG) do
		if v.property == _property then
			return k
		end
	end

	CurAvatar:resetSortConfig()

	local prop = CurAvatar.heroCardSortConfig[1].property

	for k, v in ipairs(SORT_BTN_TYPE_CONFIG) do
		if v.property == prop then
			return k
		end
	end
end

function HeroAllListFunPanel:onBtnTypeClick(sender)
	for i, v in ipairs(self.btnTypeList) do
		if sender == v then
			if self.curSortType == i then
				self.sortSequence = self.sortSequence == 0 and 1 or 0
			else
				self.sortSequence = 0
				SORT_BTN_TYPE_CONFIG[self.curSortType].weight = SORT_BTN_TYPE_CONFIG[self.curSortType].weight - 100
				SORT_BTN_TYPE_CONFIG[i].weight = SORT_BTN_TYPE_CONFIG[i].weight + 100
				self.curSortType = i
			end
		end
	end

	local tempSortHero = utils.deepcopy(SORT_BTN_TYPE_CONFIG)

	local function sortHeroCard(a, b)
		return a.weight > b.weight
	end

	table.sort(tempSortHero, sortHeroCard)

	local sortInfo = {}

	for i, v in ipairs(tempSortHero) do
		sortInfo[i] = {}
		sortInfo[i].property = v.property

		if i == 1 then
			sortInfo[i].sequence = self.sortSequence
		else
			sortInfo[i].sequence = 0
		end
	end

	self:sortHeroCardList(sortInfo, true)
end

function HeroAllListFunPanel:sortHeroCardList(sortInfo, refreshUI)
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

function HeroAllListFunPanel:filterHeroCard(filterCheckFunc, refreshUI, toggleGroupTypeFilter)
	self.filterCheckFunc = filterCheckFunc
	self.toggleGroupTypeFilter = toggleGroupTypeFilter

	if not self.managedHeroList then
		self:initManagedList()
	end

	self:filterHeroList()

	if refreshUI then
		local heroCardListSetDlg = UIManager.getUI("heroCardListSetDlg", nil, false)

		if heroCardListSetDlg then
			heroCardListSetDlg:setVisible(false)
		end

		self:refreshHeroMainUI()
	end
end

function HeroAllListFunPanel:filterHeroList(noNotice)
	if self.filterCheckFunc then
		local passCount = 0

		for i, v in ipairs(self.managedHeroList) do
			if self.filterCheckFunc(v) == true then
				passCount = passCount + 1
				self.managedHeroList[i].isHide = 0
			else
				self.managedHeroList[i].isHide = 1
			end
		end

		if passCount == 0 and not noNotice then
			MsgManager.notice(Lang.get(3367))

			return
		end

		self.filterMangedList = {}

		for i, v in ipairs(self.managedHeroList) do
			if self.managedHeroList[i].isHide and self.managedHeroList[i].isHide == 0 then
				table.insert(self.filterMangedList, self.managedHeroList[i])
			end
		end
	else
		self.filterMangedList = self.managedHeroList
	end
end

function HeroAllListFunPanel:refreshHeroMainUI()
	self.mWindow:refreshHeroCardList(nil, 1)
end

function HeroAllListFunPanel:onBtnSensorClick()
	self.listTypePanel:setVisible(false)
	self.btnSensor:setVisible(false)
end

function HeroAllListFunPanel:onBtnListTypeClick()
	self.listTypePanel:setVisible(not self.listTypePanel:getVisible())
	self.btnSensor:setVisible(self.listTypePanel:getVisible())
end

function HeroAllListFunPanel:getSortedFilterList()
	return self.filterMangedList
end

function HeroAllListFunPanel:refreshManagedList()
	self:initManagedList()
	self:sortHeroCardList(CurAvatar.heroCardSortConfig)
	self:filterHeroCard(self.filterCheckFunc)
end

function HeroAllListFunPanel:initManagedList()
	if not self.managedHeroList then
		self.managedHeroList = {}

		for k, v in pairs(ResHero) do
			local hero = BaseObject.GetObject(k)

			hero.level = 1

			table.insert(self.managedHeroList, hero)
		end
	end
end

function HeroAllListFunPanel:getNewSortedFilterList()
	self:refreshManagedList()

	return self.filterMangedList
end

return HeroAllListFunPanel
