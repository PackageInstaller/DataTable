-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RogueRoleInfoDetail.lua

module("logic.extensions.roguelike.view.explore.map.RogueRoleInfoDetail", package.seeall)

local M = class("RogueRoleInfoDetail")

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._cardItems = {}
	self._txtIndex = goutil.findChildTextComponent(go, "Num/txtNum")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._goLiPai = goutil.findChild(go, "run_group_lipai_item")
	self._traCardParent = goutil.findChild(go, "cards").transform
	self._canvasgroup = self._traCardParent.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._lipaiItem = RogueRoleLiPaiItem.New(self._goLiPai)
	self._animation = go:GetComponent(ComponentType.Animation)
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnClose"))

	self:bindEvents()

	self._resLoader = SingleResLoader.New()

	self._resLoader:load(ResName.Rungroupexplore_dice_effect_small_container, self._onResLoaded, self)
end

function M:bindEvents()
	if self._isBind then
		return
	end

	self._btnClose:AddClickListener(self.onClickClose, self)

	self._isBind = true

	self._lipaiItem:bindEvents()
end

function M:unbindEvents()
	self._isBind = false

	self._btnClose:RemoveClickListener()
	self._lipaiItem:unbindEvents()
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, self._go)
	goutil.setActive(self._goInst, false)
end

function M:onClickClose()
	self:setActive(false)

	if self._closeCallback then
		self._closeCallback()
	end
end

function M:setActive(isActive)
	removetimer(self.delayHideGo, self)
	removetimer(self.delayShowGo, self)

	if isActive then
		self._canvasgroup.alpha = 1

		if self._go.activeInHierarchy then
			goutil.setActive(self._go, false)
			settimer(0.02, self.delayShowGo, self, false)
		else
			self:delayShowGo()
		end
	else
		settimer(0.2, self.delayHideGo, self, false)
	end
end

function M:delayHideGo()
	goutil.setActive(self._go, false)
end

function M:delayShowGo()
	goutil.setActive(self._go, true)
end

function M:updateData(data)
	local index = data.index

	self._closeCallback = data.closeCallback

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local roleProp = allRoles[index].roleProp

	self._curRoleMo = allRoles[index]

	local roleId = roleProp:getRoleId()

	for k, v in pairs(self._cardItems) do
		v:setActive(false)
	end

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)
	local actionIds = roleProp:getCardIds()

	if not roleCo then
		printError("找不到角色", roleId)
	end

	self._cardIds = actionIds

	local qua6List = {}

	qua6List = {}

	for i = 1, 6 do
		table.insert(qua6List, roleProp:getPropertyLevel(i))
	end

	self._qua6List = qua6List

	for i = 1, #actionIds do
		local item = self._cardItems[i]
		local co = RoguelikeConfig.instance:getRoleActionById(actionIds[i])
		local cardData = {}

		if roleProp ~= nil then
			local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionIds[i], roleProp, i)

			cardData.cardEntries = cardEntries
		end

		cardData.name = co.name
		cardData.co = co

		local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)
		local attrLevel = CharacterCOUtil.qua2Score(qua6List[co.attr])
		local attrText = string.format("<color=#%s>%s</color>", RoguelikeConst.ATTR_COLOR[qua6List[co.attr]], attrLevel)

		cardData.attr = RoguelikeConst.AttrType2Name[pattern]
		cardData.attrLevel = qua6List[co.attr]
		cardData.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, qua6List[co.attr], cardData.cardEntries)
		cardData.pattern = co.attr
		cardData.slotCount = RoguelikeUtil.instance:getCardSlotCount(qua6List[co.attr])
		cardData.throwDiceText = string.format("投掷%sx%d", RoguelikeConst.GetAttrGraphic(pattern, 20), qua6List[co.attr])

		if not item then
			local go = self._traCardParent:GetChild(i - 1).gameObject

			item = Astral.LuaComponentContainer.Add(go, RogueJudgeCard)
			self._cardItems[i] = item
		end

		local index2 = i

		function cardData.longPressCallback()
			self:showCardDetail(index2)
		end

		function cardData.longPressExitCallback()
			self:hideCardDetail()
		end

		item:updateData(cardData)
	end

	local lipaiData = {}

	lipaiData.roleId = roleId
	lipaiData.hp = roleProp:getHp()
	lipaiData.card = #roleProp:getCardIds()
	lipaiData.enterAni = RoguelikeConst.ROGUE_ROLE_ANI.FALL

	self._lipaiItem:setAttackPlane()
	self._lipaiItem:updateData(lipaiData)

	self._txtIndex.text = index
	self._txtName.text = roleProp:getName()

	self:setActive(true)
end

function M:hideCardDetail()
	if self._cardTips ~= nil then
		self._cardTips:setActive(false)
	end
end

function M:showCardDetail(index)
	if self._cardTips == nil then
		self._cardTips = Astral.LuaComponentContainer.Add(self._goInst, RogueJudgeCardTips)
	end

	self:hideCardDetail()

	local data = {}

	data.leftData = {}
	data.rightData = {}

	local cardIndex = index
	local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(self._cardIds[index], self._curRoleMo.roleProp, cardIndex)

	for k, v in pairs(cardEntries) do
		local entryCo = RoguelikeConfig.instance:getCardEntryById(cardEntries[k])

		if entryCo then
			if entryCo.type == 2 then
				table.insert(data.rightData, v)
			end

			if entryCo.type == 1 then
				table.insert(data.leftData, v)
			end
		end
	end

	self._cardTips:setParent(self._cardItems[index]:getTransform(), false)
	self._cardTips:updateData(data)
end

function M:OnDestroy()
	self:unbindEvents()
	removetimer(self.delayHideGo, self)
	removetimer(self.delayShowGo, self)

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	self._goInst = nil

	if self._resLoader then
		self._resLoader:clear()
	end

	self._resLoader = nil
end

return M
