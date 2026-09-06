-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/NowTargetView.lua

module("logic.extensions.powerland.view.NowTargetView", package.seeall)

local NowTargetView = class("NowTargetView", ViewComponent)

function NowTargetView:ctor()
	NowTargetView.super.ctor(self)
end

function NowTargetView:buildUI()
	NowTargetView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnTarget = goutil.findChild(self.mainGO, "btnTarget")
	self._targetScrollerview = goutil.findChild(self.mainGO, "contentCol/targetCol/targetScrollerview")
	self._targetScrollercell = goutil.findChild(self.mainGO, "contentCol/targetCol/targetScrollercell")
	self._targetCol = goutil.findChild(self.mainGO, "contentCol/targetCol")
	self._txtEmptyGo = goutil.findChild(self.mainGO, "contentCol/txtEmpty")
	self._targetScrollList = ScrollerList.create(self._targetScrollerview, self._targetScrollercell, GameUtil.handler(self._updateTargetCell, self), GameUtil.handler(self._clearTargetCell, self))
end

function NowTargetView:bindEvents()
	NowTargetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnTarget, self._onClickBtnTarget, self)
end

function NowTargetView:unbindEvents()
	NowTargetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnTarget)
end

function NowTargetView:destroyUI()
	NowTargetView.super.destroyUI(self)
end

function NowTargetView:onEnter()
	NowTargetView.super.onEnter(self)

	self._activityId = PowerLandModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PowerLand, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内( activityId = %d )", self._activityId)
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function NowTargetView:onExit()
	NowTargetView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdate, self)
	self._targetScrollList:dispose()
end

function NowTargetView:_onSetUI()
	return
end

function NowTargetView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function NowTargetView:_onUpdateData()
	self:_onUpdateTargetColData()
end

function NowTargetView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTargetColUI()
end

function NowTargetView:_onUpdatePlaneUI()
	return
end

function NowTargetView:_onUpdateTargetColData()
	self._targetColDataList = {}

	local battleTargetInfo = PowerLandModel.instance:getBattleTargetInfo()
	local moList = battleTargetInfo:getTargetMoList()

	for _, mo in ipairs(moList) do
		if mo.count == 0 then
			break
		end

		if mo.level > 0 then
			local data = PowerLandConfig.instance:getRealPlTargetData(mo.targetId, mo.level)

			table.insert(self._targetColDataList, data)
		end
	end
end

function NowTargetView:_onUpdateTargetColUI()
	local isColNil = #self._targetColDataList <= 0

	GameUtil.SetActive(self._targetCol, not isColNil)
	GameUtil.SetActive(self._txtEmptyGo, isColNil)
	self:_onUpdateTargetScrollerList()
end

function NowTargetView:_onUpdateTargetScrollerList()
	self._targetScrollList:reloadData(self._targetColDataList)
end

function NowTargetView:_updateTargetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "effect/icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
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
	txtLevel.text = string.format("Lv.%d", data.level)

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTargetCell, self, data))
end

function NowTargetView:_clearTargetCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "effect/icon")

	uGuiUtil.clearImage(iconGo)
	GameUtil.rmClickHandler(mainGo)
end

function NowTargetView:_onClickTargetCell(data)
	UIStateManager.instance:push(ViewName.TargetDetailsView, data.targetId)
end

function NowTargetView:_onClickBtnTarget()
	UIStateManager.instance:push(ViewName.TargetDetailsView)
end

return NowTargetView
