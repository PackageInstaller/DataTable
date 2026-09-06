-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetLevelUpView.lua

module("logic.extensions.cutepet.view.CutePetLevelUpView", package.seeall)

local CutePetLevelUpView = class("CutePetLevelUpView", ViewComponent)

function CutePetLevelUpView:ctor()
	CutePetLevelUpView.super.ctor(self)
end

function CutePetLevelUpView:buildUI()
	CutePetLevelUpView.super.buildUI(self)

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
	self._costInfo = self:getGo("costInfo")
	self._costView = self:getGo("costInfo/itemcon")
	self._costCell = self:getGo("costInfo/itemcon/item")
	self._costList = ItemGroup.New(self._costView, self._costCell)
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

function CutePetLevelUpView:bindEvents()
	CutePetLevelUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnQuickLevelUp, self._onClickQuickLevelUp, self)
end

function CutePetLevelUpView:unbindEvents()
	CutePetLevelUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnQuickLevelUp)
end

function CutePetLevelUpView:onExit()
	CutePetLevelUpView.super.onExit(self)
	self._attrList:dispose()
	self._costList:dispose(self._clearCostCell, self)

	for i, v in pairs(self._replaceEffHandler) do
		UIEffectManager.instance:stopEffect(v)
	end

	removetimer(self._autoClickLevelUp, self)
end

function CutePetLevelUpView:destroyUI()
	CutePetLevelUpView.super.destroyUI(self)
end

function CutePetLevelUpView:onEnter()
	CutePetLevelUpView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetLvlUpResp, self._PM_CutePetLvlUpResp, self)
	self.addGEvent(self, GlobalNotify.CutePetShowPetChange, self._refreshView, self)

	self._attrList = ScrollerList.create(self._attrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	self._attrList:regReloadFinish(GameUtil.handler(self._onListReloadFinish, self))

	self._isUp = false
	self._replaceEffHandler = {}

	self:_refreshView()
end

function CutePetLevelUpView:_refreshView()
	self._petId = CutePetModel.instance:GetCurPetId()
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)

	if not self._petMo then
		return
	end

	self:_refreshBasicInfo()
	self:_refreshAttrInfo()
	self:_refreshCostInfo()
end

function CutePetLevelUpView:_refreshBasicInfo()
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

function CutePetLevelUpView:_refreshAttrInfo()
	self._maxLevel = #CutePetConfig.instance:getLevelUpCfgs(self._petMo.config.lvlUpPlan)

	local attr = {}
	local result = {}

	result = self._petMo.curLvl < self._maxLevel and self._petMo:calcAttr(nil, self._petMo.curLvl + 1, nil) or self._petMo.attr

	local attrSort = self._petMo:getSortAttrList(result)

	for i, v in ipairs(attrSort) do
		local nextNum = result[v]
		local nowNum = checknumber(self._petMo.attr[v])

		if nextNum ~= nowNum and nowNum ~= 0 or self._petMo.curLvl == self._maxLevel then
			table.insert(attr, {
				attrType = v,
				nextNum = nextNum,
				nowNum = nowNum
			})
		end
	end

	for i, v in ipairs(attr) do
		v.index = i
	end

	self._attrList:reloadData(attr)

	if _attrList and #_attrList > 0 then
		self._attrList:MoveCellToCenter(#_attrList)
	end
end

function CutePetLevelUpView:_refreshCostInfo()
	self._costList:dispose(self._clearCostCell, self)
	MaterialMgr.resetAll(self._levelCoinCon)
	MaterialMgr.resetAll(self._quickLevelCoinCon)

	self._txtCostCoin.text = ""
	self._txtQuickCostCoin.text = ""

	if self._petMo.curLvl < self._maxLevel then
		GameUtil.SetActive(self._costInfo, false)
		GameUtil.SetActive(self._btnLevelUp, true)
		GameUtil.SetActive(self._btnQuickLevelUp, true)
		GameUtil.SetActive(self._coinCostInfo, true)
		GameUtil.SetActive(self._coinQuickCostInfo, true)
		GameUtil.SetActive(self._maxLevelCon, false)

		local needLv = self._maxLevel - self._petMo.curLvl
		local onceLv = math.min(CutePetConfig.instance:getCommonValue("QuickLevelUpTime", true), needLv)
		local levelUpCfg = CutePetConfig.instance:getLevelUpCfg(self._petMo.config.lvlUpPlan, self._petMo.curLvl + 1)
		local costStr = string.split(levelUpCfg.materialCost, "#")

		self._costList:updateWithMoArray(costStr, self._updateCostCell, self)

		local costCoin = costStr[1]

		if costCoin then
			local matType, matId, matNum = MaterialMgr.getMatParams(costCoin)

			MaterialMgr.setIcon(self._levelCoinCon, matType, matId)

			local ownNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			self._txtCostCoin.text = string.format("%d", matNum)

			if ownNum < matNum then
				self._txtCostColorChange:SetState(0)
			else
				self._txtCostColorChange:SetState(1)
			end
		end

		local levelUpMaterialCostCfgList = {}

		for i = 1, onceLv do
			local levelUpCfg = CutePetConfig.instance:getLevelUpCfg(self._petMo.config.lvlUpPlan, self._petMo.curLvl + i)

			table.insert(levelUpMaterialCostCfgList, levelUpCfg.materialCost)
		end

		costStr = MaterialMgr.combineItemsToList(levelUpMaterialCostCfgList)
		costCoin = costStr[1]

		if costStr[1] then
			local matType, matId, matNum = MaterialMgr.getMatParams(costCoin)
			local ownNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			MaterialMgr.setIcon(self._quickLevelCoinCon, matType, matId)

			self._txtQuickCostCoin.text = string.format("%d", matNum)

			if ownNum < matNum then
				self._txtQuickCostColorChange:SetState(0)
			else
				self._txtQuickCostColorChange:SetState(1)
			end
		end

		self._txtBntQuickLevelUp.text = langPara("提升%d级", onceLv)
	else
		GameUtil.SetActive(self._coinCostInfo, false)
		GameUtil.SetActive(self._coinQuickCostInfo, false)
		GameUtil.SetActive(self._costInfo, false)
		GameUtil.SetActive(self._btnLevelUp, false)
		GameUtil.SetActive(self._btnQuickLevelUp, false)
		GameUtil.SetActive(self._maxLevelCon, true)
	end

	local goldBarLevelUpCfg = CutePetConfig.instance:getLevelUpCfg(self._petMo.config.lvlUpPlan, 2)
	local goldBarCostStr = string.split(goldBarLevelUpCfg.materialCost, "#")
	local goldBarCostCoin = goldBarCostStr[1]
	local btn_list = {}

	if goldBarCostCoin then
		table.insert(btn_list, {
			showAdd = true,
			id = goldBarCostCoin
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function CutePetLevelUpView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgChange = go:GetComponent(ComponentType.UIImageColorChange)
	local txtName = goutil.findChildTextComponent(go, "txtType")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtNumNext = goutil.findChildTextComponent(go, "txtNumNext")
	local imgNext = goutil.findChild(go, "imgNext")
	local typeChange = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")

	typeChange:SetState(data.attrType - 1)

	txtNum.text = data.nowNum >= 1 and string.format("%d", math.floor(data.nowNum)) or string.format("%.2f%%", data.nowNum * 100)

	if data.nextNum == data.nowNum then
		GameUtil.SetActive(txtNumNext, false)
		GameUtil.SetActive(imgNext, false)
	else
		GameUtil.SetActive(txtNumNext, true)
		GameUtil.SetActive(imgNext, true)

		txtNumNext.text = data.nextNum >= 1 and string.format("%d", math.floor(data.nextNum)) or string.format("%.2f%%", data.nextNum * 100)
	end

	bgChange:SetState(data.index % 2)

	txtName.text = GameEnum.AttrTypeName[data.attrType]

	if self._isUp == true then
		if self._replaceEffHandler[go] then
			UIEffectManager.instance:stopEffect(self._replaceEffHandler[go])

			self._replaceEffHandler[go] = nil
		end

		local effName = "20230728/chongwuyuan/fx_ui_chongwuyuan_saoguang.prefab"

		self._replaceEffHandler[go] = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, nil, function()
			self._replaceEffHandler[go]:setClipping(self._gRootRt)
		end)

		self._replaceEffHandler[go]:setParent(go.transform)
		self._replaceEffHandler[go]:setLocalPos(0, 0, 0)
		self._replaceEffHandler[go]:setScale(1)

		self._replaceEffHandler[go].hideEffWhileNotOnTop = false
	elseif self._replaceEffHandler[go] then
		UIEffectManager.instance:stopEffect(self._replaceEffHandler[go])

		self._replaceEffHandler[go] = nil
	end
end

function CutePetLevelUpView:_clearAttrCell(cell)
	local go = cell.gameObject

	if self._replaceEffHandler[go] then
		UIEffectManager.instance:stopEffect(self._replaceEffHandler[go])

		self._replaceEffHandler[go] = nil
	end
end

function CutePetLevelUpView:_updateCostCell(item, data, i)
	local go = item.mainGO
	local con = goutil.findChild(go, "con")
	local imgAdd = goutil.findChild(go, "img_add")
	local txtCost = goutil.findChildTextComponent(go, "txtCost")
	local txtColorChange = goutil.findChildComponent(go, "txtCost", "UITextColorChange")
	local proxy = MaterialMgr.setCellByCfg(data, con)
	local matType, id, needNum = MaterialMgr.getMatParams(data)
	local hasNum = MaterialModel.instance:getMaterialsNumber(matType, id)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setNum(0)
		proxy:setCallBack(function()
			if hasNum < needNum then
				MaterialMgr.openGetSource(matType, id)
			else
				CommonTipsMgr.instance:openMaterialTips(con, matType, id, 0)
			end
		end)
	end

	GameUtil.SetActive(imgAdd, hasNum < needNum)

	if hasNum < needNum then
		txtColorChange:SetState(0)
	else
		txtColorChange:SetState(1)
	end

	txtCost.text = string.format("%d <color=#263047FF>/%d</color>", hasNum, needNum)
end

function CutePetLevelUpView:_clearCostCell(item)
	local go = item.mainGO
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function CutePetLevelUpView:_onClickQuickLevelUp()
	local needLv = self._maxLevel - self._petMo.curLvl
	local onceLv = math.min(CutePetConfig.instance:getCommonValue("QuickLevelUpTime", true), needLv)
	local levelUpMaterialCostCfgList = {}

	for i = 1, onceLv do
		local levelUpCfg = CutePetConfig.instance:getLevelUpCfg(self._petMo.config.lvlUpPlan, self._petMo.curLvl + i)

		if levelUpCfg then
			table.insert(levelUpMaterialCostCfgList, levelUpCfg.materialCost)
		end
	end

	if #levelUpMaterialCostCfgList > 0 then
		local costStr = MaterialMgr.combineItemsToList(levelUpMaterialCostCfgList)

		for i, v in ipairs(costStr or {}) do
			local matType, id, needNum = MaterialMgr.getMatParams(v)

			if MaterialModel.instance:IsEnough(matType, id, needNum) == false then
				MaterialMgr.openGetSource(matType, id)
				removetimer(self._autoClickLevelUp, self)

				return
			end
		end
	else
		FloatWordMgr.instance:show(lang("已满级"))
		removetimer(self._autoClickLevelUp, self)

		return
	end

	CutePetGardenAgent.instance:sendPM_CutePetLvlUpReq(self._petId, onceLv)
end

function CutePetLevelUpView:_onClickLevelUp()
	local levelUpCfg = CutePetConfig.instance:getLevelUpCfg(self._petMo.config.lvlUpPlan, self._petMo.curLvl + 1)

	if levelUpCfg then
		local costStr = string.split(levelUpCfg.materialCost, "#")

		for i, v in ipairs(costStr or {}) do
			local matType, id, needNum = MaterialMgr.getMatParams(v)

			if MaterialModel.instance:IsEnough(matType, id, needNum) == false then
				MaterialMgr.openGetSource(matType, id)
				removetimer(self._autoClickLevelUp, self)

				return
			end
		end
	else
		FloatWordMgr.instance:show(lang("已满级"))
		removetimer(self._autoClickLevelUp, self)

		return
	end

	CutePetGardenAgent.instance:sendPM_CutePetLvlUpReq(self._petId, 1)
end

function CutePetLevelUpView:_onClickClose()
	self:close()
end

function CutePetLevelUpView:_onListReloadFinish()
	self._isUp = false
end

function CutePetLevelUpView:_PM_CutePetLvlUpResp()
	self._isUp = true

	self:_refreshView()
end

function CutePetLevelUpView:_onClickRule()
	TipsFacade.instance:openRulesView("cute_pet_level_up_rule")
end

return CutePetLevelUpView
