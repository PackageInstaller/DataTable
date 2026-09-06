-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarDispatchPartView.lua

module("logic.extensions.ultimatewar.view.UltimateWarDispatchPartView", package.seeall)

local UltimateWarDispatchPartView = class("UltimateWarDispatchPartView", ViewComponent)

function UltimateWarDispatchPartView:buildUI()
	UltimateWarDispatchPartView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnGetAll = self:getGo("btnGetAll")
	self._redBtnGetAll = self:getGo("btnGetAll/redPoint")
	self._btnSet = self:getGo("btnSet")
	self._redBtnSet = self:getGo("btnSet/redPoint")
	self._pointView = self:getGo("pointCol/pointView")
	self._pointCell = self:getGo("pointCol/pointCell")
	self._energys = {}

	GameUtil.SetActive(self._pointCell, false)
end

function UltimateWarDispatchPartView:bindEvents()
	UltimateWarDispatchPartView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnGetAll, self._onClickBtnGetAll, self)
	GameUtil.addClickHandler(self._btnSet, self._onClickBtnSet, self)
end

function UltimateWarDispatchPartView:unbindEvents()
	UltimateWarDispatchPartView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGetAll)
	GameUtil.rmClickHandler(self._btnSet)
end

function UltimateWarDispatchPartView:onEnter()
	UltimateWarDispatchPartView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._actData = UltimateWarConfig.instance:getActData(self._activityId)
	self._score2Item = UltimateWarConfig.instance:getScore2Item(self._activityId)

	local matStr = UltimateWarConfig.instance:getGoldMat(self._activityId)

	self._matName = MaterialMgr.getMaterialsNameByCfg(matStr)
	self._isCanGetAll = false

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarFirstStepInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGainHangingPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarDispatchRes, self._onUpdate, self)
	UltimateWarController.instance:sendPM_UltimateWarFirstStepInfoReq(self._activityId)
	settimer(0.5, self._onTicking, self, true)
	self:_onTicking()
end

function UltimateWarDispatchPartView:onExit()
	UltimateWarDispatchPartView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnSet)
	removetimer(self._onTicking, self)
	table.clear(self._energys)
	self:_onClear()
end

function UltimateWarDispatchPartView:_onTicking()
	local nowMs = ServerTime.nowMs()

	self._isCanGetAll = false

	for txtEnergy, pointInfo in pairs(self._energys) do
		local max = pointInfo:getCurMaxLimtItem()
		local cur = pointInfo:getLeftItemCount()
		local lastRefreshTime = pointInfo:getLastRefreshTime()

		if pointInfo:getCurDispatchCount() > 0 and lastRefreshTime > 0 then
			local leftSec = Mathf.Max(nowMs - lastRefreshTime, 0) / 1000
			local xiaoLv = pointInfo:getXiaoLvOfSec(leftSec)
			local addItem = Mathf.Floor(xiaoLv / self._score2Item)

			cur = cur + addItem
		else
			cur = 0
		end

		cur = Mathf.Min(cur, max)
		txtEnergy.text = string.format("%s：%s/%s", self._matName, cur, max)

		if cur > 0 then
			self._isCanGetAll = true
		end
	end

	GameUtil.SetActive(self._redBtnGetAll, self._isCanGetAll or RedPointModel.instance:isActive(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILY))
end

function UltimateWarDispatchPartView:_onSetUI()
	local list = {
		{
			showAdd = false,
			id = UltimateWarConfig.instance:getGoldMat(self._activityId)
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	GameUtil.SetActive(self._redBtnGetAll, RedPointModel.instance:isActive(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILY))
	RedPointController.instance:regRedPoint(self._redBtnSet, RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILYFIRSTDISPATCH, RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_CANDISPATCH)
end

function UltimateWarDispatchPartView:_onUpdate()
	local cfg = UltimateWarConfig.instance:getDefenceLineCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._pointView, self._pointCell, cfg, self._updatePointCell, self)
	self:_onTicking()
end

function UltimateWarDispatchPartView:_onClear()
	GameUtil.clearCells(self._pointView, self._clearPointCell, self)
end

function UltimateWarDispatchPartView:_updatePointCell(mainGo, data, index)
	local pointInfo = self._ultimateWarMo:getPointInfo(data.pointId)
	local point = goutil.findChild(mainGo, "point")
	local txtEnergy = goutil.findChildTextComponent(mainGo, "point/energy/txt")
	local txtName = goutil.findChildTextComponent(mainGo, "point/txtName")
	local petView = goutil.findChild(mainGo, "petView")
	local petCell = goutil.findChild(mainGo, "petCell")

	GameUtil.SetActive(petCell, false)

	local name = ""

	for i, v in ipairs(data.attributes) do
		name = name .. v
	end

	txtName.text = name

	if not data.pointPos then
		if not data.pointPos[3] then
			local x, y, scale = checknumber(data.pointPos[1]), checknumber(data.pointPos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.pointPos[3], data.pointPos[3], data.pointPos[3])

			local cur = pointInfo:getLeftItemCount()
			local max = pointInfo:getCurMaxLimtItem()

			txtEnergy.text = string.format("挑战进度：%s/%s", cur, max)
			self._energys[txtEnergy] = pointInfo

			local childCount = petView.transform.childCount

			if not data.specialRaceIds then
				local specialRaceIds = {}

				if specialRaceIds then
					if not #specialRaceIds then
						local dataLen = 0
						local len = math.max(childCount, dataLen)

						for index = 1, len do
							local cell, trans

							cell = index <= childCount and petView.transform:GetChild(index - 1).gameObject or goutil.cloneAndSetParent(petCell, petView.transform)

							if index <= dataLen then
								cell:SetActive(true)
								self:_updatePetCell(cell, data, specialRaceIds[index], index)
							else
								cell:SetActive(false)
								self:_clearPetCell(cell)
							end
						end
					end
				end
			end
		end
	end
end

function UltimateWarDispatchPartView:_clearPointCell(mainGo)
	local txtEnergy = goutil.findChildTextComponent(mainGo, "point/energy/txt")
	local petView = goutil.findChild(mainGo, "petView")

	self._energys[txtEnergy] = nil

	for i = 1, petView.transform.childCount do
		local cell = petView.transform:GetChild(i - 1).gameObject

		self:_clearPetCell(cell)
	end
end

function UltimateWarDispatchPartView:_updatePetCell(mainGo, data, raceId, index)
	local pointId = data.pointId
	local pointInfo = self._ultimateWarMo:getPointInfo(pointId)
	local isDispatching = pointInfo:isDispatchingTheRace(raceId)
	local icon = goutil.findChild(mainGo, "icon")
	local empty = goutil.findChild(mainGo, "empty")

	if data.petPos then
		if not data.petPos[index] then
			local pos = {}

			if not pos[3] then
				local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

				GameUtil.setLocalPos(mainGo, x, y, 0)
				GameUtil.setLocalScale(mainGo, pos[3], pos[3], pos[3])
				MaterialMgr.setIcon(icon, MatType.Pet, raceId, nil, nil)
				GameUtil.SetActive(empty, not isDispatching)
				GameUtil.addClickHandler(mainGo, function()
					UIStateManager.instance:push(ViewName.UltimateWarDispatchPetView, self._activityId, pointId)
				end)
			end
		end
	end
end

function UltimateWarDispatchPartView:_clearPetCell(mainGo)
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
end

function UltimateWarDispatchPartView:_onClickBtnGetAll()
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILY)

	if not self._isCanGetAll then
		FloatWordMgr.instance:show("暂无可领取货币")

		return
	end

	UltimateWarController.instance:sendPM_UltimateWarGainHangingPrizeReq(self._activityId)
end

function UltimateWarDispatchPartView:_onClickBtnTip()
	local key = self._actData.firstStepRule

	TipsFacade.instance:openRulesView(key)
end

function UltimateWarDispatchPartView:_onClickBtnSet()
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILYFIRSTDISPATCH)
	UIStateManager.instance:push(ViewName.UltimateWarDispatchPetView, self._activityId)
end

return UltimateWarDispatchPartView
