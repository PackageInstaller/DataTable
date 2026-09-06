-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressResultView.lua

module("logic.extensions.divineempress.view.DivineEmpressResultView", package.seeall)

local DivineEmpressResultView = class("DivineEmpressResultView", ViewComponent)

function DivineEmpressResultView:ctor()
	DivineEmpressResultView.super.ctor(self)
end

function DivineEmpressResultView:unbindEvents()
	DivineEmpressResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineEmpressResultView:bindEvents()
	DivineEmpressResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function DivineEmpressResultView:buildUI()
	DivineEmpressResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tabelList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._imgChangeReachWin = self:getGo("imgReachWin"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgChangeReachScore = self:getGo("imgReachScore"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtScore = self:getTxt("txtScore")
	self._txtResult = self:getTxt("txtResult")
	self._txtEmpty = self:getTxt("txtEmpty")
	self._imgTitlePass = self:getGo("imgTitlePass")
	self._imgTitleFail = self:getGo("imgTitleFail")
end

function DivineEmpressResultView:onExit()
	DivineEmpressResultView.super.onExit(self)
end

function DivineEmpressResultView:onEnter()
	DivineEmpressResultView.super.onEnter(self)

	local resultInfo = DivineEmpressModel.instance:getTempBattleResult()

	self._activityId = resultInfo.activityId
	self._stageId = resultInfo.stageId

	local buffCfg = DivineEmpressConfig.instance:getBuffCfg(self._activityId, resultInfo.positiveBuffId)
	local debuffCfg = DivineEmpressConfig.instance:getBuffCfg(self._activityId, resultInfo.negativeBuffId)
	local scoreCfg = DivineEmpressController.instance:getScoreCfgByTotalScore(self._activityId, buffCfg.buffScore + debuffCfg.buffScore)

	self._txtScore.text = langPara("免疫次数：%d（%d/%d）", scoreCfg.immunityTimes, resultInfo.sumImmunityTimes, scoreCfg.immunityTimes)

	if resultInfo.isWin == true then
		self._imgChangeReachWin:SetState(0)
	else
		self._imgChangeReachWin:SetState(1)
	end

	if resultInfo.sumImmunityTimes >= scoreCfg.immunityTimes == true then
		self._imgChangeReachScore:SetState(0)
	else
		self._imgChangeReachScore:SetState(1)
	end

	self._isPass = resultInfo.isWin and resultInfo.isReachPassCondition
	self._maxScore = 0

	if resultInfo.extremeClgPetInfo then
		for i, v in ipairs(resultInfo.extremeClgPetInfo) do
			if self._maxScore < v.immunityTimes then
				self._maxScore = v.immunityTimes
			end
		end

		local list = {}

		for i, v in ipairs(resultInfo.extremeClgPetInfo) do
			table.insert(list, v)
		end

		list = ArraySort.sortOn(list, "immunityTimes", ArraySort.DESCENDING)

		self._tabelList:reloadData(list)
	end

	GameUtil.SetActive(self._tableview, self._isPass == true)
	GameUtil.SetActive(self._txtEmpty, not self._isPass)
	GameUtil.SetActive(self._imgTitlePass, self._isPass == true)
	GameUtil.SetActive(self._imgTitleFail, not self._isPass)
end

function DivineEmpressResultView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local blockGo = goutil.findChild(go, "block")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	GameUtil.SetActive(blockGo, data.immunityTimes == self._maxScore and self._isPass == true)

	txtScore.text = langPara("免疫：%d", data.immunityTimes)

	MaterialMgr.resetAll(con)
	MaterialMgr.setCell(MatType.Pet, data.raceId, con)
end

function DivineEmpressResultView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function DivineEmpressResultView:_onClickSure()
	DivineEmpressModel.instance:saveTempBattleResult(nil)
	self:close()

	local changeSetId = checknumber(DivineEmpressModel.instance:getTempChangeSetId())

	if changeSetId ~= 0 then
		UIStateManager.instance:popByName(ViewName.DivineEmpressExtreStageView)
		MaterialController.instance:showChangeSetInTemp(DivineEmpressModel.instance:getTempChangeSetId())
		DivineEmpressModel.instance:saveTempChangeSetId(nil)
	end
end

return DivineEmpressResultView
