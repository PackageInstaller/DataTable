-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroTalkView.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTalkView", package.seeall)

local DiceHeroTalkView = class("DiceHeroTalkView", BaseView)

function DiceHeroTalkView:onInitView()
	self._txtTitle = gohelper.findChildTextMesh(self.viewGO, "#txt_title")
	self._goNarration = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_narration")
	self._gotalk = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_talk")
	self._goreward = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_reward")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_reward/#go_item")
	self._goarrow = gohelper.findChild(self.viewGO, "#scroll_contentlist/arrow")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._scrollRoot = gohelper.findChild(self.viewGO, "#scroll_contentlist")
	self._rewardFullBg = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_reward/#go_fullbg")
	self._transcontent = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content").transform
	self.scrollContent = gohelper.findChildScrollRect(self.viewGO, "#scroll_contentlist")
	self._transscroll = self.scrollContent.transform
end

function DiceHeroTalkView:addEvents()
	NavigateMgr.instance:addSpace(ViewName.DiceHeroTalkView, self._clickSpace, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchDown, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self.onTouchUp, self)
	self.scrollContent:AddOnValueChanged(self.onScrollValueChanged, self)
	self._btnSkip:AddClickListener(self._skipStory, self)
end

function DiceHeroTalkView:removeEvents()
	self.scrollContent:RemoveOnValueChanged()
	self._btnSkip:RemoveClickListener()
end

function DiceHeroTalkView:onOpen()
	if self.viewParam then
		local co = self.viewParam.co
		local gameInfo = DiceHeroModel.instance:getGameInfo(co.chapter)

		if not co then
			logError("配置不存在？？" .. tostring(gameInfo.currLevel))

			return
		end

		self._co = co
		DiceHeroModel.instance.talkId = co.dialog
		DiceHeroModel.instance.stepId = 0

		local dialogSteps = lua_dice_dialogue.configDict[co.dialog]

		if not dialogSteps then
			logError("对话配置不存在" .. tostring(co.dialog))

			return
		end

		gohelper.setActive(self._goNarration, false)
		gohelper.setActive(self._gotalk, false)
		gohelper.setActive(self._rewardFullBg, false)

		local contentGos = {}
		local contentTxts = {}

		for _, dialogStepCo in ipairs(dialogSteps) do
			if dialogStepCo.type == DiceHeroEnum.DialogContentType.Title then
				self._txtTitle.text = dialogStepCo.desc
			elseif dialogStepCo.type == DiceHeroEnum.DialogContentType.Narration then
				local go = gohelper.cloneInPlace(self._goNarration)

				if dialogStepCo.line ~= 1 then
					local line = gohelper.findChild(go, "line")

					gohelper.setActive(line, false)
				end

				local txt = gohelper.findChildTextMesh(go, "txt")

				txt.text = ""

				table.insert(contentGos, go)
				table.insert(contentTxts, {
					isEnd = false,
					txt = txt,
					chars = GameUtil.getUCharArrWithoutRichTxt(dialogStepCo.desc),
					stepId = dialogStepCo.step
				})
			else
				local go = gohelper.cloneInPlace(self._gotalk)
				local txt = gohelper.findChildTextMesh(go, "txt")

				txt.text = ""

				table.insert(contentGos, go)
				table.insert(contentTxts, {
					isEnd = false,
					txt = txt,
					chars = GameUtil.getUCharArrWithoutRichTxt(dialogStepCo.speaker .. dialogStepCo.desc),
					stepId = dialogStepCo.step
				})
			end
		end

		if gameInfo:hasReward() and gameInfo.currLevel == self._co.id and not gameInfo.allPass then
			local rewardItem = gameInfo.rewardItems

			if self._co.mode == 1 then
				rewardItem = {}

				for k, v in ipairs(gameInfo.rewardItems) do
					if v.type == DiceHeroEnum.RewardType.Hero then
						self._noShowBg = true

						gohelper.setActive(self._rewardFullBg, true)

						v.index = k

						table.insert(rewardItem, v)

						local characterCo = lua_dice_character.configDict[v.id]

						if not string.nilorempty(characterCo.relicIds) then
							for _, relicId in ipairs(string.splitToNumber(characterCo.relicIds, "#")) do
								local rewardMo = DiceHeroRewardMo.New()

								rewardMo.id = relicId
								rewardMo.type = DiceHeroEnum.RewardType.Relic
								rewardMo.index = k

								table.insert(rewardItem, rewardMo)
							end
						end

						if not string.nilorempty(characterCo.skilllist) then
							for _, skillId in ipairs(string.splitToNumber(characterCo.skilllist, "#")) do
								local rewardMo = DiceHeroRewardMo.New()

								rewardMo.id = skillId
								rewardMo.type = DiceHeroEnum.RewardType.SkillCard
								rewardMo.index = k

								table.insert(rewardItem, rewardMo)
							end
						end
					else
						v.index = k

						table.insert(rewardItem, v)
					end
				end
			else
				for k, v in ipairs(gameInfo.rewardItems) do
					v.isShowAll = nil
				end
			end

			self._rewardItem = rewardItem

			gohelper.CreateObjList(self, self._createRewardItem, rewardItem, self._goreward, self._gorewarditem, nil, nil, nil, 1)
			gohelper.setAsLastSibling(self._goreward)
			table.insert(contentGos, self._goreward)
		end

		gohelper.setActive(self._goreward, false)

		self._contentGos = contentGos
		self._contentTxts = contentTxts

		gohelper.setActive(self._goarrow, true)
		self:nextStep()
		TaskDispatcher.runRepeat(self._autoSpeak, self, 0.02)

		if self._rewardItem and co.isSkip == 1 then
			self:_realSkipStory()
		end
	end
end

function DiceHeroTalkView:onTouchDown()
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroTalkView) then
		self._isKeyDown = false

		return
	end

	if not self._tweenId then
		self._isKeyDown = true
	end
end

function DiceHeroTalkView:_clickSpace()
	if not self._tweenId then
		self:nextStep()
	end
end

function DiceHeroTalkView:onTouchUp()
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroTalkView) then
		return
	end

	if self._isKeyDown then
		if self._contentGos[1] then
			self:nextStep()
		else
			local gameInfo = DiceHeroModel.instance:getGameInfo(self._co.chapter)

			if not gameInfo:hasReward() and gameInfo.currLevel == self._co.id or gameInfo.currLevel ~= self._co.id then
				if not self._isSendStat then
					DiceHeroStatHelper.instance:sendStoryEnd(true, false)
				end

				self._isSendStat = true

				self:closeThis()
			end
		end
	end
end

function DiceHeroTalkView:onScrollValueChanged(scrollX, scrollY)
	if math.abs(scrollY) > 0.05 then
		self._isKeyDown = false
	end
end

function DiceHeroTalkView:_autoSpeak()
	if not self._curTxtData or self._curTxtData.isEnd then
		if self._curTxtData and not self._curTxtData.isScrollEnd then
			self._curTxtData.isScrollEnd = true
			self.scrollContent.verticalNormalizedPosition = 0
		end

		return
	end

	if not self._curTxtData.index then
		local curIndex = 0

		curIndex = curIndex + 1
		self._curTxtData.index = curIndex
		self._curTxtData.txt.text = table.concat(self._curTxtData.chars, "", 1, curIndex)
		self._curTxtData.isEnd = curIndex >= #self._curTxtData.chars
		self.scrollContent.verticalNormalizedPosition = 0

		if self._curTxtData.isEnd then
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
		end
	end
end

function DiceHeroTalkView:nextStep()
	if self._curTxtData and not self._curTxtData.isEnd then
		self._curTxtData.index = #self._curTxtData.chars - 1

		return
	end

	local go = table.remove(self._contentGos, 1)

	self._curTxtData = table.remove(self._contentTxts, 1)

	if self._curTxtData then
		DiceHeroModel.instance.stepId = self._curTxtData.stepId or DiceHeroModel.instance.stepId

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_feichi_yure_caption)
	else
		gohelper.setActive(self._btnSkip, false)
	end

	if not go then
		gohelper.setActive(self._goarrow, false)
		self:checkSendLevelReq()

		return
	end

	if not self._contentGos[1] then
		gohelper.setActive(self._goarrow, false)
		self:checkSendLevelReq()
	end

	gohelper.setActive(go, true)
	ZProj.UGUIHelper.RebuildLayout(self._transcontent)

	local height1 = recthelper.getHeight(self._transcontent)
	local height2 = recthelper.getHeight(self._transscroll)

	self:killTween()

	if height2 < height1 and not self._curTxtData then
		local height3 = recthelper.getHeight(self._goreward.transform)
		local toPos = Mathf.Clamp(1 - (height1 - height3) / (height1 - height2), 0, 1)

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(self.scrollContent.verticalNormalizedPosition, toPos, 0.3, self.tweenFrameCallback, self.tweenFinishCallback, self)
	end
end

function DiceHeroTalkView:_skipStory()
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, self._realSkipStory, nil, nil, self)
end

function DiceHeroTalkView:_realSkipStory()
	if not self._rewardItem then
		if not self:checkSendLevelReq(true) then
			self:closeThis()
		end

		return
	end

	if self._curTxtData then
		self._curTxtData.txt.text = table.concat(self._curTxtData.chars, "")
		self._curTxtData = nil
	end

	for i, v in ipairs(self._contentTxts) do
		v.txt.text = table.concat(v.chars, "")
	end

	tabletool.clear(self._contentTxts)

	for i, v in ipairs(self._contentGos) do
		gohelper.setActive(v, true)
	end

	tabletool.clear(self._contentGos)
	ZProj.UGUIHelper.RebuildLayout(self._transcontent)

	local height1 = recthelper.getHeight(self._transcontent)
	local height2 = recthelper.getHeight(self._transscroll)
	local height3 = recthelper.getHeight(self._goreward.transform)

	self.scrollContent.verticalNormalizedPosition = Mathf.Clamp(1 - (height1 - height3) / (height1 - height2), 0, 1)

	gohelper.setActive(self._btnSkip, false)
	gohelper.setActive(self._goarrow, false)
end

function DiceHeroTalkView:checkSendLevelReq(isSkip)
	local gameInfo = DiceHeroModel.instance:getGameInfo(self._co.chapter)

	if gameInfo.currLevel == self._co.id and not gameInfo.allPass and self._co.rewardSelectType == DiceHeroEnum.GetRewardType.None then
		if isSkip then
			DiceHeroRpc.instance:sendDiceHeroEnterStory(self._co.id, self._co.chapter, self.closeThis, self)
		else
			DiceHeroRpc.instance:sendDiceHeroEnterStory(self._co.id, self._co.chapter)
		end

		DiceHeroStatHelper.instance:sendStoryEnd(true, true)

		self._isSendStat = true

		return true
	end
end

function DiceHeroTalkView:tweenFrameCallback(value)
	self.scrollContent.verticalNormalizedPosition = value
end

function DiceHeroTalkView:tweenFinishCallback()
	self._tweenId = nil
end

function DiceHeroTalkView:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function DiceHeroTalkView:_createRewardItem(obj, data, index)
	local title = gohelper.findChildTextMesh(obj, "#txt_title")
	local desc = gohelper.findChildTextMesh(obj, "scroll_desc/viewport/#txt_desc")
	local scrollview = gohelper.findChild(obj, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	local btn = gohelper.findChildButtonWithAudio(obj, "#btn_choose")
	local btnLine = gohelper.findChild(obj, "#btn_choose/line")
	local image = gohelper.findChildSingleImage(obj, "headbg/#simage_icon")
	local card = gohelper.findChildImage(obj, "headbg/#go_cardicon")
	local bg = gohelper.findChild(obj, "bg")
	local anim = gohelper.findChildAnim(obj, "")

	scrollview.parentGameObject = self._scrollRoot

	if self._noShowBg then
		gohelper.setActive(bg, false)
		gohelper.setActive(btnLine, false)

		if data.type ~= DiceHeroEnum.RewardType.Hero then
			gohelper.setActive(btn, false)
		end
	end

	data.anim = anim

	self:removeClickCb(btn)

	local var_17_3 = {}

	var_17_3.index = data.index or index
	var_17_3.data = data

	self.addClickCb(self, btn, self._onClickSelect, self, var_17_3)
	gohelper.setActive(card, false)
	gohelper.setActive(image, true)

	if data.type == DiceHeroEnum.RewardType.Hero then
		local co = lua_dice_character.configDict[data.id]

		if co then
			title.text = co.name or ""
		end

		if co then
			desc.text = co.desc or ""
		end

		image:LoadImage(ResUrl.getHeadIconSmall(co.icon))
	elseif data.type == DiceHeroEnum.RewardType.SkillCard then
		local co = lua_dice_card.configDict[data.id]

		if co then
			title.text = co.name or ""
		end

		if co then
			desc.text = co.desc or ""
		end

		UISpriteSetMgr.instance:setDiceHeroSprite(card, "dicehero_cardicon_" .. co.quality)
		gohelper.setActive(card, true)
		gohelper.setActive(image, false)
	elseif data.type == DiceHeroEnum.RewardType.Relic then
		local co = lua_dice_relic.configDict[data.id]

		if co then
			title.text = co.name or ""
		end

		if co then
			desc.text = co.desc or ""
		end

		image:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. co.icon .. ".png")
	end

	anim:Play("open", 0, 0)
end

function DiceHeroTalkView:_onClickSelect(data)
	local rewardData = data.data

	if rewardData.type == DiceHeroEnum.RewardType.Hero and self._co.mode == 2 and not rewardData.isShowAll then
		rewardData.isShowAll = true

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)

		local rewardItem = {}

		rewardData.index = data.index

		table.insert(rewardItem, rewardData)

		local characterCo = lua_dice_character.configDict[rewardData.id]

		if not string.nilorempty(characterCo.relicIds) then
			for _, relicId in ipairs(string.splitToNumber(characterCo.relicIds, "#")) do
				local rewardMo = DiceHeroRewardMo.New()

				rewardMo.id = relicId
				rewardMo.type = DiceHeroEnum.RewardType.Relic
				rewardMo.index = data.index

				table.insert(rewardItem, rewardMo)
			end
		end

		if not string.nilorempty(characterCo.skilllist) then
			for _, skillId in ipairs(string.splitToNumber(characterCo.skilllist, "#")) do
				local rewardMo = DiceHeroRewardMo.New()

				rewardMo.id = skillId
				rewardMo.type = DiceHeroEnum.RewardType.SkillCard
				rewardMo.index = data.index

				table.insert(rewardItem, rewardMo)
			end
		end

		self._rewardItem = rewardItem

		rewardData.anim:Play("finish", 0, 0)
		UIBlockHelper.instance:startBlock("DiceHeroTalkView_GetReward", 0.5)
		TaskDispatcher.runDelay(self._delayRefrshReward, self, 0.5)

		return
	end

	local gameInfo = DiceHeroModel.instance:getGameInfo(self._co.chapter)
	local indexes = {}

	self._allGetIndexes = {}

	if self._co.rewardSelectType == DiceHeroEnum.GetRewardType.One then
		table.insert(indexes, data.index - 1)

		self._allGetIndexes[data.index] = true

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)
	else
		for i, v in ipairs(gameInfo.rewardItems) do
			table.insert(indexes, i - 1)

			self._allGetIndexes[i] = true
		end

		if #indexes > 1 then
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards_rare)
		else
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)
		end
	end

	DiceHeroRpc.instance:sendDiceHeroGetReward(indexes, self._co.chapter, self._getReward, self)
end

function DiceHeroTalkView:_delayRefrshReward()
	gohelper.setActive(self._rewardFullBg, true)

	self._noShowBg = true

	gohelper.CreateObjList(self, self._createRewardItem, self._rewardItem, self._goreward, self._gorewarditem, nil, nil, nil, 1)
end

function DiceHeroTalkView:_getReward(cmd, resultCode, msg)
	if resultCode == 0 then
		for i, v in ipairs(self._rewardItem) do
			if not v.index then
				if self._allGetIndexes[v.index] then
					v.anim:Play("finish", 0, 0)
				end
			end
		end

		UIBlockHelper.instance:startBlock("DiceHeroTalkView_GetReward", 0.5)
		TaskDispatcher.runDelay(self.closeThis, self, 0.5)

		if self._co.type == 1 then
			DiceHeroStatHelper.instance:sendStoryEnd(true, true)

			self._isSendStat = true
		end
	end
end

function DiceHeroTalkView:onDestroyView()
	TaskDispatcher.cancelTask(self._delayRefrshReward, self)
	TaskDispatcher.cancelTask(self._autoSpeak, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
	self:killTween()

	self._contentGos = {}

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
end

function DiceHeroTalkView:onClose()
	if DiceHeroModel.instance.isUnlockNewChapter then
		ViewMgr.instance:closeView(ViewName.DiceHeroLevelView)
	end
end

return DiceHeroTalkView
