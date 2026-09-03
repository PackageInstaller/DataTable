-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivitySagaWinWxhMediator.lua

ActivitySagaWinWxhMediator = class("ActivitySagaWinWxhMediator", DmPopupViewMediator, _M)

ActivitySagaWinWxhMediator:has("_rankSystem", {
	is = "rw"
}):injectWith("RankSystem")
ActivitySagaWinWxhMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.showScheduleBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickShowScheduleBtn"
	}
}

function ActivitySagaWinWxhMediator:initialize()
	super.initialize(self)
end

function ActivitySagaWinWxhMediator:dispose()
	self:disposeView()
	super.dispose(self)
end

function ActivitySagaWinWxhMediator:disposeView()
	self:stopEffect()
end

function ActivitySagaWinWxhMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:getView():getChildByFullName("main.renqiPanel.value2"):setString(Strings:get("Activity_Saga_UI_33"))
	self:getView():getChildByFullName("main.tip"):setString(Strings:get("Activity_Saga_UI_34"))
	self:getView():getChildByFullName("main.showScheduleBtn.txt"):setString(Strings:get("Activity_Saga_UI_32"))

	self._nameNode = self:getView():getChildByFullName("main.name")

	self._nameNode:getVirtualRenderer():setLineSpacing(-10)

	self._zongrenqiwenzi = self:getView():getChildByFullName("main.renqiPanel.value2")
	self._zongrenqizhi = self:getView():getChildByFullName("main.renqiPanel.value1")

	self._zongrenqizhi:enableOutline(cc.c4b(129, 57, 67, 178.5), 2)

	self._showScheduleBtn = self:getView():getChildByFullName("main.showScheduleBtn")
	self._talkBg = self:getView():getChildByFullName("main.talkBg")
end

function ActivitySagaWinWxhMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlockZuoHe
	self._activity = self._activitySystem:getActivityById(self._activityId)

	self:initData()
	self:initView()
end

function ActivitySagaWinWxhMediator:resumeWithData()
	return
end

function ActivitySagaWinWxhMediator:refreshView()
	self:initData()
	self:initView()
end

function ActivitySagaWinWxhMediator:initData()
	self._heroId = self._activity:getWinHeroId()
	self._winPopularity = self._activity:getWinPopularity()
end

function ActivitySagaWinWxhMediator:initView()
	self:initContent()
	self:showBeginAnimation()
end

function ActivitySagaWinWxhMediator:initContent()
	local hd = self._activity:getHeroDataById(self._heroId)

	if not hd then
		return
	end

	self._roleNode = self:getView():getChildByFullName("main.roleNode")

	self._roleNode:removeAllChildren()

	local modelId = hd.ModelId
	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = modelId
	})

	img:addTo(self._roleNode):posite(0, 0)
	img:setScale(0.8)

	local name = ConfigReader:requireRecordById("RoleModel", modelId).Name

	self._nameNode:setString(Strings:get(name))
	self:getView():getChildByFullName("main.renqiPanel.value1"):setString(self._winPopularity)

	local bubble = hd.Bubble.Winner

	self:getView():getChildByFullName("main.talkBg.content"):setString(Strings:get(bubble.tip))
	self:stopEffect()

	self._heroEffect, _ = AudioEngine:getInstance():playEffect(bubble.sound, false, function()
		return
	end)
end

function ActivitySagaWinWxhMediator:stopEffect()
	if self._heroEffect then
		AudioEngine:getInstance():stopEffect(self._heroEffect)

		self._heroEffect = nil
	end
end

function ActivitySagaWinWxhMediator:onClickShowScheduleBtn()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSagaSupportSchedule(self._activityId)
end

function ActivitySagaWinWxhMediator:showBeginAnimation()
	local animNode = self:getView():getChildByFullName("main.animNode")

	self._bgAnim = cc.MovieClip:create("wuxiupailian_wuxiupailian")

	self._bgAnim:addTo(animNode)
	self._bgAnim:addCallbackAtFrame(75, function()
		self._bgAnim:gotoAndStop(30)
	end)

	local yanhua1 = self._bgAnim:getChildByFullName("yanhua1")

	yanhua1:addCallbackAtFrame(45, function()
		yanhua1:stop()
	end)

	local yanhua2 = self._bgAnim:getChildByFullName("yanhua2")

	yanhua2:addCallbackAtFrame(45, function()
		yanhua2:stop()
	end)

	local nodeToActionMap = {}

	nodeToActionMap[self._talkBg] = self._bgAnim:getChildByFullName("shuohua")
	nodeToActionMap[self._roleNode] = self._bgAnim:getChildByFullName("ren")
	nodeToActionMap[self._showScheduleBtn] = self._bgAnim:getChildByFullName("chakansaicheng")
	nodeToActionMap[self._zongrenqizhi] = self._bgAnim:getChildByFullName("renqi")
	nodeToActionMap[self._nameNode] = self._bgAnim:getChildByFullName("mingzi")

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

	startFunc()
end
