-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/StoryStageCommonCell.lua

StoryStageCommonCell = class("StoryStageCommonCell", DisposableObject, _M)

StoryStageCommonCell:has("_point", {
	is = "rw"
})
StoryStageCommonCell:has("_view", {
	is = "rw"
})

StoryStageType = {
	kPass = "pass",
	klock = "lock",
	kNotPass = "unpass"
}

function StoryStageCommonCell:initialize(view, info)
	super.initialize(self)

	self._view = view
	self._mediator = info.mediator
	self._point = info.point
	self._state = StoryStageType.klock

	self:initWigetInfo()
end

function StoryStageCommonCell:dispose()
	super.dispose()
end

function StoryStageCommonCell:getView()
	return self._view
end

function StoryStageCommonCell:initWigetInfo()
	self:getView():setVisible(false)

	local stageName = self:getView():getChildByFullName("bg.Text_name")
	local storyPointConfig = self._point:getConfig()

	self._isHide = storyPointConfig.IsHide or 0
	self._isAutoPlay = storyPointConfig.IsAuto or 0

	stageName:setString(Strings:get(storyPointConfig.Name))
	stageName:enableOutline(cc.c4b(0, 0, 0, 255), 1)
end

function StoryStageCommonCell:refreshViewWithState(stageState, isUnlock, isPass)
	if stageState then
		self._state = stageState
	end

	if self._state == StoryStageType.klock then
		self:getView():setVisible(false)

		if isUnlock then
			if self._isHide == 1 then
				self._state = StoryStageType.kPass

				self:getView():setVisible(true)
			else
				self._state = StoryStageType.kNotPass
			end
		end
	end

	if self._state == StoryStageType.kNotPass and isPass then
		self:getView():setVisible(true)
		self:getView():setOpacity(0)
		self:getView():runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))

		self._state = StoryStageType.kPass
	end

	if self._state == StoryStageType.kPass then
		self:getView():setVisible(true)
	end
end

function StoryStageCommonCell:initAnim()
	return
end
