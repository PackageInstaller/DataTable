-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/view/KingNuoyaBuffView.lua

module("logic.extensions.kingnuoya.view.KingNuoyaBuffView", package.seeall)

local KingNuoyaBuffView = class("KingNuoyaBuffView", TableViewComponent)

function KingNuoyaBuffView:ctor()
	KingNuoyaBuffView.super.ctor(self)
end

function KingNuoyaBuffView:unbindEvents()
	KingNuoyaBuffView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClose)
end

function KingNuoyaBuffView:bindEvents()
	KingNuoyaBuffView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function KingNuoyaBuffView:buildUI()
	KingNuoyaBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	GameUtil.SetActive(self._btnClose, true)

	self._btnGet = self:getBtn("btnGet")
	self._txtBtnSure = self:getTxt("btnGet/Text")
	self._singleLine = self:getGo("cellcon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._ContentTr = self:getGo("tableview/Viewport/Content").transform
end

function KingNuoyaBuffView:onExit()
	KingNuoyaBuffView.super.onExit(self)
end

function KingNuoyaBuffView:onEnter()
	KingNuoyaBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._curType = params[2]
	self._curStepId = params[3]
	self._challengeId = params[4]

	local stageCfg = KingNuoyaChallengeConfig.instance:getStageCfgById(self._activityId, self._challengeId)

	if not stageCfg.buffPlans then
		self._buffCfgs = self:_getBuffCfgs(stageCfg.buffPlans)

		if self._buffCfgs[1] then
			self._currBuffId = self._buffCfgs[1].buffPlanId or 0
		end

		self._curViewDatas = self._buffCfgs

		self:reloadData()
	end
end

function KingNuoyaBuffView:_getBuffCfgs(buffIds)
	local cfgs = {}
	local isUseBuffIds = {}

	for i, buffId in ipairs(buffIds) do
		if buffId > 0 and not isUseBuffIds[buffId] then
			local cfg = KingNuoyaChallengeConfig.instance:getBuffCfgById(self._activityId, buffId)

			table.insert(cfgs, cfg)

			isUseBuffIds[buffId] = true
		end
	end

	return cfgs
end

function KingNuoyaBuffView:_onClickbtnGet()
	if self._currBuffId <= 0 then
		FloatWordMgr.instance:show("请先选择Buff")

		return
	end

	KingNuoyaChallengeController.instance:openFmtView(self._activityId, self._curType, self._curStepId, self._challengeId, self._currBuffId)
	self:close()
end

function KingNuoyaBuffView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function KingNuoyaBuffView:_updateCell(view, cell, buffCfg)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goSelect = goutil.findChild(cell.gameObject, "select")

	txtName.text = buffCfg.name
	txtDesc.text = buffCfg.desc

	local spriteName = GameUrl.getExpEventUrl(buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(goBuffIcon, nil, spriteName)
	goutil.setActive(goSelect, self._currBuffId == buffCfg.buffPlanId)
	btn:AddClickListener(function()
		if self._currBuffId == buffCfg.buffPlanId then
			return
		end

		self._currBuffId = buffCfg.buffPlanId

		self:reloadData()
	end)
end

function KingNuoyaBuffView:_clearTableview(cell)
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")

	uGuiUtil.clearImage(goBuffIcon)
end

function KingNuoyaBuffView:_onReloadFinish()
	if self._curViewDatas and #self._curViewDatas <= 3 then
		for i = self._ContentTr.childCount, 1, -1 do
			self._ContentTr:GetChild(i - 1):SetParent(self._singleLine.gameObject.transform)
		end

		self._singleLine:Layout()
	end
end

return KingNuoyaBuffView
