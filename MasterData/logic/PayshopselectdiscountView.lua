-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopselectdiscountView.lua

module("logic.extensions.payshop.view.PayshopselectdiscountView", package.seeall)

local PayshopselectdiscountView = class("PayshopselectdiscountView", TableViewComponent)

function PayshopselectdiscountView:ctor()
	PayshopselectdiscountView.super.ctor(self)
end

function PayshopselectdiscountView:unbindEvents()
	PayshopselectdiscountView.super.unbindEvents(self)
	self._btnNotUse:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function PayshopselectdiscountView:bindEvents()
	PayshopselectdiscountView.super.bindEvents(self)
	self._btnNotUse:AddClickListener(self._onClickbtnNotUse, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function PayshopselectdiscountView:buildUI()
	PayshopselectdiscountView.super.buildUI(self)

	self._btnNotUse = self:getBtn("noUse/btnNotUse")
	self._btnSure = self:getBtn("btnSure")
	self._notUseChooseGo = self:getGo("noUse/btnNotUse/choose")
end

function PayshopselectdiscountView:onExit()
	PayshopselectdiscountView.super.onExit(self)
end

function PayshopselectdiscountView:onEnter()
	PayshopselectdiscountView.super.onEnter(self)

	local params = self:getOpenParam()

	self._goodsDefineId = params[1]
	self._discountPlanId = checknumber(params[2])
	self._goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._goodsDefineId)

	local cfgs = PayShopController.instance:getDiscountActiveGroup(self._goodsDefineId)
	local list = string.split(self._goodsCfg.originalGoodsId, ":")

	self._oriNeedType = list[1]
	self._oriNeedId = list[2]
	self._oriNeedNum = checkint(list[#list])
	self._canChooseAndHasNum = true
	self._curViewDatas = self:_sortViewDatas(cfgs)

	self:reloadData()
end

function PayshopselectdiscountView:_onClickbtnNotUse()
	self._canChooseAndHasNum = true
	self._discountPlanId = PayShopController.instance:getBestFreeDiscountPlanIdByGoodsDefineId(self._goodsDefineId)

	self:reloadData()
end

function PayshopselectdiscountView:_onClickbtnSure()
	if self._canChooseAndHasNum then
		GlobalDispatcher:dispatch(GlobalNotify.PayShopSelectDiscountId, self._goodsDefineId, self._discountPlanId)
		self:close()
	else
		FloatWordMgr.instance:show("道具数量不足，不可选择哦")
	end
end

function PayshopselectdiscountView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PayshopselectdiscountView:_updateCell(view, cell, cfg)
	local btnChoose = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnChoose")
	local goChoose = goutil.findChild(cell.gameObject, "btnChoose/choose")
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goPayIcon = goutil.findChild(cell.gameObject, "payIcon")
	local txtDiscount = goutil.findChildTextComponent(cell.gameObject, "txtDiscount")
	local txtLimit = goutil.findChildTextComponent(cell.gameObject, "txtLimit")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local list = string.split(cfg.discountCost, ":")
	local matType = checkint(list[1])
	local matId = checkint(list[2])
	local hasNum = MaterialFacade.instance:getMatNumber(matType, matId)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(cfg.discountCost)

	MaterialMgr.setIcon(goIcon, matType, matId)

	txtNum.text = string.format("数量：%s", hasNum)

	local list2 = string.split(cfg.discountPrice, ":")
	local matType2 = checkint(list2[1])
	local matId2 = checkint(list2[2])
	local curPayNum = checkint(list2[#list2])

	txtDiscount.text = self._oriNeedType ~= matType2 and curPayNum or curPayNum - self._oriNeedNum

	MaterialMgr.setIcon(goPayIcon, matType2, matId2)

	txtLimit.text = self:_getLimitStr(cfg)

	goutil.setActive(goChoose, self._discountPlanId == cfg.id)
	btnChoose:AddClickListener(function()
		self._canChooseAndHasNum = hasNum > 0 or string.nilorempty(cfg.discountCost)
		self._discountPlanId = cfg.id

		self:reloadData()

		if not self._canChooseAndHasNum then
			MaterialMgr.openGetSource(matType, matId)
		end
	end)
end

function PayshopselectdiscountView:_clearTableview(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goPayIcon = goutil.findChild(cell.gameObject, "payIcon")

	MaterialMgr.resetAll(goIcon)
	MaterialMgr.resetAll(goPayIcon)
end

function PayshopselectdiscountView:_onReloadFinish()
	local selectCost = false

	for i, v in ipairs(self._curViewDatas) do
		if v.id == self._discountPlanId then
			selectCost = true

			break
		end
	end

	goutil.setActive(self._notUseChooseGo, not selectCost)
end

function PayshopselectdiscountView:_getLimitStr(cfg)
	local str = cfg.discountTime

	if str == "全天" or string.nilorempty(str) then
		return "不限时"
	else
		local arr = string.split(str, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")
			local eDate = GameUtil.string2date(tem[2])

			return string.format("限%s.%s.%s前使用", eDate.year, eDate.month, eDate.day)
		end
	end

	return "未知"
end

function PayshopselectdiscountView:_sortViewDatas(cfgs)
	local newCfgs = {}

	for i, v in ipairs(cfgs or {}) do
		local list2 = string.split(v.discountPrice, ":")
		local curPayNum = checkint(list2[#list2])
		local hasNum = MaterialMgr.getMatCount(v.discountCost)
		local offlineTime = self:_getOfflineTime(v)

		table.insert(newCfgs, {
			cfg = v,
			price = curPayNum - self._oriNeedNum,
			hasNum = hasNum,
			offlineTime = offlineTime
		})
	end

	ArraySort.sortOn(newCfgs, {
		"price",
		"offlineTime",
		"hasNum"
	}, {
		ArraySort.NONE,
		ArraySort.NONE,
		ArraySort.DESCENDING
	})

	local finalList = {}

	for i, v in ipairs(newCfgs) do
		table.insert(finalList, v.cfg)
	end

	return finalList
end

function PayshopselectdiscountView:_getOfflineTime(cfg)
	local str = cfg.discountTime

	if str == "全天" or string.nilorempty(str) then
		return 0
	else
		local arr = string.split(str, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")

			return -GameUtil.string2time(tem[2])
		end
	end

	return 0
end

return PayshopselectdiscountView
