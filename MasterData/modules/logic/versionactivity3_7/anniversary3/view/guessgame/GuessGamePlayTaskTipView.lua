-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayTaskTipView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayTaskTipView", package.seeall)

local GuessGamePlayTaskTipView = class("GuessGamePlayTaskTipView", BaseView)

function GuessGamePlayTaskTipView:onInitView()
	self._gogifts = gohelper.findChild(self.viewGO, "#go_gifts")
	self._gogiftitem = gohelper.findChild(self.viewGO, "#go_gifts/#go_giftitem")
	self._gotasktips = gohelper.findChild(self.viewGO, "#go_tasktips")
	self._imagegift = gohelper.findChildImage(self.viewGO, "#go_tasktips/#image_gift")
	self._txttasktip = gohelper.findChildText(self.viewGO, "#go_tasktips/#txt_tasktip")
	self._goscore = gohelper.findChild(self.viewGO, "#go_score")
	self._txtscore = gohelper.findChildText(self.viewGO, "#go_score/#txt_score")
	self._goaddeff = gohelper.findChild(self.viewGO, "#go_score/#vx_add")
	self._goreduceeff = gohelper.findChild(self.viewGO, "#go_score/#vx_lose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGamePlayTaskTipView:addEvents()
	return
end

function GuessGamePlayTaskTipView:removeEvents()
	return
end

function GuessGamePlayTaskTipView:_editableInitView()
	gohelper.setActive(self._gogiftitem, false)

	self._tipGiftItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function GuessGamePlayTaskTipView:_addSelfEvents()
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnRefreshTaskTipScore, self._refreshScore, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnRefreshTaskTipUnlockChanged, self._onUnlockGiftChanged, self)
end

function GuessGamePlayTaskTipView:_removeSelfEvents()
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnRefreshTaskTipScore, self._refreshScore, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnRefreshTaskTipUnlockChanged, self._onUnlockGiftChanged, self)
end

function GuessGamePlayTaskTipView:_onUnlockGiftChanged()
	if self._tipGiftItems then
		for _, v in pairs(self._tipGiftItems) do
			v:refreshCount()
		end
	end
end

function GuessGamePlayTaskTipView:onUpdateParam()
	return
end

function GuessGamePlayTaskTipView:onOpen()
	self:_initUI()
end

function GuessGamePlayTaskTipView:_initUI()
	self:_refreshScore()

	local episodeId = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.EpisodeId)
	local episodeCo = Activity234Config.instance:getEpisodeCo(episodeId)

	if not episodeCo then
		return
	end

	local lays = GameUtil.splitString2(episodeCo.layout, true, "|", "#")

	for index, lay in ipairs(lays) do
		if not self._tipGiftItems[index] then
			self._tipGiftItems[index] = GuessGamePlayTipGiftItem.New()

			local go = gohelper.cloneInPlace(self._gogiftitem)

			self._tipGiftItems[index]:init(go)
		end

		self._tipGiftItems[index]:refresh(lay)
	end
end

function GuessGamePlayTaskTipView:_refreshScore()
	local score = GuessGameModel.instance:getResultScoreByGameScore()

	if not self._score then
		self._score = score
		self._txtscore.text = self._score

		return
	end

	if score == self._score then
		return
	end

	gohelper.setActive(self._goaddeff, score > self._score)
	gohelper.setActive(self._goreduceeff, score < self._score)
	TaskDispatcher.runDelay(self._onPlayScoreEffFinished, self, 1)

	self._score = score
	self._txtscore.text = self._score
end

function GuessGamePlayTaskTipView:_onPlayScoreEffFinished()
	gohelper.setActive(self._goaddeff, false)
	gohelper.setActive(self._goreduceeff, false)
end

function GuessGamePlayTaskTipView:onClose()
	return
end

function GuessGamePlayTaskTipView:onDestroyView()
	TaskDispatcher.cancelTask(self._onPlayScoreEffFinished, self)

	if self._tipGiftItems then
		for _, v in pairs(self._tipGiftItems) do
			v:destroy()
		end

		self._tipGiftItems = nil
	end

	self:_removeSelfEvents()
end

return GuessGamePlayTaskTipView
