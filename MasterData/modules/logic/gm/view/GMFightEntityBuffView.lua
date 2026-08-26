-- chunkname: @modules/logic/gm/view/GMFightEntityBuffView.lua

module("modules.logic.gm.view.GMFightEntityBuffView", package.seeall)

local GMFightEntityBuffView = class("GMFightEntityBuffView", BaseView)

GMFightEntityBuffView.ClickSearchItem = "ClickSearchItem"

function GMFightEntityBuffView:onInitView()
	local buff = gohelper.findChild(self.viewGO, "buff")

	gohelper.setActive(buff, true)

	self._maskGO = gohelper.findChild(self.viewGO, "buff/searchList")
	self._scrollTr = gohelper.findChild(self.viewGO, "buff/searchList/scroll").transform
	self._input = gohelper.findChildTextMeshInputField(self.viewGO, "buff/add/input")
	self._btnAdd = gohelper.findChildButton(self.viewGO, "buff/add/btnAdd")
end

function GMFightEntityBuffView:addEvents()
	self._btnAdd:AddClickListener(self._onClickAddBuff, self)
	SLFramework.UGUI.UIClickListener.Get(self._input.gameObject):AddClickListener(self._onClickInpItem, self, nil)
	SLFramework.UGUI.UIClickListener.Get(self._maskGO):AddClickListener(self._onClickMask, self, nil)
	self._input:AddOnValueChanged(self._onInpValueChanged, self)
	GMController.instance:registerCallback(GMFightEntityBuffView.ClickSearchItem, self._onClickItem, self)
end

function GMFightEntityBuffView:removeEvents()
	self._btnAdd:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._input.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._maskGO):RemoveClickListener()
	self._input:RemoveOnValueChanged()
	GMController.instance:unregisterCallback(GMFightEntityBuffView.ClickSearchItem, self._onClickItem, self)
end

function GMFightEntityBuffView:onOpen()
	self:_hideScroll()
	self._input:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMEntityBuffSearch, ""))
end

function GMFightEntityBuffView:_onClickAddBuff()
	local buffId = tonumber(self._input:GetText())
	local buffCO = buffId and lua_skill_buff.configDict[buffId]

	if buffCO then
		PlayerPrefsHelper.setString(PlayerPrefsKey.GMEntityBuffSearch, tostring(buffId))
		GameFacade.showToast(ToastEnum.IconId, "add buff " .. buffId)

		local entityMO = GMFightEntityModel.instance.entityMO

		GMRpc.instance:sendGMRequest(string.format("fightAddBuff %s %s", tostring(entityMO.id), tostring(buffId)))

		self._oldBuffUidDict = {}

		for _, buffMO in ipairs(entityMO:getBuffList()) do
			self._oldBuffUidDict[buffMO.id] = true
		end

		FightRpc.instance:sendEntityInfoRequest(entityMO.id)
		self.addEventCb(self, FightController.instance, FightEvent.onReceiveEntityInfoReply, self._onGetEntityInfo, self)
	else
		GameFacade.showToast(ToastEnum.IconId, "buff not exist " .. self._input:GetText())
	end
end

function GMFightEntityBuffView:_onGetEntityInfo(msg)
	self.removeEventCb(self, FightController.instance, FightEvent.onReceiveEntityInfoReply, self._onGetEntityInfo, self)

	local entityMO = GMFightEntityModel.instance.entityMO

	if not entityMO then
		return
	end

	for _, buffMO in ipairs(entityMO:getBuffList()) do
		if not self._oldBuffUidDict[buffMO.id] then
			logError("add buff " .. buffMO.buffId)

			local entity = FightHelper.getEntity(entityMO.id)

			if entity and entity.buff then
				FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, entityMO.id, FightEnum.EffectType.BUFFADD, buffMO.buffId, buffMO.uid, 0, buffMO)
			end
		else
			FightController.instance:dispatchEvent(FightEvent.GMForceRefreshNameUIBuff, entityMO.id)
		end
	end
end

function GMFightEntityBuffView:_onClickInpItem()
	self:_showScroll()
end

function GMFightEntityBuffView:_onClickMask()
	self:_hideScroll()
end

function GMFightEntityBuffView:_showScroll()
	gohelper.setActive(self._maskGO, true)
	self:_checkBuildItems()
end

function GMFightEntityBuffView:_hideScroll()
	gohelper.setActive(self._maskGO, false)
end

function GMFightEntityBuffView:_onClickItem(mo)
	self._input:SetText(mo.buffId)
	self:_hideScroll()
end

function GMFightEntityBuffView:_onInpValueChanged(inputStr)
	self:_checkBuildItems()
end

function GMFightEntityBuffView:_checkBuildItems()
	if not self._searchScrollView then
		local buffSearchListParam = ListScrollParam.New()

		buffSearchListParam.scrollGOPath = "buff/searchList/scroll"
		buffSearchListParam.prefabType = ScrollEnum.ScrollPrefabFromView
		buffSearchListParam.prefabUrl = "buff/searchList/scroll/item"
		buffSearchListParam.cellClass = GMFightEntityBuffSearchItem
		buffSearchListParam.scrollDir = ScrollEnum.ScrollDirV
		buffSearchListParam.lineCount = 1
		buffSearchListParam.cellWidth = 450
		buffSearchListParam.cellHeight = 50
		buffSearchListParam.cellSpaceH = 0
		buffSearchListParam.cellSpaceV = 0
		self._searchScrollModel = ListScrollModel.New()
		self._searchScrollView = LuaListScrollView.New(self._searchScrollModel, buffSearchListParam)

		self:addChildView(self._searchScrollView)

		self._buffList = {}

		for _, buffCO in ipairs(lua_skill_buff.configList) do
			local mo = {
				buffId = tostring(buffCO.id),
				name = buffCO.name
			}

			table.insert(self._buffList, mo)
		end
	end

	local targetList
	local input = self._input:GetText()

	if string.nilorempty(input) then
		targetList = self._buffList
	else
		if self._tempList then
			tabletool.clear(self._tempList)
		else
			self._tempList = {}
		end

		for _, mo in ipairs(self._buffList) do
			if string.find(mo.name, input) or string.find(mo.buffId, input) == 1 then
				table.insert(self._tempList, mo)
			end
		end

		targetList = self._tempList
	end

	local count = Mathf.Clamp(#targetList, 1, 10)

	recthelper.setHeight(self._scrollTr, count * 50)
	self._searchScrollModel:setList(targetList)
end

return GMFightEntityBuffView
