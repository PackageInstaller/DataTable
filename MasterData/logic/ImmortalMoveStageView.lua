-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveStageView.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveStageView", package.seeall)

local ImmortalMoveStageView = class("ImmortalMoveStageView", ViewComponent)

function ImmortalMoveStageView:ctor()
	ImmortalMoveStageView.super.ctor(self)
end

function ImmortalMoveStageView:unbindEvents()
	ImmortalMoveStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, cell in ipairs(self._stageList) do
		GameUtil.rmClickHandler(cell.btnEnter)
	end
end

function ImmortalMoveStageView:bindEvents()
	ImmortalMoveStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, cell in ipairs(self._stageList) do
		GameUtil.addClickHandler(cell.btnEnter, GameUtil.handler(self._onClickFight, self, i))
	end
end

function ImmortalMoveStageView:buildUI()
	ImmortalMoveStageView.super.buildUI(self)

	self._powerPetMo = FightingPowerPetMo.New()
	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._stageList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("stage/cell" .. i)
		cell.fmtView = goutil.findChild(cell.go, "fmt/fmtView")
		cell.pass = goutil.findChild(cell.go, "pass")
		cell.btnEnter = goutil.findChild(cell.go, "btnEnter")
		self._stageList[i] = cell
	end
end

function ImmortalMoveStageView:onExit()
	ImmortalMoveStageView.super.onExit(self)

	for i, cell in ipairs(self._stageList) do
		local childCount = cell.fmtView.transform.childCount

		for posId = 1, childCount do
			local fmtCellGo = cell.fmtView.transform.transform:GetChild(posId - 1)
			local fmtIcon = goutil.findChild(fmtCellGo, "icon")

			MaterialMgr.resetAll(fmtIcon)
		end
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function ImmortalMoveStageView:onEnter()
	ImmortalMoveStageView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 494001
	end

	self.addGEvent(self, GlobalNotify.ImmortalMovementGetInfo, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	ImmortalMovementController.instance:getInfo(self._activityId)
end

function ImmortalMoveStageView:_updateUIByCfg()
	self._actCfg = ImmortalMovementConfig.instance:getActCfgById(self._activityId)

	local day = ImmortalMovementController.instance:getCurDay(self._activityId)

	self._stageCfgs = ImmortalMovementConfig.instance:getStageCfgs(self._activityId, day)
	self._curSkinId = self._actCfg.skinId
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)
end

function ImmortalMoveStageView:_updateUIByInfo()
	local info = ImmortalMovementModel.instance:getBaseInfo(self._activityId)

	self._todayPassStage = {}

	if not info then
		return
	end

	self._todayPassStage = info.todayPassStage or {}

	for i, cell in ipairs(self._stageList) do
		local isPass = table.indexof(self._todayPassStage, i)

		goutil.setActive(cell.pass, isPass)
		goutil.setActive(cell.btnEnter, not isPass)

		local stageCfg = self._stageCfgs[i]
		local childCount = cell.fmtView.transform.childCount

		for posId = 1, childCount do
			local fmtCellGo = cell.fmtView.transform.transform:GetChild(posId - 1)
			local fmtIcon = goutil.findChild(fmtCellGo, "icon")
			local note = goutil.findChild(fmtCellGo, "note")

			goutil.setActive(note, false)
			MaterialMgr.resetAll(fmtIcon)
		end

		if not stageCfg.notePosition then
			local notePositions = {}
			local creepsMasterId = stageCfg.creepsMasterId
			local creepCfgs = ImmortalMovementConfig.instance:getCreepCfgs(creepsMasterId) or {}

			for _, cfg in pairs(creepCfgs) do
				local posId = cfg.posId
				local creepsId = cfg.creepsId
				local isNote = table.indexof(notePositions, creepsId)

				if posId < 1 or posId > 9 then
					-- block empty
				else
					local fmtCellGo = cell.fmtView.transform:GetChild(posId - 1)

					if fmtCellGo then
						local fmtIcon = goutil.findChild(fmtCellGo, "icon")
						local note = goutil.findChild(fmtCellGo, "note")

						goutil.setActive(note, isNote)
						self._powerPetMo:fromChallengeCreepCo(cfg)

						local bagPetMo = self._powerPetMo:toBaseBagPetMo()
						local proxy = MaterialMgr.setCellByMo(bagPetMo, fmtIcon)

						if proxy then
							proxy.binder:setAutoTips(false)
							proxy:setCallBack(function()
								CommonTipsMgr.instance:showPetTips(bagPetMo)
							end)
						end
					end
				end
			end
		end
	end
end

function ImmortalMoveStageView:_onClickFight(stageId)
	ImmortalMovementController.instance:openMissionview(self._activityId, stageId)
end

return ImmortalMoveStageView
