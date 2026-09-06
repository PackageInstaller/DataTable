-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnTaskView.lua

module("logic.extensions.playerreturn.view.PlayerReturnTaskView", package.seeall)

local PlayerReturnTaskView = class("PlayerReturnTaskView", TableViewComponent)

function PlayerReturnTaskView:ctor()
	PlayerReturnTaskView.super.ctor(self)

	self._choiDayIndex = nil
	self._daysItemList = nil
	self._scoreItemList = nil
	self._scoreInfoList = nil
	self._scoreEffList = nil
end

function PlayerReturnTaskView:bindEvents()
	PlayerReturnTaskView.super.bindEvents(self)
end

function PlayerReturnTaskView:unbindEvents()
	PlayerReturnTaskView.super.unbindEvents(self)
end

function PlayerReturnTaskView:onExit()
	PlayerReturnTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PR_UpdataTaskInfo, self.updataPlayerReturnTask, self)
	GlobalDispatcher:removeListener(GlobalNotify.PR_UpdataScoreInfo, self._updataAllScoreItemShow, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	for _, eff in pairs(self._scoreEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._scoreEffList = nil
end

function PlayerReturnTaskView:destroyUI()
	PlayerReturnTaskView.super.destroyUI(self)

	self._choiDayIndex = nil
	self._daysItemList = nil

	for _, item in pairs(self._scoreItemList or {}) do
		if item and item.itemGo and item.isDestroy then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._scoreItemList = nil
	self._scoreInfoList = nil
end

function PlayerReturnTaskView:buildUI()
	PlayerReturnTaskView.super.buildUI(self)

	self._numIma = self:getGo("numberIma"):GetComponent("UIImgNumeralText")

	local allDaysTran = self:getGo("allDayTran").transform

	self._daysItemList = {}

	for i = 1, allDaysTran.childCount do
		local go = allDaysTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		self._daysItemList[tonumber(names[2])] = {
			itemGo = go,
			itemGrp = go:GetComponent("UIChangeGroup"),
			itemTxt = goutil.findChildTextComponent(go, "btnTxt"),
			redGo = goutil.findChild(go, "redGo"),
			lockGo = goutil.findChild(go, "lockGo")
		}
	end

	self._scoreTran = self:getGo("scoreShowGo"):GetComponent(goutil.Type_RectTransform)
	self._scoreSli = goutil.findChildComponent(self._scoreTran.gameObject, "scoreSli", "Slider")
	self._smaCell = goutil.findChild(self._scoreTran.gameObject, "smaCell")
	self._bigCell = goutil.findChild(self._scoreTran.gameObject, "bigCell")
	self._scoreSli.value = 0

	self._smaCell:SetActive(false)
	self._bigCell:SetActive(false)
end

function PlayerReturnTaskView:onEnter()
	PlayerReturnTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PR_UpdataTaskInfo, self.updataPlayerReturnTask, self)
	GlobalDispatcher:addListener(GlobalNotify.PR_UpdataScoreInfo, self._updataAllScoreItemShow, self)
	PlayerReturnController.instance:csRegressGetTaskInfoReq()

	self._actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()
	self._mainCfg = self:getFirstParam()

	if self._mainCfg == nil then
		self._mainCfg = PlayerReturnConfig.instance:getReturnMainViewCfgs(self._actiInfo.actId, 3)
	end

	self._choiDayIndex = 1
	self._scoreEffList = {}

	self:updataPlayerReturnTask()

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
end

function PlayerReturnTaskView:updataPlayerReturnTask()
	self._scoreItemList = self._scoreItemList or {}
	self._openDays = GameUtil.getDaysByTimestamp(self._actiInfo.startTime, ServerTime.now())

	self:_updataAllDaysItemShow(true)
	self:_updataAllScoreItemShow()
end

function PlayerReturnTaskView:_updataAllScoreItemShow()
	self._scoreInfoList, self._haveScore = PlayerReturnModel.instance:getScoreInfoList(self._mainCfg.planId)

	self._numIma:SetNum(self._haveScore)

	self._scoreSli.value = 0

	if self._scoreInfoList then
		if not #self._scoreInfoList then
			local count = 0

			if count > 0 then
				local allX = 700
				local oneX = allX / count
				local jd = 1
				local effPath = "fx_ui_qirirenwu/fx_qirirenwu_kelingqu.prefab"

				for i = 1, count do
					if self._scoreEffList[i] then
						UIEffectManager.instance:stopEffect(self._scoreEffList[i])

						self._scoreEffList[i] = nil
					end

					if self._scoreItemList[i] == nil or self._scoreItemList[i].itemGo == nil then
						local go

						self._scoreItemList[i] = {}
						go = i == count and self._bigCell or UnityEngine.GameObject.Instantiate(self._smaCell, self._scoreTran)
						self._scoreItemList[i].itemGo = go
						self._scoreItemList[i].matPos = goutil.findChild(go, "matPos")
						self._scoreItemList[i].receivedGo = goutil.findChild(go, "receivedGo")
						self._scoreItemList[i].countTxt = goutil.findChildTextComponent(go, "countTxt")
						self._scoreItemList[i].clickBtnGo = goutil.findChild(go, "clickBtnGo")
					end

					self._scoreItemList[i].itemGo:SetActive(true)
					MaterialMgr.resetAll(self._scoreItemList[i].matPos)
					GameUtil.asBtn(self._scoreItemList[i].clickBtnGo):RemoveClickListener()

					if i < count then
						Framework.TransformUtil.SetLocalPos(self._scoreItemList[i].itemGo.transform, i * oneX - allX / 2, 0, 0)
					end

					if self._scoreInfoList[i] and #self._scoreInfoList[i].goods > 2 then
						local subLua = MaterialMgr.setCell(checknumber(self._scoreInfoList[i].goods[1]), checknumber(self._scoreInfoList[i].goods[2]), self._scoreItemList[i].matPos)

						subLua.binder:setNum(checknumber(self._scoreInfoList[i].goods[3]))
					end

					self._scoreItemList[i].countTxt.text = tostring(self._scoreInfoList[i].needCount)

					if self._scoreInfoList[i].isReceive then
						self._scoreItemList[i].receivedGo:SetActive(true)
						self._scoreItemList[i].clickBtnGo:SetActive(true)

						if jd < i then
							jd = i
						end
					else
						self._scoreItemList[i].receivedGo:SetActive(false)

						if self._scoreInfoList[i].isReach then
							self._scoreItemList[i].clickBtnGo:SetActive(true)

							self._scoreEffList[i] = UIEffectManager.instance:playEffect(self, effPath, self._scoreItemList[i].itemGo, 0, 0, true, nil, nil, function(_, eff)
								eff:setClipping(self._scoreTran)
							end, self)

							self._scoreEffList[i]:setParent(self._scoreItemList[i].itemGo.transform)

							if count <= i then
								self._scoreEffList[i]:setLocalPos(0, 40, 0)
								self._scoreEffList[i]:setScale(1.85)
							else
								self._scoreEffList[i]:setLocalPos(0, 28, 0)
								self._scoreEffList[i]:setScale(1.35)
							end

							if jd < i then
								jd = i
							end
						else
							self._scoreItemList[i].clickBtnGo:SetActive(false)
						end
					end

					GameUtil.asBtn(self._scoreItemList[i].clickBtnGo):AddClickListener(function()
						if self._scoreInfoList[i].isReceive then
							FloatWordMgr.instance:show("已领取！")

							return
						end

						if not self._scoreInfoList[i].isReach then
							FloatWordMgr.instance:show("未达到领取条件！")

							return
						end

						PlayerReturnController.instance:csRegressGainTaskScorePrizeReq(i)
					end, self)
				end

				if jd < count then
					local sy = self._haveScore - self._scoreInfoList[jd].needCount
					local yy = self._scoreInfoList[jd + 1].needCount - self._scoreInfoList[jd].needCount

					self._scoreSli.value = jd / count + sy / (count * yy)
				else
					self._scoreSli.value = 1
				end
			end

			if count < #self._scoreItemList then
				for i = count + 1, #self._scoreItemList do
					if self._scoreItemList[i] and self._scoreItemList[i].itemGo and self._scoreItemList[i].itemGo.activeSelf then
						self._scoreItemList[i].itemGo:SetActive(false)
					end
				end
			end
		end
	end
end

function PlayerReturnTaskView:_updataAllDaysItemShow(isInit)
	if self._daysItemList == nil or #self._daysItemList == 0 then
		return
	end

	if self._openDays > #self._daysItemList then
		self._choiDayIndex = #self._daysItemList or self._openDays
	end

	for i = 1, #self._daysItemList do
		if self._daysItemList[i] and self._daysItemList[i].itemGo then
			if i == self._choiDayIndex then
				self._daysItemList[i].itemGrp:SetState(1)
			else
				self._daysItemList[i].itemGrp:SetState(0)
			end

			local isRed = PlayerReturnModel.instance:getTaskDaysRedpoint(self._mainCfg.planId, i)

			self._daysItemList[i].redGo:SetActive(isRed)
			self._daysItemList[i].lockGo:SetActive(i > self._choiDayIndex)

			if isInit then
				GameUtil.asBtn(self._daysItemList[i].itemGo):RemoveClickListener()

				self._daysItemList[i].itemTxt.text = string.format("第%s天", ConstString.ChineseNumber[i])

				GameUtil.asBtn(self._daysItemList[i].itemGo):AddClickListener(function()
					self:_onClickDaysItemBtn(i)
				end, self)
			end
		end
	end

	if self._daysItemList[self._choiDayIndex] and self._daysItemList[self._choiDayIndex].itemGo then
		self:_onClickDaysItemBtn(self._choiDayIndex, true)
	end
end

function PlayerReturnTaskView:_onClickDaysItemBtn(index, isForce)
	if index > self._openDays then
		FloatWordMgr.instance:show("暂时未解锁该日任务哦！")

		return
	end

	if self._choiDayIndex == index and not isForce then
		return
	end

	if self._daysItemList[self._choiDayIndex] and self._daysItemList[self._choiDayIndex].itemGrp then
		self._daysItemList[self._choiDayIndex].itemGrp:SetState(0)
	end

	if self._daysItemList[index] and self._daysItemList[index].itemGrp then
		self._daysItemList[index].itemGrp:SetState(1)
	end

	self._choiDayIndex = index
	self._curViewDatas = PlayerReturnModel.instance:getTaskInfoList(self._mainCfg.planId, self._choiDayIndex)

	self._tableview:ReloadData()
	self._tableview:MoveCellInView(0, false)
end

function PlayerReturnTaskView:_getPath()
	return {
		cellPath = "taskItem",
		viewPath = "taskItemSR"
	}
end

function PlayerReturnTaskView:_cellSize()
	return 962, 106
end

function PlayerReturnTaskView:_updateCell(view, cell, data)
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local gotoBtnGo = goutil.findChild(cell, "gotoBtn")
	local receiveGo = goutil.findChild(cell, "receiveGo")
	local itemSli = goutil.findChildComponent(cell, "itemSli", "Slider")
	local itemDescTxt = goutil.findChildTextComponent(cell, "itemDescTxt")
	local itemProgTxt = goutil.findChildTextComponent(cell, "itemProgTxt")
	local matPosList = {
		goutil.findChild(cell, "matPos_1"),
		goutil.findChild(cell, "matPos_2"),
		goutil.findChild(cell, "matPos_3"),
		goutil.findChild(cell, "matPos_4")
	}

	GameUtil.asBtn(receiveBtnGo):RemoveClickListener()
	GameUtil.asBtn(gotoBtnGo):RemoveClickListener()

	for i = 1, #matPosList do
		if matPosList[i] then
			MaterialMgr.resetAll(matPosList[i])
		end
	end

	if data.isReceive then
		receiveBtnGo:SetActive(false)
		gotoBtnGo:SetActive(false)
		receiveGo:SetActive(true)

		itemSli.value = 1
	else
		receiveGo:SetActive(false)
		gotoBtnGo:SetActive(false)

		if data.isReach then
			receiveBtnGo:SetActive(true)
		else
			receiveBtnGo:SetActive(false)

			if not string.nilorempty(data.jumpTo) then
				gotoBtnGo:SetActive(true)
			end
		end

		itemSli.value = data.haveCount / data.needCount
	end

	itemProgTxt.text = data.haveCount .. "/" .. data.needCount
	itemDescTxt.text = data.desc

	if data.prizeList and #data.prizeList > 0 then
		for i = 1, #data.prizeList + 1 do
			if matPosList[i] then
				local goods = i <= #data.prizeList and string.split(data.prizeList[i], ":") or {
					"1004",
					"1009",
					tostring(data.score)
				}

				if goods and #goods > 2 then
					local subLua = MaterialMgr.setCell(checknumber(goods[1]), checknumber(goods[2]), matPosList[i])

					subLua.binder:setNum(checknumber(goods[3]))
				end
			end
		end
	end

	if data.isReceive then
		return
	end

	if data.isReach then
		GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
			PlayerReturnController.instance:csRegressGainTaskPrizeReq(data.id, self._mainCfg.planId)
		end, self)
	elseif not string.nilorempty(data.jumpTo) then
		GameUtil.asBtn(gotoBtnGo):AddClickListener(function()
			GotoMgr.gotoByString(data.jumpTo)
		end, self)
	end
end

return PlayerReturnTaskView
