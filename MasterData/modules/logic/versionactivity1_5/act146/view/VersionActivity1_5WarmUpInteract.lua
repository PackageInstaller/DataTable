-- chunkname: @modules/logic/versionactivity1_5/act146/view/VersionActivity1_5WarmUpInteract.lua

module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpInteract", package.seeall)

local VersionActivity1_5WarmUpInteract = class("VersionActivity1_5WarmUpInteract", BaseView)

function VersionActivity1_5WarmUpInteract:onInitView()
	self._godragarea = gohelper.findChild(self.viewGO, "Middle/#go_dragarea")
	self._goguide1 = gohelper.findChild(self.viewGO, "Middle/#go_guide1")
	self._goguide2 = gohelper.findChild(self.viewGO, "Middle/#go_guide2")
	self._imagePhotoMask1 = gohelper.findChildImage(self.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask1")
	self._imagePhotoMask2 = gohelper.findChildImage(self.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask2")
	self._imagePhotoMask3 = gohelper.findChildImage(self.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5WarmUpInteract:addEvents()
	self.addEventCb(self, Activity146Controller.instance, Activity146Event.DataUpdate, self._onDataUpdate, self)
	self._drag:AddDragListener(self._onDragging, self)
	self._drag:AddDragBeginListener(self._onBeginDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self)
end

function VersionActivity1_5WarmUpInteract:removeEvents()
	self.removeEventCb(self, Activity146Controller.instance, Activity146Event.DataUpdate, self._onDataUpdate, self)
	self._drag:RemoveDragListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
end

VersionActivity1_5WarmUpInteract.InteractType = {
	Counting = 2,
	Vertical = 1
}

function VersionActivity1_5WarmUpInteract:_onBeginDrag(param, eventData)
	local interactFuncMap = VersionActivity1_5WarmUpInteract.DragFuncMap[self._interactType]

	if interactFuncMap and interactFuncMap.onBegin then
		interactFuncMap.onBegin(self, param, eventData)
	end
end

function VersionActivity1_5WarmUpInteract:_onDragging(param, eventData)
	local interactFuncMap = VersionActivity1_5WarmUpInteract.DragFuncMap[self._interactType]

	if interactFuncMap and interactFuncMap.onDrag then
		interactFuncMap.onDrag(self, param, eventData)
	end
end

function VersionActivity1_5WarmUpInteract:_onEndDrag(param, eventData)
	local interactFuncMap = VersionActivity1_5WarmUpInteract.DragFuncMap[self._interactType]

	if interactFuncMap and interactFuncMap.onEnd then
		interactFuncMap.onEnd(self, param, eventData)
	end
end

function VersionActivity1_5WarmUpInteract:_onBeginDragVertical(param, eventData)
	self._isPassEpisode = false
	self._dragLengthen = 0

	gohelper.setActive(self._goguide1, false)
	gohelper.setActive(self._goguide2, false)

	self._atticletterOpeningId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_opening)
end

local dragMinLengthenVertical = 80

function VersionActivity1_5WarmUpInteract:_onDraggingVertical(param, eventData)
	local moveOffsetX = Mathf.Abs(eventData.delta.x)
	local moveOffsetY = Mathf.Abs(eventData.delta.y)
	local isMove2Vertical = moveOffsetX <= moveOffsetY

	if not self._isPassEpisode and isMove2Vertical then
		self._dragLengthen = self._dragLengthen + moveOffsetY

		local dragProgress = Mathf.Clamp(self._dragLengthen / dragMinLengthenVertical, 0, 1)

		if dragProgress >= 1 then
			self._isPassEpisode = true
		end
	end
end

function VersionActivity1_5WarmUpInteract:_onEndDragVertical()
	if self._isPassEpisode then
		Activity146Controller.instance:dispatchEvent(Activity146Event.OnEpisodeFinished)
	end

	if self._atticletterOpeningId then
		AudioMgr.instance:stopPlayingID(self._atticletterOpeningId)

		self._atticletterOpeningId = nil
	end
end

local dragSuccCount = 3
local dragMinOffset = 10

function VersionActivity1_5WarmUpInteract:_onBeginDragCounting(param, eventData)
	self._isPassEpisode = false
	self._dragLengthenX = 0
	self._dragLengthenY = 0

	gohelper.setActive(self._goguide1, false)
	gohelper.setActive(self._goguide2, false)
end

local ClearMaskPhotoAnim = {
	"1st",
	"2nd",
	"3rd"
}

function VersionActivity1_5WarmUpInteract:_onDraggingCounting(param, eventData)
	if not self._isPassEpisode then
		local isSucc = false

		if Mathf.Abs(eventData.delta.x) > dragMinOffset and eventData.delta.x * self._dragLengthenX <= 0 then
			isSucc = true
		elseif Mathf.Abs(eventData.delta.y) > dragMinOffset and eventData.delta.y * self._dragLengthenY <= 0 then
			isSucc = true
		end

		if isSucc then
			self._dragLengthenX = eventData.delta.x
			self._dragLengthenY = eventData.delta.y
			self._dragCount = self._dragCount or 0
			self._dragCount = self._dragCount + 1

			if not ClearMaskPhotoAnim[self._dragCount] then
				local animStateName = "idle"

				self._photoMaskAnim:Play(animStateName, 0, 0)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_cleaning)

				if self._dragCount >= dragSuccCount then
					self._isPassEpisode = true
				end
			end
		end
	end
end

function VersionActivity1_5WarmUpInteract:_onEndDragCounting()
	if self._isPassEpisode then
		Activity146Controller.instance:dispatchEvent(Activity146Event.OnEpisodeFinished)
	end
end

function VersionActivity1_5WarmUpInteract:_editableInitView()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godragarea)

	local photoMaskRoot = gohelper.findChild(self.viewGO, "Middle/#go_mail2/image_PhotoMask")

	self._photoMaskAnim = gohelper.onceAddComponent(photoMaskRoot, typeof(UnityEngine.Animator))
end

function VersionActivity1_5WarmUpInteract:_onDataUpdate()
	local curEpisodeId = Activity146Model.instance:getCurSelectedEpisode()

	self._interactType = Activity146Config.instance:getEpisodeInteractType(self.viewParam.actId, curEpisodeId)

	self._photoMaskAnim:Play("idle", 0, 0)

	self._dragCount = 0
end

VersionActivity1_5WarmUpInteract.DragFuncMap = {
	[VersionActivity1_5WarmUpInteract.InteractType.Counting] = {
		onBegin = VersionActivity1_5WarmUpInteract._onBeginDragCounting,
		onDrag = VersionActivity1_5WarmUpInteract._onDraggingCounting,
		onEnd = VersionActivity1_5WarmUpInteract._onEndDragCounting
	},
	[VersionActivity1_5WarmUpInteract.InteractType.Vertical] = {
		onBegin = VersionActivity1_5WarmUpInteract._onBeginDragVertical,
		onDrag = VersionActivity1_5WarmUpInteract._onDraggingVertical,
		onEnd = VersionActivity1_5WarmUpInteract._onEndDragVertical
	}
}

function VersionActivity1_5WarmUpInteract:onClose()
	if self._atticletterOpeningId then
		AudioMgr.instance:stopPlayingID(self._atticletterOpeningId)

		self._atticletterOpeningId = nil
	end
end

return VersionActivity1_5WarmUpInteract
