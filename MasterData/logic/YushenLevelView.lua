-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenLevelView.lua

module("logic.extensions.dragonxiuer.view.YushenLevelView", package.seeall)

local YushenLevelView = class("YushenLevelView", ViewComponent)

YushenLevelView.ConditionDesc = {
	ActiveCount = lang("存活精灵"),
	CircleCount = lang("击败回合数"),
	RoundCount = lang("出手次数")
}

function YushenLevelView:ctor()
	YushenLevelView.super.ctor(self)
end

function YushenLevelView:unbindEvents()
	YushenLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function YushenLevelView:bindEvents()
	YushenLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function YushenLevelView:buildUI()
	YushenLevelView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._groupTableView = self:getGo("groupRoot/tableview")
	self._groupTableCell = self:getGo("groupRoot/tablecell")
	self._levelTableView = self:getGo("levelRoot/tableview")
	self._levelTableCell = self:getGo("levelRoot/cell")
end

function YushenLevelView:onExit()
	YushenLevelView.super.onExit(self)
	self._groupTableList:dispose()
	self._listTableList:dispose()
end

function YushenLevelView:onEnter()
	YushenLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_DragonXiuerGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_DragonXiuerResetDestroyModeTeamRes, self._refreshView, self)

	self._actId = self:getFirstParam()
	self._groupTableList = ScrollerList.create(self._groupTableView, self._groupTableCell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	self._listTableList = ScrollerList.create(self._levelTableView, self._levelTableCell, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))
	self._selectGroup = DragonXiuerModel.instance:getPassStageId(self._actId) + 1

	DragonXiuerAgent.instance:sendPM_DragonXiuerGetInfoReq(self._actId)
end

function YushenLevelView:_refreshView()
	local groupCfg = DragonXiuerConfig.instance:getActStageCfg(self._actId)

	if #groupCfg < self._selectGroup then
		self._selectGroup = #groupCfg
	end

	self._groupTableList:reloadData(groupCfg)

	local teamList = {}

	for i, v in ipairs(groupCfg[self._selectGroup].teams) do
		table.insert(teamList, {
			index = i,
			teamId = v
		})
	end

	self._listTableList:reloadData(teamList)
end

function YushenLevelView:_updateGroupCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "btnSelect")
	local passGo = goutil.findChild(go, "pass")
	local lockTip = goutil.findChild(go, "lockTip")
	local txtName = goutil.findChildTextComponent(go, "nameText")
	local prizeCon = goutil.findChild(go, "prize/con")
	local txtPirze = goutil.findChildTextComponent(go, "prize/txt")
	local goSelect = goutil.findChild(go, "select")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	txtPirze.text = langPara("x%d", matNum)

	MaterialMgr.setIcon(prizeCon, matType, matId)

	txtName.text = data.name

	local info = DragonXiuerModel.instance:getStageInfo(self._actId, data.stageId)

	if info then
		GameUtil.SetActive(passGo, info.isPass)
	else
		GameUtil.SetActive(passGo, false)
	end

	local passStageId = DragonXiuerModel.instance:getPassStageId(self._actId)

	GameUtil.SetActive(lockTip, passStageId + 1 < data.stageId)
	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickGroup(data.stageId)
	end, self)
	goutil.setActive(goSelect, data.stageId == self._selectGroup)
end

function YushenLevelView:_clearGroupCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "btnSelect")
	local prizeCon = goutil.findChild(go, "prize/con")

	GameUtil.rmClickHandler(btnClick)
	MaterialMgr.resetAll(prizeCon)
end

function YushenLevelView:_updateLevelCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnChallenge = goutil.findChild(go, "clickArea")
	local btnReset = goutil.findChild(go, "btnReset")
	local txtCondition = goutil.findChildTextComponent(go, "txtCondition")
	local groupCfg = DragonXiuerConfig.instance:getActStageCfg(self._actId)
	local txtScore = goutil.findChildTextComponent(go, "tag/txt")
	local passGo = goutil.findChild(go, "pass")
	local con = goutil.findChild(go, "petCon")
	local mark = goutil.findChild(go, "imgMark")
	local imgNumMark = goutil.findChildComponent(go, "imgMark/imgMarkNum", "ImgNumber")
	local info = DragonXiuerModel.instance:getTeamInfo(self._actId, self._selectGroup, data.index)
	local passStageId = DragonXiuerModel.instance:getPassStageId(self._actId)
	local score = 0

	if info then
		score = info.score

		if self._selectGroup < passStageId + 1 then
			GameUtil.SetActive(passGo, true)
			GameUtil.SetActive(btnReset, false)
			GameUtil.SetActive(mark, true)
		elseif self._selectGroup == passStageId + 1 then
			GameUtil.SetActive(passGo, score ~= 0)
			GameUtil.SetActive(btnReset, score ~= 0)
			GameUtil.SetActive(mark, score ~= 0)
		else
			GameUtil.SetActive(passGo, false)
			GameUtil.SetActive(btnReset, false)
			GameUtil.SetActive(mark, false)
		end
	else
		score = 0

		GameUtil.SetActive(passGo, false)
		GameUtil.SetActive(btnReset, false)
		GameUtil.SetActive(mark, false)
	end

	local groupCfg = DragonXiuerConfig.instance:getActStageCfg(self._actId)

	if groupCfg[self._selectGroup] and groupCfg[self._selectGroup].scoreType == "RoundCount" then
		imgNumMark:SetNum(score % 10)
	else
		imgNumMark:SetNum(score)
	end

	txtCondition.text = langPara("<color=#FFFFFFFF>%s:</color>%d", YushenLevelView.ConditionDesc[groupCfg[self._selectGroup].scoreType], score)
	txtScore.text = langPara("%d", score)

	local creepsCfg = DragonXiuerConfig.instance:getCreepsCfg(data.teamId)
	local raceId = creepsCfg[1].raceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))

	if not modelCo then
		printError("t_model id not exist:" .. raceId)

		return
	end

	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickLevel(data.index)
	end, self)
	GameUtil.rmClickHandler(btnReset)
	GameUtil.addClickHandler(btnReset, function()
		self:_onClickReset(data.index)
	end, self)
end

function YushenLevelView:_clearLevelCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "petCon")
	local btnChallenge = goutil.findChild(go, "clickArea")
	local btnReset = goutil.findChild(go, "btnReset")

	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.rmClickHandler(btnReset)
	uGuiUtil.clearImage(con)
end

function YushenLevelView:_onClickGroup(groupId)
	self._selectGroup = groupId

	self:_refreshView()
end

function YushenLevelView:_onClickLevel(levelId)
	local passStageId = DragonXiuerModel.instance:getPassStageId(self._actId)

	if self._selectGroup < passStageId + 1 then
		FloatWordMgr.instance:show(lang("本关已通过"))
	elseif self._selectGroup == passStageId + 1 then
		local info = DragonXiuerModel.instance:getTeamInfo(self._actId, self._selectGroup, levelId)

		if info and info.score > 0 then
			local content = lang("是否确认重置该关卡的挑战状态")
		else
			local fmtMo = DragonXiuerModel.instance:getLevelFmtMo()

			fmtMo:initParams(self._actId, self._selectGroup, levelId)
			CustomFmtController.instance:showMissionView(fmtMo)
		end
	else
		FloatWordMgr.instance:show(lang("请通关上一层后解锁挑战"))
	end
end

function YushenLevelView:_onClickReset(levelId)
	local content = lang("是否确认重置该关卡的挑战状态")

	TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
		DragonXiuerController.instance:sendPM_DragonXiuerResetDestroyModeTeamReq(self._actId, self._selectGroup, levelId)
	end)
end

return YushenLevelView
