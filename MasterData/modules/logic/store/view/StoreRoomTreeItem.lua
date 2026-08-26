-- chunkname: @modules/logic/store/view/StoreRoomTreeItem.lua

module("modules.logic.store.view.StoreRoomTreeItem", package.seeall)

local StoreRoomTreeItem = class("StoreRoomTreeItem", TreeScrollCell)

function StoreRoomTreeItem:ctor()
	self._rootIndex = nil
	self._nodeIndex = nil
	self._go = nil
	self._view = nil
	self._isRoot = nil
	self._isNode = nil
	self.nodeItemList = {}
	self._firstUpdate = true
	self._animationStartTime = 0
	self.openduration = 0.6
	self.closeduration = 0.3
end

function StoreRoomTreeItem:initRoot()
	local root = self:getUserDataTb_()

	root._go = gohelper.findChild(self._go, "root")
	root._gomain = gohelper.findChild(root._go, "#go_main")
	root._simagebg = gohelper.findChildSingleImage(root._go, "#go_main/#simage_bg")
	root._simageicon = gohelper.findChildSingleImage(root._go, "#go_main/#simage_icon")
	root._simagemask = gohelper.findChildSingleImage(root._go, "#go_main/#simage_mask")
	root._simagetitle = gohelper.findChildSingleImage(root._go, "#go_main/#simage_title")
	root._txttitle = gohelper.findChildText(root._go, "#go_main/left/#txt_title")
	root._gotheme = gohelper.findChild(root._go, "#go_main/left/#txt_title/#go_theme")
	root._txttype = gohelper.findChildText(root._go, "#go_main/left/#txt_title/#go_theme/#txt_type")
	root._goclicktype = gohelper.findChild(root._go, "#go_main/left/#txt_title/#go_theme/clickArea")
	root._gotag = gohelper.findChild(root._go, "#go_main/left/#txt_title/#go_Tag")
	root._txttag = gohelper.findChildText(root._go, "#go_main/left/#txt_title/#go_Tag/#txt_Tag")
	root._txtdesc = gohelper.findChildText(root._go, "#go_main/left/#txt_desc")
	root._txthuolinum = gohelper.findChildText(root._go, "#go_main/left/info/huoli/#txt_huolinum")
	root._txtblocknum = gohelper.findChildText(root._go, "#go_main/left/info/dikuai/#txt_dikuainum")
	root._btnbuy = gohelper.findChildButtonWithAudio(root._go, "#go_main/right/#btn_buy")
	root._txtcost1num = gohelper.findChildText(root._go, "#go_main/right/#btn_buy/bg/cost1/#txt_cost1num")
	root._imagecost1num = gohelper.findChildImage(root._go, "#go_main/right/#btn_buy/bg/cost1/icon")
	root._txtcost2num = gohelper.findChildText(root._go, "#go_main/right/#btn_buy/bg/cost2/#txt_cost2num")
	root._imagecost2num = gohelper.findChildImage(root._go, "#go_main/right/#btn_buy/bg/cost2/icon")
	root._godiscount = gohelper.findChild(root._go, "#go_main/right/#go_discount")
	root._golimit = gohelper.findChild(root._go, "#go_main/right/#go_limit")
	root._gohas = gohelper.findChild(root._go, "#go_main/right/#go_has")
	root._txtdiscount = gohelper.findChildText(root._go, "#go_main/right/#go_discount/bg/label/#txt_discount")
	root._goempty = gohelper.findChild(root._go, "#go_empty")
	self.root = root

	self.root._simagebg:LoadImage(ResUrl.getStoreWildness("img_taozhuang_bg"))
	self.root._simagetitle:LoadImage(ResUrl.getStoreWildness("img_deco_1"))
	self.root._simagemask:LoadImage(ResUrl.getStoreWildness("mask"))

	root._gonewtag = gohelper.findChild(root._go, "#go_main/#go_newtag")
	root._goremaintime = gohelper.findChild(root._go, "#go_main/#go_remaintime")
	root._txtremiantime = gohelper.findChildText(root._go, "#go_main/#go_remaintime/#txt_remaintime")
	self._animator = self._go:GetComponent(typeof(UnityEngine.Animator))
end

function StoreRoomTreeItem:initNode()
	local node = self:getUserDataTb_()

	node._go = gohelper.findChild(self._go, "node")
	node._simagedetailbg = gohelper.findChildSingleImage(node._go, "#simage_detailbg")
	node._content = gohelper.findChild(node._go, "content")
	self.node = node
end

function StoreRoomTreeItem:addEventListeners()
	return
end

function StoreRoomTreeItem:removeEventListeners()
	if self.root then
		if self.root._click then
			self.root._click:RemoveClickListener()
		end

		if self.root._clickType then
			self.root._clickType:RemoveClickListener()
		end

		self.root._btnbuy:RemoveClickListener()
		self.root._simagebg:UnLoadImage()
		self.root._simageicon:UnLoadImage()
		self.root._simagemask:UnLoadImage()
		self.root._simagetitle:UnLoadImage()
	end

	if next(self.nodeItemList) then
		for i, v in ipairs(self.nodeItemList) do
			v.good:onDestroy()
		end

		self.nodeItemList = nil
	end
end

function StoreRoomTreeItem:_onClick()
	if self._view:isExpand(self._rootIndex) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

		if self.root._mo.treeRootParam then
			StoreController.instance:dispatchEvent(StoreEvent.OpenRoomStoreNode, {
				state = false,
				index = self._rootIndex,
				itemHeight = recthelper.getHeight(self._go.transform)
			})
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_close)

		if self.root._mo.treeRootParam then
			StoreController.instance:dispatchEvent(StoreEvent.OpenRoomStoreNode, {
				state = true,
				index = self._rootIndex,
				itemHeight = recthelper.getHeight(self._go.transform)
			})
		end
	end

	self.root._mo:setNewRedDotKey()
end

function StoreRoomTreeItem:_onBuyBtn(rootmo)
	if rootmo then
		StoreController.instance:openNormalGoodsView(rootmo)
	else
		logError("没找到rootmo")
	end

	self.root._mo:setNewRedDotKey()
	self:refreshNewTag()
end

function StoreRoomTreeItem:_onClickType()
	if self.themeId then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = MaterialEnum.MaterialType.RoomTheme,
			id = self.themeId
		})
	end

	self.root._mo:setNewRedDotKey()
	self:refreshNewTag()
end

function StoreRoomTreeItem:_findThemeId(productInfoArr)
	if not productInfoArr then
		return
	end

	local tRoomConfig = RoomConfig.instance

	for i, v in ipairs(productInfoArr) do
		local themeId = tRoomConfig:getThemeIdByItem(v[2], v[1])

		if themeId then
			return themeId
		end
	end
end

function StoreRoomTreeItem:onSelect(isSelect)
	return
end

function StoreRoomTreeItem:refreshNewTag()
	local needShowNew = self.root._mo:checkShowNewRedDot()

	gohelper.setActive(self.root._gonewtag, needShowNew)

	if needShowNew then
		recthelper.setAnchorX(self.root._txtremiantime.transform, -8)
	else
		recthelper.setAnchorX(self.root._txtremiantime.transform, -40)
	end
end

function StoreRoomTreeItem:onUpdateRootMO(mo)
	local update = mo.update

	if mo.type and mo.type == 0 then
		gohelper.setActive(self.root._gomain, false)
		gohelper.setActive(self.root._goempty, true)

		if self.root._click then
			self.root._click:RemoveClickListener()
		end

		if mo.update then
			self._animationStartTime = Time.time
		end

		self:_refreshOpenAnimation()

		mo.update = false
	else
		gohelper.setActive(self.root._gomain, true)
		gohelper.setActive(self.root._goempty, false)

		self.has = false
		self.root._mo = mo

		gohelper.setActive(self.root._btnbuy.gameObject, true)
		gohelper.setActive(self.root._gohas, false)
		self.root._btnbuy:AddClickListener(self._onBuyBtn, self, self.root._mo)

		self.root._click = SLFramework.UGUI.UIClickListener.Get(self.root._go)
		self.root._clickType = SLFramework.UGUI.UIClickListener.Get(self.root._goclicktype)

		self.root._click:AddClickListener(self._onClick, self)
		self.root._clickType:AddClickListener(self._onClickType, self)

		local goodsConfig = StoreConfig.instance:getGoodsConfig(mo.goodsId)
		local product = goodsConfig.product
		local productInfoArr = GameUtil.splitString2(product, true)

		self.root._simageicon:LoadImage(goodsConfig.bigImg)

		self.root._txttitle.text = string.format("「%s」", mo.goodscn)

		local desc = GameUtil.splitString2(goodsConfig.name)

		self.root._txtdesc.text = desc[1][2]

		local cost = goodsConfig.cost

		if string.nilorempty(cost) then
			self.root._txtcost1num.text = luaLang("store_free")

			gohelper.setActive(self.root._imagecost1num.gameObject, false)
		else
			local costs = string.split(cost, "|")

			if not costs[mo.buyCount + 1] then
				local costParam = costs[#costs]
				local costInfo = string.splitToNumber(costParam, "#")
				local costType = costInfo[1]
				local costId = costInfo[2]

				self.cost1Quantity = costInfo[3]

				local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(costType, costId)
				local id = costConfig.icon
				local str = string.format("%s_1", id)

				UISpriteSetMgr.instance:setCurrencyItemSprite(self.root._imagecost1num, str)
				gohelper.setActive(self.root._imagecost1num.gameObject, true)

				self.root._txtcost1num.text = self.cost1Quantity
			end
		end

		local cost2 = goodsConfig.cost2

		if string.nilorempty(cost2) then
			gohelper.setActive(self.root._imagecost2num.gameObject, false)
		else
			local costs = string.split(cost2, "|")

			if not costs[mo.buyCount + 1] then
				local costParam = costs[#costs]
				local costInfo = string.splitToNumber(costParam, "#")
				local costType = costInfo[1]
				local costId = costInfo[2]

				self.cost2Quantity = costInfo[3]

				local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(costType, costId)
				local id = costConfig.icon
				local str = string.format("%s_1", id)

				UISpriteSetMgr.instance:setCurrencyItemSprite(self.root._imagecost2num, str)
				gohelper.setActive(self.root._imagecost2num.gameObject, true)

				self.root._txtcost2num.text = self.cost2Quantity
			end
		end

		gohelper.setActive(self.root._godiscount, mo.config.originalCost > 0)

		if not string.nilorempty(self.cost2Quantity) then
			local offTag = self.cost2Quantity / mo.config.originalCost

			offTag = math.ceil(offTag * 100)
			self.root._txtdiscount.text = string.format("-%d%%", 100 - offTag)
		end

		local txthuolinum = 0
		local blockNum = 0

		for i, v in ipairs(productInfoArr) do
			self.itemType = v[1]
			self.itemId = v[2]
			self.itemNum = v[3]

			if self.itemType == MaterialEnum.MaterialType.BlockPackage then
				if self.itemId and self.itemNum then
					txthuolinum = txthuolinum + RoomConfig.instance:getBlockPackageFullDegree(self.itemId) * self.itemNum

					local blockList = RoomConfig.instance:getBlockListByPackageId(self.itemId) or {}

					for j = 1, #blockList do
						local blockCfg = blockList[j]

						if blockCfg.ownType ~= RoomBlockEnum.OwnType.Special or RoomModel.instance:isHasBlockById(blockCfg.blockId) then
							blockNum = blockNum + 1
						end
					end

					if blockNum < 1 and #blockList >= 1 then
						blockNum = 1
					end
				else
					logError("不存在值")
				end
			elseif self.itemType == MaterialEnum.MaterialType.Building then
				if self.itemId and self.itemNum then
					local roomBuildingConfig = RoomConfig.instance:getBuildingConfig(self.itemId)

					txthuolinum = txthuolinum + roomBuildingConfig.buildDegree * self.itemNum
				else
					logError("不存在值")
				end
			end
		end

		self.root._txthuolinum.text = txthuolinum
		self.root._txtblocknum.text = blockNum

		local canjump = self:checkChildCanJump(mo)

		gohelper.setActive(self.root._gotheme, not canjump)
		gohelper.setActive(self.root._gotag, canjump)
		gohelper.setActive(self.root._golimit, canjump)
		gohelper.setActive(self.root._btnbuy.gameObject, not canjump)

		if not canjump then
			self.themeId = self:_findThemeId(productInfoArr)

			gohelper.setActive(self.root._txttype.gameObject, self.themeId ~= nil)
			gohelper.setActive(self.root._goclicktype, self.themeId ~= nil)
		end

		self.has = mo:alreadyHas()

		if self.has then
			gohelper.setActive(self.root._btnbuy.gameObject, false)
			gohelper.setActive(self.root._gohas, true)
			gohelper.setActive(self.root._golimit, false)
		end

		local needShowNew = mo:checkShowNewRedDot()

		gohelper.setActive(self.root._gonewtag, needShowNew)

		if needShowNew then
			recthelper.setAnchorX(self.root._txtremiantime.transform, -8)
		else
			recthelper.setAnchorX(self.root._txtremiantime.transform, -40)
		end

		local offlineTime = mo:getOfflineTime()
		local offEndTime = offlineTime - ServerTime.now()

		gohelper.setActive(self.root._goremaintime, offlineTime > 0)

		if offEndTime > 3600 then
			local time, str = TimeUtil.secondToRoughTime(offEndTime)

			self.root._txtremiantime.text = formatLuaLang("remain", time .. str)
		else
			self.root._txtremiantime.text = luaLang("not_enough_one_hour")
		end
	end

	if update then
		self._animationStartTime = Time.time
	end

	if not mo.isjump then
		self:_refreshOpenAnimation()
	end
end

function StoreRoomTreeItem:onUpdateNodeMO(mo)
	self.node._simagedetailbg:LoadImage(ResUrl.getStoreWildness("img_zhankai_bg"))

	if next(self.nodeItemList) and self.nodeItemList.index ~= mo.rootindex then
		for key, v in ipairs(self.nodeItemList) do
			v.good:onDestroy()
		end

		gohelper.destroyAllChildren(self.node._content)

		self.nodeItemList = {}
	end

	if #self.nodeItemList ~= #mo then
		for key, v in ipairs(self.nodeItemList) do
			v.good:onDestroy()
		end

		gohelper.destroyAllChildren(self.node._content)

		self.nodeItemList = {}
	end

	for i, childmo in ipairs(mo) do
		local goodsItem = self.nodeItemList[i]

		if goodsItem == nil then
			goodsItem = {
				parent = self.node._content
			}

			local itemGO = self._view:getResInst("ui/viewres/store/normalstoregoodsitem.prefab", goodsItem.parent, "roomNode" .. i)

			goodsItem.good = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, NormalStoreGoodsItem)

			goodsItem.good:hideOffflineTime()
			goodsItem.good:init(itemGO)

			self.nodeItemList[i] = goodsItem
			self.nodeItemList.index = mo.rootindex
		end

		goodsItem.good:onUpdateMO(childmo)
		gohelper.setActive(goodsItem.go, true)
	end
end

function StoreRoomTreeItem:_refreshOpenAnimation()
	if not self._animator or not self._animator.gameObject.activeInHierarchy then
		return
	end

	local openAnimTime = self:_getAnimationTime()

	self._animator.speed = 1

	self._animator:Play(UIAnimationName.Open, 0, 0)
	self._animator:Update(0)

	local currentAnimatorStateInfo = self._animator:GetCurrentAnimatorStateInfo(0)
	local length = currentAnimatorStateInfo.length

	if length <= 0 then
		length = 1
	end

	self._animator:Play(UIAnimationName.Open, 0, (Time.time - openAnimTime) / length)
	self._animator:Update(0)
end

function StoreRoomTreeItem:_getAnimationTime()
	if not self._animationStartTime then
		return nil
	end

	local delayTime = 0.1
	local _animationDelayTimes = delayTime * self._rootIndex

	return self._animationStartTime + _animationDelayTimes
end

function StoreRoomTreeItem:checkChildCanJump(mo)
	if mo.children and #mo.children > 0 then
		for index, nodemo in ipairs(mo.children) do
			if nodemo.config.jumpId ~= 0 then
				return true
			end
		end
	end

	return false
end

return StoreRoomTreeItem
