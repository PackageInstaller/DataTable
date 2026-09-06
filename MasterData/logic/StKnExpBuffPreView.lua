-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpBuffPreView.lua

module("logic.extensions.stknexp.view.StKnExpBuffPreView", package.seeall)

local StKnExpBuffPreView = class("StKnExpBuffPreView", ViewComponent)

function StKnExpBuffPreView:buildUI()
	StKnExpBuffPreView.super.buildUI(self)

	local buffScrView = self:getGo("buffCol/scrView")
	local buffScrCell = self:getGo("buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
end

function StKnExpBuffPreView:bindEvents()
	StKnExpBuffPreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function StKnExpBuffPreView:unbindEvents()
	StKnExpBuffPreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function StKnExpBuffPreView:onEnter()
	StKnExpBuffPreView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)

	self:_onUpdate()
end

function StKnExpBuffPreView:onExit()
	StKnExpBuffPreView.super.onExit(self)
	self:_onClear()
end

function StKnExpBuffPreView:_onUpdate()
	local cfg = StKnExpConfig.instance:getIslandBuffClientCfg(self._activityId) or {}

	self._buffScrollerList:reloadData(cfg)
end

function StKnExpBuffPreView:_onClear()
	self._buffScrollerList:dispose()
end

function StKnExpBuffPreView:_updateBuffCell(view, cell, data, tag)
	local buffId = data.islandBuffId
	local skinId = data.skinId
	local isActive = self._subMo:isActiveBuff(buffId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)

	txtDesc.text = data.buffDesc

	GameUtil.SetActive(tagLock, not isActive)

	local petName = CharacterConfig.instance:getPetName(skinId)
	local nameArrary = string.split(petName, "·")

	txtName.text = nameArrary[#nameArrary]
end

function StKnExpBuffPreView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")

	MaterialMgr.clearIcon(icon)
end

function StKnExpBuffPreView:_onClickBtnClose()
	self:close()
end

function StKnExpBuffPreView:_onClickBtnSure()
	self:close()
end

return StKnExpBuffPreView
