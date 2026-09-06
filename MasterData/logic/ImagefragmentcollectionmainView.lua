-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/view/ImagefragmentcollectionmainView.lua

module("logic.extensions.imagefragmentcollection.view.ImagefragmentcollectionmainView", package.seeall)

local ImagefragmentcollectionmainView = class("ImagefragmentcollectionmainView", ViewComponent)

function ImagefragmentcollectionmainView:unbindEvents()
	ImagefragmentcollectionmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnMass:RemoveClickListener()
	self._btnShare1:RemoveClickListener()
	self._btnShare2:RemoveClickListener()
end

function ImagefragmentcollectionmainView:bindEvents()
	ImagefragmentcollectionmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnMass:AddClickListener(self._onClickbtnMass, self)
	self._btnShare1:AddClickListener(self._onClickbtnShare, self)
	self._btnShare2:AddClickListener(self._onClickbtnShare2, self)
end

function ImagefragmentcollectionmainView:buildUI()
	ImagefragmentcollectionmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnMass = self:getBtn("massRoot/btnMass")
	self._btnShare1 = self:getBtn("btnShare")
	self._btnMassDot = self:getGo("massRoot/btnMass/red")
	self._collectAllPrizeGo = self:getGo("collectAllPrize")
	self._collectAllItemGroup = ItemGroup.New(self._collectAllPrizeGo, nil, nil, nil, true)
	self._leftImgRootGo = self:getGo("leftImgRoot")
	self._rightImgRootGo = self:getGo("rightImgRoot")
	self._fragmentImgItems = {}

	self:_buildFragmentImgItems(1, self._leftImgRootGo)
	self:_buildFragmentImgItems(2, self._rightImgRootGo)

	self._effectHandles = {}
	self._txtLeftTime = self:getTxt("time/txtTime")
	self._txtMass = goutil.findChildTextComponent(self.mainGO, "massRoot/txtMass")
	self._rewardSliderGo = self:getGo("massRoot/rewardSlider")
	self._rewardSliderSizeX = self._rewardSliderGo.transform.sizeDelta.x
	self._massRewardCellGo = self:getGo("massRoot/rewardSlider/cell")
	self._massItemGroup = ItemGroup.New(self._rewardSliderGo, self._massRewardCellGo, nil, nil, true)
	self._massSlider = self:getSlider("massRoot/rewardSlider/slider")
	self._btnShare2 = self:getBtn("btnShare2")
	self._effectGo = self:getGo("effect")
	self._maskGo = self:getGo("maskGo")
end

function ImagefragmentcollectionmainView:_buildFragmentImgItems(idx, root)
	if self._fragmentImgItems[idx] then
		return
	end

	local item = {
		fullImgGo = goutil.findChild(root, "fullImg"),
		itemcon = goutil.findChild(root, "itemcon"),
		itemGo = goutil.findChild(root, "item"),
		activeAllEffectGo = goutil.findChild(root, "activeAllEffect")
	}

	item.itemGroup = ItemGroup.New(item.itemcon, item.itemGo, nil, nil, true)

	goutil.setActive(item.itemGo, false)

	self._fragmentImgItems[idx] = item
end

function ImagefragmentcollectionmainView:onExit()
	ImagefragmentcollectionmainView.super.onExit(self)
	GlobalDispatcher:removeListener(ImagefragmentcollectionController.PM_ImageFragmentCollectionInfoRes, self._PM_ImageFragmentCollectionInfoRes, self)
	GlobalDispatcher:removeListener(ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveImagePrizeRes, self._ReceiveImagePrizeRes, self)
	GlobalDispatcher:removeListener(ImagefragmentcollectionController.PM_ImageFragmentCollectionMassRes, self._CollectionMassRes, self)
	GlobalDispatcher:removeListener(ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveMassPrizeRes, self._CollectionReceiveMassPrizeRes, self)
	self._collectAllItemGroup:dispose(function(item)
		local goCon = goutil.findChild(item.mainGO, "con")

		MaterialMgr.resetAll(goCon)
	end)

	for k, v in pairs(self._effectHandles) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectHandles = {}

	self._massItemGroup:dispose(function(item)
		local goItem = goutil.findChild(item.mainGO, "item")

		MaterialMgr.resetAll(goItem)
	end)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	UIEffectManager.instance:stopEffect(self._activeEffectHandler)
	goutil.setActive(self._maskGo, false)

	self._playActiveEffect = false
	self._activeCache = false
end

function ImagefragmentcollectionmainView:onEnter()
	ImagefragmentcollectionmainView.super.onEnter(self)
	GlobalDispatcher:addListener(ImagefragmentcollectionController.PM_ImageFragmentCollectionInfoRes, self._PM_ImageFragmentCollectionInfoRes, self)
	GlobalDispatcher:addListener(ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveImagePrizeRes, self._ReceiveImagePrizeRes, self)
	GlobalDispatcher:addListener(ImagefragmentcollectionController.PM_ImageFragmentCollectionMassRes, self._CollectionMassRes, self)
	GlobalDispatcher:addListener(ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveMassPrizeRes, self._CollectionReceiveMassPrizeRes, self)

	local params = self:getOpenParam()

	self._activityType = GameEnum.ActivityType.ImageFragmentCollection
	self._activityId = checknumber(params[1])

	self:_updateUI()

	self._activeCache = ImagefragmentcollectionController.instance:getActiveCache()

	ImagefragmentcollectionController.instance:clearActiveCache()
	goutil.setActive(self._maskGo, self._activeCache)
	ImageFragmentCollectionAgent.instance:sendPM_ImageFragmentCollectionInfoReq(self._activityId)
	self:_playEffect()
end

function ImagefragmentcollectionmainView:_onClickbtnClose()
	self:close()
end

function ImagefragmentcollectionmainView:_onClickbtnMass()
	if not ImagefragmentcollectionModel.instance:isMassToday() then
		ImageFragmentCollectionAgent.instance:sendPM_ImageFragmentCollectionMassReq(self._activityId)
	else
		FloatWordMgr.instance:show("今日已集结")
	end
end

function ImagefragmentcollectionmainView:_onClickbtnShare()
	UIStateManager.instance:push(ViewName.ImagefragmentcollectionhotView, self._activityId, 1)
end

function ImagefragmentcollectionmainView:_onClickbtnShare2()
	UIStateManager.instance:push(ViewName.ImagefragmentcollectionhotView, self._activityId, 2)
end

function ImagefragmentcollectionmainView:_updateUI()
	self:_updateCollectAllItems()
	self:_updateMassItems()
	self:_updateFragmentItems()
	self:_setActTime()
end

function ImagefragmentcollectionmainView:_updateCollectAllItems()
	local cfg = ImagefragmentcollectionConfig.instance:getCollectionCfg(self._activityId)
	local pcfgs = ImagefragmentcollectionConfig.instance:getPrizePlanCfgs(cfg.prizePlanId)

	self._collectAllItemGroup:updateWithNoCreate(#pcfgs, function(item, index)
		goutil.setActive(item.mainGO, true)

		local pcfg = pcfgs[index]
		local goCon = goutil.findChild(item.mainGO, "con")
		local goEffect = goutil.findChild(item.mainGO, "effect")
		local goylq = goutil.findChild(item.mainGO, "ylq")
		local txtDesc = goutil.findChildTextComponent(item.mainGO, "txtDesc")
		local txtProgress = goutil.findChildTextComponent(item.mainGO, "progress/text")
		local slider = Framework.SliderAdapter.GetFrom(item.mainGO, "slider")
		local progress = ImagefragmentcollectionModel.instance:getCollectionProgress(pcfg.imageId)
		local hasGet = ImagefragmentcollectionModel.instance:hasGetCollectionProgressPrize(pcfg.imageId)
		local fcfgs = ImagefragmentcollectionConfig.instance:getFragmentPlanCfgs(pcfg.fragmentPlanId)
		local baseProgress = #fcfgs
		local proxy = MaterialMgr.setCellByCfg(pcfg.prize, goCon)

		txtDesc.text = pcfg.desc
		txtProgress.text = string.format("%s/%s", progress, baseProgress)

		goutil.setActive(self["_btnShare" .. index].gameObject, baseProgress <= progress)
		slider:SetValue(progress / baseProgress)

		local canGet = baseProgress <= progress and not hasGet

		goutil.setActive(goEffect, canGet)
		goutil.setActive(goylq, hasGet)

		local handler = self._effectHandles[goEffect]

		if handler then
			UIEffectManager.instance:stopEffect(handler)
		end

		proxy.binder:setAutoTips(not canGet)

		if canGet then
			local effName = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

			handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

			handler:setParent(goEffect.transform)
			handler:setLocalPos(0, 0, 0)
			handler:setScale(1.4)

			self._effectHandles[goEffect] = handler

			proxy.binder:setCallBack(function()
				ImageFragmentCollectionAgent.instance:sendPM_ImageFragmentCollectionReceiveImagePrizeReq(self._activityId, pcfg.imageId)
			end)
		else
			proxy.binder:setCallBack(nil)
		end
	end)
end

function ImagefragmentcollectionmainView:_updateMassItems()
	goutil.setActive(self._btnMassDot, not ImagefragmentcollectionModel.instance:isMassToday())

	self._txtMass.text = "心意值\n" .. ImagefragmentcollectionModel.instance:getMassNum()

	self:_setMassItem()
end

function ImagefragmentcollectionmainView:_setMassItem()
	local currScore = ImagefragmentcollectionModel.instance:getMassNum()
	local fill = 0
	local cfg = ImagefragmentcollectionConfig.instance:getCollectionCfg(self._activityId)
	local pcfgs = ImagefragmentcollectionConfig.instance:getMassPrizePlanCfgs(cfg.massPrizePlanId)
	local len = #pcfgs

	self._massCellSpace = len <= 0 and 1 or math.floor(self._rewardSliderSizeX / len)

	self._massItemGroup:updateWithMoArray(pcfgs, self._updateMassRewardCell, self)

	if pcfgs[len] then
		local step = 1 / len

		if currScore >= pcfgs[len].regardValue then
			fill = 1
		else
			local nextScore = 0
			local lastScore = 0

			for i, v in ipairs(pcfgs) do
				if currScore >= v.regardValue then
					fill = fill + step
					lastScore = v.regardValue
				else
					nextScore = v.regardValue

					break
				end
			end

			fill = fill + (currScore - lastScore) / (nextScore - lastScore) * step
		end
	end

	self:_setMassFill(fill)
end

function ImagefragmentcollectionmainView:_setMassFill(num)
	self._massSlider:SetValue(num)
end

function ImagefragmentcollectionmainView:_updateMassRewardCell(item, cfg)
	local goItem = goutil.findChild(item.mainGO, "item")
	local goYlq = goutil.findChild(item.mainGO, "ylq")
	local goEffect = goutil.findChild(item.mainGO, "effect")
	local txtCountTxt = goutil.findChildTextComponent(item.mainGO, "countTxt")
	local hasGet = ImagefragmentcollectionModel.instance:hasGetMassProgressPrize(cfg.id)
	local proxy = MaterialMgr.setCellByCfg(cfg.prize, goItem)
	local canGet = not hasGet and ImagefragmentcollectionModel.instance:getMassNum() >= cfg.regardValue

	txtCountTxt.text = cfg.regardValue

	goutil.setActive(goYlq, hasGet)

	local handler = self._effectHandles[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	proxy.binder:setAutoTips(not canGet)

	if canGet then
		local effName = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

		handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

		handler:setParent(goEffect.transform)
		handler:setLocalPos(0, 0, 0)
		handler:setScale(1)

		self._effectHandles[goEffect] = handler

		proxy.binder:setCallBack(function()
			ImageFragmentCollectionAgent.instance:sendPM_ImageFragmentCollectionReceiveMassPrizeReq(self._activityId, cfg.id)
		end)
	else
		proxy.binder:setCallBack(nil)
	end

	GameUtil.setAnchoredPos(item.mainGO, item.index * self._massCellSpace - 40, 0)
end

function ImagefragmentcollectionmainView:_updateFragmentItems()
	local cfg = ImagefragmentcollectionConfig.instance:getCollectionCfg(self._activityId)
	local pcfgs = ImagefragmentcollectionConfig.instance:getPrizePlanCfgs(cfg.prizePlanId)

	for i, pcfg in ipairs(pcfgs) do
		local itemTab = self._fragmentImgItems[i]

		if itemTab then
			local fcfgs = ImagefragmentcollectionConfig.instance:getFragmentPlanCfgs(pcfg.fragmentPlanId)
			local progress = ImagefragmentcollectionModel.instance:getCollectionProgress(pcfg.imageId)
			local isFinish = not self._playActiveEffect and progress >= #fcfgs

			goutil.setActive(itemTab.fullImgGo, isFinish)
			goutil.setActive(itemTab.itemcon, not isFinish)

			if isFinish then
				-- block empty
			else
				itemTab.itemGroup:updateWithMoArray(fcfgs, function(item, fcfg)
					local btn = Framework.ButtonAdapter.GetFrom(item.mainGO, "btnJump")
					local txtBtn = goutil.findChildTextComponent(item.mainGO, "btnJump/text")
					local activeBg = goutil.findChild(item.mainGO, "activeBg")
					local effectGo = goutil.findChild(item.mainGO, "effect")
					local activeBgChange = activeBg:GetComponent(ComponentType.UIImageSpriteChange)
					local openTime = GameUtil.string2time(fcfg.openTime)
					local nowTime = ServerTime.nowServerLook()
					local isOpen = openTime <= nowTime
					local isTaskFinish = ImagefragmentcollectionModel.instance:checkFragmentIsCollection(i, fcfg.fragmentId)

					goutil.setActive(activeBg, isTaskFinish)
					goutil.setActive(btn.gameObject, not isTaskFinish)
					self:_setFragmentBtnTxt(txtBtn, item.index, isOpen, openTime)

					if self._activeCache and self._activeCache[pcfg.imageId] and self._activeCache[pcfg.imageId].fragmentId == fcfg.fragmentId then
						if progress >= #fcfgs then
							self:_playAllFragmentActiveEffect(itemTab.activeAllEffectGo)
						else
							self:_playFragmentActiveEffect(effectGo, activeBg)
						end
					end

					activeBgChange:SetState(item.index - 1)
					btn:AddClickListener(function()
						if isTaskFinish then
							FloatWordMgr.instance:show("已获得线索")

							return
						end

						if fcfg.fragmentId > 1 and not ImagefragmentcollectionModel.instance:checkFragmentIsCollection(i, fcfg.fragmentId - 1) or pcfg.imageId == 2 and fcfg.fragmentId == 1 and not ImagefragmentcollectionModel.instance:checkFragmentIsCollection(1, 4) then
							FloatWordMgr.instance:show("需要先获得前置线索")

							return
						end

						if isOpen then
							if ImagefragmentcollectionModel.instance:getTodayActiveTimes() >= ImagefragmentcollectionConfig.instance:getDayliUnlockFragmentNum() then
								FloatWordMgr.instance:show("已达今日获取线索上限")

								return
							end

							GotoMgr.gotoByString(fcfg.jumpTo)
						else
							FloatWordMgr.instance:show("该线索未到解锁时间")
						end
					end)
				end)
			end
		end
	end
end

function ImagefragmentcollectionmainView:_setFragmentBtnTxt(txtBtn, index, isOpen, openTime)
	local content = ""

	if isOpen then
		content = "获取线索\n<size=30>" .. index .. "</size>"
	else
		local date = GameUtil.time2date(openTime)

		content = string.format("%s月%s日解锁线索%s", date.month, date.day, index)
	end

	txtBtn.text = content
end

function ImagefragmentcollectionmainView:_playFragmentActiveEffect(effectGo, activeBgGo)
	if self._playActiveEffect then
		self._playActiveEffect = false
		self._activeCache = false

		goutil.setActive(activeBgGo, false)

		local function finishBack()
			goutil.setActive(activeBgGo, true)
			goutil.setActive(self._maskGo, false)
			self:_updateFragmentItems()
		end

		local effName = "fx_ui_nvshenshidai/fx_ui_nvshenshidai_baodian.prefab"

		self._activeEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, finishBack)

		self._activeEffectHandler:setParent(effectGo.transform)
		self._activeEffectHandler:setLocalPos(0, 0, 0)
		self._activeEffectHandler:setScale(1)
		self._activeEffectHandler:setEffTime(0.3)
	end
end

function ImagefragmentcollectionmainView:_playAllFragmentActiveEffect(effectGo)
	if self._playActiveEffect then
		self._playActiveEffect = false
		self._activeCache = false

		local function finishBack()
			goutil.setActive(self._maskGo, false)
		end

		local effName = "fx_ui_nvshenshidai/fx_ui_nvshenshidai_jiesuo.prefab"

		self._activeEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, finishBack)

		self._activeEffectHandler:setParent(effectGo.transform)
		self._activeEffectHandler:setLocalPos(0, 0, 0)
		self._activeEffectHandler:setScale(1)
	end
end

function ImagefragmentcollectionmainView:_setActTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	local sdate = GameUtil.time2date(stime)
	local edate = GameUtil.time2date(etime)

	self._txtLeftTime.text = string.format("活动时间：%s - %s", self:_formatTime(sdate), self:_formatTime(edate))
end

function ImagefragmentcollectionmainView:_formatTime(date)
	return string.format("%s.%s", date.month, date.day)
end

function ImagefragmentcollectionmainView:_PM_ImageFragmentCollectionInfoRes(status)
	if status == 0 then
		self._playActiveEffect = self._activeCache

		self:_updateUI()
	end
end

function ImagefragmentcollectionmainView:_ReceiveImagePrizeRes(status)
	if status == 0 then
		self:_updateCollectAllItems()
	end
end

function ImagefragmentcollectionmainView:_CollectionMassRes(status)
	if status == 0 then
		self:_updateMassItems()
	end
end

function ImagefragmentcollectionmainView:_CollectionReceiveMassPrizeRes(status)
	if status == 0 then
		self:_updateMassItems()
	end
end

function ImagefragmentcollectionmainView:_playEffect()
	local effName = "fx_ui_nvshenshidai/fx_ui_nvshenshidai_jiemian.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return ImagefragmentcollectionmainView
