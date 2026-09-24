-- chunkname: @modules/logic/decorate/view/DecoratePackageLeftView.lua

module("modules.logic.decorate.view.DecoratePackageLeftView", package.seeall)

local DecoratePackageLeftView = class("DecoratePackageLeftView", BaseView)
local CELL_HEIGHT = 168
local CELL_SPACE_V = 16
local START_SPACE = 100
local END_SPACE = 100

function DecoratePackageLeftView:onInitView()
	self._goScroll = gohelper.findChild(self.viewGO, "root/Scrollview")
	self._goContent = gohelper.findChild(self.viewGO, "root/Scrollview/Viewport/Content")
	self._goTabitem = gohelper.findChild(self.viewGO, "root/Scrollview/Viewport/Content/#go_Tabitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecoratePackageLeftView:addEvents()
	return
end

function DecoratePackageLeftView:removeEvents()
	return
end

function DecoratePackageLeftView:_onClickPackageLeftTab(index)
	self:_refreshSelectTab(index)
end

function DecoratePackageLeftView:_editableInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root")

	gohelper.setActive(self._goTabitem, false)

	self._tabItems = self:getUserDataTb_()
end

function DecoratePackageLeftView:onUpdateParam()
	return
end

function DecoratePackageLeftView:onOpen()
	self._goodsId = self.viewParam.goodsId
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)
	self._goodsIds = self.viewParam.goodsIds
	self._goodsIdConfigs = {}
	self._selectTabIndex = 1

	for i, id in ipairs(self._goodsIds) do
		if self._goodsId == id then
			self._selectTabIndex = i
		end

		self._goodsIdConfigs[i] = DecorateStoreConfig.instance:getDecorateConfig(id)
	end

	self:onRefresh(self._goodsIdConfigs)
	self:_refreshSelectTab(self._selectTabIndex)
end

function DecoratePackageLeftView:onShow(isShow)
	gohelper.setActive(self._goroot, isShow)
end

function DecoratePackageLeftView:_refreshSelectTab(index)
	for i, item in pairs(self._tabItems) do
		gohelper.setActive(item.goselect, i == index)
		gohelper.setActive(item.gounselect, i ~= index)

		local scale = i == index and 1.16 or 1

		transformhelper.setLocalScale(item.go.transform, scale, scale, scale)
	end
end

function DecoratePackageLeftView:onRefresh(list)
	if not self._tabItems then
		return
	end

	if list and #list > 1 then
		for i, co in ipairs(list) do
			local bundleBuylmg = co.bundleBuylmg
			local item = self:_getTabItem(i)
			local goodsCo = StoreConfig.instance:getGoodsConfig(co.id)
			local itemCos = goodsCo and GameUtil.splitString2(goodsCo.product, true)
			local icon

			if not itemCos or #itemCos > 1 then
				if not string.nilorempty(bundleBuylmg) then
					icon = ResUrl.getDecorateStoreImg(bundleBuylmg)
				end
			else
				local item = itemCos[1]
				local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(item[1], item[2])

				icon = itemIcon
			end

			if not string.nilorempty(icon) then
				item.simageicon:LoadImage(icon)
			end
		end
	end

	if list and #list > 1 then
		if not #list then
			local count = 0
			local startSpace = START_SPACE

			for i, item in pairs(self._tabItems) do
				if i <= count then
					local _height = (CELL_HEIGHT + CELL_SPACE_V) * (count - 1)
					local pageHeight = recthelper.getHeight(self._goScroll.transform)

					if _height < pageHeight then
						startSpace = (pageHeight - _height) * 0.5
					end

					local y = -((CELL_HEIGHT + CELL_SPACE_V) * (i - 1) + startSpace)

					recthelper.setAnchorY(item.go.transform, y)
				end

				gohelper.setActive(item.go, i <= count)
			end

			local height = (CELL_HEIGHT + CELL_SPACE_V) * (count - 1) + startSpace + END_SPACE

			recthelper.setHeight(self._goContent.transform, height)
		end
	end
end

function DecoratePackageLeftView:_getTabItem(index)
	local item = self._tabItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goTabitem)
		item.goselect = gohelper.findChild(item.go, "select")
		item.simagerare = gohelper.findChildSingleImage(item.go, "#image_rare")
		item.gospbg = gohelper.findChild(item.go, "#go_spbg")
		item.simageicon = gohelper.findChildSingleImage(item.go, "#image_icon")
		item.gounselect = gohelper.findChild(item.go, "unselect")
		item.btn = gohelper.getClickWithDefaultAudio(item.go)

		item.btn:AddClickListener(self._onClickTabOnClick, self, index)

		self._tabItems[index] = item
	end

	return item
end

function DecoratePackageLeftView:_onClickTabOnClick(index)
	if self._selectTabIndex == index then
		return
	end

	self._selectTabIndex = index
	self._goodsId = self._goodsIds[index]

	self.viewContainer:setGoodsTab(self._goodsId)
	self:_refreshSelectTab(index)
end

function DecoratePackageLeftView:onClose()
	for i, item in pairs(self._tabItems) do
		item.btn:RemoveClickListener()
		item.simageicon:UnLoadImage()
		item.simagerare:UnLoadImage()
	end
end

function DecoratePackageLeftView:onDestroyView()
	return
end

return DecoratePackageLeftView
