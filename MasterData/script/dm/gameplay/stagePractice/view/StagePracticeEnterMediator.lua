-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeEnterMediator.lua

StagePracticeEnterMediator = class("StagePracticeEnterMediator", DmAreaViewMediator, _M)

StagePracticeEnterMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StagePracticeEnterMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")
StagePracticeEnterMediator:has("_mazeTowerSystem", {
	is = "r"
}):injectWith("MazeTowerSystem")

local kBtnHandlers = {
	touch_1 = {
		ignoreClickAudio = true,
		func = "onClickEasy"
	},
	touch_2 = {
		ignoreClickAudio = true,
		func = "onClickMazeTower"
	},
	touch_3 = {
		ignoreClickAudio = true,
		func = "onClickHard"
	}
}
local contips = {
	[2] = "StagePractice_Text22",
	[3] = "StagePractice_Text23"
}
local kEnterAnimNodeTag = 1111

function StagePracticeEnterMediator:initialize()
	super.initialize(self)
end

function StagePracticeEnterMediator:dispose()
	super.dispose(self)
end

function StagePracticeEnterMediator:userInject()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
end

function StagePracticeEnterMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function StagePracticeEnterMediator:enterWithData(data)
	self:refreshData()
	self:refreshView()
	self:setupTopInfoWidget()
	self:setupClickEnvs()
	self:showAni()
end

function StagePracticeEnterMediator:didFinishResumeTransition()
	self:refreshView()
	self:showAni()
end

function StagePracticeEnterMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = {}
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("StagePractice_Btn_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function StagePracticeEnterMediator:showAni()
	local enterAnimPanel = self:getView():getChildByFullName("enterAnimPanel")

	if enterAnimPanel:getChildByTag(kEnterAnimNodeTag) then
		enterAnimPanel:removeChildByTag(kEnterAnimNodeTag, true)
	end

	local enterAnim = cc.MovieClip:create("mengyanyanjiusuo_mengyanyanjiusuo")
	local practiceBtnAnim = enterAnim:getChildByName("lianxi")
	local challengeBtnAnim = enterAnim:getChildByName("tiaozhan")
	local combatBtnAnim = enterAnim:getChildByName("shizhan")

	challengeBtnAnim:setOpacity(self._canShow[2] and challengeBtnAnim:getOpacity() or 0)
	combatBtnAnim:setOpacity(self._canShow[3] and combatBtnAnim:getOpacity() or 0)
	enterAnim:addCallbackAtFrame(13, function()
		practiceBtnAnim:gotoAndPlay(1)
	end)
	enterAnim:addCallbackAtFrame(15, function()
		challengeBtnAnim:gotoAndPlay(1)
	end)
	enterAnim:addCallbackAtFrame(17, function()
		combatBtnAnim:gotoAndPlay(1)
	end)
	enterAnim:addEndCallback(function(cid, mc)
		mc:stop()
		practiceBtnAnim:stop()
		challengeBtnAnim:stop()
		combatBtnAnim:stop()
	end)
	enterAnim:addTo(enterAnimPanel, 0, kEnterAnimNodeTag)

	local action = cc.CSLoader:createTimeline("asset/ui/StagePracticeEnter.csb")

	self:getView():runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 50, false)
	action:setTimeSpeed(1)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		for i = 1, 3 do
			if str == string.format("redPoint%d", i) then
				self:setRedPoint(i)

				break
			end
		end
	end

	action:clearFrameEventCallFunc()
	action:setFrameEventCallFunc(onFrameEvent)
end

function StagePracticeEnterMediator:setRedPoint(index)
	local redPoint = self:getView():getChildByFullName(string.format("model_%d.redPoint", index))

	if index == 2 then
		redPoint:setVisible(self._mazeTowerSystem:hasRedPoint())
	else
		redPoint:setVisible(self._stagePracticeSystem:mapHasRedPoint(index))
	end
end

function StagePracticeEnterMediator:refreshData()
	self._stagePractice = self._stagePracticeSystem:getStagePractice()
	self._canShow = self._canShow or {}

	for i = 1, 3 do
		self._canShow[i] = self._stagePracticeSystem:canShow(i)
	end
end

function StagePracticeEnterMediator:refreshView()
	for i = 1, 3 do
		local model = self:getView():getChildByFullName("model_" .. i)
		local redpoint = model:getChildByFullName("redPoint")

		if redpoint then
			redpoint:setVisible(false)
		end

		local touch = self:getView():getChildByFullName("touch_" .. i)

		if i ~= 1 then
			local canShow = self._canShow[i]

			touch:setVisible(canShow)
			touch:setTouchEnabled(canShow)
			model:setVisible(canShow)
		end
	end
end

function StagePracticeEnterMediator:resumeWithData()
	self:refreshData()
	self:refreshView()
end

function StagePracticeEnterMediator:onClickBack()
	self:dismiss()
end

function StagePracticeEnterMediator:onClickEasy(sender)
	self:enterPracticeMain(sender:getName())
end

function StagePracticeEnterMediator:onClickNormal(sender)
	self:enterPracticeMain(sender:getName())
end

function StagePracticeEnterMediator:onClickHard(sender)
	self:enterPracticeMain(sender:getName())
end

function StagePracticeEnterMediator:enterPracticeMain(model)
	local tag = tonumber(string.split(model, "_")[2])
	local mapData = self._stagePractice:getMapByIndex(tag)

	if mapData:isLock() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		local condition = mapData:getStarCondition()
		local pointpass = mapData:getPreMapPass()
		local levelpass = self._developSystem:getLevel() >= mapData:getShowCondition().LEVEL

		if not levelpass then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("PM02_UnlockTips")
			}))
		else
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get(contips[tag])
			}))
		end

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

	local view = self:getInjector():getInstance("StagePracticeMainView")
	local data = {
		isInit = true,
		mapIndex = tag
	}

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
end

function StagePracticeEnterMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local model_1 = self:getView():getChildByFullName("model_1")

		if model_1 then
			storyDirector:setClickEnv("StagePracticeEnter.esay", model_1, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:enterPracticeMain("model_1")
			end)
		end

		storyDirector:notifyWaiting("enter_StagePracticeEnter_view")
	end))

	self:getView():runAction(sequence)
end

function StagePracticeEnterMediator:onClickMazeTower()
	self._mazeTowerSystem:tryEnter()
end
