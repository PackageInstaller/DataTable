-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglibossView.lua

module("logic.extensions.mimengli.view.MimenglibossView", package.seeall)

local MimenglibossView = class("MimenglibossView", ViewComponent)

function MimenglibossView:ctor()
	MimenglibossView.super.ctor(self)
end

function MimenglibossView:unbindEvents()
	MimenglibossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFight)
end

function MimenglibossView:bindEvents()
	MimenglibossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
end

function MimenglibossView:buildUI()
	MimenglibossView.super.buildUI(self)

	self._txtDesc = self:getTxt("info/txtDesc")
	self._prizeTableCell = self:getGo("info/prizeTableCell")
	self._prizeTableView = self:getGo("info/prizeTableView")
	self._imgPass = self:getGo("info/imgPass")
	self._btnFight = self:getGo("btnFight")
	self._con = self:getGo("con")
	self._fmtCellList = {}

	for i = 1, 9 do
		local cell = self:getGo("info/teamEnemy/cell_" .. i)

		table.insert(self._fmtCellList, cell)
	end

	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeTableList:setCenterMode(true)
end

function MimenglibossView:onExit()
	MimenglibossView.super.onExit(self)
	self._prizeTableList:dispose()

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = nil
end

function MimenglibossView:onEnter()
	MimenglibossView.super.onEnter(self)

	self._activityId = MiMengLiController.instance:getActivityId()

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	local param = self:getOpenParam() or {}

	self._stageId = checknumber(param[2])

	self:_onRefreshUI()
end

function MimenglibossView:_onRefreshUI()
	self._actCfg = MiMengLiConfig.instance:getActivityCfgById(self._activityId) or {}

	local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}

		if not clgInfo.curStageSelectedTagType then
			self._curPassStageId = checknumber(clgInfo.curPassStageId)

			local cfg = MiMengLiConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}

			if not cfg.firstPassPrize then
				local firstPassPrize = ""
				local list = string.split(firstPassPrize, "#")

				self._prizeTableList:reloadData(list)

				local creepsMasterId = checknumber(cfg.creepsMasterId)
				local creeps = MiMengLiConfig.instance:getCreepsById(creepsMasterId)

				self:_clearFmtInfo()

				for i, v in ipairs(creeps) do
					local con = self._fmtCellList[v.posId]

					if con then
						GameUtil.setLocalScale(con, 0.8, 0.8, 0.8)

						local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, con)

						if proxy then
							proxy.binder:setAutoTips(false)
						end
					end
				end

				local enemyCfg = MiMengLiConfig.instance:getMonsterCfgById(creepsMasterId)

				self._txtDesc.text = enemyCfg.ruleDesc

				GameUtil.SetActive(self._imgPass, self._stageId <= self._curPassStageId)

				local skinId = checknumber(self._actCfg.skinId)

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
			end
		end
	end
end

function MimenglibossView:_clearFmtInfo()
	for i, v in ipairs(self._fmtCellList) do
		MaterialMgr.resetAll(v)
	end
end

function MimenglibossView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function MimenglibossView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function MimenglibossView:_onClickFight(cell)
	if self._curPassStageId + 1 == self._stageId then
		MiMengLiController.instance:openBossFmtView(self._activityId, self._stageId)
	elseif self._curPassStageId + 1 > self._stageId then
		TipsFacade.instance:openCommonTips("当前关卡已通关")
	else
		TipsFacade.instance:openCommonTips("当前关卡暂时不可以挑战")
	end
end

return MimenglibossView
