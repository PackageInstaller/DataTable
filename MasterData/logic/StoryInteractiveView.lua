-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryInteractiveView.lua

module("logic.extensions.story.view.StoryInteractiveView", package.seeall)

local StoryInteractiveView = class("StoryInteractiveView", ViewComponent)
local frictTime = 100

function StoryInteractiveView:buildUI()
	self._interactiveNode = self:getGo("interactive")
	self._frictNode = self:getGo("interactive/frict")
	self._frictBtn = self:getBtn("interactive/frict")
	self._frictSlider = Framework.SliderAdapter.GetFrom(self.mainGO, "interactive/frict/Slider")

	self._frictSlider:SetValue(0)

	self._tip = self:getGo("interactive/frict/tip")
	self._finger = self:getGo("interactive/frict/finger")
end

function StoryInteractiveView:bindEvents()
	self._frictBtn:AddClickListener(self._onClickFrict, self)
end

function StoryInteractiveView:unbindEvents()
	self._frictBtn:RemoveClickListener()
end

function StoryInteractiveView:onEnter()
	StoryInteractiveView.super.onEnter(self)
	goutil.setActive(self._finger, true)
	self:disableFrict()
end

function StoryInteractiveView:onEnterFinished()
	self._isToggled = nil
end

function StoryInteractiveView:onExit()
	StoryInteractiveView.super.onExit(self)

	self._isFrictFinished = nil

	self:_clearEffect()
	self:_endFrict()
	self:_clearClickEff()
	removetimer(self._interactiveFinish, self)
end

function StoryInteractiveView:_onClickFrict()
	if self._isToggled then
		return
	end

	self._isToggled = true

	goutil.setActive(self._finger, false)
	goutil.setActive(self._tip, false)
	self:_playEffectTest()
end

function StoryInteractiveView:_playEffectTest()
	if self._clickEff then
		self:_playClickEff()
	else
		self._clickPlayEff = true
	end
end

function StoryInteractiveView:_clearEffect()
	if self.testeff then
		UIEffectManager.instance:stopEffect(self.testeff)

		self.testeff = nil
	end
end

function StoryInteractiveView:enableFrict(bgEff)
	if self._isFrictFinished then
		return
	end

	self._bgEffIns = bgEff
	self._mofang_spine = goutil.findChild(self._bgEffIns, "mofang_spine")
	self._isFrictFinished = nil

	self._frictNode:SetActive(true)
	self:_loadClickEff()
	self:_endFrict()
end

function StoryInteractiveView:disableFrict()
	self._frictNode:SetActive(false)

	self._isFrictFinished = nil

	self:_endFrict()
end

function StoryInteractiveView:_loadClickEff()
	if not self._effPath then
		self._effPath = "effect/prefabs/story/story_mofangbao/story_mofangbaokai.prefab"

		getres(self._effPath, self._onResLoaded, self)
	end
end

function StoryInteractiveView:_onResLoaded(res)
	self._loadRes = res

	self._loadRes:Retain()

	if self._loadRes.IsSuccess then
		self._clickEff = goutil.clone(res:GetMainAsset())

		GoUtil.SetSortingOrder(self._clickEff, 10030)
		Framework.TransformUtil.SetLocalScale(self._clickEff.transform, 2, 2, 2)
		Framework.GameObjectUtil.SetLayerRecursively(self._clickEff, SceneLayer.SkillEffects_II_Value)
		self._clickEff:SetActive(false)

		if self._clickPlayEff then
			self:_playClickEff()
		end
	end
end

function StoryInteractiveView:_clearClickEff()
	self._clickPlayEff = nil

	if self._effPath then
		removeresl(self._effPath, self._onResLoaded, self)

		self._effPath = nil
	end

	if self._loadRes then
		self._loadRes:Release()

		self._loadRes = nil
	end

	if self._clickEff then
		goutil.destroy(self._clickEff)

		self._clickEff = nil
	end

	UnityTweens.TweenShakePosition.StopTween(self.mainGO)

	if not goutil.isNil(self._mofang_spine) then
		UnityTweens.TweenEmpty.StopTween(self._mofang_spine)
	end

	self._mofang_spine = nil
end

function StoryInteractiveView:_playClickEff()
	self._clickEff:SetActive(false)
	UnityTweens.TweenShakePosition.StartTween(self._mofang_spine, Vector3.New(2, 2, 2), 1):AddListener(function()
		self._clickEff:SetActive(true)
		AudioPlayerEx.instance:playEffect(30221)
	end)
	UnityTweens.TweenEmpty.StartTween(self.mainGO, 2, self._interactiveFinish, self)
	self._mofang_spine:SetActive(true)
end

function StoryInteractiveView:_onStartFrict()
	if not self._isFrictFinished then
		self:_startFrict()
	end
end

function StoryInteractiveView:_onFricting()
	if self._isFricting then
		self._dirtyFricting = true
	end
end

function StoryInteractiveView:_startFrict()
	self._isFricting = true
	self._frictingTime = 0

	settimer(0.02, self._tickFricting, self)
	self._frictSlider:SetValue(0)
	self._frictSlider.gameObject:SetActive(true)
end

function StoryInteractiveView:_endFrict()
	self._isFricting = nil
	self._frictingTime = nil

	self._frictSlider.gameObject:SetActive(false)
	removetimer(self._tickFricting, self)
end

function StoryInteractiveView:_tickFricting()
	self._dirtyFricting = nil
	self._frictingTime = self._frictingTime + 1

	self._frictSlider:SetValue(self._frictingTime / frictTime)

	if self._frictingTime >= frictTime then
		self:_endFrict()

		self._isFrictFinished = true

		settimer(1, self._interactiveFinish, self, false)
	end
end

function StoryInteractiveView:_interactiveFinish()
	self:localNotify(TaskConst.ON_UI_INTERACTIVE_FINISH)
end

return StoryInteractiveView
