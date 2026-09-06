-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetInteractView.lua

module("logic.extensions.cutepet.view.CutePetInteractView", package.seeall)

local CutePetInteractView = class("CutePetInteractView", ViewComponent)
local btnEffectPath = "20230728/chongwuyuan/fx_ui_chongwuyuan_faguang.prefab"

function CutePetInteractView:ctor()
	CutePetInteractView.super.ctor(self)
end

function CutePetInteractView:buildUI()
	CutePetInteractView.super.buildUI(self)

	self._txtName = self:getTxt("basicInfo/cutePetName/txtName")
	self._txtLevel = self:getTxt("basicInfo/txtLevel")
	self._txtQuality = self:getTxt("basicInfo/txtQuality")
	self._imgType = goutil.findChildComponent(self.mainGO, "basicInfo/imgType", "UIImageSpriteChange")
	self._imgQualityChange = goutil.findChildComponent(self.mainGO, "basicInfo/imgQuality", "UIImageSpriteChange")
	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("basicInfo/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "basicInfo/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._sldHappiness = self:getSlider("happiness/happinessSlider")
	self._txtHappiness = self:getTxt("happiness/txtNum")
	self._btnPrize = self:getBtn("happiness/btnPrize")
	self._costView = self:getGo("interact/itemcon")
	self._costCell = self:getGo("interact/itemcon/item")
	self._costList = ItemGroup.New(self._costView, self._costCell)
	self._btnTips = self:getGo("btnRule")
end

function CutePetInteractView:bindEvents()
	CutePetInteractView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickRule, self)
end

function CutePetInteractView:unbindEvents()
	CutePetInteractView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnTips)
end

function CutePetInteractView:destroyUI()
	CutePetInteractView.super.destroyUI(self)
end

function CutePetInteractView:onExit()
	CutePetInteractView.super.onExit(self)
	removetimer(self._onTimer, self)
	self._costList:dispose(self._clearCostCell, self)
	UIEffectManager.instance:stopEffect(self._effectBtnPrize)
end

function CutePetInteractView:onEnter()
	CutePetInteractView.super.onEnter(self)
	self:_onRefreshUI()
	CutePetController.instance:sendPM_LoadCutePetInteractInfoReq()
	self.addGEvent(self, GlobalNotify.handlePM_LoadCutePetInteractInfoResp, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_HappinessInteractResp, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_GainHappinessInteractPrizeResp, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.CutePetShowPetChange, self._refreshView, self)

	self._effectBtnPrize = UIEffectManager.instance:playEffect(self, btnEffectPath, nil, 0, 0, true)

	self._effectBtnPrize:setParent(self._btnPrize.transform)
	self._effectBtnPrize:setLocalPos(0, 0, 0)
	self._effectBtnPrize:setScale(1)
end

function CutePetInteractView:_refreshView()
	removetimer(self._onTimer, self)
	settimer(1, self._onTimer, self)
	self:_onRefreshUI()
end

function CutePetInteractView:_onTimer()
	self:_refreshSlider()
end

function CutePetInteractView:_onRefreshUI()
	self._petId = CutePetModel.instance:GetCurPetId()
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)

	self:_refreshBasicInfo()
	self:_refreshSlider()

	local arr = CutePetConfig.instance:getInteractCfgs()

	self._costList:updateWithMoArray(arr, self._updateCostCell, self)
end

function CutePetInteractView:_refreshSlider()
	local hasGainPrize = CutePetModel.instance.hasGainPrize

	if not CutePetModel.instance.happiness then
		local happiness = {}
		local value = checknumber(happiness.happiness)
		local rcdTime = checknumber(happiness.happinessBalanceTime) / 1000
		local now = ServerTime.now()
		local step = now - rcdTime
		local minVal = CutePetConfig.instance:getCommonValue("InteractHappinessMinValue", true)
		local maxVal = CutePetConfig.instance:getCommonValue("InteractHappinessMaxValue", true)
		local configVal = CutePetConfig.instance:getCommonValue("InteractHappinessDecPerNSecd", true)
		local curValue = math.max(minVal, value - math.floor(step / configVal))
		local curValue = math.min(maxVal, curValue)

		self._sldHappiness:SetValue(curValue / maxVal)

		self._txtHappiness.text = langPara("%d/%d", curValue, maxVal)

		local gainPrizeVal = CutePetConfig.instance:getCommonValue("InteractHappinessGainPrizeValue", true)

		GameUtil.SetActive(self._btnPrize, not hasGainPrize and gainPrizeVal <= curValue)

		self._isMaxHappiness = curValue == maxVal
	end
end

function CutePetInteractView:_refreshBasicInfo()
	if self._petMo then
		local petTypeCfg = CutePetConfig.instance:getPetTypeCfg(self._petMo.config.type)

		self._txtName.text = self._petMo.name
		self._txtQuality.text = self._petMo.curQuality

		self._imgType:SetState(self._petMo.config.type - 1)
		self._imgQualityChange:SetState(self._petMo.curQuality - 1)

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
end

function CutePetInteractView:_updateCostCell(item, data, i)
	local go = item.mainGO
	local con = goutil.findChild(go, "con")
	local imgAdd = goutil.findChild(go, "imgAdd")
	local btnAdd = goutil.findChild(go, "btnAdd")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtResult = goutil.findChildTextComponent(go, "txtResult")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)
	local proxy = MaterialMgr.setCell(matType, matId, con)
	local count = MaterialMgr.getMatCount(data.cost)

	proxy.binder:setNum(count)
	GameUtil.SetActive(imgAdd, count == 0)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(data.cost)
	txtResult.text = "+" .. data.addHappiness

	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._onItemClick, self, data))
end

function CutePetInteractView:_clearCostCell(item)
	local go = item.mainGO
	local con = goutil.findChild(go, "con")
	local imgAdd = goutil.findChild(go, "img_add")

	MaterialMgr.resetAll(con)
end

function CutePetInteractView:_onItemClick(data)
	local count = MaterialMgr.getMatCount(data.cost)

	if count > 0 then
		if self._isMaxHappiness == true then
			FloatWordMgr.instance:show(lang("好感度已满"))

			return
		end

		CutePetController.instance:sendPM_HappinessInteractReq(data.costPlanId, 1)
	else
		MaterialMgr.openGetSourceByStr(data.cost)
	end
end

function CutePetInteractView:_onClickPrize()
	CutePetController.instance:sendPM_GainHappinessInteractPrizeReq()
end

function CutePetInteractView:_onClickRule()
	TipsFacade.instance:openRulesView("cute_pet_interact_rule")
end

return CutePetInteractView
