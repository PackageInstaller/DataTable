-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/currency/view/CostNodeWidget.lua

CostNodeWidget = class("CostNodeWidget", BaseWidget, _M)

function CostNodeWidget.class:createWidgetNode()
	local resFile = "asset/ui/CostNode.csb"

	return cc.CSLoader:createNode(resFile)
end

function CostNodeWidget:initialize(parent, view)
	super.initialize(self, view)

	self._meditor = parent
	self._view = view
end

function CostNodeWidget:userInject(injector)
	self._bagSystem = injector:getInstance(DevelopSystem):getBagSystem()
end

function CostNodeWidget:dispose()
	super.dispose(self)
end

function CostNodeWidget:updateView(data)
	self._data = data

	local itemId = self._data.id

	if not self._data.onlyShowNeed then
		local isOnlyShowNeed = false
		local iconpanel = self._view:getChildByFullName("costBg.iconpanel")
		local enoughImg = self._view:getChildByFullName("costBg.bg.enoughImg")
		local addImg = self._view:getChildByFullName("costBg.addImg")
		local costPanel = self._view:getChildByFullName("costBg.costPanel")
		local cost = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		costPanel:setVisible(true)
		iconpanel:removeAllChildren()

		local icon

		if self._data.id == CurrencyIdKind.kGold or self._data.id == CurrencyIdKind.kCrystal then
			icon = IconFactory:createResourcePic({
				scaleRatio = 0.7,
				id = self._data.id
			}, {
				largeIcon = true
			})
		else
			local iconInfo = {
				id = itemId
			}
			local style = {
				showAmount = false
			}

			icon = IconFactory:createIcon(iconInfo, style)

			icon:setScale(0.46)
		end

		icon:addTo(iconpanel):center(iconpanel:getContentSize())

		local hasNum = self._bagSystem:getItemCount(itemId)
		local needNum = self._data.needNum
		local enough = needNum <= hasNum
		local colorNum1 = enough and 1 or 7

		if isOnlyShowNeed then
			cost:setString(needNum)
			costLimit:setString("")
		else
			cost:setString(hasNum)
			costLimit:setString("/" .. needNum)
			costLimit:setPositionX(cost:getContentSize().width)
			costLimit:setTextColor(GameStyle:getColor(colorNum1))
			costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
		end

		cost:setTextColor(GameStyle:getColor(colorNum1))
		iconpanel:setGray(not enough)
		enoughImg:setVisible(enough)
		addImg:setVisible(not enough)

		local touchPanel = addImg:getChildByFullName("touchPanel")

		touchPanel:setVisible(true)
		touchPanel:setTouchEnabled(true)
		touchPanel:addClickEventListener(function()
			self:showResource()
		end)
	end
end

function CostNodeWidget:showResource()
	if self._data.clickFun then
		self._data.clickFun()
	elseif self._data.id == CurrencyIdKind.kGold then
		CurrencySystem:buyCurrencyByType(self._meditor, CurrencyType.kGold)
	elseif self._data.id == CurrencyIdKind.kCrystal then
		CurrencySystem:buyCurrencyByType(self._meditor, CurrencyType.kCrystal)
	else
		local param = {
			isNeed = true,
			hasWipeTip = true,
			itemId = self._data.id,
			hasNum = self._bagSystem:getItemCount(itemId),
			needNum = self._data.needNum
		}
		local view = self:getInjector():getInstance("sourceView")

		self._meditor:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param, nil))
	end
end
