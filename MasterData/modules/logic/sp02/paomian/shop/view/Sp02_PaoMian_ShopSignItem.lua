-- chunkname: @modules/logic/sp02/paomian/shop/view/Sp02_PaoMian_ShopSignItem.lua

module("modules.logic.sp02.paomian.shop.view.Sp02_PaoMian_ShopSignItem", package.seeall)

local Sp02_PaoMian_ShopSignItem = class("Sp02_PaoMian_ShopSignItem", LuaCompBase)

function Sp02_PaoMian_ShopSignItem:init(go)
	self.go = go
	self._simageIcon = gohelper.findChildSingleImage(self.go, "simage_Icon")
	self._txtDay = gohelper.findChildText(self.go, "txt_Day")
	self._txtNum = gohelper.findChildText(self.go, "go_num/txt_num")
	self._goCanGet = gohelper.findChild(self.go, "go_CanGet")
	self._goHasGet = gohelper.findChild(self.go, "go_HasGet")
	self._goNextDay = gohelper.findChild(self.go, "go_NextDay")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")

	self:initDayImageTab()
end

function Sp02_PaoMian_ShopSignItem:initDayImageTab()
	self._dayImageTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goDay = gohelper.findChild(self._txtDay.gameObject, "image_num_" .. i)

		if gohelper.isNil(goDay) then
			return
		end

		gohelper.setActive(goDay, false)

		self._dayImageTab[i] = goDay
	end
end

function Sp02_PaoMian_ShopSignItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Sp02_PaoMian_ShopSignItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Sp02_PaoMian_ShopSignItem:_btnClickOnClick()
	if ActivityType101Model.instance:isType101RewardCouldGet(self._actId, self._id) then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, self._id)

		return
	end

	MaterialTipController.instance:showMaterialInfo(self._itemType, self._itemId)
end

function Sp02_PaoMian_ShopSignItem:onUpdateMO(signCo, index)
	self._signCo = signCo
	self._actId = signCo and signCo.activityId
	self._id = signCo and signCo.id
	self._index = index
	self._bonusList = ActivityType101Config.instance:getDayBonusList(self._actId, self._id)

	self:refreshUI()
end

function Sp02_PaoMian_ShopSignItem:refreshUI()
	self._txtDay.text = string.format("%s<#ac9f90><size=14>DAY</size></color>", self._index)

	local hasGet = ActivityType101Model.instance:isType101RewardGet(self._actId, self._id)
	local canGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, self._id)

	gohelper.setActive(self._goHasGet, hasGet)
	gohelper.setActive(self._goCanGet, canGet)

	local isLock = not hasGet and not canGet
	local isNextDayCanGet = false

	if isLock and self._id > 1 then
		local lastDayTaskId = self._id - 1
		local isLastDayGet = ActivityType101Model.instance:isType101RewardGet(self._actId, lastDayTaskId)
		local isLastCanGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, lastDayTaskId)

		isNextDayCanGet = isLastDayGet or isLastCanGet
	end

	gohelper.setActive(self._goNextDay, isNextDayCanGet)
	self:refreshBonus()
	self:refreshDayImage()
end

function Sp02_PaoMian_ShopSignItem:refreshDayImage()
	if not self._dayImageTab then
		return
	end

	for i, goDay in pairs(self._dayImageTab) do
		gohelper.setActive(goDay, i == self._index)
	end
end

function Sp02_PaoMian_ShopSignItem:refreshBonus()
	self._itemInfo = self._bonusList and self._bonusList[1]
	self._itemType = self._itemInfo and self._itemInfo[1]
	self._itemId = self._itemInfo and self._itemInfo[2]
	self._itemNum = self._itemInfo and self._itemInfo[3]
	self._txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), self._itemNum)

	local itemCo, itemIconUrl = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId, true)

	self._simageIcon:LoadImage(itemIconUrl)
end

function Sp02_PaoMian_ShopSignItem:onDestroy()
	self._simageIcon:UnLoadImage()
end

return Sp02_PaoMian_ShopSignItem
