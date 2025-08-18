-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityRelatedHeroGiftNewPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResHero = require("ClientData/ResHero")
local ActivityGiftCell = require("UI/OpActivity/ActivityGiftCell")
local RelatedGiftNewCell = Class("RelatedGiftNewCell", ActivityGiftCell)

function RelatedGiftNewCell:ctor()
	self.panelLock = UIControls.Panel(self, "ContentPanel/ImgLock")
	self.textLockRule = UIControls.Label(self, "ContentPanel/ImgLock/BgRule/Text")
	self.iconStar = UIControls.Image(self, "ContentPanel/ImgLock/BgRule/IconStar")
end

function RelatedGiftNewCell:setGiftData(productData, svrData)
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

local strClassName = "ActivityRelatedHeroGiftNewPage"
local ActivityRelatedHeroGiftNewPage = Class(strClassName, UIControls.Child)

MixinClass(ActivityRelatedHeroGiftNewPage, ActivityPanelMixin)

function ActivityRelatedHeroGiftNewPage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.btnGet = UIControls.Button(self, "BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.btnJump = UIControls.Button(self, "BtnGo", "Text")

	self.btnJump:addEventClick(self.onJumpClick)

	self.cells = {}
	self.giftPanel = {}

	for i = 1, 5 do
		local giftPanel = UIControls.Panel(self, "GiftList/Content/GiftPanel0" .. i)

		table.insert(self.giftPanel, giftPanel)
	end
end

function ActivityRelatedHeroGiftNewPage:_setData()
	self.clientData = self.actObj.actData:getAllProduct(true) or {}
	self.serverData = self.actObj.actData.serverData

	if self.clientTemplateData.template_args then
		self.heroId = tonumber(self.clientTemplateData.template_args[1])
		self.relateData = Const.UNIQUE_HERO[self.heroId]
		self.hasHero = CurAvatar:getHeroCountByResId(self.heroId) > 0
		self.hasRelatedHero = CurAvatar:getHeroCountByResId(self.relateData.resid) > 0
	end

	self.btnGet:setVisible(not self.hasHero or not self.hasRelatedHero)

	local relatedHero = CurAvatar:getHeroMaxStarHero(self.relateData.resid)

	self.btnJump:setVisible(self.hasHero and self.hasRelatedHero and relatedHero:canStarUp())

	for i, v in ipairs(self.giftPanel) do
		if self.clientData[i] then
			v:setVisible(true)

			if self.cells[i] == nil then
				self.cells[i] = RelatedGiftNewCell(self, "GiftList/Content/GiftPanel0" .. i, "System/" .. self.clientTemplateData.src_replace[1] .. "0" .. i)
			end

			self.cells[i]:setVisible(true)
			self.cells[i]:setGiftData(self.clientData[i], self.serverData[self.clientData[i][1].rechargeId])

			self.cells[i].mEventClick = Slot(self.onCellClick, self)
		else
			v:setVisible(false)
		end
	end
end

function ActivityRelatedHeroGiftNewPage:onBtnGetClick()
	if not self.hasHero then
		local jumpId = tonumber(self.clientTemplateData.template_args[2])

		JumpGuideManager.jump(jumpId)
	elseif not self.hasRelatedHero and self.relateData.act_id then
		local actObj = CurAvatar:getActivityObj(self.relateData.act_id)

		if actObj and actObj:isValid() then
			CurAvatar:jumpToShowActivity(self.relateData.act_id)
		else
			JumpGuideManager.jump(self.relateData.jump_id)
		end
	end
end

function ActivityRelatedHeroGiftNewPage:onJumpClick()
	if self.hasHero and self.hasRelatedHero then
		if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_STARUP) then
			MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HERO_STARUP))
		else
			local relatedHero = CurAvatar:getHeroMaxStarHero(self.relateData.resid)

			if relatedHero then
				local starUpDlg = UIManager.getUI("heroStarUpDlg", true)

				starUpDlg:steHeroToExchagngePanel(relatedHero)
			end
		end
	end
end

function ActivityRelatedHeroGiftNewPage:_onShow()
	self:_setData()
end

function ActivityRelatedHeroGiftNewPage:onCellClick(sender)
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

function ActivityRelatedHeroGiftNewPage:onActivityDataRefresh(actObj)
	self:_setData()
end

return ActivityRelatedHeroGiftNewPage
