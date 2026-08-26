-- chunkname: @modules/logic/explore/view/unit/ExploreUnitDialogueView.lua

module("modules.logic.explore.view.unit.ExploreUnitDialogueView", package.seeall)

local ExploreUnitDialogueView = class("ExploreUnitDialogueView", ExploreUnitBaseView)

function ExploreUnitDialogueView:ctor(unit)
	self._offsetY2d = 200

	ExploreUnitDialogueView.super.ctor(self, unit, "ui/viewres/explore/explorebubbleview.prefab")
end

function ExploreUnitDialogueView:onInit()
	self.txt = gohelper.findChildTextMesh(self.viewGO, "go_btns/tip")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ExploreUnitDialogueView:addEventListeners()
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreen, self)
end

function ExploreUnitDialogueView:removeEventListeners()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreen, self)
end

function ExploreUnitDialogueView:_onTouchScreen()
	if self._tweenId then
		return
	end

	self._anim:Play("close")
	AudioMgr.instance:trigger(AudioEnum.Explore.BubbleHide)

	self._tweenId = ZProj.TweenHelper.DOScale(self.viewGO.transform, 0, 0, 0, 0.5, self.closeThis, self)
end

function ExploreUnitDialogueView:onOpen()
	self.txt.text = ""

	transformhelper.setLocalScale(self.viewGO.transform, 0, 0, 0)

	self._tweenId = ZProj.TweenHelper.DOScale(self.viewGO.transform, 1, 1, 1, 0.5, self.onTweenOpenEnd, self)

	if self._id then
		self:setDialogueId(self._id)
	end

	self._anim:Play("open")
	AudioMgr.instance:trigger(AudioEnum.Explore.BubbleShow)
end

function ExploreUnitDialogueView:onTweenOpenEnd()
	self._tweenId = nil
end

function ExploreUnitDialogueView:setDialogueId(id)
	self._id = id

	if not self.txt then
		return
	end

	self.txt.text = lua_explore_bubble.configDict[id].content
end

function ExploreUnitDialogueView:onDestroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	ExploreUnitDialogueView.super.onDestroy(self)
end

return ExploreUnitDialogueView
