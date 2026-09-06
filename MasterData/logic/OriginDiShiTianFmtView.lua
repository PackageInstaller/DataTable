-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/view/OriginDiShiTianFmtView.lua

module("logic.extensions.origindishitian.view.OriginDiShiTianFmtView", package.seeall)

local OriginDiShiTianFmtView = class("OriginDiShiTianFmtView", ViewComponent)

function OriginDiShiTianFmtView:ctor()
	OriginDiShiTianFmtView.super.ctor(self)
end

function OriginDiShiTianFmtView:unbindEvents()
	OriginDiShiTianFmtView.super.unbindEvents(self)
end

function OriginDiShiTianFmtView:bindEvents()
	OriginDiShiTianFmtView.super.bindEvents(self)
end

function OriginDiShiTianFmtView:buildUI()
	OriginDiShiTianFmtView.super.buildUI(self)

	self._fmtBuffCount = self:getGo("fmtCount")
	self._fmtBuffCountMap = {}

	for i = 1, 9 do
		local cell = {}

		cell.posGo = goutil.findChild(self._fmtBuffCount, "pos_" .. i)

		local buffCell = {}

		for j = 1, 3 do
			local buff = goutil.findChildComponent(cell.posGo, "buff" .. j, ComponentType.UIImageSpriteChange)

			buffCell[j] = buff

			GameUtil.SetActive(buff, false)
		end

		cell.buffCell = buffCell
		self._fmtBuffCountMap[i] = cell
	end
end

function OriginDiShiTianFmtView:onExit()
	OriginDiShiTianFmtView.super.onExit(self)
end

function OriginDiShiTianFmtView:onEnter()
	OriginDiShiTianFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	local stageCfg = OriginDiShiTianConfig.instance:getStageCfg(self._fmtMo.activityId, self._fmtMo.stageId)
	local creepsCfg = OriginDiShiTianConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

	for i = 1, 9 do
		GameUtil.SetActive(self._fmtBuffCountMap[i].posGo, false)

		for j = 1, 3 do
			GameUtil.SetActive(self._fmtBuffCountMap[i].buffCell[j], false)
		end
	end

	for i, v in ipairs(creepsCfg) do
		local enemyCell = self._fmtBuffCountMap[v.posId]

		if enemyCell then
			GameUtil.SetActive(enemyCell.posGo, true)
		end
	end

	local buffList = {}
	local redBuffPlanCfgs = OriginDiShiTianConfig.instance:getBuffPlan(stageCfg.buffPlanId, 1)

	for i, v in ipairs(redBuffPlanCfgs) do
		local enemyCell = self._fmtBuffCountMap[v.pos]

		if enemyCell then
			buffList[v.pos] = buffList[v.pos] or {}

			for j = 1, v.count do
				table.insert(buffList[v.pos], 1)
			end
		end
	end

	local blueBuffPlanCfg = OriginDiShiTianConfig.instance:getBuffPlan(stageCfg.buffPlanId, 2)

	for i, v in ipairs(blueBuffPlanCfg) do
		local enemyCell = self._fmtBuffCountMap[v.pos]

		if enemyCell then
			buffList[v.pos] = buffList[v.pos] or {}

			for j = 1, v.count do
				table.insert(buffList[v.pos], 2)
			end
		end
	end

	for pos, list in pairs(buffList) do
		for i, v in ipairs(list) do
			GameUtil.SetActive(self._fmtBuffCountMap[pos].buffCell[i], true)

			if self._fmtBuffCountMap[pos].buffCell[i] then
				self._fmtBuffCountMap[pos].buffCell[i]:SetState(v - 1)
			end
		end
	end
end

return OriginDiShiTianFmtView
