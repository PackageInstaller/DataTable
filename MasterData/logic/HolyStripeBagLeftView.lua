-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeBagLeftView.lua

module("logic.extensions.holystripe.view.HolyStripeBagLeftView", package.seeall)

local HolyStripeBagLeftView = class("HolyStripeBagLeftView", HolyStripeMainView)

function HolyStripeBagLeftView:buildUI()
	HolyStripeBagLeftView.super.buildUI(self)

	self._oneKeyTakeOffBtn = self:getBtn("oneKeyTakeoffBtn")
	self._oneKeyTakeOnBtn = self:getBtn("oneKeyTakeOnBtn")
	self._changeBtn = self:getBtn("rightRoot/suitPreviewBtn")
	self._headIcon = self:getGo("head/con")
	self._btnHeadIcon = GameUtil.asBtn(self._headIcon)
	self._petName = self:getTxt("head/txtName")
	self._patBag = self:getGo("petBag")
	self._closeBtn = self:getBtn("closeBtn")
	self._btnRule = self:getBtn("btnRule")
	self._suitPreviewBtn = self:getBtn("programBtn")
	self._btn_left = self:getGo("rightRoot/btn_left")
	self._btn_right = self:getGo("rightRoot/btn_right")
	self._backEffectGo = self:getGo("rightRoot/bgEffect")
	self._lineEffectGo = self:getGo("lineEffect")
	self._mask = self:getGo("mask")
	self._btnMask = GameUtil.asBtn(self._mask)
	self._bagTableview = self:getGo("petBag/itemScr")
	self._bagTablecell = self:getGo("petBag/itemcell")
	self._bagPetList = ScrollerList.create(self._bagTableview, self._bagTablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function HolyStripeBagLeftView:bindEvents()
	HolyStripeBagLeftView.super.bindEvents(self)
	GameUtil.addClickHandler(self._oneKeyTakeOffBtn, self._onOneKeyTakeOffBtnClick, self)
	self._closeBtn:AddClickListener(self._onCloseBtnClick, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	GameUtil.addClickHandler(self._btn_left, self._onBtnLeftClick, self)
	GameUtil.addClickHandler(self._btn_right, self._onBtnRightClick, self)
	GameUtil.addClickHandler(self._btnHeadIcon, self._onClickPetIcon, self)
	GameUtil.addClickHandler(self._btnMask, self._onClickMask, self)
end

function HolyStripeBagLeftView:unbindEvents()
	HolyStripeBagLeftView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._oneKeyTakeOffBtn)
	self._changeBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	GameUtil.rmClickHandler(self._btn_left)
	GameUtil.rmClickHandler(self._btn_right)
	GameUtil.rmClickHandler(self._btnHeadIcon)
	GameUtil.rmClickHandler(self._btnMask)
end

function HolyStripeBagLeftView:onEnter()
	HolyStripeBagLeftView.super.onEnter(self)
	GlobalDispatcher:addListener(HolyStripeController.Bag_Item_Tips_Show, self._showTips, self)
	GlobalDispatcher:addListener(HolyStripeController.On_Select_FilterPos, self._onPosFilterChange, self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeEquipRes, self._showEquipSuitEffect, self)

	local params = self:getOpenParam()

	self._posFilterId = nil

	if params and #params >= 2 then
		self._posFilterId = params[2]
	end

	self._gRootRt = GlobalModel.instance.uiRoot:GetComponent(goutil.Type_RectTransform)
	self._shineEffect = {}

	GameUtil.SetActive(self._mask, false)
	GameUtil.SetActive(self._patBag, false)
end

function HolyStripeBagLeftView:onExit()
	HolyStripeBagLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(HolyStripeController.Bag_Item_Tips_Show, self._showTips, self)
	GlobalDispatcher:removeListener(HolyStripeController.On_Select_FilterPos, self._onPosFilterChange, self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeEquipRes, self._showEquipSuitEffect, self)

	for i, v in ipairs(self._shineEffect) do
		UIEffectManager.instance:stopEffect(v)
	end

	UIEffectManager.instance:stopEffect(self._lineEffect)
	MaterialMgr.clearIcon(self._headIcon)
	MaterialMgr.resetAll(self._headIcon)

	self.curPetIndex = nil
end

function HolyStripeBagLeftView:_onItemBtnClick(posType, equip, id)
	if equip and id then
		GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterPos, posType)
		UIStateManager.instance:push(ViewName.HolyStripeTipsView, id)
	else
		GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterPos, posType)
	end
end

function HolyStripeBagLeftView:_onChangeBtnClick()
	return
end

function HolyStripeBagLeftView:_showTips(itemId)
	local itemMo = HolyStripeModel.instance:getHolyStripeMo(itemId)

	for i, v in ipairs(self._equipList) do
		if v:getId() == itemMo:getId() then
			for i, v in ipairs(self._shineEffect) do
				UIEffectManager.instance:stopEffect(v)
			end

			UIEffectManager.instance:stopEffect(self._lineEffect)
			UIStateManager.instance:push(ViewName.HolyStripeTipsView, itemId)

			return
		end

		if v:getPosType() == itemMo:getPosType() then
			for i, v in ipairs(self._shineEffect) do
				UIEffectManager.instance:stopEffect(v)
			end

			UIEffectManager.instance:stopEffect(self._lineEffect)
			UIStateManager.instance:push(ViewName.HolyStripeCompareTipsView, v:getId(), itemMo:getId())

			return
		end
	end

	UIStateManager.instance:push(ViewName.HolyStripeTipsView, itemId)
end

function HolyStripeBagLeftView:_setEquipItems()
	HolyStripeBagLeftView.super._setEquipItems(self)

	for i, v in ipairs(self._equipItems) do
		if v and v.select then
			if i == self._posFilterId then
				goutil.setActive(v.select, true)
			else
				goutil.setActive(v.select, false)
			end
		end
	end
end

function HolyStripeBagLeftView:_onCloseBtnClick()
	self:close()
end

function HolyStripeBagLeftView:_onClickSmeltBtnClick()
	UIStateManager.instance:push(ViewName.HolyStripeSmeltView)
	self:close()
end

function HolyStripeBagLeftView:_onPosFilterChange(posFilterId)
	self._posFilterId = posFilterId

	self:_updataView()
end

function HolyStripeBagLeftView:_updataView()
	HolyStripeBagLeftView.super._updataView(self)

	self.curPetIndex = BagPetsController.instance:getPetIndex()

	local state = BagPetsController.instance:checkState(self.curPetIndex)

	GameUtil.SetActive(self._btn_left, state ~= BagPetsController.NO_LEFT and state ~= BagPetsController.NO_LEFT_AND_RIGHT)
	GameUtil.SetActive(self._btn_right, state ~= BagPetsController.NO_RIGHT and state ~= BagPetsController.NO_LEFT_AND_RIGHT)

	local raceId = HolyStripeModel.instance:getCurShowFaceId()

	MaterialMgr.setIcon(self._headIcon, MatType.Pet, raceId)

	self._petName.text = BagPetsController.instance:GetCurPetMo().name

	self._bagPetList:reloadData(BagModel.instance:getCurPetViewList())
end

function HolyStripeBagLeftView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local proxy = MaterialMgr.setCellByMo(data, go)

	if proxy then
		proxy.binder:setNumStr("")
		proxy.binder:setAutoTips(false)

		if data:getId() == HolyStripeModel.instance:getCurrShowPetId() then
			proxy.binder:setSelected(true)
		else
			proxy.binder:setSelected(false)
		end

		proxy.binder:setCallBack(function()
			self:_onCLickBagPet(data:getId())
		end)
	end
end

function HolyStripeBagLeftView._clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function HolyStripeBagLeftView:_showEquipSuitEffect()
	local suitList = HolyStripeModel.instance:getCurSuitList()
	local shinePath = "20220701/zhihuijitan/fx_ui_wxwl_lwth_shangguang.prefab"
	local linePath = "20220701/zhihuijitan/fx_ui_wxwl_lwth_ljguangtiao.prefab"

	for i, v in ipairs(suitList) do
		if v.num >= 4 then
			for j, k in ipairs(self._equipItems) do
				if self._posDataList[j] and self._posDataList[j]:getSuitType() == v.suitType then
					if self._shineEffect[j] then
						UIEffectManager.instance:stopEffect(self._shineEffect[j])

						self._shineEffect[j] = nil
					end

					self._shineEffect[j] = UIEffectManager.instance:playEffect(self, shinePath, nil, 0, 0, false, nil, nil, function()
						self._shineEffect[j]:setClipping(self._gRootRt)
					end)

					self._shineEffect[j]:setParent(k.effect.transform)
					self._shineEffect[j]:setLocalPos(0, 0, 0)
					self._shineEffect[j]:setScale(1)
				end
			end

			if self._lineEffect then
				UIEffectManager.instance:stopEffect(self._lineEffect)

				self._lineEffect = nil
			end

			self._lineEffect = UIEffectManager.instance:playEffect(self, linePath, nil, 0, 0, false, nil, nil, function()
				self._lineEffect:setClipping(self._gRootRt)
			end)

			self._lineEffect:setParent(self._lineEffectGo.transform)
			self._lineEffect:setLocalPos(0, 0, 0)
			self._lineEffect:setScale(1.1)

			return
		end
	end
end

function HolyStripeBagLeftView:_onCLickBagPet(petId)
	BagPetsController.instance:SetCurPetId(petId)
	GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect)
end

function HolyStripeBagLeftView:_onBtnLeftClick()
	BagPetsController.instance:goNextPet(false)
end

function HolyStripeBagLeftView:_onBtnRightClick()
	BagPetsController.instance:goNextPet(true)
end

function HolyStripeBagLeftView:_onClickPetIcon()
	GameUtil.SetActive(self._mask, true)
	GameUtil.SetActive(self._patBag, true)
end

function HolyStripeBagLeftView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "holystripe_rule")
end

function HolyStripeBagLeftView:_onClickMask()
	GameUtil.SetActive(self._mask, false)
	GameUtil.SetActive(self._patBag, false)
end

return HolyStripeBagLeftView
