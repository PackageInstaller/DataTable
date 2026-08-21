-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueSurveyView.lua

module("logic.extensions.roguelike.view.explore.RogueSurveyView", package.seeall)

local TouchObj = class("TouchObj")

function TouchObj:ctor(go)
	self._goGuang = goutil.findChild(go, "guang")
	self._goEffect = goutil.findChild(go, "UIParticle")
	self._goImg = goutil.findChild(go, "click/Image")
	self._goInvestigated = goutil.findChild(go, "Investigated")
end

function TouchObj:setActive(isActive)
	goutil.setActive(self._goGuang, isActive)
	goutil.setActive(self._goEffect, isActive)
	goutil.setActive(self._goImg, isActive)
end

function TouchObj:setIsTouched(isTouch)
	goutil.setActive(self._goInvestigated, isTouch)
end

local kWaitTipsTime = 15
local kWaitHintBtnTime = 15
local kHideEffectHintTime = 5
local kUiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local M = class("RogueSurveyView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._goInteractPanel = self:getGo("run_group_survey_view_363134395")
	self._goStartInteractPanel = self:getGo("run_group_survey_view_55941724")
	self._goFinishInteractPanel = self:getGo("run_group_survey_view_1794530603")
	self._animStartInteractPanel = self._goStartInteractPanel:GetComponent(ComponentType.Animation)
	self._animFinishInteractPanel = self._goFinishInteractPanel:GetComponent(ComponentType.Animation)
	self._goInteractInfoPanel = self:getGo("run_group_survey_view_701381089")
	self._goInteractFinishHint = self:getGo("run_group_survey_view_2106948864")
	self._goAffectHint = self:getGo("run_group_survey_view_117522946")
	self._animAffectHint = self:getUIComponent("run_group_survey_view_-1094800727", ComponentType.Animation)
	self._txtAffectHint = self:getText("run_group_survey_view_2064152727")
	self._btnFinished = self:getBtn("run_group_survey_view_1120536437")
	self._btnHint = self:getBtn("run_group_survey_view_1515180077")
	self._goTips = self:getGo("run_group_survey_view_1913549572")
	self._goGetClue = self:getGo("run_group_survey_view_1133862448")
	self._animGetClue = self._goGetClue:GetComponent(ComponentType.Animation)
	self._goGetClueItems = {
		goutil.findChild(self._goGetClue, "prop_item"),
		goutil.findChild(self._goGetClue, "prop_item1"),
		goutil.findChild(self._goGetClue, "prop_item2")
	}
	self._btnFull = self:getBtn("run_group_survey_view_1755022132")
	self._goClickEffect = goutil.findChild(self.mainGO, "run_group_survey_click")
	self._goClickEffect1 = goutil.findChild(self._goClickEffect, "type1")
	self._goClickEffect2 = goutil.findChild(self._goClickEffect, "type2")
end

function M:destroyUI()
	self._goInteractPanel = nil
	self._goStartInteractPanel = nil
	self._animStartInteractPanel = nil
	self._goFinishInteractPanel = nil
	self._animFinishInteractPanel = nil
	self._goInteractInfoPanel = nil
	self._goInteractFinishHint = nil
	self._goAffectHint = nil
	self._animAffectHint = nil
	self._txtAffectHint = nil
	self._btnFinished = nil
	self._btnHint = nil
end

function M:bindEvents()
	self._btnHint:AddClickListener(self._onClickHint, self)
	self._btnFinished:AddClickListener(self._onClickFinish, self)
	self._btnFull:AddClickListener(self._onClickFull, self)
end

function M:unbindEvents()
	self._btnHint:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btnFull:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:hideAllClue()
	goutil.setActive(self._btnHint.gameObject, false)
	goutil.setActive(self._goTips, true)

	self._roomMo = RoguelikeModel.instance:getCurRoomMo()

	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()

	goutil.setActive(self._goInteractFinishHint, false)
	goutil.setActive(self._goAffectHint, false)

	local eventId = replyCo.successEffect[1] or 0
	local eventCo = RoguelikeConfig.instance:getPlotEventById(eventId)

	self._eventCo = eventCo
	self._allTouchIds = {}

	if eventCo then
		self._allTouchIds = eventCo.touches
		self._curTouchedIds = self._roomMo:getToucheIds()
	else
		printError("找不到剧情事件id", eventId)
	end

	self:bindTouchEvents()
	self:showStartTips()
	settimer(kWaitHintBtnTime, self._delayShowHintBtn, self, false)
	self:checkInteractFinish()
end

function M:onExit()
	self:setEvent(false)
	self:hideAllClue()
	removetimer(self._endStartTips, self)
	removetimer(self._delayShowHintBtn, self)
	removetimer(self._delayHideEffectHint, self)
	removetimer(self._delayHideClueHint, self)
	removetimer(self._delayHideClickEffect, self)
	self:unBindTouchEvents()
end

function M:_delayShowHintBtn()
	goutil.setActive(self._btnHint.gameObject, true)
end

function M:showAllTips()
	local allTouchIds = RoguelikeModel.instance:getTouchIds()

	function IsTouched(touchId)
		for k, v in ipairs(allTouchIds) do
			if v == touchId then
				return true
			end
		end

		return false
	end

	for k, v in pairs(self._touchObjs) do
		local touchId = self._allTouchIds[k]

		v:setActive(not IsTouched(touchId))
	end
end

function M:hideAllClickedTips()
	local allTouchIds = RoguelikeModel.instance:getTouchIds()

	function IsTouched(touchId)
		for k, v in ipairs(allTouchIds) do
			if v == touchId then
				return true
			end
		end

		return false
	end

	for k, v in pairs(self._touchObjs) do
		local touchId = self._allTouchIds[k]

		if IsTouched(touchId) then
			v:setActive(false)
		end
	end
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_TOUCH_INFO_REFRESH, self._onTouchRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EXPLORE_INFO, self._onTouchRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_TOUCH_INFO_REFRESH, self._onTouchRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EXPLORE_INFO, self._onTouchRefresh, self)
	end
end

function M:_onTouchRefresh()
	self:checkInteractFinish()
	self:hideAllClickedTips()
end

function M:bindTouchEvents()
	self._touchBtns = {}
	self._touchObjs = {}

	local prefabName = ""

	if self._allTouchIds then
		local touchCo = RoguelikeConfig.instance:getTouchById(self._allTouchIds[1])

		if touchCo then
			prefabName = touchCo.prefabName
		end
	end

	for i = 0, self._goInteractPanel.transform.childCount - 1 do
		local tra = self._goInteractPanel.transform:GetChild(i)

		goutil.setActive(tra.gameObject, tra.name == prefabName)
	end

	for k, v in pairs(self._allTouchIds) do
		local touchCo = RoguelikeConfig.instance:getTouchById(v)

		if touchCo then
			local btnObj = goutil.findChild(self.mainGO, string.format("panel0/%s/%s/click", touchCo.prefabName, touchCo.name))

			if btnObj then
				local btn = UIComponentType.ButtonAdapter(btnObj)

				btn:AddClickListener(self["clickInteractArea" .. k], self)
				table.insert(self._touchBtns, btn)
			else
				printError("找不到路径", string.format("panel0/%s/%s", touchCo.prefabName, touchCo.name))
			end

			local interactObj = goutil.findChild(self.mainGO, string.format("panel0/%s/%s", touchCo.prefabName, touchCo.name))

			if interactObj then
				local touchObj = TouchObj.New(interactObj)

				table.insert(self._touchObjs, touchObj)
				touchObj:setActive(false)
			end
		end
	end
end

function M:unBindTouchEvents()
	for k, v in pairs(self._touchBtns) do
		v:RemoveClickListener()
	end
end

function M:onAreaClick(idx)
	local touchId = self._allTouchIds[idx]

	if not touchId then
		printError("没有触摸id" .. idx)

		return
	end

	local allTouchIds = RoguelikeModel.instance:getTouchIds()

	function IsTouched(touchId)
		for k, v in ipairs(allTouchIds) do
			if v == touchId then
				return true
			end
		end

		return false
	end

	if IsTouched(self._allTouchIds[idx]) then
		print("点击区域已点击过")

		return
	end

	self:changeClickEffect()

	self._touchId = touchId

	local touchCo = RoguelikeConfig.instance:getTouchById(touchId)

	if touchCo and touchCo.plot ~= nil and touchCo.plot ~= 0 then
		StoryMgr.instance:startSingle(touchCo.plot, false, self.onStoryFinished, self, true)
	end
end

function M:onStoryFinished()
	local touchCo = RoguelikeConfig.instance:getTouchById(self._touchId)

	if touchCo then
		local effectIds = touchCo.effectIds or {}
		local desc = ""

		if #effectIds > 0 then
			local effectCo = RoguelikeConfig.instance:getEffectById(effectIds[1])

			desc = effectCo.description
		end

		RoguelikeController.instance:getEffectParams(effectIds, function(roleId, attr)
			RoguelikeAgent.instance:sendTouchRequest(self._touchId, roleId, attr)

			if desc ~= "" then
				self._txtAffectHint.text = StringUtil.replaceAllGraphicText2(desc)

				goutil.setActive(self._goAffectHint, true)
				self._animAffectHint:Stop()
				self._animAffectHint:Play("mask_affecthint_open")
				removetimer(self._delayHideEffectHint, self)
				settimer(kHideEffectHintTime, self._delayHideEffectHint, self)
			end
		end)
	end

	self:checkInteractFinish()
end

function M:_delayHideEffectHint()
	goutil.setActive(self._goAffectHint, false)
end

function M:clickInteractArea1()
	self:onAreaClick(1)
end

function M:clickInteractArea2()
	self:onAreaClick(2)
end

function M:clickInteractArea3()
	self:onAreaClick(3)
end

function M:clickInteractArea4()
	self:onAreaClick(4)
end

function M:clickInteractArea5()
	self:onAreaClick(5)
end

function M:showStartTips()
	goutil.setActive(self._goStartInteractPanel, true)
	goutil.setActive(self._goInteractInfoPanel, false)
	self._animStartInteractPanel:Stop()
	self._animStartInteractPanel:Play("run_group_survey_view_panel1_open")
	settimer(1.233, self._endStartTips, self, false)
end

function M:_endStartTips()
	goutil.setActive(self._goStartInteractPanel, false)
	goutil.setActive(self._goInteractInfoPanel, true)
end

function M:showFinishTips()
	goutil.setActive(self._goFinishInteractPanel, true)
	goutil.setActive(self._goInteractInfoPanel, false)
	self._animFinishInteractPanel:Stop()
	self._animFinishInteractPanel:Play("run_group_survey_view_panel1_open")
	settimer(1.233, self._endFinishTips, self, false)
end

function M:_endFinishTips()
	goutil.setActive(self._goFinishInteractPanel, false)
	goutil.setActive(self._goInteractInfoPanel, true)
	self:_onClickFinish()
end

function M:checkInteractFinish()
	local totalInteractNum = #self._allTouchIds
	local curInteractNum = 0
	local allTouchIds = RoguelikeModel.instance:getTouchIds()

	function IsTouched(touchId)
		for k, v in ipairs(allTouchIds) do
			if v == touchId then
				return true
			end
		end

		return false
	end

	for k, v in pairs(self._allTouchIds) do
		if IsTouched(v) then
			curInteractNum = curInteractNum + 1
		end
	end

	for k, v in pairs(self._touchObjs) do
		local touchId = self._allTouchIds[k]

		v:setIsTouched(IsTouched(touchId))
	end

	if totalInteractNum <= curInteractNum then
		goutil.setActive(self._goInteractFinishHint, true)
		goutil.setActive(self._btnHint.gameObject, false)
		goutil.setActive(self._goTips, false)
		self:showAllClue()
		removetimer(self._delayHideClueHint, self)
		settimer(kHideEffectHintTime, self._delayHideClueHint, self)
	end
end

function M:_delayHideClueHint()
	self:hideAllClue()
	self:showFinishTips()
end

function M:hideAllClue()
	local _getClueMark

	for k, v in pairs(self._goGetClueItems) do
		if not _getClueMark and v.gameObject.activeSelf then
			_getClueMark = true
		end

		goutil.setActive(v, false)
	end

	if _getClueMark then
		self._animGetClue:Stop()
		self._animGetClue:Play("propcontent_close")
	end
end

function M:showAllClue()
	local clueIds = {}

	for k, v in pairs(self._allTouchIds) do
		local touchCo = RoguelikeConfig.instance:getTouchById(v)
		local effectIds = touchCo.effectIds or {}

		if #effectIds > 0 then
			for k1, v1 in pairs(effectIds) do
				local effectCo = RoguelikeConfig.instance:getEffectById(v1)

				if effectCo and effectCo.program == "GetClue" then
					table.insert(clueIds, tonumber(effectCo.params))
				end
			end
		end
	end

	local _getClueMark

	for k, v in pairs(clueIds) do
		if self._goGetClueItems[k] ~= nil then
			local icon = goutil.findChildImageComponent(self._goGetClueItems[k], "icon")
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(v)

			if itemCo and icon then
				IconLoader.setSprite(icon, IconType.ItemIcon, itemCo.icon)
			else
				printError("找不到线索", v, itemCo)
			end

			goutil.setActive(self._goGetClueItems[k], true)

			_getClueMark = true
		end
	end

	if _getClueMark then
		self._animGetClue:Stop()
		self._animGetClue:Play("propcontent_open")
	end
end

function M:_onClickHint()
	self:showAllTips()
	FloatWordMgr.instance:show(lang("tip_r_survey_explore"))
end

function M:playEndPlot()
	local eventCo = self._eventCo

	if eventCo and eventCo.poststory ~= "" then
		local plotId = tonumber(eventCo.poststory)

		if not RoguelikeConst.IsAllowStory(plotId) then
			-- block empty
		end

		StoryMgr.instance:startSingle(plotId, false, self._onPlotPostStoryFinish, self)
		RoguelikeConst.SetStoryPlayed(plotId)
	else
		self:_onPlotPostStoryFinish()
	end
end

function M:_onPlotPostStoryFinish()
	self:close()
	RogueMgr.instance:getRogueFlow().judgeMgr:saveEmptyJudgeArchive(nil)
	RoguelikeAgent.instance:sendEndJudgeRequest(2, true)
end

function M:_onClickFinish()
	self:playEndPlot()
end

function M:_onClickFull()
	local mousePos = MainPlayerInputFacade.instance:getScreenPosition()
	local x, y = RectTransformUtils.ScreenPointToLocalPointInRectangle(self._btnFull.transform, mousePos.x, mousePos.y, kUiCamera, 0, 0)
	local newPos = Vector2.New(x, y)

	self._goClickEffect.transform.localPosition = newPos

	if self._goClickEffect2.activeInHierarchy then
		return
	end

	goutil.setActive(self._goClickEffect1, false)
	goutil.setActive(self._goClickEffect1, true)
end

function M:changeClickEffect()
	goutil.setActive(self._goClickEffect1, false)
	goutil.setActive(self._goClickEffect2, false)
	goutil.setActive(self._goClickEffect2, true)
	removetimer(self._delayHideClickEffect, self)
	settimer(0.5, self._delayHideClickEffect, self, false)
end

function M:_delayHideClickEffect()
	goutil.setActive(self._goClickEffect2, false)
end

return M
