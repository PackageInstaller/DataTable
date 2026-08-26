-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballMapSelectView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballMapSelectView", package.seeall)

local PinballMapSelectView = class("PinballMapSelectView", BaseView)

function PinballMapSelectView:onInitView()
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_name")
	self._txtdesc1 = gohelper.findChildTextMesh(self.viewGO, "Right/#scroll_dec/Viewport/Content/#txt_dec1")
	self._txtdesc2 = gohelper.findChildTextMesh(self.viewGO, "Right/#scroll_dec/Viewport/Content/#txt_dec2")
	self._txtdesc3 = gohelper.findChildTextMesh(self.viewGO, "Right/#scroll_dec/Viewport/Content/go_item/#txt_dec3")
	self._goitem = gohelper.findChild(self.viewGO, "Right/#scroll_dec/Viewport/Content/go_item")
	self._icontype = gohelper.findChildImage(self.viewGO, "Right/#scroll_dec/Viewport/Content/go_item/#txt_dec3/#image_icon")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_start")
	self._txtCost = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_start/#txt_cost")
	self._topCurrencyRoot = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PinballMapSelectView:addEvents()
	self._btnStart:AddClickListener(self._onStartClick, self)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self.updateCost, self)
end

function PinballMapSelectView:removeEvents()
	self._btnStart:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self.updateCost, self)
end

function PinballMapSelectView:_editableInitView()
	self._items = self:getUserDataTb_()
	self._itemSelects = self:getUserDataTb_()

	for i = 1, 4 do
		self._items[i] = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_item" .. i)
		self._itemSelects[i] = gohelper.findChild(self._items[i].gameObject, "#go_select")

		local name = gohelper.findChildTextMesh(self._items[i].gameObject, "txt_name")
		local episodeCO = PinballConfig.instance:getRandomEpisode(i)

		name.text = episodeCO.name

		self.addClickCb(self, self._items[i], self.onClickSelect, self, i)
	end

	self:onClickSelect(1)
end

function PinballMapSelectView:onOpen()
	self:createCurrencyItem()
	self:updateCost()

	if not self._enough and not PinballModel.instance.isGuideAddGrain then
		GuideController.instance:dispatchEvent(GuideEvent.TriggerActive, GuideEnum.EventTrigger.Act178FoodNotEnough)
	end
end

function PinballMapSelectView:updateCost()
	local cost = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.EpisodeCost)

	cost = cost - PinballModel.instance:getCostDec()
	cost = math.max(0, cost)

	local nowFood = PinballModel.instance:getResNum(PinballEnum.ResType.Food)

	if nowFood < cost then
		self._enough = false
		self._txtCost.text = string.format("<color=#FC8A6A>-%d", cost)
	else
		self._enough = true
		self._txtCost.text = string.format("-%d", cost)
	end
end

function PinballMapSelectView:createCurrencyItem()
	local topCurrency = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}

	for _, currencyType in ipairs(topCurrency) do
		local go = self:getResInst(self.viewContainer._viewSetting.otherRes.currency, self._topCurrencyRoot)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballCurrencyItem)

		comp:setCurrencyType(currencyType)
	end
end

local indexToResType = {
	PinballEnum.ResType.Stone,
	PinballEnum.ResType.Wood,
	PinballEnum.ResType.Food,
	PinballEnum.ResType.Mine
}

function PinballMapSelectView:onClickSelect(index)
	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._goitem, true)

	self._curIndex = index

	for i = 1, 4 do
		gohelper.setActive(self._itemSelects[i], i == index)
	end

	local episodeCO = PinballConfig.instance:getRandomEpisode(index)

	if not episodeCO then
		logError("没有副本配置")

		return
	end

	self._txtname.text = episodeCO.name
	self._txtdesc1.text = episodeCO.longDesc
	self._txtdesc2.text = episodeCO.desc
	self._txtdesc3.text = episodeCO.shortDesc

	local resType = indexToResType[episodeCO.type]

	if not resType then
		return
	end

	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][resType]

	UISpriteSetMgr.instance:setAct178Sprite(self._icontype, resCo.icon)
end

function PinballMapSelectView:_onStartClick()
	if not self._enough then
		local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballEnum.ResType.Food]

		GameFacade.showToast(ToastEnum.DiamondBuy, resCo.name)

		return
	end

	local episodeCO = PinballConfig.instance:getRandomEpisode(self._curIndex, PinballModel.instance.leftEpisodeId)

	if not episodeCO then
		logError("随机关卡失败，index：" .. tostring(self._curIndex))

		return
	end

	PinballModel.instance.leftEpisodeId = episodeCO.id

	Activity178Rpc.instance:sendAct178StartEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.leftEpisodeId, self._onReq, self)
end

function PinballMapSelectView:_onReq(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.PinballGameView, {
		index = self._curIndex
	})
	ViewMgr.instance:openView(ViewName.PinballStartLoadingView)
	self:closeThis()
end

return PinballMapSelectView
