-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/TargetDetailsView.lua

module("logic.extensions.powerland.view.TargetDetailsView", package.seeall)

local TargetDetailsView = class("TargetDetailsView", ViewComponent)

function TargetDetailsView:ctor()
	TargetDetailsView.super.ctor(self)
end

function TargetDetailsView:buildUI()
	TargetDetailsView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._targetScrollerview = goutil.findChild(self.mainGO, "topCol/targetCol/targetScrollerview")
	self._targetScrollercell = goutil.findChild(self.mainGO, "topCol/targetCol/targetScrollercell")
	self._targetCol = goutil.findChild(self.mainGO, "topCol/targetCol")
	self._txtEmptyGo = goutil.findChild(self.mainGO, "topCol/txtEmpty")
	self._pageScrollerview = goutil.findChild(self.mainGO, "pageCol/pageScrollerview")
	self._pageScrollercell = goutil.findChild(self.mainGO, "pageCol/pageScrollercell")
	self._descScrollerview = goutil.findChild(self.mainGO, "contentCol/descCol/descScrollerview")
	self._descScrollercell = goutil.findChild(self.mainGO, "contentCol/descCol/descScrollercell")
	self._txtDescTips = goutil.findChildTextComponent(self.mainGO, "contentCol/txtDescTips")
	self._pageScrollList = ScrollerList.create(self._pageScrollerview, self._pageScrollercell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageCell, self))
	self._targetScrollList = ScrollerList.create(self._targetScrollerview, self._targetScrollercell, GameUtil.handler(self._updateTargetCell, self), GameUtil.handler(self._clearTargetCell, self))
	self._descScrollList = ScrollerList.create(self._descScrollerview, self._descScrollercell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))

	GameUtil.SetActive(self._pageScrollercell, false)
	GameUtil.SetActive(self._targetScrollercell, false)
	GameUtil.SetActive(self._descScrollercell, false)
	GameUtil.SetActive(self._targetCol, false)
	GameUtil.SetActive(self._txtEmptyGo, true)
end

function TargetDetailsView:bindEvents()
	TargetDetailsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TargetDetailsView:unbindEvents()
	TargetDetailsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TargetDetailsView:destroyUI()
	TargetDetailsView.super.destroyUI(self)
end

function TargetDetailsView:onEnter()
	TargetDetailsView.super.onEnter(self)

	self._activityId = PowerLandModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PowerLand, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内( activityId = %d )", self._activityId)
		self:close()

		return
	end

	local params = self:getOpenParam() or {}

	self._toTargetId = checknumber(params[1])

	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function TargetDetailsView:onExit()
	TargetDetailsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdate, self)
	self._targetScrollList:dispose()
	self._pageScrollList:dispose()
	self._descScrollList:dispose()
end

function TargetDetailsView:_onSetUI()
	return
end

function TargetDetailsView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TargetDetailsView:_onUpdateData()
	self:_onUpdateTargetColData()
	self:_onUpdatePageColData()
end

function TargetDetailsView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTargetColUI()
	self:_onUpdatePageColUI()
end

function TargetDetailsView:_onUpdatePlaneUI()
	return
end

function TargetDetailsView:_onUpdateTargetColData()
	self._targetColDataList = {}

	local fmtTargetInfo = PowerLandModel.instance:getFmtTargetInfo()
	local moList = fmtTargetInfo:getTargetMoList()

	for _, mo in ipairs(moList) do
		if mo.count == 0 then
			break
		end

		local data = PowerLandConfig.instance:getRealPlTargetData(mo.targetId, mo.level)

		table.insert(self._targetColDataList, data)
	end
end

function TargetDetailsView:_onUpdateTargetColUI()
	local isColNil = #self._targetColDataList <= 0

	GameUtil.SetActive(self._targetCol, not isColNil)
	GameUtil.SetActive(self._txtEmptyGo, isColNil)
	self:_onUpdateTargetScrollerList()
end

function TargetDetailsView:_onUpdateTargetScrollerList()
	self._targetScrollList:reloadData(self._targetColDataList)
end

function TargetDetailsView:_updateTargetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local path = data.iconPath
	local bgGo = iconGo

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/expevents/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	local fmtTargetInfo = PowerLandModel.instance:getFmtTargetInfo()
	local count = fmtTargetInfo:getTargetCount(data.targetId)

	txtCount.text = string.format("x %d", count)
end

function TargetDetailsView:_clearTargetCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(iconGo)
end

function TargetDetailsView:_onUpdatePageColData()
	self._pageColTargetDataList = {}

	local fmtTargetInfo = PowerLandModel.instance:getFmtTargetInfo()
	local moList = fmtTargetInfo:getTargetMoList()

	for _, mo in ipairs(moList) do
		table.insert(self._pageColTargetDataList, PowerLandConfig.instance:getTargetLevelMinLimitData(mo.targetId))
	end

	self._minPageIdx = 1
	self._maxPageIdx = #moList
	self._curPageIdx = self._curPageIdx or self._minPageIdx

	for pageIdx, data in ipairs(self._pageColTargetDataList) do
		if self._toTargetId == data.targetId then
			self._curPageIdx = pageIdx
		end
	end

	self._curPageIdx = Mathf.Clamp(self._curPageIdx, self._minPageIdx, self._maxPageIdx)
end

function TargetDetailsView:_getCurPageTargetData()
	return self._pageColTargetDataList[self._curPageIdx]
end

function TargetDetailsView:_getCurPageTargetId()
	return self:_getCurPageTargetData().targetId
end

function TargetDetailsView:_onUpdatePageColUI()
	self:_onUpdatePageScrollerList()
	self:_onUpdateDescScrollerList()
end

function TargetDetailsView:_onUpdatePageScrollerList()
	self._pageScrollList:reloadData(self._pageColTargetDataList)

	local idx = Mathf.Clamp(0, self._curPageIdx - 1, #self._pageColTargetDataList - 1)
	local isMotion = true

	self._pageScrollList:MoveCellInView(idx, isMotion)
end

function TargetDetailsView:_updatePageCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local pageIdx = cell.data
	local path = data.iconPath
	local bgGo = iconGo

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/expevents/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	txtName.text = data.targetName

	local isSelected = pageIdx == self._curPageIdx

	GameUtil.setUIImageColorIdx(mainGo, isSelected and 1 or 0)

	local function handler()
		self._curPageIdx = pageIdx

		self:_onUpdatePageColUI()
	end

	GameUtil.addClickHandler(mainGo, handler)
end

function TargetDetailsView:_clearPageCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(iconGo)
	GameUtil.rmClickHandler(mainGo, handler)
end

function TargetDetailsView:_onUpdateDescScrollerList()
	local dataList = PowerLandConfig.instance:getTargetDataList(self:_getCurPageTargetId())

	self._descScrollList:reloadData(dataList)

	local isMotion = true

	self._descScrollList:MoveCellInView(0, isMotion)
end

function TargetDetailsView:_updateDescCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtLevel.text = string.format("%d级", data.level)
	txtDesc.text = data.desc
end

function TargetDetailsView:_clearDescCell(cell)
	return
end

return TargetDetailsView
