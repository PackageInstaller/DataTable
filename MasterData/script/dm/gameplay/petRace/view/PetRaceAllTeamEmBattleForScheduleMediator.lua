-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceAllTeamEmBattleForScheduleMediator.lua

PetRaceAllTeamEmBattleForScheduleMediator = class("PetRaceAllTeamEmBattleForScheduleMediator", DmPopupViewMediator)

PetRaceAllTeamEmBattleForScheduleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PetRaceAllTeamEmBattleForScheduleMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
PetRaceAllTeamEmBattleForScheduleMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {}
local teamDesInfo = {
	Strings:get("Petrace_Text_7"),
	Strings:get("Petrace_Text_9"),
	Strings:get("Petrace_Text_10"),
	Strings:get("Petrace_Text_11"),
	Strings:get("Petrace_Text_12")
}
local costLimit = 15

function PetRaceAllTeamEmBattleForScheduleMediator:onClickOK()
	self._state = self._petRaceSystem:getMyMatchState()

	local cdtime = self:getCD(self._targetTime)

	if self._state ~= 2 and cdtime <= 0 then
		self:showTip(Strings:get("Petrace_Text_13"))
		self:close()

		return false
	end

	local args = {}

	args.order = {}
	args.embattleInfo = self._embattleInfo

	for i = 1, 10 do
		table.insert(args.order, table.indexof(self._originalEmbattleInfo, self._embattleInfo[i]))
	end

	self._petRaceSystem:adjustTeamOrder(function()
		self:showTip(Strings:get("Petrace_Text_14"))
	end, args, true)
end

function PetRaceAllTeamEmBattleForScheduleMediator:initialize()
	super.initialize(self)
end

function PetRaceAllTeamEmBattleForScheduleMediator:dispose()
	super.dispose(self)
end

function PetRaceAllTeamEmBattleForScheduleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	costLimit = self._petRaceSystem:getMaxCost()

	self:bindWidget("Panel_base.Button_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickOK, self)
		}
	})
end

function PetRaceAllTeamEmBattleForScheduleMediator:mapEventListeners()
	return
end

function PetRaceAllTeamEmBattleForScheduleMediator:enterWithData(data)
	self._state = self._petRaceSystem:getMyMatchState()
	self._round = self._petRaceSystem:getRound()
	self._knockout = self._petRaceSystem:knockout()
	self._targetTime = data.targetTime
	self._mySccheduleData = self._petRaceSystem:getMySchedule()

	self:setupView()
end

function PetRaceAllTeamEmBattleForScheduleMediator:setupView()
	self._panel_base = self:getView():getChildByName("Panel_base")
	self._node_container = self._panel_base:getChildByName("Node_container")

	local bgNode = self:getView():getChildByFullName("Panel_base.tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		title = "",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		},
		bgSize = {
			width = 950,
			height = 590
		}
	})

	self._mainPanel = self:getView():getChildByFullName("Panel_base")

	self:bindBackBtnFlash(self._mainPanel, cc.p(1001, 535))
	self:updateFightdata()
	self:registerTouchEvent()
	self:initTeamCell()
	self:reloadCell()
end

function PetRaceAllTeamEmBattleForScheduleMediator:initTeamCell()
	self._teamCellArray = {}

	for i = 1, 10 do
		self._teamCellArray[i] = self._node_container:getChildByName("Node_team_" .. i)
	end

	if self._cellSize == nil then
		local scaleX = self._teamCellArray[1]:getScaleX()
		local scaleY = self._teamCellArray[1]:getScaleY()

		self._cellSize = self._teamCellArray[1]:getChildByName("Panel_base"):getContentSize()
		self._cellSize.width = self._cellSize.width * scaleX
		self._cellSize.height = self._cellSize.height * scaleY
	end
end

function PetRaceAllTeamEmBattleForScheduleMediator:reloadCell()
	for i = 1, 10 do
		self:cellAtIndex(i)
	end
end

function PetRaceAllTeamEmBattleForScheduleMediator:cellAtIndex(index)
	local data = {}

	data.embattleInfo = self._embattleInfo[index] or {}

	if self._round < 11 then
		data.des = string.format(teamDesInfo[1], index)

		if not self._mySccheduleData.roundInfo[index] then
			local info = {}

			if info.winId and #info.winId > 0 then
				data.isWin = info.userId == info.winId
			end
		end
	elseif index == 10 then
		data.des = string.format(teamDesInfo[5])
	else
		local desIndex = math.floor((index - 1) / 3) + 2

		data.des = string.format(teamDesInfo[desIndex], (index - 1) % 3 + 1)

		local teamResultIndex = math.floor((index - 1) / 3) + 1

		if not self._mySccheduleData.roundInfo[10 + teamResultIndex] then
			local info = {}

			if info.winId and #info.winId > 0 then
				data.isWin = info.userId == info.winId
			end
		end
	end

	data.cost = self._petRaceSystem:getTeamCostByIndex(index)
	data.limit = costLimit

	local cell = self._teamCellArray[index]

	cell.m_cellMediator = cell.m_cellMediator or self:getInjector():instantiate(PetRaceTeamCellForSchedule, {
		view = cell
	})

	cell.m_cellMediator:update(data, index)
end

function PetRaceAllTeamEmBattleForScheduleMediator:updateFightdata()
	self._originalEmbattleInfo = self._petRaceSystem:getEmbattleInfo()
	self._embattleInfo = table.copy(self._originalEmbattleInfo)
end

function PetRaceAllTeamEmBattleForScheduleMediator:dealMove()
	local selectIndex = 0

	for i = 1, #self._teamCellArray do
		if self._teamCellArray[i] ~= self._touchEmbattleIcon then
			local targetPos = cc.p(self._teamCellArray[i]:getPosition())
			local curPosX, curPosy = self._touchEmbattleIcon:getPosition()
			local curPos = cc.p(curPosX + self._cellSize.width / 2, curPosy + self._cellSize.height / 2)
			local rect = cc.rect(targetPos.x, targetPos.y, self._cellSize.width, self._cellSize.height)

			if cc.rectContainsPoint(rect, curPos) and self._teamCellArray[i].m_cellMediator:isWin() == nil then
				selectIndex = i

				break
			end
		end
	end

	if selectIndex > 0 then
		self._embattleInfo[selectIndex] = self._embattleInfo[self._touchEmbattleIcon.index]
		self._embattleInfo[self._touchEmbattleIcon.index] = self._embattleInfo[selectIndex]

		local tempIcon = self._teamCellArray[selectIndex]

		self._teamCellArray[selectIndex] = self._teamCellArray[self._touchEmbattleIcon.index]
		self._teamCellArray[self._touchEmbattleIcon.index] = tempIcon

		self._touchEmbattleIcon:setPosition(tempIcon:getPosition())
		tempIcon:setPosition(self._touchEmbattleIcon.originalPos)
		self:reloadCell()
	else
		local pos = self._touchEmbattleIcon.originalPos

		self._touchEmbattleIcon:setPosition(pos.x, pos.y)
	end

	self._touchEmbattleIcon = nil
end

function PetRaceAllTeamEmBattleForScheduleMediator:showTip(str)
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = str
	}))
end

function PetRaceAllTeamEmBattleForScheduleMediator:onTouchBegan(touch, event)
	self._state = self._petRaceSystem:getMyMatchState()

	local cdtime = self:getCD(self._targetTime)

	if self._state ~= 2 and cdtime <= 0 then
		self:showTip(Strings:get("Petrace_Text_13"))
		self:close()

		return false
	end

	local pt = touch:getLocation()

	if not self._touchEmbattleIcon then
		for k, v in pairs(self._teamCellArray) do
			local view = v

			if v.m_cellMediator:isWin() == nil then
				local x, y = view:getPosition()
				local pos = view:getParent():convertToWorldSpace(cc.p(x, y))
				local rectTmp = cc.rect(pos.x, pos.y, self._cellSize.width, self._cellSize.height)

				if cc.rectContainsPoint(rectTmp, pt) then
					self._touchEmbattleIcon = v
					self._touchEmbattleIcon.index = k

					break
				end
			end
		end
	end

	if self._touchEmbattleIcon then
		local x, y = self._touchEmbattleIcon:getPosition()

		self._touchEmbattleIcon.originalPos = cc.p(x, y)

		self._touchEmbattleIcon:setLocalZOrder(99)

		return true
	end

	return false
end

function PetRaceAllTeamEmBattleForScheduleMediator:onTouchMoved(touch, event)
	local curp = touch:getLocation()
	local startP = touch:getStartLocation()
	local diffx, diffy = curp.x - startP.x, curp.y - startP.y
	local localPos = self._touchEmbattleIcon:getParent():convertToNodeSpace(curp)

	localPos.x = localPos.x - self._cellSize.width / 2
	localPos.y = localPos.y - self._cellSize.height / 2

	self._touchEmbattleIcon:setPosition(localPos)
end

function PetRaceAllTeamEmBattleForScheduleMediator:onTouchEnded(touch, event)
	self._state = self._petRaceSystem:getMyMatchState()

	local cdtime = self:getCD(self._targetTime)

	if self._state ~= 2 and cdtime <= 0 then
		self:showTip(Strings:get("Petrace_Text_13"))
		self:close()

		return
	end

	local touchPoint = touch:getLocation()

	self:dealMove()

	if self._touchEmbattleIcon then
		self._touchEmbattleIcon:setLocalZOrder(0)

		self._touchEmbattleIcon = nil
	end
end

function PetRaceAllTeamEmBattleForScheduleMediator:onTouchCanceled(touch, event)
	if self._touchEmbattleIcon then
		local pos = self._touchEmbattleIcon.originalPos

		self._touchEmbattleIcon:setPosition(pos.x, pos.y)
		self._touchEmbattleIcon:setLocalZOrder(0)
	end

	self._touchEmbattleIcon = nil
end

function PetRaceAllTeamEmBattleForScheduleMediator:registerTouchEvent()
	local function onTouched(touch, event)
		local eventType = event:getEventCode()

		if eventType == ccui.TouchEventType.began then
			return self:onTouchBegan(touch, event)
		elseif eventType == ccui.TouchEventType.moved then
			self:onTouchMoved(touch, event)
		elseif eventType == ccui.TouchEventType.ended then
			self:onTouchEnded(touch, event)
		else
			self:onTouchCanceled(touch, event)
		end
	end

	self.listener = cc.EventListenerTouchOneByOne:create()

	self.listener:setSwallowTouches(false)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_BEGAN)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_MOVED)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_ENDED)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_CANCELLED)

	local touchPanel = self:getView():getChildByName("Panel_touch")

	touchPanel:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, touchPanel)
end

function PetRaceAllTeamEmBattleForScheduleMediator:onBackClicked(sender, eventType)
	self:close()
end

function PetRaceAllTeamEmBattleForScheduleMediator:getCD(targetTime)
	return math.floor(targetTime - self._gameServerAgent:remoteTimestamp())
end
