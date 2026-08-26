-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174GameShopItem.lua

module("modules.logic.versionactivity2_3.act174.view.Act174GameShopItem", package.seeall)

local Act174GameShopItem = class("Act174GameShopItem", LuaCompBase)

function Act174GameShopItem:init(go)
	self.go = go
	self.anim = go:GetComponent(gohelper.Type_Animator)
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self.txtCost = gohelper.findChildText(go, "btn_Buy/txt_Cost")
	self.goSoldOut = gohelper.findChild(go, "go_SellOut")

	for i = 1, 7 do
		self["goType" .. i] = gohelper.findChild(go, "type" .. i)
	end

	self.roleItemList = {}

	for i = 1, 3 do
		for j = 1, i do
			local goRole = gohelper.findChild(self["goType" .. i], "role" .. j)
			local roleItem = self:getUserDataTb_()

			roleItem.imageRare = gohelper.findChildImage(goRole, "rare")
			roleItem.heroIcon = gohelper.findChildSingleImage(goRole, "heroicon")
			roleItem.imageCareer = gohelper.findChildImage(goRole, "career")
			self.roleItemList[#self.roleItemList + 1] = roleItem
		end
	end

	self.roleCareerList = {}

	for i = 4, 7 do
		for j = 1, 3 do
			local goNum = gohelper.findChild(self["goType" .. i], j)

			self.roleCareerList[#self.roleCareerList + 1] = gohelper.findChildImage(goNum, "career")
		end
	end

	self.collectionRare = gohelper.findChildImage(self.goType4, "collection/rare")
	self.collectionIcon = gohelper.findChildSingleImage(self.goType4, "collection/collectionicon")
end

function Act174GameShopItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function Act174GameShopItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function Act174GameShopItem:onDestroy()
	self.collectionIcon:UnLoadImage()

	for _, roleItem in ipairs(self.roleItemList) do
		roleItem.heroIcon:UnLoadImage()
	end
end

function Act174GameShopItem:setData(goodInfo)
	self.goodInfo = goodInfo

	if goodInfo then
		self.actId = Activity174Model.instance:getCurActId()
		self.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
		self.type = self:inferBagType()

		self:refreshCost()

		local roleIdList = goodInfo.bagInfo.heroId

		table.sort(roleIdList, Act174GameShopItem.sortFunc)

		if self.type == 1 then
			self:refreshRoleItem(self.roleItemList[1], roleIdList[1])
		elseif self.type == 2 then
			self:refreshRoleItem(self.roleItemList[2], roleIdList[1])
			self:refreshRoleItem(self.roleItemList[3], roleIdList[2])
		elseif self.type == 3 then
			self:refreshRoleItem(self.roleItemList[4], roleIdList[1])
			self:refreshRoleItem(self.roleItemList[5], roleIdList[2])
			self:refreshRoleItem(self.roleItemList[6], roleIdList[3])
		elseif self.type == 4 then
			local collectionIdList = goodInfo.bagInfo.itemId
			local id = collectionIdList[1]
			local config = lua_activity174_collection.configDict[id]

			UISpriteSetMgr.instance:setAct174Sprite(self.collectionRare, "act174_propitembg_" .. config.rare)
			self.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))
		elseif self.type == 5 then
			self:refreshRoleCareer(self.roleCareerList[1], roleIdList[1])
		elseif self.type == 6 then
			self:refreshRoleCareer(self.roleCareerList[2], roleIdList[1])
			self:refreshRoleCareer(self.roleCareerList[3], roleIdList[2])
		elseif self.type == 7 then
			self:refreshRoleCareer(self.roleCareerList[4], roleIdList[1])
			self:refreshRoleCareer(self.roleCareerList[5], roleIdList[2])
			self:refreshRoleCareer(self.roleCareerList[6], roleIdList[3])
		end

		for i = 1, 7 do
			gohelper.setActive(self["goType" .. i], i == self.type)
		end
	end

	gohelper.setActive(self.go, goodInfo)
end

function Act174GameShopItem:refreshCost()
	local color = "#211F1F"
	local cost = self.goodInfo.buyCost

	if cost > self.gameInfo.coin then
		color = "#be4343"
	end

	gohelper.setActive(self.goSoldOut, self.goodInfo.finish)
	SLFramework.UGUI.GuiHelper.SetColor(self.txtCost, color)

	self.txtCost.text = cost
end

function Act174GameShopItem:onClick()
	if self.goodInfo.finish then
		return
	end

	if self.type == 4 then
		local collectionIdList = self.goodInfo.bagInfo.itemId
		local id = collectionIdList[1]
		local viewParam = {}

		viewParam.type = Activity174Enum.ItemTipType.Collection
		viewParam.co = Activity174Config.instance:getCollectionCo(id)
		viewParam.pos = Vector2.New(518, 0)
		viewParam.showMask = true
		viewParam.goodInfo = self.goodInfo

		Activity174Controller.instance:openItemTipView(viewParam)
	elseif self.type == 1 or self.type == 2 or self.type == 3 then
		local viewParam = {}

		viewParam.type = Activity174Enum.ItemTipType.Character1
		viewParam.co = self.goodInfo.bagInfo.heroId
		viewParam.pos = Vector2.New(479, 0)
		viewParam.showMask = true
		viewParam.goodInfo = self.goodInfo

		Activity174Controller.instance:openItemTipView(viewParam)
	elseif self.type == 5 or self.type == 6 or self.type == 7 then
		local bagInfo = self.goodInfo.bagInfo
		local viewParam = {}

		viewParam.type = Activity174Enum.ItemTipType.Character2
		viewParam.co = lua_activity174_bag.configDict[bagInfo.bagId]
		viewParam.pos = Vector2.New(518, 0)
		viewParam.showMask = true
		viewParam.goodInfo = self.goodInfo

		Activity174Controller.instance:openItemTipView(viewParam)
	end
end

function Act174GameShopItem:inferBagType()
	local bagInfo = self.goodInfo.bagInfo
	local bagConfig = lua_activity174_bag.configDict[bagInfo.bagId]

	if bagConfig.type == Activity174Enum.BagType.Hero then
		if bagConfig.heroType == "quality" then
			return #bagInfo.heroId + 4
		end

		return #bagInfo.heroId
	elseif bagConfig.type == Activity174Enum.BagType.Collection then
		return 4
	end
end

function Act174GameShopItem:refreshRoleItem(roleItem, roleId)
	local config = Activity174Config.instance:getRoleCo(roleId)

	roleItem.heroIcon:LoadImage(ResUrl.getHeadIconSmall(config.skinId))
	UISpriteSetMgr.instance:setCommonSprite(roleItem.imageRare, "bgequip" .. tostring(CharacterEnum.Color[config.rare]))
	UISpriteSetMgr.instance:setCommonSprite(roleItem.imageCareer, "lssx_" .. config.career)
end

function Act174GameShopItem:refreshRoleCareer(imgCareer, roleId)
	local config = Activity174Config.instance:getRoleCo(roleId)

	UISpriteSetMgr.instance:setCommonSprite(imgCareer, "lssx_" .. config.career)
end

function Act174GameShopItem.sortFunc(a, b)
	local roleCoA = Activity174Config.instance:getRoleCo(a)
	local roleCoB = Activity174Config.instance:getRoleCo(b)

	if roleCoA.rare == roleCoB.rare then
		return b < a
	else
		return roleCoA.rare > roleCoB.rare
	end
end

return Act174GameShopItem
