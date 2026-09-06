-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleBossFmtExView.lua

module("logic.extensions.starbattle.view.StarBattleBossFmtExView", package.seeall)

local StarBattleBossFmtExView = class("StarBattleBossFmtExView", ViewComponent)

function StarBattleBossFmtExView:ctor()
	StarBattleBossFmtExView.super.ctor(self)
end

function StarBattleBossFmtExView:unbindEvents()
	StarBattleBossFmtExView.super.unbindEvents(self)
end

function StarBattleBossFmtExView:bindEvents()
	StarBattleBossFmtExView.super.bindEvents(self)
end

function StarBattleBossFmtExView:buildUI()
	StarBattleBossFmtExView.super.buildUI(self)

	self._txtTips = self:getTxt("txtTips")
	self._sortCells = {}

	for i = 1, 9 do
		local cell = {}

		cell.go = self:getGo("sorts/pos" .. i)
		cell.txtSort = goutil.findChildTextComponent(cell.go, "txt")
		cell.txtSort.text = i
		self._sortCells[i] = cell
	end
end

function StarBattleBossFmtExView:onExit()
	StarBattleBossFmtExView.super.onExit(self)
end

function StarBattleBossFmtExView:onEnter()
	StarBattleBossFmtExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self._txtTips.text = ""

	for i, cell in ipairs(self._sortCells) do
		goutil.setActive(cell.go, false)
	end

	if not self.customFmtMo then
		return
	end

	local activityId = self.customFmtMo.activityId
	local periodId = self.customFmtMo.periodId
	local bossId = self.customFmtMo.bossId
	local periodCfg = StarBattleConfig.instance:getPeriodCfg(activityId, periodId)
	local verRaceCfgs = StarBattleConfig.instance:getFormationRaceCfgs(periodCfg.formationRacePlanId) or {}
	local bossCfg = StarBattleConfig.instance:getBossCfgById(periodCfg.bossPlanId, bossId)
	local showSort = {}

	if bossCfg then
		showSort = bossCfg.showSort or {}
	end

	if #verRaceCfgs == 0 then
		-- block empty
	else
		local firstCfg = verRaceCfgs[1]
		local firstStr = string.format("加成：%s+%s%%", MaterialMgr.getMaterialsName(MatType.Pet, firstCfg.raceId), firstCfg.scorePercent)

		for i = 2, #verRaceCfgs do
			local cfg = verRaceCfgs[i]
			local str = string.format(",%s+%s%%", MaterialMgr.getMaterialsName(MatType.Pet, cfg.raceId), cfg.scorePercent)

			firstStr = firstStr .. str
		end

		self._txtTips.text = firstStr
	end

	if #showSort > 0 then
		for i, cell in ipairs(self._sortCells) do
			local num = checknumber(showSort[i])

			if num > 0 then
				goutil.setActive(cell.go, true)

				cell.txtSort.text = num
			else
				goutil.setActive(cell.go, false)
			end
		end
	end
end

return StarBattleBossFmtExView
