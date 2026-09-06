-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanClgrBuffView.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanClgrBuffView", package.seeall)

local DivineTianShanClgrBuffView = class("DivineTianShanClgrBuffView", ViewComponent)

function DivineTianShanClgrBuffView:ctor()
	DivineTianShanClgrBuffView.super.ctor(self)
end

function DivineTianShanClgrBuffView:unbindEvents()
	DivineTianShanClgrBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, cell in ipairs(self._zoneList) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function DivineTianShanClgrBuffView:bindEvents()
	DivineTianShanClgrBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, cell in ipairs(self._zoneList) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._switchZoneById, self, i))
	end
end

function DivineTianShanClgrBuffView:buildUI()
	DivineTianShanClgrBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local descTabGo = self:getGo("desc/buffTableview")
	local descItemGo = self:getGo("desc/cell")

	self._tableviewDesc = ScrollerList.create(descTabGo, descItemGo, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
	self._zoneList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("zones/zone_" .. i)
		cell.uiGroup = cell.go:GetComponent(typeof(UIChangeGroup))
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		cell.curSelectBuffId = 0
		self._zoneList[i] = cell
	end
end

function DivineTianShanClgrBuffView:onExit()
	DivineTianShanClgrBuffView.super.onExit(self)
	self._tableviewDesc:dispose()
end

function DivineTianShanClgrBuffView:onEnter()
	DivineTianShanClgrBuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	local stageId = checknumber(params[2])

	self._actCfg = DivineTianShanClgConfig.instance:getActCfgById(self._activityId)
	self._normalCfg = DivineTianShanClgConfig.instance:getNormalClgPlanCfg(self._actCfg.normalClgPlanId)
	self._stageCfgs = DivineTianShanClgConfig.instance:getNormalStagePlanCfgs(self._normalCfg.stagePlanId)
	self._stageInfoMap = DivineTianShanClgModel.instance:getNormalStageMap(self._activityId)

	for i, cell in ipairs(self._zoneList) do
		local cfg = self._stageCfgs[i]

		if cfg then
			cell.txt.text = cfg.stageName
		end
	end

	for i, stageInfo in pairs(self._stageInfoMap) do
		local hpRate = checknumber(stageInfo.leftHp) / checknumber(stageInfo.totalDamage)
		local curStageCfg = self._stageCfgs[i]
		local buffCfgs = DivineTianShanClgConfig.instance:getNormalBuffCfgs(curStageCfg.buffPlanId)
		local cell = self._zoneList[i]

		cell.txt.text = string.format("%s<color=#e23535ff>(%s%%)</color>", curStageCfg.stageName, Mathf.Ceil(hpRate * 100))
		cell.curSelectBuffId = 0

		for _, buffCfg in ipairs(buffCfgs) do
			if hpRate <= checknumber(buffCfg.leftHpRate) then
				cell.curSelectBuffId = buffCfg.buffId

				break
			end
		end
	end

	self:_switchZoneById(stageId)
end

function DivineTianShanClgrBuffView:_switchZoneById(zoneId)
	self._curZoneId = zoneId

	local curStageCfg = self._stageCfgs[self._curZoneId]
	local zoneBuffs = DivineTianShanClgConfig.instance:getNormalBuffCfgs(curStageCfg.buffPlanId) or {}
	local dataList = {}

	for i = #zoneBuffs, 1, -1 do
		table.insert(dataList, zoneBuffs[i])
	end

	self._tableviewDesc:reloadData(dataList)

	for i, cell in ipairs(self._zoneList) do
		cell.uiGroup:SetState(i == self._curZoneId and 1 or 0)
	end
end

function DivineTianShanClgrBuffView:_updateDescCell(view, cell, data)
	local select = goutil.findChild(cell.gameObject, "select")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtdesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtDesc.text = data.buffDesc
	txtNum.text = string.format("≤%s%%", checknumber(data.leftHpRate) * 100)

	goutil.setActive(select, data.buffId == self._zoneList[self._curZoneId].curSelectBuffId)
end

function DivineTianShanClgrBuffView:_clearDescCell(cell)
	return
end

return DivineTianShanClgrBuffView
