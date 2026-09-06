-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetQualityUpView.lua

module("logic.extensions.cutepet.view.CutePetQualityUpView", package.seeall)

local CutePetQualityUpView = class("CutePetQualityUpView", ViewComponent)

function CutePetQualityUpView:ctor()
	CutePetQualityUpView.super.ctor(self)
end

function CutePetQualityUpView:buildUI()
	CutePetQualityUpView.super.buildUI(self)

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

	self._attrTable = self:getGo("attrInfo/ScrollView")
	self._attrCell = self:getGo("attrInfo/attrCell")
	self._costInfo = self:getGo("costInfo")
	self._costView = self:getGo("costInfo/itemcon")
	self._costCell = self:getGo("costInfo/item")
	self._costList = ItemGroup.New(self._costView, self._costCell)
	self._maxQualityCon = self:getGo("maxStarCon")
	self._txtAssistanceSkillNow = self:getTxt("assistanceSkill/txtDescNow")
	self._txtAssistanceSkillNext = self:getTxt("assistanceSkill/txtDescNext")
	self._txtAssistanceSkillMax = self:getTxt("assistanceSkill/txtDescMax")
	self._imgNext = self:getGo("assistanceSkill/imgNext")
	self._starMaxNow = self:getTxt("starMax/txtStarMaxNow")
	self._starMaxNext = self:getTxt("starMax/txtStarMaxNext")
	self._imgStarMax = self:getGo("starMax/imgNext")
	self._btnQualityUp = self:getBtn("btnStarUp")
	self._btnRule = self:getGo("btnRule")
	self._btnStatDetail = self:getGo("attrInfo/btnDetail")
end

function CutePetQualityUpView:bindEvents()
	CutePetQualityUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnQualityUp, self._onClickQualityUp, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnStatDetail, self._onClickBtnStatDetail, self)
end

function CutePetQualityUpView:unbindEvents()
	CutePetQualityUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnQualityUp)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnStatDetail)
end

function CutePetQualityUpView:onExit()
	CutePetQualityUpView.super.onExit(self)
	self._attrList:dispose()
	self._costList:dispose(self._clearCostCell, self)
end

function CutePetQualityUpView:destroyUI()
	CutePetQualityUpView.super.destroyUI(self)
end

function CutePetQualityUpView:onEnter()
	CutePetQualityUpView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetQualityUpResp, self._PM_CutePetQualityUpResp, self)
	self.addGEvent(self, GlobalNotify.CutePetShowPetChange, self._refreshView, self)

	self._attrList = ScrollerList.create(self._attrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	self:_refreshView()
end

function CutePetQualityUpView:_refreshView()
	self._petId = CutePetModel.instance:GetCurPetId()
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)

	if not self._petMo then
		return
	end

	self:_refreshBasicInfo()
	self:_refreshAttrInfo()
	self:_refreshAssistanceSkill()
	self:_refreshCostInfo()
end

function CutePetQualityUpView:_refreshBasicInfo()
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

	self._starMaxNow.text = self._maxStar
	self._maxQuality = #CutePetConfig.instance:getQualityUpPlan(self._petMo.config.qualityUpPlan)

	if self._petMo.curQuality < self._maxQuality then
		GameUtil.SetActive(self._starMaxNext, true)
		GameUtil.SetActive(self._imgStarMax, true)

		self._starMaxNext.text = CutePetConfig.instance:getMaxStar(self._petMo.config.starUpPlan, self._petMo.curQuality + 1)
	else
		GameUtil.SetActive(self._starMaxNext, false)
		GameUtil.SetActive(self._imgStarMax, false)
	end
end

function CutePetQualityUpView:_refreshAttrInfo()
	local attr = {}
	local result = {}

	result = self._petMo.curQuality < self._maxQuality and self._petMo:calcAttr(self._petMo.curQuality + 1, nil, nil) or self._petMo.attr

	local attrSort = self._petMo:getSortAttrList(result)

	for i, v in ipairs(attrSort) do
		local nextNum = result[v]
		local nowNum = checknumber(self._petMo.attr[v])

		if nextNum ~= nowNum and nextNum ~= 0 or self._petMo.curQuality == self._maxQuality then
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

	if self._attrList and #self._attrList > 0 then
		self._attrList:MoveCellToCenter(#self._attrList)
	end
end

function CutePetQualityUpView:_refreshAssistanceSkill()
	local curSkillCfg = CutePetConfig.instance:getAssistanceCfg(self._petMo.config.type, self._petMo.curQuality)

	if self._petMo.curQuality < self._maxQuality then
		GameUtil.SetActive(self._txtAssistanceSkillNext, true)
		GameUtil.SetActive(self._txtAssistanceSkillMax, false)

		local nextSkillCfg = CutePetConfig.instance:getAssistanceCfg(self._petMo.config.type, self._petMo.curQuality + 1)

		self._txtAssistanceSkillNow.text = curSkillCfg.desc
		self._txtAssistanceSkillNext.text = nextSkillCfg.desc
	else
		GameUtil.SetActive(self._txtAssistanceSkillNow, false)
		GameUtil.SetActive(self._txtAssistanceSkillNext, false)
		GameUtil.SetActive(self._imgNext, false)
		GameUtil.SetActive(self._txtAssistanceSkillMax, true)

		self._txtAssistanceSkillMax.text = curSkillCfg.desc
	end
end

function CutePetQualityUpView:_refreshCostInfo()
	self._costList:dispose(self._clearCostCell, self)

	if self._petMo.curQuality < self._maxQuality then
		GameUtil.SetActive(self._costInfo, true)
		GameUtil.SetActive(self._btnQualityUp, true)
		GameUtil.SetActive(self._maxQualityCon, false)

		local qualityUpCfg = CutePetConfig.instance:getQualityUpCfg(self._petMo.config.qualityUpPlan, self._petMo.curQuality + 1)
		local costStr = string.split(qualityUpCfg.materialCost, "#")

		self._costList:updateWithMoArray(costStr, self._updateCostCell, self)
	else
		GameUtil.SetActive(self._costInfo, false)
		GameUtil.SetActive(self._btnQualityUp, false)
		GameUtil.SetActive(self._maxQualityCon, true)
	end
end

function CutePetQualityUpView:_updateAttrCell(view, cell, data, tag)
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
end

function CutePetQualityUpView:_clearAttrCell(cell)
	return
end

function CutePetQualityUpView:_updateCostCell(item, data, i)
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

	txtCost.text = string.format("%d<color=#263047FF>/%d</color>", hasNum, needNum)
end

function CutePetQualityUpView:_clearCostCell(item)
	local go = item.mainGO
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function CutePetQualityUpView:_onClickQualityUp()
	local qualityUpCfg = CutePetConfig.instance:getQualityUpCfg(self._petMo.config.qualityUpPlan, self._petMo.curQuality + 1)

	if qualityUpCfg then
		local costStr = string.split(qualityUpCfg.materialCost, "#")

		for i, v in ipairs(costStr or {}) do
			local matType, id, needNum = MaterialMgr.getMatParams(v)

			if MaterialModel.instance:IsEnough(matType, id, needNum) == false then
				MaterialMgr.openGetSource(matType, id)

				return
			end
		end
	else
		FloatWordMgr.instance:show(lang("已达最高品质"))

		return
	end

	CutePetGardenAgent.instance:sendPM_CutePetQualityUpReq(self._petId)
end

function CutePetQualityUpView:_PM_CutePetQualityUpResp()
	self:_refreshView()
	UIStateManager.instance:push(ViewName.CutePetQualityUpShowView, self._petMo.id)
end

function CutePetQualityUpView:_onClickRule()
	TipsFacade.instance:openRulesView("cute_pet_quality_up_rule")
end

function CutePetQualityUpView:_onClickBtnStatDetail()
	GlobalDispatcher:dispatch(GlobalNotify.ShowCutePetAttrDetail, self._petId)
end

return CutePetQualityUpView
