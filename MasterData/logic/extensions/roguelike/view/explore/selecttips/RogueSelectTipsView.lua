-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/selecttips/RogueSelectTipsView.lua

module("logic.extensions.roguelike.view.explore.selecttips.RogueSelectTipsView", package.seeall)

local M = class("RogueSelectTipsView", ViewComponent)

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
	self._goTitle = self:getGo("props_select_view_copy_1709762514")
	self._goCurCard = goutil.findChild(self._goCurCardParent, "readjust_item")
	self._btnClose = self:getBtn("0&empty_mask_tips_29887572")
	self._txtTitleContent = self:getText("props_select_view_copy_2033703993")
	self._goDi = self:getGo("props_select_view_copy_239065080")
	self._titleBar = RogueSelectTitleBar.New(self)

	self._titleBar:buildUI()

	self._selectCard = RogueSelectCard.New(self)

	self._selectCard:buildUI()

	self._btnConfirm = self:getBtn("props_select_view_copy_835048801")
	self._goBtnConfirm = self:getGo("props_select_view_copy_835048801")
	self._goShowTypes = {
		[RoguelikeConst.SHOW_TIPS_TYPE.SelectProp] = self._goProp,
		[RoguelikeConst.SHOW_TIPS_TYPE.SelectRole] = self._goRoles,
		[RoguelikeConst.SHOW_TIPS_TYPE.SelectCard] = self._goCardList
	}

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
	return
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

	local param = self:getFirstParam()
	local showType = param[1]
	local options = param[2]
	local showTitle = param[3]

	if type(param[1]) == "table" then
		showType = param[1][1]
		options = param[1][2]
		showTitle = param[1][3]
	end

	goutil.setActive(self._goDi, showTitle ~= nil)

	if showTitle then
		self._txtTitleContent.text = showTitle
	end

	if showType == RoguelikeConst.SHOW_TIPS_TYPE.SelectEndOption then
		self:showEndOption(options)
	elseif showType == RoguelikeConst.SHOW_TIPS_TYPE.SelectCard then
		local cards = param[2]

		self:showOptionCard(cards)
	elseif showType == RoguelikeConst.SHOW_TIPS_TYPE.SelectRole then
		local cards = param[2]

		self:showOptionRole(cards)
	end
end

function M:showOptionRole(cards)
	self._selectCard:showNormalCard(cards, function(index)
		for i = 1, self._traCardParent.childCount - 1 do
			goutil.setActive(self._traCardParent:GetChild(i).gameObject, false)
		end

		local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

		for i = 1, #allRoles do
			local item = self._cardItems[i]

			if not item then
				item = RogueRoleLiPaiItem.New(self._traCardParent:GetChild(i).gameObject)
				self._cardItems[i] = item
			end

			local data = {}
			local roleProp = allRoles[i].roleProp

			data.roleId = roleProp:getRoleId()
			data.hp = roleProp:getHp()
			data.index = i
			data.card = roleProp:getCard()

			function data.callback()
				RogueExploreAgent.instance:sendStartCardSelectHeroRequest(data.roleId)
				self:close()
			end

			item:updateData(data)
		end

		self:setDisplayGoActive(RoguelikeConst.SHOW_TIPS_TYPE.SelectRole)
	end)
	self:setDisplayGoActive(RoguelikeConst.SHOW_TIPS_TYPE.SelectCard)
end

function M:showOptionCard(cards)
	self._selectCard:showNormalCard(cards, function(index)
		RogueExploreAgent.instance:sendEndSelectCardRequest(index)
		self:close()
	end)
	self:setDisplayGoActive(RoguelikeConst.SHOW_TIPS_TYPE.SelectCard)
end

function M:showEndOption(options)
	for k, v in pairs(self._propItems) do
		v:setActive(false)
	end

	for k, v in ipairs(options) do
		local optionCo = RogueConstConfig.instance:getOptionCoById(v)
		local data = {}
		local index = k

		function data.callback()
			self:onEndOptionSelect(optionCo.id, index)
		end

		data.content = RogueEndOptionUtil.instance:getOptionDesc(optionCo)
		data.propId = optionCo.propsId

		self._propItems[k]:updateData(data)
	end

	self:setDisplayGoActive(RoguelikeConst.SHOW_TIPS_TYPE.SelectProp)
end

function M:setDisplayGoActive(showType, isHide)
	goutil.setActive(self._goTitle, false)

	for k, v in pairs(self._goShowTypes) do
		goutil.setActive(v, k == showType and not isHide)
	end
end

function M:onEndOptionSelect(id, index)
	RogueExploreAgent.instance:sendEndSelectRequest(id)
	self:close()
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
		-- block empty
	end
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
			if temp == 0 then
				return
			end

			if effectId then
				self._effectCo = RoguelikeConfig.instance:getEffectById(effectId)

				self:_playSelectAnim(index)
			else
				self:onCardClickCallback(index)
			end
		end

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
	self._selectIndex = idx

	for k, v in ipairs(self._cardItems) do
		v:setSelect(k == idx)
		v:setHighLight(k == idx)
	end

	self:showConfirmBtn(function()
		self:_delaySelectRoleCallback()
	end)
end

function M:showConfirmBtn(callback)
	goutil.setActive(self._goBtnConfirm, true)

	self._onSelectConfirmCallback = callback
end

return M
