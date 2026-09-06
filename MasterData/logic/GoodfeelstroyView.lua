-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelstroyView.lua

module("logic.extensions.goodfeel.view.GoodfeelstroyView", package.seeall)

local GoodfeelstroyView = class("GoodfeelstroyView", TableViewComponent)

function GoodfeelstroyView:ctor()
	GoodfeelstroyView.super.ctor(self)
end

function GoodfeelstroyView:_getPath()
	return {
		cellPath = "mask/root/tablecell",
		viewPath = "mask/root/tableview"
	}
end

function GoodfeelstroyView:buildUI()
	GoodfeelstroyView.super.buildUI(self)

	self._rootTween = self:getGo("mask/root"):GetComponent(UnityTweensType.TweenPosition)
	self._emptyTipGo = self:getGo("mask/root/emptyTip")
end

function GoodfeelstroyView:bindEvents()
	GoodfeelstroyView.super.bindEvents(self)
end

function GoodfeelstroyView:unbindEvents()
	GoodfeelstroyView.super.unbindEvents(self)
end

function GoodfeelstroyView:destroyUI()
	GoodfeelstroyView.super.destroyUI(self)
end

function GoodfeelstroyView:onEnter()
	GoodfeelstroyView.super.onEnter(self)
	GlobalDispatcher:addListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	GlobalDispatcher:addListener(GoodFeelController.PM_GFViewStoryRes, self._viewStoryRes, self)
	GlobalDispatcher:addListener(GoodFeelController.RealUseGift, self._updateView, self)
	self:_updateView()
	self:_doMove()
end

function GoodfeelstroyView:onEnterFinished()
	GoodfeelstroyView.super.onEnterFinished(self)
end

function GoodfeelstroyView:onExit()
	GoodfeelstroyView.super.onExit(self)
	self._rootTween:Stop()
	GlobalDispatcher:removeListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	GlobalDispatcher:removeListener(GoodFeelController.PM_GFViewStoryRes, self._viewStoryRes, self)
	GlobalDispatcher:removeListener(GoodFeelController.RealUseGift, self._updateView, self)
end

function GoodfeelstroyView:onExitFinished()
	GoodfeelstroyView.super.onExitFinished(self)
end

function GoodfeelstroyView:_cellSize(view, index)
	return 120, 120
end

function GoodfeelstroyView:_updateCell(view, cell, data)
	local newIcon = goutil.findChild(cell.gameObject, "newIcon")
	local bgChange = goutil.findChild(cell.gameObject, "bg"):GetComponent(ComponentType.UIChangeGroup)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local btn = GameUtil.asBtn(goutil.findChild(cell.gameObject, "raycast"))
	local isLock = self._goodFeelLv < data.unlockLv
	local notShowNewIcon = GameUtil.isBitOpenByDigit(self._bitNum, data.unlockLv - 1)

	nameText.text = isLock and string.format("好感度%s级解锁", data.unlockLv) or data.name

	bgChange:SetState(isLock and 1 or 0)

	local isNew = not isLock and not notShowNewIcon

	goutil.setActive(newIcon, isNew)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		goutil.setActive(newIcon, false)

		if not isLock and isNew then
			GoodFeelingAgent.instance:sendPM_GFViewStoryReq(self._raceId, data.storyId)
		end

		self:_onClickStory(data.storyId, data.unlockLv)
	end)
end

function GoodfeelstroyView:_clearTableview(cell)
	return
end

function GoodfeelstroyView:_onClickStory(storyId, unlockLv)
	if unlockLv > self._goodFeelLv then
		FloatWordMgr.instance:show("好感度达到" .. unlockLv .. "级后解锁")

		return
	end

	StoryController.instance:startStory(storyId, StoryModel.StoryType.Goodfeel)
end

function GoodfeelstroyView:_updateView()
	self._raceId = GoodFeelModel.instance:getPetShowViewCurrRaceId()

	local cfg = HandbookConfig.instance:getPetDetailsCfgById(self._raceId)

	self._curViewDatas = GoodFeelConfig.instance:getStroyCfgsByPlantId(cfg.storyPlan)
	self._bitNum = GoodFeelModel.instance:getStoryViewBit(self._raceId)
	self._goodFeelLv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)

	goutil.setActive(self._emptyTipGo, not self._curViewDatas or #self._curViewDatas <= 0)
	self:reloadData()
end

function GoodfeelstroyView:_viewStoryRes()
	self:_updateView()
end

function GoodfeelstroyView:_onChangePetShow()
	self:_updateView()
end

function GoodfeelstroyView:_doMove()
	local isFromGift = self:getFirstParam()

	if isFromGift then
		self._rootTween:Begin()
	else
		GameUtil.setAnchoredPos(self._rootTween.gameObject, self._rootTween.to.x, self._rootTween.to.y)
	end
end

return GoodfeelstroyView
