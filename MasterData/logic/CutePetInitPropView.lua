-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetInitPropView.lua

module("logic.extensions.cutepet.view.CutePetInitPropView", package.seeall)

local CutePetInitPropView = class("CutePetInitPropView", ViewComponent)

function CutePetInitPropView:ctor()
	CutePetInitPropView.super.ctor(self)
end

function CutePetInitPropView:buildUI()
	CutePetInitPropView.super.buildUI(self)

	self._txtName = self:getTxt("basicInfo/cutePetName/txtName")
	self._txtLevel = self:getTxt("basicInfo/txtLevel")
	self._imgQualityChange = goutil.findChildComponent(self.mainGO, "basicInfo/imgQuality", "UIImageSpriteChange")
	self._imgType = goutil.findChildComponent(self.mainGO, "basicInfo/imgType", "UIImageSpriteChange")
	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("basicInfo/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "basicInfo/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._gRootRt = GlobalModel.instance.uiRoot:GetComponent(goutil.Type_RectTransform)
	self._attrTable = self:getGo("attrInfo/ScrollView")
	self._attrCell = self:getGo("attrInfo/attrCell")
	self._maxLevelCon = self:getGo("maxLevelCon")
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._coinCostInfo = self:getGo("coinCostInfo")
	self._levelCoinCon = self:getGo("coinCostInfo/con")
	self._txtCostCoin = self:getTxt("coinCostInfo/txtCost")
	self._txtCostColorChange = self._txtCostCoin:GetComponent(ComponentType.UITextColorChange)
	self._btnQuickLevelUp = self:getGo("btnQuickLevelUp")
	self._txtBntQuickLevelUp = self:getTxt("btnQuickLevelUp/txtCost")
	self._coinQuickCostInfo = self:getGo("coinQuickCostInfo")
	self._quickLevelCoinCon = self:getGo("coinQuickCostInfo/con")
	self._txtQuickCostCoin = self:getTxt("coinQuickCostInfo/txtCost")
	self._txtQuickCostColorChange = self._txtQuickCostCoin:GetComponent(ComponentType.UITextColorChange)
	self._btnRule = self:getGo("btnRule")
	self._goldBarCon = self:getGo("goldBarCon")
end

function CutePetInitPropView:bindEvents()
	CutePetInitPropView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnQuickLevelUp, self._onClickQuickLevelUp, self)
end

function CutePetInitPropView:unbindEvents()
	CutePetInitPropView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnQuickLevelUp)
end

function CutePetInitPropView:onExit()
	CutePetInitPropView.super.onExit(self)
	self._attrList:dispose()
	removetimer(self._refreshView, self)
end

function CutePetInitPropView:destroyUI()
	CutePetInitPropView.super.destroyUI(self)
end

function CutePetInitPropView:onEnter()
	CutePetInitPropView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.CutePetShowPetChange, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_StrengthInitialPropResp, self._handlePM_StrengthInitialPropResp, self)

	self._attrList = ScrollerList.create(self._attrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	self._attrList:regReloadFinish(GameUtil.handler(self._attrLoadFinish, self))

	self._isUp = false

	self:_refreshView()
end

function CutePetInitPropView:_refreshView()
	self._petId = CutePetModel.instance:GetCurPetId()
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)

	if not self._petMo then
		return
	end

	self:_refreshBasicInfo()
	self:_refreshAttr()
	self:_refreshCost()
end

function CutePetInitPropView:_refreshBasicInfo()
	local petTypeCfg = CutePetConfig.instance:getPetTypeCfg(self._petMo.config.type)

	self._imgQualityChange:SetState(self._petMo.curQuality - 1)
	self._imgType:SetState(self._petMo.config.type - 1)

	self._txtName.text = self._petMo.name
	self._txtLevel.text = string.format("%d", self._petMo.curLvl)
	self._maxStar = CutePetConfig.instance:getMaxStar(self._petMo.config.starUpPlan, self._petMo.curQuality)

	for i = 1, #self._starList do
		if i <= self._petMo.curStar then
			self._starList[i].starChange:SetState(0)
		else
			self._starList[i].starChange:SetState(1)
		end

		if i <= self._maxStar then
			GameUtil.SetActive(self._starList[i].star, true)
		else
			GameUtil.SetActive(self._starList[i].star, false)
		end
	end
end

function CutePetInitPropView:_refreshAttr()
	self._propCfg = CutePetConfig.instance:getInitPropCfgs(self._petMo.config.initPropertyPlan)

	local canChangePropMap = {}

	for i, v in pairs(self._propCfg) do
		if v.strengthRandomRange and v.strengthRandomRange[1] and v.strengthRandomRange[2] then
			canChangePropMap[FightingPowerFormula.instance:getAttrTypeByName(v.propertyType)] = v.propertyType
		end
	end

	local showList = {}
	local maxInitialProps = self._petMo:calcAttr(nil, nil, nil, true)
	local attrSort = self._petMo:getSortAttrList()

	for i, v in ipairs(attrSort) do
		if not string.nilorempty(canChangePropMap[v]) then
			table.insert(showList, {
				typeName = canChangePropMap[v],
				attrType = v,
				num = self._petMo.attr[v],
				maxNum = maxInitialProps[v]
			})
		end
	end

	self._isCanStrength = false

	for i, data in ipairs(showList) do
		local range = self._propCfg[data.typeName].genRange
		local maxProp = range[2]
		local typeIndex = FightingPowerFormula.instance:getAttrTypeByName(data.typeName)
		local petValue = self._petMo:getInitProp(typeIndex)

		if petValue < maxProp then
			self._isCanStrength = true

			break
		end
	end

	self._attrList:reloadData(showList)
end

function CutePetInitPropView:_refreshCost()
	GameUtil.SetActive(self._btnQuickLevelUp, self._isCanStrength)
	GameUtil.SetActive(self._btnLevelUp, self._isCanStrength)
	GameUtil.SetActive(self._coinCostInfo, self._isCanStrength)
	GameUtil.SetActive(self._coinQuickCostInfo, self._isCanStrength)
	GameUtil.SetActive(self._maxLevelCon, not self._isCanStrength)

	self._quickTime = CutePetConfig.instance:getCommonValue("QuickStrengeInitPropTime", true)

	local matType, matId, matNum = MaterialMgr.getMatParams(CutePetConfig.instance:getCommonValue("CutePetStrengthenInitialPropCost", false))

	MaterialMgr.setIcon(self._levelCoinCon, matType, matId)

	local ownNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._txtCostCoin.text = string.format("%d", matNum)

	if ownNum < matNum then
		self._txtCostColorChange:SetState(0)
	else
		self._txtCostColorChange:SetState(1)
	end

	self._quickTime = math.min(self._quickTime, math.floor(ownNum / matNum))

	if self._quickTime < 1 then
		self._quickTime = CutePetConfig.instance:getCommonValue("QuickStrengeInitPropTime", true)
	end

	MaterialMgr.setIcon(self._quickLevelCoinCon, matType, matId)

	self._txtQuickCostCoin.text = string.format("%d", matNum * self._quickTime)

	if ownNum < matNum * self._quickTime then
		self._txtQuickCostColorChange:SetState(0)
	else
		self._txtQuickCostColorChange:SetState(1)
	end

	self._txtBntQuickLevelUp.text = langPara("培养%d次", self._quickTime)

	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = CutePetConfig.instance:getCommonValue("CutePetStrengthenInitialPropCost", false)
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function CutePetInitPropView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local typeChange = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(go, "txtType")
	local tableView = goutil.findChild(go, "silde")
	local slider = Framework.SliderAdapter.GetFrom(go, "sliderProgress")
	local txtGrade = goutil.findChildTextComponent(go, "txtQuality")
	local gradeColorChange = goutil.findChildComponent(go, "txtQuality", "UITextColorChange")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtAddNum = goutil.findChildTextComponent(go, "txtAddNum")

	txtName.text = data.typeName

	local gradingCfg = CutePetConfig.instance:getPropertyGradingCfg(data.typeName)
	local range = self._propCfg[data.typeName].genRange
	local minProp = range[1]
	local maxProp = range[2]
	local typeIndex = FightingPowerFormula.instance:getAttrTypeByName(data.typeName)

	typeChange:SetState(typeIndex - 1)

	local petValue = self._petMo:getInitProp(typeIndex)
	local petRate = (petValue - minProp) / (maxProp - minProp)
	local list = {}
	local width = GameUtil.getWidth(tableView)

	for i, v in ipairs(gradingCfg) do
		if maxProp >= v.genRange[2] then
			local rate = (v.genRange[2] - minProp) / (maxProp - minProp)

			table.insert(list, rate * width)
		end

		if petValue >= v.genRange[1] then
			curGrade = v.distId
		end
	end

	txtGrade.text = gradingCfg[curGrade].grade

	gradeColorChange:SetState(gradingCfg[curGrade].color - 1)
	slider:SetValue(petRate)

	txtNum.text = string.format("%d/%d", petValue, maxProp)

	if self._isUp == true and self._addProp[typeIndex] then
		GameUtil.SetActive(txtAddNum, true)

		txtAddNum.text = string.format("+%d", self._addProp[typeIndex])
	else
		GameUtil.SetActive(txtAddNum, false)
	end
end

function CutePetInitPropView:_clearAttrCell(cell)
	return
end

function CutePetInitPropView:_resetAttrDividingLine(cell, data, index)
	local go = cell.mainGO

	GameUtil.setAnchoredPos(go, data, 0)
end

function CutePetInitPropView:_attrLoadFinish()
	self._isUp = false
end

function CutePetInitPropView:_onClickQuickLevelUp()
	self._tempAttrList = {}

	for i, v in pairs(self._petMo.attr) do
		self._tempAttrList[i] = v
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(CutePetConfig.instance:getCommonValue("CutePetStrengthenInitialPropCost", false))

	if MaterialModel.instance:IsEnough(matType, matId, matNum * self._quickTime) == true then
		CutePetGardenAgent.instance:sendPM_StrengthInitialPropReq(self._petId, self._quickTime)
	else
		FloatWordMgr.instance:show(lang("所需材料不足"))
	end
end

function CutePetInitPropView:_onClickLevelUp()
	self._tempAttrList = {}

	for i, v in pairs(self._petMo.attr) do
		self._tempAttrList[i] = v
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(CutePetConfig.instance:getCommonValue("CutePetStrengthenInitialPropCost", false))

	if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
		CutePetGardenAgent.instance:sendPM_StrengthInitialPropReq(self._petId, 1)
	else
		FloatWordMgr.instance:show(lang("所需材料不足"))
	end
end

function CutePetInitPropView:_onClickClose()
	self:close()
end

function CutePetInitPropView:_onClickRule()
	TipsFacade.instance:openRulesView("cute_pet_level_up_rule")
end

function CutePetInitPropView:_handlePM_StrengthInitialPropResp(msg)
	self._addProp = {}

	for i, v in ipairs(msg.addProp or {}) do
		self._addProp[v.propClientIndex] = v.propValue
	end

	self._isUp = true

	self:_refreshView()
	removetimer(self._refreshView, self)
	settimer(3, self._refreshView, self, false)
end

return CutePetInitPropView
