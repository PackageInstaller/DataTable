-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardMainDlg.lua

local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local DrawProbabilityPanel = require("UI/DrawCard/DrawProbabilityPanel")
local DrawRecordPanel = require("UI/DrawCard/DrawRecordPanel")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResOpActivityDrawDetail = require("ClientData/ResOpActivityDrawDetail")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local CustomPoolTab = require("UI/DrawCard/CustomPoolTab")
local DrawFreePoolChild = require("UI/DrawCard/DrawFreePoolChild")
local DrawStandardPoolChild = require("UI/DrawCard/DrawStandardPoolChild")
local DrawNewbiePoolChild = require("UI/DrawCard/DrawNewbiePoolChild")
local DrawCustomPoolChild = require("UI/DrawCard/DrawCustomPoolChild")
local DrawGroupPoolChild = require("UI/DrawCard/DrawGroupPoolChild")
local DrawOldRoleUpPoolChild = require("UI/DrawCard/DrawOldRoleUpPoolChild")
local DrawCardNewBieActUpChild = require("UI/DrawCard/DrawCardNewBieActUpChild")
local DrawCardNewbieLightChild = require("UI/DrawCard/DrawCardNewbieLightChild")
local strClassName = "DrawCardMainDlg"
local DrawCardMainDlg = Class(strClassName, UIControls.Window)

function DrawCardMainDlg:ctor(...)
	self:initUI()
end

DrawCardMainDlg.DrawUpTypeMap = {
	[Const.DRAW_NORMAL_UP] = {
		DrawCustomPoolChild,
		"System/HeroPool/HeroUPCardPanel"
	},
	[Const.DRAW_OLD_ROLE_UP] = {
		DrawOldRoleUpPoolChild,
		"System/HeroPool/HeroPoolNewPanel02"
	},
	[Const.DRAW_NEW_BIE_UP] = {
		DrawCardNewBieActUpChild,
		"System/HeroPool/HeroPoolNewcomerUpPanel"
	},
	[Const.DRAW_NEW_BIE_LIGHT] = {
		DrawCardNewbieLightChild,
		"System/HeroPool/HeroPoolNewPanel04"
	}
}
DrawCardMainDlg.PoolChildMap = {
	[Const.DrawTypeStandard] = {
		DrawStandardPoolChild,
		"System/HeroPool/HeroPoolNormalPanel"
	},
	[Const.DrawTypeNewbie] = {
		DrawNewbiePoolChild,
		"System/HeroPool/HeroPoolNewPanel"
	},
	[Const.DrawTypeGroup] = {
		DrawGroupPoolChild,
		"System/HeroPool/HeroPoolGroupPanel"
	}
}
DrawCardMainDlg.MaxCustomPoolCount = 10

function DrawCardMainDlg:initUI(...)
	self.pnlCommonFuncEntry = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)
	self.closeBtn = UIControls.Button(self, "BtnClose", "Text")

	self.closeBtn:addEventClick(self._onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self._onClickTips)

	self.customTabsList = {}
	self.standardTab = UIControls.Button(self, "MainInfoPanel/TabPanel/Content/BtnNormalPool")

	self.standardTab:addEventClick(Functor(self.selectPool, self, Const.DrawTypeStandard))

	self.standardRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/Content/BtnNormalPool/IconNew")

	self.standardRD:addHint({
		UIConst.RD_HINT_DRAWCARD_STANDARD,
		UIConst.RD_HINT_DRAWCARD_STANDARD_ITEM
	})

	self.standardActivityIcon = UIControls.Image(self, "MainInfoPanel/TabPanel/Content/BtnNormalPool/IconActivity")
	self.freeTab = UIControls.Button(self, "MainInfoPanel/TabPanel/Content/BtnFreePool")

	self.freeTab:setVisible(false)

	self.newbieTab = UIControls.Button(self, "MainInfoPanel/TabPanel/Content/BtnNewPool")

	self.newbieTab:addEventClick(Functor(self.selectPool, self, Const.DrawTypeNewbie))

	self.newbieRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/Content/BtnNewPool/IconNew")

	self.newbieRD:addHint({
		UIConst.RD_HINT_DRAWCARD_NEWBIE
	})

	self.newbieActivityIcon = UIControls.Image(self, "MainInfoPanel/TabPanel/Content/BtnNewPool/IconActivity")
	self.groupTab = UIControls.Button(self, "MainInfoPanel/TabPanel/Content/BtnGroupPool")

	self.groupTab:addEventClick(Functor(self.selectPool, self, Const.DrawTypeGroup))

	self.groupRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/Content/BtnGroupPool/IconNew")

	self.groupRD:addHint({
		UIConst.RD_HINT_DRAWCARD_GROUP
	})

	self.groupActivityIcon = UIControls.Image(self, "MainInfoPanel/TabPanel/Content/BtnGroupPool/IconActivity")
	self.childMountPath = "MainInfoPanel/PoolPanel"
	self.pagesList = {}
	self.probabilityBtn = UIControls.Button(self, "MainInfoPanel/BtnProbability")

	self.probabilityBtn:addEventClick(self._onViewProbability)

	self.illustratedBtn = UIControls.Button(self, "MainInfoPanel/BtnIllustrated")

	self.illustratedBtn:addEventClick(self._onOpenIllustrated)

	self.recordBtn = UIControls.Button(self, "MainInfoPanel/BtnDrawLog")

	self.recordBtn:addEventClick(self._onViewRecord)

	self.wishBtn = UIControls.Button(self, "MainInfoPanel/BtnWish")

	self.wishBtn:addEventClick(self._onViewWishList)

	self.wishBtnNew = UIControls.Image(self, "MainInfoPanel/BtnWish/IconNew")
	self.probabilityPanel = DrawProbabilityPanel(self, "ProbabilityPanel")
	self.recordPanel = DrawRecordPanel(self, "DrawLogPanel")
end

function DrawCardMainDlg._getMoneyTypes(poolType, poolId)
	if poolType ~= Const.DrawTypeCustom then
		return DrawCardConfig.MONEY_TYPES[poolType] or DrawCardConfig.MONEY_TYPES[Const.DrawTypeNewbie]
	else
		local moneyList = {}
		local randInfo = DrawCardUtils.getPoolFakeRandInfo(poolId)

		if randInfo then
			local needItem = randInfo.item_id

			if needItem then
				table.insert(moneyList, needItem)
			end

			local consumeId = randInfo.consume_id

			if consumeId then
				table.insert(moneyList, consumeId)
			end
		end

		return moneyList
	end
end

function DrawCardMainDlg:selectPool(poolType, index)
	self.currentPool = poolType
	self.currentIndex = index

	local drawFakeRandId

	if self.currentPool == Const.DrawTypeCustom then
		drawFakeRandId = self.customPoolInfo[index].poolId
	elseif self.currentPool == Const.DrawTypeFree then
		drawFakeRandId = Const.DrawPoolIdFree
	elseif self.currentPool == Const.DrawTypeStandard then
		drawFakeRandId = Const.DrawPoolIdStandard
	elseif self.currentPool == Const.DrawTypeNewbie then
		drawFakeRandId = Const.DrawPoolIdNewbie
	elseif self.currentPool == Const.DrawTypeGroup then
		if CurAvatar.todayDrawGroup == Const.DrawCampLightDark or CurAvatar:poolHasReplaced(Const.DrawPoolIdLightDark) then
			drawFakeRandId = Const.DrawPoolIdLightDark
		else
			drawFakeRandId = Const.DrawPoolIdCamp
		end
	end

	self.poolId = drawFakeRandId

	CurAvatar:unsetDrawCardItemReddot(self.poolId)

	local moneyType = self._getMoneyTypes(poolType, self.poolId)

	self.pnlCommonFuncEntry:settingFund(moneyType)

	for i = 1, #self.customTabsList do
		self.customTabsList[i]:setEnable(self.currentPool ~= Const.DrawTypeCustom or index ~= i)
	end

	self.standardTab:setEnable(self.currentPool ~= Const.DrawTypeStandard)
	self.newbieTab:setEnable(self.currentPool ~= Const.DrawTypeNewbie)
	self.groupTab:setEnable(self.currentPool ~= Const.DrawTypeGroup)

	if self.poolPage then
		self.poolPage:onPanelClose()
		self.poolPage:setVisible(false)
	end

	local poolIndex

	if self.currentPool ~= Const.DrawTypeCustom then
		poolIndex = self.currentPool

		local childInfo = DrawCardMainDlg.PoolChildMap[self.currentPool]

		if childInfo and not self.pagesList[poolIndex] then
			local poolClass = childInfo[1]
			local poolPrefabPath = childInfo[2]
			local newPage = poolClass(self, self.childMountPath, poolPrefabPath, 0, 0, true)

			newPage:initData(self.currentPool, drawFakeRandId)

			self.pagesList[poolIndex] = newPage
		end
	else
		poolIndex = 100 + index

		if not self.pagesList[poolIndex] then
			local customPoolId = self.customPoolInfo[index].poolId
			local poolClientInfo = DrawCardUtils.getPoolClientInfo(customPoolId)
			local classType, poolPrefabPath
			local actId = self.customPoolInfo[index].actId
			local actObj = CurAvatar:getActivityObj(actId)

			if actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP then
				classType = DrawCardMainDlg.DrawUpTypeMap[Const.DRAW_NEW_BIE_UP][1]
				poolPrefabPath = poolClientInfo.prefab_path or DrawCardMainDlg.DrawUpTypeMap[Const.DRAW_NEW_BIE_UP][2]
			elseif actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_CAMP then
				classType = DrawCardMainDlg.DrawUpTypeMap[Const.DRAW_NEW_BIE_LIGHT][1]
				poolPrefabPath = poolClientInfo.prefab_path or DrawCardMainDlg.DrawUpTypeMap[Const.DRAW_NEW_BIE_LIGHT][2]
			elseif actObj.actData:checkIsOldRoleUpDraw() then
				classType = DrawCardMainDlg.DrawUpTypeMap[Const.DRAW_OLD_ROLE_UP][1]
				poolPrefabPath = poolClientInfo.prefab_path or DrawCardMainDlg.DrawUpTypeMap[Const.DRAW_OLD_ROLE_UP][2]
			else
				classType = DrawCardMainDlg.DrawUpTypeMap[Const.DRAW_NORMAL_UP][1]
				poolPrefabPath = poolClientInfo.prefab_path or "System/HeroPool/HeroUPCardPanel"
			end

			local newPage = classType(self, self.childMountPath, poolPrefabPath, 0, 0, true)

			newPage:initData(customPoolId, self.customPoolInfo[index].actId)

			self.pagesList[poolIndex] = newPage
		end
	end

	self.poolPage = self.pagesList[poolIndex]

	self.poolPage:onPanelOpen()
	self.poolPage:setVisible(true)
	self.recordBtn:setVisible(self.currentPool ~= Const.DrawTypeNewbie)
	self.wishBtn:setVisible(self.currentPool == Const.DrawTypeStandard and not ConditionLimitManager.inLimitState(185))
	self:wishListHasNew()
	self:refreshPool()
end

function DrawCardMainDlg:refreshPool()
	if self.poolPage then
		self.poolPage:refreshPanel()
	end
end

function DrawCardMainDlg:changePanelInfo(data)
	if self.poolPage and self.poolPage.changePanelInfo then
		self.poolPage:changePanelInfo(data)
	end
end

function DrawCardMainDlg:onOpen()
	DrawCardMainDlg.super.onOpen(self)
	CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_OPEN_PANEL, "HeroPoolMainCanvas")
	self:initPools()

	if self.poolPage then
		self.poolPage:onPanelOpen()
		self.poolPage:refreshPanel()
	else
		self:selectDefaultPool()
	end
end

function DrawCardMainDlg:initPools()
	self:initCustomPools()
	self:initReplacePools()

	local newbiePoolVisible = CurAvatar:newbiePoolVisible()

	self.newbieTab:setVisible(newbiePoolVisible)
end

function DrawCardMainDlg:selectDefaultPool()
	if CurAvatar:newbiePoolVisible() then
		self:selectPool(Const.DrawTypeNewbie)

		return
	end

	local customIdx = self:getFirstValidCustomPool()

	if customIdx and customIdx > 0 then
		self:selectPool(Const.DrawTypeCustom, customIdx)

		return
	end

	self:selectPool(Const.DrawTypeStandard)
end

function DrawCardMainDlg:onClose(...)
	if self.poolPage then
		self.poolPage:onPanelClose()
	end

	DrawCardMainDlg.super.onClose(self)
end

function DrawCardMainDlg:selectPoolById(poolId)
	local poolType, index

	if poolId == Const.DrawPoolIdFree then
		poolType = Const.DrawTypeFree
	elseif poolId == Const.DrawPoolIdStandard then
		poolType = Const.DrawTypeStandard
	elseif poolId == Const.DrawPoolIdNewbie then
		if not CurAvatar:newbiePoolVisible() then
			return
		end

		poolType = Const.DrawTypeNewbie
	elseif poolId == Const.DrawPoolIdCamp or poolId == Const.DrawPoolIdLightDark then
		poolType = Const.DrawTypeGroup
	elseif poolId == Const.DrawPoolIdRoleUp then
		poolType = Const.DrawTypeRoleUp
	else
		poolType = Const.DrawTypeCustom
		index = 1
	end

	self:selectPool(poolType, index)
end

function DrawCardMainDlg:_onClickClose(...)
	self:setVisible(false)
	self:recoverManualReject()
end

function DrawCardMainDlg:_onOpenIllustrated(...)
	return
end

function DrawCardMainDlg:_onViewProbability(...)
	if self.poolPage and self.poolId then
		local viewPoolId = self.poolId

		if self.replacePoolInfo[self.poolId] then
			local actData = self.replacePoolInfo[self.poolId]
			local upDetail = actData:getNowUpDetail(self.poolId)

			if upDetail ~= nil and upDetail.fake_pool_id then
				viewPoolId = upDetail.fake_pool_id
			end
		end

		if RegionUtils.isJP() or RegionUtils.isKR() then
			local probDlg = UIManager.getUI("drawProbabilityDetailDlg", true)

			probDlg:setPoolInfo(self.poolPage.poolName, viewPoolId, self.poolPage.currentSelectGroup)
		else
			self.probabilityPanel:setVisible(true)
			self.probabilityPanel:setPoolInfo(self.poolPage.poolName, viewPoolId)
		end
	end
end

function DrawCardMainDlg:_onClickTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_DRAWCARD)
end

function DrawCardMainDlg:_onViewRecord()
	local record

	if self.currentPool == Const.DrawTypeCustom then
		local opId = self:_getActIdByPool(self.poolId)
		local param = 0
		local actObj = CurAvatar:getActivityObjByOpId(opId)

		if actObj and actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP and self.poolPage and self.poolPage.getCurCareer then
			param = self.poolPage:getCurCareer()
		end

		DrawCardUtils.syncDrawRecord(nil, opId, param)

		record = DrawCardUtils.getDrawRecord(nil, opId)
	else
		DrawCardUtils.syncDrawRecord(self.poolId)

		record = DrawCardUtils.getDrawRecord(self.poolId)
	end

	self.recordPanel:setVisible(true)
	self.recordPanel:setRecordData(record)
end

function DrawCardMainDlg:_onViewWishList(...)
	UIManager.getUI("drawCardWishDlg", true)
end

function DrawCardMainDlg:initCustomPools()
	self.customPoolInfo = {}

	local actObjs = CurAvatar:getUpActivity()
	local hasCustomPool = #actObjs > 0

	if hasCustomPool then
		local poolCount = math.min(self.MaxCustomPoolCount, #actObjs)

		for i = 1, poolCount do
			if UIControls.checkControlFunc(self, "MainInfoPanel/TabPanel/Content/BtnPayPool" .. i) then
				local tabBtn = CustomPoolTab(self, "MainInfoPanel/TabPanel/Content/BtnPayPool" .. i, "Text")

				tabBtn:addEventClick(Functor(self.selectPool, self, Const.DrawTypeCustom, i))
				tabBtn:setVisible(true)

				self.customTabsList[i] = tabBtn

				local actObj = actObjs[i]
				local poolId = self:_getActPoolId(actObj)

				self.customPoolInfo[i] = {
					actId = actObj.actId,
					poolId = poolId,
					actObj = actObj
				}

				tabBtn:setCustomPoolInfo(poolId, actObj)
			end
		end
	end
end

function DrawCardMainDlg:refreshCustomTabs()
	for i, poolInfo in ipairs(self.customPoolInfo) do
		local actObj = poolInfo.actObj
		local poolId = poolInfo.poolId
		local tab = self.customTabsList[i]

		if tab and actObj and poolId then
			tab:setCustomPoolInfo(poolId, actObj)
		end
	end
end

function DrawCardMainDlg:getFirstValidCustomPool()
	if self.customPoolInfo and #self.customPoolInfo > 0 then
		for i, info in ipairs(self.customPoolInfo) do
			local actObj = info.actObj

			if actObj:isValid() then
				return i
			end
		end
	end
end

function DrawCardMainDlg:onShowActivity(pageData)
	local actObj = pageData[2]
	local actId = actObj.actId

	if actObj.actType == Const.ACT_TYPE_UPDRAW or actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP or actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_CAMP then
		local tabIndex = 0

		for index, poolInfo in ipairs(self.customPoolInfo) do
			if actId == poolInfo.actId and poolInfo.actObj:isValid() then
				tabIndex = index

				break
			end
		end

		if tabIndex > 0 then
			self:selectPool(Const.DrawTypeCustom, tabIndex)
		else
			self:selectPool(Const.DrawTypeStandard)
		end
	elseif actObj.actType == Const.ACT_TYPE_REPLACE_POOL then
		self:selectPool(Const.DrawTypeGroup)
	end
end

function DrawCardMainDlg:updateActivityData(actObj)
	self:initReplacePools()

	if self.poolPage and self.poolPage.selectDefaultGroup then
		self.poolPage:selectDefaultGroup()

		if self.poolPage.selectGroupPanel then
			self.poolPage.selectGroupPanel:initReplacePool()
		end
	end

	self:refreshPool()
end

function DrawCardMainDlg:updateRelatedActivityData()
	self:refreshPool()
end

function DrawCardMainDlg:_getActPoolId(actObj)
	if actObj and actObj.actData then
		return actObj.actData:getPoolId()
	end
end

function DrawCardMainDlg:_getActIdByPool(poolId)
	for i, poolInfo in ipairs(self.customPoolInfo) do
		if poolInfo.poolId == poolId and poolInfo.actObj ~= nil then
			return poolInfo.actObj.opId
		end
	end
end

DrawCardMainDlg.POOL_TAB_MAP = {
	[Const.DrawPoolIdStandard] = "standardActivityIcon",
	[Const.DrawPoolIdNewbie] = "newbieActivityIcon",
	[Const.DrawPoolIdCamp] = "groupActivityIcon",
	[Const.DrawPoolIdLightDark] = "groupActivityIcon"
}

function DrawCardMainDlg:initReplacePools()
	self.replacePoolInfo = {}

	local actObjs = CurAvatar:getReplacePoolActivity()
	local hasAct = false

	for poolId, actObj in pairs(actObjs) do
		hasAct = true
		self.replacePoolInfo[poolId] = actObj.actData

		local actClientData = actObj.actData.clientData[poolId]

		if actClientData and #actClientData > 0 then
			local clientData = actObj.actData:getNowUpDetail(poolId)
			local defaultClientData = actObj.actData:getDefaultDetail(poolId)
			local needAddTabSign = clientData ~= nil and clientData.tab_sign == 1 or defaultClientData ~= nil and defaultClientData.tab_sign == 1
			local tabName = DrawCardMainDlg.POOL_TAB_MAP[poolId]

			if tabName and self[tabName] then
				self[tabName]:setVisible(needAddTabSign)

				local imgPath

				if clientData and clientData.tab_sign_path then
					imgPath = utils.splitString(clientData.tab_sign_path, ";")
				elseif defaultClientData and defaultClientData.ori_tab_sign then
					imgPath = utils.splitString(defaultClientData.ori_tab_sign, ";")
				end

				if imgPath and #imgPath == 2 then
					self[tabName]:setImage(imgPath[1], imgPath[2])
				end
			end
		end
	end

	if not hasAct then
		self.groupActivityIcon:setVisible(false)
	end
end

function DrawCardMainDlg:wishListHasNew()
	if self.wishBtn:getVisible() then
		local hasNew = false

		if CurAvatar then
			hasNew = CurAvatar:checkWishListNew()
		end

		self.wishBtnNew:setVisible(hasNew)
	end
end

function DrawCardMainDlg:testCase(...)
	return
end

function DrawCardMainDlg:beginnerConfirm()
	if self.poolPage and self.poolPage._selectBuyOne then
		self.poolPage:_selectBuyOne()
	end
end

return DrawCardMainDlg
