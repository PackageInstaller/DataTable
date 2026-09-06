-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelanswerView.lua

module("logic.extensions.goodfeel.view.GoodfeelanswerView", package.seeall)

local GoodfeelanswerView = class("GoodfeelanswerView", ViewComponent)

function GoodfeelanswerView:ctor()
	GoodfeelanswerView.super.ctor(self)
end

function GoodfeelanswerView:buildUI()
	GoodfeelanswerView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._lvText = goutil.findChildTextComponent(self.mainGO, "lvBg/text")
	self._timuText = goutil.findChildTextComponent(self.mainGO, "timuText")
	self._descText = goutil.findChildTextComponent(self.mainGO, "descText")
	self._answerBtnCell = self:getGo("answerBtn")
	self._answerBtnCon = self:getGo("btnCon")
	self._itemGroup = ItemGroup.New(self._answerBtnCon, self._answerBtnCell, nil, nil, true)
	self._roleImg = self:getGo("mask/roleImg")
end

function GoodfeelanswerView:bindEvents()
	GoodfeelanswerView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function GoodfeelanswerView:unbindEvents()
	GoodfeelanswerView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function GoodfeelanswerView:destroyUI()
	GoodfeelanswerView.super.destroyUI(self)
end

function GoodfeelanswerView:onEnter()
	GoodfeelanswerView.super.onEnter(self)

	local params = self:getOpenParam()

	self._raceId = params[1]
	self._eventType = params[2]
	self._contentId = params[3]

	local aCfg = GoodFeelConfig.instance:getAnsertEvent(self._contentId)

	if not aCfg then
		printError("缺失配置：", self._contentId)
		self:close()

		return
	end

	self._lvText.text = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)
	self._timuText.text = aCfg.topic
	self._descText.text = GoodFeelConfig.instance:getCommonAnswerEventDesc()

	local mCfg = CharacterConfig.instance:getModelCo(self._raceId)

	uGuiUtil.setSpriteToImage(self._roleImg, nil, GameUrl.getPetImgUrl(mCfg.cardName))
	self:_setAnswerBtns(aCfg)
end

function GoodfeelanswerView:onEnterFinished()
	GoodfeelanswerView.super.onEnterFinished(self)
end

function GoodfeelanswerView:onExit()
	GoodfeelanswerView.super.onExit(self)
	uGuiUtil.clearImage(self._roleImg)
end

function GoodfeelanswerView:onExitFinished()
	GoodfeelanswerView.super.onExitFinished(self)
end

function GoodfeelanswerView:_setAnswerBtns(cfg)
	local list = {
		{
			tag = "A",
			txt = "A." .. cfg.A
		},
		{
			tag = "B",
			txt = "B." .. cfg.B
		},
		{
			tag = "C",
			txt = "C." .. cfg.C
		},
		{
			tag = "D",
			txt = "D." .. cfg.D
		}
	}

	self._itemGroup:updateWithMoArray(list, function(item, data)
		local nameText = goutil.findChildTextComponent(item.mainGO, "text")
		local btn = GameUtil.asBtn(item.mainGO)

		nameText.text = data.txt

		btn:RemoveClickListener()
		btn:AddClickListener(function()
			local win = data.tag == cfg.rightAnswer

			GoodFeelModel.instance:setClientAnswer(win, data.txt, cfg.rightAnswer .. "." .. cfg[cfg.rightAnswer])
			GoodFeelController.instance:sendPM_GFHandleEventReq(self._raceId, win)
			self:close()
		end)
	end)
end

return GoodfeelanswerView
