-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeRecommendCalcView.lua

module("logic.extensions.holystripe.view.HolyStripeRecommendCalcView", package.seeall)

local HolyStripeRecommendCalcView = class("HolyStripeRecommendCalcView", ViewComponent)

function HolyStripeRecommendCalcView:ctor()
	HolyStripeRecommendCalcView.super.ctor(self)
end

function HolyStripeRecommendCalcView:unbindEvents()
	HolyStripeRecommendCalcView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCur)
	GameUtil.rmClickHandler(self._btnCalculate)
	GameUtil.rmClickHandler(self._btnClear)
	GameUtil.rmClickHandler(self._btnEquip)
	GameUtil.rmClickHandler(self._btnSetSuit)
	GameUtil.rmClickHandler(self._btnFilterSuit)
	GameUtil.rmClickHandler(self._btnSuit1)
	GameUtil.rmClickHandler(self._btnSuit2)
	self._customInputSuitTable:RemoveListener()
	self._customInputSubAttrTable:RemoveListener()
	self._customInputMainAttrTable:RemoveListener()
	self._customInputProtjectTips:RemoveListener()
	GameUtil.rmClickHandler(self._btnPos2Attr)
	GameUtil.rmClickHandler(self._btnPos4Attr)
end

function HolyStripeRecommendCalcView:bindEvents()
	HolyStripeRecommendCalcView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnCur, self._onClickCur, self)
	GameUtil.addClickHandler(self._btnCalculate, self._onClickCalculate, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickClear, self)
	GameUtil.addClickHandler(self._btnEquip, self._onClickEquip, self)
	GameUtil.addClickHandler(self._btnSetSuit, self._onClickSetSuit, self)
	GameUtil.addClickHandler(self._btnFilterSuit, self._onClickFilterSuit, self)
	GameUtil.addClickHandler(self._btnSuit1, self._onClickSuit, self)
	GameUtil.addClickHandler(self._btnSuit2, self._onClickSuit, self)
	self._customInputSuitTable:AddListener(self._onClickSelectDraw, self)
	self._customInputSubAttrTable:AddListener(self._onClickSelectDraw, self)
	self._customInputMainAttrTable:AddListener(self._onClickSelectDraw, self)
	self._customInputProtjectTips:AddListener(self._onClickSelectDraw, self)
	GameUtil.addClickHandler(self._btnPos2Attr, function()
		self:_onClickPosAttr(self._btnPos2Attr, 2)
	end, self)
	GameUtil.addClickHandler(self._btnPos4Attr, function()
		self:_onClickPosAttr(self._btnPos4Attr, 4)
	end, self)
end

function HolyStripeRecommendCalcView:buildUI()
	HolyStripeRecommendCalcView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._calculateInfo = self:getGo("calculateInfo")
	self._attrInfo = self:getGo("attrInfo")
	self._suitTableview = self:getGo("calculateInfo/suitTableview")
	self._suitTablecell = self:getGo("calculateInfo/suitTableview/suitTablecell")
	self._suitTableList = ScrollerList.create(self._suitTableview, self._suitTablecell, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))
	self._customInputSuitTable = UICustomInput.Get(self:getGo("calculateInfo/suitTableview"))
	self._subAttrTableview = self:getGo("calculateInfo/subAttrTableview")
	self._subAttrTablecell = self:getGo("calculateInfo/subAttrTableview/subTablecell")
	self._subAttrTableList = ScrollerList.create(self._subAttrTableview, self._subAttrTablecell, GameUtil.handler(self._updateSubAttrCell, self), GameUtil.handler(self._clearSubAttrCell, self))
	self._customInputSubAttrTable = UICustomInput.Get(self:getGo("calculateInfo/subAttrTableview"))
	self._mainAttrTableview = self:getGo("calculateInfo/mainAttrTableview")
	self._mainAttrTablecell = self:getGo("calculateInfo/mainAttrTableview/mainAttrTablecell")
	self._mainAttrTableList = ScrollerList.create(self._mainAttrTableview, self._mainAttrTablecell, GameUtil.handler(self._updateMainAttrCell, self), GameUtil.handler(self._clearMainAttrCell, self))
	self._customInputMainAttrTable = UICustomInput.Get(self:getGo("calculateInfo/mainAttrTableview"))
	self._posHolyStripeRoot = self:getGo("attrInfo/posHolyStripeRoot")
	self._posCellList = {}

	for i = 1, self._posHolyStripeRoot.transform.childCount do
		self._posCellList[i] = goutil.findChild(self._posHolyStripeRoot, "pos_" .. i)
	end

	self._posHolyStripes = self:getGo("attrInfo/posHolyStripes")
	self._posCellConList = {}

	for i = 1, self._posHolyStripes.transform.childCount do
		self._posCellConList[i] = goutil.findChild(self._posHolyStripes, "posCon_" .. i)
	end

	self._curSuitIcon = self:getGo("attrInfo/attrRoot/suitIcon")
	self._curSuitDesc = self:getTxt("attrInfo/attrRoot/txtDesc")
	self._attrTableView = self:getGo("attrInfo/attrRoot/tableview")
	self._attrTableCell = self:getGo("attrInfo/attrRoot/tablecell")
	self._attrTableList = ScrollerList.create(self._attrTableView, self._attrTableCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._curPetGo = self:getGo("curPet")
	self._changeGroupCurPet = self._curPetGo:GetComponent(ComponentType.UIChangeGroup)
	self._curPetSelect = self:getGo("curPet/select")
	self._curPetCon = self:getGo("curPet/curPetCon")
	self._btnCur = self:getGo("curPet/btnCur")
	self._txtCurEquip = self:getTxt("curPet/txtCurEquip")
	self._resultBtns = self:getGo("attrInfo/resultBtns")
	self._projectTableview = self:getGo("projectTableview")
	self._projectTablecell = self:getGo("projectTableview/projectTablecell")
	self._projectTableList = ScrollerList.create(self._projectTableview, self._projectTablecell, GameUtil.handler(self._updateProjectCell, self), GameUtil.handler(self._clearProjectCell, self))
	self._priorityTableview = self:getGo("calculateInfo/priorityTableview")
	self._priorityTablecell = self:getGo("calculateInfo/priorityTableview/priorityTablecell")
	self._priorityTableList = ScrollerList.create(self._priorityTableview, self._priorityTablecell, GameUtil.handler(self._updatePriorityCell, self), GameUtil.handler(self._clearPriorityCell, self))
	self._btnCalculate = self:getGo("calculateInfo/btnCalculate")
	self._btnClear = self:getGo("attrInfo/resultBtns/btnClear")
	self._btnEquip = self:getGo("attrInfo/resultBtns/btnEquip")
	self._btnSetSuit = self:getGo("attrInfo/resultBtns/btnSetSuit")
	self._btnFilterSuit = self:getGo("calculateInfo/btnFilterSuit")
	self._txtFilterSuit = self:getTxt("calculateInfo/txtFilterSuit")
	self._btnSuit1 = self:getGo("calculateInfo/btnSuit1")
	self._btnSuit2 = self:getGo("calculateInfo/btnSuit2")
	self._txtSuit = self:getTxt("calculateInfo/txtSuit")
	self._btnPos2Attr = self:getGo("calculateInfo/btnPos2Attr")
	self._btnPos4Attr = self:getGo("calculateInfo/btnPos4Attr")
	self._txtPos2 = self:getTxt("calculateInfo/txtPos2")
	self._txtPos4 = self:getTxt("calculateInfo/txtPos4")
	self._calcSuitIconGo = self:getGo("calculateInfo/suitIcon")
	self._suitIcon = self:getGo("calculateInfo/suitIcon/icon")
	self._txtSuitName = self:getTxt("calculateInfo/txtName")
	self._txtSuitDesc = self:getTxt("calculateInfo/txtDesc")
	self._imgEmptySuit = self:getGo("calculateInfo/imgEmptySuit")
	self._protjectTips = self:getGo("protjectTips")
	self._adjustPosition = goutil.findChildComponent(self.mainGO, "protjectTips", "UIAdjustPosition")
	self._customInputProtjectTips = UICustomInput.Get(self:getGo("protjectTips"))
	self._txtProjectDetailPos2Attr = self:getTxt("protjectTips/txtPos2Attr")
	self._txtProjectDetailPos4Attr = self:getTxt("protjectTips/txtPos4Attr")
	self._projectDetailTableview = self:getGo("protjectTips/projectDetailTableview")
	self._projectDetailTablecell = self:getGo("protjectTips/projectDetailTableview/projectDetailTablecell")
	self._projectDetailTableList = ScrollerList.create(self._projectDetailTableview, self._projectDetailTablecell, GameUtil.handler(self._updateDetailCell, self), GameUtil.handler(self._clearDetailCell, self))
end

function HolyStripeRecommendCalcView:onExit()
	HolyStripeRecommendCalcView.super.onExit(self)
end

function HolyStripeRecommendCalcView:onEnter()
	self.addGEvent(self, GlobalNotify.HolyStripeSuitSelect, self._onSelectFilterSuit, self)
	HolyStripeRecommendCalcView.super.onEnter(self)

	self._curPetId = HolyStripeModel.instance:getCurrShowPetId()
	self._selectIndex = 0
	self._resultCache = {}
	self._forbidSuitIds = {}
	self._saveRecord = {}

	for i = 0, checknumber(HolyStripeConfig.instance:getParamsValue("MAX_RECOMMEND_CALCULATE")) do
		self._forbidSuitIds[i] = {}
	end

	self._mainAttrPriority = {}
	self._subAttrPriority = {}
	self._selectSuit = 0
	self._hasResult = false

	MaterialMgr.setCellByGId(MatType.Pet, self._curPetId, self._curPetCon)
	self:_onClickCur()
	GameUtil.SetActive(self._suitTableview, false)
	GameUtil.SetActive(self._subAttrTableview, false)
	GameUtil.SetActive(self._mainAttrTableview, false)
	GameUtil.SetActive(self._protjectTips, false)
	HolyStripeAgent.instance:sendPM_SuitGetInfoReq()
end

function HolyStripeRecommendCalcView:refreshLeftView()
	if self._selectIndex == 0 then
		self._changeGroupCurPet:SetState(1)
	else
		self._changeGroupCurPet:SetState(0)
	end

	local petMo = BagPetsController.instance:getPet(self._curPetId)
	local petCfg = CharacterConfig.instance:getPetCo(petMo:getDefineId())
	local suitList = HolyStripeModel.instance:getSuitListByPet(self._curPetId)
	local suitName = lang("无")
	local suitType = 0

	for i, v in ipairs(suitList) do
		if v.num >= 4 then
			suitType = v.suitType
		end
	end

	if suitType ~= 0 then
		local suitCfg = HolyStripeConfig.instance:getSuitInfo(suitType)

		suitName = suitCfg.name
	end

	self._txtCurEquip.text = langPara("%s\n当前套装：%s", petCfg.name, suitName)

	local list = {}

	for i = 1, checknumber(HolyStripeConfig.instance:getParamsValue("MAX_RECOMMEND_CALCULATE")) do
		table.insert(list, i)
	end

	self._projectTableList:reloadData(list)
end

function HolyStripeRecommendCalcView:refreshRightView()
	GameUtil.SetActive(self._curPetSelect, self._selectIndex == 0)
	GameUtil.SetActive(self._calculateInfo, self._selectIndex ~= 0 and not self._hasResult)
	GameUtil.SetActive(self._attrInfo, self._selectIndex == 0 or self._hasResult)
	GameUtil.SetActive(self._resultBtns, self._hasResult == true)

	if #self._forbidSuitIds[self._selectIndex] > 1 then
		self._txtFilterSuit.text = langPara("已排除%d个方案", #self._forbidSuitIds[self._selectIndex])
	elseif #self._forbidSuitIds[self._selectIndex] == 1 then
		local onlySuitId = self._forbidSuitIds[self._selectIndex][1]
		local suitMo = HolyStripeModel.instance:getSuitMo(onlySuitId)

		self._txtFilterSuit.text = suitMo.suitName
	else
		self._txtFilterSuit.text = lang("未选择")
	end

	local suitInfo = HolyStripeConfig.instance:getSuitInfo(self._selectSuit)

	if suitInfo.cfg then
		GameUtil.SetActive(self._calcSuitIconGo, true)

		self._txtSuit.text = suitInfo.name
		self._txtSuitName.text = suitInfo.name

		if suitInfo.cfg then
			MaterialMgr.setIcon(self._suitIcon, MatType.HolyStripe, suitInfo.cfg.id)
		end

		local suitCfg = HolyStripeConfig.instance:getSuitCfg(self._selectSuit, 2)

		self._txtSuitDesc.text = suitCfg.doc

		GameUtil.SetActive(self._imgEmptySuit, false)
	else
		MaterialMgr.resetAll(self._suitIcon)
		GameUtil.SetActive(self._calcSuitIconGo, false)
		GameUtil.SetActive(self._imgEmptySuit, true)

		self._txtSuit.text = lang("请选择")
		self._txtSuitName.text = lang("选择灵纹类型")
		self._txtSuitDesc.text = lang("未选择")
	end

	local pos2PropertyId = checknumber(self._mainAttrPriority[2])
	local pos2PropertyCfg = HolyStripeConfig.instance:getMainPropertyType(2, pos2PropertyId)

	self._txtPos2.text = pos2PropertyCfg and pos2PropertyCfg.doc or lang("未选择")

	local pos4PropertyId = checknumber(self._mainAttrPriority[4])
	local pos4PropertyCfg = HolyStripeConfig.instance:getMainPropertyType(4, pos4PropertyId)

	self._txtPos4.text = pos4PropertyCfg and pos4PropertyCfg.doc or lang("未选择")

	local list = {}

	for i = 1, checknumber(HolyStripeConfig.instance:getParamsValue("MAX_SUBATTR_PRIORITY")) do
		table.insert(list, i)
	end

	self._priorityTableList:reloadData(list)
	self:refreshAttrView()
	self:refreshSuitInfoView()
end

function HolyStripeRecommendCalcView:refreshAttrView()
	local holyStripes = self.wearMos
	local suitList = HolyStripeModel.instance:getSuitLitByEquipList(self.wearMos)
	local curAttrs = {}
	local attrList = HolyStripeModel.instance:getAttrListByMo(holyStripes, suitList)

	for i, v in ipairs(attrList) do
		curAttrs[v.type] = v.value
	end

	curAttrs[AttrMo.KEY_DIRECT_ZDL] = nil

	local attrData = {}

	for i, v in ipairs(HolyStripeModel.DefaultAttr) do
		curAttrs[v] = curAttrs[v] or 0
	end

	local index = 1

	for attrType, attrNum in pairs(curAttrs) do
		table.insert(attrData, {
			type = attrType,
			value = attrNum,
			name = ConstString.HolyStripeAttr[attrType],
			index = index
		})

		index = index + 1
	end

	local attrList = {}

	for i = 1, #attrData do
		if i % 2 == 1 then
			table.insert(attrList, {
				data1 = attrData[i],
				data2 = attrData[i + 1]
			})
		end
	end

	self._attrTableList:reloadData(attrList)
end

function HolyStripeRecommendCalcView:refreshSuitInfoView()
	local curSuitCountList = HolyStripeModel.instance:getSuitLitByEquipList(self.wearMos)

	self._curSuitDesc.text = ""

	goutil.setActive(self._curSuitIcon, false)
	MaterialMgr.resetAll(self._curSuitIcon)

	local isFindSuit = false

	for i, v in ipairs(curSuitCountList or {}) do
		if v.num >= 4 then
			local iconCfg = HolyStripeConfig.instance:getSuitInfo(v.suitType)

			MaterialMgr.setIcon(self._curSuitIcon, MatType.HolyStripe, iconCfg.cfg.id)

			self._curSuitDesc.text = langPara("%s：%s", iconCfg.name, v.doc)
			isFindSuit = true

			break
		end
	end

	if not isFindSuit then
		goutil.setActive(self._curSuitIcon, false)

		self._curSuitDesc.text = lang("未激活套装4件套效果")
	end

	local wearMos = self.wearMos

	for i, v in ipairs(self._posCellList) do
		self:_clearPosCell(i)
	end

	for i, mo in ipairs(wearMos) do
		self:_updatePosCell(mo:getPosType(), mo:getDefineId(), mo)
	end
end

function HolyStripeRecommendCalcView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameTxt1 = goutil.findChildTextComponent(go, "nameText1")
	local valueTxt1 = goutil.findChildTextComponent(go, "valueText1")
	local iconGo1 = goutil.findChild(go, "attr1")
	local icon1 = goutil.findChildComponent(go, "attr1", "UIImageSpriteChange")
	local txtNext = goutil.findChildTextComponent(go, "txtNextValue")
	local nextColorChange = goutil.findChildComponent(go, "txtNextValue", "UITextColorChange")
	local arrowGo = goutil.findChild(go, "imgArrow")
	local arrowChange = goutil.findChildComponent(go, "imgArrow", "UIImageSpriteChange")
	local imgBg = goutil.findChild(go, "imgBg")
	local nameTxt2 = goutil.findChildTextComponent(go, "nameText2")
	local valueTxt2 = goutil.findChildTextComponent(go, "valueText2")
	local iconGo2 = goutil.findChild(go, "attr2")
	local icon2 = goutil.findChildComponent(go, "attr2", "UIImageSpriteChange")

	GameUtil.SetActive(imgBg, data.data1.index % 4 == 1)

	if data.data1 then
		if data.data1.type then
			goutil.setActive(iconGo1, true)
			icon1:SetState(data.data1.type - 1)
		else
			goutil.setActive(iconGo1, false)
		end

		valueTxt1.text = data.data1.value > 0 and data.data1.value < 1 and string.format("%s%%", data.data1.value * 100) or data.data1.value
		nameTxt1.text = data.data1.name
	else
		nameTxt1.text = ""
		valueTxt1.text = ""

		goutil.setActive(iconGo1, false)
	end

	if data.data2 then
		if data.data2.type then
			goutil.setActive(iconGo2, true)
			icon2:SetState(data.data2.type - 1)
		else
			goutil.setActive(iconGo2, false)
		end

		valueTxt2.text = data.data2.value > 0 and data.data2.value < 1 and string.format("%s%%", data.data2.value * 100) or data.data2.value
		nameTxt2.text = data.data2.name
	else
		nameTxt2.text = ""
		valueTxt2.text = ""

		goutil.setActive(iconGo2, false)
	end

	GameUtil.SetActive(arrowGo, false)
	GameUtil.SetActive(txtNext, false)
end

function HolyStripeRecommendCalcView:_clearAttrCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function HolyStripeRecommendCalcView:_updatePosCell(index, defineId, mo)
	if self._posCellList[index] then
		local go = self._posCellList[index]
		local emptyGo = goutil.findChild(go, "img")
		local icon = goutil.findChild(go, "icon")
		local qualityGo = goutil.findChild(go, "quality")
		local quality = goutil.findChildComponent(go, "quality", "UIImageSpriteChange")

		GameUtil.rmClickHandler(go)

		if checknumber(defineId) > 0 then
			GameUtil.SetActive(emptyGo, false)
			GameUtil.SetActive(icon, true)
			GameUtil.SetActive(qualityGo, true)
			MaterialMgr.setIcon(icon, MatType.HolyStripe, defineId)

			local cfg = HolyStripeConfig.instance:getHolyStripeCfg(defineId)

			quality:SetState(cfg.quality)
			GameUtil.addClickHandler(go, function()
				CommonTipsMgr.instance:openMaterialTips(self.mainGo, MatType.HolyStripe, mo:getId(), mo)
			end)
		else
			GameUtil.SetActive(emptyGo, true)
			GameUtil.SetActive(qualityGo, false)
			GameUtil.SetActive(icon, false)
			MaterialMgr.resetAll(icon)
		end

		GameUtil.SetActive(go, checknumber(defineId) <= 0)
	end

	if self._posCellConList[index] then
		GameUtil.SetActive(self._posCellConList[index], checknumber(defineId) > 0)

		if checknumber(defineId) > 0 then
			local proxy = MaterialMgr.setCellByMo(mo, self._posCellConList[index])

			if proxy then
				proxy.binder:setNum(0)
			end
		else
			MaterialMgr.resetAll(self._posCellConList[index])
		end
	end
end

function HolyStripeRecommendCalcView:_clearPosCell(index)
	if self._posCellList[index] then
		local go = self._posCellList[index]
		local emptyGo = goutil.findChild(go, "img")
		local icon = goutil.findChild(go, "icon")
		local qualityGo = goutil.findChild(go, "quality")

		GameUtil.SetActive(emptyGo, true)
		GameUtil.SetActive(icon, false)
		GameUtil.SetActive(qualityGo, false)
		MaterialMgr.resetAll(icon)
	end

	if self._posCellConList[index] then
		MaterialMgr.resetAll(self._posCellConList[index])
	end
end

function HolyStripeRecommendCalcView:_updateProjectCell(view, cell, data, tag)
	local go = cell.gameObject
	local changeGroup = go:GetComponent(ComponentType.UIChangeGroup)
	local imgSelect = goutil.findChild(go, "imgSelect")
	local imgNotSelect = goutil.findChild(go, "imgNotSelect")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local suitCon = goutil.findChild(go, "suitCon")
	local emptySuit = goutil.findChild(go, "emptySuit")
	local btnDetail = goutil.findChild(go, "btnDetail")

	GameUtil.SetActive(imgSelect, data == self._selectIndex)
	GameUtil.SetActive(imgNotSelect, data ~= self._selectIndex)

	local petMo = BagPetsController.instance:getPet(self._curPetId)
	local mainAttr, subAttr, suitId = HolyStripeModel.instance:getRecommendCalculateSetting(petMo:getDefineId(), data)

	if data == self._selectIndex then
		suitId = self._selectSuit
	end

	MaterialMgr.resetAll(suitCon)

	if checknumber(suitId) ~= 0 then
		local iconCfg = HolyStripeConfig.instance:getSuitInfo(suitId)

		MaterialMgr.setIcon(suitCon, MatType.HolyStripe, iconCfg.cfg.id)
		GameUtil.SetActive(suitCon, true)
		GameUtil.SetActive(emptySuit, false)
	else
		GameUtil.SetActive(suitCon, false)
		GameUtil.SetActive(emptySuit, true)
	end

	if data == self._selectIndex then
		changeGroup:SetState(1)
	else
		changeGroup:SetState(0)
	end

	txtName.text = langPara("方案%s", GameUtil.getChineseNumber(data))

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickProject(data)
	end)
	GameUtil.rmClickHandler(btnDetail)
	GameUtil.addClickHandler(btnDetail, function()
		self:_onClickProjectDetail(go, data)
	end)
end

function HolyStripeRecommendCalcView:_clearProjectCell(cell)
	local go = cell.gameObject
	local suitCon = goutil.findChild(go, "suitCon")

	MaterialMgr.resetAll(suitCon)
	GameUtil.rmClickHandler(go)
end

function HolyStripeRecommendCalcView:_updateSuitCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local suitInfo = HolyStripeConfig.instance:getSuitInfo(data.type)
	local suitCfg = HolyStripeConfig.instance:getSuitCfg(data.type, 2)
	local uiChangeGroup = go:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = suitInfo.name

	if suitCfg then
		txtDesc.text = suitCfg.doc or ""
	end

	if suitInfo.cfg then
		MaterialMgr.setIcon(icon, MatType.HolyStripe, suitInfo.cfg.id)
	end

	if data.type % 2 == 0 then
		uiChangeGroup:SetState(0)
	else
		uiChangeGroup:SetState(1)
	end

	GameUtil.SetActive(imgSelect, data.type == self._selectSuit)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickSuitSelect(data.type)
	end)
end

function HolyStripeRecommendCalcView:_clearSuitCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function HolyStripeRecommendCalcView:_updateMainAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local imageColorChange = go:GetComponent(ComponentType.UIImageColorChange)

	if data.propertyId % 2 == 0 then
		imageColorChange:SetState(1)
	else
		imageColorChange:SetState(0)
	end

	txtName.text = data.doc

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickAttrByMain(data.propertyId)
	end)
end

function HolyStripeRecommendCalcView:_clearMainAttrCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function HolyStripeRecommendCalcView:_updateSubAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")
	local imageColorChange = go:GetComponent(ComponentType.UIImageColorChange)

	txtName.text = data.filterPropertyType

	if data.index % 2 == 0 then
		imageColorChange:SetState(1)
	else
		imageColorChange:SetState(0)
	end

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickSubAttr(data.id)
	end)
end

function HolyStripeRecommendCalcView:_clearSubAttrCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function HolyStripeRecommendCalcView:_updatePriorityCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtIndex = goutil.findChildTextComponent(go, "txtIndex")
	local filterCfg = HolyStripeConfig.instance:getFilterCfg(checknumber(self._subAttrPriority[data]))
	local posTagGo = goutil.findChild(go, "posTag")

	txtDesc.text = filterCfg and filterCfg.filterPropertyType or lang("未选择")
	txtIndex.text = langPara("%d、", data)

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickPriority(posTagGo, data)
	end)
end

function HolyStripeRecommendCalcView:_clearPriorityCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function HolyStripeRecommendCalcView:_updateDetailCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtIndex = goutil.findChildTextComponent(go, "txtIndex")
	local filterCfg = HolyStripeConfig.instance:getFilterCfg(checknumber(data.type))

	txtDesc.text = filterCfg and filterCfg.filterPropertyType or lang("未选择")
	txtIndex.text = langPara("%d、", data.index)
end

function HolyStripeRecommendCalcView:_clearDetailCell(cell)
	return
end

function HolyStripeRecommendCalcView:_onClickCur()
	self.wearMos = HolyStripeModel.instance:getEquippedByPetId(self._curPetId)
	self._selectIndex = 0
	self._hasResult = false

	self:refreshLeftView()
	self:refreshRightView()
end

function HolyStripeRecommendCalcView:_onClickProject(index)
	local petMo = BagPetsController.instance:getPet(self._curPetId)

	if self._selectIndex ~= 0 then
		HolyStripeModel.instance:saveRecommendCalculateSetting(self._mainAttrPriority, self._subAttrPriority, self._selectSuit, petMo:getDefineId(), self._selectIndex)
	end

	self._selectIndex = index

	local mainAttr, subAttr, suitId = HolyStripeModel.instance:getRecommendCalculateSetting(petMo:getDefineId(), self._selectIndex)

	if mainAttr and subAttr and suitId then
		self._mainAttrPriority = mainAttr
		self._subAttrPriority = subAttr
		self._selectSuit = suitId
	else
		self._mainAttrPriority = {}
		self._subAttrPriority = {}
		self._selectSuit = 0
	end

	if self._resultCache[self._selectIndex] then
		self.wearMos = self._resultCache[self._selectIndex]
		self._hasResult = true
	else
		self._hasResult = false
	end

	self:refreshLeftView()
	self:refreshRightView()
end

function HolyStripeRecommendCalcView:_onClickProjectDetail(go, index)
	local petMo = BagPetsController.instance:getPet(self._curPetId)

	GameUtil.SetActive(self._protjectTips, true)

	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(go)

	if pos then
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	end

	local main2Attr, main4Attr, subPriorityMap

	if index == self._selectIndex then
		main2Attr = checknumber(self._mainAttrPriority[2])
		main4Attr = self._mainAttrPriority[4]
		subPriorityMap = self._subAttrPriority
	else
		local mainAttr, subAttr, suitId = HolyStripeModel.instance:getRecommendCalculateSetting(petMo:getDefineId(), index)

		main2Attr = mainAttr and checknumber(mainAttr[2]) or 0
		main4Attr = mainAttr and checknumber(mainAttr[4]) or 0
		subPriorityMap = subAttr
	end

	local pos2PropertyId = checknumber(main2Attr)
	local pos2PropertyCfg = HolyStripeConfig.instance:getMainPropertyType(2, pos2PropertyId)

	self._txtProjectDetailPos2Attr.text = pos2PropertyCfg and pos2PropertyCfg.doc or lang("未选择")

	local pos4PropertyId = checknumber(main4Attr)
	local pos4PropertyCfg = HolyStripeConfig.instance:getMainPropertyType(4, pos4PropertyId)

	self._txtProjectDetailPos4Attr.text = pos4PropertyCfg and pos4PropertyCfg.doc or lang("未选择")

	local subPriority = {}

	for i = 1, checknumber(HolyStripeConfig.instance:getParamsValue("MAX_SUBATTR_PRIORITY")) do
		if checknumber(subPriorityMap[i]) > 0 then
			table.insert(subPriority, {
				type = subPriorityMap[i],
				index = #subPriority + 1
			})
		else
			table.insert(subPriority, {
				type = 0,
				index = #subPriority + 1
			})
		end
	end

	self._projectDetailTableList:reloadData(subPriority)
end

function HolyStripeRecommendCalcView:_onClickSelectDraw(hover)
	if not hover then
		GameUtil.SetActive(self._suitTableview, false)
		GameUtil.SetActive(self._subAttrTableview, false)
		GameUtil.SetActive(self._mainAttrTableview, false)
		GameUtil.SetActive(self._customInputProtjectTips, false)
	end
end

function HolyStripeRecommendCalcView:_onClickCalculate()
	if checknumber(self._mainAttrPriority[2]) <= 0 or checknumber(self._mainAttrPriority[4]) <= 0 then
		FloatWordMgr.instance:show(lang("未选择主属性"))

		return
	end

	if checknumber(self._selectSuit) <= 0 then
		FloatWordMgr.instance:show(lang("未选择目标套装"))

		return
	end

	local moList = {}
	local mainPrioity = self._mainAttrPriority
	local forbidMoIds = {}

	for i, suitId in ipairs(self._forbidSuitIds[self._selectIndex]) do
		local suitMo = HolyStripeModel.instance:getSuitMo(suitId)

		for j, holyStripeId in ipairs(suitMo.wearIds) do
			forbidMoIds[holyStripeId] = true
		end
	end

	for i, mo in ipairs(HolyStripeModel.instance:getExistHolyStripeMoList()) do
		if not forbidMoIds[mo:getId()] and (checknumber(mainPrioity[mo:getPosType()]) == 0 or mainPrioity[mo:getPosType()] == mo:getPropertyId()) then
			table.insert(moList, mo)
		end
	end

	local targetSuitId = self._selectSuit
	local subPriority = {}

	for i = 1, checknumber(HolyStripeConfig.instance:getParamsValue("MAX_SUBATTR_PRIORITY")) do
		if checknumber(self._subAttrPriority[i]) > 0 then
			local attrCfg = HolyStripeConfig.instance:getFilterCfg(self._subAttrPriority[i])

			table.insert(subPriority, attrCfg.filterPropertyType)
		end
	end

	local result = HolyStripeController.instance:calcHolyStripeSuitWithPriority(moList, targetSuitId, subPriority)
	local list = {}

	for i, v in pairs(result) do
		table.insert(list, v)
	end

	if #list == 0 then
		FloatWordMgr.instance:show(lang("无符合条件的套装，请修改条件后再试"))

		return
	end

	self._resultCache[self._selectIndex] = list
	self.wearMos = list
	self._hasResult = true

	self:refreshLeftView()
	self:refreshRightView()

	local petMo = BagPetsController.instance:getPet(self._curPetId)

	if self._selectIndex ~= 0 then
		HolyStripeModel.instance:saveRecommendCalculateSetting(self._mainAttrPriority, self._subAttrPriority, self._selectSuit, petMo:getDefineId(), self._selectIndex)
	end
end

function HolyStripeRecommendCalcView:_onClickClear()
	self._resultCache[self._selectIndex] = nil
	self._saveRecord[self._selectIndex] = nil
	self._hasResult = false

	self:refreshLeftView()
	self:refreshRightView()
end

function HolyStripeRecommendCalcView:_onClickClose()
	local hasTips = false

	for i, v in pairs(self._resultCache) do
		hasTips = true

		break
	end

	for i, v in pairs(self._forbidSuitIds) do
		if #v > 0 then
			hasTips = true

			break
		end
	end

	if hasTips == true then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("退出后将不再保存所选排除预设以及计算结果，是否退出"), function()
			local petMo = BagPetsController.instance:getPet(self._curPetId)

			if self._selectIndex ~= 0 then
				HolyStripeModel.instance:saveRecommendCalculateSetting(self._mainAttrPriority, self._subAttrPriority, self._selectSuit, petMo:getDefineId(), self._selectIndex)
			end

			self:close()
		end)
	else
		self:close()
	end
end

function HolyStripeRecommendCalcView:_onClickEquip()
	local list = {}
	local hasTips = false

	for i, mo in ipairs(self.wearMos) do
		if mo:getEquipPetId() ~= self._curPetId then
			table.insert(list, mo:getId())

			if mo:getEquipPetId() > 0 then
				hasTips = true
			end
		end
	end

	if hasTips == true then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("当前所选灵纹已装备在其他精灵身上，是否替换？"), function()
			HolyStripeController.instance:equipHolyStripes(self._curPetId, list)
			FloatWordMgr.instance:show(lang("已一键装备"))
		end)
	else
		HolyStripeController.instance:equipHolyStripes(self._curPetId, list)
		FloatWordMgr.instance:show(lang("已一键装备"))
	end
end

function HolyStripeRecommendCalcView:_onClickSetSuit()
	local suitGroupList = HolyStripeModel.instance:getSuitGroupList()

	if not suitGroupList or not suitGroupList[1] then
		FloatWordMgr.instance:show(lang("不存在预设组，不可新建预设"))

		return
	end

	if self._saveRecord[self._selectIndex] == true then
		FloatWordMgr.instance:show(lang("该套装已保存"))

		return
	end

	local list = {}

	for i, mo in ipairs(self.wearMos) do
		table.insert(list, mo:getId())
	end

	local targetGroup = suitGroupList[1]
	local petMo = BagPetsController.instance:getPet(self._curPetId)
	local petCfg = CharacterConfig.instance:getPetCo(petMo:getDefineId())
	local petNameArr = string.split(petCfg.name, "·")
	local name = langPara("%s%s", petNameArr[#petNameArr], GameUtil.getChineseNumber(self._selectIndex))

	HolyStripeAgent.instance:sendPM_ModifySuitReq(nil, name, targetGroup.groupId, list)
	FloatWordMgr.instance:show(langPara("已存为预设 %s ", name))

	self._saveRecord[self._selectIndex] = true
end

function HolyStripeRecommendCalcView:_onClickSuitSelect(suitId)
	self._selectSuit = suitId

	GameUtil.SetActive(self._suitTableview, false)
	self:refreshLeftView()
	self:refreshRightView()
end

function HolyStripeRecommendCalcView:_onClickFilterSuit()
	UIStateManager.instance:push(ViewName.HolyStripeSuitSelectView, self._forbidSuitIds[self._selectIndex])
end

function HolyStripeRecommendCalcView:_onSelectFilterSuit(list)
	self._forbidSuitIds[self._selectIndex] = list

	self:refreshRightView()
end

function HolyStripeRecommendCalcView:_onClickSuit()
	GameUtil.SetActive(self._suitTableview, true)

	local suitInfoCfgs = HolyStripeConfig.instance:getAllSuitInfo()

	self._suitTableList:reloadData(suitInfoCfgs)
end

function HolyStripeRecommendCalcView:_onClickPosAttr(go, posType)
	GameUtil.SetActive(self._mainAttrTableview, true)

	local anchoredPos = GameUtil.getAnchoredPos(go)

	GameUtil.setAnchoredPos(self._mainAttrTableview, anchoredPos.x, anchoredPos.y)

	self._curMainAttrPos = posType

	local cfgs = HolyStripeConfig.instance:getMainPropertyTypeCfgs(posType)

	self._mainAttrTableList:reloadData(cfgs)
end

function HolyStripeRecommendCalcView:_onClickAttrByMain(propertyId)
	self._mainAttrPriority[self._curMainAttrPos] = propertyId

	GameUtil.SetActive(self._mainAttrTableview, false)
	self:refreshRightView()
end

function HolyStripeRecommendCalcView:_onClickPriority(go, index)
	GameUtil.SetActive(self._subAttrTableview, true)

	local pos = GameUtil.getPos(go)

	GameUtil.setPos(self._subAttrTableview, pos.x, pos.y, pos.z)

	self._curSubAttrPos = index

	local cfgs = HolyStripeConfig.instance:getFilterCfgs()
	local list = {}
	local index = 1

	for i, v in ipairs(cfgs) do
		local isFind = false

		for k, id in pairs(self._subAttrPriority) do
			if v.id == id then
				isFind = true

				break
			end
		end

		if not isFind then
			table.insert(list, {
				filterPropertyType = v.filterPropertyType,
				id = v.id,
				index = index
			})

			index = index + 1
		end
	end

	table.insert(list, {
		id = 0,
		filterPropertyType = "空",
		index = index
	})
	self._subAttrTableList:reloadData(list)
end

function HolyStripeRecommendCalcView:_onClickSubAttr(id)
	if checknumber(id) == 0 then
		self._subAttrPriority[self._curSubAttrPos] = nil
	else
		self._subAttrPriority[self._curSubAttrPos] = id
	end

	GameUtil.SetActive(self._subAttrTableview, false)
	self:refreshRightView()
end

function HolyStripeRecommendCalcView:_onClickTip()
	local ruleList = {
		{
			desc = "1、选择【方案】，点击【灵纹类型】，选择合适精灵的灵纹类型；",
			url = "ui/bigbg/views/clearstargame/board_holystripe_rule1.png"
		},
		{
			desc = "2、选择【二号位属性】【四号位属性】类型，副属性的计算优先级，可筛选出来符合条件的灵纹；",
			url = "ui/bigbg/views/clearstargame/board_holystripe_rule2.png"
		},
		{
			desc = "3、选择【已收藏灵纹方案】，打开界面选择需要排除的灵纹",
			url = "ui/bigbg/views/clearstargame/board_holystripe_rule3.png"
		},
		{
			desc = "（已排除的灵纹方案不会进行计算，不选则将背包所有符合条件的灵纹进行计算）",
			url = "ui/bigbg/views/clearstargame/board_holystripe_rule4.png"
		}
	}

	TipsFacade.instance:openImageRuleView(ruleList, lang("说明规则"))
end

return HolyStripeRecommendCalcView
