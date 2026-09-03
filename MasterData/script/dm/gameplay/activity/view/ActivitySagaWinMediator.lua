-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivitySagaWinMediator.lua

ActivitySagaWinMediator = class("ActivitySagaWinMediator", DmPopupViewMediator, _M)

ActivitySagaWinMediator:has("_rankSystem", {
	is = "rw"
}):injectWith("RankSystem")
ActivitySagaWinMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.showScheduleBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickShowScheduleBtn"
	}
}

function ActivitySagaWinMediator:initialize()
	super.initialize(self)
end

function ActivitySagaWinMediator:dispose()
	self:disposeView()
	super.dispose(self)
end

function ActivitySagaWinMediator:disposeView()
	self:stopEffect()
end

function ActivitySagaWinMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:getView():getChildByFullName("main.renqiPanel.value2"):setString(Strings:get("Activity_Saga_UI_33"))
	self:getView():getChildByFullName("main.tip"):setString(Strings:get("Activity_Saga_UI_34"))
	self:getView():getChildByFullName("main.showScheduleBtn.txt"):setString(Strings:get("Activity_Saga_UI_32"))

	self._nameNode = self:getView():getChildByFullName("main.name")

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 245, 254, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 243, 177, 255)
		}
	}
	local lineGradiantDir2 = {
		x = 0,
		y = -1
	}

	self._nameNode:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir2))
	self._nameNode:enableOutline(cc.c4b(23, 24, 28, 255), 2)
	self._nameNode:enableShadow(cc.c4b(17, 20, 49, 255), cc.size(2, 0), 3)
end

function ActivitySagaWinMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlockZuoHe
	self._activity = self._activitySystem:getActivityById(self._activityId)

	self:initData()
	self:initView()
end

function ActivitySagaWinMediator:resumeWithData()
	return
end

function ActivitySagaWinMediator:refreshView()
	self:initData()
	self:initView()
end

function ActivitySagaWinMediator:initData()
	self._heroId = self._activity:getWinHeroId()
	self._winPopularity = self._activity:getWinPopularity()
end

function ActivitySagaWinMediator:initView()
	self:initContent()
	self:showBeginAnimation()
end

function ActivitySagaWinMediator:initContent()
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

function ActivitySagaWinMediator:stopEffect()
	if self._heroEffect then
		AudioEngine:getInstance():stopEffect(self._heroEffect)

		self._heroEffect = nil
	end
end

function ActivitySagaWinMediator:onClickShowScheduleBtn()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSagaSupportSchedule(self._activityId)
end

function ActivitySagaWinMediator:showBeginAnimation()
	local animNode = self:getView():getChildByFullName("main.animNode")

	self._bgAnim = cc.MovieClip:create("zuohepailian_zuohepailianhuodong")

	self._bgAnim:addTo(animNode)

	local childs = self._bgAnim:getChildren()

	for i = 1, #childs do
		local child = childs[i]

		if child then
			child:addEndCallback(function()
				child:stop()
			end)
		end
	end

	local talkBg = self:getView():getChildByFullName("main.talkBg")
	local shuohua = self._bgAnim:getChildByFullName("shuohua")
	local nodeToActionMap = {}

	nodeToActionMap[talkBg] = shuohua:getChildByFullName("dongzuo")

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

	startFunc()
	shuohua:addCallbackAtFrame(99, function()
		stopFunc()
	end)

	local ren = self._bgAnim:getChildByFullName("ren")
	local nodeToActionMap = {}

	nodeToActionMap[self._roleNode] = ren:getChildByFullName("dongzuo")

	local startFunc1, stopFunc1 = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

	startFunc1()
	ren:addCallbackAtFrame(99, function()
		stopFunc1()
	end)

	local showScheduleBtn = self:getView():getChildByFullName("main.showScheduleBtn")
	local chakansaicheng = self._bgAnim:getChildByFullName("chakansaicheng")
	local nodeToActionMap = {}

	nodeToActionMap[showScheduleBtn] = chakansaicheng:getChildByFullName("dongzuo")

	local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

	startFunc2()
	ren:addCallbackAtFrame(99, function()
		stopFunc2()
	end)

	local renqiPanel = self:getView():getChildByFullName("main.renqiPanel")
	local renqi = self._bgAnim:getChildByFullName("renqi")
	local nodeToActionMap = {}

	nodeToActionMap[renqiPanel] = renqi:getChildByFullName("dongzuo")

	local startFunc4, stopFunc4 = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

	startFunc4()
	ren:addCallbackAtFrame(99, function()
		stopFunc4()
	end)

	local name = self:getView():getChildByFullName("main.name")
	local mingzi = self._bgAnim:getChildByFullName("mingzi")
	local nodeToActionMap = {}

	nodeToActionMap[name] = mingzi:getChildByFullName("dongzuo")

	local startFunc5, stopFunc5 = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

	startFunc5()
	ren:addCallbackAtFrame(99, function()
		stopFunc5()
	end)
end
