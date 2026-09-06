-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaBuffView.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaBuffView", package.seeall)

local PowerPillaBuffView = class("PowerPillaBuffView", TableViewComponent)

function PowerPillaBuffView:ctor()
	PowerPillaBuffView.super.ctor(self)
end

function PowerPillaBuffView:buildUI()
	PowerPillaBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function PowerPillaBuffView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function PowerPillaBuffView:bindEvents()
	PowerPillaBuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function PowerPillaBuffView:unbindEvents()
	PowerPillaBuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PowerPillaBuffView:onEnter()
	PowerPillaBuffView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.MPPGetBuffInfoRes, self._onGetBuffInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPUpgradeBuffRes, self._onUpgradeBuffRes, self)

	self._activityId = PowerPillaModel.instance:getActivityId()

	MaintainPowerPillaAgent.instance:sendPM_MPPGetBuffInfoReq(self._activityId)
end

function PowerPillaBuffView:onExit()
	PowerPillaBuffView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetBuffInfoRes, self._onGetBuffInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPUpgradeBuffRes, self._onUpgradeBuffRes, self)
end

function PowerPillaBuffView:_onClickClose()
	self:close()
end

function PowerPillaBuffView:_onGetBuffInfoRes()
	self:_initBuffList()
end

function PowerPillaBuffView:_onUpgradeBuffRes()
	FloatWordMgr.instance:show("提升成功")
	self:_updateBuffList()
end

function PowerPillaBuffView:_updateCell(view, cell, data)
	local btnUp = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnUp")
	local txtName = goutil.findChildTextComponent(cell, "name/txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local imgCoin = goutil.findChild(cell, "txtNum/imgCoin")
	local curBuyTimes = PowerPillaModel.instance:getBuffBuyTimes(data.type)
	local maxBuyTimes = PowerPillaConfig.instance:getBuffBuyTimes(data.type)
	local maxLevel = data.list[#data.list].level
	local curLevel = PowerPillaModel.instance:getBuffLevel(data.type)
	local isMaxLevel = maxLevel <= curLevel
	local cfg = data.list[curLevel]
	local isEnough = false
	local matName = ""

	if not isMaxLevel then
		isEnough = MaterialMgr.getMatEnough(cfg.cost)
		matName = MaterialMgr.getMaterialsNameByCfg(cfg.cost)
	end

	btnUp:AddClickListener(function()
		if curBuyTimes >= 0 and maxBuyTimes > 0 and curBuyTimes >= maxBuyTimes then
			FloatWordMgr.instance:show("周限购次数已用尽")

			return
		end

		if isMaxLevel then
			FloatWordMgr.instance:show("达到最大等级")

			return
		end

		if not isEnough then
			FloatWordMgr.instance:show(string.format("%s数量不足", matName))

			return
		end

		MaintainPowerPillaAgent.instance:sendPM_MPPUpgradeBuffReq(self._activityId, data.type)
	end)

	if not isMaxLevel then
		local matType, id, matNum = MaterialMgr.getMatParams(cfg.cost)

		MaterialMgr.setIcon(imgCoin, matType, id)

		txtNum.text = string.format("消耗：%d", matNum)

		goutil.setActive(txtNum.gameObject, true)
		GameUtil.SetGray(btnUp, false)
		goutil.setActive(btnUp.gameObject, true)
	else
		goutil.setActive(txtNum.gameObject, false)
		GameUtil.SetGray(btnUp, true)
		goutil.setActive(btnUp.gameObject, false)
	end

	txtName.text = curBuyTimes >= 0 and maxBuyTimes > 0 and string.format("%s（周限购：%d/%d）", cfg.buffName, maxBuyTimes - curBuyTimes, maxBuyTimes) or cfg.buffName
	txtDesc.text = cfg.buffDesc
end

function PowerPillaBuffView:_clearTableview(cell)
	local imgCoin = goutil.findChild(cell, "txtNum/imgCoin")

	MaterialMgr.clearIcon(imgCoin)
end

function PowerPillaBuffView:_initBuffList()
	local buffPlanId = PowerPillaModel.instance:getBuffPlanId()
	local cfgs = PowerPillaConfig.instance:getBuffTypeList(buffPlanId)
	local list = {}

	for i, v in ipairs(cfgs) do
		local element = {}

		element.type = i
		element.list = v

		table.insert(list, element)
	end

	self:updateListData(list)
end

function PowerPillaBuffView:_updateBuffList()
	self:reloadData()
end

return PowerPillaBuffView
