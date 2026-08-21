-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\RelicTips.lua

local ResHero = require("ClientData/ResHero")
local RelicTipsInfoPanel = require("UI/Common/Tips/RelicTipsInfoPanel")
local ResItem = require("ClientData/ResItem")
local ResColor = require("ClientData/ResColor")
local strClassName = "RelicTips"
local RelicTips = Class(strClassName, UIControls.Tips)

function RelicTips:ctor()
	self:initUI()
end

function RelicTips:initUI()
	self.imgWear = UIControls.Image(self, "BgPanel/ImgWear")
	self.btnUpgrade = UIControls.Button(self, "BgPanel/BtnUpgrade")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.txtName = UIControls.Label(self, "BgPanel/TextName")
	self.txtType = UIControls.Label(self, "BgPanel/TextName/TextType")
	self.txtRule = UIControls.Label(self, "BgPanel/TextRule")
	self.txtGoldCost = UIControls.Label(self, "BgPanel/BtnUpgrade/TextNum")
	self.iconCost = UIControls.Image(self, "BgPanel/BtnUpgrade/Icon")
	self.txtGoldUpgrade = UIControls.Label(self, "BgPanel/BtnUpgrade/Text")
	self.txtEng = UIControls.Label(self, "BgPanel/BtnUpgrade/TextEng")
	self.panelRelicInfo = RelicTipsInfoPanel(self, "BgPanel")
end

function RelicTips:_setObj(grid)
	self.relic = grid.object
	self.gridRelic = UIControls.RelicGridChild(self, "BgPanel/GridPanel", "System/Common/Grid/GridRelicSmallItem", 0, 0, true)
	self.gridRelic.inBag = true

	self.gridRelic:setObj(self.relic)
	self.gridRelic.imgNew:setVisible(false)

	self.gridRelic.mEnableTips = false

	self.txtName:setText(self.relic.name)
	self.txtType:setVisible(true)

	if self.relic.resData and self.relic.resData.career_tips then
		self.txtType:setText(self.relic.resData.career_tips)
	elseif self.relic.campLimit and self.relic.careerLimit then
		local campName = Const.CAMP_CONFIG[self.relic.campLimit].name
		local careerName = Const.CAREER_CONFIG[self.relic.careerLimit].name

		self.txtType:setText(utils.format(Lang.get(30249), campName, careerName))
	elseif self.relic.campLimit then
		local campName = Const.CAMP_CONFIG[self.relic.campLimit].name

		self.txtType:setText(string.format(Lang.get(30250), campName))
	elseif self.relic.careerLimit then
		local careerName = Const.CAREER_CONFIG[self.relic.careerLimit].name

		self.txtType:setText(string.format(Lang.get(30250), careerName))
	elseif self.relic.heroIdLimit then
		if utils.tableIsContainsElement(Const.ARTIFACT_RELIC_TIPSINFO_CHANGE_LIST, self.relic.heroIdLimit) then
			self.txtType:setText(Lang.get(56678))
		else
			self.txtType:setText(string.format(Lang.get(30250), ResHero[self.relic.heroIdLimit].hero_name))
		end
	else
		self.txtType:setVisible(false)
	end

	self.txtRule:setText(self.relic.desc)
	self.imgWear:setVisible(self.relic.inWearing ~= nil)
	self.panelRelicInfo:setRelic(self.relic)

	self.lvUpNeedInfo = self.relic:getLvUpNeed()

	if self.lvUpNeedInfo and grid.inBag then
		if self.relic.resData.level_up_item_id then
			self.txtGoldCost:setText(ClientUtils.getNumShortStr(self.lvUpNeedInfo[self.relic.resData.level_up_item_id]))

			local iconPath = BaseObject.GetObject(self.relic.resData.level_up_item_id):getIconPath()

			if iconPath then
				self.iconCost:setImage(iconPath[1], iconPath[2])
			end
		else
			self.txtGoldCost:setText(ClientUtils.getNumShortStr(self.lvUpNeedInfo[Const.MONEY_ID_GOLD]))
		end

		self.btnUpgrade:setObjGray(not CurAvatar:relicCanLvUp(self.relic))

		if not CurAvatar:relicCanLvUp(self.relic) then
			self.txtGoldCost:setFontColor(ResColor.GREYWHITE)
			self.txtGoldUpgrade:setFontColor(ResColor.GREYWHITE)
			self.txtEng:setFontColor(ResColor.GREYWHITE)
		else
			self.txtGoldCost:setFontColor(ResColor.WHITE)
			self.txtGoldUpgrade:setFontColor(ResColor.WHITE)
			self.txtEng:setFontColor(ResColor.BLUE)
		end

		self.btnUpgrade:setVisible(true)
	else
		self.btnUpgrade:setVisible(false)
	end
end

function RelicTips:onBtnUpgradeClick()
	self:setVisible(false)

	if self.lvUpNeedInfo then
		for materialId, needNum in pairs(self.lvUpNeedInfo) do
			if needNum > CurAvatar:getItemNumById(materialId) then
				MsgManager.notice(string.format(Lang.get(30029), ResItem[materialId].name))

				return
			end
		end
	end

	RPC.relicLevelUp(self.relic.id, self.relic.enhanceLevel + 1)
end

return RelicTips
