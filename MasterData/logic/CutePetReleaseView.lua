-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetReleaseView.lua

module("logic.extensions.cutepet.view.CutePetReleaseView", package.seeall)

local CutePetReleaseView = class("CutePetReleaseView", ViewComponent)

function CutePetReleaseView:ctor()
	CutePetReleaseView.super.ctor(self)
end

function CutePetReleaseView:buildUI()
	CutePetReleaseView.super.buildUI(self)

	self._desc = self:getTxt("Nego_Main/Txt_Desc")
	self._btnClose = self:getGo("Nego_Main/Btn_Close")
	self._tableView = self:getGo("Nego_Main/ScrollView/Viewport/Content")
	self._tableCell = self:getGo("Nego_Main/ScrollView/Viewport/Content/itemCell")
	self._tableList = ItemGroup.New(self._tableView, self._tableCell)
	self._btnSure = self:getGo("Nego_Main/Btns/Btn1")
	self._btnCancel = self:getGo("Nego_Main/Btns/Btn2")
end

function CutePetReleaseView:bindEvents()
	CutePetReleaseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function CutePetReleaseView:unbindEvents()
	CutePetReleaseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function CutePetReleaseView:onExit()
	CutePetReleaseView.super.onExit(self)
	self._tableList:dispose(self._clearItemCell, self)
end

function CutePetReleaseView:onEnter()
	CutePetReleaseView.super.onEnter(self)

	local params = self:getOpenParam()
	local petMo = params[1]

	self._releaseHandler = params[2]

	local returnLvRate = CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true)
	local returnQualityRate = CutePetConfig.instance:getCommonValue("CutePetQualityReturnRateWhenDeleted", true)

	self._desc.text = langPara("宠物放生后将消失，返还%d%%的培养材料和一定数量的乐园币", returnLvRate * 100)

	local result = {}
	local lvMatResult = {}
	local lvUpPlanCfg = CutePetConfig.instance:getLevelUpCfgs(petMo.config.lvlUpPlan)

	for i, v in ipairs(lvUpPlanCfg) do
		if v.lvl <= petMo.curLvl and not string.nilorempty(v.materialCost) then
			table.insert(lvMatResult, v.materialCost)
		end
	end

	lvMatResult = MaterialMgr.combineItemsToList(lvMatResult)

	for i, v in ipairs(lvMatResult) do
		local matType, matId, matNum = MaterialMgr.getMatParams(v)

		matNum = math.ceil(matNum * returnLvRate)

		table.insert(result, string.format("%d:%d:%d", matType, matId, matNum))
	end

	local qualityMatResult = {}
	local qualityUpPlanCfg = CutePetConfig.instance:getQualityUpPlan(petMo.config.qualityUpPlan)

	for i, v in ipairs(qualityUpPlanCfg) do
		if v.quality <= petMo.curQuality and not string.nilorempty(v.materialCost) then
			table.insert(qualityMatResult, v.materialCost)
		end
	end

	qualityMatResult = MaterialMgr.combineItemsToList(qualityMatResult)

	for i, v in ipairs(qualityMatResult) do
		local matType, matId, matNum = MaterialMgr.getMatParams(v)

		matNum = math.ceil(matNum * returnQualityRate)

		table.insert(result, string.format("%d:%d:%d", matType, matId, matNum))
	end

	local starUpPlanCfg = CutePetConfig.instance:getStarUpCfg(petMo.config.starUpPlan, petMo.curStar)
	local starUpNeedNum = checknumber(starUpPlanCfg.returnValue4Delete)

	if starUpNeedNum > 0 then
		local starReturnMat = CutePetConfig.instance:getCommonValue("CutePetStarReturnMaterialWhenDeleted", false)

		table.insert(result, starReturnMat .. ":" .. starUpNeedNum)
	end

	result = MaterialMgr.combineItemsToList(result)

	self._tableList:updateWithMoArray(result, self._updateItemCell, self)
end

function CutePetReleaseView:_updateItemCell(item, data, i)
	local go = item.mainGO

	MaterialMgr.setCellByCfg(data, go)
end

function CutePetReleaseView:_clearItemCell(item)
	local go = item.mainGO

	MaterialMgr.resetAll(go)
end

function CutePetReleaseView:_onClickClose()
	self:close()
end

function CutePetReleaseView:_onClickSure()
	local petMo = self:getFirstParam()

	if self._releaseHandler then
		GameUtil.callBack(self._releaseHandler)
	else
		CutePetController.instance:sendPM_ReleaseCutePetReq({
			petMo.id
		})
	end

	self:close()
end

return CutePetReleaseView
