-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglifightView.lua

module("logic.extensions.mimengli.view.MimenglifightView", package.seeall)

local MimenglifightView = class("MimenglifightView", ViewComponent)

function MimenglifightView:ctor()
	MimenglifightView.super.ctor(self)
end

function MimenglifightView:unbindEvents()
	MimenglifightView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnFight)
end

function MimenglifightView:bindEvents()
	MimenglifightView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
end

function MimenglifightView:buildUI()
	MimenglifightView.super.buildUI(self)

	self._txtDesc = self:getTxt("info/txtDesc")
	self._prizeTableCell = self:getGo("info/prizeTableCell")
	self._prizeTableView = self:getGo("info/prizeTableView")
	self._imgPass = self:getGo("info/imgPass")
	self._btnBuff = self:getGo("btnBuff")
	self._btnFight = self:getGo("btnFight")
	self._txtProgress = self:getTxt("btnBuff/txtProgress")
	self._fmtCellList = {}

	for i = 1, 9 do
		local cell = self:getGo("info/teamEnemy/cell_" .. i)

		table.insert(self._fmtCellList, cell)
	end

	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeTableList:setCenterMode(true)
end

function MimenglifightView:onExit()
	MimenglifightView.super.onExit(self)
	self._prizeTableList:dispose()
end

function MimenglifightView:onEnter()
	MimenglifightView.super.onEnter(self)

	self._activityId = MiMengLiController.instance:getActivityId()

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	local param = self:getOpenParam() or {}

	self._stageId = checknumber(param[2])

	self:_onRefreshUI()
end

function MimenglifightView:_onRefreshUI()
	local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}

		if not clgInfo.curStageSelectedTagType then
			local curStageSelectedTagType = {}

			self._curPassStageId = checknumber(clgInfo.curPassStageId)
			self._historyPassStageId = checknumber(clgInfo.historyPassStageId)

			local cfg = MiMengLiConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}

			if not cfg.firstPassPrize then
				local firstPassPrize = ""
				local list = string.split(firstPassPrize, "#")

				self._prizeTableList:reloadData(list)

				if self._curPassStageId + 1 == self._stageId then
					GameUtil.SetGray(self._btnBuff, false)
					GameUtil.SetGray(self._btnFight, false)

					self._txtProgress.text = langPara("可选:%s/%s", #curStageSelectedTagType, checknumber(cfg.selectTagCount))
				else
					GameUtil.SetGray(self._btnBuff, true)
					GameUtil.SetGray(self._btnFight, true)

					self._txtProgress.text = langPara("可选:%s/%s", 0, checknumber(cfg.selectTagCount))
				end

				local creepsMasterId = checknumber(cfg.creepsMasterId)
				local creeps = MiMengLiConfig.instance:getCreepsById(creepsMasterId)

				self:_clearFmtInfo()

				for i, v in ipairs(creeps or {}) do
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

				GameUtil.SetActive(self._imgPass, self._stageId <= self._historyPassStageId)
			end
		end
	end
end

function MimenglifightView:_clearFmtInfo()
	for i, v in ipairs(self._fmtCellList) do
		MaterialMgr.resetAll(v)
	end
end

function MimenglifightView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function MimenglifightView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function MimenglifightView:_onClickBuff()
	if self._curPassStageId + 1 == self._stageId then
		UIStateManager.instance:push(ViewName.MimenglibuffView, self._activityId, self._stageId)
	else
		TipsFacade.instance:openCommonTips("当前关卡不可以选择")
	end
end

function MimenglifightView:_onClickFight(cell)
	if self._curPassStageId + 1 == self._stageId then
		MiMengLiController.instance:openNorFmtView(self._activityId, self._stageId)
	elseif self._curPassStageId + 1 > self._stageId then
		TipsFacade.instance:openCommonTips("当前关卡已通关")
	else
		TipsFacade.instance:openCommonTips("当前关卡暂时不可以挑战")
	end
end

return MimenglifightView
