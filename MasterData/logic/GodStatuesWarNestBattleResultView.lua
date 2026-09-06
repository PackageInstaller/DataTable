-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarNestBattleResultView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarNestBattleResultView", package.seeall)

local GodStatuesWarNestBattleResultView = class("GodStatuesWarNestBattleResultView", ViewComponent)

function GodStatuesWarNestBattleResultView:buildUI()
	GodStatuesWarNestBattleResultView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtDamage = goutil.findChildTextComponent(self.mainGO, "txtDamage")
	self._txtEnergy = goutil.findChildTextComponent(self.mainGO, "txtEnergy")
	self._container = goutil.findChild(self.mainGO, "prizeCol/container")

	local prizeScrView = goutil.findChild(self.mainGO, "prizeCol/prizeScrView")
	local prizeScrCell = goutil.findChild(self.mainGO, "prizeCol/prizeScrCell")

	self._prizeScrCell = prizeScrCell
	self._prizeScrollList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function GodStatuesWarNestBattleResultView:bindEvents()
	GodStatuesWarNestBattleResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function GodStatuesWarNestBattleResultView:unbindEvents()
	GodStatuesWarNestBattleResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function GodStatuesWarNestBattleResultView:onEnter()
	GodStatuesWarNestBattleResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._nestPlanId = checknumber(params[2])
	self._nestId = checknumber(params[3])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self._resultMsg = GodStatuesWarController.instance:getNestResultMsg(self._seasonId)
	self._totalDamage = checknumber(self._resultMsg.totalDamage)
	self._nestData = GodStatuesWarConfig.instance:getNfbNestData(self._nestPlanId, self._nestId)
	self._prizeData = GodStatuesWarConfig.instance:getNfbDamagePrizeDataByDamage(self._nestData.damageScorePlan, self._totalDamage)
	self._txtDamage.text = self._totalDamage

	if self._prizeData then
		self._txtEnergy.text = self._prizeData.seasonScore or 0
	end

	self:_onUpdatePrizeColUI()
end

function GodStatuesWarNestBattleResultView:onExit()
	GodStatuesWarNestBattleResultView.super.onExit(self)
	self:_onClearPrizeCol()
end

function GodStatuesWarNestBattleResultView:_onUpdatePrizeColUI()
	local prizeList = {}

	if not string.nilorempty(self._prizeData and self._prizeData.showPrize) then
		prizeList = string.split(self._prizeData.showPrize, "#")
	end

	self:_clearPrizeContainer()

	if #prizeList > 5 then
		self._prizeScrollList:reloadData(prizeList)
	else
		self._prizeScrollList:reloadData({})

		for i, v in ipairs(prizeList) do
			local go = goutil.cloneAndSetParent(self._prizeScrCell, self._container.transform, "cell_" .. i)

			GameUtil.SetActive(go, true)
			MaterialMgr.setCellByCfg(v, go)
		end
	end
end

function GodStatuesWarNestBattleResultView:_clearPrizeContainer()
	local parent = self._container.transform
	local childCount = parent.childCount

	for i = 1, childCount do
		local trans = parent:GetChild(i - 1)

		MaterialMgr.resetAll(trans.gameObject)
	end

	goutil.clearChildren(self._container)
end

function GodStatuesWarNestBattleResultView:_onClearPrizeCol()
	self._prizeScrollList:dispose()
	self:_clearPrizeContainer()
end

function GodStatuesWarNestBattleResultView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GodStatuesWarNestBattleResultView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function GodStatuesWarNestBattleResultView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return GodStatuesWarNestBattleResultView
