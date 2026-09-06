-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestBuffView.lua

module("logic.extensions.magiccontest.view.MagicContestBuffView", package.seeall)

local MagicContestBuffView = class("MagicContestBuffView", ViewComponent)

function MagicContestBuffView:ctor()
	MagicContestBuffView.super.ctor(self)
end

function MagicContestBuffView:buildUI()
	MagicContestBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtActiveTips = self:getTxt("txtActiveTips")
	self._strActiveTips = self._txtActiveTips.text

	local buffScrCell = self:getGo("buffCol/scrCell")
	local buffScrView = self:getGo("buffCol/scrView")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function MagicContestBuffView:bindEvents()
	MagicContestBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function MagicContestBuffView:unbindEvents()
	MagicContestBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MagicContestBuffView:onEnter()
	MagicContestBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._batType = checkint(params[2])
	self._subMo = MagicContestController.instance:getSubMo(self._activityId)
	self._myCampId = self._subMo:getCampId()
	self._buffMap = self._buffMap or OrderedMap.New()

	self._buffMap:clear()

	local buffIds = self._subMo:getCurSelectBuffs(self._batType)

	for _, buffId in pairs(buffIds) do
		self._buffMap:put(buffId, buffId)
	end

	self.addGEvent(self, GlobalNotify.HandlePM_MagicContestSelectBuffRes, self._handlePM_MagicContestSelectBuffRes, self)
	self:_onUpdate()
end

function MagicContestBuffView:onExit()
	MagicContestBuffView.super.onExit(self)
	self:_onClearBuffCol()
end

function MagicContestBuffView:_handlePM_MagicContestSelectBuffRes(status)
	self:close()
end

function MagicContestBuffView:_onUpdate()
	self:_onUpdateBuffColUI()

	local cur = self._buffMap:count()
	local max = self._subMo:getMaxBuffCount()

	self._txtActiveTips.text = string.format(self._strActiveTips, cur, max)
end

function MagicContestBuffView:_onUpdateBuffColUI()
	local cfg = MagicSchoolConfig.instance:getBuffCfgsByCampId(self._activityId, self._myCampId) or {}
	local dataList = {}

	for i, v in ipairs(cfg) do
		if v.unlockLv <= self._subMo:getLevel() then
			table.insert(dataList, v)
		end
	end

	self._buffScrollerList:reloadData(dataList)
end

function MagicContestBuffView:_onClearBuffCol()
	self._buffScrollerList:dispose()
end

function MagicContestBuffView:_updateBuffCell(view, cell, data, tag)
	local buffId = data.buffId
	local isSelect = self._buffMap:has(buffId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local iconTagSelect = goutil.findChild(mainGo, "tagSelect/icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtLv = goutil.findChildTextComponent(mainGo, "txtLv")
	local txtDesc = goutil.findChildTextComponent(mainGo, "desc/viewport/content")

	txtName.text = data.name
	txtDesc.text = data.desc

	GameUtil.SetActive(iconTagSelect, isSelect)

	local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)
	GameUtil.addClickHandler(mainGo, function()
		if self._buffMap:has(buffId) then
			self._buffMap:remove(buffId)
			self:_onUpdate()
		else
			local max = self._subMo:getMaxBuffCount()
			local isFull = max < self._buffMap:count() + 1

			if isFull and max == 1 then
				self._buffMap:popFront()
			end

			if max >= self._buffMap:count() + 1 then
				self._buffMap:put(buffId, buffId)
				self:_onUpdate()
			else
				FloatWordMgr.instance:show("buff数量已达上限")
			end
		end
	end)
end

function MagicContestBuffView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
end

function MagicContestBuffView:_onClickClose()
	local cur = self._buffMap:count()
	local max = self._subMo:getMaxBuffCount()

	if max <= 0 then
		self:close()

		return
	end

	if max > 0 and cur <= 0 then
		FloatWordMgr.instance:show("请选择buff")

		return
	end

	local buffIds = self._buffMap:keyList()

	MagicContestController.instance:sendPM_MagicContestSelectBuffReq(self._activityId, self._batType, buffIds)
end

return MagicContestBuffView
