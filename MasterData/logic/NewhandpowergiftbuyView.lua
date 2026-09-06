-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandpowergiftbuyView.lua

module("logic.extensions.newhandwelfare.view.NewhandpowergiftbuyView", package.seeall)

local NewhandpowergiftbuyView = class("NewhandpowergiftbuyView", ViewComponent)
local json = require("cjson")

function NewhandpowergiftbuyView:ctor()
	NewhandpowergiftbuyView.super.ctor(self)
end

function NewhandpowergiftbuyView:buildUI()
	NewhandpowergiftbuyView.super.buildUI(self)

	self._btnClose = self:getBtn("BG/btnClose")
	self._btnBuy = self:getBtn("BG/btnBuy")
	self._txtGoodCost = goutil.findChildTextComponent(self.mainGO, "BG/btnBuy/txt")
	self._goItem = self:getGo("BG/item")
	self._goTableAll = self:getGo("BG/prizeAll/tableShow")
	self._goTableNow = self:getGo("BG/prizeNow/tableShow")
	self._tableviewAll = ScrollerList.create(self._goTableAll, self._goItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableviewNow = ScrollerList.create(self._goTableNow, self._goItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NewhandpowergiftbuyView:bindEvents()
	NewhandpowergiftbuyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
end

function NewhandpowergiftbuyView:unbindEvents()
	NewhandpowergiftbuyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function NewhandpowergiftbuyView:destroyUI()
	NewhandpowergiftbuyView.super.destroyUI(self)
end

function NewhandpowergiftbuyView:onEnter()
	NewhandpowergiftbuyView.super.onEnter(self)

	self._periodId = NewhandwelfareModel.instance:getPeriodId()
	self._periodCfg = NewhandwelfareConfig.instance:getPeriodCfg(self._periodId)

	local payGoodsId = NewhandwelfareConfig.instance:getCommonValue("BUY_ZDL_SUPER_PRIZE_PRICE")

	self._txtGoodCost.text = string.format("¥%s", PayConfig.instance:getPayMoneyYuan(payGoodsId))

	self:_refreshTable()
end

function NewhandpowergiftbuyView:onEnterFinished()
	NewhandpowergiftbuyView.super.onEnterFinished(self)
end

function NewhandpowergiftbuyView:onExit()
	NewhandpowergiftbuyView.super.onExit(self)
	self._tableviewAll:dispose()
	self._tableviewNow:dispose()
end

function NewhandpowergiftbuyView:onExitFinished()
	NewhandpowergiftbuyView.super.onExitFinished(self)
end

function NewhandpowergiftbuyView:_refreshTable()
	local currPower = RoleModel.instance:getMaxPower()
	local dataListNow = {}
	local dataListAll = {}
	local dataListAllTemp = {}
	local dataListNowTemp = {}
	local allCfgs = NewhandwelfareConfig.instance:getZdlRewardCfgs(self._periodId)

	for _, v in ipairs(allCfgs) do
		local arr1 = string.split(v.superPrize, "#")

		for _, matStr in ipairs(arr1) do
			local arr2 = string.split(matStr, ":")
			local matType = checkint(arr2[1])
			local matId = checkint(arr2[2])
			local matNum = checkint(arr2[3])

			dataListAllTemp[matType] = dataListAllTemp[matType] or {}
			dataListAllTemp[matType][matId] = dataListAllTemp[matType][matId] or 0
			dataListAllTemp[matType][matId] = dataListAllTemp[matType][matId] + matNum

			if currPower >= v.needZdl then
				dataListNowTemp[matType] = dataListNowTemp[matType] or {}
				dataListNowTemp[matType][matId] = dataListNowTemp[matType][matId] or 0
				dataListNowTemp[matType][matId] = dataListNowTemp[matType][matId] + matNum
			end
		end
	end

	for matType, list in pairs(dataListAllTemp) do
		for matId, matNum in pairs(list) do
			table.insert(dataListAll, {
				matType = matType,
				matId = matId,
				matNum = matNum,
				matStr = string.format("%s:%s:%s", matType, matId, matNum)
			})
		end
	end

	table.sort(dataListAll, function(a, b)
		return MaterialMgr.getGoodsQuality(a.matType, a.matId) > MaterialMgr.getGoodsQuality(b.matType, b.matId)
	end)

	for matType, list in pairs(dataListNowTemp) do
		for matId, matNum in pairs(list) do
			table.insert(dataListNow, {
				matType = matType,
				matId = matId,
				matNum = matNum,
				matStr = string.format("%s:%s:%s", matType, matId, matNum)
			})
		end
	end

	table.sort(dataListNow, function(a, b)
		return MaterialMgr.getGoodsQuality(a.matType, a.matId) > MaterialMgr.getGoodsQuality(b.matType, b.matId)
	end)

	if dataListNow == nil or #dataListNow == 0 or GameUtil.isEmptyString(dataListNow[1]) then
		self._tableviewNow:regGetDataLen(function()
			return 0
		end)
	else
		self._tableviewNow:regGetDataLen(function()
			return #dataListNow
		end)
	end

	self._tableviewNow:reloadData(dataListNow)

	if dataListAll == nil or #dataListAll == 0 or GameUtil.isEmptyString(dataListAll[1]) then
		self._tableviewAll:regGetDataLen(function()
			return 0
		end)
	else
		self._tableviewAll:regGetDataLen(function()
			return #dataListAll
		end)
	end

	self._tableviewAll:reloadData(dataListAll)
end

function NewhandpowergiftbuyView:_clearCell(cell)
	local point = goutil.findChild(cell, "point")

	MaterialMgr.resetAll(point)
end

function NewhandpowergiftbuyView:_updateCell(view, cell, data)
	local point = goutil.findChild(cell, "point")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	if data then
		MaterialMgr.setCellByCfg(data.matStr, point)

		txtName.text = MaterialMgr.getMaterialsNameByCfg(data.matStr)
	else
		MaterialMgr.resetAll(point)
	end
end

function NewhandpowergiftbuyView:_onClickBtnBuy()
	if NewhandwelfareModel.instance:isBuyZDLSuperPrize() then
		FloatWordMgr.instance:show("已购买")

		return
	end

	local payGoodsId = NewhandwelfareConfig.instance:getCommonValue("BUY_ZDL_SUPER_PRIZE_PRICE")

	PayController.instance:pay(payGoodsId, GameEnum.PaySubGoodsType.NEW_HAND_WELFARE, 1)
	self:close()
end

return NewhandpowergiftbuyView
