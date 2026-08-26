-- chunkname: @modules/logic/survival/view/map/comp/SurvivalBagInfoPart.lua

module("modules.logic.survival.view.map.comp.SurvivalBagInfoPart", package.seeall)

local SurvivalBagInfoPart = class("SurvivalBagInfoPart", LuaCompBase)

function SurvivalBagInfoPart:init(go)
	self._anim = gohelper.findChildAnim(go, "")
	self.go = go
	self.parent = go.transform.parent
	self._goinfo = gohelper.findChild(go, "root/#go_info")
	self._goempty = gohelper.findChild(go, "root/#go_empty")
	self._goquality5 = gohelper.findChild(go, "root/#go_quality")
	self._goprice = gohelper.findChild(go, "root/#go_info/top/right/price")
	self._txtprice = gohelper.findChildTextMesh(go, "root/#go_info/top/right/price/#txt_price")
	self._goheavy = gohelper.findChild(go, "root/#go_info/top/right/heavy")
	self._txtheavy = gohelper.findChildTextMesh(go, "root/#go_info/top/right/heavy/#txt_heavy")
	self._goequipTagItem = gohelper.findChild(go, "root/#go_info/top/right/tag/go_item")
	self._txtname = gohelper.findChildTextMesh(go, "root/#go_info/top/middle/#txt_name")
	self._txtnum = gohelper.findChildTextMesh(go, "root/#go_info/top/middle/#txt_num")
	self._gonpc = gohelper.findChild(go, "root/#go_info/top/middle/npc")
	self._imagenpc = gohelper.findChildSingleImage(go, "root/#go_info/top/middle/npc/#simage_chess")
	self._goitem = gohelper.findChild(go, "root/#go_info/top/middle/collection")
	self._imageitem = gohelper.findChildSingleImage(go, "root/#go_info/top/middle/collection/#simage_icon")
	self._imageitemrare = gohelper.findChildImage(go, "root/#go_info/top/middle/collection/#image_quailty2")
	self._effect6 = gohelper.findChild(go, "root/#go_info/top/middle/collection/#go_deceffect")
	self._effect6_2 = gohelper.findChild(go, "root/#go_deceffect")
	self._imageitemrare2 = gohelper.findChildImage(go, "root/#go_info/top/middle/npc/#image_quailty2")
	self._btnremove = gohelper.findChildButtonWithAudio(go, "root/#go_info/top/left/#btn_remove")
	self._btnleave = gohelper.findChildButtonWithAudio(go, "root/#go_info/top/left/#btn_leave")
	self._goTips = gohelper.findChild(go, "root/#go_info/top/left/go_tips")
	self._btncloseTips = gohelper.findChildClick(go, "root/#go_info/top/left/go_tips/#btn_close")
	self._btntipremove = gohelper.findChildButtonWithAudio(go, "root/#go_info/top/left/go_tips/#btn_remove")
	self._btntipleave = gohelper.findChildButtonWithAudio(go, "root/#go_info/top/left/go_tips/#btn_leave")
	self._txthave = gohelper.findChildTextMesh(go, "root/#go_info/top/left/go_tips/#txt_currency")
	self._txtremain = gohelper.findChildTextMesh(go, "root/#go_info/top/left/go_tips/#txt_after")
	self._gotipsnum = gohelper.findChild(go, "root/#go_info/top/left/go_tips/#go_num")
	self._inputtipnum = gohelper.findChildTextMeshInputField(go, "root/#go_info/top/left/go_tips/#go_num/valuebg/#input_value")
	self._btntipsaddnum = gohelper.findChildButtonWithAudio(go, "root/#go_info/top/left/go_tips/#go_num/#btn_add")
	self._btntipssubnum = gohelper.findChildButtonWithAudio(go, "root/#go_info/top/left/go_tips/#go_num/#btn_sub")
	self._btngoequip = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_goequip")
	self._btnuse = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_use")
	self._btnequip = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_equip")
	self._btnunequip = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_unequip")
	self._btnsearch = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_search")
	self._btnsell = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_sell")
	self._btnbuy = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_buy")
	self._btnplace = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_place")
	self._btnunplace = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_unplace")
	self._gonum = gohelper.findChild(go, "root/#go_info/bottom/#go_num")
	self._txtcount = gohelper.findChildTextMesh(go, "root/#go_info/bottom/#go_num/#txt_count")
	self._goicon1 = gohelper.findChild(go, "root/#go_info/bottom/#go_num/#txt_count/icon1")
	self._goicon2 = gohelper.findChild(go, "root/#go_info/bottom/#go_num/#txt_count/icon2")
	self._goinput = gohelper.findChild(go, "root/#go_info/bottom/#go_num/valuebg")
	self._inputnum = gohelper.findChildTextMeshInputField(go, "root/#go_info/bottom/#go_num/valuebg/#input_value")
	self._btnaddnum = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#go_num/#btn_add")
	self._btnsubnum = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#go_num/#btn_sub")
	self._btnmaxnum = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#go_num/#btn_max")
	self._btnminnum = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#go_num/#btn_min")
	self._btnselect = gohelper.findChildButtonWithAudio(go, "root/#go_info/bottom/#btn_select")
	self._go_rewardinherit = gohelper.findChild(go, "root/#go_info/bottom/#go_rewardinherit")
	self._btn_rewardinherit_select = gohelper.findChildButtonWithAudio(self._go_rewardinherit, "#btn_rewardinherit_select")
	self._btn_rewardinherit_unselect = gohelper.findChildButtonWithAudio(self._go_rewardinherit, "#btn_rewardinherit_unselect")
	self._goscore = gohelper.findChild(go, "root/#go_info/layout/#go_score")
	self._txtscore = gohelper.findChildTextMesh(go, "root/#go_info/layout/#go_score/image_NumBG/#txt_Num")
	self._imagescore = gohelper.findChildImage(go, "root/#go_info/layout/#go_score/image_NumBG/image_AssessIon")
	self._goattritem = gohelper.findChild(go, "root/#go_info/scroll_base/Viewport/Content/#go_attrs/#go_baseitem")
	self._goFrequency = gohelper.findChild(go, "root/#go_info/Frequency")
	self._imageFrequency = gohelper.findChildImage(go, "root/#go_info/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	self._txtFrequency = gohelper.findChildTextMesh(go, "root/#go_info/Frequency/image_NumBG/#txt_Num")
	self._txtFrequencyName = gohelper.findChildTextMesh(go, "root/#go_info/Frequency/txt_Frequency")
	self._goscroll = gohelper.findChild(go, "root/#go_info/scroll_base")
	self.itemSubType_npc = gohelper.findChild(go, "root/#go_info/layout/itemSubType_npc")
	self.recommend = gohelper.findChild(go, "root/#go_info/top/left/recommend")
	self._btnClose = gohelper.findChildButtonWithAudio(go, "root/#btn_close")

	gohelper.setActive(self._btnClose, false)

	self._showBtns = true

	local parent = go.transform.parent

	if parent then
		local parentScroll = parent.gameObject:GetComponentInParent(gohelper.Type_LimitedScrollRect)

		if parentScroll then
			local limitScroll = self._goscroll:GetComponent(gohelper.Type_LimitedScrollRect)

			limitScroll.parentGameObject = parentScroll.gameObject
		end
	end
end

function SurvivalBagInfoPart:addEventListeners()
	self._btnremove:AddClickListener(self._openTips, self)
	self._btnleave:AddClickListener(self._openTips, self)
	self._btncloseTips:AddClickListener(self._closeTips, self)
	self._btntipremove:AddClickListener(self._removeItem, self)
	self._btntipleave:AddClickListener(self._removeItem, self)
	self._inputtipnum:AddOnEndEdit(self._ontipnuminputChange, self)
	self._btntipsaddnum:AddClickListener(self._addtipnum, self, 1)
	self._btntipssubnum:AddClickListener(self._addtipnum, self, -1)
	self._btngoequip:AddClickListener(self._onGoEquipClick, self)
	self._btnuse:AddClickListener(self._onUseClick, self)
	self._btnequip:AddClickListener(self._onEquipClick, self)
	self._btnunequip:AddClickListener(self._onUnEquipClick, self)
	self._btnsearch:AddClickListener(self._onSearchClick, self)
	self._btnsell:AddClickListener(self._onSellClick, self)
	self._btnbuy:AddClickListener(self._onBuyClick, self)
	self._btnplace:AddClickListener(self._onPlaceClick, self)
	self._btnunplace:AddClickListener(self._onUnPlaceClick, self)
	self._inputnum:AddOnEndEdit(self._ontnuminputChange, self)
	self._btnaddnum:AddClickListener(self._onAddNumClick, self, 1)
	self._btnsubnum:AddClickListener(self._onAddNumClick, self, -1)
	self._btnmaxnum:AddClickListener(self._onMaxNumClick, self)
	self._btnminnum:AddClickListener(self._onMinNumClick, self)
	self._btnselect:AddClickListener(self._onSelectClick, self)
	self._btn_rewardinherit_select:AddClickListener(self._onRewardInheritSelectClick, self)
	self._btn_rewardinherit_unselect:AddClickListener(self._onRewardInheritUnSelectClick, self)
	self._btnClose:AddClickListener(self._onClickCloseTips, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipDescSimpleChange, self.updateCenterShow, self)
end

function SurvivalBagInfoPart:removeEventListeners()
	self._btnremove:RemoveClickListener()
	self._btnleave:RemoveClickListener()
	self._btncloseTips:RemoveClickListener()
	self._btntipremove:RemoveClickListener()
	self._btntipleave:RemoveClickListener()
	self._inputtipnum:RemoveOnEndEdit()
	self._btntipsaddnum:RemoveClickListener()
	self._btntipssubnum:RemoveClickListener()
	self._btngoequip:RemoveClickListener()
	self._btnuse:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnunequip:RemoveClickListener()
	self._btnsearch:RemoveClickListener()
	self._btnsell:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnplace:RemoveClickListener()
	self._btnunplace:RemoveClickListener()
	self._inputnum:RemoveOnEndEdit()
	self._btnaddnum:RemoveClickListener()
	self._btnsubnum:RemoveClickListener()
	self._btnmaxnum:RemoveClickListener()
	self._btnminnum:RemoveClickListener()
	self._btnselect:RemoveClickListener()
	self._btn_rewardinherit_select:RemoveClickListener()
	self._btn_rewardinherit_unselect:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipDescSimpleChange, self.updateCenterShow, self)
end

function SurvivalBagInfoPart:_onSelectClick()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickBagItem, self.mo)
end

function SurvivalBagInfoPart:_onRewardInheritSelectClick()
	if self._onClickSelectCallBack then
		self._onClickSelectCallBack(self._rewardInheritBtnContext, self)
	end
end

function SurvivalBagInfoPart:_onRewardInheritUnSelectClick()
	if self._onClickUnSelectCallBack then
		self._onClickUnSelectCallBack(self._rewardInheritBtnContext, self)
	end
end

function SurvivalBagInfoPart:_openTips()
	gohelper.setActive(self._goTips, true)
end

function SurvivalBagInfoPart:_closeTips()
	gohelper.setActive(self._goTips, false)
end

function SurvivalBagInfoPart:setIsShowEmpty(isShowEmpty)
	self._isShowEmpty = isShowEmpty
end

function SurvivalBagInfoPart:setCloseShow(isShow, clickCallback, clickCallobj)
	gohelper.setActive(self._btnClose, isShow)

	self._clickCloseCallback = clickCallback
	self._clickCloseCallobj = clickCallobj
end

function SurvivalBagInfoPart:_onClickCloseTips()
	self:updateMo()

	if self._clickCloseCallback then
		self._clickCloseCallback(self._clickCloseCallobj)
	end
end

function SurvivalBagInfoPart:setChangeSource(dict)
	self._changeSourceDict = dict
end

function SurvivalBagInfoPart:getItemSource()
	if self._changeSourceDict then
		if not self._changeSourceDict[self.mo.source] then
			return self.mo.source
		end
	end
end

function SurvivalBagInfoPart:setHideParent(parent)
	self.parent = parent
end

function SurvivalBagInfoPart:setShopData(shopId, shopType)
	self.shopId = shopId
	self.shopType = shopType
end

function SurvivalBagInfoPart:updateMo(mo, param)
	self.param = param or {}

	gohelper.setActive(self._goTips, false)

	if mo then
		::label_16_0::

		local var_16_0 = self.mo

		if self.mo then
			local isChange = mo ~= self.mo

			self.mo = mo

			if self._isShowEmpty then
				gohelper.setActive(self._goinfo, mo)
				gohelper.setActive(self._goempty, not mo)
			else
				gohelper.setActive(self.parent, mo)
			end

			if isChange and not self.param.jumpChangeAnim then
				self._anim:Play("switch", 0, 0)
				TaskDispatcher.runDelay(self._refreshAll, self, 0.167)
			else
				self:_refreshAll()
			end

			if self.mo then
				local isSp = true

				isSp = self.mo.co

				if self.mo.co then
					if self.mo.co.rare ~= 5 or SurvivalEnum.ItemSource.Drop ~= self.mo.source and SurvivalEnum.ItemSource.Search ~= self.mo.source then
						isSp = false

						goto label_16_1
					end

					gohelper.setActive(self._goquality5, self.mo and self.mo.co and self.mo.co.rare == 5)

					if isSp then
						self._anim:Play("opensp", 0, 0)
						AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_explore_senior)
					end

					if self.mo then
						local isSp1 = true

						isSp1 = self.mo.co

						if self.mo.co then
							if self.mo.co.rare ~= 6 or SurvivalEnum.ItemSource.Drop ~= self.mo.source and SurvivalEnum.ItemSource.Search ~= self.mo.source then
								isSp1 = false
							end

							if isSp1 then
								self._anim:Play("opensp1", 0, 0)
								AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_explore_senior)
							end

							local var_16_4 = self.shopType

							if self.shopType then
								var_16_4 = self.mo

								if self.mo then
									var_16_4 = self:isShelterShop()
									var_16_4 = var_16_4 and self.mo:isDisasterRecommendItem(self.param.mapId)
								end
							end

							gohelper.setActive(self.recommend, var_16_4)
						end
					end
				end
			end
		end
	end
end

function SurvivalBagInfoPart:isShelterShop()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	return not weekMo.inSurvival
end

function SurvivalBagInfoPart:isSurvivalShop()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	return weekMo.inSurvival
end

function SurvivalBagInfoPart:_refreshAll()
	if self.mo then
		self:updatePrice()
		self:updateHeavy()
		self:updateEquipTag()
		self:updateBaseInfo()
		gohelper.setActive(self.itemSubType_npc, self.mo and self.mo:isNPCRecommendItem())
	end
end

function SurvivalBagInfoPart:updatePrice()
	gohelper.setActive(self._goprice, not self.mo:isNPC() and not self.mo:isCurrency())

	self._txtprice.text = self:getItemSource() == SurvivalEnum.ItemSource.ShopItem and self.mo.getBuyPrice and self.mo:getBuyPrice() or self:getItemSource() == SurvivalEnum.ItemSource.ShopBag and self.mo:getSellPrice(self.shopId) or self.mo.co.worth
end

function SurvivalBagInfoPart:updateHeavy()
	local mass = self.mo.co.mass

	gohelper.setActive(self._goheavy, mass > 0 and not self.mo:isCurrency())

	self._txtheavy.text = mass
end

function SurvivalBagInfoPart:updateEquipTag()
	local tags = {}

	if self.mo.equipCo then
		if self.mo.equipCo.equipType == 0 then
			local tagIds = string.splitToNumber(self.mo.equipCo.tag, "#") or {}

			for i, v in ipairs(tagIds) do
				local tagCo = lua_survival_equip_found.configDict[v]

				if tagCo then
					table.insert(tags, {
						icon = tagCo.icon4,
						desc = tagCo.name
					})
				end
			end
		else
			tags = {
				{
					icon = "100",
					desc = luaLang("survival_spequip_tag")
				}
			}
		end
	end

	gohelper.CreateObjList(self, self._createEquipTag, tags, nil, self._goequipTagItem)
end

function SurvivalBagInfoPart:_createEquipTag(obj, data, index)
	local btn = gohelper.findChildButtonWithAudio(obj, "")
	local image = gohelper.findChildImage(obj, "#image_tag")

	UISpriteSetMgr.instance:setSurvivalSprite(image, data.icon)
	self:removeClickCb(btn)

	if data.desc then
		self.addClickCb(self, btn, self._onClickTag, self, {
			desc = data.desc,
			btn = btn
		})
	end
end

function SurvivalBagInfoPart:_onClickTag(param)
	local trans = param.btn.transform
	local scale = trans.lossyScale
	local pos = trans.position
	local width = recthelper.getWidth(trans)
	local height = recthelper.getHeight(trans)

	pos.x = pos.x - width / 2 * scale.x
	pos.y = pos.y + height / 2 * scale.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BL",
		txt = param.desc,
		pos = pos
	})
end

function SurvivalBagInfoPart:updateBaseInfo()
	local mulStr = luaLang("multiple")

	self._txtname.text = self.mo.co.name
	self._txtnum.text = self.mo.count > 1 and mulStr .. self.mo.count or ""

	local itemSource = self:getItemSource()
	local canRemove = itemSource == SurvivalEnum.ItemSource.Search or self.mo.co.disposable == 0 and not self.mo:isCurrency() and (itemSource == SurvivalEnum.ItemSource.Map or itemSource == SurvivalEnum.ItemSource.Shelter)

	gohelper.setActive(self._btnleave, canRemove and self.mo.npcCo)
	gohelper.setActive(self._btntipleave, self.mo.npcCo)

	self.isShowBtnRemove = canRemove and not self.mo.npcCo

	gohelper.setActive(self._btnremove, self.isShowBtnRemove)
	gohelper.setActive(self._btntipremove, not self.mo.npcCo)
	gohelper.setActive(self._gonpc, self.mo.npcCo)
	gohelper.setActive(self._goitem, not self.mo.npcCo)

	if self.mo.npcCo then
		SurvivalUnitIconHelper.instance:setNpcIcon(self._imagenpc, self.mo.npcCo.headIcon)
		UISpriteSetMgr.instance:setSurvivalSprite(self._imageitemrare2, "survival_bag_itemquality2_" .. self.mo.npcCo.rare, false)
		gohelper.setActive(self._effect6, false)
		gohelper.setActive(self._effect6_2, false)
	else
		UISpriteSetMgr.instance:setSurvivalSprite(self._imageitemrare, "survival_bag_itemquality2_" .. self.mo.co.rare, false)
		self._imageitem:LoadImage(ResUrl.getSurvivalItemIcon(self.mo.co.icon))
		gohelper.setActive(self._effect6, self.mo.co.rare == 6)
		gohelper.setActive(self._effect6_2, self.mo.co.rare == 6)
	end

	self:updateTipCountShow()
	self:updateBtnsShow()
	self:updateCenterShow()
end

function SurvivalBagInfoPart:updateTipCountShow()
	self._inputtipnum:SetText(self.mo.count)

	if self.mo.count <= 1 then
		gohelper.setActive(self._gotipsnum, false)
		gohelper.setActive(self._txthave, false)
		gohelper.setActive(self._txtremain, false)
	else
		gohelper.setActive(self._gotipsnum, true)

		if self:getItemSource() ~= SurvivalEnum.ItemSource.Search then
			gohelper.setActive(self._txthave, true)
			gohelper.setActive(self._txtremain, true)
			self:updateTipCount()
		else
			gohelper.setActive(self._txthave, false)
			gohelper.setActive(self._txtremain, false)
		end
	end
end

function SurvivalBagInfoPart:setShowBtns(isShow)
	self._showBtns = isShow
end

local ScrollHeight = {
	490,
	346,
	313,
	284.9,
	317.9
}

function SurvivalBagInfoPart:updateBtnsShow()
	local style = 1

	self._inputnum:SetText(self.mo.count)
	gohelper.setActive(self._btngoequip, false)
	gohelper.setActive(self._btnuse, false)
	gohelper.setActive(self._btnequip, false)
	gohelper.setActive(self._btnunequip, false)
	gohelper.setActive(self._btnsearch, false)
	gohelper.setActive(self._btnsell, false)
	gohelper.setActive(self._btnbuy, false)
	gohelper.setActive(self._btnplace, false)
	gohelper.setActive(self._btnunplace, false)
	gohelper.setActive(self._gonum, false)
	gohelper.setActive(self._txtcount, false)
	gohelper.setActive(self._goicon1, false)
	gohelper.setActive(self._goicon2, false)
	gohelper.setActive(self._btnselect, false)

	if self._showBtns then
		if self:getItemSource() == SurvivalEnum.ItemSource.Search then
			gohelper.setActive(self._btnsearch, true)
			gohelper.setActive(self._gonum, self.mo.count > 1)

			style = self.mo.count > 1 and 3 or 2
		end

		if self:getItemSource() == SurvivalEnum.ItemSource.Map then
			local sceneMo = SurvivalMapModel.instance:getSceneMo()

			if not sceneMo.panel then
				if self.mo.equipCo then
					style = 2

					gohelper.setActive(self._btngoequip, true)
				elseif self.mo.co.type == SurvivalEnum.ItemType.Quick then
					style = 2

					gohelper.setActive(self._btnuse, true)
				end
			end
		end

		if self:getItemSource() == SurvivalEnum.ItemSource.Equip then
			style = 2

			gohelper.setActive(self._btnunequip, true)
		end

		if self:getItemSource() == SurvivalEnum.ItemSource.EquipBag then
			style = 2

			gohelper.setActive(self._btnequip, true)
		end

		if self:getItemSource() == SurvivalEnum.ItemSource.Commit then
			gohelper.setActive(self._txtcount, true)
			gohelper.setActive(self._goicon1, true)
			gohelper.setActive(self._gonum, self.mo.count > 1)
			gohelper.setActive(self._btnplace, true)

			style = self.mo.count > 1 and 4 or 5

			self._inputnum:SetText("1")
		end

		if self:getItemSource() == SurvivalEnum.ItemSource.Commited then
			gohelper.setActive(self._txtcount, true)
			gohelper.setActive(self._goicon1, true)
			gohelper.setActive(self._gonum, self.mo.count > 1)
			gohelper.setActive(self._btnunplace, true)

			style = self.mo.count > 1 and 4 or 5
		end

		if self:getItemSource() == SurvivalEnum.ItemSource.Composite then
			style = 2

			gohelper.setActive(self._btnselect, true)
		end

		if self:getItemSource() == SurvivalEnum.ItemSource.ShopBag and self.mo.sellPrice > 0 then
			style = 4

			gohelper.setActive(self._txtcount, true)
			gohelper.setActive(self._goicon2, true)
			gohelper.setActive(self._gonum, true)
			gohelper.setActive(self._btnsell, true)
		end

		if self:getItemSource() == SurvivalEnum.ItemSource.ShopItem and not self.param.hideBuy then
			style = 4

			gohelper.setActive(self._txtcount, true)
			gohelper.setActive(self._goicon2, true)
			gohelper.setActive(self._gonum, true)
			gohelper.setActive(self._btnbuy, true)
			self._inputnum:SetText("1")
		end
	end

	recthelper.setHeight(self._goscroll.transform, ScrollHeight[style])
	self:onInputValueChange()
end

function SurvivalBagInfoPart:updateCenterShow()
	if not self.mo then
		return
	end

	gohelper.setActive(self._goscore, self.mo.co.type == SurvivalEnum.ItemType.Equip)

	local datas = {}

	gohelper.setActive(self._goFrequency, false)

	if self.mo.equipCo then
		local level, color = self.mo:getEquipScoreLevel()

		UISpriteSetMgr.instance:setSurvivalSprite(self._imagescore, "survivalequip_scoreicon_" .. level)

		self._txtscore.text = string.format("<color=%s>%s</color>", color, self.mo.equipCo.score + self.mo.exScore)

		if self.mo.slotMo then
			local equipBox = self.mo.slotMo.parent
			local maxTagId = equipBox.maxTagId
			local tagCo = lua_survival_equip_found.configDict[maxTagId]

			if tagCo then
				gohelper.setActive(self._goFrequency, true)
				UISpriteSetMgr.instance:setSurvivalSprite(self._imageFrequency, tagCo.value)

				if self.mo.equipValues then
					self._txtFrequency.text = self.mo.equipValues[tagCo.value] or 0
				end

				local co = lua_survival_attr.configDict[tagCo.value]

				if co then
					self._txtFrequencyName.text = co.name or ""
				end
			end
		end

		local allEntryDatas = self.mo:getEquipEffectDesc()

		datas[1] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_effect"),
			list2 = allEntryDatas
		}
		datas[2] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_info"),
			list = {
				self.mo.equipCo.desc
			}
		}
	elseif self.mo.npcCo then
		local _, tags = SurvivalConfig.instance:getNpcConfigTag(self.mo.npcCo.id)

		if tags then
			for _, tagId in ipairs(tags) do
				local tagCo = lua_survival_tag.configDict[tagId]

				table.insert(datas, {
					icon = "survival_bag_title0" .. tagCo.color,
					desc = tagCo.name,
					list = {
						tagCo.desc
					}
				})
			end
		end
	else
		datas[1] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_effect"),
			list = {
				self.mo.co.desc1
			}
		}
		datas[2] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_info"),
			list = {
				self.mo.co.desc2
			}
		}
	end

	gohelper.CreateObjList(self, self._createDescItems, datas, nil, self._goattritem)
end

function SurvivalBagInfoPart:_createDescItems(obj, data, index)
	local imageTitle = gohelper.findChildImage(obj, "#image_title")
	local txtTitle = gohelper.findChildTextMesh(obj, "#image_title/#txt_title")
	local btnSwitch = gohelper.findChildButtonWithAudio(obj, "#image_title/#txt_title/#btn_switch")
	local item = gohelper.findChild(obj, "layout/#go_decitem")
	local item2 = gohelper.findChild(obj, "layout/#go_decitem2")
	local txt = gohelper.findChild(obj, "layout/#go_decitem/#txt_desc")
	local txt2 = gohelper.findChild(obj, "layout/#go_decitem2/#txt_desc")

	UISpriteSetMgr.instance:setSurvivalSprite(imageTitle, data.icon)

	txtTitle.text = data.desc

	gohelper.setActive(item, data.list)
	gohelper.setActive(item2, data.list2)
	gohelper.setActive(btnSwitch, data.list2)
	self.addClickCb(self, btnSwitch, self._onClickSwitch, self)

	if data.list then
		gohelper.CreateObjList(self, self._createSubDescItems, data.list, nil, txt)
	end

	if data.list2 then
		gohelper.CreateObjList(self, self._createSubDescItems2, data.list2, nil, txt2)
	end
end

function SurvivalBagInfoPart:_onClickSwitch()
	SurvivalModel.instance:changeDescSimple()
end

function SurvivalBagInfoPart:_createSubDescItems(obj, data, index)
	local txtDesc = gohelper.findChildTextMesh(obj, "")

	txtDesc.text = data
end

function SurvivalBagInfoPart:_onSubDescHyperLinkClick(data, clickPosition)
	return
end

function SurvivalBagInfoPart:_createSubDescItems2(obj, data, index)
	local click = gohelper.getClick(obj)
	local txtDesc = gohelper.findChildTextMesh(obj, "")
	local point = gohelper.findChildImage(obj, "point")
	local descComp = MonoHelper.addNoUpdateLuaComOnceToGo(txtDesc.gameObject, SurvivalSkillDescComp)

	descComp:updateInfo(txtDesc, data[1], 3028)
	self.addClickCb(self, click, self._onClickDesc, self)

	local isActive = data[2]

	if self:getItemSource() == SurvivalEnum.ItemSource.EquipBag then
		isActive = false
	elseif self:getItemSource() ~= SurvivalEnum.ItemSource.Equip then
		isActive = true
	end

	ZProj.UGUIHelper.SetColorAlpha(txtDesc, isActive and 1 or 0.5)

	point.color = isActive and GameUtil.parseColor("#000000") or GameUtil.parseColor("#808080")
end

function SurvivalBagInfoPart:setClickDescCallback(clickDescCallback, clickDescCallobj, clickDescParam)
	self._clickDescCallback, self._clickDescCallobj, self._clickDescParam = clickDescCallback, clickDescCallobj, clickDescParam
end

function SurvivalBagInfoPart:_onClickDesc()
	if self._clickDescCallback then
		self._clickDescCallback(self._clickDescCallobj, self._clickDescParam)
	end
end

function SurvivalBagInfoPart:_removeItem()
	local count = tonumber(self._inputtipnum:GetText()) or 0

	count = Mathf.Clamp(count, 1, self.mo.count)

	if self:getItemSource() == SurvivalEnum.ItemSource.Search then
		SurvivalMapModel.instance.isSearchRemove = true

		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "2#" .. self.mo.uid .. "#" .. count)
	else
		SurvivalWeekRpc.instance:sendSurvivalRemoveBagItem(self.mo.source, self.mo.uid, count)
	end

	gohelper.setActive(self._goTips, false)
end

function SurvivalBagInfoPart:_ontipnuminputChange()
	local count = tonumber(self._inputtipnum:GetText()) or 0

	count = Mathf.Clamp(count, 1, self.mo.count)

	if tostring(count) ~= self._inputtipnum:GetText() then
		self._inputtipnum:SetText(tostring(count))
		self:updateTipCount()
	end
end

function SurvivalBagInfoPart:_addtipnum(value)
	local count = tonumber(self._inputtipnum:GetText()) or 0

	count = count + value
	count = Mathf.Clamp(count, 1, self.mo.count)

	self._inputtipnum:SetText(tostring(count))
	self:updateTipCount()
end

function SurvivalBagInfoPart:updateTipCount()
	if self:getItemSource() == SurvivalEnum.ItemSource.Search then
		return
	end

	local count = tonumber(self._inputtipnum:GetText()) or 0

	self._txthave.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_have"), self.mo.count)
	self._txtremain.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_remain"), self.mo.count - count)
end

function SurvivalBagInfoPart:_onEquipClick()
	if not self.mo.equipCo then
		return
	end

	local equipBox = SurvivalShelterModel.instance:getWeekInfo().equipBox

	if self.mo.equipCo.equipType == 0 then
		local slots = equipBox.slots

		for i, v in ipairs(slots) do
			if v.unlock and v.item:isEmpty() then
				SurvivalWeekRpc.instance:sendSurvivalEquipWear(i, self.mo.uid)

				return
			end
		end
	else
		local slots = equipBox.jewelrySlots

		for i, v in ipairs(slots) do
			if v.unlock and v.item:isEmpty() then
				SurvivalWeekRpc.instance:sendSurvivalJewelryEquipWear(i, self.mo.uid)

				return
			end
		end
	end

	GameFacade.showToast(ToastEnum.SurvivalCantEquip)
end

function SurvivalBagInfoPart:_onUnEquipClick()
	if not self.mo.equipCo then
		return
	end

	if self.mo.equipCo.equipType == 0 then
		SurvivalWeekRpc.instance:sendSurvivalEquipDemount(self.mo.index or 1)
	else
		SurvivalWeekRpc.instance:sendSurvivalJewelryEquipDemount(self.mo.index or 1)
	end
end

function SurvivalBagInfoPart:_onSearchClick()
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "1#" .. self.mo.uid .. "#" .. self._inputnum:GetText())
end

function SurvivalBagInfoPart:_onSellClick()
	SurvivalWeekRpc.instance:sendSurvivalShopSellRequest(self.mo.uid, self.shopType, self.shopId, tonumber(self._inputnum:GetText()))
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "SellItem", self.mo)
end

function SurvivalBagInfoPart:_onBuyClick()
	if not self._canBuy then
		GameFacade.showToast(ToastEnum.SurvivalNoMoney)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalShopBuyRequest(self.mo.uid, tonumber(self._inputnum:GetText()), self.shopType, self.shopId)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "BuyItem", self.mo)
end

function SurvivalBagInfoPart:_onGoEquipClick()
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

function SurvivalBagInfoPart:_onUseClick()
	if SurvivalMapHelper.instance:isInFlow() then
		GameFacade.showToast(ToastEnum.SurvivalCantUseItem)

		return
	end

	if SurvivalEnum.CustomUseItemSubType[self.mo.co.subType] then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUseQuickItem, self.mo)
		ViewMgr.instance:closeAllPopupViews()
	elseif self.mo.co.subType == SurvivalEnum.ItemSubType.Quick_Exit then
		self._exitItemMo = self.mo

		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalItemAbort, MsgBoxEnum.BoxType.Yes_No, self._sendUseItem, nil, nil, self, nil, nil)
	else
		SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(self.mo.uid, "")
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "Use", self.mo)
end

function SurvivalBagInfoPart:_sendUseItem()
	SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(self._exitItemMo.uid, "")
end

function SurvivalBagInfoPart:_onPlaceClick()
	local count = tonumber(self._inputnum:GetText()) or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "Place", self.mo, count)
end

function SurvivalBagInfoPart:_onUnPlaceClick()
	local count = tonumber(self._inputnum:GetText()) or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "UnPlace", self.mo, count)
end

function SurvivalBagInfoPart:_ontnuminputChange()
	local count = tonumber(self._inputnum:GetText()) or 0

	count = Mathf.Clamp(count, 1, self.mo.count)

	if tostring(count) ~= self._inputnum:GetText() then
		self._inputnum:SetText(tostring(count))
	end

	self:onInputValueChange()
end

function SurvivalBagInfoPart:_onAddNumClick(value)
	local count = tonumber(self._inputnum:GetText()) or 0

	count = count + value
	count = Mathf.Clamp(count, 1, self.mo.count)

	self._inputnum:SetText(tostring(count))
	self:onInputValueChange()
end

function SurvivalBagInfoPart:onInputValueChange()
	local count = tonumber(self._inputnum:GetText()) or 0
	local itemSource = self:getItemSource()

	if itemSource == SurvivalEnum.ItemSource.Commit or itemSource == SurvivalEnum.ItemSource.Commited then
		local weekMo = SurvivalShelterModel.instance:getWeekInfo()
		local worth = weekMo:getAttr(SurvivalEnum.AttrType.NpcRecruitment, self.mo.co.worth)

		self._txtcount.text = count * worth
	end

	if itemSource == SurvivalEnum.ItemSource.ShopBag then
		self._txtcount.text = count * self.mo:getSellPrice(self.shopId)
	end

	if itemSource == SurvivalEnum.ItemSource.ShopItem then
		local bag = SurvivalMapHelper.instance:getBagMo()
		local haveCount = bag:getCurrencyNum(SurvivalEnum.CurrencyType.Gold)
		local needVal = count * self.mo:getBuyPrice()

		self._canBuy = needVal <= haveCount
		self._txtcount.text = needVal <= haveCount and string.format("%d/%d", haveCount, needVal) or string.format("<color=#ec4747>%d</color>/%d", haveCount, needVal)
	end
end

function SurvivalBagInfoPart:_onMaxNumClick()
	local max = self.mo.count

	if self:getItemSource() == SurvivalEnum.ItemSource.ShopItem then
		local bag = SurvivalMapHelper.instance:getBagMo()
		local haveCount = bag:getCurrencyNum(SurvivalEnum.CurrencyType.Gold)
		local canBuy = math.floor(haveCount / self.mo:getBuyPrice())

		if canBuy <= 0 then
			canBuy = 1
		end

		max = Mathf.Clamp(max, 1, canBuy)
	end

	self._inputnum:SetText(max)
	self:onInputValueChange()
end

function SurvivalBagInfoPart:_onMinNumClick()
	self._inputnum:SetText(1)
	self:onInputValueChange()
end

function SurvivalBagInfoPart:showRewardInheritBtn(context, isSelect, onClickSelectCallBack, onClickUnSelectCallBack)
	gohelper.setActive(self._go_rewardinherit, true)
	gohelper.setActive(self._btn_rewardinherit_select, isSelect)
	gohelper.setActive(self._btn_rewardinherit_unselect, not isSelect)

	self._rewardInheritBtnContext = context
	self._onClickSelectCallBack = onClickSelectCallBack
	self._onClickUnSelectCallBack = onClickUnSelectCallBack

	recthelper.setHeight(self._goscroll.transform, ScrollHeight[2])
end

function SurvivalBagInfoPart:playAnim(name)
	self._anim:Play(name, 0, 0)
end

function SurvivalBagInfoPart:onDestroy()
	TaskDispatcher.cancelTask(self._refreshAll, self)
end

return SurvivalBagInfoPart
