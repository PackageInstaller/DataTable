-- chunkname: @modules/logic/college/view/comp/CollegeSceneElementItem.lua

module("modules.logic.college.view.comp.CollegeSceneElementItem", package.seeall)

local CollegeSceneElementItem = class("CollegeSceneElementItem", CollegeSceneBaseItem)

function CollegeSceneElementItem:onInitView()
	self._btnClick = gohelper.findChildButtonWithAudio(self.root, "#btn_click")

	self.addClickCb(self, self._btnClick, self.onClick, self)
end

function CollegeSceneElementItem:onClick()
	self._beginTime = UnityEngine.Time.realtimeSinceStartup

	CollegeRpc.instance:sendCollegeMilestoneActiveNode(self.data.co.id)
end

function CollegeSceneElementItem:updateData(data)
	data = data or self.data

	CollegeSceneElementItem.super.updateData(self, data)

	local loader = PrefabInstantiate.Create(self.go)
	local assetPath = data.co.effect

	if loader:getPath() ~= assetPath then
		loader:dispose()

		if not string.nilorempty(assetPath) then
			loader:startLoad(assetPath, self._onResLoad, self)
		end
	end
end

function CollegeSceneElementItem:setScale(scale)
	self._scale = scale
end

function CollegeSceneElementItem:_onResLoad()
	local loader = PrefabInstantiate.Create(self.go)

	self._effectGo = loader:getInstGO()

	transformhelper.setLocalPos(self._effectGo.transform, 0, 0, 0)
	transformhelper.setLocalScale(self._effectGo.transform, self._scale or 1, self._scale or 1, self._scale or 1)
end

function CollegeSceneElementItem:destroy()
	if self.ui then
		gohelper.destroy(self.ui)
	end

	self._uiFollower = nil
	self._uiFollower2 = nil

	self:removeClickCb(self._btnClick)
	self:removeClickCb(self.btnArrow)

	if CollegeStoryHelper.instance:isPlayingStory() then
		CollegeController.instance:registerCallback(CollegeEvent.OnStoryPlayEnd, self._playDestoryAnim, self)
	else
		self:_playDestoryAnim()
	end
end

function CollegeSceneElementItem:_playDestoryAnim()
	if self._beginTime then
		CollegeStatHelper.instance:statElementTime(self.data.co.id, UnityEngine.Time.realtimeSinceStartup - self._beginTime)
	end

	CollegeController.instance:unregisterCallback(CollegeEvent.OnStoryPlayEnd, self._playDestoryAnim, self)

	local len = self:_checkPlayDestoryAnim()

	if len > 0 then
		TaskDispatcher.runDelay(self._doDestory, self, len)
	else
		self:_doDestory()
	end
end

function CollegeSceneElementItem:_doDestory()
	gohelper.destroy(self.go)
	self:__onDispose()
end

local finishStatId = UnityEngine.Animator.StringToHash("finish")

function CollegeSceneElementItem:_checkPlayDestoryAnim()
	if not self._effectGo then
		return 0
	end

	local anim = gohelper.findComponentAnim(self._effectGo)

	if not anim then
		return 0
	end

	if not anim:HasState(0, finishStatId) then
		return 0
	end

	anim:Play("finish", 0, 0)
	anim:Update(0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)

	return anim:GetCurrentAnimatorStateInfo(0).length
end

function CollegeSceneElementItem:onDestroy()
	CollegeController.instance:unregisterCallback(CollegeEvent.OnStoryPlayEnd, self._playDestoryAnim, self)
	TaskDispatcher.cancelTask(self._doDestory, self)
end

return CollegeSceneElementItem
