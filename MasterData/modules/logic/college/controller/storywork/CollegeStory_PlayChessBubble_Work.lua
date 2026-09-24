-- chunkname: @modules/logic/college/controller/storywork/CollegeStory_PlayChessBubble_Work.lua

module("modules.logic.college.controller.storywork.CollegeStory_PlayChessBubble_Work", package.seeall)

local CollegeStory_PlayChessBubble_Work = class("CollegeStory_PlayChessBubble_Work", BaseWork)

function CollegeStory_PlayChessBubble_Work:ctor(groupId)
	self._groupId = groupId
end

function CollegeStory_PlayChessBubble_Work:onStart()
	self._stepList = lua_college_bubble_group_step.configDict[self._groupId] or {}

	local viewContainer = ViewMgr.instance:getContainer(ViewName.CollegeMainView)

	if not viewContainer or not viewContainer.viewGO then
		self:onDone(false)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onDone, self)
	ViewMgr.instance:openView(ViewName.CollegeStoryView2)

	self._gobubble = gohelper.findChild(viewContainer.viewGO, "#go_bubbles/#go_bubble")
	self._chessList = {}
	self._roleRoot = viewContainer:getSceneView():getRoleRoot()

	self:loadAllChess()
	TaskDispatcher.runDelay(self._delayPlay, self, 0.5)
end

function CollegeStory_PlayChessBubble_Work:_delayPlay()
	self._curIndex = 0

	self:playNextStep()
end

function CollegeStory_PlayChessBubble_Work:loadAllChess()
	for i, v in ipairs(self._stepList) do
		if not self._chessList[v.actorId] then
			local go = gohelper.create3d(self._roleRoot, string.format("bubble_%s_%s", v.groupId, v.step))
			local pos = Vector3.New()

			if not string.nilorempty(v.pos) then
				local arr = string.splitToNumber(v.pos, "#")

				pos:Set(arr[1], arr[2], arr[3])
			end

			transformhelper.setLocalPos(go.transform, pos.x, pos.y, pos.z)

			local role = MonoHelper.addNoUpdateLuaComOnceToGo(go, CollegeRoleItem)

			role:setScaleX(v.chessPosition)
			role:setActorId(v.actorId)

			local ui = gohelper.cloneInPlace(self._gobubble)

			role:setUI(ui)

			self._chessList[v.actorId] = role
		end
	end
end

function CollegeStory_PlayChessBubble_Work:playNextStep()
	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._stepList then
		ViewMgr.instance:closeView(ViewName.CollegeStoryView2)

		return
	end

	local step = self._stepList[self._curIndex]
	local role = self._chessList[step.actorId]

	if not string.nilorempty(step.name) then
		role:setName(step.name)
	end

	role:playDialog(step.text, step.position, self.playNextStep, self)
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.Bubble)
end

function CollegeStory_PlayChessBubble_Work:_onDone(viewName)
	if viewName == ViewName.CollegeStoryView2 then
		self:onDone(true)
	end
end

function CollegeStory_PlayChessBubble_Work:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onDone, self)

	if self._chessList then
		for i, v in pairs(self._chessList) do
			v:playExitAnim()
		end

		self._chessList = {}
	end

	TaskDispatcher.cancelTask(self._delayPlay, self)
end

return CollegeStory_PlayChessBubble_Work
