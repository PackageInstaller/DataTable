-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueEventSettlementView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueEventSettlementView", package.seeall)

local kImgPath = "rungroup_painting"
local kIconPath = {
	string.format("%s/%s", kImgPath, "sj_xiangjing"),
	string.format("%s/%s", kImgPath, "sj_xiansuo01"),
	string.format("%s/%s", kImgPath, "sj_zhixian01_start"),
	string.format("%s/%s", kImgPath, "sj_zhixian01_start"),
	string.format("%s/%s", kImgPath, "sj_zhuxian01"),
	(string.format("%s/%s", kImgPath, "sj_kongbai"))
}
local M = class("RogueEventSettlementView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("run_group_event_view_436966131")
	self._btnTeam = self:getBtn("run_group_event_view_-52114248")
	self._txtEventName = self:getText("run_group_event_view_-851054734")
	self._txtEventName2 = self:getText("run_group_event_view_1099296717")
	self._txtEventDesc = self:getText("run_group_event_view_-669862653")
	self._traReplyItems = self:getGo("run_group_event_view_-899430128").transform
	self._goReplyItem = self:getGo("run_group_event_view_-313301502")
	self._goSettlement = self:getGo("run_group_event_view_405978464")
	self._txtSettlement = self:getText("run_group_event_view_1963129254")
	self._txtSettlement2 = self:getText("run_group_event_view_-1777786403")
	self._imgPaint = self:getImage("run_group_event_view_-1414914602")
	self._goTrapName = self:getGo("run_group_event_view_-447953531")
	self._goTrapBlood = self:getGo("run_group_event_view_469263603")
	self._goEventEffect = self:getGo("run_group_event_view_1550344973")
	self._goTrapEffect = self:getGo("run_group_event_view_1058629130")
	self._goCenter = self:getGo("run_group_event_view_1176719673")
	self._traLeft = goutil.findChild(self._goCenter, "left").transform
	self._traLeft1Pos = goutil.findChild(self._goCenter, "leftPos1").transform
	self._traLeft2Pos = goutil.findChild(self._goCenter, "leftPos2").transform
	self._traRight = goutil.findChild(self._goCenter, "right").transform
	self._traRight1Pos = goutil.findChild(self._goCenter, "righPos1").transform
	self._traRight2Pos = goutil.findChild(self._goCenter, "righPos2").transform
	self._goWin = self._txtSettlement.transform.parent.gameObject
	self._goLose = self._txtSettlement2.transform.parent.gameObject
	self._goHint = self:getGo("2&btn_explain_-1936547904")

	goutil.setActive(self._goHint, false)
	goutil.setActive(self._btnTeam.gameObject, false)

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self.mainGO.name = "run_group_event_settlement"
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTeam:AddClickListener(self._onClickTeam, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnTeam:RemoveClickListener()
end

function M:updateCenterLayout()
	goutil.setActive(self.mainGO, false)

	local x1, y1, z1 = Astral.TransformUtil.GetLocalRotation(self._traLeft2Pos, 0, 0, 0)
	local x2, y2, z2 = Astral.TransformUtil.GetLocalRotation(self._traRight2Pos, 0, 0, 0)
	local left1Pos = self._traLeft2Pos.position
	local right1Pos = self._traRight2Pos.position

	Astral.TransformUtil.SetPos(self._traLeft, left1Pos.x, left1Pos.y, left1Pos.z)
	Astral.TransformUtil.SetPos(self._traRight, right1Pos.x, right1Pos.y, right1Pos.z)
	Astral.TransformUtil.SetLocalRotation(self._traLeft, 0, 0, z1)
	Astral.TransformUtil.SetLocalRotation(self._traRight, 0, 0, z2)
	goutil.setActive(self.mainGO, true)
end

function M:onEnter()
	if RoguelikeConst.GetIsEventJudgeQuick() then
		RogueMgr.instance:setNeedShowDice(true)
		RogueMgr.instance:setWaitTimeScale(1)
	end

	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if RogueMgr.instance:getRogueFlow() then
		RogueMgr.instance:getRogueFlow().diceMgr:recoveryAllDiceObj()
	end

	if not allRoleState or not RogueMgr.instance:isInRogue() then
		self:close()

		return
	end

	self:setObjectVisible()

	local eventId = self:getOpenParam()[1]

	eventId = eventId ~= nil and eventId or RogueMgr.instance:getModel():getCurEventId()
	self._eventId = eventId

	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)
	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()

	if eventCo then
		if replyCo == nil then
			printError("找不到应对,事件id：" .. eventId)
			self:close()

			return
		end

		self:updateInfoByCo(eventCo, replyCo)
	end

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open_Pos1")
end

function M:setObjectVisible()
	goutil.setActive(self._traReplyItems.gameObject, false)
	goutil.setActive(self._goSettlement, true)
end

function M:showEncounterObjs(isActive)
	goutil.setActive(self._goTrapName, isActive)
	goutil.setActive(self._goTrapBlood, isActive)
	goutil.setActive(self._goTrapEffect, isActive)
	goutil.setActive(self._goEventEffect, not isActive)
end

function M:onExit()
	RoguelikeController.instance:exitSettlementView()

	if not RogueMgr.instance:getRogueFlow() then
		return
	end

	RogueMgr.instance:getRogueFlow().model:setInSettlement(false)
	RogueMgr.instance:getRogueFlow().judgeMgr:saveEmptyJudgeArchive(0)
	RoguelikeController.instance:checkNeedQuit()

	if RogueMgr.instance:getHackToolModel() then
		return
	end
end

function M:updateInfoByCo(co, replyCo)
	self._txtEventName.text = co.name
	self._txtEventName2.text = co.name
	self._eventType = co.type

	local isWin = self:getOpenParam()[2]

	isWin = isWin ~= nil and isWin or RogueMgr.instance:getModel():getJudgeResult()
	self._isWin = isWin

	goutil.setActive(self._goWin, isWin)
	goutil.setActive(self._goLose, not isWin)

	local settlementText = isWin and replyCo.successDescription or replyCo.failDescription

	self._txtEventDesc.text = StringUtil.replaceAllGraphicText2(settlementText)

	local effectIds = {}

	if isWin then
		effectIds = replyCo.successEffect
	else
		effectIds = replyCo.failEffect
	end

	local description = ""

	if co.illustration == "" then
		IconLoader.setSprite(self._imgPaint, IconType.RunGroup, kIconPath[co.type] or kIconPath[1], self._onImageCallback, self)
	elseif isWin and replyCo.successImage ~= "" then
		IconLoader.setSprite(self._imgPaint, IconType.RunGroup, string.format("%s/%s", kImgPath, replyCo.successImage), self._onImageCallback, self)
	elseif not isWin and replyCo.failImage ~= "" then
		IconLoader.setSprite(self._imgPaint, IconType.RunGroup, string.format("%s/%s", kImgPath, replyCo.failImage), self._onImageCallback, self)
	else
		IconLoader.setSprite(self._imgPaint, IconType.RunGroup, string.format("%s/%s", kImgPath, co.illustration), self._onImageCallback, self)
	end

	if effectIds and #effectIds > 0 then
		for k, effectId in pairs(effectIds) do
			local effectCo = RoguelikeConfig.instance:getEffectById(effectId)

			if effectCo then
				if description ~= "" then
					description = description .. " , "
				end

				description = description .. effectCo.description
			end
		end
	end

	self._txtSettlement.text = StringUtil.replaceAllGraphicText2(description)
	self._txtSettlement2.text = StringUtil.replaceAllGraphicText2(description)

	goutil.setActive(self._goSettlement, description ~= "")

	if settlementText == "" or settlementText == nil then
		self:_onClickClose()
	end

	if RoguelikeController.instance:getIsAllDeath() then
		self._txtSettlement.text = lang("tip_r_role_die_quit")
		self._txtSettlement2.text = lang("tip_r_role_die_quit")
	end

	local eventType = replyCo.type

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SINGLE_EVENT or eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.MULTI_EVENT then
		self._txtEventName.text = isWin and lang("tip_r_judge_success") or lang("tip_r_judge_fail")
		self._txtEventName2.text = isWin and lang("tip_r_judge_success") or lang("tip_r_judge_fail")
	end

	self:showEncounterObjs(eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.ENCOUNTER_EVENT)

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.AT_ONE and self._txtSettlement.text == "" and self._txtEventDesc.text == "" then
		self:close()
	end
end

function M:_onImageCallback()
	return
end

function M:_onClickClose()
	if not RogueMgr.instance:isInRogue() then
		self:close()

		return
	end

	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()

	self:close()

	if replyCo then
		function execClose()
			local eventType = replyCo.type

			if eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.AT_ONE or eventType == 5 then
				if replyCo.successEffect ~= "" then
					local effectId = replyCo.successEffect

					RoguelikeController.instance:execEffectIds(effectId, function()
						RogueMgr.instance:getModel():setCurReplyCo(nil)
					end)
				end
			elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SINGLE_EVENT or eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.MULTI_EVENT then
				local effectId = self._isWin and replyCo.successEffect or replyCo.failEffect

				RoguelikeController.instance:execEffectIds(effectId, function()
					RogueMgr.instance:getModel():setCurReplyCo(nil)
				end)
			end
		end

		local plotCallback

		if self._eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_ENTRANCE or eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_EXIT then
			function plotCallback()
				execClose()
			end
		else
			execClose()
		end

		local plotId = 0

		if self._isWin then
			plotId = replyCo.successStory
		else
			plotId = replyCo.failStory
		end

		RoguePlotUtil.instance:startPlot(plotId, plotCallback)
	else
		printError(self._eventId .. "没有应对选项")
	end
end

function M:_onClickTeam()
	ViewMgr.instance:open(ViewName.RogueTeamInfo)
end

return M
