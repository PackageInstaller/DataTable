-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/home/Navigation.lua

require("dm.gameplay.home.view.home.NavigationItem")

Navigation = class("Navigation", objectlua.Object, _M)
NavigationItemType = {
	kBottom = 1,
	kTop = 3,
	kLeft = 2,
	kRight = 0
}

function Navigation:initialize(bottomLayout, rightLayout, leftLayout, topFunLayout, urlLayout, injector)
	super.initialize(self)

	self._bottomLayout = bottomLayout
	self._rightLayout = rightLayout
	self._leftLayout = leftLayout
	self._topLayout = topFunLayout
	self._urlLayout = urlLayout
	self._injector = injector
	self._initDone = false

	AdjustUtils.ignorSafeAreaRectForNode(self._rightLayout, AdjustUtils.kAdjustType.Right)
	self:init()
end

function Navigation:init()
	self._rightList = {}
	self._bottomList = {}
	self._leftList = {}
	self._topList = {}
	self._navOpen = true
	self._topLayoutFoldBtn = self._topLayout:getChildByFullName("mFoldBtn")
	self._topOpen = false
	self._interval = 55

	self:updataTopNode()
end

function Navigation:updataTopNode()
	self._topNodes = {}

	local unlockSystem = self:getInjector():getInstance(SystemKeeper)
	local settingSystem = self:getInjector():getInstance(SettingSystem)
	local mFriendNode = self._topLayout:getChildByFullName("mFriendNode")

	if unlockSystem:canShow("Friend_Entrance") then
		mFriendNode:setVisible(true)

		self._topNodes[#self._topNodes + 1] = mFriendNode
	else
		mFriendNode:setVisible(false)
	end

	self._topNodes[#self._topNodes + 1] = self._topLayout:getChildByFullName("mMailNode")
	self._topNodes[#self._topNodes + 1] = self._topLayout:getChildByFullName("mBagNode")

	local mRankNode = self._topLayout:getChildByFullName("mRankNode")

	if CommonUtils.GetSwitch("fn_rank") and unlockSystem:canShow("Rank_Main") then
		mRankNode:setVisible(true)

		self._topNodes[#self._topNodes + 1] = mRankNode
	else
		mRankNode:setVisible(false)
	end

	local mChatNode = self._topLayout:getChildByFullName("mChatNode")

	if unlockSystem:canShow("Chat_System") then
		mChatNode:setVisible(true)

		self._topNodes[#self._topNodes + 1] = mChatNode
	else
		mChatNode:setVisible(false)
	end

	local mDownNode = self._topLayout:getChildByFullName("mDownNode")
	local canDownload = settingSystem:canDownloadPortrait() or settingSystem:canDownloadSoundCV()

	if canDownload then
		mDownNode:setVisible(true)

		self._topNodes[#self._topNodes + 1] = mDownNode
	else
		mDownNode:setVisible(false)
	end

	self._topNodes[#self._topNodes + 1] = self._topLayout:getChildByFullName("mAnnounceNode")

	local mYxqNode = self._topLayout:getChildByFullName("mYxqNode")

	if SDKHelper and SDKHelper:isEnableSdk() and SDKHelper:readCacheValue("showYxq") then
		mYxqNode:setVisible(true)

		self._topNodes[#self._topNodes + 1] = self._topLayout:getChildByFullName("mYxqNode")
	else
		mYxqNode:setVisible(false)
	end

	local mPassNode = self._topLayout:getChildByFullName("mPassNode")

	if CommonUtils.GetSwitch("fn_pass") then
		mPassNode:setVisible(true)

		local anim = cc.MovieClip:create("m1_tongxingzhengrukou")

		anim:addEndCallback(function(cid, mc)
			anim:stop()
		end)

		local passMovie = mPassNode:getChildByFullName("mMovieClip")

		passMovie:removeAllChildren()
		anim:addTo(passMovie):center(passMovie:getContentSize()):offset(0, 10)

		self._topNodes[#self._topNodes + 1] = mPassNode
	else
		mPassNode:setVisible(false)
	end
end

function Navigation:openNavigation()
	if self._navOpen then
		return
	end

	self._navOpen = true
end

function Navigation:closeNavigation()
	if not self._navOpen then
		return
	end

	self._navOpen = false
end

function Navigation:isTopOpen()
	return self._topOpen
end

function Navigation:openTop()
	if self._topOpen then
		return
	end

	self:openAction()

	self._topOpen = true
end

function Navigation:openAction()
	local basePosX, basePosY = self._topLayoutFoldBtn:getPosition()

	basePosY = basePosY - 1

	if CommonUtils.GetSwitch("fn_pass") then
		if not (#self._topNodes - 1) then
			local btnNum = #self._topNodes

			for i = 1, btnNum do
				local node = self._topNodes[i]

				node:setVisible(true)
				node:getChildByFullName("mTouchLayer"):setTouchEnabled(false)

				local action = i == 1 and cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.1, cc.p(basePosX - self._interval, basePosY)), cc.FadeIn:create(0.1)), cc.CallFunc:create(function()
					node:getChildByFullName("mTouchLayer"):setTouchEnabled(true)
				end)) or cc.Spawn:create(cc.MoveTo:create(i * 0.1, cc.p(basePosX - i * self._interval, basePosY)), cc.Sequence:create(cc.DelayTime:create((i - 1) * 0.1), cc.FadeIn:create(0.1), cc.CallFunc:create(function()
					node:getChildByFullName("mTouchLayer"):setTouchEnabled(true)
				end)))

				node:stopAllActions()
				node:runAction(action)
			end

			if CommonUtils.GetSwitch("fn_pass") then
				self._topNodes[#self._topNodes]:stopAllActions()
				self._topNodes[#self._topNodes]:runAction(cc.MoveTo:create(#self._topNodes * 0.1, cc.p(basePosX - #self._topNodes * self._interval - 11, 31)))
			end
		end
	end
end

function Navigation:closeTop()
	if not self._topOpen then
		return
	end

	self:closeAction()

	self._topOpen = false
end

function Navigation:closeAction()
	local basePosX, basePosY = self._topLayoutFoldBtn:getPosition()

	basePosY = basePosY - 1

	if CommonUtils.GetSwitch("fn_pass") then
		if not (#self._topNodes - 1) then
			local btnNum = #self._topNodes

			for i = 1, btnNum do
				local node = self._topNodes[i]

				node:getChildByFullName("mTouchLayer"):setTouchEnabled(false)

				local action = i == #self._topNodes and cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(i * 0.1, cc.p(basePosX, basePosY)), cc.FadeOut:create(0.1)), cc.Hide:create()) or cc.Sequence:create(cc.DelayTime:create((#self._topNodes - i) * 0.1), cc.Spawn:create(cc.MoveTo:create(i * 0.1, cc.p(basePosX, basePosY)), cc.FadeOut:create(0.1)), cc.Hide:create())

				node:stopAllActions()
				node:runAction(action)
			end

			if CommonUtils.GetSwitch("fn_pass") then
				self._topNodes[#self._topNodes]:stopAllActions()
				self._topNodes[#self._topNodes]:runAction(cc.MoveTo:create(#self._topNodes * 0.1, cc.p(basePosX - 66, 31)))
			end
		end
	end
end

function Navigation:checkTopRedPoint()
	if self._topOpen then
		return false
	end

	for i = 1, #self._topNodes do
		local node = self._topNodes[i]
		local redPoint = node:getChildByFullName("mRedSprite")

		if redPoint and redPoint:isVisible() then
			return true
		end
	end

	return false
end
