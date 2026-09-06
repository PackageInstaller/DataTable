-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshoppetdetailMountAttrPart.lua

module("logic.extensions.payshop.view.PayshoppetdetailMountAttrPart", package.seeall)

local PayshoppetdetailMountAttrPart = class("PayshoppetdetailMountAttrPart", BaseLuaOnce)

PayshoppetdetailMountAttrPart.TabConst = {
	Attr = 1,
	NoAttr = 2
}

function PayshoppetdetailMountAttrPart:unbindEvents()
	PayshoppetdetailMountAttrPart.super.unbindEvents(self)
	self._btnNoAttr:RemoveClickListener()
	self._btnAttr:RemoveClickListener()
end

function PayshoppetdetailMountAttrPart:bindEvents()
	PayshoppetdetailMountAttrPart.super.bindEvents(self)
	self._btnNoAttr:AddClickListener(self._onClickbtnNoAttr, self)
	self._btnAttr:AddClickListener(self._onClickbtnAttr, self)
end

function PayshoppetdetailMountAttrPart:buildUI()
	PayshoppetdetailMountAttrPart.super.buildUI(self)

	self._sliders = {}

	for i = 1, 4 do
		local attr = {}

		attr.go = goutil.findChild(self.mainGO, "mountRoot/attribute/attr" .. i)
		attr._txtVal = goutil.findChildTextComponent(attr.go, "txtVal")
		attr._txtName = goutil.findChildTextComponent(attr.go, "txtName")
		attr._txtBarrage = goutil.findChildTextComponent(attr.go, "txtBarrage")
		attr._goBarrage = goutil.findChild(attr.go, "txtBarrage")
		attr._icon = GameUtil.getUIImageSpriteChange(goutil.findChild(attr.go, "icon"))

		table.insert(self._sliders, attr)
	end

	self._txtVal = goutil.findChildTextComponent(self.mainGO, "mountRoot/tupoAttr/tupoAttr/txtVal")
	self._txtTupoName = goutil.findChildTextComponent(self.mainGO, "mountRoot/tupoAttr/tupoAttr/txtName")
	self._tupoAttrGo = self:getGo("mountRoot/tupoAttr")
	self._txtEmptyGo = self:getGo("mountRoot/text/txtEmpty")
	self._attributeGo = self:getGo("mountRoot/attribute")
	self._btnNoAttr = self:getBtn("tabroot/btns/btnNoAttr")
	self._btnAttr = self:getBtn("tabroot/btns/btnAttr")
	self._tabRootGo = self:getGo("tabroot")

	local scrollerGo = self:getGo("tabroot/tableview")
	local cellGo = self:getGo("tabroot/tablecell")

	self._tableview = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self._bgChange = {}
	self._bgChange[PayshoppetdetailMountAttrPart.TabConst.Attr] = self:getGo("tabroot/btns/btnAttr/bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self._bgChange[PayshoppetdetailMountAttrPart.TabConst.NoAttr] = self:getGo("tabroot/btns/btnNoAttr/bg"):GetComponent(ComponentType.UIImageSpriteChange)
end

function PayshoppetdetailMountAttrPart:onExit()
	PayshoppetdetailMountAttrPart.super.onExit(self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._NotifyPayShopItemBuySucRes, self)

	self._currSelectTab = nil

	self._tableview:dispose()
end

function PayshoppetdetailMountAttrPart:onEnter(mountId, shopItemId, showMulTal)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._NotifyPayShopItemBuySucRes, self)

	self._shopItemId = shopItemId
	self._selectMountId = mountId

	self:_refreshMountAttr(mountId)
	goutil.setActive(self._tabRootGo, showMulTal)

	if showMulTal then
		self:_switchTab(self._currSelectTab or PayshoppetdetailMountAttrPart.TabConst.Attr)
	end
end

function PayshoppetdetailMountAttrPart:_switchTab(tab)
	self._currSelectTab = tab

	for k, v in pairs(self._bgChange) do
		v:SetState(k == self._currSelectTab and 1 or 0)
	end

	self:_refreshItems()
end

function PayshoppetdetailMountAttrPart:_loadMountActiveData()
	self._mountActiveItems = {}

	local mounts = MountModel.instance:getLockmounts()
	local mountsKV = {}

	for i, v in ipairs(mounts) do
		mountsKV[v.mountId] = true
	end

	local mountCfgs = MountConfig.instance:getAllMounts()

	for i, v in ipairs(mountCfgs) do
		local arr = string.split(v.activationItem, ":")
		local newKey = string.format("%s:%s", arr[1], arr[2])

		self._mountActiveItems[newKey] = {
			mountId = v.id,
			isActive = mountsKV[v.id],
			mountCfg = v
		}
	end
end

function PayshoppetdetailMountAttrPart:_refreshItems()
	self:_loadMountActiveData()

	if self._goodsDatas == nil then
		self._goodsDatas = {}

		local datas = PayShopModel.instance:getMiBaoGoodDatasByTabId(43)
		local arr, newKey, list, goodsCfg

		for k, v in pairs(datas or {}) do
			goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.id)

			for i, str in ipairs((string.split(goodsCfg.content, "#"))) do
				arr = string.split(str, ":")
				newKey = string.format("%s:%s", arr[1], arr[2])

				if self._mountActiveItems[newKey] then
					table.insert(self._goodsDatas, {
						goodsCfg = goodsCfg,
						activeKey = newKey,
						mountId = self._mountActiveItems[newKey].mountId,
						mountCfg = self._mountActiveItems[newKey].mountCfg
					})
				end
			end
		end
	end

	local curId = checknumber(MountModel.instance:getCurMountId())

	self._finalDatas = {}

	for k, v in pairs(self._goodsDatas) do
		local mountCfg = self._mountActiveItems[v.activeKey].mountCfg

		if self._currSelectTab == PayshoppetdetailMountAttrPart.TabConst.Attr then
			if not string.nilorempty(mountCfg.sqContent) then
				table.insert(self._finalDatas, v)
			end
		elseif self._currSelectTab == PayshoppetdetailMountAttrPart.TabConst.NoAttr and string.nilorempty(mountCfg.sqContent) then
			table.insert(self._finalDatas, v)
		end
	end

	table.sort(self._finalDatas, function(a, b)
		local aId = a.mountId
		local bId = b.mountId
		local alock = MountController.instance:getIfLock(aId) or self:_checkHasActiveItem(a.activeKey)
		local block = MountController.instance:getIfLock(bId) or self:_checkHasActiveItem(b.activeKey)

		if curId == aId then
			return true
		end

		if curId == bId then
			return false
		end

		if alock and block then
			return aId < bId
		elseif alock or block then
			return alock
		else
			return aId < bId
		end
	end)
	self._tableview:reloadData(self._finalDatas)
end

function PayshoppetdetailMountAttrPart:_updateCell(view, cell, goodsData)
	local data = goodsData.mountCfg
	local unlock = MountController.instance:getIfLock(data.id)
	local txtStarName = goutil.findChildTextComponent(cell, "txtStarName")
	local select = goutil.findChild(cell, "select")
	local lock = goutil.findChild(cell, "lock")
	local tabImg = cell.gameObject:GetComponent("UIImageSpriteChange")
	local redPoint = goutil.findChild(cell, "imgRed")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")

	tabImg:SetState(data.id - 1)

	txtStarName.text = data.name
	unlock = unlock or self:_checkHasActiveItem(goodsData.activeKey)

	GameUtil.SetActive(tag, false)

	if not string.nilorempty(data.sqContent) then
		GameUtil.SetActive(tag, true)

		txtTag.text = data.sqContent
	end

	GameUtil.SetActive(lock, not unlock)
	GameUtil.SetActive(select, data.id == self._selectMountId)
	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data, cell.data, goodsData.goodsCfg.id))
	GameUtil.SetActive(redPoint, false)
end

function PayshoppetdetailMountAttrPart:_onClickCell(data, index, goodsId)
	self._selectMountId = data.id

	self:_refreshMountAttr(data.id)
	self._tableview:refresh(self._finalDatas)
	GlobalDispatcher:dispatch(GlobalNotify.PayShopSelectMountId, self._selectMountId, goodsId)
end

function PayshoppetdetailMountAttrPart:_clearTableview(cell)
	return
end

function PayshoppetdetailMountAttrPart:_refreshMountAttr(mountId)
	local level = MountModel.instance:getMaxLevel(mountId)
	local attMaxList = MountModel.instance:getAttMax(mountId, level)
	local hasAttr = attMaxList and #attMaxList > 0

	goutil.setActive(self._attributeGo, hasAttr)
	goutil.setActive(self._txtEmptyGo, not hasAttr)

	if hasAttr then
		for i, attr in ipairs(self._sliders) do
			local type = attMaxList[i].type

			attr._txtVal.text = checknumber(attMaxList[i].value)
			attr._txtName.text = ConstString.Attr[type]

			attr._icon:SetState(checknumber(type) - 1)
		end

		local activationAtts = MountModel.instance:getActivationAtt(mountId)
		local maxData = activationAtts[#activationAtts]
		local arr = string.split(maxData.attribute, "+")
		local id = table.indexof(GameEnum.AttrTypeName, arr[1])
		local value = checknumber(arr[2])
		local propertyVal = GameUtil.GetPropertyValue(id, value)
	end

	local datas = MountModel.instance:getActivationAtt(mountId)
	local maxData = datas[#datas]

	goutil.setActive(self._tupoAttrGo, hasAttr and maxData)

	if maxData then
		local arr = string.split(maxData.attribute, "+")
		local id = table.indexof(GameEnum.AttrTypeName, arr[1])
		local value = checknumber(arr[2])
		local propertyVal = GameUtil.GetPropertyValue(id, value)

		self._txtTupoName.text = "全体上阵精灵" .. arr[1]
		self._txtVal.text = string.format("+%s", propertyVal)
	else
		self._txtTupoName.text = "无"
		self._txtVal.text = ""
	end
end

function PayshoppetdetailMountAttrPart:_NotifyPayShopItemBuySucRes()
	return
end

function PayshoppetdetailMountAttrPart:_onClickbtnNoAttr()
	self:_switchTab(PayshoppetdetailMountAttrPart.TabConst.NoAttr)
end

function PayshoppetdetailMountAttrPart:_onClickbtnAttr()
	self:_switchTab(PayshoppetdetailMountAttrPart.TabConst.Attr)
end

function PayshoppetdetailMountAttrPart:_checkHasActiveItem(activeKey)
	local arr = string.split(activeKey, ":")
	local matType = checknumber(arr[1])
	local matId = checknumber(arr[2])
	local hasNum = MaterialFacade.instance:getMatNumber(matType, matId)

	return hasNum > 0
end

return PayshoppetdetailMountAttrPart
