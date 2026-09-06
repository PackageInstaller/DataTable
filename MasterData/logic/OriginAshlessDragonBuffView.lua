-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonBuffView.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonBuffView", package.seeall)

local OriginAshlessDragonBuffView = class("OriginAshlessDragonBuffView", ViewComponent)

function OriginAshlessDragonBuffView:buildUI()
	OriginAshlessDragonBuffView.super.buildUI(self)

	local descScrView = self:getGo("descScrView")
	local descScrCell = self:getGo("descScrCell")

	self._descScrollerList = ScrollerList.create(descScrView, descScrCell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
	self._customInput = UICustomInput.Get(self.mainGO)
end

function OriginAshlessDragonBuffView:bindEvents()
	OriginAshlessDragonBuffView.super.bindEvents(self)
	self._customInput:AddListener(function(self, hover)
		if not hover then
			self:close()
		end
	end, self)
end

function OriginAshlessDragonBuffView:unbindEvents()
	OriginAshlessDragonBuffView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function OriginAshlessDragonBuffView:onEnter()
	OriginAshlessDragonBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = OriginAshlessDragonController.instance:getSubMo(self._activityId)

	self:_onUpdateUI()
end

function OriginAshlessDragonBuffView:onExit()
	OriginAshlessDragonBuffView.super.onExit(self)
	self._descScrollerList:dispose()
end

function OriginAshlessDragonBuffView:_onUpdateUI()
	local datas = OriginAshlessDragonConfig.instance:getDebuffDatas(self._activityId)
	local dataList = {}

	for _, data in pairs(datas) do
		table.insert(dataList, data)
	end

	ArraySort.sortOn(dataList, "risk", ArraySort.NUMERIC)

	local risk = self._subMo:getTotalRisk()
	local debuffData = OriginAshlessDragonConfig.instance:getDebuffDataByRisk(self._activityId, risk)

	if debuffData then
		self._curActiveRisk = debuffData.risk or 0
	end

	self._descScrollerList:reloadData(dataList)

	local index = 0

	for i, data in ipairs(dataList) do
		if data.risk == self._curActiveRisk then
			index = i - 1

			break
		end
	end

	self._descScrollerList:MoveCellToCenter(index)
end

function OriginAshlessDragonBuffView:_updateDescCell(view, cell, data, tag)
	local index = cell.data
	local isActive = self._curActiveRisk == data.risk
	local mainGo = cell.gameObject
	local bg = goutil.findChild(mainGo, "bg")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	if isActive then
		txtScore.text = string.format("<color=#20b376>%s</color>", data.risk)
		txtDesc.text = string.format("<color=#20b376>%s</color>", data.desc)
	else
		txtScore.text = data.risk
		txtDesc.text = data.desc
	end

	GameUtil.SetActive(bg, index % 2 == 0)
end

function OriginAshlessDragonBuffView:_clearDescCell(cellGo)
	return
end

return OriginAshlessDragonBuffView
