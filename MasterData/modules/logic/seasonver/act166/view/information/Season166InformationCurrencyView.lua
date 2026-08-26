-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationCurrencyView.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationCurrencyView", package.seeall)

local Season166InformationCurrencyView = class("Season166InformationCurrencyView", BaseView)

function Season166InformationCurrencyView:onInitView()
	self._gocurrency = gohelper.findChild(self.viewGO, "RightTop/#go_container/#go_currency")
	self._gocontainer = gohelper.findChild(self.viewGO, "RightTop/#go_container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166InformationCurrencyView:addEvents()
	return
end

function Season166InformationCurrencyView:removeEvents()
	return
end

function Season166InformationCurrencyView._btncurrencyOnClick(param)
	local selfObj = param.self
	local index = param.index

	selfObj:_btncurrencyClick(selfObj.param[index])
end

function Season166InformationCurrencyView:_btncurrencyClick(param)
	if not param then
		return
	end

	if self.overrideClickFunc then
		return self.overrideClickFunc(self.overrideClickFuncObj, param)
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, param, false)

	if self._callback then
		self._callback(self._callbackObj)
	end
end

function Season166InformationCurrencyView._onClick(param)
	local selfObj = param.self
	local index = param.index
	local param = selfObj.param[index]

	if not param then
		return
	end

	if type(param) == "number" then
		local currencyId = param

		CurrencyJumpHandler.JumpByCurrency(currencyId)
	elseif param.jumpFunc then
		param.jumpFunc()
	end
end

function Season166InformationCurrencyView:_editableInitView()
	gohelper.setActive(self._gocurrency, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._currencyObjs = {}
	self._currentItemIndex = nil
	self._initialized = true
end

function Season166InformationCurrencyView:setCurrencyType(currencyTypeParam)
	self.param = currencyTypeParam

	self:_onCurrencyChange()
end

function Season166InformationCurrencyView:onDestroyView()
	for _, itemObj in ipairs(self._currencyObjs) do
		itemObj.btn:RemoveClickListener()
		itemObj.btncurrency:RemoveClickListener()
	end
end

function Season166InformationCurrencyView:onOpen()
	self.actId = self.viewParam.actId or self.viewParam.activityId
	self.param = {
		Season166Config.instance:getSeasonConstNum(self.actId, Season166Enum.InfoCostId)
	}

	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onCurrencyChange, self)
	self:_onCurrencyChange()
end

function Season166InformationCurrencyView:onClose()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onCurrencyChange, self)
end

function Season166InformationCurrencyView:_onCurrencyChange()
	if not self.param then
		gohelper.setActive(self._gocontainer, false)

		return
	end

	if not self._initialized then
		return
	end

	local paramLen = #self.param
	local sibling = 1

	for index = paramLen, 1, -1 do
		local itemObj = self:getCurrencyItem(index)
		local param = self.param[index]

		gohelper.setSibling(itemObj.go, sibling)

		sibling = sibling + 1

		if param then
			local currencyID = param
			local currencyMO = CurrencyModel.instance:getCurrency(currencyID)
			local currencyCO = CurrencyConfig.instance:getCurrencyCo(currencyID)

			if currencyMO then
				if not currencyMO.quantity then
					local quantity = 0

					itemObj.txt.text = GameUtil.numberDisplay(quantity)

					itemObj.go:SetActive(true)

					local currencyname = currencyCO.icon

					UISpriteSetMgr.instance:setCurrencyItemSprite(itemObj.image, currencyname .. "_1")
				end
			end
		else
			itemObj.go:SetActive(false)
		end
	end

	if paramLen < #self._currencyObjs then
		for i = paramLen + 1, #self._currencyObjs do
			local itemObj = self:getCurrencyItem(i)

			itemObj.go:SetActive(false)
		end
	end

	gohelper.setActive(self._gocontainer, paramLen > 0)
end

function Season166InformationCurrencyView:getCurrencyItem(index)
	local currencyObj = self._currencyObjs[index]

	if not currencyObj then
		currencyObj = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gocurrency, "currency")

		currencyObj.go = go
		currencyObj.btn = gohelper.findChildButtonWithAudio(go, "#btn_currency/#btn")
		currencyObj.image = gohelper.findChildImage(go, "#btn_currency/#image")
		currencyObj.btncurrency = gohelper.findChildButtonWithAudio(go, "#btn_currency")
		currencyObj.txt = gohelper.findChildText(go, "#btn_currency/content/#txt")
		currencyObj.click = gohelper.findChild(go, "#btn_currency/click")

		currencyObj.btn:AddClickListener(self._onClick, {
			self = self,
			index = index
		})
		gohelper.setActive(currencyObj.btn, false)
		currencyObj.btncurrency:AddClickListener(self._btncurrencyOnClick, {
			self = self,
			index = index
		})

		self._currencyObjs[index] = currencyObj

		gohelper.setActive(currencyObj.go, true)
	end

	return currencyObj
end

return Season166InformationCurrencyView
