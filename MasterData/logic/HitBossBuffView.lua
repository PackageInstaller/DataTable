-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/view/HitBossBuffView.lua

module("logic.extensions.hitboss.view.HitBossBuffView", package.seeall)

local HitBossBuffView = class("HitBossBuffView", ViewComponent)

function HitBossBuffView:buildUI()
	HitBossBuffView.super.buildUI(self)

	local scrView = goutil.findChild(self.mainGO, "buffCol/scrView")
	local scrCell = goutil.findChild(self.mainGO, "buffCol/scrCell")

	self._buffScrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
end

function HitBossBuffView:bindEvents()
	HitBossBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function HitBossBuffView:unbindEvents()
	HitBossBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function HitBossBuffView:onEnter()
	HitBossBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curDay = 0

	self.addGEvent(self, GlobalNotify.WuDiClgNotifyNormalFightResultRes, self._onUpdate, self)
	self:_onUpdate()
end

function HitBossBuffView:onExit()
	HitBossBuffView.super.onExit(self)
	self:_onClear()
end

function HitBossBuffView:_onUpdate()
	self._curDay = HitbossController.instance:getTotalDay(self._activityId)

	local cfg = HitbossConfig.instance:getDailyBuffCfgs(self._activityId)

	self._buffScrollList:reloadData(cfg)

	local index = 1

	for idx, data in ipairs(cfg) do
		if data.day == self._curDay then
			index = idx

			break
		end
	end

	self._buffScrollList:MoveCellToCenter(index - 1)
end

function HitBossBuffView:_onClear()
	self._buffScrollList:dispose()
end

function HitBossBuffView:_updateBuffCell(view, cell, data, tag)
	local isSelected = self._curDay == data.day
	local mainGo = cell.gameObject
	local select = goutil.findChild(mainGo, "select")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	GameUtil.SetActive(select, isSelected)

	txtName.text = string.format("第%s天", data.day)
	txtDesc.text = data.des
end

function HitBossBuffView:_clearBuffCell(cell)
	return
end

return HitBossBuffView
