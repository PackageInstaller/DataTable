-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/view/EndlessDarkClgLevelUpView.lua

module("logic.extensions.endlessdark.view.EndlessDarkClgLevelUpView", package.seeall)

local EndlessDarkClgLevelUpView = class("EndlessDarkClgLevelUpView", ViewComponent)

function EndlessDarkClgLevelUpView:ctor()
	EndlessDarkClgLevelUpView.super.ctor(self)
end

function EndlessDarkClgLevelUpView:unbindEvents()
	EndlessDarkClgLevelUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._imgCoin)
end

function EndlessDarkClgLevelUpView:bindEvents()
	EndlessDarkClgLevelUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._imgCoin, self._onClickTips, self)
end

function EndlessDarkClgLevelUpView:buildUI()
	EndlessDarkClgLevelUpView.super.buildUI(self)

	self._txtCoinNum = self:getTxt("txtCoin/txtCoinNum")
	self._btnClose = self:getGo("btnClose")
	self._imgCoin = self:getGo("txtCoin/imgCoin")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)
end

function EndlessDarkClgLevelUpView:onExit()
	EndlessDarkClgLevelUpView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgCoin)
	self._scrollList:dispose()
end

function EndlessDarkClgLevelUpView:onEnter()
	EndlessDarkClgLevelUpView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_EndlessDarkClgUpgradeBuffRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 555001
	end

	self._buffTypeList = EndlessDarkClgConfig.instance:getBuffTypeList(self._activityId)

	self._scrollList:reloadData(self._buffTypeList)

	self._info = EndlessDarkClgModel.instance:getInfo(self._activityId)
	self._buffMap = EndlessDarkClgModel.instance:getBuffMap(self._activityId)

	local buffCfg = EndlessDarkClgConfig.instance:getBuffCfgsById(self._activityId, 1, 1)

	self._prize = buffCfg.costItem

	local matType, matId, matNum = MaterialMgr.getMatParams(self._prize)

	MaterialMgr.setIcon(self._imgCoin, matType, matId, nil, nil)
	self:_onUpdate()
end

function EndlessDarkClgLevelUpView:_onUpdate()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._prize)

	self._txtCoinNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)
	self._buffMap = EndlessDarkClgModel.instance:getBuffMap(self._activityId)

	self._scrollList:reloadData(self._buffTypeList)
end

function EndlessDarkClgLevelUpView:_onClickTips()
	CommonTipsMgr.instance:openTipsByConfStr(self._imgCoin, self._prize)
end

function EndlessDarkClgLevelUpView:_updateCell(view, cell, data)
	local btnLvUp = goutil.findChild(cell, "btnLvUp")
	local btnChangeComp = btnLvUp:GetComponent("UIImageSpriteChange")
	local finish = goutil.findChild(cell, "finish")
	local icon = goutil.findChild(cell, "icon")
	local cost = goutil.findChild(cell, "cost")
	local iconCost = goutil.findChild(cell, "cost/icon")
	local checkbox = goutil.findChild(cell, "btnSelect/checkbox")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local txtCostNum = goutil.findChildTextComponent(cell, "cost/txtNum")
	local txtBtnLvUp = goutil.findChildTextComponent(cell, "btnLvUp/txt")
	local txtDesc = goutil.findChildTextComponent(cell, "view/viewport/content/txtDesc")
	local type = data
	local buffLv = checknumber(self._buffMap[type])
	local cfgs = EndlessDarkClgConfig.instance:getBuffCfgsByType(self._activityId, type)
	local buffCfg = EndlessDarkClgConfig.instance:getBuffCfgsById(self._activityId, type, buffLv)
	local isLock = buffLv <= 0
	local isMaxLv = buffLv >= #cfgs
	local btnStateIdx = isLock and 0 or 1
	local btnStr = "升级"

	if isMaxLv then
		btnStr = "已满级"
	elseif isLock then
		btnStr = "解锁"
	end

	if not isMaxLv then
		local nextCfg = cfgs[buffLv + 1]
		local prize = nextCfg.costItem
		local matType, matId, matNum = MaterialMgr.getMatParams(prize)

		txtCostNum.text = matNum

		MaterialMgr.setIcon(iconCost, matType, matId, nil, nil)
	end

	txtBtnLvUp.text = btnStr
	txtName.text = buffCfg.name
	txtDesc.text = buffCfg.desc
	txtLv.text = string.format("LV.%d", buffLv)

	btnChangeComp:SetState(btnStateIdx)
	GameUtil.SetActive(finish, isMaxLv)
	GameUtil.SetActive(cost, not isMaxLv)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffCfg.iconPath))
	GameUtil.addClickHandler(btnLvUp, function()
		if isMaxLv then
			FloatWordMgr.instance:show("已升至满级，无需再升级")

			return
		end

		UIStateManager.instance:push(ViewName.EndlessDarkClgLevelUpTipView, self._activityId, type)
	end, self)
end

function EndlessDarkClgLevelUpView:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")
	local iconCost = goutil.findChild(cell, "cost/icon")
	local btnLvUp = goutil.findChild(cell, "btnLvUp")

	MaterialMgr.clearIcon(iconCost)
	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(btnLvUp)
end

return EndlessDarkClgLevelUpView
