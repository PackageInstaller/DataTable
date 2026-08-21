-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMeetEventView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMeetEventView", package.seeall)

local ReplyItem = class("ReplyItem")

function ReplyItem:ctor(container)
	local go = container.gameObject

	self._go = go

	local tra = go.transform

	self._txtDesc = tra:Find("normal/txtHandle"):GetComponent("Text")
	self._txtLockDesc = tra:Find("lock/txtHandle"):GetComponent("Text")
	self._goDiff = goutil.findChild(go, "normal/difficultySign")
	self._txtDiff = goutil.findChildTextComponent(go, "normal/difficultySign/txtNum")
	self._txtType = goutil.findChildTextComponent(go, "normal/difficultySign/Text")
	self._imgAttrIcon = goutil.findChildImageComponent(go, "normal/difficultySign/icon")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "clickImg"))
	self._goLock = goutil.findChild(go, "lock")
end

function ReplyItem:setHighlightEnable(isHighlight)
	goutil.setActive(self._goLock, not isHighlight)
end

function ReplyItem:bindEvents()
	if self._isBind then
		return
	end

	self._btnClick:AddClickListener(self.onClick, self)

	self._isBind = true
end

function ReplyItem:unbindEvents()
	self._btnClick:RemoveClickListener()

	self._isBind = false
end

function ReplyItem:OnDestroy()
	self:unbindEvents()
end

function ReplyItem:setDiff(diff, attr, type)
	if diff > 0 then
		IconLoader.setSprite(self._imgAttrIcon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(attr)))

		self._txtDiff.text = diff
	end

	self._txtType.text = lang(RoguelikeConst.ROGUE_EVENT_TYPE_LANG[type])

	goutil.setActive(self._goDiff, diff > 0)
end

function ReplyItem:updateData(data)
	self._txtDesc.text = StringUtil.replaceAllGraphicText2(data.desc)
	self._txtLockDesc.text = StringUtil.replaceAllGraphicText2(data.desc)
	self._onClickCallback = data.callback

	goutil.setActive(self._go, true)
	self:bindEvents()
end

function ReplyItem:onClick()
	if self._onClickCallback ~= nil then
		self._onClickCallback()
	end
end

local kImgPath = "rungroup_painting"
local kIconPath = {
	string.format("%s/%s", kImgPath, "sj_xiangjing"),
	string.format("%s/%s", kImgPath, "sj_xiansuo01"),
	string.format("%s/%s", kImgPath, "sj_zhixian01_start"),
	string.format("%s/%s", kImgPath, "sj_zhixian01_start"),
	string.format("%s/%s", kImgPath, "sj_zhuxian01"),
	(string.format("%s/%s", kImgPath, "sj_kongbai"))
}
local M = class("RogueMeetEventView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("run_group_event_view_436966131")
	self._btnHint = self:getBtn("2&btn_explain_-1936547904")
	self._btnTeam = self:getBtn("run_group_event_view_-52114248")
	self._txtEventName = self:getText("run_group_event_view_-851054734")
	self._txtEventName2 = self:getText("run_group_event_view_1099296717")
	self._txtEventDesc = self:getText("run_group_event_view_-669862653")
	self._traReplyItems = self:getGo("run_group_event_view_-899430128").transform
	self._goReplyItem = self:getGo("run_group_event_view_-313301502")
	self._goReplyItem2 = self:getGo("run_group_event_view_1387117230")
	self._imgPaint = self:getImage("run_group_event_view_-1414914602")
	self._goTrapName = self:getGo("run_group_event_view_-447953531")
	self._goTrapBlood = self:getGo("run_group_event_view_469263603")
	self._goEventEffect = self:getGo("run_group_event_view_1550344973")
	self._goTrapEffect = self:getGo("run_group_event_view_1058629130")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._goToggleQuick = self:getGo("run_group_event_view_285399120")
	self._toggleQuick = goutil.addComponentOnce(self._goToggleQuick, UIComponentType.SpaceXToggle)
	self._replyItems = {}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnHint:AddClickListener(self._onClickHint, self)
	self._btnTeam:AddClickListener(self._onClickTeam, self)
	self._toggleQuick:AddListener(self._onToggleQuickChange, self)
end

function M:unbindEvents()
	self._btnHint:RemoveClickListener()
	self._btnTeam:RemoveClickListener()
	self._toggleQuick:RemoveListener()
end

function M:onEnter()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_PROP_TOP)
	RoguelikeAgent.instance:sendJudgeArchiveRequest(nil)
	goutil.setActive(self.mainGO, false)
	self:setEvent(true)

	local eventId = self:getFirstParam()

	if type(eventId) == "table" then
		eventId = eventId[1]
	end

	self:syncToggleQuick(false)

	self._eventId = eventId

	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

	if eventCo then
		self:updateInfoByCo(eventCo)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_GUIDE_INFO, GuideEnum.GuideRoguelikeTriggerType.Event, eventId)
	else
		printError("找不到事件配置", eventId)
	end
end

function M:syncToggleQuick(hadJudge)
	self._toggleQuick.IsOn = RoguelikeConst.GetIsEventJudgeQuick()

	goutil.setActive(self._goToggleQuick, RoguelikeConst.IsGuideFinish() and hadJudge)
end

function M:_onClickHint()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.ManualKey.RogueMeetEvent
	})
end

function M:_onClickTeam()
	ViewMgr.instance:open(ViewName.RogueTeamInfo)
end

function M:_onToggleQuickChange(toggle, isOn)
	RoguelikeConst.SetIsEventJudgeQuick(isOn)
end

function M:onExit()
	self:setEvent(false)

	for k, v in pairs(self._replyItems) do
		v:unbindEvents()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_EVENT_REPLY, self._onEventReply, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EVENT_REPLY, self._onEventReply, self)
	end
end

function M:_onEventReply(sender, msg)
	local replyIds = {}
	local allEnable = {}

	for k, v in ipairs(msg.reply) do
		table.insert(replyIds, v)
		table.insert(allEnable, true)
	end

	for k, v in ipairs(msg.ashReply) do
		table.insert(replyIds, v)
		table.insert(allEnable, false)
	end

	if #replyIds == 0 then
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(self._eventId)
		local conditionCo = RoguelikeConfig.instance:getConditionById(eventCo.condition)

		goutil.setActive(self.mainGO, true)
		ViewMgr.instance:close(ViewName.RogueMeetEvent, false, WindowType.WindowCloseReasonType.QuickCloseType)
		FloatWordMgr.instance:show(conditionCo.description)
	else
		goutil.setActive(self.mainGO, true)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open_Pos1")
	end

	self:updateReplyIds(replyIds, allEnable)
end

function M:updateInfoByCo(co)
	self._txtEventName.text = co.name
	self._txtEventName2.text = co.name
	self._txtEventDesc.text = StringUtil.replaceAllGraphicText2(co.description)

	local replyIds = co.replys or {}

	if co.illustration == "" then
		IconLoader.setSprite(self._imgPaint, IconType.RunGroup, kIconPath[co.type] or kIconPath[1], self._onImageCallback, self)
	else
		IconLoader.setSprite(self._imgPaint, IconType.RunGroup, string.format("%s/%s", kImgPath, co.illustration), self._onImageCallback, self)
	end

	for i = 0, self._traReplyItems.childCount - 1 do
		goutil.setActive(self._traReplyItems:GetChild(i).gameObject, false)
	end

	if RogueMgr.instance:getIsClientMode() or self:getOpenParam()[2] then
		local allEnable = {}

		for k, v in pairs(replyIds) do
			table.insert(allEnable, true)
		end

		self:updateReplyIds(replyIds, allEnable)
		goutil.setActive(self.mainGO, true)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open_Pos1")
	else
		local eventId = self._eventId

		RoguelikeAgent.instance:sendStartEventRequest(eventId)
	end
end

function M:_onImageCallback()
	return
end

function M:showEncounterObjs(isActive)
	goutil.setActive(self._goTrapName, isActive)
	goutil.setActive(self._goTrapBlood, isActive)
	goutil.setActive(self._goTrapEffect, isActive)
	goutil.setActive(self._goEventEffect, not isActive)
end

function M:updateReplyIds(replyIds, replyEnables)
	self._replyIds = replyIds

	for i = 0, self._traReplyItems.childCount - 1 do
		goutil.setActive(self._traReplyItems:GetChild(i).gameObject, false)
	end

	self._replyEnables = replyEnables

	local judgeArchive = RoguelikeModel.instance:getEventJudgeArchive()

	if RogueMgr.instance:getHackToolModel() then
		judgeArchive = nil
	end

	local enemyId = judgeArchive and judgeArchive.enemyId or -1
	local isEncounterEvent = false
	local hadJudge = false

	for i = 1, #replyIds do
		local item = self._replyItems[i]

		if not item then
			local mod = i % 2
			local goItem = mod == 1 and self._goReplyItem or self._goReplyItem2
			local go = Astral.GameObjectUtil.CloneAndSetParent(goItem, self._traReplyItems, nil)

			go.name = "replyOption" .. i
			item = Astral.LuaComponentContainer.Add(go, ReplyItem)
			self._replyItems[i] = item
		end

		local replyCo = RoguelikeConfig.instance:getEventReplyById(replyIds[i])
		local data = {}
		local isSelected = RoguelikeModel.instance:getReplyIdSelected(replyIds[i])
		local patternResult = ""

		data.desc = isSelected and replyCo.description .. patternResult .. lang("tip_r_reply_select") or replyCo.description .. patternResult

		function data.callback()
			self:onReplyItemClick(replyCo, i)
		end

		item:updateData(data)
		item:setDiff(replyCo.difficulty, replyCo.testedAttribute, replyCo.type)
		item:setHighlightEnable(self._replyEnables[i])

		if replyCo.type == RoguelikeConst.ROGUE_EVENT_TYPE_1.ENCOUNTER_EVENT then
			isEncounterEvent = true
		end

		if replyCo.type >= RoguelikeConst.ROGUE_EVENT_TYPE_1.SINGLE_EVENT and replyCo.type <= RoguelikeConst.ROGUE_EVENT_TYPE_1.ENCOUNTER_EVENT then
			hadJudge = true
		end

		if enemyId == replyIds[i] then
			self._roleIndex = RogueMgr.instance:getModel():getRoleIndexByRoleId(judgeArchive.heroId)

			self:onReplyItemClick(replyCo, i, true)
		end
	end

	self:syncToggleQuick(hadJudge)
	self:showEncounterObjs(isEncounterEvent)
end

function M:delaySetPlotStatus()
	RoguelikeController.instance:setPlayingReplyPlotStatus(false)
end

function M:onReplyItemClick(replyCo, idx, isRestore)
	local isEnable = RogueMgr.instance:getConditionMgr():judgeConditions(replyCo.condition == 0 and {} or {
		replyCo.condition
	})
	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(self._eventId)

	RogueMgr.instance:getModel():setCurReplyCo(replyCo)

	local eventType = eventCo.type
	local replyType = replyCo.type

	idx = idx or 1

	if not self._replyEnables[idx] then
		if replyCo.condition ~= 0 then
			local conditionCo = RoguelikeConfig.instance:getConditionById(replyCo.condition)

			if conditionCo then
				FloatWordMgr.instance:show(conditionCo.description)
			end
		else
			FloatWordMgr.instance:show(lang("tip_fail_meet_condition"))
		end
	elseif replyType == RoguelikeConst.ROGUE_EVENT_TYPE_1.AT_ONE or replyType == RoguelikeConst.ROGUE_EVENT_TYPE_1.REPEAT or eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_ENTRANCE or eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_EXIT then
		RoguelikeModel.instance:setEnterRoleStates()

		if replyCo.successEffect ~= 0 then
			local effectId = replyCo.successEffect

			RogueMgr.instance:getRogueFlow().model:setInSettlement(true)
			RogueMgr.instance:getRogueFlow().judgeMgr:saveEmptyJudgeArchive(replyCo.id)

			if replyType == RoguelikeConst.ROGUE_EVENT_TYPE_1.AT_ONE and eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_ENTRANCE and eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_EXIT then
				RoguelikeAgent.instance:sendEndJudgeRequest(2, true)
			end

			self:openEventView(replyCo)
			ViewMgr.instance:open(ViewName.RogueEventSettlement, self._eventId, true)
		else
			RogueMgr.instance:getRogueFlow().model:setInSettlement(true)
			RogueMgr.instance:getRogueFlow().judgeMgr:saveEmptyJudgeArchive(replyCo.id)

			if replyType == RoguelikeConst.ROGUE_EVENT_TYPE_1.AT_ONE and eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_ENTRANCE and eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_EXIT then
				RoguelikeAgent.instance:sendEndJudgeRequest(2, true)
			end

			ViewMgr.instance:open(ViewName.RogueEventSettlement, self._eventId, true)
			RogueMgr.instance:getModel():setCurReplyCo(nil)
			self:openEventView(replyCo)
		end

		if replyType == RoguelikeConst.ROGUE_EVENT_TYPE_1.REPEAT or eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_ENTRANCE or eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_EXIT then
			RogueMgr.instance:getRogueFlow().model:setInExitEvent(true)
		end
	elseif replyCo.testedAttribute ~= nil and replyCo.testedAttribute ~= 0 then
		print("修改事件考察属性", replyCo.testedAttribute)
		RogueMgr.instance:getModel():setEventProp(replyCo.testedAttribute)
		self:openEventView(replyCo, isRestore)
	elseif replyCo.testedAttribute == 0 then
		print("无判定流程", replyCo.id)
		FloatWordMgr.instance:show(replyCo.description)
		self:openEventView(replyCo)
	end
end

function M:onCardClickCallback(idx)
	RogueMgr.instance:getModel():setCurRoleIndex(idx)
	RogueMgr.instance:getModel():setCurEventInfo({
		self._eventId,
		self._replyCo
	})

	if RogueMgr.instance:getHackToolModel() then
		RogueMgr.instance:getModel():setCurEventInfo(nil)
		RogueMgr.instance:enterEvent(self._eventId, self._replyCo.type + 1)
		self:close()

		return
	end

	self:close()
	self:openEventJudgeView()
end

function M:openEventView(replyCo, isRestore)
	local eventType = replyCo.type

	self._replyCo = replyCo

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.SINGLE_EVENT then
		if isRestore then
			local idx = self._roleIndex

			RogueMgr.instance:getModel():setCurRoleIndex(idx)
			RogueMgr.instance:getModel():setCurEventInfo({
				self._eventId,
				replyCo
			})
			self:openEventJudgeView()
		else
			local pattern = RoguelikeUtil.instance:convertCAttrType2SType(replyCo.testedAttribute)
			local title = ""
			local patternResult = RoguelikeConst.AttrType2Name[pattern]

			title = string.format(lang("tip_r_judge_select_role"), RoguelikeConst.AttrType2GraphicText[pattern], patternResult)

			ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
				1,
				function(idx)
					ViewMgr.instance:close(ViewName.RogueSelectPropAndRole)
					self:onCardClickCallback(idx)
				end,
				title,
				[5] = replyCo.testedAttribute
			})
		end
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.MULTI_EVENT then
		local result = RogueMgr.instance:getModel():setFirstActiveRoleIndex()

		if result ~= 0 then
			RogueMgr.instance:getModel():setCurEventInfo({
				self._eventId,
				replyCo
			})

			if RogueMgr.instance:getHackToolModel() then
				RogueMgr.instance:getModel():setCurEventInfo(nil)
				RogueMgr.instance:enterEvent(self._eventId, replyCo.type + 1)
				self:_onClickClose()

				return
			end

			self:openEventJudgeView()
		end
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.ENCOUNTER_EVENT then
		local result = RogueMgr.instance:getModel():setFirstActiveRoleIndex()

		if result ~= 0 then
			RogueMgr.instance:getModel():setCurEventInfo({
				self._eventId,
				replyCo
			})

			if RogueMgr.instance:getHackToolModel() then
				RogueMgr.instance:getModel():setCurEventInfo(nil)
				RogueMgr.instance:enterEvent(self._eventId, replyCo.type + 1)
				self:_onClickClose()

				return
			end

			self:openEventJudgeView()
		end
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE_1.PLOT_EVENT then
		if not replyCo.successEffect then
			printError("剧情事件没应对", replyCo.id)
		end

		local eventId = replyCo.successEffect[1]

		RogueMgr.instance:getRogueFlow().judgeMgr:saveAtOneEventJudgeArchive(replyCo.id, RoguelikeConst.ROGUE_EVENT_TYPE.PLOT_EVENT, eventId)

		local eventCo = RoguelikeConfig.instance:getPlotEventById(eventId)

		if eventCo and eventCo.prestory ~= "" then
			local plotId = tonumber(eventCo.prestory)

			if RoguelikeConst.IsAllowStory(plotId) then
				StoryMgr.instance:startSingle(plotId, false, self._onPlotEventStoryFinish, self)
				RoguelikeConst.SetStoryPlayed(plotId)
			else
				ViewMgr.instance:open(ViewName.RogueSurvey)
			end
		else
			ViewMgr.instance:open(ViewName.RogueSurvey)
		end
	end

	self:close()
end

function M:openEventJudgeView()
	if RoguelikeConst.GetIsEventJudgeQuick() then
		RogueMgr.instance:setNeedShowDice(false)
		RogueMgr.instance:setWaitTimeScale(0.01)
		RogueMgr.instance:enterEventWithToast(self._eventId, self._replyCo.type + 1)
	else
		RoguelikeController.instance:enterRunGroupJudgeScene(function()
			RoguelikeController.instance:closeMapView()

			local eventInfo = RogueMgr.instance:getModel():getCurEventInfo()

			ViewMgr.instance:open(ViewName.RogueEventJudge, eventInfo)
			RogueMgr.instance:getModel():setCurEventInfo(nil)
		end)
	end
end

function M:_onPlotEventStoryFinish()
	settimer(0.2, function()
		ViewMgr.instance:close(ViewName.RogueMeetEvent)
		ViewMgr.instance:open(ViewName.RogueSurvey)
	end, self, false)
end

function M:_onClickClose()
	self:close()

	if #self._replyIds == 0 then
		return
	end

	if RogueMgr.instance:getHackToolModel() then
		return
	end

	RoguelikeController.instance:closeMapView()
	RoguelikeController.instance:exitRunGroupSceneFlow()
end

return M
