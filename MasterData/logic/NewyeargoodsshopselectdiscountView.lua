-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/view/NewyeargoodsshopselectdiscountView.lua

module("logic.extensions.newyeargoodsshop.view.NewyeargoodsshopselectdiscountView", package.seeall)

local NewyeargoodsshopselectdiscountView = class("NewyeargoodsshopselectdiscountView", ViewComponent)

function NewyeargoodsshopselectdiscountView:ctor()
	NewyeargoodsshopselectdiscountView.super.ctor(self)
end

function NewyeargoodsshopselectdiscountView:unbindEvents()
	NewyeargoodsshopselectdiscountView.super.unbindEvents(self)
	self._btnNotUse:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function NewyeargoodsshopselectdiscountView:bindEvents()
	NewyeargoodsshopselectdiscountView.super.bindEvents(self)
	self._btnNotUse:AddClickListener(self._onClickbtnNotUse, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function NewyeargoodsshopselectdiscountView:buildUI()
	NewyeargoodsshopselectdiscountView.super.buildUI(self)

	self._btnNotUse = self:getBtn("noUse/btnNotUse")
	self._btnSure = self:getBtn("btnSure")
	self._notUseChooseGo = self:getGo("noUse/btnNotUse/choose")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(function()
		self:_onReloadFinish()
	end)
end

function NewyeargoodsshopselectdiscountView:onExit()
	NewyeargoodsshopselectdiscountView.super.onExit(self)
	self._scrollerList:dispose()
end

function NewyeargoodsshopselectdiscountView:onEnter()
	NewyeargoodsshopselectdiscountView.super.onEnter(self)

	local params = self:getOpenParam()

	self._goodsCfg = params[1]
	self._discountPlanId = checknumber(params[2])

	local cfgs = ActivityshopConfig.instance:getCouponCfgsByShopItemId(self._goodsCfg.activityType, self._goodsCfg.activityId, self._goodsCfg.shopItemId)
	local matType = MaterialMgr.getMatParams(self._goodsCfg.sellPrice)
	local finalCfgs = {}

	for i, v in ipairs(cfgs) do
		if v.deductMaterialType == matType and NewyeargoodsshopController.instance:isCanUseCoupon(self._goodsCfg, v.couponId) then
			table.insert(finalCfgs, v)
		end
	end

	local list = string.split(self._goodsCfg.sellPrice, ":")

	self._oriNeedType = checkint(list[1])
	self._oriNeedId = checkint(list[2])
	self._oriNeedNum = checkint(list[#list])
	self._canChooseAndHasNum = true
	self._curViewDatas = self:_sortViewDatas(finalCfgs)

	self._scrollerList:reloadData(self._curViewDatas)
end

function NewyeargoodsshopselectdiscountView:_onClickbtnNotUse()
	self._canChooseAndHasNum = true
	self._discountPlanId = 0

	self._scrollerList:refresh()
	self:_updateNotUseState()
end

function NewyeargoodsshopselectdiscountView:_onClickbtnSure()
	if self._canChooseAndHasNum then
		GlobalDispatcher:dispatch(GlobalNotify.NewYearGoodsShopSelectDiscountId, self._goodsCfg.activityType, self._goodsCfg.activityId, self._goodsCfg.shopItemId, self._discountPlanId)
		self:close()
	else
		FloatWordMgr.instance:show("道具数量不足，不可选择哦")
	end
end

function NewyeargoodsshopselectdiscountView:_updateCell(view, cell, cfg)
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

	local curPayNum = cfg.deductCount

	txtDiscount.text = self._oriNeedType ~= cfg.deductMaterialType and curPayNum or self._oriNeedNum - curPayNum

	MaterialMgr.setIcon(goPayIcon, self._oriNeedType, self._oriNeedId)

	txtLimit.text = self:_getLimitStr(cfg)

	goutil.setActive(goChoose, self._discountPlanId == cfg.couponId)
	btnChoose:AddClickListener(function()
		self._canChooseAndHasNum = hasNum > 0 or string.nilorempty(cfg.discountCost)
		self._discountPlanId = cfg.couponId

		self._scrollerList:refresh()
		self:_updateNotUseState()

		if not self._canChooseAndHasNum then
			MaterialMgr.openGetSource(matType, matId)
		end
	end)
end

function NewyeargoodsshopselectdiscountView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goPayIcon = goutil.findChild(cell.gameObject, "payIcon")

	MaterialMgr.resetAll(goIcon)
	MaterialMgr.resetAll(goPayIcon)
end

function NewyeargoodsshopselectdiscountView:_onReloadFinish()
	self:_updateNotUseState()
end

function NewyeargoodsshopselectdiscountView:_updateNotUseState()
	local selectCost = false

	for i, v in ipairs(self._curViewDatas) do
		if v.couponId == self._discountPlanId then
			selectCost = true

			break
		end
	end

	goutil.setActive(self._notUseChooseGo, not selectCost)
end

function NewyeargoodsshopselectdiscountView:_getLimitStr(cfg)
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

function NewyeargoodsshopselectdiscountView:_sortViewDatas(cfgs)
	local newCfgs = {}

	for i, v in ipairs(cfgs or {}) do
		local list2 = string.split(v.discountPrice, ":")
		local curPayNum = checkint(list2[#list2])
		local hasNum = MaterialMgr.getMatCount(v.discountCost)

		table.insert(newCfgs, {
			cfg = v,
			price = v.deductCount - self._oriNeedNum,
			hasNum = hasNum
		})
	end

	ArraySort.sortOn(newCfgs, {
		"price",
		"hasNum"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING
	})

	local finalList = {}

	for i, v in ipairs(newCfgs) do
		table.insert(finalList, v.cfg)
	end

	return finalList
end

return NewyeargoodsshopselectdiscountView
