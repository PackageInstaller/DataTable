-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhustageView.lua

module("logic.extensions.originlongzhu.view.OriginlongzhustageView", package.seeall)

local OriginlongzhustageView = class("OriginlongzhustageView", ViewComponent)

function OriginlongzhustageView:unbindEvents()
	OriginlongzhustageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginlongzhustageView:bindEvents()
	OriginlongzhustageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function OriginlongzhustageView:buildUI()
	OriginlongzhustageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnEnter = self:getGo("right/btnEnter")
	self._btnReset = self:getGo("right/btnReset")
	self._con = self:getGo("con")
	self._emptyBuff = self:getGo("right/emptyBuff")
	self._emptyTips = self:getGo("right/emptyTips")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtDesc = self:getTxt("right/txtDesc")
	self._txtTarget = self:getTxt("right/txtTarget")
	self._btnHelp = self:getGo("right/btnHelp")
	self._tablecell = self:getGo("right/tableview/tablecell")
	self._tableview = self:getGo("right/tableview")
	self._buffTableview = self:getGo("right/desc/buffTableview")
	self._cell = self:getGo("right/desc/cell")
	self._stagetableview = self:getGo("stagetableview")
	self._tablecell2 = self:getGo("stagetableview/tablecell")
	self._tableviewPet = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._tableviewPet:setCenterMode(true)

	self._tableviewDesc = ScrollerList.create(self._buffTableview, self._cell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
	self._tableviewStage = ScrollerList.create(self._stagetableview, self._tablecell2, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
end

function OriginlongzhustageView:onExit()
	OriginlongzhustageView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = nil

	self._tableviewPet:dispose()
	self._tableviewDesc:dispose()
	self._tableviewStage:dispose()
end

function OriginlongzhustageView:onEnter()
	OriginlongzhustageView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 573001
	end

	self.addGEvent(self, GlobalNotify.ORIGIN_LONGZHU_INFO_UPDATE, self._refreshUI, self)
	OriginLongzhuController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
	OriginLongzhuController.instance:showCI()
end

function OriginlongzhustageView:_refreshUI()
	self._actCfg = OriginLongzhuConfig.instance:getActCfgById(self._activityId) or {}
	self._txtDesc.text = self._actCfg.ruleDesc

	self:_updateUIByExtremeInfo()
end

function OriginlongzhustageView:_updateUIByExtremeInfo()
	local info = OriginLongzhuModel.instance:getInfo(self._activityId) or {}

	if not info.stageInfos then
		local stageInfos = {}

		self._curStageDataMap = {}
		self._lockRaceIdList = {}

		local total = 0

		for i, v in ipairs(stageInfos) do
			self._curStageDataMap[v.stageId] = v

			local buffScore = 0

			for _, ts in ipairs(v.typeScores or {}) do
				buffScore = buffScore + ts.right
			end

			total = total + checknumber(v.damageScore) + buffScore

			if not v.lockRaceIds then
				local races = {}

				for j, raceId in ipairs(races) do
					table.insert(self._lockRaceIdList, raceId)
				end
			end
		end

		self._totalAlivePetIds = #self._lockRaceIdList
		self._txtTarget.text = langPara("当前总分：%s\n排行榜历史最高：%s", total, checknumber(info.everMaxScore))

		local stageList = OriginLongzhuConfig.instance:getStageListCfgById(self._activityId) or {}
		local idx = OriginLongzhuController.instance:getLastIdx()
		local notPassIdx = -1

		for i, cfg in ipairs(stageList) do
			local data = self._curStageDataMap[cfg.stageId]

			if data == nil and notPassIdx < 0 then
				notPassIdx = i
			end
		end

		if idx > 0 then
			if self._curStageDataMap[idx] then
				if notPassIdx < 0 then
					notPassIdx = idx
				end
			else
				notPassIdx = idx
			end
		elseif notPassIdx < 0 then
			notPassIdx = 1
		end

		self._curSelectIdx = notPassIdx

		self._tableviewStage:reloadData(stageList)
		self._tableviewStage:MoveCellInView(notPassIdx - 1)
		OriginLongzhuController.instance:setLastIdx(notPassIdx)
		self:_updateRight()
	end
end

function OriginlongzhustageView:_updateRight()
	local stageList = OriginLongzhuConfig.instance:getStageListCfgById(self._activityId) or {}

	if not stageList[self._curSelectIdx] then
		local cfg = {}
		local skinId = checknumber(cfg.showSkinId)

		if skinId == 0 then
			local creeps = OriginLongzhuConfig.instance:getCreepsById(cfg.creepsMasterId) or {}

			for _, cc in pairs(creeps) do
				skinId = cc.raceId

				break
			end
		end

		if skinId > 0 then
			local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

			if not modelCfg[3] then
				local x, y, scale = modelCfg[1] or 0, modelCfg[2] or 0, 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)
			end
		end

		local info = self._curStageDataMap[cfg.stageId]
		local lockPetRaceIds = {}
		local typeScores = {}

		if info then
			lockPetRaceIds = info.lockRaceIds or {}
			typeScores = info.typeScores or {}
		end

		self._tableviewPet:reloadData(lockPetRaceIds)
		self._tableviewPet:MoveCellToBegin(0)
		self._tableviewDesc:reloadData(typeScores)
		goutil.setActive(self._emptyBuff, #typeScores <= 0)
		goutil.setActive(self._emptyTips, #lockPetRaceIds <= 0)
		goutil.setActive(self._btnEnter, not info)
		goutil.setActive(self._btnReset, info)
	end
end

function OriginlongzhustageView:_onClickEnter()
	local stageList = OriginLongzhuConfig.instance:getStageListCfgById(self._activityId) or {}
	local cfg = stageList[self._curSelectIdx]

	if cfg then
		OriginLongzhuController.instance:openFmtView(self._activityId, cfg.stageId, ViewName.OriginlongzhufmtexView, ViewName.OriginlongzhuresultView)
	end
end

function OriginlongzhustageView:_onClickReset()
	local stageList = OriginLongzhuConfig.instance:getStageListCfgById(self._activityId) or {}
	local cfg = stageList[self._curSelectIdx]

	if not self._curStageDataMap[cfg.stageId] then
		local info = {}
		local buffScore = 0

		for i, v in ipairs(info.typeScores or {}) do
			buffScore = buffScore + v.right
		end

		local content = langPara("本关积分为：%s，是否重置，清空积分，解锁行为", checknumber(info.damageScore) + buffScore)

		TipsFacade.instance:openPopupWindow("提示", content, function()
			if cfg then
				OriginLongzhuController.instance:sendResetFight(self._activityId, cfg.stageId)
			end
		end)
	end
end

function OriginlongzhustageView:_onClickBtnTip()
	local key = self._actCfg.ruleTip

	TipsFacade.instance:openRulesView(key)
end

function OriginlongzhustageView:_onClickSelect(scId)
	self._curSelectIdx = scId

	OriginLongzhuController.instance:setLastIdx(self._curSelectIdx)
	self:_updateRight()
	self._tableviewStage:refresh()
end

function OriginlongzhustageView:_updatePetCell(view, cell, raceId)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function OriginlongzhustageView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function OriginlongzhustageView:_updateDescCell(view, cell, data)
	local bg = goutil.findChild(cell.gameObject, "bg")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtdesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = data.right

	local cfg = OriginLongzhuConfig.instance:getScoreTypeCfgById(self._activityId, data.left) or {}

	txtDesc.text = cfg.desc
end

function OriginlongzhustageView:_clearDescCell(cell)
	return
end

function OriginlongzhustageView:_updateStageCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local pass = goutil.findChild(cell, "pass")
	local txtScore = goutil.findChildTextComponent(cell, "score/txt")
	local txtName = goutil.findChildTextComponent(cell, "name/txt")
	local txtBuff = goutil.findChildTextComponent(cell, "buff/txt")
	local skinId = checknumber(data.showSkinId)

	if skinId == 0 then
		local creeps = OriginLongzhuConfig.instance:getCreepsById(data.creepsMasterId) or {}

		for _, cc in pairs(creeps) do
			skinId = cc.raceId

			break
		end
	end

	MaterialMgr.setIcon(icon, MatType.PET_SKIN, skinId)

	local info = self._curStageDataMap[data.stageId]
	local buffScore = 0
	local damageScore = 0

	if info then
		for i, v in ipairs(info.typeScores or {}) do
			buffScore = buffScore + v.right
		end

		damageScore = checknumber(info.damageScore)
	end

	txtName.text = langPara("第%s关", data.stageId)
	txtBuff.text = langPara("行为积分：%s", buffScore)
	txtScore.text = langPara("伤害积分：%s", damageScore)

	GameUtil.SetActive(pass, info ~= nil)
	GameUtil.SetActive(select, cell.data == self._curSelectIdx)
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSelect, self, cell.data))
end

function OriginlongzhustageView:_clearStageCell(cell)
	return
end

function OriginlongzhustageView:_onClickHelp()
	UIStateManager.instance:push(ViewName.OriginlongzhubuffView, self._activityId)
end

return OriginlongzhustageView
