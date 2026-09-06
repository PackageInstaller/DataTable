-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvdetailView.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvdetailView", package.seeall)

local LongnvdetailView = class("LongnvdetailView", ViewComponent)

function LongnvdetailView:ctor()
	LongnvdetailView.super.ctor(self)
end

function LongnvdetailView:buildUI()
	LongnvdetailView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.bg = self:getGo("bg")
	self.bg2 = self:getGo("bg2")
	self.txtResult = self:getTxt("txtResult")
	self.cell = self:getGo("cell")
	self.tableview = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function LongnvdetailView:bindEvents()
	LongnvdetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function LongnvdetailView:unbindEvents()
	LongnvdetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function LongnvdetailView:destroyUI()
	LongnvdetailView.super.destroyUI(self)
end

function LongnvdetailView:onEnter()
	LongnvdetailView.super.onEnter(self)

	local type = checknumber(self:getFirstParam())

	self.raceName = ""
	self.type = type

	GameUtil.SetActive(self.bg, false)
	GameUtil.SetActive(self.bg2, false)

	if type == LongnvModel.TYPE_1 then
		GameUtil.SetActive(self.bg, true)
	else
		GameUtil.SetActive(self.bg2, true)
	end

	self._challengeId = 16

	GlobalDispatcher:addListener(GlobalNotify.PM_LongnvInfoRes, self.onRefreshUI, self)
	LongnvController.instance:sendGetChallengeInfoByType(type)
	self:onRefreshUI()
end

function LongnvdetailView:onEnterFinished()
	LongnvdetailView.super.onEnterFinished(self)
end

function LongnvdetailView:onExit()
	LongnvdetailView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_LongnvInfoRes, self.onRefreshUI, self)
	self.scrollList:dispose()
end

function LongnvdetailView:onExitFinished()
	LongnvdetailView.super.onExitFinished(self)
end

function LongnvdetailView:onRefreshUI()
	local type = self.type
	local planId = LongnvModel.instance:getPlanId()
	local cfg = LongnvConfig.instance:getPlanCfg(planId) or {}
	local monsterPlan = checknumber(cfg.monsterPlan)
	local typeCfg = LongnvConfig.instance:getTypeCfg(type) or {}
	local name = typeCfg.desc
	local rId = GameEnum.Races[typeCfg.detectAttr]
	local race = ConstString.Race[rId]

	self.raceName = race

	local num = typeCfg.minAlivePet
	local total = LongnvModel.instance:getTotalAliveByType(type)
	local isOk = lang("<color=#ff0000>未达成</color>")

	self.txtResult.text = langPara("通过%s关卡，<color=#20b376>%s属性精灵存活≥%s</color>\n当前%s属性精灵存活：<color=#20b376>%s/%s</color>  %s", name, race, num, race, total, num, (num <= total or nil) and lang("<color=#20b376>已达成</color>"))

	local monsterList = LongnvConfig.instance:getMonsterListCfg(type, monsterPlan) or {}

	self.scrollList:reloadData(monsterList)

	local idx = 1

	for i, data in ipairs(monsterList) do
		local hasNum1 = LongnvModel.instance:getHasNumAliveByType(self.type, data.stage)
		local hasNum2 = LongnvModel.instance:getHasNumAliveByType(self.type, data.stage - 1)

		if hasNum1 then
			-- block empty
		elseif data.stage == 1 or hasNum2 then
			idx = i

			break
		end
	end

	self.scrollList:MoveCellInView(idx - 1)
end

function LongnvdetailView:clearCell(cell)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local con = goutil.findChild(cell, "con")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local txtResult = goutil.findChildTextComponent(cell, "txtResult")

	GameUtil.rmClickHandler(btnChallenge)
end

function LongnvdetailView:_updateCell(view, cell, data, tag)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local con = goutil.findChild(cell, "btnChallenge/con")
	local txtLevel = goutil.findChildTextComponent(cell, "btnChallenge/txtLevel")
	local txtResult = goutil.findChildTextComponent(cell, "btnChallenge/txtResult")

	GameUtil.setAnchoredPos(btnChallenge, 0, checknumber(data.offsetY))
	MaterialMgr.setIcon(con, MatType.Pet, data.showFaceId)

	txtLevel.text = data.name

	local hasNum1 = LongnvModel.instance:getHasNumAliveByType(self.type, data.stage)
	local hasNum2 = LongnvModel.instance:getHasNumAliveByType(self.type, data.stage - 1)

	if hasNum1 then
		local num = LongnvModel.instance:getNumAliveByType(self.type, data.stage)
		local race = self.raceName

		txtResult.text = langPara("存活<color=#20b376>%s只</color>%s系精灵", num, race)
	else
		txtResult.text = (data.stage == 1 or hasNum2) and lang("可挑战") or ""
	end

	GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self.onClickCell, self, data))
end

function LongnvdetailView:onClickCell(data)
	LongnvController.instance:checkIfCanChallengeSmall(function()
		local hasNum = LongnvModel.instance:getHasNumAliveByType(self.type, data.stage - 1)

		if data.stage == 1 or hasNum then
			ViewAutoShowController.instance:saveCurModalView()

			local params = {}

			params.type = self.type
			params.stageId = data.stage
			params.challengeId = self._challengeId

			UIStateManager.instance:push(ViewName.LongnvMissionView, params)
		else
			TipsFacade.instance:openCommonTips(lang("请先通过前面挑战！"))
		end
	end)
end

return LongnvdetailView
