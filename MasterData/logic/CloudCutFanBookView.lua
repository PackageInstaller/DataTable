-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/view/CloudCutFanBookView.lua

module("logic.extensions.cloudcutfan.view.CloudCutFanBookView", package.seeall)

local CloudCutFanBookView = class("CloudCutFanBookView", ViewComponent)

function CloudCutFanBookView:ctor()
	CloudCutFanBookView.super.ctor(self)
end

function CloudCutFanBookView:unbindEvents()
	CloudCutFanBookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnMake)
	GameUtil.rmClickHandler(self._btnRepair)
end

function CloudCutFanBookView:bindEvents()
	CloudCutFanBookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnMake, self._onClickBtnMake, self)
	GameUtil.addClickHandler(self._btnRepair, self._onClickBtnRepair, self)
end

function CloudCutFanBookView:buildUI()
	CloudCutFanBookView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnRepair = self:getGo("btnRepair")
	self._txtCostTips = self:getTxt("costTips/txt")
	self._itemCostTips = self:getGo("costTips/item")
	self._btnMake = self:getGo("btnMake")
	self._txtTimeTips = self:getTxt("timeTips/txt")

	local goCellPrize = self:getGo("prize/cell")
	local goTabPrize = self:getGo("prize/tableview")

	self._tableviewPrize = ScrollerList.create(goTabPrize, goCellPrize, GameUtil.handler(self._updateCellPrize, self), GameUtil.handler(self._clearCellPrize, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumNum = self:getTxt("prize/num/txtNum")

	local goTabFace = self:getGo("tableviewFace")
	local goCellFace = self:getGo("tableviewFace/tablecell")

	self._tableviewFace = ScrollerList.create(goTabFace, goCellFace, GameUtil.handler(self._updateCellFace, self), GameUtil.handler(self._clearCellFace, self))

	local goTabFan = self:getGo("tableviewFan")
	local goCellFan = self:getGo("tableviewFan/tablecell")

	self._tableviewFan = ScrollerList.create(goTabFan, goCellFan, GameUtil.handler(self._updateCellFan, self), GameUtil.handler(self._clearCellFan, self))
end

function CloudCutFanBookView:onExit()
	CloudCutFanBookView.super.onExit(self)
	MaterialMgr.resetAll(self._itemCostTips)
	self._tableviewPrize:dispose()
	self._tableviewFace:dispose()
	self._tableviewFan:dispose()
end

function CloudCutFanBookView:onEnter()
	CloudCutFanBookView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_CloudCutFanInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_CloudCutFanGetRewardPrizeRes, self._updateUIPrize, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = CloudCutFanController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	CloudCutFanController.instance:getInfo(self._activityId)
end

function CloudCutFanBookView:_updateUIByCfg()
	self._actCfg = CloudCutFanConfig.instance:getActCfgByActId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._craftLimitCount = self._actCfg.dailyCraftCount or 0
	self._repairCostStr = self._actCfg.repairCost or ""
	self._costItemType, self._costItemId, self._costItemNum = MaterialMgr.getMatParams(self._repairCostStr)

	MaterialMgr.setIcon(self._itemCostTips, self._costItemType, self._costItemId)

	self._txtCostTips.text = langPara("%s/%s", self._costItemNum, MaterialModel.instance:getMaterialsNumber(self._costItemType, self._costItemId))
	self._allFanFaceCfgs = CloudCutFanConfig.instance:getAllFanFaceCfgs(self._activityId) or {}
	self._allFanMakeCfgs = CloudCutFanConfig.instance:getAllFanMakeCfgs(self._activityId) or {}
	self._showFanMakeCfgs = {}

	for _, makeCfg in ipairs(self._allFanMakeCfgs) do
		table.insert(self._showFanMakeCfgs, makeCfg)
	end

	self._allFanRewardPrizeCfgs = CloudCutFanConfig.instance:getAllFanRewardPrizeCfgs(self._activityId) or {}
end

function CloudCutFanBookView:_updateUIByInfo()
	self._todayCraftUsedCount = 0
	self._unLockCount = 0
	self._curUnLockFaceId = 0
	self._isTodayRepairedFace = false

	local info = CloudCutFanModel.instance:getInfo(self._activityId)

	if info then
		self._todayCraftUsedCount = info.todayCraftUsedCount or 0
		self._unLockCount = CloudCutFanModel.instance:getTotalUnlockCount(self._activityId)
		self._curUnLockFaceId = info.unLockFace or 0
		self._isTodayRepairedFace = info.todayRepairedFace or false
	end

	self._txtTimeTips.text = langPara("解锁次数：%s/%s", self._craftLimitCount - self._todayCraftUsedCount, self._craftLimitCount)

	self:_updateUIPrize()
	self._tableviewFace:reloadData(self._allFanFaceCfgs)
	table.sort(self._showFanMakeCfgs, function(a, b)
		local isAUnlock = CloudCutFanModel.instance:isFanUnlocked(self._activityId, a.fanId)
		local isBUnlock = CloudCutFanModel.instance:isFanUnlocked(self._activityId, b.fanId)

		if isAUnlock ~= isBUnlock then
			return isAUnlock
		end

		return a.fanId < b.fanId
	end)
	self._tableviewFan:reloadData(self._showFanMakeCfgs)
end

function CloudCutFanBookView:_updateUIPrize()
	self._txtNumNum.text = self._unLockCount

	local showIndex = -1
	local lastIndex = -1
	local scoreList = {}

	for index, prizeCfg in ipairs(self._allFanRewardPrizeCfgs) do
		if not prizeCfg.requiredCount then
			local requiredCount = 0

			table.insert(scoreList, requiredCount)

			if not prizeCfg.prizeId then
				local prizeId = 0
				local canGain = requiredCount <= self._unLockCount and not CloudCutFanModel.instance:isRewardPrizeGained(self._activityId, prizeId)

				if canGain and showIndex == -1 then
					showIndex = index
				end

				if requiredCount <= self._unLockCount then
					lastIndex = index
				end
			end
		end
	end

	if lastIndex <= 0 then
		lastIndex = 1
	end

	if showIndex < 0 then
		showIndex = lastIndex
	end

	self._tableviewPrize:updateUnderSlider(self._progressBar, self._unLockCount, scoreList)
	self._tableviewPrize:MoveCellToBegin(showIndex - 1)
	self._tableviewPrize:reloadData(self._allFanRewardPrizeCfgs)
end

function CloudCutFanBookView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function CloudCutFanBookView:_onClickBtnMake()
	if self._todayCraftUsedCount >= self._craftLimitCount then
		TipsFacade.instance:openCommonTips(lang("今日制作次数已用完"))

		return
	end

	UIStateManager.instance:push(ViewName.CloudCutFanMakeView, self._activityId)
end

function CloudCutFanBookView:_onClickBtnRepair()
	if self._isTodayRepairedFace then
		TipsFacade.instance:openCommonTips(lang("今日已完成修复"))

		return
	end

	if ((self._allFanFaceCfgs or nil) and #self._allFanFaceCfgs) <= self._curUnLockFaceId then
		TipsFacade.instance:openCommonTips(lang("已修复全部扇面"))

		return
	end

	local tips = langPara("确定消耗%s%s开始修复扇面？", self._costItemNum, MaterialMgr.getMaterialsName(self._costItemType, self._costItemId))

	TipsFacade.instance:openPopupCostMatViewNew(self._costItemType, self._costItemId, self._costItemNum, tips, function()
		UIStateManager.instance:push(ViewName.CloudCutFanRepairView, self._activityId, self._curUnLockFaceId + 1)
	end)
end

function CloudCutFanBookView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function CloudCutFanBookView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function CloudCutFanBookView:_updateCellPrize(view, cell, data)
	if not data.prizeId then
		local prizeId = 0
		local hasGain = CloudCutFanModel.instance:isRewardPrizeGained(self._activityId, prizeId)

		if not data.requiredCount then
			local requiredCount = 0
			local canGain = requiredCount <= self._unLockCount and not hasGain
			local go = cell.gameObject
			local txtNum = goutil.findChildTextComponent(go, "txtNum")

			txtNum.text = requiredCount

			local btnGet = goutil.findChild(go, "btnGet")
			local goItem = goutil.findChild(go, "item")

			MaterialMgr.setCellByCfg(data.rewardPrize, goItem)

			local conEffect = goutil.findChild(go, "effect")

			if canGain then
				GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, data))
				self:_playCellEffect(conEffect)
				goutil.setActive(btnGet, true)
			else
				GameUtil.rmClickHandler(btnGet)
				self:_clearCellEffect(conEffect)
				goutil.setActive(btnGet, false)
			end

			local geted = goutil.findChild(go, "geted")

			goutil.setActive(geted, hasGain)
		end
	end
end

function CloudCutFanBookView:_clearCellPrize(cell)
	local go = cell.gameObject
	local goEffect = goutil.findChild(go, "effect")

	self:_clearCellEffect(goEffect)

	local btnGet = goutil.findChild(go, "btnGet")

	GameUtil.rmClickHandler(btnGet)
end

function CloudCutFanBookView:_onClickGainPrize(data)
	if not data.prizeId then
		local prizeId = 0
		local hasGain = CloudCutFanModel.instance:isRewardPrizeGained(self._activityId, prizeId)

		if hasGain then
			TipsFacade.instance:openCommonTips(lang("已领取过该奖励了哦~"))
			self:_updatePrizes()

			return
		end

		if not data.requiredCount then
			local requiredCount = 0

			if requiredCount > self._unLockCount then
				TipsFacade.instance:openCommonTips(lang("解锁数量不足哦~"))
				self:_updatePrizes()

				return
			end

			CloudCutFanController.instance:getRewardPrize(self._activityId)
		end
	end
end

function CloudCutFanBookView:_updateCellFan(view, cell, data)
	local go = cell.gameObject
	local markLock = goutil.findChild(go, "markLock")
	local icon = goutil.findChild(go, "icon")
	local txtName = goutil.findChildTextComponent(go, "name/txt")
	local isUnlock = CloudCutFanModel.instance:isFanUnlocked(self._activityId, data.fanId)

	goutil.setActive(markLock, not isUnlock)

	txtName.text = data.name or ""

	if not data.bookPic then
		local picPath = ""
		local truePath = GameUrl.getItemIconUrl(picPath)

		if not GameUtil.isEmptyString(truePath) then
			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, truePath, function()
				local img = icon:GetComponent(goutil.Type_UIImage)

				img:SetNativeSize()

				img.raycastTarget = false

				GameUtil.SetGray(icon, not isUnlock)
			end)
		end
	end
end

function CloudCutFanBookView:_clearCellFan(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
end

function CloudCutFanBookView:_updateCellFace(view, cell, data)
	local go = cell.gameObject
	local markLock = goutil.findChild(go, "markLock")
	local icon = goutil.findChild(go, "icon")
	local txtName = goutil.findChildTextComponent(go, "name/txt")

	if self._curUnLockFaceId > 0 then
		if data.fanFaceId then
			local isUnlock = data.fanFaceId <= self._curUnLockFaceId

			goutil.setActive(markLock, not isUnlock)

			txtName.text = data.showName or ""

			if not data.bookPic then
				local picPath = ""
				local truePath = CloudCutFanController.instance:getUseMatPicUrl(picPath)

				if not GameUtil.isEmptyString(truePath) then
					uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, truePath, function()
						local img = icon:GetComponent(goutil.Type_UIImage)

						img:SetNativeSize()

						img.raycastTarget = false

						GameUtil.SetGray(icon, not isUnlock)
					end)
				end
			end
		end
	end
end

function CloudCutFanBookView:_clearCellFace(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
end

return CloudCutFanBookView
