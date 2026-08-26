-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballBuildView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballBuildView", package.seeall)

local PinballBuildView = class("PinballBuildView", BaseView)

function PinballBuildView:onInitView()
	self._golist = gohelper.findChild(self.viewGO, "#go_list")
	self._goitem = gohelper.findChild(self._golist, "#go_item")
	self._gobuild = gohelper.findChild(self.viewGO, "#go_build")
	self._godone = gohelper.findChild(self.viewGO, "#go_done")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "#txt_title")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "#scroll_dec/Viewport/Content/#txt_dec")
	self._btnBuild = gohelper.findChildButtonWithAudio(self.viewGO, "#go_build/#btn_build")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_lock/#btn_lock")
	self._goeffectitem = gohelper.findChild(self.viewGO, "#go_add/go_item")
	self._gocostitem1 = gohelper.findChild(self.viewGO, "#go_build/#go_currency/go_item")
	self._gocostitem2 = gohelper.findChild(self.viewGO, "#go_lock/#go_currency/go_item")
	self._topCurrencyRoot = gohelper.findChild(self.viewGO, "#go_topright")
end

function PinballBuildView:addEvents()
	self._btnClose:AddClickListener(self.onClickModalMask, self)
	self._btnBuild:AddClickListener(self.onBuildClick, self)
	self._btnLock:AddClickListener(self.onLockClick, self)
end

function PinballBuildView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnBuild:RemoveClickListener()
	self._btnLock:RemoveClickListener()
end

function PinballBuildView:onClickModalMask()
	gohelper.setActive(self.viewGO, false)
	self:closeThis()
end

function PinballBuildView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio3)
	self:createCurrencyItem()

	self._items = {}

	local coList = PinballConfig.instance:getAllBuildingCo(VersionActivity2_4Enum.ActivityId.Pinball, self.viewParam.size)

	gohelper.CreateObjList(self, self.createItem, coList, self._golist, self._goitem, PinballBuildItem)
	self:onSelect(1)
end

function PinballBuildView:createItem(obj, data, index)
	obj:initData(data, index)

	self._items[index] = obj

	local btn = gohelper.findChildButtonWithAudio(obj.go, "#btn_click")

	self.addClickCb(self, btn, self.onSelect, self, index)
end

function PinballBuildView:onSelect(index)
	self._curSelectIndex = index

	for _, item in pairs(self._items) do
		item:setSelect(index == item._index)

		if index == item._index then
			self:_refreshView(item)
		end
	end
end

function PinballBuildView:createCurrencyItem()
	local topCurrency = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}

	for _, currencyType in ipairs(topCurrency) do
		local go = self:getResInst(self.viewContainer._viewSetting.otherRes.currency, self._topCurrencyRoot)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballCurrencyItem)

		comp:setCurrencyType(currencyType)
	end
end

function PinballBuildView:_refreshView(item)
	local isLock = item:isLock()
	local isDone = item:isDone()
	local data = item._data

	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._godone, isDone)
	gohelper.setActive(self._gobuild, not isLock and not isDone)

	self._txttitle.text = data.desc
	self._txtdesc.text = data.desc2

	self:updateEffect(data)
	self:updateCost(data)
	ZProj.UGUIHelper.SetGrayscale(self._btnBuild.gameObject, not not self._costNoEnough)
end

function PinballBuildView:updateEffect(data)
	local effectArr = {}
	local effect = data.effect

	if not string.nilorempty(effect) then
		local dict = GameUtil.splitString2(effect, true)

		for _, arr in pairs(dict) do
			if arr[1] == PinballEnum.BuildingEffectType.AddScore then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Score,
					value = arr[2]
				})
			elseif arr[1] == PinballEnum.BuildingEffectType.AddFood then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Food,
					value = arr[2]
				})
			elseif arr[1] == PinballEnum.BuildingEffectType.CostFood then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Food,
					value = arr[2],
					text = luaLang("pinball_food_need")
				})
			elseif arr[1] == PinballEnum.BuildingEffectType.AddPlay then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Play,
					value = arr[2]
				})
			elseif arr[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Play,
					value = arr[2],
					text = luaLang("pinball_play_need")
				})
			end
		end
	end

	gohelper.CreateObjList(self, self._createEffectItem, effectArr, nil, self._goeffectitem)
end

function PinballBuildView:updateCost(data)
	local costArr = {}
	local cost = data.cost

	if not string.nilorempty(cost) then
		local dict = GameUtil.splitString2(cost, true)

		for _, arr in pairs(dict) do
			table.insert(costArr, {
				resType = arr[1],
				value = arr[2]
			})
		end
	end

	self._costNoEnough = nil

	gohelper.CreateObjList(self, self._createCostItem, costArr, nil, self._gocostitem1)
	gohelper.CreateObjList(self, self._createCostItem, costArr, nil, self._gocostitem2)
end

function PinballBuildView:_createCostItem(obj, data, index)
	local num = gohelper.findChildTextMesh(obj, "#txt_num")
	local icon = gohelper.findChildImage(obj, "#txt_num/#image_icon")
	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][data.resType]

	if not resCo then
		logError("资源配置不存在" .. data.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(icon, resCo.icon)

	local color = ""

	if data.value > PinballModel.instance:getResNum(data.resType) then
		color = "<color=#FC8A6A>"
		self._costNoEnough = self._costNoEnough or resCo.name
	end

	num.text = string.format("%s-%d", color, data.value)
end

function PinballBuildView:_createEffectItem(obj, data, index)
	local num = gohelper.findChildTextMesh(obj, "#txt_num")
	local icon = gohelper.findChildImage(obj, "#txt_num/#image_icon")
	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][data.resType]

	if not resCo then
		logError("资源配置不存在" .. data.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(icon, resCo.icon)

	num.text = string.format("%s%+d", data.text or resCo.name, data.value)
end

function PinballBuildView:onBuildClick()
	if self._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, self._costNoEnough)

		return
	end

	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, self._items[self._curSelectIndex]._data.id, PinballEnum.BuildingOperType.Build, self.viewParam.index)
	self:onClickModalMask()
end

function PinballBuildView:onLockClick()
	self._items[self._curSelectIndex]:isLock(true)
end

return PinballBuildView
