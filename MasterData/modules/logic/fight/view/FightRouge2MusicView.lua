-- chunkname: @modules/logic/fight/view/FightRouge2MusicView.lua

module("modules.logic.fight.view.FightRouge2MusicView", package.seeall)

local FightRouge2MusicView = class("FightRouge2MusicView", FightBaseView)

function FightRouge2MusicView:onInitView()
	local rectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	local anchor, scale = FightPlayCardLayoutHelper.getAnchorPosAndScale(FightPlayCardLayoutHelper.PlayCardOperateType.MusicNote)

	recthelper.setAnchor(rectTr, anchor.x, anchor.y)
	transformhelper.setLocalScale(rectTr, scale, scale, scale)

	self.viewAnimator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.scrollRectTr = gohelper.findChildComponent(self.viewGO, "root/#scroll_yinfu", gohelper.Type_RectTransform)
	self.musicItem = gohelper.findChild(self.viewGO, "root/#scroll_yinfu/viewport/content/#image_yinfu")

	gohelper.setActive(self.musicItem, false)

	self.itemWidth = recthelper.getWidth(self.musicItem.transform)
	self.halfItemWidth = self.itemWidth / 2
	self.rectDesc2Tr = gohelper.findChildComponent(self.viewGO, "root/#scroll_yinfu/dec2", gohelper.Type_RectTransform)
	self.imageDesc2 = self.rectDesc2Tr:GetComponent(gohelper.Type_Image)
	self.goTips = gohelper.findChild(self.viewGO, "root/#go_tips")

	gohelper.setActive(self.goTips, false)

	self.goTipItem = gohelper.findChild(self.goTips, "tips/#scroll_tips/viewport/content/#go_tipsitem")

	gohelper.setActive(self.goTipItem, false)

	self.tipClick = gohelper.findChildClickWithDefaultAudio(self.goTips, "#btn_click")
	self.click = gohelper.getClick(self.viewGO)
	self.musicItemPool = {}
	self.musicItemList = {}
	self.activingMusicItemList = {}
	self.tweenIdList = {}
	self.musicInfo = self:getRouge2MusicInfo()
	self.musicQueueMax = self.musicInfo.queueMax
	self.music2SkillIdDict = self.musicInfo.type2SkillId
	self.rouge2MusicEntityMo = FightDataHelper.entityMgr:getRouge2Music()
	self.rouge2MusicEntityId = self.rouge2MusicEntityMo.id
end

function FightRouge2MusicView:addEvents()
	self.tipClick:AddClickListener(self.onClickTip, self)
	self.click:AddClickListener(self.onClickSelf, self)
	self.addEventCb(self, FightController.instance, FightEvent.Rouge2_OnAddMusicType, self.onAddMusicType, self)
	self.addEventCb(self, FightController.instance, FightEvent.Rouge2_OnPopMusicType, self.onPopMusicType, self)
	self.addEventCb(self, FightController.instance, FightEvent.Rouge2_OnPlayMusicActive, self.onPlayMusicActive, self)
	self.addEventCb(self, FightController.instance, FightEvent.Rouge2_ForceRefreshMusicType, self.onForceRefreshMusicType, self)
	self.addEventCb(self, FightController.instance, FightEvent.Rouge2_ScanMusic, self.onScanMusic, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self.onPlayHandCard, self)
end

function FightRouge2MusicView:onClickSelf()
	if not self.hasDesc then
		return
	end

	gohelper.setActive(self.goTips, true)
end

function FightRouge2MusicView:onClickTip()
	gohelper.setActive(self.goTips, false)
end

local AddBlueCountBehaviourType = 40013

function FightRouge2MusicView:onPlayHandCard(cardMo)
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Operate then
		return
	end

	if cardMo.uid ~= FightEntityScene.MySideId then
		return
	end

	local skillCo = lua_skill.configDict[cardMo.skillId]

	if not skillCo then
		return
	end

	local change = false

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, behaviourArray in ipairs(array) do
				if behaviourArray[1] == AddBlueCountBehaviourType then
					change = true

					FightDataHelper.rouge2MusicDataMgr:addClientBlueValue(behaviourArray[2])
				end
			end
		end
	end

	if change then
		self:refreshBlueValue()
	end
end

function FightRouge2MusicView:refreshBlueValue()
	for _, musicItem in ipairs(self.musicItemList) do
		musicItem.txtNum.text = musicItem.musicNote.blueValue + musicItem.musicNote.preAddValue
	end
end

FightRouge2MusicView.ScanDuration = 0.5

function FightRouge2MusicView:onScanMusic()
	if not self.scrollWidth then
		return
	end

	local musicList = FightDataHelper.rouge2MusicDataMgr:getServerMusicNoteList()

	if #musicList < 1 then
		return
	end

	gohelper.setActive(self.viewGO, true)
	self:clearScanTween()
	self:clearResetTrTween()

	for _, musicItem in ipairs(self.musicItemList) do
		musicItem.playedScanAnim = false
	end

	self.scanTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, FightRouge2MusicView.ScanDuration, self.onScanFrameCallback, self.onScanDone, self)
end

function FightRouge2MusicView:onScanFrameCallback(value)
	local posX = value * self.scrollWidth

	recthelper.setAnchorX(self.rectDesc2Tr, posX)

	for _, musicItem in ipairs(self.musicItemList) do
		if not musicItem.playedScanAnim then
			local musicItemPosX = recthelper.getAnchorX(musicItem.rectTr)

			musicItemPosX = -musicItemPosX
			musicItemPosX = musicItemPosX + self.halfItemWidth

			local rectPosX = self.scrollWidth - musicItemPosX

			if rectPosX <= posX then
				musicItem.animatorPlayer:Play("fight_rouge2_yinfu_play")

				musicItem.playedScanAnim = true
			end
		end
	end
end

function FightRouge2MusicView:clearScanTween()
	if self.scanTweenId then
		ZProj.TweenHelper.KillById(self.scanTweenId)

		self.scanTweenId = nil
	end
end

FightRouge2MusicView.ResetDesc2TweenDuration = 0.2

function FightRouge2MusicView:onScanDone()
	self.scanTweenId = nil
	self.resetDesc2TrTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, FightRouge2MusicView.ResetDesc2TweenDuration, self.onResetDesc2TweenCallback, self.onResetDesc2Done, self)
end

function FightRouge2MusicView:clearResetTrTween()
	if self.resetDesc2TrTweenId then
		ZProj.TweenHelper.KillById(self.resetDesc2TrTweenId)

		self.resetDesc2TrTweenId = nil
	end
end

function FightRouge2MusicView:onResetDesc2TweenCallback(value)
	local alpha

	if value >= 0.5 then
		value = value - 0.5
		alpha = value * 2

		recthelper.setAnchorX(self.rectDesc2Tr, 0)
	else
		alpha = 1 - value * 2
	end

	ZProj.UGUIHelper.SetColorAlpha(self.imageDesc2, alpha)
end

function FightRouge2MusicView:onResetDesc2Done()
	self.resetDesc2TrTweenId = nil
end

function FightRouge2MusicView:onPlayMusicActive()
	for _, musicItem in ipairs(self.activingMusicItemList) do
		if not musicItem.playedActiveAnim then
			musicItem.playedActiveAnim = true

			musicItem.animatorPlayer:Play("active", self.onPlayActiveDone, self, musicItem)
			AudioMgr.instance:trigger(20320602)
		end
	end
end

function FightRouge2MusicView:onStageChanged(stage)
	local showUi = stage == FightStageMgr.StageType.Operate

	if not showUi then
		self.viewAnimator:Play("close", self.onCloseDone, self)

		return
	end

	self.viewAnimator:Stop()
	gohelper.setActive(self.viewGO, true)
end

function FightRouge2MusicView:onCloseDone()
	gohelper.setActive(self.viewGO, false)
end

function FightRouge2MusicView:onForceRefreshMusicType()
	self:forceRefreshMusic()
end

function FightRouge2MusicView:onPopMusicType(musicType)
	if not musicType then
		return
	end

	self:popMusicItem()
end

function FightRouge2MusicView:onAddMusicType(musicNote)
	local musicItem = self:addMusicItem(musicNote)

	musicItem.animatorPlayer:Play("in")
	self:tweenMusicItem()
	AudioMgr.instance:trigger(20320601)
end

function FightRouge2MusicView:popMusicItem()
	local musicItem = table.remove(self.musicItemList)

	if musicItem then
		table.insert(self.activingMusicItemList, 1, musicItem)
	end

	self:tweenMusicItem()
end

function FightRouge2MusicView:onPlayActiveDone(musicItem)
	tabletool.removeValue(self.activingMusicItemList, musicItem)
	self:recycleItem(musicItem)
end

function FightRouge2MusicView:getMusicItem()
	if #self.musicItemPool > 0 then
		return table.remove(self.musicItemPool)
	end

	local musicItem = self:getUserDataTb_()

	musicItem.go = gohelper.cloneInPlace(self.musicItem)
	musicItem.rectTr = musicItem.go:GetComponent(gohelper.Type_RectTransform)
	musicItem.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(musicItem.go)
	musicItem.imageIcon = gohelper.findChildImage(musicItem.go, "image")
	musicItem.rectTrIcon = musicItem.imageIcon:GetComponent(gohelper.Type_RectTransform)
	musicItem.goLight = gohelper.findChild(musicItem.go, "light")
	musicItem.goFrame = gohelper.findChild(musicItem.go, "frame")
	musicItem.txtNum = gohelper.findChildText(musicItem.go, "#txt_num")
	musicItem.goNum = musicItem.txtNum.gameObject

	gohelper.setActive(musicItem.goLight, true)
	gohelper.setActive(musicItem.goFrame, true)
	gohelper.setActive(musicItem.goNum, false)

	musicItem.goAnim = gohelper.findChild(musicItem.go, "active_ani")

	return musicItem
end

function FightRouge2MusicView:addMusicItem(music)
	local musicType = music.type
	local musicItem = self:getMusicItem()

	gohelper.setActive(musicItem.go, true)
	gohelper.setAsLastSibling(musicItem.go)

	local co = FightConfig.instance:getRouge2MusicCo(musicType)

	UISpriteSetMgr.instance:setFightSprite(musicItem.imageIcon, co.icon2)

	local isBlue = musicType == FightEnum.Rouge2MusicType.Blue

	gohelper.setActive(musicItem.goNum, isBlue)
	table.insert(self.musicItemList, 1, musicItem)

	musicItem.musicNote = music

	if isBlue then
		musicItem.txtNum.text = music.blueValue + music.preAddValue
	end

	local posX = self:getMusicItemPos(1)

	recthelper.setAnchorX(musicItem.rectTr, posX)

	local posY = self:randomPosY()
	local scale = self:getScale()

	recthelper.setAnchorY(musicItem.rectTrIcon, posY)
	transformhelper.setLocalScale(musicItem.rectTrIcon, scale, scale, 1)

	return musicItem
end

FightRouge2MusicView.ActivingMusicItemStartPosX = 222.85

function FightRouge2MusicView:getMusicItemPos(index)
	if index > self.musicQueueMax then
		index = index - self.musicQueueMax

		local posX = (index - 1) * self.itemWidth + self:getActivingStartPosX()

		return -posX
	end

	local posX = (index - 1) * self.itemWidth

	return -posX
end

function FightRouge2MusicView:getActivingStartPosX()
	local offset = (self.musicQueueMax - 3) * self.itemWidth

	return FightRouge2MusicView.ActivingMusicItemStartPosX + offset
end

FightRouge2MusicView.Type2Pos = {
	0,
	-5,
	5
}

function FightRouge2MusicView:randomPosY()
	local posYType = math.random(1, 3)

	return FightRouge2MusicView.Type2Pos[posYType]
end

function FightRouge2MusicView:getScale()
	local scaleType = math.random(1, 2)

	return scaleType == 1 and 1 or -1
end

function FightRouge2MusicView:recycleItem(musicItem)
	musicItem.playedActiveAnim = nil
	musicItem.playedScanAnim = nil
	musicItem.musicNote = nil

	gohelper.setActive(musicItem.go, false)
	table.insert(self.musicItemPool, musicItem)
end

function FightRouge2MusicView:getRouge2MusicInfo()
	local teamType = FightEnum.TeamType.MySide
	local teamDataMgr = FightDataHelper.teamDataMgr

	return (teamDataMgr:getRouge2MusicInfo(teamType))
end

function FightRouge2MusicView:onOpen()
	local stage = FightDataHelper.stageMgr:getCurStage()
	local showUi = stage == FightStageMgr.StageType.Operate

	gohelper.setActive(self.viewGO, showUi)
	self:setScrollRectWidth()
	self:forceRefreshMusic()
	self:refreshTipDesc()
end

function FightRouge2MusicView:refreshTipDesc()
	local bagType = Rouge2_Enum.BagType.Buff
	local moList = Rouge2_BackpackModel.instance:getItemList(bagType)

	self.hasDesc = moList and #moList > 0

	if not self.hasDesc then
		return
	end

	for _, mo in ipairs(moList) do
		local goTipItem = gohelper.cloneInPlace(self.goTipItem)

		gohelper.setActive(goTipItem, true)

		local config = mo:getConfig()
		local txtTip = gohelper.findChildText(goTipItem, "title/#txt_name")
		local txtDesc = gohelper.findChildText(goTipItem, "txt_desc")

		txtTip.text = config.name
		txtDesc.text = SkillHelper.buildDesc(config.descSimply)

		SkillHelper.addHyperLinkClick(txtDesc)
	end
end

function FightRouge2MusicView:setScrollRectWidth()
	local maxCount = self.musicQueueMax
	local width = maxCount * self.itemWidth

	recthelper.setWidth(self.scrollRectTr, width)

	self.scrollWidth = width
end

function FightRouge2MusicView:forceRefreshMusic()
	self:clearPosTween()

	for _, musicItem in ipairs(self.musicItemList) do
		self:recycleItem(musicItem)
	end

	tabletool.clear(self.musicItemList)

	for _, musicItem in ipairs(self.activingMusicItemList) do
		self:recycleItem(musicItem)
	end

	tabletool.clear(self.activingMusicItemList)

	local musicList = FightDataHelper.rouge2MusicDataMgr:getClientMusicNoteList()

	for _, music in ipairs(musicList) do
		self:addMusicItem(music)
	end

	self:refreshMusicItemPos()
end

function FightRouge2MusicView:refreshMusicItemPos()
	self:clearPosTween()

	for index, musicItem in ipairs(self.musicItemList) do
		local posX = self:getMusicItemPos(index)

		recthelper.setAnchorX(musicItem.rectTr, posX)
	end
end

FightRouge2MusicView.TweenDuration = 0.3333

function FightRouge2MusicView:tweenMusicItem()
	self:clearPosTween()

	local duration = FightRouge2MusicView.TweenDuration

	for index, musicItem in ipairs(self.musicItemList) do
		local posX = self:getMusicItemPos(index)
		local tweenId = ZProj.TweenHelper.DOAnchorPosX(musicItem.rectTr, posX, duration)

		table.insert(self.tweenIdList, tweenId)
	end

	local len = #self.musicItemList

	for index, musicItem in ipairs(self.activingMusicItemList) do
		local posX = self:getMusicItemPos(len + index)
		local tweenId = ZProj.TweenHelper.DOAnchorPosX(musicItem.rectTr, posX, duration)

		table.insert(self.tweenIdList, tweenId)
	end
end

function FightRouge2MusicView:clearPosTween()
	for _, tweenId in ipairs(self.tweenIdList) do
		ZProj.TweenHelper.KillById(tweenId)
	end

	tabletool.clear(self.tweenIdList)
end

function FightRouge2MusicView:onDestroyView()
	if self.tipClick then
		self.tipClick:RemoveClickListener()

		self.tipClick = nil
	end

	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end

	self:clearScanTween()
	self:clearPosTween()
end

return FightRouge2MusicView
