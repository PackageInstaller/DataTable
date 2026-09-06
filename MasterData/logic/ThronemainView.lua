-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronemainView.lua

module("logic.extensions.throne.view.ThronemainView", package.seeall)

local ThronemainView = class("ThronemainView", TableViewComponent)
local TabDatas = {
	{
		name = "科技",
		id = GameEnum.ThroneTabType.Keji
	},
	{
		name = "武器",
		id = GameEnum.ThroneTabType.Baowu
	},
	{
		name = "工艺",
		id = GameEnum.ThroneTabType.Shengqi
	},
	{
		name = "手办",
		id = GameEnum.ThroneTabType.Baijian
	},
	{
		name = "全部",
		id = GameEnum.ThroneTabType.All
	}
}

function ThronemainView:ctor()
	ThronemainView.super.ctor(self)
end

function ThronemainView:buildUI()
	ThronemainView.super.buildUI(self)

	self._roleImg = self:getBtn("roleImg")
	self._roleImgDot = self:getGo("roleImg/dot")
	self._closeBtn = self:getBtn("closeBtn")
	self._wishBtn = self:getBtn("wishBtn")
	self._addText = goutil.findChildTextComponent(self.mainGO, "addText")
	self._goodsBg = self:getBtn("goodsBg")
	self._goodsItemCon = self:getGo("goodsBg/item")
	self._subCon = self:getGo("subCon")
	self._helpBtn = self:getBtn("helpBtn")
	self._roleCon = self:getGo("roleImg/con")
	self._btnOneKey = self:getGo("btnOneKey")
	self._btnCompose = self:getBtn("btnCompose")
end

function ThronemainView:bindEvents()
	ThronemainView.super.bindEvents(self)
	self._roleImg:AddClickListener(self._onClickroleImg, self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
	self._wishBtn:AddClickListener(self._onClickwishBtn, self)
	self._goodsBg:AddClickListener(self._onClickGoodsBg, self)
	self._helpBtn:AddClickListener(self._onClickhelpBtn, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	self._btnCompose:AddClickListener(self._onClickbtnCompose, self)
end

function ThronemainView:unbindEvents()
	ThronemainView.super.unbindEvents(self)
	self._roleImg:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._wishBtn:RemoveClickListener()
	self._goodsBg:RemoveClickListener()
	self._helpBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnOneKey)
	self._btnCompose:RemoveClickListener()
end

function ThronemainView:destroyUI()
	ThronemainView.super.destroyUI(self)
end

function ThronemainView:onEnter()
	ThronemainView.super.onEnter(self)
	GlobalDispatcher:addListener(ThroneController.PM_LoadAllThronesRes, self._updateView, self)
	GlobalDispatcher:addListener(ThroneController.PM_GetThronePanelOtherInfoRes, self._updateReward, self)
	GlobalDispatcher:addListener(ThroneController.PM_GainThroneDailyPrizeRes, self._updateReward, self)
	GlobalDispatcher:addListener(ThroneController.UpdateRedDot, self._checkRedDot, self)
	GlobalDispatcher:addListener(ThroneController.PM_NotifyThronesChangeRes, self._updateAddAttr, self)
	RedPointController.instance:regRedPoint(self._roleImgDot, RedPointModel.ID_THRONE_ACHIEVE)

	self._curViewDatas = TabDatas

	self:_switchTab(GameEnum.ThroneTabType.All, true)
	self:_setRole()
	ThroneController.instance:sendPM_LoadAllThronesReq()
	ThroneAgent.instance:sendPM_GetThronePanelOtherInfoReq()
end

function ThronemainView:onEnterFinished()
	ThronemainView.super.onEnterFinished(self)
end

function ThronemainView:onExit()
	ThronemainView.super.onExit(self)
	MaterialMgr.resetAll(self._goodsItemCon)
	RedPointController.instance:unregRedPoint(self._roleImgDot)
	GlobalDispatcher:removeListener(ThroneController.PM_LoadAllThronesRes, self._updateView, self)
	GlobalDispatcher:removeListener(ThroneController.PM_GetThronePanelOtherInfoRes, self._updateReward, self)
	GlobalDispatcher:removeListener(ThroneController.PM_GainThroneDailyPrizeRes, self._updateReward, self)
	GlobalDispatcher:removeListener(ThroneController.UpdateRedDot, self._checkRedDot, self)
	GlobalDispatcher:removeListener(ThroneController.PM_NotifyThronesChangeRes, self._updateAddAttr, self)
	RoleObjectPool.instance:removeRole(self._obj)
end

function ThronemainView:onExitFinished()
	ThronemainView.super.onExitFinished(self)
end

function ThronemainView:_onClickroleImg()
	UIStateManager.instance:push(ViewName.ThronerewardView)
end

function ThronemainView:_onClickcloseBtn()
	self:close()
end

function ThronemainView:_onClickwishBtn()
	return
end

function ThronemainView:_onClickhelpBtn()
	TipsFacade.instance:openRulesView("thronemainview")
end

function ThronemainView:_switchTab(tab, force)
	if self._lastTab == tab and not force then
		return
	end

	self._lastTab = tab

	self:reloadData()
	self:_updateView()
end

function ThronemainView:_updateView()
	UIStateManager.instance:popByName(ViewName.ThronegoodsView)
	self:showTabAt(self._subCon, ViewName.ThronegoodsView, self._lastTab)
	self:_updateAddAttr()
end

function ThronemainView:_updateAddAttr()
	local list = ThroneModel.instance:getRoleThroneAttr(true)

	if list then
		local temp = {}

		for k, v in pairs(list) do
			table.insert(temp, string.format("%s+%s", k, v))
		end

		self._addText.text = table.concat(temp, " ")
	else
		self._addText.text = "无"
	end
end

function ThronemainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function ThronemainView:_updateCell(view, cell, data)
	local selectGo = goutil.findChild(cell.gameObject, "select")
	local redDot = goutil.findChild(cell.gameObject, "dot")
	local btn = GameUtil.asBtn(goutil.findChild(cell.gameObject, "imgBg"))
	local nameText = goutil.findChildTextComponent(cell.gameObject, "text")

	goutil.setActive(redDot, ThroneModel.instance:checkRedDotByShowType(data.id))
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_switchTab(data.id)
	end)

	nameText.text = data.name

	goutil.setActive(selectGo, data.id == self._lastTab)
end

function ThronemainView:_clearTableview(cell)
	return
end

function ThronemainView:_updateReward()
	local hasGain = ThroneModel.instance:hasGainDailyPrize()

	if hasGain then
		goutil.setActive(self._goodsBg.gameObject, false)

		return
	end

	local str = ThroneConfig.instance:getDailyPrizeStr()

	goutil.setActive(self._goodsBg.gameObject, not string.nilorempty(str))
	MaterialMgr.setCellByCfg(str, self._goodsItemCon)
end

function ThronemainView:_onClickGoodsBg()
	ThroneAgent.instance:sendPM_GainThroneDailyPrizeReq()
end

function ThronemainView:_checkRedDot()
	self:reloadData()
end

function ThronemainView:_setRole()
	self._obj = RoleObjectPool.instance:addRoleToParent(self._obj, 80001, self._roleCon, 1, nil, false)
end

function ThronemainView:_onClickOneKey()
	local cfgs = ThroneConfig.instance:getThroneCfgs()
	local isCanUpgrade = false

	for i, v in ipairs(cfgs) do
		if ThroneModel.instance:checkThronCanUpgradeRedDot(v.id) == true then
			isCanUpgrade = true

			break
		end
	end

	if isCanUpgrade == true then
		ThroneAgent.instance:sendPM_OneClickUpgradeThroneReq()
	else
		FloatWordMgr.instance:show(lang("无可用升级"))
	end
end

function ThronemainView:_onClickbtnCompose()
	GotoMgr.gotoByString("ui#equipfactory#2")
end

return ThronemainView
