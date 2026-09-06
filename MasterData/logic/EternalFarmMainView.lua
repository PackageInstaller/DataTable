-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmMainView.lua

module("logic.extensions.eternalfarm.view.EternalFarmMainView", package.seeall)

local EternalFarmMainView = class("EternalFarmMainView", ViewComponent)

function EternalFarmMainView:ctor()
	EternalFarmMainView.super.ctor(self)
end

function EternalFarmMainView:unbindEvents()
	EternalFarmMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGetItem)
	GameUtil.rmClickHandler(self._btnMatDetail)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function EternalFarmMainView:bindEvents()
	EternalFarmMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGetItem, self._onClickBtnGetItem, self)
	GameUtil.addClickHandler(self._btnMatDetail, self._onClickBtnMatDetail, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function EternalFarmMainView:buildUI()
	EternalFarmMainView.super.buildUI(self)

	self._btnGetItem = self:getGo("btnGetItem")
	self._btnMatDetail = self:getGo("btnMatDetail")
	self._rewards = self:getGo("rewards")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._rewardcells = {}

	for i = 1, self._rewards.transform.childCount do
		local curCell = {}
		local cell = goutil.findChild(self._rewards, "rewardCell" .. i)

		curCell.item = goutil.findChild(cell, "bubble/item")
		curCell.effRoot = goutil.findChild(cell, "bubble/root")
		curCell.btnGet = goutil.findChild(cell, "bubble/btnGet")
		curCell.txtProgress = goutil.findChildTextComponent(cell, "bg1/progress/txtProgress")
		curCell.imgHasGain = goutil.findChild(cell, "bubble/imgHasGain")
		curCell.clipRect = goutil.findChild(cell, "bubble/item").gameObject:GetComponent(goutil.Type_RectTransform)

		table.insert(self._rewardcells, curCell)
	end
end

function EternalFarmMainView:onExit()
	EternalFarmMainView.super.onExit(self)
	self:_clearCells()
end

function EternalFarmMainView:onEnter()
	EternalFarmMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EternalFarmGainPrizeRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.EternalFarmGetInfoRes, self._updateCells, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EternalFarm)
	self._itemIds = EternalFarmConfig.instance:getItemIds(self._activityId)
	self._collectPrizeCfg = EternalFarmConfig.instance:getCollectPrizeCfg(self._activityId)
	self._effList = {}

	self:_onSetUI()
	EternalFarmController.instance:sendPM_EternalFarmInfoReq(self._activityId)
end

function EternalFarmMainView:_onSetUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.EternalFarm, self._activityId)

	self._txtOpenTime.text = string.format("%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
end

function EternalFarmMainView:_updateCells()
	for idx, cell in ipairs(self._rewardcells) do
		local itemId = self._itemIds[idx]
		local nextPrizeId = EternalFarmController.instance:nextPrizeIds(self._activityId, itemId)

		if self._collectPrizeCfg[itemId] then
			local data = self._collectPrizeCfg[itemId][nextPrizeId]
			local matType = 10
			local matId = data.itemId

			if not data.prize then
				local prizeStr = "8:1:1"
				local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

				if not data.number then
					local needNum = 0
					local hasFinishAllReward = EternalFarmController.instance:isFinishAllReward(self._activityId, itemId)
					local canGetPrize = needNum <= hasNum

					cell.txtProgress.text = hasNum .. "/" .. needNum

					GameUtil.SetActive(cell.btnGet, not hasFinishAllReward and canGetPrize)
					GameUtil.SetActive(cell.imgHasGain, hasFinishAllReward)
					MaterialMgr.setCellByCfg(prizeStr, cell.item)

					if self._effList and self._effList[cell.effRoot] then
						UIEffectManager.instance:stopEffect(self._effList[cell.effRoot])

						self._effList[cell.effRoot] = nil
					end

					if canGetPrize and not hasFinishAllReward then
						local function loadHandler(target, eff)
							eff.effGo.transform:SetParent(cell.effRoot.transform)
							GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
							GameUtil.setLocalScale(eff.effGo.transform, 0.5, 0.5, 0.7)
							GameUtil.setLocalRotation(eff.effGo.transform, 0, 0, 0)
							eff:setClipping(self.mainGO:GetComponent(goutil.Type_RectTransform))
						end

						self._effList[cell.effRoot] = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.effRoot.transform, 0, 0, true, false, nil, loadHandler)
					end

					GameUtil.addClickHandler(cell.btnGet, function()
						if not canGetPrize then
							FloatWordMgr.instance:show("未满足条件，无法领取！")

							return
						end

						EternalFarmController.instance:sendPM_EternalFarmGainPrizeReq(self._activityId, itemId, nextPrizeId)
					end)
				end
			end
		end
	end
end

function EternalFarmMainView:_clearCells()
	if self._effList then
		for effGo, eff in pairs(self._effList) do
			UIEffectManager.instance:stopEffect(eff)

			self._effList[effGo] = nil
		end

		self._effList = nil
	end

	for idx, cell in ipairs(self._rewardcells) do
		GameUtil.rmClickHandler(cell.btnGet)
		MaterialMgr.resetAll(cell.item)
	end
end

function EternalFarmMainView:_onClickBtnGetItem()
	UIStateManager.instance:push(ViewName.EternalFarmView)
end

function EternalFarmMainView:_onClickBtnMatDetail()
	UIStateManager.instance:push(ViewName.EternalFarmTaskView)
end

function EternalFarmMainView:_sendGetInfoReq(msg)
	EternalFarmController.instance:sendPM_EternalFarmInfoReq(self._activityId)
end

function EternalFarmMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("eternalfram_rule")
end

return EternalFarmMainView
