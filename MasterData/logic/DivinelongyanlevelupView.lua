-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanlevelupView.lua

module("logic.extensions.divinelongyan.view.DivinelongyanlevelupView", package.seeall)

local DivinelongyanlevelupView = class("DivinelongyanlevelupView", ViewComponent)

function DivinelongyanlevelupView:ctor()
	DivinelongyanlevelupView.super.ctor(self)
end

function DivinelongyanlevelupView:unbindEvents()
	DivinelongyanlevelupView.super.unbindEvents(self)
	self._btnUpAll:RemoveClickListener()
	self._btnUpOne:RemoveClickListener()
end

function DivinelongyanlevelupView:bindEvents()
	DivinelongyanlevelupView.super.bindEvents(self)
	self._btnUpAll:AddClickListener(self._onClickbtnUpAll, self)
	self._btnUpOne:AddClickListener(self._onClickbtnUpOne, self)
end

function DivinelongyanlevelupView:buildUI()
	DivinelongyanlevelupView.super.buildUI(self)

	self._btnUpAll = self:getBtn("btnUpAll")
	self._btnUpOne = self:getBtn("btnUpOne")
	self._txtCostTen = self:getTxt("btnUpAll/txtCost")
	self._txtCostOne = self:getTxt("btnUpOne/txtCost")
	self._txtMaxLevelGo = self:getGo("goMaxLevel")
	self._txtLv = self:getTxt("txtLv")
	self._txtPower = self:getTxt("txtPower")
	self._txtUptoX = self:getTxt("btnUpOne/txt")
	self._powerNum = self:getGo("power/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._progressBar = self:getSlider("progressBar")
	self._goCom = self:getGo("goCom")
	self._goOne = self:getGo("goOne")
	self._txtCur = self:getTxt("goCom/txtCur")
	self._txtNex = self:getTxt("goCom/txtNex")
	self._txtCurNow = self:getTxt("goOne/txtCur")
end

function DivinelongyanlevelupView:onExit()
	DivinelongyanlevelupView.super.onExit(self)
end

function DivinelongyanlevelupView:onEnter()
	DivinelongyanlevelupView.super.onEnter(self)

	local activityId = self:getFirstParam()

	self._activityId = activityId and activityId or DivinelongyanModel.instance:getActivityId()
	self._matType, self._matId = DivinelongyanController.instance:getCostMatParams(self._activityId)

	self.addGEvent(self, GlobalNotify.DivineLongYanUpgradeLevelRes, self._updateUI, self)
	self:_updateUI()
end

function DivinelongyanlevelupView:_onClickbtnUpAll()
	local cfgs = DivinelongyanConfig.instance:getSupportPetLevelCfgs(self._activityId)
	local hasNum = MaterialFacade.instance:getMatNumber(self._matType, self._matId)
	local costNum = 0
	local nextCfg

	for i = self._supportPet.level + 1, #cfgs do
		local cfg = cfgs[i]
		local preCostNum = costNum + cfg.cost

		if hasNum < preCostNum then
			break
		end

		nextCfg = cfg
		costNum = preCostNum
	end

	local cfg = DivinelongyanConfig.instance:getActCfg(self._activityId) or {}
	local costMp = cfg.costMp

	if not nextCfg then
		TipsFacade.instance:openItemSourceView(costMp)

		return
	end

	local type, id = MaterialMgr.getMatParams(costMp)
	local matName = MaterialMgr.getMaterialsName(type, id)
	local content = langPara("确定要消耗%s%s把精灵升级到Lv.%s吗？", matName, costNum, nextCfg.petLevel)

	TipsFacade.instance:openPopupCostMatViewNew(type, id, costNum, content, function()
		DivineLongYanChallengeAgent.instance:sendPM_DivineLongYanUpgradeLevelReq(self._activityId, nextCfg.level - self._supportPet.level)
	end)
end

function DivinelongyanlevelupView:_onClickbtnUpOne()
	local nextCfg = DivinelongyanConfig.instance:getSupportPetLevelCfg(self._activityId, self._supportPet.level + 1)
	local hasNum = MaterialFacade.instance:getMatNumber(self._matType, self._matId)
	local cfg = DivinelongyanConfig.instance:getActCfg(self._activityId) or {}
	local costMp = cfg.costMp

	if hasNum < nextCfg.cost then
		TipsFacade.instance:openItemSourceView(costMp)

		return
	end

	local type, id = MaterialMgr.getMatParams(costMp)
	local matName = MaterialMgr.getMaterialsName(type, id)
	local content = langPara("确定要消耗%s%s把精灵升级到Lv.%s吗？", matName, nextCfg.cost, nextCfg.petLevel)

	TipsFacade.instance:openPopupCostMatViewNew(type, id, nextCfg.cost, content, function()
		DivineLongYanChallengeAgent.instance:sendPM_DivineLongYanUpgradeLevelReq(self._activityId, 1)
	end)
end

function DivinelongyanlevelupView:_updateUI()
	self._supportPet = DivinelongyanModel.instance:getSupportPet(self._activityId)

	self:_updatePetLv()
	self:_updateCost()
	self:_updatePower()
end

function DivinelongyanlevelupView:_updatePetLv()
	local level = DivinelongyanConfig.instance:getSupportPetLevel(self._activityId, self._supportPet.level)
	local cfgs = DivinelongyanConfig.instance:getSupportPetLevelCfgs(self._activityId)
	local maxLxl = cfgs[#cfgs].petLevel

	self._txtLv.text = string.format("<color=#20b376>%s</color>/%s", level, maxLxl)

	self._progressBar:SetValue(level / maxLxl)
end

function DivinelongyanlevelupView:_updateCost()
	local nextCfg = DivinelongyanConfig.instance:getSupportPetLevelCfg(self._activityId, self._supportPet.level + 1)
	local isMax = not nextCfg

	GameUtil.SetActive(self._txtMaxLevelGo, isMax)
	GameUtil.SetActive(self._btnUpOne, not isMax)
	GameUtil.SetActive(self._btnUpAll, not isMax)
	GameUtil.SetActive(self._goOne, isMax)
	GameUtil.SetActive(self._goCom, not isMax)

	local level = DivinelongyanConfig.instance:getSupportPetLevel(self._activityId, self._supportPet.level)
	local nowCfg = DivinelongyanConfig.instance:getSupportPetLevelCfg(self._activityId, self._supportPet.level)
	local arr = self:getAttrStr(nowCfg.extproperties or "", nowCfg.buffs)

	self._txtCur.text = table.concat(arr, "\n")
	self._txtCurNow.text = table.concat(arr, "\n")

	local hasNum = MaterialFacade.instance:getMatNumber(self._matType, self._matId)
	local name = MaterialMgr.getMaterialsName(self._matType, self._matId)

	if nextCfg then
		local arr = self:getAttrStr(nextCfg.extproperties or "", nextCfg.buffs)

		self._txtNex.text = table.concat(arr, "\n")
		self._txtCostOne.text = hasNum < nextCfg.cost and string.format("<color=#eb4642>消耗%s%s</color>", nextCfg.cost, name) or string.format("消耗%s%s", nextCfg.cost, name)
		self._txtUptoX.text = string.format("升到%s级", nextCfg.petLevel)
	end

	local cfgs = DivinelongyanConfig.instance:getSupportPetLevelCfgs(self._activityId)
	local costNum = 0
	local tmpCfg

	for i = self._supportPet.level + 1, #cfgs do
		local cfg = cfgs[i]
		local preCostNum = costNum + cfg.cost

		if hasNum < preCostNum then
			break
		end

		tmpCfg = cfg
		costNum = preCostNum
	end

	self._txtCostTen.text = not tmpCfg and (nextCfg and string.format("<color=#eb4642>消耗%s%s</color>", nextCfg.cost, name) or string.format("消耗%s%s", 0, name)) or string.format("消耗%s%s", costNum, name)
end

function DivinelongyanlevelupView:_updatePower()
	local petMo = DivinelongyanModel.instance:getCurSuppopPetMo(self._activityId)

	if petMo then
		self._powerNum:SetNum(petMo:getFightingPower())
	end
end

function DivinelongyanlevelupView:getAttrStr(extproperties, buffs)
	local list = {}
	local arr = string.split(extproperties or "", "#")

	for i, v in ipairs(arr) do
		local tem = string.split(v, "+")

		table.insert(list, checknumber(tem[2]) <= 1 and "<color=#20b376>" .. tem[1] .. "</color>\t\t\t+" .. checknumber(tem[2]) * 100 .. "%" or "<color=#20b376>" .. tem[1] .. "</color>\t\t\t\t+" .. tem[2])
	end

	local arr = string.split(buffs or "", "#")

	for i, v in ipairs(arr) do
		local tem = string.splitToNumber(v, ":")
		local cfg = BattleConfig.instance:getBuffCo(tem[1])
		local str = "<color=#cd7800>" .. cfg.name .. "</color>"

		table.insert(list, str)
	end

	return list
end

return DivinelongyanlevelupView
