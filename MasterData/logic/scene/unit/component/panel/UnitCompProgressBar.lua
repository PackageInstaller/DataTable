-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/panel/UnitCompProgressBar.lua

module("logic.scene.unit.component.panel.UnitCompProgressBar", package.seeall)

local M = class("UnitCompProgressBar", UnitComponentBase)
local URL_PROGRESS = ResName.Snatch_at_node

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = nil
	self._followUIComp = nil
	self._goInst = false

	self:_resetData()
end

function M:_resetData()
	self._fromValue = 0
	self._toValue = 0
	self._duration = -1
	self._finCallback = nil
	self._finTarget = nil
	self._mode = 0
	self._continueLowMood = false
	self._clearWhenFinish = false
	self._isPauseShowLowMood = false
end

function M:onInit()
	self._resLoader = SingleResLoader.New()
	self._followUIComp = self._unit.uiFollow

	self:_setMoodEvents(true)
end

function M:onReuse()
	self:_setMoodEvents(true)
end

function M:onReset()
	self:_setMoodEvents(false)
	self:_clearInst()
	self:_resetData()
end

function M:onDestroy()
	self:_setMoodEvents(false)
	self:_clearInst()
	self:_resetData()

	self._resLoader = nil
	self._followUIComp = nil
end

function M:_setMoodEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.HERO_MOOD_UPDATE, self._onMoodUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_MOOD_UPDATE, self._onMoodUpdate, self)
	end
end

function M:setVisible(visible)
	if self._goInst then
		goutil.setActive(self._goInst, visible)
	end
end

function M:stopProgress()
	self:_clearTweener()

	self._finCallback = nil
	self._finTarget = nil
end

function M:clear()
	self:stopProgress()

	self._mode = 0

	if self._goInst then
		self:_refreshMode()
		self:continueShowMood()
	end
end

function M:playProgress(from, to, duration, finishCallback, finishTarget, clearWhenFinish)
	self._mode = 1
	self._fromValue = from
	self._toValue = to
	self._duration = duration
	self._finCallback = finishCallback
	self._finTarget = finishTarget
	self._clearWhenFinish = clearWhenFinish

	if self._goInst then
		self:_playProgress()
	else
		self._resLoader:load(URL_PROGRESS, self._onResLoaded, self)
	end
end

function M:refreshMood()
	self:_onMoodUpdate()
end

function M:showMood()
	if self._mode == 2 then
		return
	end

	self._mode = 2

	if self._goInst then
		self:_showMood()
	else
		self._resLoader:load(URL_PROGRESS, self._onResLoaded, self)
	end
end

function M:continueShowMood()
	if self._continueLowMood and not self._isPauseShowLowMood then
		self:showMood()
	end
end

function M:pauseShowLowMood()
	self._isPauseShowLowMood = true

	if self._goInst then
		goutil.setActive(self._goMoodRoot, false)
	end
end

function M:resumeShowLowMood()
	self._isPauseShowLowMood = false

	if self._goInst then
		self:continueShowMood()
		self:_refreshMode()
	end
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()
	self._goSliderRoot = goutil.findChild(self._goInst, "slider")
	self._imgProgress = goutil.findChildImageComponent(self._goSliderRoot, "imgSlider")
	self._goGuang = goutil.findChild(self._goSliderRoot, "guang")
	self._goMoodRoot = goutil.findChild(self._goInst, "mood")
	self._goMood1 = goutil.findChild(self._goMoodRoot, "mood1")
	self._goMood2 = goutil.findChild(self._goMoodRoot, "mood2")
	self._goMood3 = goutil.findChild(self._goMoodRoot, "mood3")

	local parentGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.addChildToParent(self._goInst, parentGo)
	self._followUIComp:addTopFollowGameObject(self._goInst)

	if self._mode == 1 then
		self:_playProgress()
	elseif self._mode == 2 then
		self:_showMood()
	else
		self:_refreshMode()
	end
end

function M:_playProgress()
	self:setVisible(true)
	self:_refreshMode()
	self:_clearTweener()
	self:_lerpProgress(self._fromValue)

	self._guangTweener = TweenNumberUtils.FloatTo(self._fromValue, self._toValue, self._duration, self._lerpProgress, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self._lerpFinish, self)
end

function M:_lerpProgress(updateValue)
	self._imgProgress.fillAmount = updateValue

	local rotaZ = -360 * updateValue + 90

	Astral.TransformUtil.SetLocalRotation(self._goGuang.transform, 0, 0, rotaZ)
end

function M:_lerpFinish()
	self:_clearTweener()

	if self._finCallback then
		self._finCallback(self._finTarget)
	end

	self._finCallback = nil
	self._finTarget = nil

	if self._clearWhenFinish then
		self:clear()
	end
end

function M:_showMood()
	self:setVisible(true)
	self:_refreshMode()
	self:_refreshMoodValue()
end

function M:_refreshMoodValue()
	self._continueLowMood = false

	local mo = HeroHouseFeatureModel.instance:getFeatureMO(self._unit.heroId)
	local moodValue = 0

	if mo then
		moodValue = mo:getMood()

		local type = HouseWorkerModel.instance:getMoodInterval(moodValue)

		if type == 3 then
			self._continueLowMood = true
		end
	end

	if self._goInst then
		local type = HouseWorkerModel.instance:getMoodInterval(moodValue)

		goutil.setActive(self._goMood1, type == 1)
		goutil.setActive(self._goMood2, type == 2)
		goutil.setActive(self._goMood3, type == 3)
	end
end

function M:_refreshMode()
	if self._mode == 1 then
		goutil.setActive(self._goSliderRoot, true)
		goutil.setActive(self._goMoodRoot, false)
	elseif self._mode == 2 then
		goutil.setActive(self._goSliderRoot, false)
		goutil.setActive(self._goMoodRoot, true)
	else
		goutil.setActive(self._goSliderRoot, false)
		goutil.setActive(self._goMoodRoot, false)
	end
end

function M:_clearTweener()
	if self._guangTweener then
		self._guangTweener:Kill(false)
	end

	self._guangTweener = nil
end

function M:_clearInst()
	self:_clearTweener()

	if self._goInst then
		self._followUIComp:removeTopFollowGameObject(self._goInst)
		goutil.destroy(self._goInst)
	end

	self._goInst = false
	self._goSliderRoot = false
	self._imgProgress = false
	self._goMoodRoot = false
	self._goMood1 = false
	self._goMood2 = false
	self._goMood3 = false

	if self._resLoader then
		self._resLoader:clear()
	end
end

function M:_onMoodUpdate()
	self:_refreshMoodValue()
	self:continueShowMood()
end

return M
