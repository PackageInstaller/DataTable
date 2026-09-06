-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/TargetColConView.lua

module("logic.extensions.powerland.view.TargetColConView", package.seeall)

local TargetColConView = class("TargetColConView", ViewComponent)

function TargetColConView:ctor()
	TargetColConView.super.ctor(self)
end

function TargetColConView:destroyUI()
	TargetColConView.super.destroyUI(self)
end

function TargetColConView:onExitFinished()
	TargetColConView.super.onExitFinished(self)
end

function TargetColConView:onEnterFinished()
	TargetColConView.super.onEnterFinished(self)
end

function TargetColConView:unbindEvents()
	TargetColConView.super.unbindEvents(self)
end

function TargetColConView:bindEvents()
	TargetColConView.super.bindEvents(self)
end

function TargetColConView:buildUI()
	TargetColConView.super.buildUI(self)

	local targetScrollerView = goutil.findChild(self.mainGO, "targetScrollerview")
	local targetScrollerCell = goutil.findChild(self.mainGO, "targetScrollercell")

	self._targetList = ScrollerList.create(targetScrollerView, targetScrollerCell, GameUtil.handler(self._updateTargetCell, self), GameUtil.handler(self._clearTargetCell, self))
end

function TargetColConView:onEnter()
	TargetColConView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdateData, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandStageOverRes, self._onUpdateData, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandRefreshShopRes, self._onUpdateData, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdateData, self)
	self:_onUpdateData()
end

function TargetColConView:onExit()
	TargetColConView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdateData, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandStageOverRes, self._onUpdateData, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandRefreshShopRes, self._onUpdateData, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdateData, self)
	self._targetList:dispose()
end

function TargetColConView:_updateTargetCell(view, cell, data, tag)
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

function TargetColConView:_clearTargetCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(iconGo)
end

function TargetColConView:_onUpdateTargetColData()
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

function TargetColConView:_onUpdateTargetScrollerList()
	self._targetList:reloadData(self._targetColDataList)
end

function TargetColConView:_onUpdateData()
	self:_onUpdateTargetColData()
	self:_onUpdateTargetScrollerList()
end

return TargetColConView
