-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvBuffDetailView.lua

module("logic.extensions.domainadventure.view.DomAdvBuffDetailView", package.seeall)

local DomAdvBuffDetailView = class("DomAdvBuffDetailView", ViewComponent)
local _curBuffId = 0

function DomAdvBuffDetailView:ctor()
	DomAdvBuffDetailView.super.ctor(self)
end

function DomAdvBuffDetailView:buildUI()
	DomAdvBuffDetailView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtBuffDesc = goutil.findChildTextComponent(self.mainGO, "descCol/txtBuffDesc")
	self._btnJump = goutil.findChild(self.mainGO, "descCol/btnJump")
	self._buffIcon = goutil.findChild(self.mainGO, "descCol/buffIcon")

	local buffScrView = goutil.findChild(self.mainGO, "buffCol/scrView")
	local buffScrCell = goutil.findChild(self.mainGO, "buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))

	self._buffScrollerList:setCenterMode(true)
end

function DomAdvBuffDetailView:bindEvents()
	DomAdvBuffDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickBtnJump, self)
end

function DomAdvBuffDetailView:unbindEvents()
	DomAdvBuffDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump)
end

function DomAdvBuffDetailView:onEnter()
	DomAdvBuffDetailView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = DomainAdventureController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._scene = SceneMgr.instance:getCurScene()
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._buffCfg = DomainAdventureConfig.instance:getBuffCfg(self._activityId) or {}

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function DomAdvBuffDetailView:onExit()
	DomAdvBuffDetailView.super.onExit(self)
	self._buffScrollerList:dispose()
	uGuiUtil.clearImage(self._buffIcon)
end

function DomAdvBuffDetailView:_onSetUI()
	return
end

function DomAdvBuffDetailView:_onUpdate()
	if _curBuffId <= 0 then
		for _, data in ipairs(self._buffCfg) do
			_curBuffId = data.buffId

			local gridState = self._scene:getGridState(data.blockId)

			if not gridState:isOccupied() then
				break
			end
		end
	end

	local buffData = DomainAdventureConfig.instance:getBuffData(self._activityId, _curBuffId)

	self._buffScrollerList:reloadData(self._buffCfg)

	if buffData then
		self._txtBuffDesc.text = buffData.buffDesc or "无"
	end

	GameUtil.SetActive(self._btnJump, buffData ~= nil)

	if buffData then
		local path = string.format("%s.png", buffData.iconPath)

		uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, path, nil)
	else
		uGuiUtil.clearImage(self._buffIcon)
	end
end

function DomAdvBuffDetailView:_updateBuffCell(view, cell, data, tag)
	local buffId = data.buffId
	local blockId = data.blockId
	local gridState = self._scene:getGridState(blockId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local imgLock = goutil.findChild(mainGo, "imgLock")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.name

	GameUtil.SetActive(imgLock, not gridState:isOccupied())
	GameUtil.SetActive(imgSelected, _curBuffId == buffId)

	local path = string.format("%s.png", data.iconPath)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, path, nil)
	GameUtil.addClickHandler(mainGo, function()
		_curBuffId = buffId

		self:_onUpdate()
	end)
end

function DomAdvBuffDetailView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function DomAdvBuffDetailView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(key)
end

function DomAdvBuffDetailView:_onClickBtnJump()
	local buffData = DomainAdventureConfig.instance:getBuffData(self._activityId, _curBuffId)

	if buffData == nil then
		return
	end

	self:close()

	local blockId = buffData.blockId

	GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneFocusToGrid, blockId, true)
end

return DomAdvBuffDetailView
