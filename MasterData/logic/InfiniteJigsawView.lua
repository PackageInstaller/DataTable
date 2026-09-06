-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/view/InfiniteJigsawView.lua

module("logic.extensions.infinitejigsaw.view.InfiniteJigsawView", package.seeall)

local InfiniteJigsawView = class("InfiniteJigsawView", ViewComponent)

function InfiniteJigsawView:ctor()
	InfiniteJigsawView.super.ctor(self)
end

function InfiniteJigsawView:buildUI()
	InfiniteJigsawView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGift = self:getBtn("btnGift")
	self._btnTask = self:getBtn("btnTask")
	self._btnAll = self:getBtn("puzzle/btns/btn_All")
	self._btnTip = self:getBtn("btnTip")
	self._taskRedPoint = self:getGo("btnTask/redPoint")
	self._bg = self:getGo("bg")
	self._roleGo = self:getGo("role")
	self._txtTime = self:getTxt("time/txtTime")
	self._goldBar = self:getGo("goldBarCon")
	self._txtCost = self:getTxt("puzzle/tip/txtCost")
	self._coinImg = self:getGo("puzzle/tip/img")
	self._puzzleRectTrans = self:getGo("puzzle"):GetComponent(goutil.Type_RectTransform)
	self._btnPages = {}
	self._changeGroups = {}
	self._redPoints = {}

	for i = 1, 4 do
		self._btnPages[i] = self:getBtn("puzzle/btns/btn_" .. i)
		self._changeGroups[i] = self:getGo("puzzle/btns/btn_" .. i):GetComponent(typeof(UIChangeGroup))
		self._redPoints[i] = self:getGo(string.format("puzzle/btns/btn_%d/redPoint", i))
	end

	self._hvRewards = {}
	self._getedGoList = {}

	for i = 1, 8 do
		self._hvRewards[i] = self:getGo(string.format("puzzle/reward%d/node", i))
		self._getedGoList[i] = self:getGo(string.format("puzzle/reward%d/geted", i))
	end

	self._bigItem = self:getGo("puzzle/bigReward/item")
	self._bigItemGeted = self:getGo("puzzle/bigReward/geted")
	self._mainIcon = self:getGo("puzzle/picture")
	self._emptyTip = self:getGo("puzzle/emptyTip")
	self._pieceGo = self:getGo("puzzle/piece")
	self._lockGo = self:getGo("puzzle/lock")
	self._txtLock = self:getTxt("puzzle/lock/txt")

	goutil.setActive(self._pieceGo, false)

	self._pieceLists = {}

	for i = 1, 15 do
		local go = goutil.cloneAndSetParent(self._pieceGo, self._mainIcon.transform, "piece" .. i)

		goutil.setActive(go, true)

		local element = {}

		element.go = go
		element.btn = Framework.ButtonAdapter.Get(go)
		element.lock = goutil.findChild(go, "lock")
		element.kuang = goutil.findChild(go, "kuang")

		table.insert(self._pieceLists, element)
	end
end

function InfiniteJigsawView:bindEvents()
	InfiniteJigsawView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnGift:AddClickListener(self._onClickGift, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnAll:AddClickListener(self._onClickAll, self)
	self._btnTip:AddClickListener(self._onClickTip, self)

	for i, v in ipairs(self._btnPages) do
		v:AddClickListener(function()
			self:_onClickBtnPage(i)
		end)
	end

	for i, v in ipairs(self._pieceLists) do
		v.btn:AddClickListener(function()
			self:_onClickPiece(i)
		end)
	end
end

function InfiniteJigsawView:unbindEvents()
	InfiniteJigsawView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGift:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnAll:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i, v in ipairs(self._btnPages) do
		v:RemoveClickListener()
	end

	for i, v in ipairs(self._pieceLists) do
		v.btn:RemoveClickListener()
	end
end

function InfiniteJigsawView:onEnter()
	InfiniteJigsawView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.JEGetPictureInfoRes, self._onGetPictureInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.JEActivateJigsawRes, self._onActivateJigsawRes, self)
	GlobalDispatcher:addListener(GlobalNotify.JEGainGroupPrizeRes, self._onGainGroupPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.JEGainBigPrizeRes, self._onGainBigPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.JEFailedActivePiece, self._onFailedActivePiece, self)
	GlobalDispatcher:addListener(GlobalNotify.JEGetTaskInfoRes, self._onGetTaskInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.JEGainTaskPrizeRes, self._onGainTaskPrizeRes, self)
	InfiniteJigsawController.instance:markDailyRedPoint()

	self._isCanClick = false
	self._activityId = InfiniteJigsawModel.instance:getActivityId()
	self._cfgActivity = InfiniteJigsawConfig.instance:getActivityCfg(self._activityId)

	if not self._cfgActivity then
		return
	end

	self:_initGameObject()
	self:_playIdleEffect()
	self:_showRoleModel()
	self:_setGoldBar()
	self:_setCostItem()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GratefulPuzzle, self._activityId)

	if not isInTime then
		self:_showCloseTip()

		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GratefulPuzzle, self._activityId)

	self._startTimestamp = startTime
	self._endTimestamp = endTime

	self:_onSecond()
	settimer(1, self._onSecond, self)

	self._curPageIndex = nil

	JigsawExchangeAgent.instance:sendPM_JEGetPictureInfoReq(self._activityId)
	JigsawExchangeAgent.instance:sendPM_JEGetTaskInfoReq(self._activityId)
end

function InfiniteJigsawView:_initGameObject()
	goutil.setActive(self._mainIcon, false)
	goutil.setActive(self._lockGo, false)
	goutil.setActive(self._emptyTip, false)

	for i, v in ipairs(self._getedGoList) do
		goutil.setActive(v, false)
	end

	for i, v in ipairs(self._redPoints) do
		goutil.setActive(v, false)
	end

	goutil.setActive(self._taskRedPoint, false)
end

function InfiniteJigsawView:onExit()
	InfiniteJigsawView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.JEGetPictureInfoRes, self._onGetPictureInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.JEActivateJigsawRes, self._onActivateJigsawRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.JEGainGroupPrizeRes, self._onGainGroupPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.JEGainBigPrizeRes, self._onGainBigPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.JEFailedGainPrize, self._onFailedActivePiece, self)
	GlobalDispatcher:removeListener(GlobalNotify.JEGetTaskInfoRes, self._onGetTaskInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.JEGainTaskPrizeRes, self._onGainTaskPrizeRes, self)
	removetimer(self._onSecond, self)
	self:_resetRoleModel()
	self:_clearRewards()
	self:_clearEffects()
	self:_clearIcons()
	self:_resetPuzzles()
	self:_removeIdleEffect()
end

function InfiniteJigsawView:_onClickClose()
	self:close()
end

function InfiniteJigsawView:_onClickGift()
	if InfiniteJigsawModel.instance:isUnlockAllPicture() then
		JigsawExchangeAgent.instance:sendPM_JEGiveGiftReq(self._activityId)
	else
		FloatWordMgr.instance:show("解锁所有所有的格子漫画，才能赠礼")
	end
end

function InfiniteJigsawView:_onClickTask()
	UIStateManager.instance:push(ViewName.InfiniteJigsawTaskView)
end

function InfiniteJigsawView:_onClickAll()
	if InfiniteJigsawModel.instance:isUnlockAllPicture() then
		UIStateManager.instance:push(ViewName.InfiniteJigsawComicsView)
	else
		FloatWordMgr.instance:show("解锁全部漫画后即可查看哦")
	end
end

function InfiniteJigsawView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "lightuppuzzlerule")
end

function InfiniteJigsawView:_onClickBtnPage(index)
	if not self._isCanClick then
		return
	end

	index = Mathf.Clamp(index, 1, 4)

	if self._curPageIndex == index then
		return
	end

	for i, v in ipairs(self._changeGroups) do
		v:SetState(i == index and 1 or 0)
	end

	self._curPageIndex = index

	self:_updatePageInfo(index)
end

function InfiniteJigsawView:_onClickPiece(index)
	if not self._isCanClick then
		return
	end

	local realPictureId = InfiniteJigsawModel.instance:getPictureId()

	if realPictureId > self._curPageIndex then
		return
	elseif realPictureId < self._curPageIndex then
		FloatWordMgr.instance:show(string.format("请先点亮第%d格拼图", realPictureId))

		return
	else
		local jigsawId = index
		local isActive = InfiniteJigsawModel.instance:isActiveJigsawId(jigsawId, realPictureId)

		if isActive then
			FloatWordMgr.instance:show("已点亮")
		elseif self:_isItemEnoughForClickPiece() then
			JigsawExchangeAgent.instance:sendPM_JEActivateJigsawReq(self._activityId, realPictureId, jigsawId)
		else
			FloatWordMgr.instance:show("道具不足")
		end
	end
end

function InfiniteJigsawView:_onGetPictureInfoRes()
	self._isCanClick = true

	self:_onClickBtnPage(InfiniteJigsawModel.instance:getPictureId())
	self:_updatePageRedPoints()
end

function InfiniteJigsawView:_onActivateJigsawRes(activityId, pictureId, jigsawId)
	if self._activityId == activityId and self._curPageIndex == pictureId then
		self:_updateOnePuzzle(pictureId, jigsawId)
		self:_updatePageRedPoints()
	end
end

function InfiniteJigsawView:_onGainGroupPrizeRes(activityId, pictureId, groupPrizeId)
	if self._activityId == activityId and self._curPageIndex == pictureId then
		self:_updateOneReward(groupPrizeId)
		self:_updatePageRedPoints()
	end
end

function InfiniteJigsawView:_onGainBigPrizeRes(activityId, pictureId)
	if self._activityId == activityId and self._curPageIndex == pictureId then
		self:_updateOneReward(-1)
		self:_updatePageRedPoints()
	end
end

function InfiniteJigsawView:_onFailedActivePiece(status)
	FloatWordMgr.instance:show("未到领取时间")
end

function InfiniteJigsawView:_onGetTaskInfoRes()
	self:_updateTaskRedPoints()
end

function InfiniteJigsawView:_onGainTaskPrizeRes()
	self:_updateTaskRedPoints()
end

function InfiniteJigsawView:_showRoleModel()
	local curFaceId = 10295
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._roleGo, scale, nil, true, x, y)
end

function InfiniteJigsawView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function InfiniteJigsawView:_showCloseTip()
	local title = lang("tip")
	local text = "未在活动时间"

	local function func()
		self:_onClickClose()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function InfiniteJigsawView:_onSecond()
	self:_updateCountdown()
end

function InfiniteJigsawView:_updateCountdown()
	if self._endTimestamp and self._endTimestamp > 0 then
		local leftTime = self._endTimestamp - ServerTime.now()

		leftTime = leftTime >= 0 and leftTime or 0
		self._txtTime.text = string.format("剩余：%s", GameUtil.FormatTimeSymbol(leftTime))
	end
end

function InfiniteJigsawView:_setGoldBar()
	local cfg = self._cfgActivity
	local name = cfg.scoreItemType
	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)
end

function InfiniteJigsawView:_setCostItem()
	local matType, id, matNum = MaterialMgr.getMatParams(self._cfgActivity.activateJigsawCost)

	self._txtCost.text = string.format("消耗%s", matNum)

	MaterialMgr.setIcon(self._coinImg, matType, id)
end

function InfiniteJigsawView:_isItemEnoughForClickPiece()
	local matType, id, matNum = MaterialMgr.getMatParams(self._cfgActivity.activateJigsawCost)

	return matNum <= MaterialModel.instance:getMaterialsNumber(matType, id)
end

function InfiniteJigsawView:_clearCostItem()
	MaterialMgr.clearIcon(self._coinImg)
end

function InfiniteJigsawView:_updatePageInfo(pictureId)
	local cfgPicture = InfiniteJigsawConfig.instance:getPictureCfg(self._cfgActivity.picturePlanId, pictureId)

	if not cfgPicture then
		return
	end

	local startDay = cfgPicture.relativeOpenDays + 1
	local duration = 100
	local availableStartTime = GameUtil.getTimestampOnStartAndEnd(self._startTimestamp, startDay, duration)
	local isStart = availableStartTime < ServerTime.now()

	self:_updateRewardInfo(pictureId)

	if isStart then
		goutil.setActive(self._mainIcon, true)
		goutil.setActive(self._lockGo, false)
		self:_updateMainIcon(pictureId)
		self:_updatePuzzles(pictureId)

		if pictureId <= InfiniteJigsawModel.instance:getPictureId() then
			goutil.setActive(self._emptyTip, InfiniteJigsawModel.instance:isPictureAllLock(pictureId))
		else
			goutil.setActive(self._emptyTip, false)
		end
	else
		goutil.setActive(self._mainIcon, false)
		goutil.setActive(self._lockGo, true)
		goutil.setActive(self._emptyTip, false)

		local dateTime = GameUtil.time2date(availableStartTime)

		self._txtLock.text = string.format("%d.%d 5:00后开启", dateTime.month, dateTime.day)
	end
end

function InfiniteJigsawView:_updateRewardInfo(pictureId)
	self:_clearRewards()
	self:_clearEffects()

	self._uiEffects = self._uiEffects or {}

	local cfgPicture = InfiniteJigsawConfig.instance:getPictureCfg(self._cfgActivity.picturePlanId, pictureId)

	if cfgPicture then
		local cfgGroups = InfiniteJigsawConfig.instance:getGroupPrizeList(cfgPicture.groupPrizePlanId)

		for i, v in ipairs(cfgGroups) do
			if self._hvRewards[i] then
				local matType, id, matNum = MaterialMgr.getMatParams(v.prize)
				local proxy = MaterialMgr.setCellByCfg(v.prize, self._hvRewards[i])
				local groupPrizeId = v.groupPrizeId
				local activityId = self._activityId

				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					if InfiniteJigsawModel.instance:isRewardCanGet(pictureId, groupPrizeId) then
						JigsawExchangeAgent.instance:sendPM_JEGainGroupPrizeReq(activityId, pictureId, groupPrizeId)
					elseif not goutil.isNil(self._hvRewards[i]) then
						CommonTipsMgr.instance:openMaterialTips(self._hvRewards[i], matType, id, 0)
					end
				end)

				if self._getedGoList[groupPrizeId] then
					goutil.setActive(self._getedGoList[groupPrizeId], false)
				end

				if InfiniteJigsawModel.instance:isRewardCanGet(pictureId, groupPrizeId) then
					local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
					local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._hvRewards[i].transform, 0, 0, true, false, nil, function(target, eff)
						if not goutil.isNil(self._puzzleRectTrans) then
							eff:setClipping(self._puzzleRectTrans)
						end
					end)

					uiEffect:setParent(self._hvRewards[i].transform)
					uiEffect:setLocalPos(0, 0, 0)
					uiEffect:setScale(1)

					self._uiEffects[groupPrizeId] = uiEffect
				elseif InfiniteJigsawModel.instance:isRewardGeted(pictureId, groupPrizeId) and self._getedGoList[groupPrizeId] then
					goutil.setActive(self._getedGoList[groupPrizeId], true)
				end
			end
		end

		local bigPrizeIndex = -1
		local activityId = self._activityId
		local proxy = MaterialMgr.setCellByCfg(cfgPicture.bigPrize, self._bigItem)
		local matType, id, matNum = MaterialMgr.getMatParams(cfgPicture.bigPrize)

		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			if InfiniteJigsawModel.instance:isRewardCanGet(pictureId, bigPrizeIndex) then
				JigsawExchangeAgent.instance:sendPM_JEGainBigPrizeReq(activityId, pictureId)
			elseif not goutil.isNil(self._bigItem) then
				CommonTipsMgr.instance:openMaterialTips(self._bigItem, matType, id, 0)
			end
		end)
		goutil.setActive(self._bigItemGeted, false)

		if InfiniteJigsawModel.instance:isRewardCanGet(pictureId, bigPrizeIndex) then
			local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
			local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._bigItem.transform, 0, 0, true, false, nil, function(target, eff)
				if not goutil.isNil(self._puzzleRectTrans) then
					eff:setClipping(self._puzzleRectTrans)
				end
			end)

			uiEffect:setParent(self._bigItem.transform.transform)
			uiEffect:setLocalPos(0, 0, 0)
			uiEffect:setScale(1)

			self._uiEffects[bigPrizeIndex] = uiEffect
		elseif InfiniteJigsawModel.instance:isRewardGeted(pictureId, bigPrizeIndex) then
			goutil.setActive(self._bigItemGeted, true)
		end
	end
end

function InfiniteJigsawView:_updateOneReward(groupPrizeId)
	if self._uiEffects[groupPrizeId] then
		UIEffectManager.instance:stopEffect(self._uiEffects[groupPrizeId])
	end

	if groupPrizeId ~= -1 then
		if self._getedGoList[groupPrizeId] then
			goutil.setActive(self._getedGoList[groupPrizeId], true)
		end
	else
		goutil.setActive(self._bigItemGeted, true)
	end
end

function InfiniteJigsawView:_clearRewards()
	for i, v in ipairs(self._hvRewards) do
		MaterialMgr.resetAll(v)
	end

	MaterialMgr.resetAll(self._bigItem)
end

function InfiniteJigsawView:_clearEffects()
	if self._uiEffects then
		for k, v in pairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._uiEffects)
	end
end

function InfiniteJigsawView:_updateMainIcon(pictureId)
	local cfgPicture = InfiniteJigsawConfig.instance:getPictureCfg(self._cfgActivity.picturePlanId, pictureId)

	if cfgPicture then
		uGuiUtil.setSpriteToImage(self._mainIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("picturepuzzle", cfgPicture.iconPath))
	end
end

function InfiniteJigsawView:_clearIcons()
	MaterialMgr.clearIcon(self._mainIcon)
end

function InfiniteJigsawView:_updatePuzzles(pictureId)
	local isAllUnlock = InfiniteJigsawModel.instance:isPictureAllUnlock(pictureId)

	for i, v in ipairs(self._pieceLists) do
		local isUnlock = InfiniteJigsawModel.instance:isActiveJigsawId(i, self._curPageIndex)

		goutil.setActive(v.lock, not isUnlock)
		goutil.setActive(v.kuang, not isAllUnlock)
	end
end

function InfiniteJigsawView:_resetPuzzles()
	if self._pieceLists then
		for i, v in ipairs(self._pieceLists) do
			goutil.setActive(v.lock, true)
			goutil.setActive(v.kuang, true)
		end
	end
end

function InfiniteJigsawView:_updateOnePuzzle(pictureId, jigsawId)
	local isAllUnlock = InfiniteJigsawModel.instance:isPictureAllUnlock(pictureId)
	local isAllLock = InfiniteJigsawModel.instance:isPictureAllLock(pictureId)

	goutil.setActive(self._emptyTip, isAllLock)

	for i, v in ipairs(self._pieceLists) do
		if i == jigsawId then
			goutil.setActive(v.lock, false)
			self:_updateRewardInfo(pictureId, jigsawId)
			self:_playBriefEffect(v.go.transform)

			if not isAllUnlock then
				break
			end
		end

		if isAllUnlock then
			goutil.setActive(v.kuang, false)
		end
	end
end

function InfiniteJigsawView:_updatePageRedPoints()
	for i, v in ipairs(self._redPoints) do
		local isExist = InfiniteJigsawModel.instance:isExistRewardCanGet(i)

		goutil.setActive(self._redPoints[i], isExist)
	end
end

function InfiniteJigsawView:_updateTaskRedPoints()
	goutil.setActive(self._taskRedPoint, InfiniteJigsawModel.instance:isExistTaskRewardCanGet())
end

function InfiniteJigsawView:_playIdleEffect()
	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._bg.transform, 0, 0, true, false)

	uiEffect:setParent(self._bg.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	uiEffect.hideEffWhileNotOnTop = false
	self._uiIdleEffect = uiEffect
end

function InfiniteJigsawView:_removeIdleEffect()
	if self._uiIdleEffect then
		UIEffectManager.instance:stopEffect(self._uiIdleEffect)

		self._uiIdleEffect = nil
	end
end

function InfiniteJigsawView:_playBriefEffect(attachTransform)
	local effPath = "20230331/chongzhurongguang/fx_ui_chongzhurongguang_duanzao.prefab"
	local uiEffect = UIEffectManager.instance:playEffectBrief(self, effPath, attachTransform)

	uiEffect:setParent(attachTransform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)
end

return InfiniteJigsawView
