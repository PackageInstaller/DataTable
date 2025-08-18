-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SendHero\\ActivitySendHeroUpTipsDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivitySendHeroUpTipsCell = Class("ActivitySendHeroUpTipsCell", UIControls.Child)

function ActivitySendHeroUpTipsCell:ctor()
	self:initUI()
end

function ActivitySendHeroUpTipsCell:initUI()
	self.textDesc = UIControls.Label(self, "TxtHeroBuff")
	self.gridHero = UIControls.GridSimpleContainerChild(self, "HeroPanel", "System/Common/Grid/GridContainer", 0, 0, true)
	self.panelOk = UIControls.Panel(self, "ImgHigh")
end

function ActivitySendHeroUpTipsCell:setData(hero, lvDesc)
	self.textDesc:setText(lvDesc)
	self.panelOk:setVisible(false)
	self.gridHero:setObj(hero)
end

function ActivitySendHeroUpTipsCell:setNow()
	self.panelOk:setVisible(true)
end

local strClassName = "ActivitySendHeroUpTipsDlg"
local ActivitySendHeroUpTipsDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivitySendHeroUpTipsDlg, ActivityPanelMixin)

function ActivitySendHeroUpTipsDlg:initUI()
	self.cells = {}
	self.panelContent = UIControls.Panel(self, "BgPanel/HeroStarList/Content")
end

function ActivitySendHeroUpTipsDlg:_setData()
	self.miscData = self.actObj.actData.miscData

	local needHeroId = self.miscData.hero_id
	local nowStar = CurAvatar:getHeroMaxStar(needHeroId)
	local starData = {}

	for _, data in pairs(self.actObj.actData.heroStarBonusData) do
		table.insert(starData, data)
	end

	local nowIndex = 0

	table.sort(starData, utils.getSortingFunc("hero_star", true))

	for index = 1, #starData do
		local newCell = ActivitySendHeroUpTipsCell(self, "BgPanel/HeroStarList/Content", "System/Activity/ActivityDispatch/DispatchHeroBuffCell", 0, 0, true)
		local hero = BaseObject.GetObject(needHeroId)

		hero.star = starData[index].hero_star

		local value = starData[index].bonus - 10000

		value = value / 100 .. "%"

		newCell:setData(hero, string.format(self.miscData.hero_up_desc, value))
		table.insert(self.cells, newCell)

		if nowStar >= starData[index].hero_star then
			nowIndex = index
		end
	end

	if self.cells[nowIndex] then
		self.cells[nowIndex]:setNow()
	end

	if nowIndex > 1 then
		self.panelContent:setPosition(0, math.min(nowIndex - 1, #starData - 2) * 150)
	end
end

return ActivitySendHeroUpTipsDlg
