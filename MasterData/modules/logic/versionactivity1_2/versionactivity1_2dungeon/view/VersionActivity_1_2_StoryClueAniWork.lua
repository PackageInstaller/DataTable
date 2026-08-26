-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_StoryClueAniWork.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryClueAniWork", package.seeall)

local VersionActivity_1_2_StoryClueAniWork = class("VersionActivity_1_2_StoryClueAniWork", BaseWork)

function VersionActivity_1_2_StoryClueAniWork:ctor(signObj, viewClass, index, clueId)
	self._signObjList = signObj
	self._viewClass = viewClass
	self._index = index
	self._clueId = clueId

	self:_buildFlow()
end

function VersionActivity_1_2_StoryClueAniWork:_buildFlow()
	self._aniFlow = FlowSequence.New()

	local speed = 100

	self._tweenValue = {}

	local goMask = self._viewClass._gomask
	local maskTransform = goMask.transform
	local rootTransform = gohelper.findChild(self._viewClass.viewGO, "root").transform

	VersionActivity_1_2_StoryClueAniWork.lastNoteId = 0

	for i = 1, #self._signObjList do
		local objList = self._signObjList[i]

		for index, obj in ipairs(objList) do
			local lineTransform = obj.transform
			local toValue = recthelper.getWidth(lineTransform)
			local duration = toValue / speed

			recthelper.setWidth(lineTransform, 0)

			local noteObj = lineTransform.parent.parent.gameObject
			local noteTransform = noteObj.transform
			local noteId = noteTransform.name

			if VersionActivity_1_2_StoryClueAniWork.lastNoteId == 0 then
				-- block empty
			elseif VersionActivity_1_2_StoryClueAniWork.lastNoteId ~= noteId then
				self._aniFlow:addWork(WorkWaitSeconds.New(0.16))
				self._aniFlow:addWork(TweenWork.New({
					from = 1,
					type = "DOFadeCanvasGroup",
					to = 0,
					t = 0.3,
					go = goMask
				}))
			end

			if index == 1 then
				local title = gohelper.findChild(noteTransform.gameObject, "title/go_titleNormal")
				local tarPos = recthelper.rectToRelativeAnchorPos(title.transform.position, self._viewClass.viewGO.transform)
				local tarPosX = -tarPos.x * 1.5 - 200
				local tarPosY = -tarPos.y * 1.5 + 80
				local flow = FlowParallel.New()

				flow:addWork(TweenWork.New({
					toz = 1,
					type = "DOScale",
					tox = 1.5,
					toy = 1.5,
					t = 0.3,
					tr = rootTransform
				}))
				flow:addWork(TweenWork.New({
					type = "DOAnchorPos",
					t = 0.3,
					tr = rootTransform,
					tox = tarPosX,
					toy = tarPosY
				}))
				self._aniFlow:addWork(flow)

				if VersionActivity_1_2_StoryClueAniWork.lastNoteId ~= noteId then
					self._aniFlow:addWork(FunctionWork.New(function()
						recthelper.setWidth(maskTransform, 5200)
						recthelper.setHeight(maskTransform, 2500)
						gohelper.setActive(goMask, true)
					end))

					flow = FlowParallel.New()

					local sizeValue = gohelper.findChildText(lineTransform.parent.gameObject, ""):GetPreferredValues()
					local offsetHeight = (sizeValue.y - 112) * 1.5
					local maskHeight = 1250 + offsetHeight

					flow:addWork(FunctionWork.New(function()
						recthelper.setAnchorY(maskTransform, 0 - offsetHeight / 2)
					end))
					flow:addWork(TweenWork.New({
						type = "DOSizeDelta",
						tox = 2600,
						t = 0.6,
						tr = maskTransform,
						toy = maskHeight
					}))
					flow:addWork(TweenWork.New({
						from = 0,
						type = "DOFadeCanvasGroup",
						to = 1,
						t = 0.6,
						go = goMask
					}))
					self._aniFlow:addWork(flow)
				end
			end

			VersionActivity_1_2_StoryClueAniWork.lastNoteId = noteId

			self._aniFlow:addWork(VersionActivity_1_2_StoryClueLineWork.New(lineTransform, toValue, duration, self._clueId))

			if index == #objList then
				self._aniFlow:addWork(WorkWaitSeconds.New(0.6))
			end

			table.insert(self._tweenValue, {
				tr = lineTransform,
				to = toValue
			})
		end
	end

	VersionActivity_1_2_StoryClueAniWork.lastNoteId = 0

	self._aniFlow:addWork(TweenWork.New({
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		t = 0.3,
		go = goMask
	}))
	self._aniFlow:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = -556,
		toy = 466,
		t = 0.3,
		tr = rootTransform
	}))

	local collectNoteTtran = self._viewClass._gocollectNote.transform
	local collectNoteItem = collectNoteTtran:GetChild(self._index - 1).gameObject

	self._aniFlow:addWork(FunctionWork.New(function()
		gohelper.setActive(collectNoteItem, true)
	end))

	local sign = gohelper.findChild(collectNoteItem, VersionActivity_1_2_StoryCollectView._signTypeName[self._clueId]).transform
	local toValue = recthelper.getWidth(sign)
	local duration = toValue / speed

	recthelper.setWidth(sign, 0)
	self._aniFlow:addWork(VersionActivity_1_2_StoryClueLineWork.New(sign, toValue, duration, self._clueId))
	self._aniFlow:addWork(WorkWaitSeconds.New(1))
	table.insert(self._tweenValue, {
		tr = sign,
		to = toValue,
		collectNoteItem = collectNoteItem
	})
end

function VersionActivity_1_2_StoryClueAniWork:onStart()
	self._aniFlow:registerDoneListener(self._onAniFlowDone, self)
	self._aniFlow:start()
end

function VersionActivity_1_2_StoryClueAniWork:_onAniFlowDone()
	if self._aniFlow then
		self._aniFlow:unregisterDoneListener(self._onAniFlowDone, self)
		self._aniFlow:destroy()

		self._aniFlow = nil
	end

	self:onDone(true)
end

function VersionActivity_1_2_StoryClueAniWork:clearWork()
	if self._aniFlow then
		self._aniFlow:unregisterDoneListener(self._onAniFlowDone, self)
		self._aniFlow:destroy()

		self._aniFlow = nil
	end
end

return VersionActivity_1_2_StoryClueAniWork
