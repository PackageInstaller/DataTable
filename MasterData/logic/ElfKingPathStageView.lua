-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/view/ElfKingPathStageView.lua

module("logic.extensions.elfkingpath.view.ElfKingPathStageView", package.seeall)

local ElfKingPathStageView = class("ElfKingPathStageView", ViewComponent)

function ElfKingPathStageView:ctor()
	ElfKingPathStageView.super.ctor(self)
end

function ElfKingPathStageView:unbindEvents()
	ElfKingPathStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEnter)

	for i, v in pairs(self._switchCells) do
		GameUtil.rmClickHandler(v.go)
	end
end

function ElfKingPathStageView:bindEvents()
	ElfKingPathStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)

	for i, v in pairs(self._switchCells) do
		GameUtil.addClickHandler(v.go, function()
			self:_onSwithSonStageId(i)
		end, self)
	end
end

function ElfKingPathStageView:buildUI()
	ElfKingPathStageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnEnter = self:getGo("btnEnter")
	self._txtName = self:getTxt("txtName")
	self._txtDesc = self:getTxt("txtDesc")
	self._powerPetMo = FightingPowerPetMo.New()
	self._fmtCellList = {}
	self._fmtView = self:getGo("fmt/fmtView")

	for posId = 1, self._fmtView.transform.childCount do
		local cell = {}

		cell.go = self._fmtView.transform:GetChild(posId - 1).gameObject
		cell.icon = goutil.findChild(cell.go, "icon")

		table.insert(self._fmtCellList, cell)
	end

	self._txtRule = self:getTxt("rule/Viewport/txt")
	self._passFmt = self:getGo("fmt/pass")
	self._switchCells = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("switchs/stage" .. i)
		cell.bg = goutil.findChild(cell.go, "bg")
		cell.select = goutil.findChild(cell.go, "select")
		cell.lock = goutil.findChild(cell.go, "lock")

		table.insert(self._switchCells, cell)
	end
end

function ElfKingPathStageView:onExit()
	ElfKingPathStageView.super.onExit(self)

	for i, v in pairs(self._fmtCellList) do
		MaterialMgr.resetAll(v.icon)
	end
end

function ElfKingPathStageView:onEnter()
	ElfKingPathStageView.super.onEnter(self)

	self._enterStageId = 1

	local params = self:getOpenParam()

	if params then
		self._enterStageId = checknumber(params[1])
	end

	self._curStageCfg = ElfKingPathConfig.instance:getStageCfg(self._enterStageId)
	self._curSonStageCfgs = ElfKingPathConfig.instance:getSonStageCfgsByStageId(self._enterStageId)

	for i, v in ipairs(self._switchCells) do
		local cfg = self._curSonStageCfgs[i]

		if cfg then
			goutil.setActive(v.go, true)
		else
			goutil.setActive(v.go, false)
		end
	end

	self:_updateUI()
	GuideController.instance:setViewVar("elf_king_path_battle", nil)

	for i, v in ipairs(self._curSonStageCfgs) do
		if not v.battleGuideId then
			local gid = 0

			if checknumber(gid) > 0 then
				ElfKingPathController.instance:processGuideData(gid, false)
			end
		end
	end
end

function ElfKingPathStageView:_updateUI()
	self._isPassAll = false
	self._curPassMaxStageId = 0

	local curInfo = ElfKingPathModel.instance:getCurInfo()

	if curInfo then
		for i, v in ipairs(curInfo.stageInfos) do
			if v.stageId == self._enterStageId then
				self._curPassMaxStageId = v.maxPassSonStageId

				break
			end
		end
	end

	self._isPassAll = self._curPassMaxStageId >= #self._curSonStageCfgs

	if self._isPassAll then
		self:_onSwithSonStageId(1)
	else
		self:_onSwithSonStageId(self._curPassMaxStageId + 1)
	end
end

function ElfKingPathStageView:_switchCurSonStage()
	local cfg = self._curSonStageCfgs[self._curSonStageId]

	goutil.setActive(self._btnEnter, self._curPassMaxStageId + 1 >= self._curSonStageId)

	local creepsMasterId = cfg.creepsMasterId
	local creepCfgs = ElfKingPathConfig.instance:getCreepCfgs(creepsMasterId)

	for i = 1, #self._fmtCellList do
		MaterialMgr.resetAll(self._fmtCellList[i].icon)
	end

	for i, v in ipairs(self._fmtCellList) do
		local creepCfg = creepCfgs[i]

		if creepCfg then
			local cell = self._fmtCellList[creepCfg.posId]

			if cell then
				self._powerPetMo:fromChallengeCreepCo(creepCfg)

				local bagPetMo = self._powerPetMo:toBaseBagPetMo()
				local proxy = MaterialMgr.setCellByMo(bagPetMo, cell.icon)

				if proxy then
					proxy.binder:setAutoTips(false)
					proxy:setCallBack(function()
						CommonTipsMgr.instance:showPetTips(bagPetMo)
					end)
				end
			end
		end
	end

	self._txtName.text = cfg.sonStageName or ""
	self._txtRule.text = cfg.showRule or ""

	GameUtil.setAnchoredPos(self._txtRule.gameObject, 0, 0)
	goutil.setActive(self._passFmt, self._curPassMaxStageId >= self._curSonStageId)

	for i, v in ipairs(self._switchCells) do
		if i <= self._curPassMaxStageId then
			GameUtil.setUIImageSpriteIdx(v.bg, 0)
		else
			GameUtil.setUIImageSpriteIdx(v.bg, 1)
		end

		goutil.setActive(v.select, i == self._curSonStageId)
		goutil.setActive(v.lock, i > self._curPassMaxStageId + 1)
	end
end

function ElfKingPathStageView:_onSwithSonStageId(sonStageId)
	if sonStageId < 1 or sonStageId > #self._curSonStageCfgs then
		return
	end

	if sonStageId > self._curPassMaxStageId + 1 then
		TipsFacade.instance:openCommonTips("关卡未解锁,请先通关前置关卡")

		return
	end

	self._curSonStageId = sonStageId

	self:_switchCurSonStage()
end

function ElfKingPathStageView:_onClickEnter()
	ViewAutoShowController.instance:saveCurModalView()
	ElfKingPathController.instance:showBossMissionView(self._enterStageId, self._curSonStageId)
end

return ElfKingPathStageView
