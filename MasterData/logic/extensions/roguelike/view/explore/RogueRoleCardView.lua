-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueRoleCardView.lua

module("logic.extensions.roguelike.view.explore.RogueRoleCardView", package.seeall)

local M = class("RogueRoleCardView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._cardItems = {}
end

function M:buildUI()
	self._goProp = self:getGo("props_select_view_701021865")
	self._goRoles = self:getGo("props_select_view_-363431592")
	self._btnClose = self:getBtn("0&empty_mask_tips_29887572")
	self._goCards = self:getGo("props_select_view_583509240")
	self._traCardParent = self._goCards.transform
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._goProp = nil
	self._goRoles = nil
	self._btnClose = nil
	self._goCards = nil
	self._traCardParent = nil
	self._guiAnimation = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.checkClose, self)
end

function M:checkClose()
	self:close()
end

function M:onClickUpgradeClose()
	if self._selectRoleCardCallback then
		self._selectRoleCardCallback(self._selectIndex)

		self._selectRoleCardCallback = nil
	end

	self:close()
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local openParam = self:getOpenParam()
	local openType = openParam[1]

	if openType == 1 then
		self:showRoleCard(openParam[2])
	elseif openType == 2 then
		self:showRoleCardUpgrade(openParam[2])
	end
end

function M:showRoleCardUpgrade(param)
	self:showRoleCard(param)
end

function M:showRoleCard(param)
	for k, v in pairs(self._cardItems) do
		v:setActive(false)
	end

	local actionIds = param[1]
	local roleId = param[2]

	self._selectRoleCardCallback = param[3]
	self._roleProp = param[4]
	self._entryId = param[5]

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)

	if not roleCo then
		printError("找不到角色", roleId)
	end

	self._cardIds = actionIds

	local qua6List = roleCo.qua6
	local roleMo

	if RogueMgr.instance:isInRogue() then
		roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId)

		if roleMo ~= nil then
			qua6List = {}

			for i = 1, 6 do
				table.insert(qua6List, roleMo.roleProp:getPropertyLevel(i))
			end
		end
	end

	self._roleMo = roleMo
	self._qua6List = qua6List

	for i = 1, #actionIds do
		local item = self._cardItems[i]
		local co = RoguelikeConfig.instance:getRoleActionById(actionIds[i])
		local data = {}

		if roleMo ~= nil then
			local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionIds[i], roleMo.roleProp, i)

			data.cardEntries = cardEntries
		end

		data.name = co.name
		data.co = co

		local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)
		local attrLevel = CharacterCOUtil.qua2Score(qua6List[co.attr])
		local attrText = string.format("<color=#%s>%s</color>", RoguelikeConst.ATTR_COLOR[qua6List[co.attr]], attrLevel)

		data.attr = RoguelikeConst.AttrType2Name[pattern]
		data.attrLevel = qua6List[co.attr]
		data.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, qua6List[co.attr], data.cardEntries)
		data.pattern = co.attr
		data.isDisplay = true
		data.slotCount = RoguelikeUtil.instance:getCardSlotCount(qua6List[co.attr])
		data.throwDiceText = string.format("投掷%sx%d", RoguelikeConst.GetAttrGraphic(pattern, 20), qua6List[co.attr])

		if self._roleProp then
			data.isBan = self._roleProp:getCardSlotIsFull(i)
		end

		if not item then
			local go = self._traCardParent:GetChild(i - 1).gameObject

			item = Astral.LuaComponentContainer.Add(go, RogueJudgeCard)
			self._cardItems[i] = item
		end

		local index = i
		local attr = i

		function data.selectCallback()
			self:onCardSelect(index, attr)
		end

		item:updateData(data)
	end

	goutil.setActive(self._goCards, true)
end

function M:onCardSelect(index, attr)
	self._selectIndex = index

	if self._entryId ~= nil then
		goutil.setActive(self._goCards, false)
		self:showRoleCardUpgradeDetail(index)
	elseif self._selectRoleCardCallback then
		self._selectRoleCardCallback(index)
	end
end

function M:showRoleCardUpgradeDetail(index)
	do return end

	local i = index
	local actionIds = self._cardIds
	local qua6List = self._qua6List
	local co = RoguelikeConfig.instance:getRoleActionById(actionIds[i])
	local data = {}

	data.name = co.name

	local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)
	local attrLevel = CharacterCOUtil.qua2Score(qua6List[co.attr])
	local attrText = string.format("<color=#%s>%s</color>", RoguelikeConst.ATTR_COLOR[qua6List[co.attr]], attrLevel)

	data.attr = RoguelikeConst.AttrType2Name[pattern]
	data.attrLevel = qua6List[co.attr]

	local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionIds[i], self._roleMo.roleProp, i)

	data.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, qua6List[co.attr], cardEntries)
	data.pattern = co.attr
	data.isDisplay = true
	data.slotCount = RoguelikeUtil.instance:getCardSlotCount(qua6List[co.attr])
	data.throwDiceText = string.format("投掷%sx%d", RoguelikeConst.GetAttrGraphic(pattern, 20), qua6List[co.attr])

	if self._roleMo ~= nil then
		local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionIds[i], self._roleMo.roleProp, i)

		data.cardEntries = cardEntries
	end

	self._upgradeCard1:updateData(data)

	local data2 = TableUtil.deepCopy(data)

	if self._roleMo ~= nil then
		local cardEntries2 = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionIds[i], self._roleMo.roleProp, i)

		table.insert(cardEntries2, self._entryId)

		data2.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, qua6List[co.attr], cardEntries2)
		data2.cardEntries = cardEntries2
	end

	self._upgradeCard2:updateData(data2)
	goutil.setActive(self._goUpgrade, true)
end

function M:onExit()
	self:setEvent(false)
	goutil.setActive(self._goCards, false)
	self._guiAnimation:PlayAniByName("close")
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

return M
