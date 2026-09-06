-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiChallengeView.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiChallengeView", package.seeall)

local MississiChallengeView = class("MississiChallengeView", ViewComponent)

function MississiChallengeView:buildUI()
	MississiChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._goTableView = self:getGo("level/tableview")
	self._goCell = self:getGo("level/cell")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTip = self:getTxt("progress/txtTip")
	self._txtTip2 = self:getGo("progress/txtTip2")
	self._missionCells = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("mission/mission_" .. i)
		cell.markPass = goutil.findChild(cell.go, "pass")
		cell.markFail = goutil.findChild(cell.go, "fail")
		cell.petNum = goutil.findChild(cell.go, "petNum")
		cell.txtPetNum = goutil.findChildTextComponent(cell.petNum, "txtPetNum")
		cell.btnChallenge = goutil.findChild(cell.go, "btnChallenge")
		cell.petCells = {}

		for k = 1, 9 do
			local petCell = {}

			petCell.go = goutil.findChild(cell.btnChallenge, "cell_" .. k)
			petCell.con = goutil.findChild(petCell.go, "con")
			cell.petCells[k] = petCell
		end

		self._missionCells[i] = cell
	end

	self._passTip = self:getGo("passTip")
	self._passTxtTip = goutil.findChildTextComponent(self._passTip, "txtTip")
end

function MississiChallengeView:bindEvents()
	MississiChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self.onClickTip, self)
	GameUtil.addClickHandler(self._passTip, self.onClickPassTip, self)

	for i = 1, 3 do
		GameUtil.addClickHandler(self._missionCells[i].btnChallenge, GameUtil.handler(self._startChallenge, self, i))
	end
end

function MississiChallengeView:unbindEvents()
	MississiChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._passTip)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._missionCells[i].btnChallenge)
	end
end

function MississiChallengeView:onEnter()
	MississiChallengeView.super.onEnter(self)
	self:setShowTipsKey()

	self._actId = MississiModel.instance:getActId()

	MississiModel.instance:showCI()

	if self._actId > 0 then
		self._stageCfgs = MississiConfig.instance:getStageCfgs(self._actId)

		self:_updateViewByInfo()
	end
end

function MississiChallengeView:setShowTipsKey()
	self.LANG_TIPS_1 = "存活女性精灵：%s只"
	self.LANG_TIPS_2 = "累计存活女性精灵："
end

function MississiChallengeView:onExit()
	MississiChallengeView.super.onExit(self)
	MississiModel.instance:resetBattleInfo()
	self._tableView:dispose()

	for i = 1, 3 do
		for k = 1, 9 do
			MaterialMgr.resetAll(self._missionCells[i].petCells[k].con)
		end
	end
end

function MississiChallengeView:_updateViewByInfo()
	self._curPassStage = MississiModel.instance:getCurPassStage(self._actId)
	self._curSelectId = nil
	self._isAllPass = self._curPassStage >= #self._stageCfgs

	if self._isAllPass then
		self._showStage = #self._stageCfgs or self._curPassStage + 1
	end

	self:_updateView(self._showStage)
	goutil.setActive(self._passTip, MississiModel.instance:getIsPassCurStage())
end

function MississiChallengeView:_updateView(stageId)
	if stageId > self._showStage then
		FloatWordMgr.instance:show(lang("请先通关当前关卡"))

		return
	end

	if self._curSelectId ~= stageId then
		self._curSelectId = stageId

		self._tableView:reloadData(self:_getCurDataList())
		self:_updateRightPart()
	end
end

function MississiChallengeView:_getCurDataList()
	return self._stageCfgs
end

function MississiChallengeView:_startChallenge(teamId)
	local nextStageId = self._curPassStage + 1

	if nextStageId < self._curSelectId then
		FloatWordMgr.instance:show(lang("请通关前置关卡"))
	elseif nextStageId > self._curSelectId then
		FloatWordMgr.instance:show(lang("已通关当前关卡"))
	else
		local teamCfg = MississiConfig.instance:getTeamCfg(self._actId, self._curSelectId, teamId)
		local mainViewName = self:getFightEndMianViewName()

		MississiController.instance:showMissionView(teamCfg, mainViewName, self._viewPresentor.viewName, self.LANG_TIPS_1)
	end
end

function MississiChallengeView:getFightEndMianViewName()
	return ViewName.MississiMainView
end

function MississiChallengeView:_updateRightPart()
	local curStageCfg = self._stageCfgs[self._curSelectId]
	local curActiveNum = 0
	local nextStageId = self._curPassStage + 1

	for i = 1, 3 do
		local missionCell = self._missionCells[i]
		local teamCfg = MississiConfig.instance:getTeamCfg(self._actId, self._curSelectId, i)
		local creepCfgs = MississiConfig.instance:getCreepsCfg(teamCfg.creepsMasterId)

		for k = 1, 9 do
			MaterialMgr.resetAll(missionCell.petCells[k].con)
			goutil.setActive(missionCell.petCells[k].go, false)
		end

		for _, v in pairs(creepCfgs) do
			local petStr = string.format("%s:%s:%s:1", MatType.Pet, v.raceId, v.lv)

			MaterialMgr.setCellByCfg(petStr, missionCell.petCells[v.posId].con)
			goutil.setActive(missionCell.petCells[v.posId].go, true)
		end

		if nextStageId < self._curSelectId then
			goutil.setActive(missionCell.markPass, false)
			goutil.setActive(missionCell.petNum, true)

			missionCell.txtPetNum.text = lang("尚未挑战")
		elseif nextStageId > self._curSelectId then
			goutil.setActive(missionCell.markPass, true)
			goutil.setActive(missionCell.petNum, false)
			goutil.setActive(missionCell.markFail, false)
		else
			local info = MississiModel.instance:getCurStateTeamsInfoByTeamId(self._actId, self._curSelectId, i)

			goutil.setActive(missionCell.petNum, true)

			if info and info.isChallenged then
				missionCell.txtPetNum.text = langPara(self.LANG_TIPS_1, info.activeNum)
				curActiveNum = curActiveNum + info.activeNum

				goutil.setActive(missionCell.markPass, true)
				goutil.setActive(missionCell.markFail, false)
			else
				missionCell.txtPetNum.text = langPara(self.LANG_TIPS_1, 0)

				goutil.setActive(missionCell.markPass, false)
				goutil.setActive(missionCell.markFail, info and info.activeNum >= 0)
			end
		end
	end

	if nextStageId < self._curSelectId then
		self._txtTip.text = lang("请通关前置关卡")

		goutil.setActive(self._txtTip2, false)
	elseif nextStageId > self._curSelectId then
		self._txtTip.text = lang("已通关")

		goutil.setActive(self._txtTip2, false)
	else
		local showContent = curActiveNum >= curStageCfg.number and langPara("<color=#20b376>%s</color>", curActiveNum) or langPara("<color=#eb4642>%s</color>", curActiveNum)

		self._txtTip.text = lang(self.LANG_TIPS_2) .. langPara("%s/%s只", showContent, curStageCfg.number)

		goutil.setActive(self._txtTip2, curActiveNum >= curStageCfg.number)

		self._passTxtTip.text = lang(self.LANG_TIPS_2) .. langPara("%s只\n成功通关", MississiModel.instance:getLastActiveNum())
	end
end

function MississiChallengeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local stageId = data.stageId

	cell.txtLevel.text = langPara("第%s关", stageId)

	GameUtil.addClickHandler(cell.btnSelect, GameUtil.handler(self._updateView, self, stageId))

	if stageId % 2 ~= 1 then
		Framework.TransformUtil.SetLocalScale(cell.go.transform, -1, 1, 1)
		Framework.TransformUtil.SetLocalScale(cell.mirror.transform, -1, 1, 1)
	end

	if stageId == self._curSelectId then
		goutil.setActive(cell.markSelect, true)
	end

	if stageId <= self._curPassStage then
		goutil.setActive(cell.pass, true)
	end

	if stageId == #self._stageCfgs then
		goutil.setActive(cell.dots, false)
	end

	if stageId == self._showStage then
		goutil.setActive(cell.arrow, true)
	end
end

function MississiChallengeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btnSelect = goutil.findChild(cell.go, "btnSelect")
	cell.mirror = goutil.findChild(cell.go, "mirror")
	cell.pass = goutil.findChild(cell.mirror, "pass")
	cell.dots = goutil.findChild(cell.go, "dots")
	cell.arrow = goutil.findChild(cell.go, "arrow")
	cell.markSelect = goutil.findChild(cell.mirror, "head")
	cell.txtLevel = goutil.findChildTextComponent(cell.mirror, "txtLevel")

	goutil.setActive(cell.pass, false)
	goutil.setActive(cell.markSelect, false)
	goutil.setActive(cell.dots, true)
	goutil.setActive(cell.arrow, false)
	GameUtil.rmClickHandler(cell.btnSelect)
	GameUtil.setLocalScale(go, scaleX, scaleY, scaleZ)
	Framework.TransformUtil.SetLocalScale(cell.go.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalScale(cell.mirror.transform, 1, 1, 1)

	return cell
end

function MississiChallengeView:onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "mississichallengerule")
end

function MississiChallengeView:onClickPassTip()
	MississiModel.instance:resetBattleInfo()
	self:_updateViewByInfo()
end

function MississiChallengeView:_onClickClose()
	self:close()
end

return MississiChallengeView
