-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolystripestrengthView.lua

module("logic.extensions.holystripe.view.HolystripestrengthView", package.seeall)

local HolystripestrengthView = class("HolystripestrengthView", HolyStripeStrengthBaseView)

function HolystripestrengthView:ctor()
	HolystripestrengthView.super.ctor(self)

	self._unOneKeyQuality = 5
end

function HolystripestrengthView:unbindEvents()
	HolystripestrengthView.super.unbindEvents(self)
	self._btnStrength:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._sliderAdapter:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._tipBtn)
end

function HolystripestrengthView:bindEvents()
	HolystripestrengthView.super.bindEvents(self)
	self._btnStrength:AddClickListener(self._onClickbtnStrength, self)
	self._btnAdd:AddClickListener(self._onClickAddBtn, self)
	self._btnMinus:AddClickListener(self._onClickSubtractBtn, self)
	self._sliderAdapter:AddOnValueChanged(self._setSliderValue, self)
	GameUtil.addClickHandler(self._tipBtn, self._onClickTips, self)
end

function HolystripestrengthView:buildUI()
	HolystripestrengthView.super.buildUI(self)

	self._btnStrength = self:getBtn("strengthen/btnStrength")
	self._quenchingTableviewGo = self:getGo("strengthen/leftInfo/lvStrength/quenchingAttr/tableview")
	self._baseTableviewGo = self:getGo("strengthen/leftInfo/lvStrength/tableview")
	self._tablecellGo = self:getGo("strengthen/leftInfo/lvStrength/tablecell")
	self._baseAttrScrollList = ScrollerList.create(self._baseTableviewGo, self._tablecellGo, GameUtil.handler(self._updataAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._quenchingAttrScrollList = ScrollerList.create(self._quenchingTableviewGo, self._tablecellGo, GameUtil.handler(self._updataAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._slider = self:getSlider("strengthen/leftInfo/lvProgre/slider")
	self._txtNext = self:getTxt("strengthen/leftInfo/lvProgre/txtNext")
	self._txtProgre = self:getTxt("strengthen/leftInfo/lvProgre/txtProgre")
	self._txtNow = self:getTxt("strengthen/leftInfo/lvProgre/txtNow")
	self._emptyTxt = self:getTxt("empty/txtEmpty")
	self._txNow = self:getTxt("strengthen/levelUp/txNow")
	self._txNext = self:getTxt("strengthen/levelUp/txNext")
	self._txtCost = self:getTxt("strengthen/txtCost")
	self._goldbarConGo = self:getGo("goldbarCon")
	self._levelSlider = self:getGo("strengthen/levelUp/levelSlider")
	self._sliderAdapter = Framework.SliderAdapter.Get(self._levelSlider)
	self._btnAdd = self:getBtn("strengthen/levelUp/btnAdd")
	self._btnMinus = self:getBtn("strengthen/levelUp/btnMinus")

	EndDragHandler.Get(self._levelSlider):AddLuaHandler(function(go, eventData)
		self:_onEndDrag(go, eventData)
	end)

	self._txtNum = self:getTxt("limit/txtNum")
	self._limit = self:getGo("limit")
	self._tipBtn = self:getGo("limit/tipBtn")
end

function HolystripestrengthView:onExit()
	HolystripestrengthView.super.onExit(self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeStrengthenRes, self._PM_HolyStripeStrengthenRes, self)
	UIEffectManager.instance:stopEffect(self.effectHandler)
end

function HolystripestrengthView:onEnter()
	self._totalSelect = {}
	self._totalAddExp = 0
	self._lockList = HolyStripeConfig.instance:getUnlockLvs()

	HolystripestrengthView.super.onEnter(self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeStrengthenRes, self._PM_HolyStripeStrengthenRes, self)
	self:_setTitleName("灵纹强化")

	if self._emptyTxt then
		self._emptyTxt.text = lang("当前无可消耗的材料")
	end

	self._smeltRefundExpRate = HolyStripeConfig.instance:getSmeltRefundExpRate()
	self._costCoinsList = HolyStripeConfig.instance:getStrengthenCostCoins()
	self._strengthMatLimit = HolyStripeConfig.instance:getMaxStrengthLimit()
	self._strengthMatSelectNum = 0
	self._isSetGold = false

	self:_setTopGoldBar()
	HolyStripeAgent.instance:sendPM_SuitGetInfoReq()
end

function HolystripestrengthView:_onClickTips()
	local type = MatType.HolyStripe

	ItemBagController.instance:showLimitTipsWithType(type)
end

function HolystripestrengthView:_showCurrLiitWithType()
	local type = MatType.HolyStripe
	local cur, total = ItemBagController.instance:getCurrLiitWithType(type)

	self._txtNum.text = cur > total * 0.9 and langPara("<color=#eb4642>%s</color>/%s", cur, total) or langPara("%s/%s", cur, total)
end

function HolystripestrengthView:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "strengthen/scrollView"
	}
end

function HolystripestrengthView:refreshView()
	local list = HolyStripeModel.instance:getAllHolyStripeMo(self._holyStripId)
	local newList = {}

	for i, mo in ipairs(list) do
		if mo:getEquipPetId() < 0 then
			table.insert(newList, mo)
		end
	end

	local mats = HolyStripeConfig.instance:getStrengthMats()

	for i = #mats, 1, -1 do
		local hasNum = MaterialFacade.instance:getMatNumber(MatType.Item, mats[i].matId)

		if hasNum > 0 then
			table.insert(newList, 1, mats[i])
		end
	end

	self._oriViewDatas = newList

	self:_refreshBag(list)
	self:_refreshFilter()
	goutil.setActive(self._emptyGo, not self._curViewDatas or #self._curViewDatas <= 0)
end

function HolystripestrengthView:_dataPretreatment(moList)
	local newList = {}

	for i, mo in ipairs(moList) do
		if mo:getEquipPetId() < 0 then
			table.insert(newList, {
				totalNum = 1,
				selectNum = 0,
				mo = mo
			})
		end
	end

	if self._qualityFilterId == nil then
		local mats = HolyStripeConfig.instance:getStrengthMats()

		for i = #mats, 1, -1 do
			local hasNum = MaterialFacade.instance:getMatNumber(MatType.Item, mats[i].matId)

			if hasNum > 0 then
				table.insert(newList, 1, {
					selectNum = 0,
					mo = mats[i],
					totalNum = hasNum
				})
			end
		end
	end

	return newList
end

function HolystripestrengthView:_refreshLeftInfo()
	if not self._holyStripeMo then
		return
	end

	self:_updateSliderPart()
	self:_updateAttrPart()
	self:_updataTxtCost()
end

function HolystripestrengthView:_onClickbtnStrength()
	local usingIds = {}
	local usingMaterials = {}
	local hasHightQuality = false
	local hasQuality5 = false

	for k, data in pairs(self._oriViewDatas) do
		local num = 0

		if not data.isMat and self._totalSelect[data:getId()] then
			num = self._totalSelect[data:getId()]
		elseif data.isMat and self._totalSelect["Mat" .. data.matId] then
			num = checknumber(self._totalSelect["Mat" .. data.matId])
		end

		if num > 0 then
			local mo = data

			if mo.isMat then
				local item = MaterialExtension_pb.MaterialItemNO()

				item.id = mo.matId
				item.num = num

				table.insert(usingMaterials, item)
			else
				table.insert(usingIds, mo:getId())

				hasHightQuality = hasHightQuality or mo:getQuality() >= 4
				hasQuality5 = hasQuality5 or mo:getQuality() >= 5
			end
		end
	end

	if #usingIds == 0 and #usingMaterials == 0 then
		FloatWordMgr.instance:show("请放入材料")

		return
	end

	self._usingIds = usingIds
	self._usingMaterials = usingMaterials

	if hasQuality5 and PasswordLockController.instance:checkNeedOpenVerifyView() then
		return
	end

	local notShowTip = HolyStripeModel.instance:getStrengthTip()

	if not notShowTip and hasHightQuality then
		local content = "当前选中的材料有橙色或红色以上品质灵纹，是否确定放入？\n<color=#33B56FFF>温馨提示：可通过品质筛选后，再进行一键放入低品质灵纹。</color>"
		local togText = "本次登录不再提示"

		local function func1()
			self:_sendStrengReq()
		end

		local function funcTog()
			HolyStripeModel.instance:setStrengthTip(true)
		end

		TipsFacade.instance:openPopupWindowWithTog(lang("tip"), content, func1, nil, funcTog, nil, nil, togText, UnityEngine.TextAnchor.MiddleCenter)
	else
		self:_sendStrengReq()
	end
end

function HolystripestrengthView:_sendStrengReq()
	local hasNum = MaterialFacade.instance:getMatNumber(MatType.Coin, 1)
	local cost = self:_getCostNum()

	if hasNum < cost then
		FloatWordMgr.instance:show("金币不足")

		return
	end

	if self._usingIds and self._usingMaterials then
		HolyStripeController.instance:sendPM_HolyStripeStrengthenReq(self._holyStripId, self._usingIds, self._usingMaterials)
	end

	self._usingIds = nil
	self._usingMaterials = nil
end

function HolystripestrengthView:_updataAttrCell(view, cell, data, tag)
	local valueStr = data.nowValueStr
	local nextValueStr = data.nextValueStr
	local imgChangeBg = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local imgChangeAttrIcon = goutil.findChild(cell, "attrIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgArrowGo = goutil.findChild(cell, "imgArrow")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtNext = goutil.findChildTextComponent(cell, "txtNext")
	local txtNow = goutil.findChildTextComponent(cell, "txtNow")
	local lockGo = goutil.findChild(cell, "lock")
	local lockDesc = goutil.findChildTextComponent(cell, "lock/txtDesc")
	local arr = string.split(valueStr, "+")
	local name = arr[1]
	local value = tonumber(arr[2])
	local index = table.indexof(GameEnum.HolyStripeAttrTypeName, name)

	if imgChangeBg and data.idx then
		imgChangeBg:SetState((data.idx - 1) % 2)
	end

	goutil.setActive(imgChangeAttrIcon.gameObject, not data.isLock)
	goutil.setActive(txtName.gameObject, not data.isLock)
	goutil.setActive(txtNext.gameObject, not string.nilorempty(nextValueStr))
	goutil.setActive(txtNow.gameObject, not data.isLock)
	goutil.setActive(lockGo.gameObject, data.isLock)

	if data.isLock then
		lockDesc.text = valueStr
	end

	if index then
		imgChangeAttrIcon:SetState(index - 1)
	end

	if value == nil then
		value = arr[2]
		txtNow.text = arr[2]
	else
		txtNow.text = value > 0 and value < 1 and string.format("%s%%", value * 100) or value
	end

	txtName.text = name

	goutil.setActive(imgArrowGo, not string.nilorempty(nextValueStr) and not data.isLock)

	if not string.nilorempty(nextValueStr) then
		local arr = string.split(nextValueStr, "+")
		local value = tonumber(arr[2])

		txtNext.text = value == nil and nextValueStr or value > 0 and value < 1 and string.format("%s%%", value * 100) or value
	else
		txtNext.text = ""
	end
end

function HolystripestrengthView:_clearAttrCell(cell)
	return
end

function HolystripestrengthView:_updataCell(view, cell, data, tag)
	local mo = data.mo
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "item")
	local lock = goutil.findChild(go, "lock")
	local discard = goutil.findChild(go, "discard")
	local btnReduce = Framework.ButtonAdapter.Get(goutil.findChild(go, "btnReduce"))
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local autoDestroyTagGo = goutil.findChild(go, "autoDestroyTag")

	MaterialMgr.resetAll(itemCon)

	if mo.isMat == nil and data.mo:getIsLock() then
		goutil.setActive(lock, true)
	end

	local var_20_0

	do
		goutil.setActive(lock, false)

		var_20_0 = mo.isMat == nil and data.mo.getIsReadyToDiscard and data.mo:getIsReadyToDiscard() or false
	end

	goutil.setActive(discard, var_20_0)

	local proxy

	if mo.isMat then
		proxy = MaterialMgr.setCellByCfg(mo.cfgStr, itemCon)

		proxy.binder:setNumStr(string.format("%s/%s", self._totalSelect["Mat" .. mo.matId] or 0, data.totalNum))

		nameText.text = ""
	else
		proxy = MaterialMgr.setCellByMo(mo, itemCon)

		proxy.binder:setCellEfectOnTop(true)
		proxy.binder:setNumStr(" ")
		proxy.binder:setNumBg(false)

		local _, color
		local var_20_1, var_20_2 = PetEquipController:GetQualityStrByNum(mo:getQuality())

		_ = var_20_1
		nameText.text = langPara("<color=%s>%s</color>", var_20_2, mo:getName())
	end

	local autoSmelt = false

	if not mo.isMat and self._autoSmeltDays > 0 and not mo:getIsLock() and mo:getEquipPetId() < 0 then
		for i, v in ipairs(self._autoSmeltQuality) do
			if checknumber(mo:getQuality()) == v then
				autoSmelt = true

				break
			end
		end
	end

	goutil.setActive(autoDestroyTagGo, autoSmelt)

	local isSelect = false

	if mo.isMat then
		if self._totalSelect["Mat" .. mo.matId] then
			isSelect = self._totalSelect["Mat" .. mo.matId] > 0
		end
	elseif self._totalSelect[mo:getId()] then
		isSelect = self._totalSelect[mo:getId()] > 0
	end

	goutil.setActive(btnReduce.gameObject, isSelect)

	local isInSuit = not mo.isMat and HolyStripeModel.instance:getIsInSuit(data.mo:getId()) > 0

	proxy.binder:setAutoTips(false)
	proxy.binder:setSelected(isSelect)
	proxy.binder:setCallBack(function()
		if isInSuit == true then
			local suitId = HolyStripeModel.instance:getIsInSuit(data.mo:getId())
			local suitMo = HolyStripeModel.instance:getSuitMo(suitId)
			local groupInfo = HolyStripeModel.instance:getSuitGroupById(suitMo.groupId)
			local content = langPara("该选中灵纹存在【%s】【%s】方案中，是否当做材料吞噬？", groupInfo.groupName, suitMo.suitName)

			TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
				self:_onClickMat(data, true)
			end)
		else
			self:_onClickMat(data, true)
		end
	end)
	btnReduce:AddClickListener(function()
		self:_onClickMat(data, false)
	end)
end

function HolystripestrengthView:_clearCell(cell)
	local itemCon = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(itemCon)
end

function HolystripestrengthView:_updateSliderPart()
	self._txtNow.text = "Lv" .. self:_getShowNowLv()
	self._txtNext.text = "Lv" .. self:_getShowNextLv()

	if self:_isMaxLv() then
		self._txtProgre.text = "Max"

		self._slider:SetValue(1)
	else
		local curValue, nextValue = self:_getShowNowExp(), self:_getShowNextExp()

		self._txtProgre.text = string.format("%s/%s", curValue, nextValue)

		self._slider:SetValue(curValue / nextValue)
	end
end

function HolystripestrengthView:_updateAttrPart()
	local paramStr = self._holyStripeMo:getBasePropertyParam()
	local attrList = string.split(paramStr, "#")
	local attrNextList = {}

	if self._totalAddExp > 0 then
		local nextLv = self:_getShowNextLv()

		if not self:_isMaxLv() then
			nextLv = nextLv - 1
		end

		paramStr = self._holyStripeMo:getBasePropertyParam(nextLv)
		attrNextList = string.split(paramStr, "#")
	end

	local baseFinalList = {}

	for i, v in ipairs(attrList) do
		table.insert(baseFinalList, {
			islock = false,
			nowValueStr = v,
			nextValueStr = attrNextList[i],
			idx = i
		})
	end

	self._baseAttrScrollList:reloadData(baseFinalList)

	paramStr = self._holyStripeMo:getQuenchingPropertyDoc()
	attrList = {}

	if not string.nilorempty(paramStr) then
		attrList = string.split(paramStr, "#")
	end

	local finalList = {}
	local idx = 1

	for i, v in ipairs(attrList) do
		table.insert(finalList, {
			isLock = false,
			nowValueStr = v,
			idx = idx
		})

		idx = idx + 1
	end

	for i, v in ipairs(self._lockList) do
		if v > self._holyStripeMo:getLv() and v <= self._holyStripeMo:getMaxLv() then
			local content = langPara("强化+%d解锁", v)

			if v <= self:_getShowNowLv() then
				table.insert(finalList, {
					isLock = true,
					nowValueStr = content,
					nextValueStr = lang("解锁新属性"),
					idx = idx
				})
			else
				table.insert(finalList, {
					isLock = true,
					nowValueStr = content,
					idx = idx
				})
			end

			idx = idx + 1
		end
	end

	self._quenchingAttrScrollList:reloadData(finalList)
end

function HolystripestrengthView:_updataTxtCost()
	if not self._costCoinsList then
		self._txtCost.text = 0

		return
	end

	local hasNum = MaterialFacade.instance:getMatNumber(MatType.Coin, 1)
	local cost = self:_getCostNum()
	local color

	self._txtCost.text = string.format("<color=%s>%s</color>", cost <= hasNum and GameEnum.ColorConst.Green or GameEnum.ColorConst.Red, cost)
end

function HolystripestrengthView:_changeHolyStripId()
	HolystripestrengthView.super._changeHolyStripId(self)

	self._maxStrengthExp = self._holyStripeMo:getMaxStrengthExp()

	self:_resetViews()
end

function HolystripestrengthView:_onClickMat(data, isAdd, addTime, isOneKey)
	addTime = addTime or 1

	if isAdd and data.mo.isMat == nil then
		local goOrPos = self:getGo("strengthen/rightBg")
		local pos = goOrPos
		local sizeDelta = {
			0,
			0
		}

		if goOrPos and goOrPos.gameObject then
			local rect = goOrPos.gameObject:GetComponent("RectTransform")

			if rect ~= nil then
				sizeDelta = {
					rect.sizeDelta.x,
					rect.sizeDelta.y
				}
			end

			pos = goOrPos.gameObject.transform.position

			local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

			pos = uiCamera:WorldToScreenPoint(pos)
		end

		if not isOneKey then
			UIStateManager.instance:open(ViewName.HolyStripeRepaceTipsView, data.mo:getId(), false, pos, sizeDelta, true)
		end
	end

	if data.mo.isMat == nil and data.mo:getIsLock() then
		if not isOneKey then
			FloatWordMgr.instance:show("被上锁保护中，请解除锁定状态")
		end

		return
	end

	local selectNum = 0

	selectNum = data.mo.isMat and checknumber(self._totalSelect["Mat" .. data.mo.matId]) or checknumber(self._totalSelect[data.mo:getId()])

	if isAdd then
		if selectNum >= data.totalNum then
			FloatWordMgr.instance:show("达到当前材料可选数量限制")

			return
		end

		if self:_isMaxLv() then
			FloatWordMgr.instance:show("当前灵纹经验已满")

			return
		end

		if self._strengthMatSelectNum >= self._strengthMatLimit then
			FloatWordMgr.instance:show("达到材料可选数量限制")

			return
		end

		if selectNum <= 0 then
			self._strengthMatSelectNum = self._strengthMatSelectNum + 1
		end

		if data.mo.isMat then
			self._totalSelect["Mat" .. data.mo.matId] = checknumber(self._totalSelect["Mat" .. data.mo.matId]) + addTime
		else
			self._totalSelect[data.mo:getId()] = 1
		end
	else
		if data.mo.isMat then
			self._totalSelect["Mat" .. data.mo.matId] = checknumber(self._totalSelect["Mat" .. data.mo.matId]) - addTime
			selectNum = self._totalSelect["Mat" .. data.mo.matId]
		else
			self._totalSelect[data.mo:getId()] = 0
			selectNum = 0
		end

		if selectNum <= 0 then
			self._strengthMatSelectNum = self._strengthMatSelectNum - 1
		end
	end

	if not isOneKey then
		self._itemList:reloadData(self._curViewDatas)
	end

	self:_calCurAddExp()

	if not isOneKey then
		self:_refreshLeftInfo()
		self:_initSlider()
	end

	return true
end

function HolystripestrengthView:_calCurAddExp()
	self._totalAddExp = 0

	for k, data in pairs(self._oriViewDatas) do
		if data.isMat then
			if self._totalSelect["Mat" .. data.matId] and self._totalSelect["Mat" .. data.matId] > 0 then
				self._totalAddExp = self._totalAddExp + data.exp * checknumber(self._totalSelect["Mat" .. data.matId])
			end
		elseif self._totalSelect[data:getId()] and self._totalSelect[data:getId()] > 0 then
			self._totalAddExp = self._totalAddExp + (data:getExp() * self._smeltRefundExpRate + data:getRefundExp())
		end
	end
end

function HolystripestrengthView:_getShowNowLv()
	return self._holyStripeMo:getLvByAddExp(self._totalAddExp)
end

function HolystripestrengthView:_getShowNextLv()
	return self._holyStripeMo:getNextLvByAddExp(self._totalAddExp)
end

function HolystripestrengthView:_getShowTargetLv()
	return math.floor(self._sliderAdapter:GetValue())
end

function HolystripestrengthView:_getShowNowExp()
	local nowExp = self._holyStripeMo:getExp() + self._totalAddExp
	local lv = self:_getShowNowLv()
	local baseExp = self._holyStripeMo:getLvCostExp(lv)

	return nowExp - baseExp
end

function HolystripestrengthView:_getShowNextExp()
	local lv = self:_getShowNextLv()
	local nextExp = self._holyStripeMo:getLvCostExp(lv)
	local preExp = self._holyStripeMo:getLvCostExp(lv - 1)

	return nextExp - preExp
end

function HolystripestrengthView:_getShowTargetExp()
	local lv = self:_getShowNowLv()
	local targetLv = self:_getShowTargetLv()
	local preExp = self._holyStripeMo:getLvCostExp(targetLv)
	local curExp = self._holyStripeMo:getLvCostExp(lv)

	return preExp - curExp
end

function HolystripestrengthView:_PM_HolyStripeStrengthenRes()
	self:_changeHolyStripId()
end

function HolystripestrengthView:_resetViews()
	self._strengthMatSelectNum = 0
	self._totalSelect = {}
	self._totalAddExp = 0

	self:refreshView()
	self:_refreshLeftInfo()
	self:_initSlider()
	self:_showCurrLiitWithType()
end

function HolystripestrengthView:setViewType()
	self:_setViewType(HolyStripeStrengthBaseView.ViewType.Strength)
end

function HolystripestrengthView:_isMaxLv()
	return self._totalAddExp + self._holyStripeMo:getExp() >= self._maxStrengthExp
end

function HolystripestrengthView:_setTopGoldBar()
	if not self._isSetGold then
		self._isSetGold = true

		local btn_list = {
			{
				showAdd = false,
				id = GameEnum.GoldType.Coin
			}
		}

		MainUIController.instance:showGlodBar(self._goldbarConGo, self._viewPresentor, btn_list, false)
	end
end

function HolystripestrengthView:_compareQuality(a, b, isReverse, reverseNotPass)
	if a:getQuality() ~= b:getQuality() then
		if isReverse == true then
			return a:getQuality() > b:getQuality()
		else
			return a:getQuality() < b:getQuality()
		end
	end

	if reverseNotPass == true then
		return self:_compareTime(a, b, not isReverse)
	end

	return self:_compareTime(a, b, isReverse)
end

function HolystripestrengthView:_compareLv(a, b, isReverse, reverseNotPass)
	if a:getLv() ~= b:getLv() then
		if isReverse == true then
			return a:getLv() > b:getLv()
		else
			return a:getLv() < b:getLv()
		end
	end

	if reverseNotPass == true then
		return self:_compareQuality(a, b, not isReverse)
	end

	return self:_compareQuality(a, b, isReverse)
end

function HolystripestrengthView:_compareHoly(a, b, conditionId, isReverse)
	if conditionId == -1 then
		return self:_compareEquip(a, b, isReverse)
	elseif conditionId == -2 then
		return self:_compareTime(a, b, isReverse)
	elseif conditionId == -3 then
		return self:_compareLv(a, b, true, true)
	elseif conditionId == -4 then
		return self:_compareQuality(a, b, true, true)
	elseif conditionId == -5 then
		return self:_compareDiscard(a, b, isReverse)
	end

	return self:_compareAttr(a, b, conditionId, isReverse)
end

function HolystripestrengthView:_initSlider()
	self._sliderAdapter.slider.minValue = self._holyStripeMo:getLv()
	self._sliderAdapter.slider.maxValue = self._holyStripeMo:getMaxLv()
	self._txNow.text = "Lv." .. self:_getShowNowLv()
	self._txNext.text = "Lv." .. self._holyStripeMo:getMaxLv()

	self._sliderAdapter:SetValue(self:_getShowNowLv())
end

function HolystripestrengthView:_setSliderValue(value)
	local num = math.floor(value)

	self._txNow.text = "Lv." .. num

	if value < self:_getShowNowLv() then
		self._strengthMatSelectNum = 0
		self._totalSelect = {}
		self._totalAddExp = 0

		self:refreshView()
		self:_refreshLeftInfo()
	end

	self:_setOneKey()
	self._sliderAdapter:SetValue(self:_getShowNowLv())
end

function HolystripestrengthView:_onEndDrag(go, eventData)
	local value = math.floor(self._sliderAdapter:GetValue())

	self._sliderAdapter:SetValue(self:_getShowNowLv())
end

function HolystripestrengthView:_onClickAddBtn()
	self._sliderAdapter:SetValue(self:_getShowNowLv() + 1)

	if self:_isMaxLv() == true then
		FloatWordMgr.instance:show("无法放入更多强化材料")
	end

	self:_setOneKey()
	self._sliderAdapter:SetValue(self:_getShowNowLv())
end

function HolystripestrengthView:_onClickSubtractBtn()
	local targetLv = self:_getShowNowLv() - 1

	self:_resetViews()
	self._sliderAdapter:SetValue(targetLv)
	self:_setOneKey()
	self._sliderAdapter:SetValue(self:_getShowNowLv())
end

function HolystripestrengthView:_setOneKey()
	local nextExp = self:_getShowTargetExp()
	local nowExp = self:_getShowNowExp()
	local nowLv = self:_getShowNowLv()
	local nextLv = self:_getShowTargetLv()
	local needExp = nextExp - nowExp
	local hit = false

	if not self:_isMaxLv() and needExp > 0 then
		table.sort(self._curViewDatas, function(a, b)
			if not a.mo.isMat then
				if not b.mo.isMat then
					local bIsMat = false

					if a.mo.isMat ~= bIsMat then
						return a.mo.isMat
					end

					if not a.mo.isMat then
						local aDiscard = a.mo.getIsReadyToDiscard and a.mo:getIsReadyToDiscard() or false
						local bDiscard = b.mo.getIsReadyToDiscard and b.mo:getIsReadyToDiscard() or false

						if aDiscard ~= bDiscard then
							return aDiscard
						end

						if aDiscard then
							local aQuality = a.mo:getQuality()
							local bQuality = b.mo:getQuality()

							if aQuality ~= bQuality then
								return aQuality < bQuality
							end
						end
					end

					return false
				end
			end
		end)

		for i, data in ipairs(self._curViewDatas) do
			local needNum = math.ceil(needExp / data.mo.exp)

			needNum = math.min(needNum, data.totalNum - (data.mo.isMat and checknumber(self._totalSelect["Mat" .. data.mo.matId]) or checknumber(self._totalSelect[data.mo:getId()])))

			if needNum > 0 and (data.mo.isMat or (data.mo.getIsReadyToDiscard and data.mo:getIsReadyToDiscard() or data.mo:getQuality() < self._unOneKeyQuality) and not data.mo:getIsLock() and HolyStripeModel.instance:getIsInSuit(data.mo:getId()) <= 0) then
				local res = self:_onClickMat(data, true, needNum, true)

				if not res then
					self._itemList:reloadData(self._curViewDatas)
					self:_calCurAddExp()
					self:_refreshLeftInfo()

					return
				else
					needExp = needExp - data.mo.exp * needNum
				end

				hit = true

				if nextLv <= self:_getShowNowLv() then
					break
				end
			end
		end

		if not hit then
			FloatWordMgr.instance:show("暂无更多强化材料")
		end
	end

	self._itemList:reloadData(self._curViewDatas)
	self:_calCurAddExp()
	self:_refreshLeftInfo()
end

function HolystripestrengthView:_getCostNum()
	local costNum = 0
	local realAddExp

	if self._totalAddExp then
		realAddExp = math.min(self._maxStrengthExp - self._holyStripeMo:getExp(), self._totalAddExp)
	end

	for i, v in ipairs(self._costCoinsList) do
		if realAddExp and v.quality == self._holyStripeMo:getQuality() then
			costNum = checkint(realAddExp / v.exp) * v.cost

			break
		end
	end

	return costNum
end

return HolystripestrengthView
