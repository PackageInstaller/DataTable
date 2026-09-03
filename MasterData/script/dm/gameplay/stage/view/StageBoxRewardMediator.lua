-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StageBoxRewardMediator.lua

StageBoxRewardMediator = class("StageBoxRewardMediator", DmPopupViewMediator, _M)

StageBoxRewardMediator:has("_stageFacade", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	["mMainPanel.mStateBtn.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onStateBtn"
	}
}
local kIconWigth = 110
local kIconDistance = 18

function StageBoxRewardMediator:initialize()
	super.initialize(self)
end

function StageBoxRewardMediator:dispose()
	super.dispose(self)
end

function StageBoxRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("mMainPanel.mStateBtn", OneLevelViceButton, {})
end

function StageBoxRewardMediator:onRemove()
	super.onRemove(self)
end

function StageBoxRewardMediator:enterWithData(data)
	self._data = data

	self:initWidget()
	self:refreshView()
	self:setupClickEnvs()
end

function StageBoxRewardMediator:initWidget()
	self._bgWidget = bindWidget(self, "mMainPanel.bg", PopupNormalWidget, {
		fontSize = 50,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onBackBtn, self)
		},
		title = Strings:find("CUSTOM_REWARD_TITLE" .. self._data.type),
		title1 = Strings:get("UITitle_EN_Pingxingjiangli")
	})
	self._pointNameLabel = self:getView():getChildByFullName("mMainPanel.mPointNameLabel")
	self._starNode = self:getView():getChildByFullName("mMainPanel.star")
	self._curStarCount = self:getView():getChildByFullName("mMainPanel.star.mCurStarCount")
	self._allStarCount = self:getView():getChildByFullName("mMainPanel.star.mAllStarCount")
	self._rewardLayout = self:getView():getChildByFullName("mMainPanel.mRewardLayout")
	self._stateBtn = self:getView():getChildByFullName("mMainPanel.mStateBtn")
	self._stateLabel = self:getView():getChildByFullName("mMainPanel.mStateBtn.name")
	self._labelEn = self:getView():getChildByFullName("mMainPanel.mStateBtn.name1")
	self._gotImage = self:getView():getChildByFullName("mMainPanel.signOver")

	local text1 = self._starNode:getChildByName("Text_1")

	text1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text2 = self._starNode:getChildByName("Text_2")

	text2:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function StageBoxRewardMediator:refreshView()
	self._pointNameLabel:setVisible(self._data.type == StageRewardType.kBoxPoint)
	self._starNode:setVisible(self._data.type == StageRewardType.kStarBox)

	if self._data.extra then
		self._pointNameLabel:setString(self._data.extra[1])
		self._curStarCount:setString(self._data.extra[1])
	end

	if self._data.extra then
		self._allStarCount:setString("/" .. self._data.extra[2])
	end

	self._allStarCount:setTextColor(cc.c3b(255, 255, 255))
	self._allStarCount:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._curStarCount:setTextColor(cc.c3b(205, 250, 100))
	self._curStarCount:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	if self._data.state == StageBoxState.kCannotReceive then
		self._gotImage:setVisible(false)
		self._stateLabel:setString(Strings:get("Common_button1"))
		self._labelEn:setString(Strings:get("UITitle_EN_Queding"))
		self._curStarCount:setTextColor(cc.c3b(255, 135, 135))
	elseif self._data.state == StageBoxState.kCanReceive then
		self._gotImage:setVisible(false)
		self._stateLabel:setString(Strings:find("CUSTOM_REWARD_CAN_RECEIVE"))
		self._labelEn:setString(Strings:find("UITitle_EN_Lingqu"))
	else
		self._stateBtn:setVisible(false)
		self._gotImage:setVisible(true)
	end

	local rewardCfg = ConfigReader:getRecordById("Reward", self._data.rewardId)
	local rewardBgWidth = self._rewardLayout:getContentSize().width
	local rewardNum = #rewardCfg.Content
	local icon1XPos = rewardBgWidth / 2 - (rewardNum - 1) * (kIconWigth / 2 + kIconDistance / 2)

	for k, rewardInfo in ipairs(rewardCfg.Content) do
		local child = IconFactory:createRewardIcon(rewardInfo, {
			isWidget = true
		})

		IconFactory:bindTouchHander(child, IconTouchHandler:new(self), rewardInfo, {
			needDelay = true
		})

		if child then
			local xPos = icon1XPos + (k - 1) * (kIconDistance + kIconWigth)

			child:setScaleNotCascade(0.8)
			child:setPosition(cc.p(xPos, 50))
			self._rewardLayout:addChild(child)
		end
	end

	local abc = self:getView():getChildByFullName("mMainPanel.mStateBtn.button")

	abc:removeAllChildren()

	if self._data.guide then
		local animNode = cc.Node:create()

		animNode:addTo(abc):center(abc:getContentSize()):offset(0, 0)

		local circleAnim = cc.MovieClip:create("anim_xinyindaoguangquan")

		circleAnim:addTo(animNode):center(animNode:getContentSize()):offset(0, 0)

		local handAnim = cc.MovieClip:create("xiaoshou_xinshouyindao")

		handAnim:addTo(animNode):center(animNode:getContentSize()):offset(5, -5)

		local handNode = handAnim:getChildByName("handNode")

		if handNode then
			local image = ccui.ImageView:create("xsyd_shou.png", ccui.TextureResType.plistType)

			image:addTo(handNode)
		end
	end
end

function StageBoxRewardMediator:onStateBtn(sender, eventType)
	if self._data.callback then
		self._data.callback()
	end

	self:close()
end

function StageBoxRewardMediator:onBackBtn(sender, eventType)
	if self._data.closeback then
		self._data.closeback()
	end

	self:close()
end

function StageBoxRewardMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)

	if self._data.closeback then
		self._data.closeback()
	end

	self:close()
end

function StageBoxRewardMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local button = self:getView():getChildByFullName("mMainPanel.mStateBtn.button")

		storyDirector:setClickEnv("StageBoxRewardMediator.button", button, function()
			AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
			self:onStateBtn()
		end)
		storyDirector:notifyWaiting("enter_StageBoxRewardMediator")
	end))

	self:getView():runAction(sequence)
end
