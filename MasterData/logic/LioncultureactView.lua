-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureactView.lua

module("logic.extensions.lionculture.view.LioncultureactView", package.seeall)

local LioncultureactView = class("LioncultureactView", ViewComponent)

function LioncultureactView:ctor()
	LioncultureactView.super.ctor(self)
end

function LioncultureactView:buildUI()
	LioncultureactView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._goldBarCon = self:getGo("goldBarCon")

	goutil.setActive(self._dragObj, false)

	self._rewardList = {}

	for i = 1, 3 do
		self._rewardList[i] = self:getGo("fragment/reward" .. i)
	end

	self._dragObj = self:getGo("dragObj")
	self._fragmentcell = self:getGo("fragment/fragmentcell")
	self._fragmentGo = self:getGo("fragment/tableview")
	self._fragmentScrollList = ScrollerList.create(self._fragmentGo, self._fragmentcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._fragmentTableview = self._fragmentScrollList:getView()

	local dialogCellList = {}

	for i = 1, 3 do
		dialogCellList[i] = self:getGo("dialog/storyCell_" .. i)
	end

	self._dialogGo = self:getGo("dialog/tableview")
	self._dialogScrollRect = self._dialogGo:GetComponent(ComponentType.ScrollRect)
	self._dialogScrollList = ScrollerList.create(self._dialogGo, dialogCellList, GameUtil.handler(self._updateDialogCell, self), GameUtil.handler(self._clearDialogCell, self))

	self._dialogScrollList:regGetTagByIdx(GameUtil.handler(self._getTagByData, self))

	self._txtTitle = self:getTxt("leftTop/txtTitle")
end

function LioncultureactView:bindEvents()
	LioncultureactView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule6")
	end, self)
end

function LioncultureactView:unbindEvents()
	LioncultureactView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function LioncultureactView:onEnter()
	LioncultureactView.super.onEnter(self)
	BrotherHoodController.instance:registerLocalNotify(BrotherHoodController.BeginDrag, self._onBeginDrag, self)
	BrotherHoodController.instance:registerLocalNotify(BrotherHoodController.Drag, self._onDrag, self)
	BrotherHoodController.instance:registerLocalNotify(BrotherHoodController.Drop, self._onDrop, self)
	BrotherHoodController.instance:registerLocalNotify(BrotherHoodController.EndDrag, self._onEndDrag, self)
	GlobalDispatcher:addListener(GlobalNotify.BrotherHoodSinglePlotPlanRes, self._onSinglePlotPlanRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BrotherHoodSplicePlotRes, self._onSplicePlotRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStoryPlayFinished, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._plotPlanId = params[2]
	self._cfgActivity = BrotherHoodConfig.instance:getActivityCfg(self._activityId)
	self._cfgPlot = BrotherHoodConfig.instance:getPlotCfgById(self._plotPlanId)
	self._fragmentCfgs = BrotherHoodConfig.instance:getFragmentCfgs(self._plotPlanId)

	goutil.setActive(self._dragObj, false)

	self._txtTitle.text = self._cfgPlot.titleName

	self:_initRewards()

	self._dialogScrollRect.verticalNormalizedPosition = 1

	BrotherHoodAgent.instance:sendPM_BrotherHoodSinglePlotPlanReq(self._activityId, self._plotPlanId)

	self.typeConfig = LioncultureConfig.instance:getGameData(LioncultureModel.instance.activityId, 5)

	if not GameUtil.getUserData(ViewName.LioncultureactView) then
		UIStateManager.instance:push(ViewName.LionculturetipView, self.typeConfig.desc)
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule6")
		GameUtil.saveUserData(ViewName.LioncultureactView, true)
	end
end

function LioncultureactView:onExit()
	LioncultureactView.super.onExit(self)
	BrotherHoodController.instance:unregisterLocalNotify(BrotherHoodController.BeginDrag, self._onBeginDrag, self)
	BrotherHoodController.instance:unregisterLocalNotify(BrotherHoodController.Drag, self._onDrag, self)
	BrotherHoodController.instance:unregisterLocalNotify(BrotherHoodController.Drop, self._onDrop, self)
	BrotherHoodController.instance:unregisterLocalNotify(BrotherHoodController.EndDrag, self._onEndDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.BrotherHoodSinglePlotPlanRes, self._onSinglePlotPlanRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BrotherHoodSplicePlotRes, self._onSplicePlotRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStoryPlayFinished, self)
	goutil.setActive(self._dragObj, false)
	self._fragmentScrollList:dispose()
end

function LioncultureactView:_onSinglePlotPlanRes()
	self:_updateFragments()
	self:_updateDialogs()
end

function LioncultureactView:_onSplicePlotRes()
	self:_updateFragments()
	self:_updateDialogs()

	if BrotherHoodModel.instance:isFinishPlotPlan(self._plotPlanId) and self._cfgPlot.story > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._cfgPlot.story)
	elseif BrotherHoodModel.instance:isFinishPlotPlan(self._plotPlanId) then
		FloatWordMgr.instance:show("醒狮文化-演，关卡已完成")
	end
end

function LioncultureactView:_onStoryPlayFinished(storyId)
	if self._cfgPlot.story == storyId then
		MaterialController.instance:showChangeSetInTemp(BrotherHoodModel.instance:getSplicePlotChangeSetId())
	end
end

function LioncultureactView:_setGoldBarCon()
	local energyMat = self._cfgActivity.energy
	local energyList = {}

	if not string.nilorempty(energyMat) then
		local energyMatArr = string.splitToNumber(energyMat, ":")
		local energyId = energyMatArr[2]
		local energyCfg = EnergyConfig.instance:getEnergyCfg(energyId)
		local isNeedShowAdd = not string.nilorempty(energyCfg.source)

		local function callBack()
			EnergyController.instance:openBuyView(energyId)
		end

		energyList = {
			id = energyMat,
			showAdd = isNeedShowAdd,
			showAddCallBack = callBack
		}

		local list = {}

		table.insert(list, energyList)
		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end
end

function LioncultureactView:_initRewards()
	local list = MaterialMgr.changeItemStrArr(self._cfgPlot.reward)

	for i = 1, 3 do
		if list[i] then
			MaterialMgr.setCellByCfg(list[i], self._rewardList[i])
		end
	end
end

function LioncultureactView:_updateFragments()
	local list = {}

	for i, v in ipairs(self._fragmentCfgs) do
		local isUnlock = BrotherHoodModel.instance:isUnlock(self._plotPlanId, v.fragmentsId)

		if not isUnlock then
			table.insert(list, v)
		end
	end

	self._fragmentScrollList:reloadData(list)
end

function LioncultureactView:_updateDialogs()
	local cfgs = BrotherHoodConfig.instance:getPlotList(self._plotPlanId)

	self._dialogScrollList:reloadData(cfgs)
end

function LioncultureactView:_updateCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, BHFragmentCell)

	cls:init(data)
end

function LioncultureactView:_clearCell(cell)
	local cls = GameUtil.GetLua(cell.gameObject, BHFragmentCell)

	if cls then
		cls:reset()
	end
end

function LioncultureactView:_getTagByData(data, idx)
	return data.plotType
end

function LioncultureactView:_updateDialogCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, BHDialogCell)

	cls:init(data)
end

function LioncultureactView:_clearDialogCell(cell)
	local cls = GameUtil.GetLua(cell.gameObject, BHDialogCell)

	if cls then
		cls:reset()
	end
end

function LioncultureactView:_onBeginDrag(go, eventData, cfgFragment)
	local drag = math.abs(eventData.delta.y) > math.abs(eventData.delta.x) and self._fragmentTableview:GetScrollRect().horizontal or math.abs(eventData.delta.y) < math.abs(eventData.delta.x) and self._fragmentTableview:GetScrollRect().vertical

	self._dragFragmentId = 0

	if drag and not self._dragging then
		self._dragging = true
		self._dragFragmentId = cfgFragment.fragmentsId

		goutil.setActive(self._dragObj, true)

		if cfgFragment then
			uGuiUtil.setSpriteToImage(self._dragObj, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfgFragment.resource))
		end
	else
		self._dragging = false

		self._fragmentTableview:GetScrollRect():OnBeginDrag(eventData)
		self._fragmentTableview:OnBeginDrag(eventData)
	end
end

function LioncultureactView:_onDrag(go, eventData, cfgFragment)
	if self._dragging then
		self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
	else
		self._fragmentTableview:OnDrag(data)
		self._fragmentTableview:GetScrollRect():OnDrag(eventData)
	end
end

function LioncultureactView:_onDrop(go, eventData, cfgPlot)
	if self._dragging then
		if cfgPlot.fragmentsId > 0 then
			if self._dragFragmentId == cfgPlot.fragmentsId then
				if not BrotherHoodModel.instance:isUnlock(cfgPlot.plotPlan, cfgPlot.fragmentsId) then
					local physicalCost = BrotherHoodConfig.instance:getPowerCostById(self._cfgActivity.physicalCostPlanId)

					if MaterialMgr.getMatEnough(physicalCost) then
						BrotherHoodAgent.instance:sendPM_BrotherHoodSplicePlotReq(self._activityId, self._plotPlanId, cfgPlot.groupId, cfgPlot.fragmentsId)
					else
						local matType, matId, matNum = MaterialMgr.getMatParams(physicalCost)

						EnergyController.instance:openBuyView(matId, "体力不足")
					end
				else
					FloatWordMgr.instance:show("对话已解锁")
				end
			else
				FloatWordMgr.instance:show("放置位置不对哦~")
			end
		else
			FloatWordMgr.instance:show("放置位置不对哦~")
		end
	end
end

function LioncultureactView:_onEndDrag(go, eventData, cfgFragment)
	if self._dragging then
		self._dragging = false

		goutil.setActive(self._dragObj, false)
		uGuiUtil.clearImage(self._dragObj)
	else
		self._fragmentTableview:GetScrollRect():OnEndDrag(eventData)
		self._fragmentTableview:OnEndDrag(eventData)
	end

	self._dragFragmentId = 0
end

return LioncultureactView
