-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingUpgradeView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingUpgradeView", package.seeall)

local M = class("FacilityHoldingUpgradeView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._imgBg = self:getImage("facility_holding_upgrade_view_-1239609803")
	self._canvasGroupLeft = self:getUIComponent("facility_holding_upgrade_view_-1885166537", ComponentType.CanvasGroup)
	self._canvasGroupRight = self:getUIComponent("facility_holding_upgrade_view_-361066370", ComponentType.CanvasGroup)
	self._btnDetial = self:getBtn("facility_holding_upgrade_view_-1537056899")
	self._txtNumber = self:getText("facility_holding_upgrade_view_-1642130058")
	self._txtName = self:getText("facility_holding_upgrade_view_-873105938")
	self._imgIcon = self:getImage("facility_holding_upgrade_view_-21389959")
	self._txtFacilityName = self:getText("facility_holding_upgrade_view_-934884686")
	self._txtFacilityLv = self:getText("facility_holding_upgrade_view_-1068751743")
	self._goItemSquare = self:getGo("facility_holding_upgrade_view_-1351550341")
	self._goPressGroup = self:getGo("facility_holding_upgrade_view_-605850682")
	self._goDamageManageGroup = self:getGo("facility_holding_upgrade_view_-1028312703")
	self._goContractEtaGroup = self:getGo("facility_holding_upgrade_view_-2036245471")
	self._imgModelProcess = self:getImage("facility_holding_upgrade_view_-1407644912")
	self._txtModelProcess = self:getText("facility_holding_upgrade_view_-346341215")
	self._imgModelPointIcon = self:getImage("facility_holding_upgrade_view_-710210881")
	self._txtCanLvUpCount = self:getText("facility_holding_upgrade_view_-747017392")
	self._goModuleItem = self:getGo("facility_holding_upgrade_view_-868500135")
	self._rectModuleRootBase = self:getRectTransform("facility_holding_upgrade_view_1808566843")
	self._rectModuleRootPrimary = self:getRectTransform("facility_holding_upgrade_view_-132449090")
	self._rectModuleRootAdvanced = self:getRectTransform("facility_holding_upgrade_view_1238525437")
	self._infoCellCollection = LocalReusableCollection.New(ProtomerModuleUpgradeCell, 8)
	self._goScrollReward = self:getGo("facility_holding_upgrade_view_-1976089138")
	self._goRewardItem = self:getGo("rewards_detail_item_2141037416")
	self._loopListHelper = LoopListHelper.New(self._goScrollReward)

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._imgBg = nil
	self._canvasGroupLeft = nil
	self._canvasGroupRight = nil
	self._guiAnimation = nil
	self._btnDetial = nil
	self._txtNumber = nil
	self._txtName = nil
	self._imgIcon = nil
	self._txtFacilityName = nil
	self._txtFacilityLv = nil
	self._goItemSquare = nil
	self._goPressGroup = nil
	self._goDamageManageGroup = nil
	self._goContractEtaGroup = nil
	self._imgModelProcess = nil
	self._txtModelProcess = nil
	self._imgModelPointIcon = nil
	self._txtCanLvUpCount = nil
	self._goModuleItem = nil
	self._rectModuleRootBase = nil
	self._rectModuleRootPrimary = nil
	self._rectModuleRootAdvanced = nil
	self._goScrollReward = nil
	self._goRewardItem = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil
	self._cellModuleGroup = nil
	self._infoCellCollection = nil
end

function M:bindEvents()
	self._btnDetial:AddClickListener(self._onClickDetial, self)
end

function M:unbindEvents()
	self._btnDetial:RemoveClickListener()
end

function M:onEnter()
	self._cellItem = {}

	GlobalDispatcher:addEventListener(EventType.HOUSE_PROTOMER_INFO_CHANGE, self._handleHouseProtomerInfoChange, self)

	local info = self:getFirstParam()

	self.protomerId = info and info.protomerId or 1

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(CommEnum.CurrencyCodeEnum.ProtomerModulePointCode)

	if itemCo then
		IconLoader.setSprite(self._imgModelPointIcon, IconType.ItemIcon, itemCo.icon)
	end

	self:_updateShow(self.protomerId)

	self._imgBg.color = Color.New(1, 1, 1, 1)
	self._canvasGroupLeft.alpha = 1
	self._canvasGroupRight.alpha = 1

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.HOUSE_PROTOMER_INFO_CHANGE, self._handleHouseProtomerInfoChange, self)

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._cellItem = nil

	self._loopListHelper:ClearCells()

	self._rewards = nil
	self._moduleDataLst = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
	self._infoCellCollection:clearAllInstance()
end

function M:_handleHouseProtomerInfoChange()
	self:_updateShow(self.protomerId)
end

function M:_onClickDetial()
	ContainmentFacade.instance:openPrototypeInfoView(self.protomerId)
end

function M:_updateShow(protomerId)
	local protomerMo = ProtomerModel.instance:getProtomerInfo(protomerId)

	self._txtName.text = protomerMo:getProtomerName()

	self:_setIcon(protomerId)

	self._txtNumber.text = protomerMo:getProtomerSerialNumShow()

	local cfgInfo = ContainmentConfig.instance:getProtomerInfoCoById(protomerId)

	self._txtFacilityName.text = cfgInfo.roomname
	self._txtFacilityLv.text = string.format("Lv.%d", protomerMo:getModuleUpGradeCount())

	self:_updatePressureShow(protomerId)
	self:_updateDamageManageShow(protomerId)
	self:_updateContractEtaShow(protomerId)

	self._txtCanLvUpCount.text = protomerMo:getModulePoint()

	local nowResearchPoint, needResearchPoint = protomerMo:getResearchProcess()
	local isMaxLv = needResearchPoint == 0
	local researchProcess = 1

	if isMaxLv then
		self._txtModelProcess.text = string.format("%d", protomerMo:getResearchPoint())
	else
		researchProcess = nowResearchPoint / needResearchPoint
		self._txtModelProcess.text = string.format("%d/%d", nowResearchPoint, needResearchPoint)
	end

	self._imgModelProcess.fillAmount = researchProcess

	self:_updateModuleGroup(protomerId)
	self:_updateRewadShow(protomerId)
end

function M:_setIcon(protomerId)
	ContainmentUtil.setProtomerDynIcon(self._imgIcon, protomerId)
end

function M:_updateRewadShow(protomerId)
	local len = 0
	local cfg = ContainmentConfig.instance:getProtomerCoById(protomerId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(cfg.goodsReward)

	self._rewards = {}

	table.insert(self._rewards, {
		echo = true,
		count = 0,
		itemId = cfg.echoReward
	})

	for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
		if not v.pool then
			table.insert(self._rewards, {
				echo = false,
				count = v.number,
				itemId = v.code
			})
		end
	end

	self._loopListHelper:SetListItemCount(#self._rewards, true)
	self._loopListHelper:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._rewards[curIndex]
	local itemData = ItemUtil.createItemData({
		itemId = data.itemId
	})

	itemData:setCount(data.count)

	local item = self._loopListHelper:NewListViewItem("backpack_item")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, HoldRewardItemCell)

	shower:setCellData(itemData, curIndex)
	shower:setNumShow(false)
	shower:setHandler(self)

	local signTyp = data.echo and CommEnum.BackPackItemSignTyp.Probability or CommEnum.BackPackItemSignTyp.None

	shower:setSignShow(signTyp)
	shower:setIsShowTips(true)
	shower:setShowSelectedEffect(false)
	shower:setIsShowTipsPassEvent(false)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:onRewardItemSelect(cellRewardItem)
	local instanceId = cellRewardItem:getMainGo():GetInstanceID()

	for key, value in pairs(self._cellItem or {}) do
		if key ~= instanceId then
			value:setItemSelect(false)
		end
	end
end

function M:_updatePressureShow(protomerId)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local valDefault = protomerInfoMo:getPressureLimitCfgDefault()
	local valLimitMax = protomerInfoMo:getPressureLimitCfgMax()
	local valNow = protomerInfoMo:getPressureLimitEnhance()
	local rootTrans = self._goPressGroup.transform

	self:_duelItemProcess(rootTrans, valDefault, valLimitMax, valNow)
end

function M:_updateDamageManageShow(protomerId)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local valDefault = protomerInfoMo:getDmgManageLimitCfgDefault()
	local valLimitMax = protomerInfoMo:getDmgManageLimitCfgMax()
	local valNow = protomerInfoMo:getDmgManageLimitEnhance()
	local rootTrans = self._goDamageManageGroup.transform

	self:_duelItemProcess(rootTrans, valDefault, valLimitMax, valNow)
end

function M:_updateContractEtaShow(protomerId)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local valDefault = protomerInfoMo:getEchoEffLimitCfgDefault()
	local valLimitMax = protomerInfoMo:getEchoEffLimitCfgMax()
	local valNow = protomerInfoMo:getEchoEffLimitEnhance()
	local rootTrans = self._goContractEtaGroup.transform

	self:_duelItemProcess(rootTrans, valDefault, valLimitMax, valNow)
end

function M:_duelItemProcess(rootTrans, valDefault, valLimitMax, valNow)
	while valLimitMax > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goItemSquare, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < valLimitMax
		local isDefault = i < valDefault
		local isEnhance = i < valNow and not isDefault
		local isWeaken = isDefault and valNow < valDefault and valNow <= i
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local goDefault = goutil.findChild(tempGo, "startValue")
			local goEnhance = goutil.findChild(tempGo, "up")
			local goWeaken = goutil.findChild(tempGo, "down")

			goutil.setActive(goDefault, isDefault)
			goutil.setActive(goEnhance, isEnhance)
			goutil.setActive(goWeaken, isWeaken)
		end

		goutil.setActive(tempGo, show)
	end
end

function M:_updateModuleGroup(protomerId)
	if self._infoCellCollection then
		self._infoCellCollection:clearAllInstance()
	end

	local protomerMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local cfgProtomer = ContainmentConfig.instance:getProtomerCoById(protomerId)
	local cfgModule = ContainmentConfig.instance:getHouseModelCoLstByCode(cfgProtomer.module)
	local count_base = 1
	local count_primary = 0
	local count_advanced = 0

	self._moduleDataLst = {}

	for _, value in pairs(cfgModule) do
		local theModuleId = value.module

		count_primary = count_primary + (value.moduletyp == ContainmentEnum.moduleTypPrimary and 1 or 0)
		count_advanced = count_advanced + (value.moduletyp == ContainmentEnum.moduleTypAdvanced and 1 or 0)

		local theLockTyp = ContainmentEnum.ModuleLockTyp.Lock
		local preModuleLst = {}

		if value.moduletyp == ContainmentEnum.moduleTypPrimary then
			table.insert(preModuleLst, 0)
		end

		local preModuleCount = value.preModule and #value.preModule or 0

		if preModuleCount == 0 then
			theLockTyp = protomerMo:getIsModuleUpGrade(theModuleId) and ContainmentEnum.ModuleLockTyp.isUpgrade or ContainmentEnum.ModuleLockTyp.CanUpgrade
		else
			theLockTyp = ContainmentEnum.ModuleLockTyp.CanUpgrade

			for preKey, preVal in pairs(value.preModule) do
				if protomerMo:getIsModuleUpGrade(preVal) == false then
					theLockTyp = ContainmentEnum.ModuleLockTyp.Lock
				end

				table.insert(preModuleLst, preVal)
			end

			if protomerMo:getIsModuleUpGrade(theModuleId) then
				theLockTyp = ContainmentEnum.ModuleLockTyp.isUpgrade
			end
		end

		self._moduleDataLst[theModuleId] = {
			protomerId = self.protomerId,
			preLst = preModuleLst,
			lockTyp = theLockTyp,
			cfg = value
		}
	end

	local layoutInfo = {
		contentWidth = goutil.getWidth(self._rectModuleRootBase),
		spacing = self._rectModuleRootBase.gameObject:GetComponent(UIComponentType.HorizontalOrVerticalLayoutGroup).spacing,
		baseNum = count_base,
		primaryNum = count_primary,
		advancedNum = count_advanced
	}

	for key, value in pairs(self._moduleDataLst or {}) do
		self._moduleDataLst[key].layoutInfo = layoutInfo
	end

	self:_fixModuleCount(self._rectModuleRootBase, count_base)

	self._cellModuleGroup = {}
	self._cacheIndex = 0
	self._cacheTyp = 0

	for theModuleId, myData in pairs(self._moduleDataLst) do
		local typ = myData.cfg.moduletyp

		if typ ~= self._cacheTyp then
			self._cacheIndex = 0
			self._cacheTyp = typ
		end

		local itemData = self._moduleDataLst[myData.cfg.module]
		local shower = self._infoCellCollection:createInstance(self._goModuleItem)

		shower.view = self

		goutil.addChildToParent(shower.mainGO, self:_getParent(typ))
		goutil.setActive(shower.mainGO, true)

		self._cellModuleGroup[myData.cfg.module] = shower

		shower:setHandler(self)
		shower:setCellData(itemData)

		self._cacheIndex = self._cacheIndex + 1
	end

	self._cacheIndex = nil
	self._cacheTyp = nil
end

function M:_fixModuleCount(rootTrans, count)
	while count > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goModuleItem, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < count
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local lineGo = goutil.findChild(tempGo, "line_root")

			goutil.setActive(lineGo, false)
		end

		goutil.setActive(tempGo, show)
	end
end

function M:_getTypModuleGroupChild(typ, index)
	if typ == ContainmentEnum.moduleTypPrimary then
		return self._rectModuleRootPrimary:GetChild(index)
	elseif typ == ContainmentEnum.moduleTypAdvanced then
		return self._rectModuleRootAdvanced:GetChild(index)
	else
		printError(string.format("检查typ[%d],暂不支持此类型"))

		return self._rectModuleRootBase:GetChild(0)
	end
end

function M:_getParent(typ)
	if typ == ContainmentEnum.moduleTypPrimary then
		return self._rectModuleRootPrimary
	elseif typ == ContainmentEnum.moduleTypAdvanced then
		return self._rectModuleRootAdvanced
	else
		printError(string.format("检查typ[%d],暂不支持此类型"))

		return self._rectModuleRootBase
	end
end

return M
