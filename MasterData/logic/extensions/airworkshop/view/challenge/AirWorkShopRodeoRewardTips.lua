-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoRewardTips.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoRewardTips", package.seeall)

local M = class("AirWorkShopRodeoRewardTips", ViewComponent)

M.SubViewTyp = {
	Upgrade3 = 1,
	Degrade = 5,
	Upgrade2 = 2,
	KeepLevel = 4,
	Upgrade1 = 3,
	First = 6
}
M.LvState2Page = {
	[AirWorkShopEnum.LvState.UP3] = M.SubViewTyp.Upgrade3,
	[AirWorkShopEnum.LvState.UP2] = M.SubViewTyp.Upgrade2,
	[AirWorkShopEnum.LvState.UP1] = M.SubViewTyp.Upgrade1,
	[AirWorkShopEnum.LvState.KEEP] = M.SubViewTyp.KeepLevel,
	[AirWorkShopEnum.LvState.DOWN] = M.SubViewTyp.Degrade
}
M.ViewData = {
	[M.SubViewTyp.Upgrade3] = {
		ratio = "up3Ratio",
		rewardCode = "up3Reward"
	},
	[M.SubViewTyp.Upgrade2] = {
		ratio = "up2Ratio",
		rewardCode = "up2Reward"
	},
	[M.SubViewTyp.Upgrade1] = {
		ratio = "up1Ratio",
		rewardCode = "up1Reward"
	},
	[M.SubViewTyp.KeepLevel] = {
		ratio = "keepRatio",
		rewardCode = "keepReward"
	},
	[M.SubViewTyp.Degrade] = {
		ratio = "downRatio",
		rewardCode = "downReward"
	},
	[M.SubViewTyp.First] = {
		rewardCode = "firstUpReward"
	}
}
M.TabData = {
	{
		state = AirWorkShopEnum.LvState.UP3
	},
	{
		state = AirWorkShopEnum.LvState.UP2
	},
	{
		state = AirWorkShopEnum.LvState.UP1
	},
	{
		state = AirWorkShopEnum.LvState.KEEP
	},
	{
		state = AirWorkShopEnum.LvState.DOWN
	},
	{
		tabNameLangKey = "tip_air_lv_state_first_up"
	}
}
M.RatioOrder = {
	"up3Ratio",
	"up2Ratio",
	"up1Ratio",
	"keepRatio",
	"downRatio"
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._btnExit = self:getBtnByPath("middle_tips_common_bg/clickExit")
	self._loopList = LoopListHelper.New(self:getGo("sports_reward_tips_-1077034103"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("3&left_tab_list_-1767715410"), LeftTabListComp)

	self._tabComp:resetTabList()

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)

	for i, _tabData in ipairs(M.TabData) do
		local tabName = string.nilorempty(_tabData.tabNameLangKey) and AirWorkShopUtil.getRodeoLvStateName(_tabData.state) or lang(_tabData.tabNameLangKey)
		local tabCell = self._tabComp:createTabCell(LeftTabListCellMO.New({
			tabName = tabName,
			iconType = IconType.activityTabIcon,
			redDotKeyList = {},
			redDotParentKeyLsit = {}
		}))

		self._toggleTabControl:addToggleTab(tabCell:getToggleTab())
	end

	self._goTitlePlayerNum = goutil.findChild(self.mainGO, "allContent/img1/txt3").gameObject
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnExit:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnExit:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
	self._tabComp:onEnter()

	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()

	self._curLv = info:getLv()
	self._lvState = info:getState()

	local defualtTabIndex = M.LvState2Page[info:getState()] or M.SubViewTyp.KeepLevel

	self._toggleTabControl:selectTab(defualtTabIndex)
end

function M:onExit()
	self._tabComp:onExit()
	removetimer(self._refreshScrollToLvIndex, self)

	self._activeIndex = nil

	self._loopList:ClearCells()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)

	self._cfgLst = nil
	self._cfgPageLst = nil
end

function M:_onClickClose()
	self:close()
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:_prepareData()
		self:refreshView()
	end
end

function M:_prepareData()
	if not self._cfgLst then
		self._cfgLst = {}

		local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()

		for i = maxLv, minLv, -1 do
			local cfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirAtkPoint, i)

			table.insert(self._cfgLst, cfg)
		end
	end
end

function M:_getPageCfgList(tabIndex)
	if not self._cfgPageLst then
		self._cfgPageLst = {}
	end

	if not self._cfgPageLst[tabIndex] then
		self._cfgPageLst[tabIndex] = {}

		local curRatioKey = M.ViewData[tabIndex].ratio

		for _, cfg in ipairs(self._cfgLst) do
			local rewardNum = #self:_getRewardList(cfg[M.ViewData[self._activeIndex].rewardCode])

			if rewardNum > 0 then
				if curRatioKey then
					local curRatio = cfg[curRatioKey]

					if curRatio > 0 then
						table.insert(self._cfgPageLst[tabIndex], cfg)
					end
				else
					table.insert(self._cfgPageLst[tabIndex], cfg)
				end
			end
		end
	end

	return self._cfgPageLst[tabIndex]
end

function M:refreshView()
	removetimer(self._refreshScrollToLvIndex, self)

	self._curCfgLst = self:_getPageCfgList(self._activeIndex)

	local len = #self._curCfgLst

	if len > 0 then
		local totalCount = len + 1

		if self._loopList:GetLoopListView().ItemTotalCount ~= totalCount then
			self._loopList:SetListItemCount(totalCount, true)
		else
			self._loopList:RefreshAllShownItem()
		end

		if self._activeIndex == M.LvState2Page[self._lvState] then
			settimer(0, self._refreshScrollToLvIndex, self, false)
		end
	else
		self._loopList:ClearCells()
	end

	goutil.setActive(self._goTitlePlayerNum, M.ViewData[self._activeIndex].ratio)
end

function M:_refreshScrollToLvIndex()
	local setIndex

	for index, cfg in ipairs(self._curCfgLst or {}) do
		if not setIndex and cfg.lv == self._curLv then
			setIndex = index - 1
		end
	end

	if setIndex then
		self._loopList:MoveToItemIndex(setIndex)
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data
	local prefabName = "reward_item"
	local item

	if curIndex <= #self._curCfgLst then
		data = self._curCfgLst[curIndex]
		prefabName = "reward_item"
		item = self._loopList:NewListViewItem(prefabName)

		self:_updateCell(item.gameObject, data)
	else
		prefabName = "space_item"
		item = self._loopList:NewListViewItem(prefabName)
	end

	return item
end

function M:_updateCell(go, cfg)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			goCur = goutil.findChild(go, "imgCurrent"),
			goLv1Bg = goutil.findChild(go, "imgQualityBg_S").gameObject,
			imgLv1 = goutil.findChildImageComponent(go, "imgLevel1"),
			imgLv2 = goutil.findChildImageComponent(go, "imgLevel2"),
			txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.Text)
		}

		local rewardRoot = goutil.findChildComponent(go, "rewardGroup", UIComponentType.RectTransform)

		while rewardRoot.childCount < 3 do
			goutil.cloneAndSetParent(rewardRoot:GetChild(0).gameObject, rewardRoot)
		end

		theItem.rewardCellLst = {}

		for i = 0, rewardRoot.childCount - 1 do
			local itemCell = Astral.SimpleLuaComponentContainer.Add(rewardRoot:GetChild(i).gameObject, ItemCell)

			itemCell:setShowSelectedEffect(false)
			table.insert(theItem.rewardCellLst, itemCell)
		end

		self._itemData[key] = theItem
	end

	AirWorkShopUtil.rodeoLvImgChange(cfg.lv, theItem.imgLv1, theItem.imgLv2, theItem.goLv1Bg, nil)
	goutil.setActive(theItem.goCur, self._curLv == cfg.lv and self._activeIndex == M.LvState2Page[self._lvState])

	local curRatioKey = M.ViewData[self._activeIndex].ratio
	local curRatio = curRatioKey and cfg[curRatioKey] or -1
	local ratioStr

	if curRatio > 0 then
		local ratioTotal = 0
		local ratioLeft = 0
		local ratioRight = 0

		for _, _key in ipairs(M.RatioOrder) do
			local offset = math.floor(cfg[_key] * 100)

			if _key == curRatioKey then
				ratioLeft = ratioTotal
				ratioRight = ratioTotal + offset
			else
				ratioTotal = ratioTotal + offset
			end
		end

		ratioStr = string.format("前%s%%-%s%%", ratioLeft, ratioRight)
	end

	theItem.txtContent.text = ratioStr

	local rewardList = self:_getRewardList(cfg[M.ViewData[self._activeIndex].rewardCode])
	local len = #rewardList

	for i = 1, #theItem.rewardCellLst do
		goutil.setActive(theItem.rewardCellLst[i]:getGo(), i <= len)

		if i <= len then
			theItem.rewardCellLst[i]:updateData(ItemUtil.createItemData({
				itemId = rewardList[i].itemId,
				count = rewardList[i].num
			}))

			local isReceive = false

			if self._activeIndex == M.SubViewTyp.First then
				isReceive = AirWorkShopChallengeModel.instance:isFirstRewardReceive(cfg.lv)
			end

			goutil.setActive(theItem.rewardCellLst[i]:findUIElement("backpack_item_1042455870"), isReceive)
		end
	end
end

function M:_getRewardList(rewardId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)
	local tempList = {}

	if rewardCO then
		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			table.insert(tempList, {
				itemId = v.code,
				num = v.num
			})
		end
	end

	return tempList
end

return M
