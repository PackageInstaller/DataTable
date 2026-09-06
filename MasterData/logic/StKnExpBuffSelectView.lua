-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpBuffSelectView.lua

module("logic.extensions.stknexp.view.StKnExpBuffSelectView", package.seeall)

local StKnExpBuffSelectView = class("StKnExpBuffSelectView", ViewComponent)

function StKnExpBuffSelectView:buildUI()
	StKnExpBuffSelectView.super.buildUI(self)

	local buffScrView = self:getGo("buffCol/scrView")
	local buffScrCell = self:getGo("buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._txtTips = self:getTxt("txtTips")
end

function StKnExpBuffSelectView:bindEvents()
	StKnExpBuffSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function StKnExpBuffSelectView:unbindEvents()
	StKnExpBuffSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function StKnExpBuffSelectView:onEnter()
	StKnExpBuffSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	if self._zoneId <= 0 then
		printError("缺失传入参数")
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)
	self._zoneData = StKnExpConfig.instance:getZoneData(self._activityId, self._zoneId)
	self._maxBuffCount = self._subMo:getMaxBossBuffNum()
	self._selectBuffs = {}

	local buffList = self._subMo:getSelectBuffsInZone(self._zoneId)

	for i, v in ipairs(buffList) do
		self._selectBuffs[v] = v
	end

	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionUpgardeIslandRes, self._onUpdate, self)
	self:_onUpdate()
end

function StKnExpBuffSelectView:onExit()
	StKnExpBuffSelectView.super.onExit(self)
	self:_onClear()
end

function StKnExpBuffSelectView:_isFullBuff()
	local cur = self:_getCurSelectBuffCount()

	return cur >= self._maxBuffCount
end

function StKnExpBuffSelectView:_getCurSelectBuffCount()
	return (TableUtil.Count(self._selectBuffs, function(k, v)
		return not not v
	end, pairs))
end

function StKnExpBuffSelectView:_onUpdate()
	local cfg = StKnExpConfig.instance:getIslandBuffClientCfg(self._activityId) or {}

	self._buffScrollerList:reloadData(cfg)
	self:_updateTips()
end

function StKnExpBuffSelectView:_onClear()
	self._buffScrollerList:dispose()
end

function StKnExpBuffSelectView:_updateTips()
	local cur = self:_getCurSelectBuffCount()

	self._txtTips.text = string.format("可选：（%s/%s）", cur, self._maxBuffCount)
end

function StKnExpBuffSelectView:_updateBuffCell(view, cell, data, tag)
	local buffId = data.islandBuffId
	local skinId = data.skinId
	local isActive = self._subMo:isActiveBuff(buffId)
	local isSelected = self._selectBuffs[buffId]
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local selectTag = goutil.findChild(mainGo, "selectTag")
	local imgSelect = goutil.findChild(mainGo, "selectTag/imgSelect")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)

	txtDesc.text = data.buffDesc

	GameUtil.SetActive(tagLock, not isActive)
	GameUtil.SetActive(selectTag, isActive)
	GameUtil.SetActive(imgSelect, isSelected)

	local petName = CharacterConfig.instance:getPetName(skinId)
	local nameArrary = string.split(petName, "·")

	txtName.text = nameArrary[#nameArrary]

	GameUtil.addClickHandler(mainGo, function()
		if self._selectBuffs[buffId] then
			self._selectBuffs[buffId] = nil
		elseif not isActive then
			FloatWordMgr.instance:show("未激活")
		elseif self:_isFullBuff() then
			FloatWordMgr.instance:show("已达选择上限")
		else
			self._selectBuffs[buffId] = buffId
		end

		GameUtil.SetActive(imgSelect, self._selectBuffs[buffId])
		self:_updateTips()
	end)
end

function StKnExpBuffSelectView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(mainGo)
end

function StKnExpBuffSelectView:_onClickBtnClose()
	self:close()
end

function StKnExpBuffSelectView:_onClickBtnSure()
	local buffIdList = TableUtil.toList(self._selectBuffs)

	self._subMo:saveSelectBuffsInZone(self._zoneId, buffIdList)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightExpeditionBossBuffSelect)
	self:close()
end

return StKnExpBuffSelectView
