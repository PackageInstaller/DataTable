-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchView.lua

module("logic.extensions.scratch.view.ScratchView", package.seeall)

local ScratchView = class("ScratchView", ViewComponent)
local effectPath

function ScratchView:ctor()
	ScratchView.super.ctor(self)
end

function ScratchView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnReset = self:getBtn("btnReset")
	self._txtScore = self:getTxt("score/TxtC_Num")
	self._btnExplain = self:getBtn("btnExplain")
	self._btnTask = self:getBtn("btnTask")
	self._bigRewardNode = self:getGo("bigReward/node")
	self._bigRewardGeted = self:getGo("bigReward/geted")
	self._txtLeftTime = self:getTxt("leftTime/txtLeftTime")
	self._mask = self:getGo("mask")
	self._redPoint = self:getGo("btnTask/redPoint")
	self._roleModel = self:getGo("roleModel")
	self._tableview = self:getGo("rewardList"):GetComponent("UITableview")
	self._tableCell = self:getGo("rewardList/item")

	self._tableCell:SetActive(false)

	self._door = self:getGo("door")
	self._doorAnim = self:getGo("door/anim")
	self._effectDoorGo = self:getGo("door/effect")
	self._effectRewardGo = self:getGo("bigReward/effect")
	self._btnDoor = self:getBtn("door/anim/btnDoor")
	self._bigReward = self:getGo("bigReward")
	self._btnRefresh = self:getBtn("bigReward/btnRefresh")
	self._txtRoundDesc = self:getTxt("bigReward/txtBg/txtRoundDesc")
	self._btnAdd = self:getBtn("score/btnAdd")
	self._itemIcon = self:getGo("score/itemIcon")
end

function ScratchView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnReset:AddClickListener(self._onBtnResetClick, self)
	self._btnExplain:AddClickListener(self._onBtnExplainClick, self)
	self._btnTask:AddClickListener(self._onBtnTaskClick, self)
	self._btnDoor:AddClickListener(self._onSelectRewardClick, self)
	self._btnRefresh:AddClickListener(self._onClickRefreshBigReward, self)
	self._btnAdd:AddClickListener(self._onBtnTaskClick, self)
end

function ScratchView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnDoor:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
end

function ScratchView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ScratchSelectPrize, self._onScratchSelectPrize, self)
	GlobalDispatcher:addListener(GlobalNotify.GetScratchUserInfo, self._onGetScratchUserInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.ScratchDig, self._onScratchDig, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self._onMaterialGet, self)
	GlobalDispatcher:addListener(GlobalNotify.ScratchReset, self._onScratchReset, self)
	GlobalDispatcher:addListener(GlobalNotify.ScratchExchange, self._onScratchExchange, self)
	GlobalDispatcher:addListener(GlobalNotify.ScratchSwitchReward, self._onSwitchBigReward, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	ScratchController.instance:closeFirstRedPoint()
	goutil.setActive(self._tableview.gameObject, false)
	goutil.setActive(self._btnReset.gameObject, false)
	goutil.setActive(self._mask, true)
	ScratchController.instance:sendGetScratchUserInfoReq()

	self._txtLeftTime.text = "剩余时间：00:00:00"

	self:_setRedPoint()
	self:_showRoleModel()
	goutil.setActive(self._door, true)

	self._spineAnimGo = self:getResInstance("effect/prefabs/ui/fx_ui_baozangmiche/spine/10001_baozhang/10001_baozhang-ui_p.prefab")

	goutil.addChildToParent(self._spineAnimGo, self._doorAnim)
	self:_loadItemIcon()
	self:_setDoorActive(false)
	self:_playDoorAnim(false)
end

function ScratchView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ScratchSelectPrize, self._onScratchSelectPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.GetScratchUserInfo, self._onGetScratchUserInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScratchDig, self._onScratchDig, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialGet, self._onMaterialGet, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScratchReset, self._onScratchReset, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScratchExchange, self._onScratchExchange, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScratchSwitchReward, self._onSwitchBigReward, self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
	self:_removeBigReward()
	removetimer(self._setLeftTime, self)
	self:_resetRoleModel()
	self:_removeEffectDoor()
	self:_removeEffectBigReward()
	self:_removeOpenDoorEffect()
	self:_killTween()
	goutil.destroy(self._spineAnimGo)
	self:_removeItemIcon()
end

function ScratchView:_onClickClose()
	self:close()
end

function ScratchView:_onSelectRewardClick()
	local activityId = ScratchModel.instance:getActivityId()

	UIStateManager.instance:open(ViewName.ScratchRewardView, activityId)
end

function ScratchView:_onBtnResetClick()
	if not ScratchModel.instance:isDigAll() then
		TipsFacade:openPopupWindow("重置宝藏", "未挖到的宝物将无法获得，是否要重置宝藏，开启下一轮挖宝？", function()
			ScratchController.instance:sendScratchResetReq()
		end, nil, "确定", "再想想", alignment)
	else
		ScratchController.instance:sendScratchResetReq()
	end
end

function ScratchView:_onBtnExplainClick()
	UIStateManager.instance:open(ViewName.RulesView, "scratchrule")
end

function ScratchView:_onBtnTaskClick()
	UIStateManager.instance:open(ViewName.ScratchTaskView)
end

function ScratchView:_onClickRefreshBigReward()
	if ScratchModel.instance:isPlaying() and not ScratchModel.instance:isDigFirstPrize() then
		local activityId = ScratchModel.instance:getActivityId()
		local isSelectAgain = true

		UIStateManager.instance:open(ViewName.ScratchRewardView, activityId, isSelectAgain)
	else
		FloatWordMgr.instance:show("大奖已经挖到了哦")
	end
end

function ScratchView:_numInView()
	return #self._curViewDatas
end

function ScratchView:_cellSize()
	return 80, 80
end

function ScratchView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function ScratchView:_updateCell(view, cell, data)
	local idx = cell.index + 1
	local component = GameUtil.AddLuaOnce(cell.gameObject, ScratchItem)

	component:init(idx, data, self)
end

function ScratchView:_clearTableview(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, ScratchItem)

	component:reset()
end

function ScratchView:_onScratchSelectPrize()
	self:_setDoorActive(true)
	self:_removeEffectDoor()
	goutil.setActive(self._btnDoor.gameObject, false)
	self:_playOpenDoorEffect()
	self:_playDoorAnim(true, function()
		printInfo("test 动画播放完毕")
		self:_setDoorActive(false)
		goutil.setActive(self._btnDoor.gameObject, true)
		ScratchController.instance:sendGetScratchUserInfoReq()
	end)
	self:_updateBtnRefreshActive()
end

function ScratchView:_onGetScratchUserInfo(msg, isSuccessRes)
	if not isSuccessRes then
		self:_popupCloseTip("不在活动时间内")
	end

	if ScratchModel.instance:isPlaying() then
		self._tableview.gameObject:SetActive(true)
		self:_updateGridList()
		self:_setBigReward()
		self:_loadEffectBigReward()
		self:_setDoorActive(false)
		self:_playDoorAnim(false)
	else
		self._tableview.gameObject:SetActive(false)
		self:_removeBigReward()
		self:_removeEffectBigReward()
		self:_setDoorActive(true)
		self:_playDoorAnim(false)
	end

	self:_updateScore()
	self:_setBtnReset()
	self:_setBigRewardGeted()

	local isHaveTime = self:_setLeftTime()

	if isHaveTime then
		goutil.setActive(self._mask, false)
		settimer(1, self._setLeftTime, self)
	end

	self:_setRedPoint()
	self:_updateBtnRefreshActive()
end

function ScratchView:_onScratchDig(msg)
	goutil.setActive(self._mask, true)
	self:_updateBtnRefreshActive()

	local x, y = ScratchModel.instance:getRecentDigGrid()
	local changeSetId = msg.changeSetId
	local index = ScratchController.instance:getIndexByPos(x, y)
	local digCell = self._tableview:GetCellAtIndex(index)
	local component = GameUtil.GetLua(digCell.gameObject, ScratchItem)

	if not component then
		printError("ScratchItem 不存在")

		return
	end

	component:loadDigEffect()

	local boomLists = ScratchModel.instance:getDigRangePosList()

	self._delayTweenBoom = TweenUtil.DoDelay(0.1, function()
		self._delayTweenBoom = nil

		component:loadBoomEffect1()
		self:_updateShow()
	end)
	self._delayTweenBoom2 = TweenUtil.DoDelay(0.1, function()
		self._delayTweenBoom2 = nil

		for i, v in ipairs(boomLists) do
			local index = ScratchController.instance:getIndexByPos(v.xAxis, v.yAxis)
			local boomCell = self._tableview:GetCellAtIndex(index)
			local component = GameUtil.GetLua(boomCell.gameObject, ScratchItem)

			component:loadBoomEffect2()
		end
	end)
	self._delayTweenShowReward = TweenUtil.DoDelay(0.6, function()
		self._delayTweenShowReward = nil

		for i, v in ipairs(boomLists) do
			local index = ScratchController.instance:getIndexByPos(v.xAxis, v.yAxis)
			local boomCell = self._tableview:GetCellAtIndex(index)
			local component = GameUtil.GetLua(boomCell.gameObject, ScratchItem)

			component:removeEffect()
		end

		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		goutil.setActive(self._mask, false)
	end)
end

function ScratchView:_updateShow()
	self:_updateGridList()
	self:_updateScore()
	self:_setBtnReset()
	self:_setBigRewardGeted()
end

function ScratchView:_onMaterialGet()
	self:_updateScore()
	self:_setRedPoint()
end

function ScratchView:_onScratchReset()
	self._tableview.gameObject:SetActive(false)
	self:_setDoorActive(true)
	self:_playDoorAnim(false)
	self:_removeEffectBigReward()
	self:_setBtnReset()
	ScratchController.instance:sendGetScratchUserInfoReq()
end

function ScratchView:_updateGridList()
	self._curViewDatas = ScratchModel.instance:getGridList()

	self._tableview:ReloadData()
end

function ScratchView:_updateScore()
	self._txtScore.text = tostring(ScratchController.instance:getCurExchangeItemNum())
end

function ScratchView:_setBtnReset()
	local isShow = ScratchModel.instance:isDigFirstPrize()

	goutil.setActive(self._btnReset.gameObject, isShow)
end

function ScratchView:_setBigReward()
	printInfo("test 设置大奖")
	MaterialMgr.resetAll(self._bigRewardNode)

	local bigRewardId = ScratchModel.instance:getBigPrizeId()

	if not bigRewardId or bigRewardId <= 0 then
		return
	end

	goutil.setActive(self._bigReward, true)

	local activityId = ScratchModel.instance:getActivityId()
	local cfg = ScratchConfig.instance:getScratchActivityCfgById(activityId)
	local planId = cfg.bigPlanId
	local prizeCfg = ScratchConfig.instance:getScratchPrizeCfg(planId, bigRewardId, true)

	if prizeCfg then
		MaterialMgr.setCellByCfg(prizeCfg.prize, self._bigRewardNode)
	end

	self._txtRoundDesc.text = string.format("第%d轮 一等奖", ScratchModel.instance:getCurRound())
end

function ScratchView:_removeBigReward()
	goutil.setActive(self._bigReward, false)
	MaterialMgr.resetAll(self._bigRewardNode)
end

function ScratchView:_setBigRewardGeted()
	local isShow = ScratchModel.instance:isDigFirstPrize()

	self._bigRewardGeted:SetActive(isShow)
end

function ScratchView:_setLeftTime()
	local activityId = ScratchModel.instance:getActivityId()
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Nor2, activityId)

	if not isInTime then
		local txtTime = "未在活动时间"

		removetimer(self._setLeftTime, self)
		self:_popupCloseTip(txtTime)

		self._txtLeftTime.text = string.format("剩余时间：%s", txtTime)

		return false
	end

	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Nor2, activityId)

	if cfg then
		local nowTime = ServerTime.now()
		local timeStart = GameUtil.string2time(cfg.startTime)
		local timeEnd = GameUtil.string2time(cfg.endTime)
		local txtTime = ""
		local isHaveTime = false

		if timeStart <= nowTime and nowTime <= timeEnd then
			txtTime = GameUtil.FormatTimeSymbol(timeEnd - nowTime)
			isHaveTime = true
		elseif nowTime < timeStart then
			txtTime = "活动未开始"

			removetimer(self._setLeftTime, self)
			self:_popupCloseTip(txtTime)
		elseif timeEnd < nowTime then
			txtTime = "活动已结束"

			removetimer(self._setLeftTime, self)
			self:_popupCloseTip(txtTime)
		end

		self._txtLeftTime.text = string.format("剩余时间：%s", txtTime)

		return isHaveTime
	end

	return false
end

function ScratchView:_popupCloseTip(txt)
	TipsFacade.instance:openTipWindowNoX("提示", txt, function()
		UIStateManager.instance:clear()
	end, "确定")
end

function ScratchView:_setRedPoint()
	goutil.setActive(self._redPoint, ScratchModel.instance:isCanExchange())
end

function ScratchView:_showRoleModel()
	self:_resetRoleModel()

	local skinId = 10183
	local scale = 1

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._roleModel, scale, nil, nil)
end

function ScratchView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function ScratchView:_onScratchExchange()
	self:_setRedPoint()
end

function ScratchView:_onSwitchBigReward()
	FloatWordMgr.instance:show("成功重置大奖")
	self:_setBigReward()
end

function ScratchView:_loadEffectDoor()
	if not self._effectDoor then
		self._effectDoor = UIEffectManager.instance:playEffect(self, "fx_ui_baozangmiche/fx_ui_baozangmicheng_men.prefab", self._effectDoorGo.transform, 0, 0, true, false)

		self._effectDoor:setParent(self._effectDoorGo.transform)
		self._effectDoor:setScale(1)
	end
end

function ScratchView:_removeEffectDoor()
	if self._effectDoor then
		UIEffectManager.instance:stopEffect(self._effectDoor)

		self._effectDoor = nil
	end
end

function ScratchView:_loadEffectBigReward()
	if not self._effectBigReward then
		self._effectBigReward = UIEffectManager.instance:playEffect(self, "fx_ui_baozangmiche/fx_ui_yidengjiang.prefab", self._effectRewardGo.transform, 0, 0, true, false)

		self._effectBigReward:setParent(self._effectRewardGo.transform)
		self._effectBigReward:setScale(1)
	end
end

function ScratchView:_removeEffectBigReward()
	if self._effectBigReward then
		UIEffectManager.instance:stopEffect(self._effectBigReward)

		self._effectBigReward = nil
	end
end

function ScratchView:_setDoorActive(isOpen, callBack)
	goutil.setActive(self._doorAnim, isOpen)

	if isOpen then
		self:_loadEffectDoor()
	else
		self:_removeEffectDoor()
	end
end

function ScratchView:_playDoorAnim(isOpen, callBack)
	local go = self._spineAnimGo
	local animName = isOpen and "open" or "idle"
	local loop = false
	local graphic = go:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if graphic then
		local sk = graphic.skeletonDataAsset
		local data = sk:GetAnimationStateData()
		local skd = data.SkeletonData
		local ani = skd:FindAnimation(animName)

		if ani ~= nil then
			graphic.startingAnimation = animName

			graphic.AnimationState:SetAnimation(0, animName, loop)
			graphic:Update(0)

			local onComplete

			function onComplete()
				GameUtil.callBack(callBack)

				graphic.AnimationState.Complete = graphic.AnimationState.Complete - onComplete
			end

			graphic.AnimationState.Complete = graphic.AnimationState.Complete + onComplete
		end
	end
end

function ScratchView:_playOpenDoorEffect()
	self:_removeOpenDoorEffect()

	local effect = UIEffectManager.instance:playEffect(self, "fx_ui_baozangmiche/spine/fx_baozangmicheng_01_tx.prefab", self._door.transform, -277, 34, true, false)

	effect:setParent(self._door.transform)
	effect:setScale(1)
	table.insert(self._effectList, effect)

	self._doorDelayTween = TweenUtil.DoDelay(0.8, function()
		local effect2 = UIEffectManager.instance:playEffect(self, "fx_ui_baozangmiche/spine/fx_baozangmicheng_02.prefab", self._door.transform, -277, 34, true, false)

		effect2:setParent(self._door.transform)
		effect2:setScale(1)
		table.insert(self._effectList, effect2)

		self._doorDelayTween = nil
	end)
	self._removeOpenDoorTween = TweenUtil.DoDelay(3, function()
		self:_removeOpenDoorEffect()

		self._removeOpenDoorTween = nil
	end)
end

function ScratchView:_removeOpenDoorEffect()
	if self._effectList then
		for i, v in ipairs(self._effectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._effectList = {}
	else
		self._effectList = {}
	end
end

function ScratchView:_killTween()
	if self._delayTweenBoom then
		self._delayTweenBoom:Kill()
	end

	if self._delayTweenBoom2 then
		self._delayTweenBoom2:Kill()
	end

	if self._delayTweenShowReward then
		self._delayTweenShowReward:Kill()
	end

	if self._doorDelayTween then
		self._doorDelayTween:Kill()

		self._doorDelayTween = nil
	end

	if self._removeOpenDoorTween then
		self._removeOpenDoorTween:Kill()

		self._removeOpenDoorTween = nil
	end
end

function ScratchView:_updateBtnRefreshActive()
	local isShow = ScratchModel.instance:isPlaying() and not ScratchModel.instance:isDigFirstPrize()

	self._btnRefresh.gameObject:SetActive(isShow)
end

function ScratchView:_loadItemIcon()
	uGuiUtil.setSpriteToImage(self._itemIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_shizigao"))
end

function ScratchView:_removeItemIcon()
	if self._itemIcon then
		local img = Framework.ImageBigBG.Get(self._itemIcon)

		img:ClearImage()
	end
end

return ScratchView
