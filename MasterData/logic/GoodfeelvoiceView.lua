-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelvoiceView.lua

module("logic.extensions.goodfeel.view.GoodfeelvoiceView", package.seeall)

local GoodfeelvoiceView = class("GoodfeelvoiceView", TableViewComponent)

function GoodfeelvoiceView:ctor()
	GoodfeelvoiceView.super.ctor(self)
end

function GoodfeelvoiceView:_getPath()
	return {
		cellPath = "mask/root/tablecell",
		viewPath = "mask/root/tableview"
	}
end

function GoodfeelvoiceView:buildUI()
	GoodfeelvoiceView.super.buildUI(self)

	self._rootTween = self:getGo("mask/root"):GetComponent(UnityTweensType.TweenPosition)
end

function GoodfeelvoiceView:bindEvents()
	GoodfeelvoiceView.super.bindEvents(self)
end

function GoodfeelvoiceView:unbindEvents()
	GoodfeelvoiceView.super.unbindEvents(self)
end

function GoodfeelvoiceView:destroyUI()
	GoodfeelvoiceView.super.destroyUI(self)
end

function GoodfeelvoiceView:onEnter()
	GoodfeelvoiceView.super.onEnter(self)
	GlobalDispatcher:addListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	GlobalDispatcher:addListener(GoodFeelController.RealUseGift, self._updateView, self)
	self:_updateView()
	self:_doMove()
end

function GoodfeelvoiceView:onEnterFinished()
	GoodfeelvoiceView.super.onEnterFinished(self)
end

function GoodfeelvoiceView:onExit()
	GoodfeelvoiceView.super.onExit(self)
	self._rootTween:Stop()
	GlobalDispatcher:removeListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	GlobalDispatcher:removeListener(GoodFeelController.RealUseGift, self._updateView, self)
end

function GoodfeelvoiceView:onExitFinished()
	GoodfeelvoiceView.super.onExitFinished(self)
end

function GoodfeelvoiceView:_cellSize(view, index)
	return 120, 90
end

function GoodfeelvoiceView:_updateCell(view, cell, data)
	local cvCfg = data.cvCfg
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local bg = goutil.findChild(cell.gameObject, "bg")
	local btn = GameUtil.asBtn(cell.gameObject)
	local isLock = self._goodFeelLv < cvCfg.goodfeelUnlockLv

	nameText.text = isLock and string.format("好感度%s级解锁", cvCfg.goodfeelUnlockLv) or cvCfg.usageScenarios

	GameUtil.SetGray(bg, isLock)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickVoice(isLock, cvCfg)
	end)
end

function GoodfeelvoiceView:_clearTableview(cell)
	return
end

function GoodfeelvoiceView:_onClickVoice(isLock, cvCfg)
	if not isLock then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_HANGAN_YUYIN)

		local petCo = CharacterConfig.instance:getPetCo(self._raceId)

		if petCo then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.GOODFEEL_VOICE_NAME, petCo.name)
		end

		GlobalDispatcher:dispatch(GoodFeelController.PlayVoiceCv, cvCfg)
	else
		FloatWordMgr.instance:show("语音未解锁")
	end
end

function GoodfeelvoiceView:_updateView()
	self._raceId, self._skinId = GoodFeelModel.instance:getPetShowViewCurrRaceId()
	self._goodFeelLv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)

	local allList = {}
	local list = CharacterConfig.instance:getPetCvCfg(self._skinId) or {}

	for k, vcfg in ipairs(list) do
		table.insert(allList, {
			cvCfg = vcfg
		})
	end

	self._curViewDatas = allList

	self:reloadData()
end

function GoodfeelvoiceView:_onChangePetShow()
	self:_updateView()
end

function GoodfeelvoiceView:_doMove()
	local isFromGift = self:getFirstParam()

	if isFromGift then
		self._rootTween:Begin()
	else
		GameUtil.setAnchoredPos(self._rootTween.gameObject, self._rootTween.to.x, self._rootTween.to.y)
	end
end

return GoodfeelvoiceView
