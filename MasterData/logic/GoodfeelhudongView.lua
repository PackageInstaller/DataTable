-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelhudongView.lua

module("logic.extensions.goodfeel.view.GoodfeelhudongView", package.seeall)

local GoodfeelhudongView = class("GoodfeelhudongView", ViewComponent)

function GoodfeelhudongView:ctor()
	GoodfeelhudongView.super.ctor(self)
end

function GoodfeelhudongView:buildUI()
	GoodfeelhudongView.super.buildUI(self)

	self._answerBtn = self:getBtn("answerBtn")
	self._lvText = goutil.findChildTextComponent(self.mainGO, "nameText/lvBg/text")
	self._descText = goutil.findChildTextComponent(self.mainGO, "descText")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "nameText")
	self._leftTimeText = goutil.findChildTextComponent(self.mainGO, "leftTimeText")
	self._btnText = goutil.findChildTextComponent(self.mainGO, "answerBtn/text")
	self._roleImg = self:getGo("mask/roleImg")
end

function GoodfeelhudongView:bindEvents()
	GoodfeelhudongView.super.bindEvents(self)
	self._answerBtn:AddClickListener(self._onClickGoToAnswer, self)
end

function GoodfeelhudongView:unbindEvents()
	GoodfeelhudongView.super.unbindEvents(self)
	self._answerBtn:RemoveClickListener()
end

function GoodfeelhudongView:destroyUI()
	GoodfeelhudongView.super.destroyUI(self)
end

function GoodfeelhudongView:onEnter()
	GoodfeelhudongView.super.onEnter(self)

	local params = self:getOpenParam()

	self._raceId = params[1]
	self._cfg = params[2]

	self:_updateView()
end

function GoodfeelhudongView:onEnterFinished()
	GoodfeelhudongView.super.onEnterFinished(self)
end

function GoodfeelhudongView:onExit()
	GoodfeelhudongView.super.onExit(self)
	uGuiUtil.clearImage(self._roleImg)
end

function GoodfeelhudongView:onExitFinished()
	GoodfeelhudongView.super.onExitFinished(self)
end

function GoodfeelhudongView:_onClickGoToAnswer()
	UIStateManager.instance:push(ViewName.GoodfeelanswerView, self._raceId, self._cfg.eventType, self._cfg.contentId)
	self:close()
end

function GoodfeelhudongView:_updateView()
	local infoCo = CharacterConfig.instance:getPetInfoCo(self._raceId)
	local cCfg = CharacterConfig.instance:getPetCo(self._raceId)
	local hudongTime = GoodFeelModel.instance:getTodayInteractUseCount()

	self._nameText.text = cCfg.name
	self._lvText.text = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)
	self._leftTimeText.text = string.format("今日已互动次数：%s", hudongTime)
	self._descText.text = infoCo.goodfeelIntroduce
	self._btnText.text = cCfg.name .. "想考考你"

	local mCfg = CharacterConfig.instance:getModelCo(self._raceId)

	uGuiUtil.setSpriteToImage(self._roleImg, nil, GameUrl.getPetImgUrl(mCfg.cardName))
end

return GoodfeelhudongView
