-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeCuilingView.lua

module("logic.extensions.holystripe.view.HolyStripeCuilingView", package.seeall)

local HolyStripeCuilingView = class("HolyStripeCuilingView", HolyStripeStrengthBaseView)

function HolyStripeCuilingView:ctor()
	HolyStripeCuilingView.super.ctor(self)
end

function HolyStripeCuilingView:unbindEvents()
	HolyStripeCuilingView.super.unbindEvents(self)
	self._btnCost:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function HolyStripeCuilingView:bindEvents()
	HolyStripeCuilingView.super.bindEvents(self)
	self._btnCost:AddClickListener(self._onClickbtnCost, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function HolyStripeCuilingView:buildUI()
	HolyStripeCuilingView.super.buildUI(self)

	self._tableviewGo = self:getGo("cuiling/leftInfo/tableview")
	self._tablecellGo = self:getGo("cuiling/leftInfo/tablecell")
	self._attrScrollList = ItemGroup.New(self._tableviewGo, self._tablecellGo, nil, nil, true)
	self._btnCost = self:getBtn("cuiling/leftInfo/cost/btnCost")
	self._btnCostTxt = self:getTxt("cuiling/leftInfo/cost/btnCost/txtCost")
	self._btnSure = self:getBtn("cuiling/leftInfo/btnSure")
	self._btnCancel = self:getBtn("cuiling/leftInfo/btnCancel")
	self._itemGo = self:getGo("cuiling/leftInfo/cost/item")
	self._itemconGo = self:getGo("cuiling/leftInfo/cost/itemcon")
	self._costMatItems = ItemGroup.New(self._itemconGo, self._itemGo, nil, nil, true)
	self._gRootRt = GlobalModel.instance.uiRoot:GetComponent(goutil.Type_RectTransform)
	self._emptyTxt = self:getTxt("empty/txtEmpty")
	self._goldbarConGo = self:getGo("goldbarCon")
end

function HolyStripeCuilingView:onExit()
	HolyStripeCuilingView.super.onExit(self)
	self._costMatItems:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeQuenchingRes, self._PM_HolyStripeQuenchingRes, self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeReplaceQuenchingDataRes, self._sureCuilingResult, self)
	GlobalDispatcher:removeListener(HolyStripeController.ForceUpdateCuiling, self._onForceUpdateCuiling, self)

	if self._replaceEffHandler then
		UIEffectManager.instance:stopEffect(self._replaceEffHandler)

		self._replaceEffHandler = nil
	end
end

function HolyStripeCuilingView:onEnter()
	self._totalAddExp = 0

	HolyStripeCuilingView.super.onEnter(self)
	GlobalDispatcher:addListener(HolyStripeController.ForceUpdateCuiling, self._onForceUpdateCuiling, self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeQuenchingRes, self._PM_HolyStripeQuenchingRes, self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeReplaceQuenchingDataRes, self._sureCuilingResult, self)
	self:_setTitleName("灵纹淬灵")

	self._smeltRefundExpRate = HolyStripeConfig.instance:getSmeltRefundExpRate()
	self._selectQuenchingId = nil
	self._isWaitReplace = false
	self._isReplace = false
	self._quenchingReplaceDatas = {}
	self._isSetGold = false

	self:_setBtnState()

	if self._emptyTxt then
		self._emptyTxt.text = lang("当前无可淬灵的灵纹")
	end
end

function HolyStripeCuilingView:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "cuiling/scrollView"
	}
end

function HolyStripeCuilingView:refreshView()
	local list = HolyStripeModel.instance:getAllHolyStripeMo(self._holyStripId)

	self:_refreshBag(list)
	self:_refreshFilter()
	goutil.setActive(self._emptyGo, not self._curViewDatas or #self._curViewDatas <= 0)
end

function HolyStripeCuilingView:_dataPretreatment(moList)
	local newList = {}

	for i, mo in ipairs(moList) do
		table.insert(newList, {
			totalNum = 1,
			selectNum = 0,
			mo = mo
		})
	end

	self._oriViewDatas = newList

	return newList
end

function HolyStripeCuilingView:_updataCell(view, cell, data, tag)
	local mo = data.mo
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "item")
	local btnReduce = Framework.ButtonAdapter.Get(goutil.findChild(go, "btnReduce"))

	MaterialMgr.resetAll(itemCon)

	local proxy

	if mo.isMat then
		proxy = MaterialMgr.setCellByCfg(mo.cfgStr, itemCon)
	else
		proxy = MaterialMgr.setCellByMo(mo, itemCon)

		proxy.binder:setNumStr("")
		proxy.binder:setAutoTips(false)
	end

	proxy.binder:setCallBack(function()
		UIStateManager.instance:push(ViewName.HolyStripeTipsView, mo:getId(), true)
	end)

	local isSelect = data.selectNum > 0

	goutil.setActive(btnReduce.gameObject, isSelect)
end

function HolyStripeCuilingView:_clearCell(cell)
	local itemCon = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(itemCon)
end

function HolyStripeCuilingView:_changeHolyStripId()
	HolyStripeCuilingView.super._changeHolyStripId(self)

	self._selectQuenchingId = nil

	self:_clearWaitReplace()
end

function HolyStripeCuilingView:setViewType()
	self:_setViewType(HolyStripeStrengthBaseView.ViewType.Cuiling)
end

function HolyStripeCuilingView:_onClickbtnCost()
	if not self._selectQuenchingId or self._selectQuenchingId <= 0 then
		FloatWordMgr.instance:show("未选择需要淬灵的属性")

		return
	end

	local selectQuenchingIds = {
		self._selectQuenchingId
	}

	HolyStripeAgent.instance:sendPM_HolyStripeQuenchingReq(self._holyStripId, selectQuenchingIds)
end

function HolyStripeCuilingView:_onClickbtnSure()
	HolyStripeAgent.instance:sendPM_HolyStripeReplaceQuenchingDataReq(self._holyStripId)
end

function HolyStripeCuilingView:_onClickbtnCancel()
	self:_clearWaitReplace()
end

function HolyStripeCuilingView:_setCostMats()
	local str = self._holyStripeMo:getQuenchingCost()
	local arr = string.split(str, "#")

	self:_setTopGoldBar(arr)
	self._costMatItems:updateWithMoArray(arr, function(item, cfgStr)
		MaterialMgr.resetAll(item.mainGO)

		local proxy = MaterialMgr.setCellByCfg(cfgStr, item.mainGO)
		local arr = string.split(cfgStr, ":")
		local useNum = checknumber(arr[#arr])
		local matType = checknumber(arr[1])
		local id = checknumber(arr[2])
		local hasNum = MaterialFacade.instance:getMatNumber(matType, id)

		str = hasNum < useNum and string.format("<color=%s>%s</color>", GameEnum.ColorConst.Red, useNum) or string.format("<color=%s>%s</color>", GameEnum.ColorConst.Green, useNum)

		proxy.binder:setNumStr(str)
	end)
end

function HolyStripeCuilingView:_setAttrs()
	local unlockLvs = HolyStripeConfig.instance:getQuenchingUnlockLvs()
	local showLen = #unlockLvs
	local list = self._holyStripeMo:getAllQuenchingCfgs()
	local ids = self._holyStripeMo:getQuenchingIds() or {}
	local idsKV = {}

	for i, id in ipairs(ids) do
		idsKV[id] = true
	end

	local activeList = {}
	local activeNum = #ids
	local unlockIndex = 0
	local posType = self._holyStripeMo:getPosType()
	local quality = self._holyStripeMo:getQuality()
	local idx = 1

	for i, quenchingId in ipairs(ids) do
		local cfg = HolyStripeConfig.instance:getQuenchingProperty(posType, quality, quenchingId)

		table.insert(activeList, {
			isActive = true,
			cfg = cfg,
			idx = idx
		})

		idx = idx + 1
	end

	for i = 1, showLen - #activeList do
		unlockIndex = unlockIndex + 1

		local var_21_1 = {
			isActive = false
		}

		var_21_1.unlockLv = unlockLvs[activeNum + unlockIndex] or ""
		var_21_1.idx = idx

		table.insert(activeList, var_21_1)

		idx = idx + 1
	end

	self._cacheAttrList = activeList

	self._attrScrollList:updateWithMoArray(activeList, self._updataAttrCell, self)
end

function HolyStripeCuilingView:_updateLeft()
	self:_setCostMats()
	self:_setAttrs()
end

function HolyStripeCuilingView:_updataAttrCell(item, data)
	local cfg = data.cfg
	local goCheckMark = goutil.findChild(item.mainGO, "select/checkMark")
	local imgChangeBg = item.mainGO:GetComponent(ComponentType.UIImageSpriteChange)
	local imgChangeNewIcon = goutil.findChild(item.mainGO, "new/newIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgChangeOldIcon = goutil.findChild(item.mainGO, "old/oldIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtNewDesc = goutil.findChildTextComponent(item.mainGO, "new/txtDesc")
	local txtOldDesc = goutil.findChildTextComponent(item.mainGO, "old/txtDesc")
	local txtNewValue = goutil.findChildTextComponent(item.mainGO, "new/txtValue")
	local txtOldValue = goutil.findChildTextComponent(item.mainGO, "old/txtValue")
	local lockGo = goutil.findChild(item.mainGO, "lock")
	local txtLock = goutil.findChildTextComponent(lockGo, "txt")
	local btnSelect = Framework.ButtonAdapter.GetFrom(item.mainGO, "select")
	local goNew = goutil.findChild(item.mainGO, "new")
	local goOld = goutil.findChild(item.mainGO, "old")
	local goSelect = goutil.findChild(item.mainGO, "select")
	local goEffect = goutil.findChild(item.mainGO, "effect")

	if data.isActive then
		local hasNew = self:_hasNewQuenchingId(cfg.quenchingId)

		goutil.setActive(goNew, data.isActive)
		goutil.setActive(goOld, data.isActive)
		goutil.setActive(lockGo, not data.isActive)
		goutil.setActive(goCheckMark, data.isActive and cfg.quenchingId == self._selectQuenchingId)

		if imgChangeBg and data.idx then
			imgChangeBg:SetState((data.idx - 1) % 2)
		end

		if not data.isActive then
			txtLock.text = string.format("强化+%s解锁", data.unlockLv)

			if string.nilorempty(data.unlockLv) then
				goutil.setActive(lockGo, false)
			else
				goutil.setActive(lockGo, true)
			end
		else
			local arr = string.split(cfg.doc, "+")
			local name = arr[1]

			txtOldValue.text = goCheckMark

			local index = table.indexof(GameEnum.HolyStripeAttrTypeName, name)

			if index then
				imgChangeOldIcon:SetState(index - 1)
			end

			txtOldDesc.text = name

			if data.isActive then
				local replaceData = self._quenchingReplaceDatas[cfg.quenchingId]
				local proCfg = self._holyStripeMo:getQuenchingPropertyCfg(replaceData.newQuenchingId)
				local arr = string.split(proCfg.doc, "+")
				local name = arr[1]

				txtNewValue.text = arr[2]

				local index = table.indexof(GameEnum.HolyStripeAttrTypeName, name)

				if index then
					imgChangeNewIcon:SetState(index - 1)
				end

				txtNewDesc.text = name
			end
		end

		btnSelect:AddClickListener(function()
			if self._selectQuenchingId == cfg.quenchingId then
				self._selectQuenchingId = nil
			else
				self._selectQuenchingId = cfg.quenchingId
			end

			self._attrScrollList:updateWithMoArray(self._cacheAttrList, self._updataAttrCell, self)
			self:_setBtnState()
		end)

		if data.isActive and self._oldId and self._oldId == cfg.quenchingId then
			self._oldId = nil

			if self._replaceEffHandler then
				UIEffectManager.instance:stopEffect(self._replaceEffHandler)

				self._replaceEffHandler = nil
			end

			local effName = "fx_ui_assignmentview/fx_ui_assignmentview_refresheffect.prefab"

			self._replaceEffHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, nil, function()
				self._replaceEffHandler:setClipping(self._gRootRt)
			end)

			self._replaceEffHandler:setParent(goEffect.transform)
			self._replaceEffHandler:setLocalPos(-37, 20, 0)
			self._replaceEffHandler:setScale(0.4)

			self._replaceEffHandler.hideEffWhileNotOnTop = false
		end

		goutil.setActive(goSelect, data.isActive and (not self._selectQuenchingId or cfg.quenchingId == self._selectQuenchingId) and not self._newId)
	end
end

function HolyStripeCuilingView:_clearAttrCell(cell)
	return
end

function HolyStripeCuilingView:_setItemName()
	local itemName = MaterialMgr.getMaterialsName(MatType.HolyStripe, self._holyStripeMo:getDefineId())

	self._txtItemName.text = string.format("%s Lv.%s", itemName, self._holyStripeMo:getLv())
end

function HolyStripeCuilingView:_hasNewQuenchingId(oldId)
	return self._quenchingReplaceDatas and self._quenchingReplaceDatas[oldId]
end

function HolyStripeCuilingView:_PM_HolyStripeQuenchingRes(quenchingReplaceDatas)
	self._oldId = nil
	self._newId = nil

	for i, v in ipairs(quenchingReplaceDatas) do
		self._quenchingReplaceDatas[v.oldQuenchingId] = v
		self._oldId = v.oldQuenchingId
		self._newId = v.newQuenchingId
	end

	self._selectQuenchingId = nil
	self._isWaitReplace = true

	self:_updateLeft()
	self:_setBtnState()
end

function HolyStripeCuilingView:_sureCuilingResult()
	if self._oldId and self._newId then
		self._holyStripeMo:setCuiling(self._oldId, self._newId)
	end

	self:_clearWaitReplace()
end

function HolyStripeCuilingView:_clearWaitReplace()
	self._isWaitReplace = false
	self._oldId = nil
	self._newId = nil
	self._quenchingReplaceDatas = {}

	self:_setBtnState()
	self:_updateLeft()
end

function HolyStripeCuilingView:_setBtnState()
	goutil.setActive(self._btnSure.gameObject, self._isWaitReplace)
	goutil.setActive(self._btnCancel.gameObject, self._isWaitReplace)
	goutil.setActive(self._btnCost.gameObject, not self._newId and not self._oldId)
end

function HolyStripeCuilingView:_setTopGoldBar(arr)
	if not self._isSetGold then
		self._isSetGold = true

		local btn_list = {}

		for i, v in ipairs(arr) do
			table.insert(btn_list, {
				showAdd = false,
				id = v
			})
		end

		MainUIController.instance:showGlodBar(self._goldbarConGo, self._viewPresentor, btn_list, false)
	end
end

function HolyStripeCuilingView:_onForceUpdateCuiling(id)
	if id and self._holyStripId ~= id then
		self._viewPresentor._openParam = {
			id
		}

		self:onEnter()
	end
end

return HolyStripeCuilingView
