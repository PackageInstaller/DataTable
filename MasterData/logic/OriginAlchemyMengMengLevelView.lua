-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengLevelView.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengLevelView", package.seeall)

local OriginAlchemyMengMengLevelView = class("OriginAlchemyMengMengLevelView", ViewComponent)

function OriginAlchemyMengMengLevelView:ctor()
	OriginAlchemyMengMengLevelView.super.ctor(self)
end

function OriginAlchemyMengMengLevelView:unbindEvents()
	OriginAlchemyMengMengLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnStage)
	GameUtil.rmClickHandler(self._btnMake)
end

function OriginAlchemyMengMengLevelView:bindEvents()
	OriginAlchemyMengMengLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickBtnLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickBtnRight, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnStage, self._onClickBtnStage, self)
	GameUtil.addClickHandler(self._btnMake, self._onClickBtnMake, self)
end

function OriginAlchemyMengMengLevelView:buildUI()
	OriginAlchemyMengMengLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnStage = self:getGo("stage")
	self._txtStage = self:getTxt("stage/txtStage")
	self._finish = self:getGo("stage/finish")
	self._btnReset = self:getGo("btnReset")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._tableviewWarehouse = self:getGo("warehouse/tableview")
	self._tablecellWarehouse = self:getGo("warehouse/tableview/tablecell")
	self._scrollListWarehouse = ScrollerList.create(self._tableviewWarehouse, self._tablecellWarehouse, GameUtil.handler(self._updateWarehouseCell, self), GameUtil.handler(self._clearWarehouseCell, self))
	self._btnMake = self:getGo("guide/btnMake")
	self._txtWaitUseGo = self:getGo("guide/txtWaitUse")
	self._txtCompoundEffect = self:getTxt("guide/txtCompoundEffect")
	self._txtCompoundName = self:getTxt("guide/txtCompoundName")
	self._tableviewMaterial = self:getGo("guide/tableviewMaterial")
	self._tablecellMaterial = self:getGo("guide/tableviewMaterial/tablecell")
	self._scrollListMaterial = ScrollerList.create(self._tableviewMaterial, self._tablecellMaterial, GameUtil.handler(self._updateMaterialCell, self), GameUtil.handler(self._clearMaterialCell, self))
	self._tableviewDrug = self:getGo("guide/tableviewDrug")
	self._tablecellDrug = self:getGo("guide/tableviewDrug/tablecell")
	self._scrollListDrug = ScrollerList.create(self._tableviewDrug, self._tablecellDrug, GameUtil.handler(self._updateDrugCell, self), GameUtil.handler(self._clearDrugCell, self))
end

function OriginAlchemyMengMengLevelView:onExit()
	OriginAlchemyMengMengLevelView.super.onExit(self)
	self._scrollListWarehouse:dispose()
	self._scrollListMaterial:dispose()
	self._scrollListDrug:dispose()
end

function OriginAlchemyMengMengLevelView:onEnter()
	OriginAlchemyMengMengLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginAlchemyMengMengGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginAlchemyMengMengResetRes, self._onResetRes, self)
	self.addGEvent(self, GlobalNotify.PM_OriginAlchemyMengMengSmeltReagentRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 601001
	end

	self._actCfg = OriginalChemyMengMengConfig.instance:getActivityCfg(self._activityId) or {}
	self._stageCfgs = OriginalChemyMengMengConfig.instance:getStageCfgs(self._activityId) or {}
	self._selectStage = OriginalChemyMengMengModel.instance:getSelectStageMap(self._activityId)

	if checknumber(self._selectStage) <= 0 then
		self._selectStage = OriginalChemyMengMengController.instance:getCanChallengeStage(self._activityId)
	end

	self._selectReagentId = 1

	OriginalChemyMengMengController.instance:sendPM_OriginAlchemyMengMengGetInfoReq(self._activityId)
end

function OriginAlchemyMengMengLevelView:_onUpdate()
	self._info = OriginalChemyMengMengModel.instance:getInfo(self._activityId) or {}
	self._compoundMap = OriginalChemyMengMengModel.instance:getCompoundMap(self._activityId)
	self._compoundCfgs = OriginalChemyMengMengConfig.instance:getCompoundCfgs(self._activityId) or {}
	self._reagentCfgs = OriginalChemyMengMengConfig.instance:getReagentCfgs(self._activityId) or {}
	self._curNeedMatMap = OriginalChemyMengMengController.instance:getNeedMatMap(self._activityId, self._selectReagentId)
	self._curStageCompundList, self._curStageCompundDescMap = OriginalChemyMengMengController.instance:showCurStageCompound(self._activityId, self._selectStage)

	self._scrollListDrug:reloadData(self._reagentCfgs)
	self._scrollListWarehouse:reloadData(self._curStageCompundList)
	self:_updateGuide()
	self:_updateChallenge()
end

function OriginAlchemyMengMengLevelView:_updateMaterialCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local hasNum = checknumber(self._compoundMap[data])
	local needNum = checknumber(self._curNeedMatMap[data])
	local compoundCfg = OriginalChemyMengMengConfig.instance:getCompoundCfg(self._activityId, data) or {}
	local curColor = needNum <= hasNum and "green" or "red"

	txtNum.text = string.format("<color=%s>%s</color>/%s", curColor, hasNum, needNum)

	MaterialMgr.setCellByCfg(compoundCfg.materialStr, item)
end

function OriginAlchemyMengMengLevelView:_clearMaterialCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function OriginAlchemyMengMengLevelView:_updateDrugCell(view, cell, data)
	local imgDrug = goutil.findChild(cell, "imgDrug")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local used = goutil.findChild(cell, "used")
	local txtDrug = goutil.findChildTextComponent(cell, "txtDrug")
	local hasUsed = OriginalChemyMengMengModel.instance:hasUsedReagent(self._activityId, data.reagentId)
	local hasGain = OriginalChemyMengMengModel.instance:hasGainReagent(self._activityId, data.reagentId)

	txtDrug.text = data.name

	GameUtil.SetActive(used, hasUsed)
	GameUtil.SetActive(imgSelect, self._selectReagentId == data.reagentId)
	GameUtil.addClickHandler(cell, function()
		self._selectReagentId = data.reagentId

		self:_onUpdate()
		self._scrollListDrug:reloadData(self._reagentCfgs)
	end, self)
	uGuiUtil.setSpriteToImage(imgDrug, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.resName))
end

function OriginAlchemyMengMengLevelView:_clearDrugCell(cell)
	local imgDrug = goutil.findChild(cell, "imgDrug")

	GameUtil.rmClickHandler(cell)
	uGuiUtil.clearImage(imgDrug)
end

function OriginAlchemyMengMengLevelView:_updateWarehouseCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local cfg = self._compoundCfgs[data]
	local matNum = checknumber(self._compoundMap[data])
	local matStr = cfg.materialStr

	txtName.text = cfg.compoundName
	txtDesc.text = string.format(lang("获得：%s"), self._curStageCompundDescMap[data])
	txtNum.text = matNum

	MaterialMgr.setCellByCfg(matStr, item)
end

function OriginAlchemyMengMengLevelView:_clearWarehouseCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function OriginAlchemyMengMengLevelView:_updateGuide()
	local curReagentCfg = self._reagentCfgs[self._selectReagentId]

	if curReagentCfg then
		local needCompound = OriginalChemyMengMengController.instance:getNeedCompoundIdList(self._activityId, self._selectReagentId)
		local hasUsed = OriginalChemyMengMengModel.instance:hasUsedReagent(self._activityId, self._selectReagentId)
		local hasGain = OriginalChemyMengMengModel.instance:hasGainReagent(self._activityId, self._selectReagentId)
		local canMake = OriginalChemyMengMengController.instance:canMakeReagent(self._activityId, self._selectReagentId)

		self._txtCompoundName.text = curReagentCfg.name
		self._txtCompoundEffect.text = curReagentCfg.desc

		self._scrollListMaterial:reloadData(needCompound)
		GameUtil.SetGray(self._btnMake, not canMake)
		GameUtil.SetActive(self._btnMake, not hasGain)
		GameUtil.SetActive(self._txtWaitUseGo, hasGain and not hasUsed)
	end
end

function OriginAlchemyMengMengLevelView:_updateChallenge()
	if self._stageCfgs[self._selectStage] then
		local stageCfg = self._stageCfgs[self._selectStage]

		self._txtStage.text = stageCfg.name
	end

	GameUtil.SetActive(self._finish, table.indexof(self._info.passStageId, self._selectStage))
	GameUtil.SetGray(self._btnLeft, self._selectStage <= 1)
	GameUtil.SetGray(self._btnRight, self._selectStage >= #self._stageCfgs)
end

function OriginAlchemyMengMengLevelView:_onResetRes()
	FloatWordMgr.instance:show(lang("进度重置成功"))

	self._selectReagentId = 1
	self._selectStage = 1

	self:_onUpdate()
end

function OriginAlchemyMengMengLevelView:_onClickBtnLeft()
	if self._selectStage == 1 then
		FloatWordMgr.instance:show(lang("已经是首关卡,无法再次选择"))

		return
	end

	self._selectStage = self._selectStage - 1

	self:_onUpdate()
end

function OriginAlchemyMengMengLevelView:_onClickBtnRight()
	if self._selectStage == #self._stageCfgs then
		FloatWordMgr.instance:show(lang("已经是最后关卡,无法再次选择"))

		return
	end

	self._selectStage = self._selectStage + 1

	self:_onUpdate()
end

function OriginAlchemyMengMengLevelView:_onClickBtnReset()
	if #checktable(self._info.passStageId) <= 0 then
		FloatWordMgr.instance:show(lang("无需重置"))

		return
	end

	if self._info.hasGainPrize then
		FloatWordMgr.instance:show(lang("已通关，无需重置"))

		return
	end

	local tipsContent = lang("确定要重置所有进度吗？重置后材料、试剂、关卡进度将全部清空，不可恢复")

	local function okFunc()
		OriginalChemyMengMengController.instance:sendPM_OriginAlchemyMengMengResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function OriginAlchemyMengMengLevelView:_onClickBtnStage()
	if table.indexof(self._info.passStageId, self._selectStage) then
		FloatWordMgr.instance:show(lang("已挑战过，不可重复挑战"))

		return
	end

	OriginalChemyMengMengModel.instance:setSelectStageMap(self._activityId, self._selectStage)
	OriginalChemyMengMengController.instance:enterBattleClg(self._activityId, self._selectStage)
end

function OriginAlchemyMengMengLevelView:_onClickBtnMake()
	local hasEnoughMatMakeReagent = OriginalChemyMengMengController.instance:canMakeReagent(self._activityId, self._selectReagentId)

	if not hasEnoughMatMakeReagent then
		FloatWordMgr.instance:show(lang("材料不足，无法制作"))

		return
	end

	OriginalChemyMengMengController.instance:sendPM_OriginAlchemyMengMengSmeltReagentReq(self._activityId, self._selectReagentId)
end

function OriginAlchemyMengMengLevelView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	if key then
		TipsFacade.instance:openRulesView(key)
	end
end

return OriginAlchemyMengMengLevelView
