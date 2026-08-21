-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitRelatedHeroGiftPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResHero = require("ClientData/ResHero")
local ActivityGiftCell = require("UI/OpActivity/ActivityGiftCell")
local RelatedGiftCell = Class("RelatedGiftCell", ActivityGiftCell)

function RelatedGiftCell:ctor()
	self.panelLock = UIControls.Panel(self, "ContentPanel/ImgLock")
	self.textLockRule = UIControls.Label(self, "ContentPanel/ImgLock/BgRule/Text")
	self.iconStar = UIControls.Image(self, "ContentPanel/ImgLock/BgRule/IconStar")
end

function RelatedGiftCell:setGiftData(productData, svrData)
	local product = productData[1]
	local gData = productData[2]

	self.inLock = productData[3]

	self:initData({
		product,
		gData
	}, svrData)

	if self.inLock then
		self.TextLimit:setText(Lang.get(195))
		self.panelLock:setVisible(true)

		local condId = gData.limit_id
		local condData = ResConditionLimit[condId]

		if condData and condData.hero_id and condData.hero_star and ResHero[condData.hero_id] then
			self.textLockRule:setText(ResHero[condData.hero_id].hero_name or "")

			local starPath = UIConst.getHeroStarPath(condData.hero_star, true)

			if starPath then
				self.iconStar:setImage(starPath[1], starPath[2])
			end
		end

		self.unlockDesc = ConditionLimitManager.getLimitUnlockDesc(condId)
	else
		self.panelLock:setVisible(false)
	end
end

local strClassName = "ActivitRelatedHeroGiftPage"
local ActivitRelatedHeroGiftPage = Class(strClassName, UIControls.Child)

MixinClass(ActivitRelatedHeroGiftPage, ActivityPanelMixin)

function ActivitRelatedHeroGiftPage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textRule = UIControls.Label(self, "VanityHeroPanel/BgTextDes/TextDes")
	self.gridHeroLeft = UIControls.RelatedHeroGridChild(self, "VanityHeroPanel/GridLeftPanel", "System/Hero/GridVanityHeroStarUp", 0, 0, true)
	self.gridHeroLeft.mEventClick = Slot(self.onClickHeroGrid, self)
	self.gridHeroRight = UIControls.RelatedHeroGridChild(self, "VanityHeroPanel/GridRightPanel", "System/Hero/GridVanityHeroStarUp", 0, 0, true)
	self.gridHeroRight.mEventClick = Slot(self.onClickHeroGrid, self)
	self.btnLeftGet = UIControls.Button(self, "BtnLeftGo")
	self.cells = {}
end

function ActivitRelatedHeroGiftPage:_setData()
	self.clientData = self.actObj.actData:getAllProduct(true) or {}
	self.serverData = self.actObj.actData.serverData

	for i = #self.cells + 1, #self.clientData do
		self.cells[i] = RelatedGiftCell(self, "GiftList/Content", "System/Activity/ActivityVanityHero/VanityHeroGiftItem01")
		self.cells[i].mEventClick = Slot(self.onCellClick, self)
	end

	for index, cell in ipairs(self.cells) do
		local data = self.clientData[index]

		if data then
			cell:setVisible(true)
			self.cells[index]:setGiftData(data, self.serverData[data[1].rechargeId])
		else
			cell:setVisible(false)
		end
	end

	if self.clientTemplateData.template_args then
		self.heroId1 = tonumber(self.clientTemplateData.template_args[1])

		self.gridHeroLeft:setHero(self.heroId1)
		self.btnLeftGet:setVisible(not self.gridHeroLeft.hasHero)

		self.heroId2 = tonumber(self.clientTemplateData.template_args[2])

		self.gridHeroRight:setHero(self.heroId2)
	end
end

function ActivitRelatedHeroGiftPage:onClickHeroGrid(sender)
	JumpGuideManager.jump(Const.HANDBOOK_JUMP_HERO_ID, "", sender.heroId)
end

function ActivitRelatedHeroGiftPage:_onShow()
	self:_setData()
end

function ActivitRelatedHeroGiftPage:onCellClick(sender)
	if sender.isSoldOut == true then
		MsgManager.notice(Lang.get(30596))
	else
		local ui = UIManager.getUI("giftBuyBox")

		ui:showShopItem(sender.data, self, nil, sender.data.rechargeId, self.actObj)
		ui:bindWindow(self)

		if sender.data.price == 0 then
			ui:onItemBuy()
		else
			ui:setVisible(true)
		end
	end
end

function ActivitRelatedHeroGiftPage:onActivityDataRefresh(actObj)
	self:_setData()
end

return ActivitRelatedHeroGiftPage
