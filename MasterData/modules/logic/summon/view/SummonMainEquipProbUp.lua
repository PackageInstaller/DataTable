-- chunkname: @modules/logic/summon/view/SummonMainEquipProbUp.lua

module("modules.logic.summon.view.SummonMainEquipProbUp", package.seeall)

local SummonMainEquipProbUp = class("SummonMainEquipProbUp", BaseView)

function SummonMainEquipProbUp:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageequip1 = gohelper.findChildSingleImage(self.viewGO, "#simage_equip1")
	self._simageequip2 = gohelper.findChildSingleImage(self.viewGO, "#simage_equip2")
	self._simageequip3 = gohelper.findChildSingleImage(self.viewGO, "#simage_equip3")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#txt_deadline/#simage_line")
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._goequip1 = gohelper.findChild(self.viewGO, "#go_ui/equip/right/#go_equip1")
	self._goequip2 = gohelper.findChild(self.viewGO, "#go_ui/equip/right/#go_equip2")
	self._goequip3 = gohelper.findChild(self.viewGO, "#go_ui/equip/right/#go_equip3")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	self._txtsummon1 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/#txt_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")
	self._gosinglefree = gohelper.findChild(self.viewGO, "#go_ui/summonbtns/summon1/#go_singlefree")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/#txt_deadline")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainEquipProbUp:addEvents()
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function SummonMainEquipProbUp:removeEvents()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

SummonMainEquipProbUp.preloadList = {
	ResUrl.getSummonEquipIcon("full/bg")
}

function SummonMainEquipProbUp:_editableInitView()
	self:initConst()
	self:refreshSingleImage()

	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_initEquipItems()
end

local UI_Max_Rare = 6

function SummonMainEquipProbUp:initConst()
	self._uiMaxLocation = 3
end

function SummonMainEquipProbUp:_initEquipItems()
	self._equipItemsMap = self._equipItemsMap or {}

	for index = 1, self._uiMaxLocation do
		local goItem = self["_goequip" .. tostring(index)]

		if not gohelper.isNil(goItem) then
			local equipItemObj = self:getUserDataTb_()

			equipItemObj.go = goItem
			equipItemObj.txtName = gohelper.findChildText(goItem, "name")
			equipItemObj.btnDetail = gohelper.findChildButtonWithAudio(goItem, "btn_detail")

			equipItemObj.btnDetail:AddClickListener(self.onClickItem, self, index)

			for j = 1, UI_Max_Rare do
				equipItemObj["star" .. j] = gohelper.findChild(goItem, "stars/go_star" .. tostring(j))
			end

			for j = 5, UI_Max_Rare do
				equipItemObj["rare" .. j] = gohelper.findChild(goItem, "rare/rare" .. tostring(j))
			end

			self._equipItemsMap[index] = equipItemObj
		end
	end
end

function SummonMainEquipProbUp:onDestroyView()
	if self._equipItemsMap then
		for _, v in pairs(self._equipItemsMap) do
			v.btnDetail:RemoveClickListener()
		end

		self._equipItemsMap = nil
	end

	self:unloadSingleImage()
end

function SummonMainEquipProbUp:refreshSingleImage()
	self._simagebg:LoadImage(ResUrl.getSummonEquipIcon("full/bg"))
	self._simageequip1:LoadImage(ResUrl.getSummonEquipIcon("img_role_6"))
	self._simageequip2:LoadImage(ResUrl.getSummonEquipIcon("img_role_7"))
	self._simageequip3:LoadImage(ResUrl.getSummonEquipIcon("img_role_8"))
	self._simageline:LoadImage(ResUrl.getSummonCoverBg("hero/title_img_deco"))
end

function SummonMainEquipProbUp:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simageequip1:UnLoadImage()
	self._simageequip2:UnLoadImage()
	self._simageequip3:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

function SummonMainEquipProbUp:onClickItem(index)
	local curPool = SummonMainModel.instance:getCurPool()
	local equipDetailCoDict = SummonMainModel.instance:getEquipDetailListByPool(curPool)
	local equipDetailCo = equipDetailCoDict[index]

	if equipDetailCo then
		local equipCo = EquipConfig.instance:getEquipCo(equipDetailCo.equipId)

		if equipCo then
			local param = {}

			param.equipId = equipCo.id

			EquipController.instance:openEquipView(param)
		end
	end
end

function SummonMainEquipProbUp:onUpdateParam()
	return
end

function SummonMainEquipProbUp:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.onInfoGot, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playEnterAnim, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
	self:playEnterAnim()
	self:_refreshView()
end

function SummonMainEquipProbUp:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
	end

	if self._animRoot then
		self._animRoot:Play(SummonEnum.SummonEquipAnimationSwitch, 0, 0)
	end
end

function SummonMainEquipProbUp:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playEnterAnim, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.onInfoGot, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonMainEquipProbUp:_btnsummon1OnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(curPool.cost1)
	local param = {}

	param.type = cost_type
	param.id = cost_id
	param.quantity = cost_num
	param.callback = self._summon1Confirm
	param.callbackObj = self
	param.notEnough = false

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local itemEnough = cost_num <= num
	local everyCostCount = SummonMainModel.instance.everyCostCount
	local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not itemEnough and currencyNum < everyCostCount then
		param.notEnough = true
	end

	if itemEnough then
		param.needTransform = false

		self:_summon1Confirm()

		return
	else
		param.needTransform = true
		param.cost_type = SummonMainModel.instance.costCurrencyType
		param.cost_id = SummonMainModel.instance.costCurrencyId
		param.cost_quantity = everyCostCount
		param.miss_quantity = 1
	end

	SummonMainController.instance:openSummonConfirmView(param)
end

function SummonMainEquipProbUp:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonMainEquipProbUp:_btnsummon10OnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(curPool.cost10)
	local param = {}

	param.type = cost_type
	param.id = cost_id
	param.quantity = cost_num
	param.callback = self._summon10Confirm
	param.callbackObj = self
	param.notEnough = false

	local ownNum = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local itemEnough = cost_num <= ownNum
	local everyCostCount = SummonMainModel.instance.everyCostCount
	local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()
	local remainCount = 10 - ownNum
	local costRemain = everyCostCount * remainCount

	if not itemEnough and currencyNum < costRemain then
		param.notEnough = true
	end

	if itemEnough then
		param.needTransform = false

		self:_summon10Confirm()

		return
	else
		param.needTransform = true
		param.cost_type = SummonMainModel.instance.costCurrencyType
		param.cost_id = SummonMainModel.instance.costCurrencyId
		param.cost_quantity = costRemain
		param.miss_quantity = remainCount
	end

	SummonMainController.instance:openSummonConfirmView(param)
end

function SummonMainEquipProbUp:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonMainEquipProbUp:_refreshView()
	self.summonSuccess = false

	self:_refreshCost()
	self:_refreshEquips()
	self:_refreshOpenTime()
end

function SummonMainEquipProbUp:_refreshOpenTime()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)

	if poolMO ~= nil and poolMO.offlineTime ~= 0 and poolMO.offlineTime < TimeUtil.maxDateTimeStamp then
		local time = poolMO.offlineTime - ServerTime.now()

		self._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(time))
	else
		self._txtdeadline.text = ""
	end
end

SummonMainEquipProbUp.SingleFreeTextPosX = 17.4
SummonMainEquipProbUp.SingleCostTextPosX = 83.3

function SummonMainEquipProbUp:_refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	self._txtsummon1.text = luaLang("summon_equip_one_times")

	recthelper.setAnchorX(self._txtsummon1.transform, SummonMainEquipProbUp.SingleCostTextPosX)
	gohelper.setActive(self._gosinglefree, false)

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
	end
end

function SummonMainEquipProbUp:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	gohelper.setActive(icon.gameObject, true)
	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonMainEquipProbUp:_refreshSingleFree(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	gohelper.setActive(icon.gameObject, false)

	self[numTxt .. "1"].text = ""
	self[numTxt .. "2"].text = ""
end

function SummonMainEquipProbUp:_refreshEquips()
	local curPool = SummonMainModel.instance:getCurPool()
	local equipDetailCoDict = SummonMainModel.instance:getEquipDetailListByPool(curPool)

	for location = 1, self._uiMaxLocation do
		local item = self._equipItemsMap[location]

		if not equipDetailCoDict[location] then
			if item then
				item.go:SetActive(false)
			end
		elseif item then
			self:_refreshEquipItem(item, location, equipDetailCoDict[location])
		end
	end
end

function SummonMainEquipProbUp:_refreshEquipItem(item, index, detailCo)
	item.go:SetActive(true)

	local equipCo = EquipConfig.instance:getEquipCo(detailCo.equipId)

	item.txtName.text = equipCo.name

	self:_applyStars(item, equipCo.rare)
	self:_applyRare(item, equipCo.rare)
end

function SummonMainEquipProbUp:_applyStars(item, rare)
	local starCount = 1 + rare

	for i = 1, UI_Max_Rare do
		gohelper.setActive(item["star" .. tostring(i)], i <= starCount)
	end
end

function SummonMainEquipProbUp:_applyRare(item, rare)
	local starCount = 1 + rare

	for i = 5, UI_Max_Rare do
		gohelper.setActive(item["rare" .. tostring(i)], i == starCount)
	end
end

function SummonMainEquipProbUp:onSummonFailed()
	self.summonSuccess = false

	self:_refreshCost()
end

function SummonMainEquipProbUp:onSummonReply()
	self.summonSuccess = true
end

function SummonMainEquipProbUp:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:_refreshCost()
end

function SummonMainEquipProbUp:onInfoGot()
	self:_refreshCost()
end

return SummonMainEquipProbUp
