-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetStarUpView.lua

module("logic.extensions.cutepet.view.CutePetStarUpView", package.seeall)

local CutePetStarUpView = class("CutePetStarUpView", ViewComponent)

function CutePetStarUpView:ctor()
	CutePetStarUpView.super.ctor(self)
end

function CutePetStarUpView:buildUI()
	CutePetStarUpView.super.buildUI(self)

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

	self._txtSkillStar = self:getTxt("assistanceSkill/star/txt")
	self._attrTable = self:getGo("attrInfo/ScrollView")
	self._attrCell = self:getGo("attrInfo/attrCell")
	self._costInfo = self:getGo("costInfo")
	self._costView = self:getGo("costInfo/itemcon")
	self._costCell = self:getGo("costInfo/item")
	self._costList = ItemGroup.New(self._costView, self._costCell)
	self._txtAssSkill = self:getTxt("assistanceSkill/ScrollView/Viewport/txtDesc")
	self._assSkillStarList = {}

	for i = 1, 6 do
		table.insert(self._assSkillStarList, {
			star = self:getGo("assistanceSkill/starLv/star_" .. i)
		})
	end

	self._maxStarCon = self:getGo("maxStarCon")
	self._btnStarUp = self:getBtn("btnStarUp")
	self._btnOneKey = self:getGo("btnOneKey")
	self._maxStarTips = self:getGo("maxStarTips")
	self._btnRule = self:getGo("btnRule")
	self._txtCanCost = self:getTxt("costInfo/txtCanCost")
	self._skillIntroduce = self:getGo("skillIntroduce")
	self._btnSkillClose = self:getGo("skillIntroduce/btnClose")
	self._btnSkillIntro = self:getGo("btnSkillIntro")
	self._skillTable = self:getGo("skillIntroduce/starSkill/ScrollView")
	self._skillCell = self:getGo("skillIntroduce/starSkill/skillCell")
	self._skillSizeImmediate = goutil.findChildComponent(self._skillCell, "bg", "ContentSizeImmediate")
	self._skillList = ScrollerList.create(self._skillTable, self._skillCell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))

	self._skillList:regReloadFinish(GameUtil.handler(self._skillReloadFinish, self))
	self._skillList:regGetCellSize(GameUtil.handler(self._skillCellSize, self))
end

function CutePetStarUpView:bindEvents()
	CutePetStarUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStarUp, self._onClickStarUp, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnSkillIntro, self._onClickSkillIntro, self)
	GameUtil.addClickHandler(self._btnSkillClose, self._onClickSkillClose, self)
end

function CutePetStarUpView:unbindEvents()
	CutePetStarUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStarUp, self._onClickStarUp, self)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnSkillIntro)
	GameUtil.rmClickHandler(self._btnSkillClose)
end

function CutePetStarUpView:onExit()
	CutePetStarUpView.super.onExit(self)
	self._costList:dispose(self._clearCostCell, self)
	self._skillList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_CutePetStarUpResp, self._PM_CutePetStarUpResp, self)

	self._selectPetId = {}
	self._curShowCutePetMo = nil
end

function CutePetStarUpView:destroyUI()
	CutePetStarUpView.super.destroyUI(self)
end

function CutePetStarUpView:onEnter()
	CutePetStarUpView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_CutePetStarUpResp, self._PM_CutePetStarUpResp, self)
	self.addGEvent(self, GlobalNotify.CutePetShowPetChange, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.CutePetStarUpViewRefresh, self._refreshView, self)

	self._attrList = ScrollerList.create(self._attrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	GameUtil.SetActive(self._skillIntroduce, false)
	self:_refreshView()

	self._toggleKey = "CutePetStarUpView"
end

function CutePetStarUpView:_refreshView()
	self._petId = CutePetModel.instance:GetCurPetId()
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)
	self._curShowCutePetMo = self._petMo
	self._initProps = self._curShowCutePetMo:getInitialActiveProps()
	self._checkSure = false

	if not self._petMo then
		return
	end

	self:_refreshBasicInfo()
	self:_refreshAttrInfo()
	self:_refreshSkillInfo()
	self:_refreshCostInfo()
	self:_refreshCanCostPetTxt()
end

function CutePetStarUpView:_refreshBasicInfo()
	local petTypeCfg = CutePetConfig.instance:getPetTypeCfg(self._petMo.config.type)

	self._imgQualityChange:SetState(self._petMo.curQuality - 1)

	self._txtName.text = self._petMo.name
	self._txtLevel.text = string.format("%s", self._petMo.curLvl)
	self._maxStar = CutePetConfig.instance:getMaxStar(self._petMo.config.starUpPlan, self._petMo.curQuality)

	self._imgType:SetState(self._petMo.config.type - 1)

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

function CutePetStarUpView:_refreshAttrInfo()
	local attr = {}
	local result = {}

	result = self._petMo.curStar < self._maxStar and self._petMo:calcAttr(nil, nil, self._petMo.curStar + 1) or self._petMo.attr

	local attrSort = self._petMo:getSortAttrList(result)

	for i, v in ipairs(attrSort) do
		local nextNum = result[v]
		local nowNum = checknumber(self._petMo.attr[v])

		if nextNum ~= nowNum and nowNum ~= 0 or self._petMo.curStar == self._maxStar then
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

function CutePetStarUpView:_refreshSkillInfo()
	local showStar = self._petMo.curStar + 1

	if showStar > self._maxStar then
		showStar = self._maxStar
	end

	local starSkillCfg = CutePetConfig.instance:getStarSkillCfg(self._petMo.raceId, showStar)

	self._txtAssSkill.text = starSkillCfg.starBuffsDesc

	for i = 1, 6 do
		if i <= showStar then
			GameUtil.SetActive(self._assSkillStarList[i].star, true)
		else
			GameUtil.SetActive(self._assSkillStarList[i].star, false)
		end
	end

	self._txtSkillStar.text = showStar
end

function CutePetStarUpView:_refreshCostInfo()
	GameUtil.SetActive(self._costInfo, self._petMo.curStar < self._maxStar)
	GameUtil.SetActive(self._btnStarUp, self._petMo.curStar < self._maxStar)
	GameUtil.SetActive(self._btnOneKey, self._petMo.curStar < self._maxStar)
	GameUtil.SetActive(self._maxStarCon, self._petMo.curStar >= self._maxStar)

	local starList = CutePetConfig.instance:getStarUpCfgs(self._petMo.config.starUpPlan)

	GameUtil.SetActive(self._maxStarTips, self._petMo.curStar >= self._maxStar and #starList > self._maxStar)

	self._costMatData = {}

	local result = {}

	if self._petMo.curStar < self._maxStar then
		local starUpCfg = CutePetConfig.instance:getStarUpCfg(self._petMo.config.starUpPlan, self._petMo.curStar + 1)

		self._selectPetId = self._selectPetId or {}
		self._selectPetId[self._petMo.raceId] = self._selectPetId[self._petMo.raceId] or {}

		table.insert(result, {
			raceId = self._petMo.raceId,
			selectPetId = self._selectPetId[self._petMo.raceId],
			needCount = starUpCfg.costCutePetCount
		})

		self._needCount = starUpCfg.costCutePetCount

		if not string.nilorempty(starUpCfg.materialCost) then
			local costStr = string.split(starUpCfg.materialCost, "#")

			for i, v in ipairs(costStr or {}) do
				table.insert(result, {
					str = v
				})
			end
		end

		if self._needCount < #self._selectPetId[self._petMo.raceId] then
			local needToDelete = #self._selectPetId[self._petMo.raceId] - self._needCount

			for i = 1, needToDelete do
				table.remove(self._selectPetId[self._petMo.raceId], #self._selectPetId[self._petMo.raceId])
			end
		end
	end

	self._costList:updateWithMoArray(result, self._updateCostCell, self)
end

function CutePetStarUpView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgChange = go:GetComponent(ComponentType.UIImageColorChange)
	local txtName = goutil.findChildTextComponent(go, "txtType")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtNumNext = goutil.findChildTextComponent(go, "txtNumNext")
	local imgNext = goutil.findChild(go, "imgNext")
	local typeChange = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")

	typeChange:SetState(data.attrType - 1)

	txtNum.text = data.nowNum >= 1 and string.format("%s", math.floor(data.nowNum)) or string.format("%.2f%%", data.nowNum * 100)

	if data.nextNum == data.nowNum then
		GameUtil.SetActive(txtNumNext, false)
		GameUtil.SetActive(imgNext, false)
	else
		GameUtil.SetActive(txtNumNext, true)
		GameUtil.SetActive(imgNext, true)

		txtNumNext.text = data.nextNum >= 1 and string.format("%s", math.floor(data.nextNum)) or string.format("%.2f%%", data.nextNum * 100)
	end

	bgChange:SetState(data.index % 2)

	txtName.text = GameEnum.AttrTypeName[data.attrType]
end

function CutePetStarUpView:_clearAttrCell(cell)
	return
end

function CutePetStarUpView:_updateCostCell(item, data, i)
	local costData = {}
	local go = item.mainGO
	local con = goutil.findChild(go, "con")
	local imgAdd = goutil.findChild(go, "img_add")
	local txtCost = goutil.findChildTextComponent(go, "txtCost")
	local txtColorChange = goutil.findChildComponent(go, "txtCost", "UITextColorChange")
	local btnAdd = GameUtil.asBtn(goutil.findChild(go, "btnAdd"))

	GameUtil.SetActive(btnAdd, false)

	local hasNum, needNum = 0, 0

	if not string.nilorempty(data.str) then
		local proxy = MaterialMgr.setCellByCfg(data.str, con)
		local matType, id = 0, 0

		matType, id, needNum = MaterialMgr.getMatParams(data.str)
		hasNum = MaterialModel.instance:getMaterialsNumber(matType, id)

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
	elseif checknumber(data.raceId) > 0 then
		local raceCfg = CutePetConfig.instance:getCutePetById(data.raceId)
		local proxy = MaterialMgr.setCellByCfg(table.concat({
			MatType.CutePet,
			data.raceId
		}, ":"), con)

		if proxy then
			proxy.binder:setAutoTips(false)
		end

		needNum = data.needCount
		hasNum = #data.selectPetId

		GameUtil.SetActive(btnAdd, true)

		local function filterFunc(id)
			local mo = CutePetModel.instance:getCutePeMo(id)

			return mo.raceId == data.raceId and mo.id ~= self._petMo.id
		end

		self._filterFunc = filterFunc

		local title = lang("宠物选择")
		local descStr = langPara("选择#count#只%s作为材料消耗（处于庇护精灵或冒险协会中除外），返还%s#rate#养成材料", raceCfg.name, CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true) * 100)

		descStr = string.gsub(descStr, "#count#", "%%s")
		descStr = string.gsub(descStr, "#rate#", "%%%%")

		local function descChangeFunc(selectIds)
			local descStrList = {
				langPara("选择#count#只%s作为材料消耗（处于庇护精灵或冒险协会中除外），返还%s#rate#养成材料", raceCfg.name, CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true) * 100),
				(langPara("选择#count#只%s作为材料消耗（处于庇护精灵或冒险协会中除外），返还%s#rate#养成材料和少量乐园币", raceCfg.name, CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true) * 100))
			}

			descStrList[1] = string.gsub(descStrList[1], "#count#", "%%s")
			descStrList[1] = string.gsub(descStrList[1], "#rate#", "%%%%")
			descStrList[2] = string.gsub(descStrList[2], "#count#", "%%s")
			descStrList[2] = string.gsub(descStrList[2], "#rate#", "%%%%")

			for i, id in ipairs(selectIds or {}) do
				local mo = CutePetModel.instance:getCutePeMo(id)

				if mo.curStar > 1 then
					return descStrList[2]
				end
			end

			return descStrList[1]
		end

		local onlyoneOrCount = needNum

		btnAdd:AddClickListener(function()
			local canSelect = false

			for i, mo in pairs(CutePetModel.instance:getAllCutePet()) do
				if mo.raceId == data.raceId and mo.id ~= self._petMo.id then
					canSelect = true

					break
				end
			end

			if canSelect == true then
				local funcList = {
					filterFunc = filterFunc,
					submitFunc = GameUtil.handler(self._onSelectCutePet, self),
					descChangeFunc = descChangeFunc,
					totalCostFunc = GameUtil.handler(self._onGetTotalCost, self)
				}

				costData.selectPetId = data.selectPetId
				costData.onlyoneOrCount = onlyoneOrCount
				costData.hasNum = hasNum
				costData.needNum = needNum
				self._costMatData[self._petMo.id] = costData

				CutePetController.instance:openCutePetSelectView(onlyoneOrCount, title, descStr, data.selectPetId, funcList)
			else
				MaterialMgr.openGetSource(MatType.CutePet, self._petMo.raceId)
			end
		end, self)
	end

	GameUtil.SetActive(imgAdd, hasNum < needNum)

	if hasNum < needNum then
		txtColorChange:SetState(0)
	else
		txtColorChange:SetState(1)
	end

	txtCost.text = string.format("%s<color=#263047FF>/%s</color>", hasNum, needNum)
end

function CutePetStarUpView:_clearCostCell(item)
	local go = item.mainGO
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function CutePetStarUpView:_onSelectCutePet(view, petIds)
	local hasTip = false
	local checkTip = false

	if type(petIds) == "number" then
		checkTip = checknumber(petIds) > 0
	elseif type(petIds) == "table" then
		checkTip = #petIds > 0
	end

	if not CutePetModel.instance:getSelectGoodCuteTips() and checkTip == true then
		local hasUpStar = false

		for i, id in ipairs(petIds or {}) do
			local mo = CutePetModel.instance:getCutePeMo(id)

			if mo.curStar > 1 then
				hasUpStar = true

				break
			end
		end

		TipsFacade.instance:openPopupWindowWithTog(lang("提示"), hasUpStar == true and langPara("升星后所选萌宠将消失，返还%s%%养成材料和少量乐园币！", CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true) * 100) or langPara("升星后所选萌宠将消失，返还%s%%养成材料！", CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true) * 100), function()
			self:_selectPet(petIds)
			view:close()
		end, nil, function()
			CutePetModel.instance:saveSelectGoodCuteTips()
		end, "确认", "取消", "今日不再提示", UnityEngine.TextAnchor.MiddleCenter)

		hasTip = true
	end

	if hasTip == false then
		self:_selectPet(petIds)
		view:close()
	end
end

function CutePetStarUpView:_onGetTotalCost(totalCost, mo)
	local levelCfgs = CutePetConfig.instance:getLevelUpCfgs(mo.config.lvlUpPlan)
	local levelMats = {}

	for i = 1, mo.curLvl do
		if levelCfgs[i] and not string.nilorempty(levelCfgs[i].materialCost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(levelCfgs[i].materialCost)

			levelMats[matType] = levelMats[matType] or {}
			levelMats[matType][matId] = checknumber(levelMats[matType][matId]) + matNum
		end
	end

	local levelReturnRate = CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true)

	for matType, v in pairs(levelMats) do
		for matId, matNum in pairs(v) do
			if checknumber(matNum) > 0 then
				totalCost[matType] = totalCost[matType] or {}
				totalCost[matType][matId] = math.ceil(matNum * levelReturnRate) + checknumber(totalCost[matType][matId])
			end
		end
	end

	local qualityCfgs = CutePetConfig.instance:getQualityUpPlan(mo.config.qualityUpPlan)
	local qualityMats = {}

	for i = 1, mo.curQuality do
		if qualityCfgs[i] and not string.nilorempty(qualityCfgs[i].materialCost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(qualityCfgs[i].materialCost)

			qualityMats[matType] = qualityMats[matType] or {}
			qualityMats[matType][matId] = checknumber(qualityMats[matType][matId]) + matNum
		end
	end

	local qualityReturnRate = CutePetConfig.instance:getCommonValue("CutePetQualityReturnRateWhenDeleted", true)

	for matType, v in pairs(qualityMats) do
		for matId, matNum in pairs(v) do
			if checknumber(matNum) > 0 then
				totalCost[matType] = totalCost[matType] or {}
				totalCost[matType][matId] = math.ceil(matNum * qualityReturnRate) + checknumber(totalCost[matType][matId])
			end
		end
	end

	local curStarCfg = CutePetConfig.instance:getStarUpCfg(mo.config.starUpPlan, mo.curStar)
	local initStarCfg = CutePetConfig.instance:getStarUpCfg(mo.config.starUpPlan, 1)
	local starMatNum = curStarCfg.returnValue4Delete - initStarCfg.returnValue4Delete
	local starMat = CutePetConfig.instance:getCommonValue("CutePetStarReturnMaterialWhenDeleted", false)
	local starMatType, starMatId, _ = MaterialMgr.getMatParams(starMat)

	if starMatNum > 0 then
		totalCost[starMatType] = totalCost[starMatType] or {}
		totalCost[starMatType][starMatId] = starMatNum + checknumber(totalCost[starMatType][starMatId])
	end
end

function CutePetStarUpView:_selectPet(petIds)
	self._selectPetId[self._petMo.raceId] = {}

	if type(petIds) == "table" then
		for i, id in ipairs(petIds) do
			local mo = CutePetModel.instance:getCutePeMo(id)

			self._selectPetId[mo.raceId] = self._selectPetId[mo.raceId] or {}

			table.insert(self._selectPetId[mo.raceId], id)
		end
	elseif type(petIds) == "number" then
		local mo = CutePetModel.instance:getCutePeMo(petIds)

		self._selectPetId[mo.raceId] = self._selectPetId[mo.raceId] or {}

		table.insert(self._selectPetId[mo.raceId], petIds)
	end

	self:_refreshCostInfo()
end

function CutePetStarUpView:_onClickStarUp()
	local starUpCfg = CutePetConfig.instance:getStarUpCfg(self._petMo.config.lvlUpPlan, self._petMo.curStar + 1)

	if self._selectPetId and self._selectPetId[self._petMo.raceId] and starUpCfg and #self._selectPetId[self._petMo.raceId] == starUpCfg.costCutePetCount then
		if PasswordLockController.instance:checkNeedOpenVerifyView() then
			return
		end

		local needToSure = self:_checkSureToStarUp()

		if not needToSure or GameUtil.getUserDayData(self._toggleKey) then
			CutePetGardenAgent.instance:sendPM_CutePetStarUpReq(self._petId, self._selectPetId[self._petMo.raceId])
		else
			local tipsContent = "本次放入的材料中含有天赋评级≥<color=#CB5FFFFF>了不起</color>的宠物，升级消耗后宠物将消失，是否确认放入？"
			local countDown = 3

			local function sureFunc()
				CutePetGardenAgent.instance:sendPM_CutePetStarUpReq(self._petId, self._selectPetId[self._petMo.raceId])
			end

			UIStateManager.instance:push(ViewName.CutePetStarUpTipView, tipsContent, sureFunc, "今日不再提示", self._toggleKey, countDown)
		end
	else
		FloatWordMgr.instance:show(lang("材料不足"))
	end
end

function CutePetStarUpView:_onClickRule()
	TipsFacade.instance:openRulesView("cute_pet_star_up_rule")
end

function CutePetStarUpView:_onClickOneKey()
	local allCutePet = CutePetModel.instance:getAllCutePet()

	allCutePet = self:_petFillter(allCutePet)
	self._showPetList = {}
	self._backPetList = {}

	for i, mo in pairs(allCutePet) do
		if not self._filterFunc or self._filterFunc(mo.id) == true then
			if mo:getState(CutePetMo.STATE_IN_ADVENTURE) == true or checknumber(mo.equippedPetId) > 0 or mo:getState(CutePetMo.LOCKED) == true then
				table.insert(self._backPetList, mo)
			else
				table.insert(self._showPetList, mo)
			end
		end
	end

	table.sort(self._showPetList, function(a, b)
		return self:_compareOneKeyPet(a, b)
	end)

	if self._needCount < #self._selectPetId[self._petMo.raceId] then
		local needToDelete = #self._selectPetId[self._petMo.raceId] - self._needCount

		for i = 1, needToDelete do
			table.remove(self._selectPetId[self._petMo.raceId], #self._selectPetId[self._petMo.raceId])
		end

		return
	end

	local canCostNum = math.min(self._needCount, #self._showPetList)

	if #self._selectPetId[self._petMo.raceId] < self._needCount then
		for i = 1, canCostNum do
			local mo = self._showPetList[i]
			local petId = mo.id

			if not table.indexof(self._selectPetId[self._petMo.raceId], petId) then
				table.insert(self._selectPetId[self._petMo.raceId], petId)
			end
		end
	end

	self:_refreshCostInfo()
end

function CutePetStarUpView:_petFillter(list)
	local resultList = {}

	for i, mo in pairs(list) do
		if ((CutePetFilterMgr.instance:checkIsMatch(CutePetFilterMgr.TYPE_CUTESELECT, mo.cfg, mo.id) == true or nil) and true) == true then
			table.insert(resultList, mo)
		end
	end

	return resultList
end

function CutePetStarUpView:_PM_CutePetStarUpResp()
	self._selectPetId = {}

	self:_refreshView()
	UIStateManager.instance:push(ViewName.CutePetStarUpShowView, self._petMo.id)
end

function CutePetStarUpView:_refreshCanCostPetTxt()
	if self._petMo.curStar >= self._maxStar then
		return
	end

	local allCutePet = CutePetModel.instance:getAllCutePet()

	allCutePet = self:_petFillter(allCutePet)

	local showPetList = {}

	for i, mo in pairs(allCutePet) do
		if self._filterFunc(mo.id) ~= true or mo:getState(CutePetMo.STATE_IN_ADVENTURE) == true or checknumber(mo.equippedPetId) > 0 or mo:getState(CutePetMo.LOCKED) == true then
			-- block empty
		else
			table.insert(showPetList, mo)
		end
	end

	local canCost = checknumber(self._needCount) <= #showPetList

	self._txtCanCost.text = canCost and langPara("(拥有:<color=green>%s</color>)", #showPetList) or langPara("(拥有:<color=red>%s</color>)", #showPetList)
end

function CutePetStarUpView:_petFillter(list)
	local filterType = CutePetFilterMgr.TYPE_CUTESELECT
	local resultList = {}

	for i, mo in pairs(list) do
		if ((CutePetFilterMgr.instance:checkIsMatch(filterType, mo.cfg, mo.id) == true or nil) and true) == true then
			table.insert(resultList, mo)
		end
	end

	return resultList
end

function CutePetStarUpView:_checkSureToStarUp()
	local arr = self._selectPetId[self._petMo.raceId]

	if arr then
		for k, cid in pairs(arr) do
			local mo = CutePetModel.instance:getCutePeMo(cid)

			if self:_checkHas4StarUp(mo) then
				return true
			end
		end
	end

	return false
end

function CutePetStarUpView:_checkHas4StarUp(cutePetMo)
	if cutePetMo == nil then
		return false
	end

	return cutePetMo:getTalentGrade() >= 4
end

function CutePetStarUpView:_compareOneKeyPet(a, b)
	local aDiscard = a:getIsReadyToDiscard()
	local bDiscard = b:getIsReadyToDiscard()

	if aDiscard ~= bDiscard then
		return aDiscard
	end

	if a.score ~= b.score then
		return a.score < b.score
	end

	if a.curQuality ~= b.curQuality then
		return a.curQuality < b.curQuality
	end

	if a.curStar ~= b.curStar then
		return a.curStar < b.curStar
	end

	if a.curLvl ~= b.curLvl then
		return a.curLvl < b.curLvl
	end

	if a.gainTime ~= b.gainTime then
		return a.gainTime < b.gainTime
	end

	return a.id < b.id
end

function CutePetStarUpView:_updateSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "bg/txtDesc")
	local txtColorChange = goutil.findChildComponent(go, "bg/txtDesc", "UITextColorChange")
	local lock = goutil.findChild(go, "lock")
	local txtStar = goutil.findChildTextComponent(go, "star/txt")

	for i = 1, 6 do
		local star = goutil.findChild(go, "starLv/star_" .. i)

		if i <= data.star then
			GameUtil.SetActive(star, true)
		else
			GameUtil.SetActive(star, false)
		end
	end

	go.name = "star_" .. data.star

	if data.star <= self._petMo.curStar then
		txtColorChange:SetState(0)
		GameUtil.SetActive(lock, false)
	else
		txtColorChange:SetState(1)
		GameUtil.SetActive(lock, true)
	end

	txtDesc.text = data.starBuffsDesc
	txtStar.text = data.star
end

function CutePetStarUpView:_clearSkillCell(cell)
	return
end

function CutePetStarUpView:_skillReloadFinish()
	if self._petMo then
		self._skillList:MoveCellInView(self._petMo.curStar - 1, true)
	end
end

function CutePetStarUpView:_skillCellSize(view, index)
	local height = self.heightList[index + 1]

	return 326, height
end

function CutePetStarUpView:_recordHeight(skillList)
	goutil.setActive(self._skillCell, true)

	self.heightList = {}

	for k, data in ipairs(skillList) do
		self:_updateSkillCell(nil, self._skillCell, data)

		local size = self._skillSizeImmediate:GetPreferredSize()

		table.insert(self.heightList, math.max(25, size.y))
	end

	goutil.setActive(self._skillCell, false)
end

function CutePetStarUpView:_onClickSkillIntro()
	GameUtil.SetActive(self._skillIntroduce, true)

	local skillList = {}

	for i, v in ipairs(CutePetConfig.instance:getStarSkillCfgs(self._petMo.raceId)) do
		table.insert(skillList, v)
	end

	table.sort(skillList, function(a, b)
		return a.star < b.star
	end)
	self:_recordHeight(skillList)
	self._skillList:reloadData(skillList)
end

function CutePetStarUpView:_onClickSkillClose()
	GameUtil.SetActive(self._skillIntroduce, false)
end

return CutePetStarUpView
