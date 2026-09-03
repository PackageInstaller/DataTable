-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/BossStageCommonCell.lua

BossStageCommonCell = class("BossStageCommonCell", DisposableObject, _M)

local inlineState = {
	kUnlock = 0,
	kFirstPass = 2,
	kNotPass = 1,
	kReadyPass = 3
}

function BossStageCommonCell:initialize(view, info)
	super.initialize(self)

	self._view = view
	self._mediator = info.mediator
	self._point = info.point
	self._index = info.index
	self._state = inlineState.kUnlock

	self:initAnim()
end

function BossStageCommonCell:getView()
	return self._view
end

function BossStageCommonCell:refreshState(stageState, isUnlock, isPass)
	if stageState then
		self._state = stageState
	end

	if self._state == inlineState.kUnlock then
		self:getView():setVisible(false)

		if isUnlock then
			self:getView():setVisible(true)
			self._mc:gotoAndPlay(1)

			self._state = inlineState.kNotPass
		end
	end

	if self._state == inlineState.kNotPass then
		self:getView():setVisible(true)
		self._mc:gotoAndPlay(1)

		if isPass then
			self._state = inlineState.kFirstPass
		end
	elseif self._state == inlineState.kFirstPass then
		self:getView():setVisible(true)
		self._mc:gotoAndStop(30)

		if isPass then
			self._state = inlineState.kReadyPass
		end
	elseif self._state == inlineState.kReadyPass then
		self:getView():setVisible(true)
		self._mc:gotoAndStop(30)
	end
end

function BossStageCommonCell:reloadBar()
	local hpRate = self._point:getHpRate()

	self._bar:setPercent(hpRate * 100)
end

function BossStageCommonCell:initAnim()
	local mc

	if self._index == 1 then
		mc = cc.MovieClip:create("a_caidanboss")
	elseif self._index == 2 then
		mc = cc.MovieClip:create("c_caidanboss")
	end

	mc:addTo(self._view)
	mc:gotoAndStop(1)

	local name = self._point:getName()
	local nameText = ccui.Text:create(name, TTF_FONT_FZYH_M, 18)
	local namePanel = mc:getChildByName("name")

	nameText:addTo(namePanel)

	local hpRate = self._point:getHpRate()
	local loadingBar = cc.CSLoader:createNode("asset/ui/ActStageLoadingBar.csb")

	loadingBar:addTo(self._view):offset(0, -15)
	loadingBar:setScale(0.8, 0.65)

	self._bar = loadingBar:getChildByName("bar")

	self._bar:setPercent(hpRate * 100)
	mc:addEndCallback(function()
		mc:stop()
	end)

	self._mc = mc
end
