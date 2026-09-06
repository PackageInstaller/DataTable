-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitEditView.lua

module("logic.extensions.holystripe.view.HolyStripeSuitEditView", package.seeall)

local HolyStripeSuitEditView = class("HolyStripeSuitEditView", ViewComponent)
local inputLenLimit = 6
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
local resultCode = {}

resultCode[0] = "预设名可以由<color=#ffffff>2-6个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-13526] = "预设名不可为空"
resultCode[-13530] = "预设名不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-13528] = "预设名太长了"
resultCode[-1505] = "有些字不太合适哦，再想想看？"
resultCode[-1513] = "预设名格式有误哦(只能由汉字、字母、数字和下划线等组成，且不能全为数字或下划线)"

function HolyStripeSuitEditView:buildUI()
	HolyStripeSuitEditView.super.buildUI(self)

	self._btnClose = self:getGo("closeBtn")
	self._btnSure = self:getGo("btnSure")
	self._tableView = self:getGo("rightRoot/attrRoot/tableview")
	self._tableCell = self:getGo("rightRoot/attrRoot/tablecell")
	self._suitIcon = self:getGo("rightRoot/attrRoot/attrIcon")
	self._suitDesc = self:getTxt("rightRoot/attrRoot/txtDesc")
	self._recommenItemCon = self:getGo("rightRoot/txtRecommen")
	self._txtRecommen = self:getTxt("rightRoot/txtRecommen")
	self._backEffectGo = self:getGo("rightRoot/bgEffect")
	self._effectBgGo = self:getGo("rightRoot")
	self._effectBgRt = self:getGo("rightRoot"):GetComponent(goutil.Type_RectTransform)

	self:_buildEquipItems()

	self._attrScrollList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updataAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._headIcon = self:getGo("head/con")
	self._petName = self:getTxt("head/txtName")
	self._patBag = self:getGo("petBag")
	self._btnRule = self:getBtn("btnRule")
	self._lineEffectGo = self:getGo("lineEffect")
	self._inputName = self:getInput("InputC_Search")

	self._inputName:SetCharacterLimit(inputLenLimit)
end

function HolyStripeSuitEditView:_buildEquipItems()
	local equipCell = self:getGo("rightRoot/equipRoot/cell1")
	local equipRoot = self:getGo("rightRoot/equipRoot")

	self._equipItems = {}

	local goList = {
		equipCell
	}

	for i = 2, 5 do
		goList[i] = goutil.cloneAndSetParent(equipCell, equipRoot.transform, "cell" .. i)
	end

	for i, go in ipairs(goList) do
		local btn = Framework.ButtonAdapter.GetFrom(go, "raycast")
		local icon = goutil.findChild(go, "icon")
		local lvText = goutil.findChildTextComponent(go, "lvText")
		local nameText = goutil.findChildTextComponent(go, "nameText")
		local effect = goutil.findChild(go, "effect")
		local redpoint = goutil.findChild(go, "redpoint")
		local select = goutil.findChild(go, "select")
		local quality = goutil.findChild(go, "quality")
		local qualityUIChange = goutil.findChildComponent(go, "quality", "UIImageSpriteChange")

		self._equipItems[i] = {
			btn = btn,
			icon = icon,
			lvText = lvText,
			effect = effect,
			nameText = nameText,
			redPoint = redpoint,
			select = select,
			quality = quality,
			qualityUIChange = qualityUIChange
		}

		local pos = HolyStripeMainView.HolyStripePosition[i]

		GameUtil.setAnchoredPos(go, pos.x, pos.y)

		if select then
			Framework.TransformUtil.SetLocalRotation(select.transform, 0, 0, pos.rotate)
		end

		if quality then
			Framework.TransformUtil.SetLocalRotation(quality.transform, 0, 0, pos.rotate)
		end
	end
end

function HolyStripeSuitEditView:bindEvents()
	HolyStripeSuitEditView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._inputName:AddOnValueChanged(self._onValueChanged, self)
	Framework.UIClickTrigger.Get(self._inputName.input.gameObject):AddClickListener(self._onClickInput, self, nil)
end

function HolyStripeSuitEditView:unbindEvents()
	HolyStripeSuitEditView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	self._inputName:RemoveOnValueChanged()
	Framework.UIClickTrigger.Get(self._inputName.input.gameObject):RemoveClickListener()
end

function HolyStripeSuitEditView:onEnter()
	HolyStripeSuitEditView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeModifySuitRes, self._PM_HolyStripeModifySuitRes, self)

	self._suitId = self:getFirstParam()
	self._suitMo = HolyStripeModel.instance:getSuitMo(self._suitId)
	self._copyWearIds = {}

	for i, v in ipairs(self._suitMo.wearIds) do
		table.insert(self._copyWearIds, v)
	end

	self.addGEvent(self, HolyStripeController.Bag_Item_Tips_Show, self._showTips, self)
	self.addGEvent(self, HolyStripeController.On_Select_FilterPos, self._onPosFilterChange, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyHolyStripeSuitInfoChangeRes, self._updataView, self)

	self._posFilterId = nil
	self._gRootRt = GlobalModel.instance.uiRoot:GetComponent(goutil.Type_RectTransform)
	self._shineEffect = {}

	self:_updataView()
	self._inputName:SetText(self._suitMo.suitName)
end

function HolyStripeSuitEditView:onExit()
	HolyStripeSuitEditView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeSuitEndEdit)
end

function HolyStripeSuitEditView:_onClickClose()
	self._suitMo.wearIds = self._copyWearIds

	HolyStripeModel.instance:clearTempSuitMo()
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyHolyStripeSuitInfoChangeRes)
	self:close()
end

function HolyStripeSuitEditView:_onClickSure()
	self._suitMo.wearIds = self._suitMo.wearIds or {}

	local hasEquip = false

	for i = 1, 5 do
		if not self._suitMo.wearIds[i] or self._suitMo.wearIds[i] == -1 then
			self._suitMo.wearIds[i] = -1
		else
			hasEquip = true
		end
	end

	if not hasEquip then
		FloatWordMgr.instance:show(lang("当前套装为空"))

		return
	end

	local isValid = self:_checkNameValid(self._inputName:GetText())

	if isValid == true then
		if self._suitId ~= HolyStripeModel.TempSuitId then
			HolyStripeAgent.instance:sendPM_ModifySuitReq(self._suitId, self._inputName:GetText(), nil, self._suitMo.wearIds)
		else
			HolyStripeAgent.instance:sendPM_ModifySuitReq(nil, self._inputName:GetText(), self._suitMo.groupId, self._suitMo.wearIds)
		end

		HolyStripeModel.instance:clearTempSuitMo()
	end
end

function HolyStripeSuitEditView:_onPosFilterChange(posFilterId)
	self._posFilterId = posFilterId

	self:_updataView()
end

function HolyStripeSuitEditView:_onClickInput()
	if self._inputName.input.isFocused then
		-- block empty
	end
end

function HolyStripeSuitEditView:_checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		self:_showRenameTips(-13526)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, regex) then
		self:_showRenameTips(-1513)
	elseif realLen < 2 then
		self:_showRenameTips(-13530)
	elseif isAllUnderLine then
		self:_showRenameTips(-1513)
	elseif realLen > inputLenLimit then
		self:_showRenameTips(-13528)
	else
		isValid = true
	end

	return isValid
end

function HolyStripeSuitEditView:_showEquipSuitEffect()
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

function HolyStripeSuitEditView:_updataView()
	self:_parseData()
	self:_setEquipItems()
	self:_showSuit()
	self:_refreshAllAttr()
	self:_refreshRecommeds()

	local raceId = HolyStripeModel.instance:getCurShowFaceId()

	MaterialMgr.setIcon(self._headIcon, MatType.Pet, raceId)

	self._petName.text = BagPetsController.instance:GetCurPetMo().name
end

function HolyStripeSuitEditView:_parseData()
	self._curPetId = HolyStripeModel.instance:getCurrShowPetId()
	self._equipList = {}

	for i, v in ipairs(self._suitMo.wearIds) do
		local mo = HolyStripeModel.instance:getHolyStripeMo(v)

		if mo then
			table.insert(self._equipList, mo)
		end
	end

	self._id2posList = self._id2posList or {}
	self._posDataList = {}

	for i, v in ipairs(self._equipList) do
		local defineId = v:getDefineId()
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(defineId)

		self._id2posList[defineId] = cfg.positionType
		self._posDataList[cfg.positionType] = v
	end
end

function HolyStripeSuitEditView:_setEquipItems()
	for i, v in ipairs(self._equipItems) do
		v.lvText.text = ""
		v.nameText.text = ""

		v.btn:RemoveClickListener()
		v.btn:AddClickListener(function()
			self:_onItemBtnClick(i, false)
		end)
		goutil.setActive(v.icon, false)
		goutil.setActive(v.quality, false)
		MaterialMgr:clearIcon(v.icon)

		if v.select then
			goutil.setActive(v.select, false)
		end
	end

	for posType, v in pairs(self._posDataList) do
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(v:getDefineId())
		local iconGo = self._equipItems[posType].icon
		local quality = self._equipItems[posType].quality
		local qualityUIChange = self._equipItems[posType].qualityUIChange

		self._equipItems[posType].lvText.text = v:getLv() > 0 and "Lv." .. v:getLv() or ""

		local _, color
		local var_17_0, var_17_1 = PetEquipController:GetQualityStrByNum(v:getQuality())

		_ = var_17_0
		self._equipItems[posType].nameText.text = langPara("<color=%s>%s</color>", var_17_1, cfg.name)

		goutil.setActive(quality, true)
		qualityUIChange:SetState(cfg.quality)
		MaterialMgr.setIcon(iconGo, MatType.HolyStripe, v:getDefineId())
		goutil.setActive(iconGo, true)
		self._equipItems[posType].btn:RemoveClickListener()
		goutil.setActive(self._equipItems[posType].redPoint, false)
		self._equipItems[posType].btn:AddClickListener(function()
			self:_onItemBtnClick(posType, true, v:getId())
		end)
	end

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

function HolyStripeSuitEditView:_resetEquipItems()
	for i, item in ipairs(self._equipItems) do
		item.btn:RemoveClickListener()
		MaterialMgr:clearIcon(item.icon)
		MaterialMgr.resetAll(item.icon)
	end
end

function HolyStripeSuitEditView:_showSuit()
	local suitList = self._suitMo:getSuitList()

	self._suitDesc.text = ""

	goutil.setActive(self._suitIcon, true)
	MaterialMgr.resetAll(self._suitIcon)

	for i, v in ipairs(suitList) do
		if v.num >= 4 then
			local iconCfg = HolyStripeConfig.instance:getSuitInfo(v.suitType)

			MaterialMgr.setIcon(self._suitIcon, MatType.HolyStripe, iconCfg.cfg.id)

			self._suitDesc.text = v.doc

			return
		end
	end

	goutil.setActive(self._suitIcon, false)

	self._suitDesc.text = lang("未激活套装4件套效果")
end

function HolyStripeSuitEditView:_refreshAllAttr()
	local attrs = HolyStripeModel.instance:getAttrListByMo(self._equipList, self._suitMo:getSuitList())

	if #attrs == 0 then
		for i, v in ipairs(HolyStripeModel.DefaultAttr) do
			table.insert(attrs, {
				value = 0,
				type = v,
				name = ConstString.HolyStripeAttr[v]
			})
		end
	end

	self._attrScrollList:reloadData(attrs)
end

function HolyStripeSuitEditView:_refreshRecommeds()
	local curFaceId = HolyStripeModel.instance:getCurShowFaceId()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	self._txtRecommen.text = langPara("推荐灵纹：%s", (cfg or nil) and cfg.recmdHolystripeId)
end

function HolyStripeSuitEditView:_updataAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameTxt = goutil.findChildTextComponent(go, "nameText")
	local valueTxt = goutil.findChildTextComponent(go, "valueText")
	local iconGo = goutil.findChild(go, "attr")
	local icon = goutil.findChildComponent(go, "attr", "UIImageSpriteChange")

	if data.type then
		goutil.setActive(iconGo, true)
		icon:SetState(data.type - 1)
	else
		goutil.setActive(iconGo, false)
	end

	valueTxt.text = data.value > 0 and data.value < 1 and string.format("%s%%", data.value * 100) or data.value
	nameTxt.text = data.name
end

function HolyStripeSuitEditView:_clearAttrCell(cell)
	return
end

function HolyStripeSuitEditView:_onItemBtnClick(posType, equip, id)
	if equip and id then
		GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterPos, posType)
		UIStateManager.instance:push(ViewName.HolyStripeSuitTipsView, id, false, nil, nil, nil, self._suitId)
	else
		GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterPos, posType)
	end
end

function HolyStripeSuitEditView:_onValueChanged()
	local value = self._inputName:GetText()
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(inputLenLimit, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._inputName:SetText(result)
end

function HolyStripeSuitEditView:_showTips(itemId)
	local itemMo = HolyStripeModel.instance:getHolyStripeMo(itemId)

	for i, v in ipairs(self._equipList) do
		if v:getId() == itemMo:getId() then
			for i, v in ipairs(self._shineEffect) do
				UIEffectManager.instance:stopEffect(v)
			end

			UIEffectManager.instance:stopEffect(self._lineEffect)
			UIStateManager.instance:push(ViewName.HolyStripeSuitTipsView, itemId, false, nil, nil, nil, self._suitId)

			return
		end

		if v:getPosType() == itemMo:getPosType() then
			for i, v in ipairs(self._shineEffect) do
				UIEffectManager.instance:stopEffect(v)
			end

			UIEffectManager.instance:stopEffect(self._lineEffect)
			UIStateManager.instance:push(ViewName.HolyStripeSuitCompareTipsView, v:getId(), itemMo:getId(), self._suitId)

			return
		end
	end

	UIStateManager.instance:push(ViewName.HolyStripeSuitTipsView, itemId, false, nil, nil, nil, self._suitId)
end

function HolyStripeSuitEditView:_showRenameTips(status)
	FloatWordMgr.instance:show(lang(resultCode[status] or ""))
end

function HolyStripeSuitEditView:_PM_HolyStripeModifySuitRes(status)
	if status == 0 then
		self:close()
	end
end

return HolyStripeSuitEditView
