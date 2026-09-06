-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryEventsView.lua

module("logic.extensions.goddessglory.view.GoddessGloryEventsView", package.seeall)

local GoddessGloryEventsView = class("GoddessGloryEventsView", ViewComponent)

function GoddessGloryEventsView:buildUI()
	GoddessGloryEventsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._bgClose = Framework.UIClickTrigger.Get(self:getGo("bg"))
	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)
end

function GoddessGloryEventsView:bindEvents()
	GoddessGloryEventsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._bgClose:AddClickListener(self._onClickClose, self)
	self._tableview:RegisterCallback(self._numEventsInView, nil, self._eventCellAtIndex, self)
end

function GoddessGloryEventsView:unbindEvents()
	GoddessGloryEventsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._bgClose:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function GoddessGloryEventsView:onEnter()
	GoddessGloryEventsView.super.onEnter(self)

	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()
	local stageMo = GoddessGloryModel.instance:getGoddessGloryStage(challengeId, stageId)

	self._events = stageMo:getAllEvents()

	table.sort(self._events, function(x, y)
		return x.eventState - y.eventState > 0
	end)
	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
end

function GoddessGloryEventsView:onExit()
	GoddessGloryEventsView.super.onExit(self)

	self._events = nil

	self._tableview:Travel(function(cell)
		local iconReward = goutil.findChild(cell.gameObject, "txtReward/icon")
		local evtIconPet = goutil.findChild(cell.gameObject, "evtIconPet")

		MaterialMgr.clearIcon(iconReward)
		MaterialMgr.clearIcon(evtIconPet)
	end, nil)
end

function GoddessGloryEventsView:_onClickClose()
	self:close()
end

function GoddessGloryEventsView:_numEventsInView(view)
	if not self._events then
		return 0
	end

	return #self._events
end

function GoddessGloryEventsView:_eventCellAtIndex(view, idx)
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableCell)

	local evtData = self._events[idx + 1]
	local evtCo = GoddessGloryConfig.instance:getEventCo(evtData.eventId)
	local imgTitle = goutil.findChildComponent(cell.gameObject, "imgTitle", ComponentType.UIImageSpriteChange)
	local imgBg = cell:GetComponent(ComponentType.UIImageSpriteChange)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local finished = goutil.findChild(cell.gameObject, "pass")

	finished:SetActive(evtData.eventState == GoddessGloryEvtStatus.Finished)

	if evtCo.type == GoddessGloryEvtType.Challenge and evtCo.isBossEvent then
		imgTitle:SetState(GoddessGloryEvtType.Boss - 1)
		imgBg:SetState(GoddessGloryEvtType.Boss - 1)
	else
		imgTitle:SetState(evtCo.type - 1)
		imgBg:SetState(evtCo.type - 1)
	end

	txtDesc.text = evtCo.desc

	self:_fillRewards(cell, evtCo, evtData)
	self:_fillEvtIcon(cell, evtCo)

	return cell
end

function GoddessGloryEventsView:_fillEvtIcon(cell, evtCo)
	local iconEvt = goutil.findChildComponent(cell.gameObject, "evtIcon", ComponentType.UIImageSpriteChange)
	local evtIconPet = goutil.findChild(cell.gameObject, "evtIconPet")

	if evtCo.type == GoddessGloryEvtType.Challenge then
		iconEvt.gameObject:SetActive(false)
		evtIconPet:SetActive(true)
		MaterialMgr.setIcon(evtIconPet, MatType.Pet, evtCo.evtPetIcon)
	else
		iconEvt.gameObject:SetActive(true)
		evtIconPet:SetActive(false)
		iconEvt:SetState(evtCo.type - 1)
	end
end

function GoddessGloryEventsView:_fillRewards(cell, evtCo, evtData)
	local txtReward = goutil.findChildTextComponent(cell.gameObject, "txtReward")
	local iconReward = goutil.findChild(cell.gameObject, "txtReward/icon")
	local typeReward = goutil.findChildTextComponent(cell.gameObject, "txtReward/txt")

	MaterialMgr.setIcon(iconReward, MatType.Item_Fake, GoddessGloryModel.instance:getEnergyItemId())

	if evtCo.energy > 0 then
		txtReward.gameObject:SetActive(true)

		typeReward.text = "奖励："
		txtReward.text = "x" .. evtCo.energy
	elseif evtCo.cost > 0 then
		txtReward.gameObject:SetActive(true)

		typeReward.text = "消耗："
		txtReward.text = "x" .. evtCo.cost
	else
		txtReward.gameObject:SetActive(false)
	end
end

return GoddessGloryEventsView
