-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueSelectRolePropView.lua

module("logic.extensions.roguelike.view.explore.RogueSelectRolePropView", package.seeall)

local M = class("RogueSelectRolePropView", ViewComponent)
local kSelectType = {
	SelectProp = 2,
	SelectCard = 3,
	SelectRole = 1
}

function M:ctor()
	M.super.ctor(self)

	self._cardItems = {}
end

function M:buildUI()
	self._traCardParent = self:getGo("props_select_view_-363431592").transform
	self._goCardItem = self._traCardParent:GetChild(1).gameObject
	self._goProp = self:getGo("props_select_view_701021865")
	self._goRoles = self:getGo("props_select_view_-363431592")
	self._goCardList = self:getGo("props_select_view_583509240")
	self._goCurCardParent = self:getGo("props_select_view_1679353307")
	self._goCurCard = goutil.findChild(self._goCurCardParent, "readjust_item")
	self._btnClose = self:getBtn("0&empty_mask_tips_29887572")
	self._goTitle = self:getGo("props_select_view_copy_1709762514")
	self._txtTitle = self:getText("props_select_view_-680477595")
	self._titleBar = RogueSelectTitleBar.New(self)

	self._titleBar:buildUI()

	self._selectCard = RogueSelectCard.New(self)

	self._selectCard:buildUI()

	self._btnConfirm = self:getBtn("props_select_view_copy_835048801")
	self._goBtnConfirm = self:getGo("props_select_view_copy_835048801")
	self._aniBtnConfirm = self._goBtnConfirm:GetComponent(ComponentType.Animation)

	self:initPropItems()

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:initPropItems()
	self._propItems = {}

	for i = 1, 3 do
		local itemGo = goutil.findChild(self._goProp, "prop_" .. i)
		local propItem = Astral.LuaComponentContainer.Add(itemGo, RogueSelectPropItem)

		table.insert(self._propItems, propItem)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.checkClose, self)
	self._btnConfirm:AddClickListener(self.onSelectConfirmClick, self)
end

function M:setTitleActive(selectTypes)
	self._titleBar:setTitleActive(selectTypes)
end

function M:setToggleStatus(curSelectType)
	self._titleBar:setToggleStatus(curSelectType)
end

function M:onSelectConfirmClick()
	if self._onSelectConfirmCallback then
		self._onSelectConfirmCallback()
	end
end

function M:checkClose()
	local params = self:getFirstParam()

	if params[1] == 2 and params[2] ~= nil and #params[2] == 1 then
		-- block empty
	elseif params[1] == 3 then
		RoguelikeModel.instance:setEnterRoleStates()
		self:close()

		if params[2] then
			params[2]()
		end

		RoguelikeAgent.instance:delayShowProps()
	end
end

function M:unbindEvents()
	for i = 1, #self._cardItems do
		self._cardItems[i]:unbindEvents()
	end

	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	if not RogueMgr.instance:isInRogue() then
		self:close()

		return
	end

	goutil.setActive(self._goDi, false)

	local params = self:getFirstParam()
	local isInSettlement = RogueMgr.instance:getRogueFlow().model:getInSettlement()

	print("选择道具类型", params[1], params[3])
	goutil.setActive(self._goTitle, true)

	if params[1] == 1 then
		self._selectRoleCallback = params[2]

		self:updateRoleInfoByNormal(params[3], params[4], params[5])
		self:setTitleActive({
			kSelectType.SelectRole
		})
		self:setToggleStatus(kSelectType.SelectRole)
		goutil.setActive(self.mainGO, true)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open")
	elseif params[1] == 2 then
		if #params[2] == 1 then
			self:setTitleActive({})
		else
			self:setTitleActive({
				kSelectType.SelectProp
			})
		end

		self:setToggleStatus(kSelectType.SelectProp)
		self:showPropSelect(params[2])
	elseif params[1] == 3 then
		goutil.setActive(self._goTitle, false)
		self:showRoleStateChange()
		goutil.setActive(self.mainGO, true)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open")
	end

	goutil.setActive(self.mainGO, not isInSettlement or params[3] == true)

	if self.mainGO.activeInHierarchy then
		self:beginCapture()
	end
end

function M:showRoleStateChange()
	goutil.setActive(self._goProp, false)
	goutil.setActive(self._goRoles, true)

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local allEnterRoles = RoguelikeModel.instance:getEnterRoleStates()

	for i = 1, self._traCardParent.childCount - 1 do
		goutil.setActive(self._traCardParent:GetChild(i).gameObject, false)
	end

	local changRoles = {}

	for i = 1, #allRoles do
		if allRoles[i].roleProp:getHp() ~= allEnterRoles[i].hp or allRoles[i].roleProp:getSan() ~= allEnterRoles[i].san then
			local data = {}

			data.id = allRoles[i].roleProp:getRoleId()
			data.hp = allRoles[i].roleProp:getHp()
			data.hpChange = allRoles[i].roleProp:getHp() - allEnterRoles[i].hp
			data.san = allRoles[i].roleProp:getSan()
			data.sanChange = allRoles[i].roleProp:getSan() - allEnterRoles[i].san

			table.insert(changRoles, data)
		end
	end

	for i = 1, #changRoles do
		local item = self._cardItems[i]

		if not item then
			item = RogueRoleLiPaiItem.New(self._traCardParent:GetChild(i).gameObject)
			self._cardItems[i] = item
		end

		local data = {}

		data.roleId = changRoles[i].id
		data.hp = changRoles[i].hp
		data.san = changRoles[i].san
		data.hpChange = changRoles[i].hpChange
		data.san = changRoles[i].san
		data.sanChange = changRoles[i].sanChange
		data.isHideSixInfo = false
		data.isHideClick = true

		item:updateData(data)
	end
end

function M:onExit()
	self:setEvent(false)

	self._isSelectProp = false
	self._selectIndex = nil
	self._propCo = nil
	self._effectCo = nil

	goutil.setActive(self._goCurCardParent, false)
	goutil.setActive(self._goCardList, false)
	goutil.setActive(self._goBtnConfirm, false)
	removetimer(self._sendGetPropDelay, self)
	removetimer(self._sendAddPropsRequst, self)
	removetimer(self._delayClickCallback, self)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_CHECK_SETTLEMENT)
	self._guiAnimation:PlayAniByName("close")
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_CHECK_SETTLEMENT, self._onCheckSettlement, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_PROP_TOP, self._onChangeViewTop, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_CHECK_SETTLEMENT, self._onCheckSettlement, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_PROP_TOP, self._onChangeViewTop, self)
	end
end

function M:_onCheckSettlement()
	print("重新显示选择道具", debug.traceback())

	local params = self:getFirstParam()

	params[3] = true

	self:close()

	if not RogueMgr.instance:isInRogue() then
		return
	end

	ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, params)
end

function M:_onChangeViewTop()
	settimer(0, function()
		if self.mainGO then
			self.mainGO.transform:SetAsLastSibling()
		end
	end, self, false)
end

function M:showPropSelect(propIds)
	goutil.setActive(self._goProp, true)
	goutil.setActive(self._goRoles, false)

	local count = 0
	local curPropId = 0

	goutil.setActive(self._txtTitle.gameObject, #propIds == 1)

	for index, item in ipairs(self._propItems) do
		local data = {}

		data.propId = propIds[index]

		function data.callback(pid)
			self._selectPropId = pid

			for k, v in ipairs(self._propItems) do
				v:setSelect(k == index)
			end

			goutil.setActive(self._txtTitle.gameObject, false)
			self:setTitleActive(self:getPropShowTypes(pid))
			self:showConfirmBtn(function()
				self:sendGetProp(self._selectPropId)
			end)
		end

		item:updateData(data)

		if data.propId ~= nil then
			count = count + 1
			curPropId = data.propId
		end
	end

	if #propIds == 1 then
		goutil.setActive(self._txtTitle.gameObject, false)

		self._selectPropId = propIds[1]

		self._propItems[1]:setSelect(true)
		self:setTitleActive(self:getPropShowTypes(self._selectPropId))
		self:showConfirmBtn(function()
			self:sendGetProp(self._selectPropId)
		end)
	end
end

function M:getPropShowTypes(propId)
	local propCo = RoguelikeConfig.instance:getPropById(propId)
	local effectIds = propCo.effectIds or {}
	local needSelect = false
	local needSelectCard = false
	local addCardId = false
	local addEntryId
	local isAll = false

	for k, v in ipairs(effectIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)
		local selectable = string.find(effectCo.params, "SELECTABLE")

		if selectable or effectCo.program == "AddChosenAttribute" or effectCo.program == "SelectedHeroToRiseAttribute" then
			needSelect = true
		end

		needSelectCard = needSelectCard or string.find(effectCo.params, "SELECTED_CARD")

		if needSelectCard then
			addEntryId = addEntryId or tonumber(string.split(effectCo.params, "#")[3])
		end

		if string.find(effectCo.params, "ALL") then
			isAll = true
		end
	end

	if needSelectCard then
		local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
		local isAllRoleCardSlotFull = true

		for i = 1, #allRoles do
			isAllRoleCardSlotFull = isAllRoleCardSlotFull and allRoles[i].roleProp:getAllCardSlotIsFull()
		end

		if isAllRoleCardSlotFull then
			FloatWordMgr.instance:show(lang("没有强化位置,强化强制失效"))
			RoguelikeAgent.instance:sendAddPropsRequest(propId, 0)
			self:close()

			return
		end
	end

	local showTypes = {
		kSelectType.SelectProp
	}

	if needSelectCard then
		table.insert(showTypes, kSelectType.SelectCard)
	end

	if needSelect then
		table.insert(showTypes, kSelectType.SelectRole)
	end

	self._curShowTypes = showTypes
	self._curPropInfo = {
		needSelect = needSelect,
		needSelectCard = needSelectCard,
		addCardId = addCardId,
		isAll = isAll
	}

	return showTypes
end

function M:waitForPropSelect(index)
	for k, v in ipairs(self._propItems) do
		v:setSelect(k == index)
	end

	settimer(0.5, function()
		self:_sendGetPropDelay()
	end, self, false)
end

function M:_sendGetPropDelay()
	self:sendGetProp(self._selectPropId)
end

function M:showCurEffectCard(actionId, qua6List)
	if not self._curRoleCard then
		self._curRoleCard = Astral.LuaComponentContainer.Add(self._goCurCard, RogueJudgeCard)
	end

	self._curRoleCard:showByCardId(actionId, qua6List)
	goutil.setActive(self._goCurCardParent, true)
end

function M:sendGetProp(propId)
	local propCo = RoguelikeConfig.instance:getPropById(propId)

	if self._curPropInfo.addCardId then
		local qua6List = {}

		for i = 1, 6 do
			table.insert(qua6List, 6)
		end

		self:showCurEffectCard(addCardId, qua6List)
	end

	if self._curPropInfo.needSelect and not self._curPropInfo.isAll then
		local pId = propId

		self:setToggleStatus(kSelectType.SelectRole)

		function self._selectRoleCallback(idx)
			local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(idx)

			if roleProp:getAllCardSlotIsFull() then
				FloatWordMgr.instance:show(lang("当前角色卡牌槽位已满"))

				return
			end

			if self._curPropInfo.needSelectCard then
				self:setToggleStatus(kSelectType.SelectCard)

				local actionIds = roleProp:getCardIds()

				goutil.setActive(self._goRoles, false)
				self:hideConfirmBtn()
				self._selectCard:showRoleCard({
					actionIds,
					roleProp:getRoleId(),
					function(cardIndex)
						if roleProp:getCardSlotIsFull(cardIndex) then
							FloatWordMgr.instance:show(lang("当前卡牌槽位已满"))
							self._selectCard:reset()
							self:hideConfirmBtn()

							return
						end

						self._selectCardIndex = cardIndex

						self:showConfirmBtn(function()
							self:_playSelectAnim(idx, true)
						end)
					end,
					roleProp,
					addEntryId
				})
			else
				self:_playSelectAnim(idx, true)
			end
		end

		self:updateRoleInfo(propCo, false, needSelectCard)
		self:hideConfirmBtn()
	else
		RoguelikeAgent.instance:sendAddPropsRequest(propId, 0)
		self:close()
		print("关闭界面")
	end
end

function M:getEffectAttrList(content)
	local iBegin = string.find(content, "%[")
	local iEnd = string.find(content, "%]")

	if not iBegin or not iEnd then
		return {
			tonumber(content) + 1
		}
	end

	local attrsStr = string.sub(content, iBegin + 1, iEnd - 1)
	local attrList = string.split(attrsStr, ",")
	local result = {}

	for k, v in pairs(attrList) do
		table.insert(result, tonumber(v) + 1)
	end

	return result
end

function M:updateRoleInfo(propCo, selectIndex, needSelectCard)
	self._propCo = propCo

	goutil.setActive(self._goProp, false)
	goutil.setActive(self._goRoles, true)

	self._attrChangeList = {}

	for i, v in ipairs(propCo.effectIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		if effectCo.program == "AddAttribute" and selectIndex then
			local selectable = string.find(effectCo.params, "SELECTABLE")

			if selectable then
				local strList = string.split(effectCo.params, "#")
				local attrList = self:getEffectAttrList(strList[2])

				for k1, v1 in pairs(attrList) do
					self._attrChangeList[v1] = tonumber(strList[3])
				end
			end
		end
	end

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local item = self._cardItems[i]

		if not item then
			item = RogueRoleLiPaiItem.New(self._traCardParent:GetChild(i).gameObject)
			self._cardItems[i] = item
		end

		if allRoles[i].roleProp:getIsDeath() then
			-- block empty
		end

		local data = {}
		local index = i

		data.roleId = allRoles[i].roleProp:getRoleId()
		data.isDeath = allRoles[i].roleProp:getIsDeath()

		if needSelectCard and data.roleId ~= 0 then
			data.roleId = allRoles[i].roleProp:getAllCardSlotIsFull() and 0 or data.roleId
		end

		local temp = data.roleId

		function data.callback()
			self:onCardClickCallback(index)
		end

		data.enable = RoguePredictionUtil.instance:getRoleCanUseProp(data.roleId, propCo.id)
		data.hp = allRoles[i].roleProp:getHp()
		data.card = allRoles[i].roleProp:getCard()
		data.attrChange = selectIndex == index and self._attrChangeList or nil

		item:updateData(data)
	end
end

function M:updateRoleInfoByNormal(desc, effectId, testAttr)
	goutil.setActive(self._goProp, false)
	goutil.setActive(self._goRoles, true)

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local item = self._cardItems[i]

		if not item then
			item = RogueRoleLiPaiItem.New(self._traCardParent:GetChild(i).gameObject)
			self._cardItems[i] = item
		end

		if allRoles[i].roleProp:getIsDeath() then
			-- block empty
		end

		local data = {}
		local index = i

		data.roleId = allRoles[i].roleProp:getRoleId()
		data.isDeath = allRoles[i].roleProp:getIsDeath()

		local temp = data.roleId

		function data.callback()
			if effectId ~= nil then
				self._effectCo = RoguelikeConfig.instance:getEffectById(effectId)
			end

			self:onCardClickCallback(index)
		end

		data.enable = RoguePredictionUtil.instance:getRoleCanUseEffect(data.roleId, effectId)
		data.hp = allRoles[i].roleProp:getHp()
		data.san = allRoles[i].roleProp:getSan()
		data.selectAttr = testAttr

		item:updateData(data)
	end
end

function M:closeOtherView()
	if ViewMgr.instance:isOpen(ViewName.RogueMoonyDiceGame) then
		ViewMgr.instance:close(ViewName.RogueMoonyDiceGame)
	end

	if ViewMgr.instance:isOpen(ViewName.RogueVendingMachine) then
		ViewMgr.instance:close(ViewName.RogueVendingMachine)
	end

	if ViewMgr.instance:isOpen(ViewName.RogueGuessDiceGame) then
		ViewMgr.instance:close(ViewName.RogueGuessDiceGame)
	end

	self._selectIndex = nil

	self:beginCapture()
end

function M:onCardClickCallback(idx)
	if self._selectIndex == idx then
		return
	end

	self._selectIndex = idx

	for k, v in ipairs(self._cardItems) do
		v:setSelect(k == idx)
	end

	self:showConfirmBtn(function()
		self:_delaySelectRoleCallback()
	end)
end

function M:showConfirmBtn(callback)
	goutil.setActive(self._goBtnConfirm, true)

	self._onSelectConfirmCallback = callback

	self._aniBtnConfirm:Play("props_select_view_copy_btncontinue_open")
end

function M:hideConfirmBtn()
	self._aniBtnConfirm:Play("props_select_view_copy_btncontinue_close")
end

function M:_delaySelectRoleCallback()
	local idx = self._selectIndex

	if self._selectRoleCallback then
		self._selectRoleCallback(idx)
	end
end

function M:_playSelectAnim(idx, ignoreDelay)
	self._selectIndex = idx

	if self._selectIndex ~= nil then
		if self._propCo then
			if not ignoreDelay then
				self:updateRoleInfo(self._propCo, self._selectIndex)
				settimer(0.5, self._sendAddPropsRequst, self, false)
			else
				self:_sendAddPropsRequst()
			end
		elseif self._effectCo then
			if not ignoreDelay then
				self:showEffectSelect()
				settimer(0.5, self._delayClickCallback, self, false)
			else
				self:_delayClickCallback()
			end
		end
	end
end

function M:beginCapture()
	goutil.setActive(self.mainGO, false)
	self:_onCaptureFinish()
end

function M:_onCaptureFinish()
	if not self.mainGO.activeInHierarchy then
		goutil.setActive(self.mainGO, true)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open")
	end

	if self._selectIndex ~= nil and self._cardItems ~= nil and #self._cardItems > 0 then
		for i = 1, 4 do
			goutil.setActive(self._cardItems[i]._go, i == self._selectIndex)
		end
	end

	if self._selectIndex ~= nil then
		if self._propCo then
			self:updateRoleInfo(self._propCo, self._selectIndex)
			settimer(0.5, self._sendAddPropsRequst, self, false)
		elseif self._effectCo then
			self:showEffectSelect()
			settimer(0.5, self._delayClickCallback, self, false)
		end
	end
end

function M:showEffectSelect()
	if not RogueMgr.instance:getModel() then
		return
	end

	self._attrChangeList = {}

	local effectCo = self._effectCo

	if effectCo.program == "AddAttribute" and self._selectIndex then
		local selectable = string.find(effectCo.params, "SELECTABLE")

		if selectable then
			local strList = string.split(effectCo.params, "#")
			local attrList = self:getEffectAttrList(strList[2])

			for k1, v1 in pairs(attrList) do
				self._attrChangeList[v1] = tonumber(strList[3])
			end
		end
	end

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local item = self._cardItems[i]

		if not item then
			item = RogueRoleLiPaiItem.New(self._traCardParent:GetChild(i).gameObject)
			self._cardItems[i] = item
		end

		if allRoles[i].roleProp:getIsDeath() then
			-- block empty
		end

		local data = {}
		local index = i

		data.roleId = allRoles[i].roleProp:getRoleId()
		data.isDeath = allRoles[i].roleProp:getIsDeath()
		data.hp = allRoles[i].roleProp:getHp()
		data.san = allRoles[i].roleProp:getSan()
		data.attrChange = self._selectIndex == index and self._attrChangeList or nil

		item:updateData(data)

		if self._selectIndex then
			item:setHighLight(self._selectIndex == index)
		end
	end
end

function M:_delayClickCallback()
	self:onCardClickCallback(self._selectIndex)
end

function M:_sendAddPropsRequst()
	local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(self._selectIndex)
	local actionIds = roleProp:getCardIds()
	local actionId = actionIds[self._selectCardIndex]
	local propId = self._propCo.id
	local cardIndex = self._selectCardIndex or 1

	RoguePredictionUtil.instance:showPropEffectTips(self._propCo.id, roleProp:getRoleId(), self._selectIndex, actionId, self._selectCardIndex or 1, function()
		RoguelikeAgent.instance:sendAddPropsRequest(propId, roleProp:getRoleId(), 1, cardIndex)
	end)
	self:close()
end

return M
