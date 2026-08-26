-- chunkname: @modules/logic/battlepass/view/BpPropView2.lua

module("modules.logic.battlepass.view.BpPropView2", package.seeall)

local BpPropView2 = class("BpPropView2", BaseView)

function BpPropView2:onInitView()
	self._bgClick = gohelper.getClick(self.viewGO)
	self._scrollitem = gohelper.findChild(self.viewGO, "#scroll")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll/itemcontent")
	self._goeff = gohelper.findChild(self.viewGO, "#go_eff")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btnOK")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btnBuy")
	self._goSpecial = gohelper.findChildTextMesh(self.viewGO, "#btnBuy/#txt")
	self._txtlv = gohelper.findChildText(self.viewGO, "title/level/#txt_lv")
	self._scrollContent2 = gohelper.findChild(self.viewGO, "#scroll2/Viewport/#go_rewards")
	self._item = gohelper.findChild(self.viewGO, "#scroll2/Viewport/#go_rewards/#go_Items")
end

function BpPropView2:addEvents()
	self._bgClick:AddClickListener(self._onClickBG, self)
	self._btnclose:AddClickListener(self._onClickOK, self)
	self._btnBuy:AddClickListener(self.openChargeView, self)
end

function BpPropView2:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._bgClick:RemoveClickListener()
end

function BpPropView2:_onClickBG()
	if not self._openDt or self._openDt + 1 > UnityEngine.Time.time then
		return
	end

	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "关闭"
	})
	self:closeThis()
end

function BpPropView2:_onClickOK()
	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "确定"
	})
	self:closeThis()
end

function BpPropView2:onOpen()
	self.bpCo = BpModel.instance:getBpCO()
	self._openDt = UnityEngine.Time.time
	CommonPropListItem.hasOpen = false

	self:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.BpPropView2, self._onClickBG, self)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end

	local bpLv = BpModel.instance:getBpLv()

	self._txtlv.text = bpLv

	gohelper.setActive(self._item, false)

	local dict = {}
	local list = {}

	for level = 1, bpLv do
		local bonusCO = BpConfig.instance:getBonusCO(BpModel.instance.id, level)

		self:_calcBonus(dict, list, bonusCO.payBonus)
	end

	self:_sortList(list)

	local specialBonus = BpModel.instance:getSpecialBonus()

	if specialBonus then
		local bonus = specialBonus[1]

		table.insert(list, 1, {
			isSpecial = true,
			materilType = bonus[1],
			materilId = bonus[2],
			quantity = bonus[3]
		})
	end

	local haveSpecialBonus = BpModel.instance:haveSpecialBonus()

	gohelper.setActive(self._goSpecial.gameObject, haveSpecialBonus)

	if haveSpecialBonus then
		self._goSpecial.text = self.bpCo.specialPropDesc
	end

	gohelper.CreateObjList(self, self._createItem, list, self._scrollContent2, self._item)
end

function BpPropView2:_sortList(list)
	table.sort(list, function(a, b)
		if self:getIsSkin(a) ~= self:getIsSkin(b) then
			return self:getIsSkin(a)
		elseif self:getIsSummon(a) ~= self:getIsSummon(b) then
			return self:getIsSummon(a)
		elseif self:getIsEquip(a) ~= self:getIsEquip(b) then
			return self:getIsEquip(a)
		elseif CommonPropListModel.instance:_getQuality(a) ~= CommonPropListModel.instance:_getQuality(b) then
			return CommonPropListModel.instance:_getQuality(a) > CommonPropListModel.instance:_getQuality(b)
		elseif a.materilType ~= b.materilType then
			return a.materilType > b.materilType
		elseif a.materilType == MaterialEnum.MaterialType.Item and b.materilType == MaterialEnum.MaterialType.Item and CommonPropListModel.instance:_getSubType(a) ~= CommonPropListModel.instance:_getSubType(b) then
			return CommonPropListModel.instance:_getSubType(a) < CommonPropListModel.instance:_getSubType(b)
		elseif a.materilId ~= b.materilId then
			return a.materilId > b.materilId
		end
	end)
end

function BpPropView2:getIsSkin(config)
	return config.materilType == MaterialEnum.MaterialType.HeroSkin
end

function BpPropView2:getIsEquip(config)
	return config.materilType == MaterialEnum.MaterialType.Equip and config.materilId == 1000
end

function BpPropView2:getIsSummon(config)
	return config.materilType == MaterialEnum.MaterialType.Item and config.materilId == 140001
end

function BpPropView2:_calcBonus(dict, list, bonusStr)
	for _, str in pairs(string.split(bonusStr, "|")) do
		local sp = string.splitToNumber(str, "#")
		local id = sp[2]
		local num = sp[3]

		if not dict[id] then
			dict[id] = {
				materilType = sp[1],
				materilId = sp[2],
				quantity = sp[3],
				[4] = sp[4],
				[5] = sp[5]
			}

			table.insert(list, dict[id])
		else
			dict[id].quantity = dict[id].quantity + num
		end
	end
end

function BpPropView2:_createItem(obj, data, index)
	local limit = gohelper.findChild(obj, "#go_Limit")
	local txtLimit = gohelper.findChildTextMesh(obj, "#go_Limit/txt_Limit")
	local itemGo = gohelper.findChild(obj, "#go_item")
	local isNew = gohelper.findChild(obj, "#go_new")
	local go_cruise = gohelper.findChild(obj, "#go_cruise")
	local txtCruise = gohelper.findChildTextMesh(obj, "#go_cruise/txt_Limit")
	local materilType = data.materilType
	local materilId = data.materilId
	local quantity = data.quantity
	local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemGo)

	itemIcon:setMOValue(materilType, materilId, quantity, nil, true)

	local showNum = quantity and quantity ~= 0

	if self:getIsSkin(data) then
		showNum = false
	end

	itemIcon:isShowEquipAndItemCount(showNum)

	if showNum then
		itemIcon:setCountText(GameUtil.numberDisplay(quantity))
	end

	itemIcon:setCountFontSize(43)

	if data.isSpecial then
		local cfg = BpModel.instance:getSpecialDes(self.id)
		local isLimit = cfg.tagType == 1

		gohelper.setActive(limit, isLimit)

		if isLimit then
			txtLimit.text = cfg.tagTxt
		end

		local isCruise = data.tagType == 2

		gohelper.setActive(go_cruise, isCruise)

		if isCruise then
			txtCruise.text = data.tagTxt
		end

		itemIcon:setCanShowDeadLine(not isCruise)
	else
		gohelper.setActive(limit, false)
		gohelper.setActive(go_cruise, false)
	end

	gohelper.setActive(isNew, data[5] == 1)
end

function BpPropView2:onClickModalMask()
	self:closeThis()
end

function BpPropView2:_setPropItems()
	CommonPropListModel.instance:setPropList(self.viewParam)

	local list = CommonPropListModel.instance:getList()

	for i, mo in ipairs(list) do
		local go = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gocontent, "cell" .. i)

		transformhelper.setLocalScale(go.transform, 0.7, 0.7, 0.7)

		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, CommonPropListItem)

		comp._index = i
		comp._view = self

		comp:onUpdateMO(mo)

		function comp.callback()
			comp:setCountFontSize(43)
		end
	end
end

function BpPropView2:openChargeView()
	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "解锁吼吼典藏光碟"
	})
	ViewMgr.instance:openView(BpController.instance:getBpChargeView())
	self:closeThis()
end

function BpPropView2:onClose()
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false
end

function BpPropView2:onDestroyView()
	return
end

return BpPropView2
