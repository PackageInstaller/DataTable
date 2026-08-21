-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingPointView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingPointView", package.seeall)

local M = class("FacilityHoldingPointView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	local go = self:getResInstance(ResName.Room_facility_holding_facility_holding_point)

	self._rectTrGo = go:GetComponent(UIComponentType.RectTransform)

	self:_setVisible(false)

	local parent = self:getGo("facility_holding_main_view_1689953045")

	goutil.addChildToParent(go, parent)

	self._viewElementsRegistry = ViewElementsRegistry.New(go)
	self._imgFill = self._viewElementsRegistry:findUIElement("facility_holding_point_-1264341305", UIComponentType.Image)
	self._txtProcess = self._viewElementsRegistry:findUIElement("facility_holding_point_-1508555793", UIComponentType.Text)
	self._btnClick = self._viewElementsRegistry:findUIElement("facility_holding_point_-46168608", UIComponentType.ButtonAdapter)
	self._guiAnimation = goutil.addComponentOnce(go, typeof(Astral.GUITimelineAniLua))
	self._playableDirector = goutil.addComponentOnce(go, ComponentType.PlayableDirector)
end

function M:destroyUI()
	self._rectTrGo = nil
	self._guiAnimation = nil
	self._playableDirector = nil

	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil
	self._imgFill = nil
	self._txtProcess = nil
	self._btnClick = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickReport, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter(reasonTyp)
	self:_setEvent(true)
	self:_setVisible(false)

	local info = self:getFirstParam()

	self._roomId = info and info.roomId or 0

	self:_refreshAni(true, reasonTyp ~= WindowType.WindowCloseReasonType.QuickOpenType)
end

function M:onExit(closeReasonType)
	self:_setEvent(false)
	self:_refreshAni(false, closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType)
end

function M:onExitFinished()
	self._guiAnimation:StopTimelineAni()

	self._playableDirector.initialTime = 0
	self._playableDirector.time = 0
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
	end
end

function M:_onClickReport()
	ContainmentFacade.instance:openReportView(self._roomId)
end

function M:_onClickDetail()
	ContainmentFacade.instance:openReportView(self._roomId)
end

function M:_refreshAni(open, playAni)
	local hasProtomer = self:_refreshView()

	if hasProtomer then
		self._playableDirector.initialTime = 0

		self._guiAnimation:StopTimelineAni()
		PlayableDirectorUtil.JumpToTime(self._playableDirector, 0)

		local name = open and "open" or "close"
		local mode = not playAni and Astral.GUITimeLineMode.TimeToEnd or Astral.GUITimeLineMode.TimeToStart

		if open or not open and playAni then
			settimer(0, function()
				self._guiAnimation:PlayAniByName(name, mode)
				self:_setVisible(true)
			end, self, false)
		end
	else
		self._guiAnimation:StopTimelineAni()
		self:_setVisible(false)
	end
end

function M:_refreshView()
	local protomerInfoMo = ContainmentModel.instance:getProtomerInfo(self._roomId)

	if protomerInfoMo then
		local roomInfo = ContainmentModel.instance:getRoomInfoById(self._roomId)
		local nowReportNum = roomInfo:getTotalReportCount()
		local maxReportCount = ContainmentConfig.instance:getConstByKey("MaxReportCount")
		local process = 1

		if nowReportNum <= 0 then
			process = protomerInfoMo:getProductivity() / protomerInfoMo:getCfgProductivity()
		end

		self:_setProcess(math.floor(process * 100))
		self:_setFillUpContentStr(string.format("%d/%d", nowReportNum, maxReportCount))

		return protomerInfoMo:getProtomerId()
	end

	return false
end

function M:_handleHouseHoldRoomInfoChange()
	if self._visible then
		self:_refreshView()
	else
		self:_refreshAni(true, true)
	end
end

function M:_setProcess(process)
	local processP = process / 100

	processP = processP < 0 and 0 or processP
	processP = processP > 1 and 1 or processP
	self._imgFill.fillAmount = processP
end

function M:_setVisible(visible)
	self._visible = visible

	Astral.GeometryUtil.SetAnchorPosY(self._rectTrGo, visible and 0 or 2000)
end

function M:_setFillUpContentStr(str)
	self._txtProcess.text = str
end

return M
