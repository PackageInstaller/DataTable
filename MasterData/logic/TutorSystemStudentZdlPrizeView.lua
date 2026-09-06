-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemStudentZdlPrizeView.lua

module("logic.extensions.tutorsystem.view.TutorSystemStudentZdlPrizeView", package.seeall)

local TutorSystemStudentZdlPrizeView = class("TutorSystemStudentZdlPrizeView", ViewComponent)

function TutorSystemStudentZdlPrizeView:buildUI()
	TutorSystemStudentZdlPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._mask = goutil.findChild(self.mainGO, "mask")

	local scrView = goutil.findChild(self.mainGO, "taskScrView")
	local scrCell = goutil.findChild(self.mainGO, "taskScrCell")

	self._scrollRect = scrView:GetComponent(ComponentType.ScrollRect)

	local sliderGo = goutil.findChild(scrCell, "slider")

	self._topHeight = GameUtil.getHeight(sliderGo)
	self._bottomHegiht = self._topHeight * 0.3
	self._txtMyZdl = goutil.findChildTextComponent(self.mainGO, "zdl/txt")
	self._taskScrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
end

function TutorSystemStudentZdlPrizeView:bindEvents()
	TutorSystemStudentZdlPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._mask, self.close, self)
end

function TutorSystemStudentZdlPrizeView:unbindEvents()
	TutorSystemStudentZdlPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._mask)
end

function TutorSystemStudentZdlPrizeView:onEnter()
	TutorSystemStudentZdlPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_TutorStudentZdlPrizeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_TutorStudentGainZdlPrizeRes, self._handlePM_TutorStudentGainZdlPrizeRes, self)
	self:_onUpdate()
	TutorSystemController.instance:sendPM_TutorStudentZdlPrizeInfoReq()
end

function TutorSystemStudentZdlPrizeView:onExit()
	TutorSystemStudentZdlPrizeView.super.onExit(self)
	self._taskScrollList:dispose()
end

function TutorSystemStudentZdlPrizeView:_handlePM_TutorStudentGainZdlPrizeRes(msg)
	if msg.finish then
		self:close()
	else
		TutorSystemController.instance:sendPM_TutorStudentZdlPrizeInfoReq()
	end
end

function TutorSystemStudentZdlPrizeView:_onUpdate()
	local cfg = TutorSystemConfig.instance:getZdlPrizeCfg() or {}

	self._progressList = {}
	self._cellHeightList = {}

	local cur = RoleModel.instance:getMaxPower()
	local count = #cfg

	for index, data in ipairs(cfg) do
		local curHeight = self._bottomHegiht + ((count > 0 or nil) and (self._topHeight - self._bottomHegiht) / count) * (index - 1)

		if not self._cellHeightList[index - 1] then
			self._cellHeightList[index] = curHeight
			self._progressList[index] = cur / data.zdl
		end
	end

	self._taskScrollList:reloadData(cfg)

	self._txtMyZdl.text = cur

	local index = 0

	for idx, data in ipairs(cfg) do
		local isHasGain = TutorSystemModel.instance:isHasGainPrizeInZdlPrize(data.prizeId)
		local isCanGet = TutorSystemModel.instance:isCanGetPrizeInZdlPrize(data.prizeId)

		if isCanGet or isHasGain then
			index = idx

			break
		end
	end

	self._taskScrollList:MoveCellToCenter(index == -1 and 0 or index)
end

function TutorSystemStudentZdlPrizeView:_updateTaskCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local prizeId = data.prizeId
	local isHasGain = TutorSystemModel.instance:isHasGainPrizeInZdlPrize(prizeId)
	local isCanGet = TutorSystemModel.instance:isCanGetPrizeInZdlPrize(prizeId)
	local progress = self._progressList[tabIdx]
	local height = self._cellHeightList[tabIdx]
	local scrollRect = self._scrollRect
	local mainGo = cell.gameObject
	local txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl")
	local sliderGo = goutil.findChild(mainGo, "slider")
	local slider = sliderGo:GetComponent(ComponentType.Slider)
	local itemcell = goutil.findChild(mainGo, "slider/itemcell")
	local item = goutil.findChild(mainGo, "slider/itemcell/item")
	local received = goutil.findChild(mainGo, "slider/itemcell/received")
	local effectRoot = goutil.findChild(mainGo, "slider/itemcell/effectRoot")
	local btnGet = goutil.findChild(mainGo, "slider/itemcell/btnGet")
	local txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl")

	GameUtil.setHeight(sliderGo, height)

	slider.value = progress
	txtZdl.text = data.zdl

	local prizeStr = data.prize

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(scrollRect)
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, function()
		TutorSystemController.instance:sendPM_TutorStudentGainZdlPrizeReq(prizeId)
	end)
end

function TutorSystemStudentZdlPrizeView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "slider/itemcell/item")
	local btnGet = goutil.findChild(mainGo, "slider/itemcell/btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

return TutorSystemStudentZdlPrizeView
