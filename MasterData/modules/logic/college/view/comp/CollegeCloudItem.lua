-- chunkname: @modules/logic/college/view/comp/CollegeCloudItem.lua

module("modules.logic.college.view.comp.CollegeCloudItem", package.seeall)

local CollegeCloudItem = class("CollegeCloudItem", LuaCompBase)

function CollegeCloudItem:init(go)
	self.go = go
	self._preStatus = {}

	self:initCloud()
	self:checkLockStatus()
end

function CollegeCloudItem:addEventListeners()
	CollegeController.instance:registerCallback(CollegeEvent.UpdateArea, self.checkLockStatus, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusBegin, self.onAreaFocus, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusCancel, self.onAreaCancelFocus, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onViewClose, self)
end

function CollegeCloudItem:removeEventListeners()
	CollegeController.instance:unregisterCallback(CollegeEvent.UpdateArea, self.checkLockStatus, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusBegin, self.onAreaFocus, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusCancel, self.onAreaCancelFocus, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onViewClose, self)
end

function CollegeCloudItem:onEnable()
	if CollegeModel.instance.curSceneType ~= CollegeEnum.SceneType.Map then
		return
	end

	self._preStatus = {}

	self:checkLockStatus()
end

function CollegeCloudItem:onViewClose(viewName)
	if viewName == ViewName.CollegeSwitchSceneAnimView then
		TaskDispatcher.runDelay(self.onEnable, self, 1)
	end
end

function CollegeCloudItem:initCloud()
	self._goItems = self:getUserDataTb_()

	local trans = self.go.transform

	for i = trans.childCount - 1, 0, -1 do
		local child = trans:GetChild(i)
		local id = child.name:match("#go_item_(%d+)")

		id = tonumber(id)

		if id then
			self._goItems[id] = gohelper.findComponentAnim(child.gameObject)
		end
	end
end

function CollegeCloudItem:checkLockStatus()
	if not self.go.activeInHierarchy then
		return
	end

	local sceneMo = CollegeModel.instance:getSceneMo()

	for i, v in ipairs(sceneMo.worldMap.areas) do
		local animName = "lock"

		if v.isFinish then
			animName = ViewMgr.instance:isOpen(ViewName.CollegeSwitchSceneAnimView) and (sceneMo.prop.clientDataMo:isPlayedUnlock(v.id) and "unlock" or "explore") or sceneMo.prop.clientDataMo:updateAreaUnlock(v.id) and "explore_unlock" or v.id == self._curFocusId and "focus" or "unlock"
		elseif v.status == CollegeEnum.AreaStatus.Exploring then
			animName = "explore"
		end

		self:playAnim(v.id, animName)
	end
end

function CollegeCloudItem:onAreaFocus()
	local focusData = CollegeModel.instance.curFocusData

	if not focusData or focusData.type ~= CollegeEnum.SceneType.Map or not focusData.isFinish then
		return
	end

	self._curFocusId = focusData.id

	self:playAnim(focusData.id, "focus")
end

function CollegeCloudItem:onAreaCancelFocus()
	if not self._curFocusId then
		return
	end

	self:playAnim(self._curFocusId, "unlock")

	self._curFocusId = nil
end

local switchAnim = {
	explore = {
		lock = "explore_lock"
	},
	lock = {
		explore = "lock_explore"
	},
	unlock = {
		focus = "select"
	},
	explore_unlock = {
		focus = "select"
	},
	focus = {
		unlock = "unselect"
	}
}
local finishName = {
	explore = "lock_explore"
}
local animNameToAudioId = {
	lock_explore = CollegeAudioEnum.Exploring,
	explore_lock = CollegeAudioEnum.ExplorePause,
	explore_unlock = CollegeAudioEnum.Explored
}

function CollegeCloudItem:playAnim(id, animName)
	if animName == self._preStatus[id] then
		return
	end

	local anim = self._goItems[id]

	if not anim then
		return
	end

	local switchName = GameUtil.getTbValue(switchAnim, self._preStatus[id], animName)

	self._preStatus[id] = animName
	animName = switchName or animName

	if finishName[animName] then
		anim:Play(finishName[animName], 0, 1)
	else
		anim:Play(animName)
	end

	if animNameToAudioId[animName] then
		CollegeAudioHelper.instance:playAudio(animNameToAudioId[animName])
	end
end

function CollegeCloudItem:onDestroy()
	TaskDispatcher.cancelTask(self.onEnable, self)
end

return CollegeCloudItem
