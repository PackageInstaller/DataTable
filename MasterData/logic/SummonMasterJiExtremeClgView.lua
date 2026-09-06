-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiExtremeClgView.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiExtremeClgView", package.seeall)

local SummonMasterJiExtremeClgView = class("SummonMasterJiExtremeClgView", ViewComponent)

function SummonMasterJiExtremeClgView:ctor()
	SummonMasterJiExtremeClgView.super.ctor(self)
end

function SummonMasterJiExtremeClgView:buildUI()
	SummonMasterJiExtremeClgView.super.buildUI(self)

	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtSubTitle = self:getTxt("selectPanel/txtSubTitle")
	self._fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("fmtPanel/fmt/cell_%d", i))
		item.con = self:getGo(string.format("fmtPanel/fmt/cell_%d/con", i))

		table.insert(self._fmtList, item)
	end

	self._powerPetMo = FightingPowerPetMo.New()

	local pathPrefix = "selectPanel/level%d/"

	self._levelList = {}

	for i = 1, 3 do
		local element = {}

		element.btnList = {}

		for j = 1, 3 do
			local cell = {}

			cell.btn = self:getGo(string.format(pathPrefix .. "btn%d", i, j))
			cell.txtNum = self:getTxt(string.format(pathPrefix .. "btn%d/txt", i, j))
			cell.select = self:getGo(string.format(pathPrefix .. "btn%d/select", i, j))

			table.insert(element.btnList, cell)
		end

		element.txtScore = self:getTxt(string.format(pathPrefix .. "txtScore", i))
		element.txtDesc = self:getTxt(string.format(pathPrefix .. "txtDesc", i))

		table.insert(self._levelList, element)
	end

	self._txtTotalScore = self:getTxt("selectPanel/total/txtScore")
	self._txtPredictScore = self:getTxt("selectPanel/predict/txtScore")
end

function SummonMasterJiExtremeClgView:bindEvents()
	SummonMasterJiExtremeClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)

	for i, element in ipairs(self._levelList) do
		for j, cell in ipairs(element.btnList) do
			GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickSelectLevel, self, i, j))
		end
	end
end

function SummonMasterJiExtremeClgView:unbindEvents()
	SummonMasterJiExtremeClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)

	for i, element in ipairs(self._levelList) do
		for j, cell in ipairs(element.btnList) do
			GameUtil.rmClickHandler(cell.btn)
		end
	end
end

function SummonMasterJiExtremeClgView:onEnter()
	SummonMasterJiExtremeClgView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._cfgStage = SummonMasterJiConfig.instance:getExtremeStageCfg(self._activityId, self._stageId)
	self._scoreCfgList = SummonMasterJiConfig.instance:getExtremeStageScoreList(self._cfgStage.stageScorePlanId)
	self._txtTitle.text = self._cfgStage.name .. "之试炼"
	self._txtSubTitle.text = string.format("%s之试炼炼度", self._cfgStage.name)

	self:_initEnemyFmt()
	self:_initSelectPanel()
end

function SummonMasterJiExtremeClgView:onExit()
	SummonMasterJiExtremeClgView.super.onExit(self)
	self:_clearEnemyFmt()
end

function SummonMasterJiExtremeClgView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "summonmasterjiextremeclgview_rule")
end

function SummonMasterJiExtremeClgView:_onClickChallenge()
	local itemId2ScoreList = {}

	for itemId, element in ipairs(self._levelList) do
		local info = {}

		info.left = itemId
		info.right = checknumber(element.txtScore.text)

		table.insert(itemId2ScoreList, info)
	end

	ViewAutoShowController.instance:saveCurModalView()
	SummonMasterJiController.instance:openExtremeMissionView(self._activityId, self._stageId, itemId2ScoreList)
end

function SummonMasterJiExtremeClgView:_onClickSelectLevel(itemId, index)
	self:_updateSelectPanel(itemId, index)
end

function SummonMasterJiExtremeClgView:_initEnemyFmt()
	self:_clearEnemyFmt()

	if self._cfgStage then
		local cfgCreeps = SummonMasterJiConfig.instance:getCreeps(self._cfgStage.creepsMasterId)

		for i, cfgEnemy in ipairs(cfgCreeps) do
			local item = self._fmtList[cfgEnemy.posId]

			if item and item.go then
				goutil.setActive(item.go, true)
				GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)
				self._powerPetMo:fromChallengeCreepCo(cfgEnemy)

				local bagPetMo = self._powerPetMo:toBaseBagPetMo()
				local proxy = MaterialMgr.setCellByMo(bagPetMo, item.con)

				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(bagPetMo)
				end)
			end
		end
	end
end

function SummonMasterJiExtremeClgView:_clearEnemyFmt()
	for i, v in ipairs(self._fmtList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.go, false)
	end
end

function SummonMasterJiExtremeClgView:_initSelectPanel()
	local initIndexs = SummonMasterJiModel.instance:getScoreSelectPlan(self._activityId)

	self._selectIdList = {
		initIndexs[1],
		initIndexs[2],
		initIndexs[3]
	}
	self._predictScore = 0

	for i, element in ipairs(self._levelList) do
		for j, cell in ipairs(element.btnList) do
			cell.txtNum.text = self._scoreCfgList[i].difficultyScores[j]

			GameUtil.SetActive(cell.select, self._selectIdList[i] == j)
		end

		element.txtScore.text = self._scoreCfgList[i].difficultyScores[self._selectIdList[i]]

		local buffId = self._scoreCfgList[i].difficultyBuffs[self._selectIdList[i]]
		local cfgBuff = SummonMasterJiConfig.instance:getBuffCfg(buffId)

		element.txtDesc.text = cfgBuff.desc
	end

	self:_updateHistoryRecordScore()
	self:_updatePredictScore()
end

function SummonMasterJiExtremeClgView:_updateSelectPanel(itemId, index)
	self._selectIdList[itemId] = index

	for i, element in ipairs(self._levelList) do
		if i == itemId then
			for j, cell in ipairs(element.btnList) do
				GameUtil.SetActive(cell.select, index == j)
			end

			element.txtScore.text = self._scoreCfgList[itemId].difficultyScores[index]

			local buffId = self._scoreCfgList[itemId].difficultyBuffs[index]
			local cfgBuff = SummonMasterJiConfig.instance:getBuffCfg(buffId)

			element.txtDesc.text = cfgBuff.desc
		end
	end

	self:_updatePredictScore()
	SummonMasterJiModel.instance:saveScoreSelectPlan(self._activityId, self._selectIdList[1], self._selectIdList[2], self._selectIdList[3])
end

function SummonMasterJiExtremeClgView:_updatePredictScore()
	self._predictScore = 0

	for i, v in ipairs(self._selectIdList) do
		self._predictScore = self._predictScore + self._scoreCfgList[i].difficultyScores[v]
	end

	self._txtPredictScore.text = self._predictScore
end

function SummonMasterJiExtremeClgView:_updateHistoryRecordScore()
	self._txtTotalScore.text = SummonMasterJiModel.instance:getExtremeScoreByStageId(self._activityId, self._stageId)
end

return SummonMasterJiExtremeClgView
