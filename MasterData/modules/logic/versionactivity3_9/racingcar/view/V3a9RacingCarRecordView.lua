-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarRecordView.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarRecordView", package.seeall)

local V3a9RacingCarRecordView = class("V3a9RacingCarRecordView", BaseView)

function V3a9RacingCarRecordView:onInitView()
	self._gofull = gohelper.findChild(self.viewGO, "#go_full")
	self._scrollRecordList = gohelper.findChildScrollRect(self.viewGO, "root/result/normal/#scroll_RecordList")
	self._goContent = gohelper.findChild(self.viewGO, "root/result/normal/#scroll_RecordList/Viewport/#go_Content")
	self._gosectionInfo = gohelper.findChild(self.viewGO, "root/result/normal/#go_sectionInfo")
	self._txtindex = gohelper.findChildText(self.viewGO, "root/result/normal/#go_sectionInfo/#txt_index")
	self._txtname = gohelper.findChildText(self.viewGO, "root/result/normal/#go_sectionInfo/#txt_name")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/result/normal/#go_sectionInfo/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/result/normal/#go_sectionInfo/#scroll_desc/viewport/content/#txt_desc")
	self._imagechess = gohelper.findChildImage(self.viewGO, "root/result/newRecord/bg/#image_chess")
	self._simageHeroHead = gohelper.findChildSingleImage(self.viewGO, "root/result/newRecord/Hero/HeroHead/#simage_HeroHead")
	self._txtHeroName = gohelper.findChildText(self.viewGO, "root/result/newRecord/Hero/#txt_HeroName")
	self._txtnewRecord = gohelper.findChildText(self.viewGO, "root/result/newRecord/Hero/#txt_newRecord")
	self._gobest = gohelper.findChild(self.viewGO, "root/result/newRecord/#go_best")
	self._txttimes = gohelper.findChildText(self.viewGO, "root/result/newRecord/#go_best/#txt_times")
	self._goBottom = gohelper.findChild(self.viewGO, "root/#go_Bottom")
	self._btntalent = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Bottom/go_btn/#btn_talent")
	self._goreward = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward")
	self._gostar = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#go_star")
	self._gostar1 = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#go_star/#go_star_1")
	self._imageicon1 = gohelper.findChildImage(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#go_star/#go_star_1/#image_icon1")
	self._gostar2 = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#go_star/#go_star_2")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#go_star/#go_star_2/#image_icon2")
	self._gostar3 = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#go_star/#go_star_3")
	self._imageicon3 = gohelper.findChildImage(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#go_star/#go_star_3/#image_icon3")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#scroll_Reward")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._gorare1 = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#scroll_Reward/Viewport/Content/#go_rewarditem/go_rare/#go_rare1")
	self._gorare2 = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#scroll_Reward/Viewport/Content/#go_rewarditem/go_rare/#go_rare2")
	self._gorare3 = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#scroll_Reward/Viewport/Content/#go_rewarditem/go_rare/#go_rare3")
	self._gorare4 = gohelper.findChild(self.viewGO, "root/#go_Bottom/go_btn/#go_reward/#scroll_Reward/Viewport/Content/#go_rewarditem/go_rare/#go_rare4")
	self._btnagain = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Bottom/go_btn/#btn_again")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Bottom/go_btn/#btn_exit")
	self._golefttop = gohelper.findChild(self.viewGO, "root/#go_lefttop")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarRecordView:addEvents()
	self._btntalent:AddClickListener(self._btntalentOnClick, self)
	self._btnagain:AddClickListener(self._btnagainOnClick, self)
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3a9RacingCarRecordView:removeEvents()
	self._btntalent:RemoveClickListener()
	self._btnagain:RemoveClickListener()
	self._btnexit:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function V3a9RacingCarRecordView:_btnclickOnClick()
	gohelper.setActive(self._btnclick, false)

	if self._isNewBest then
		self._isNewBest = false

		gohelper.setActive(self._goBottom, true)
		gohelper.setActive(self._goNewRecord, true)
		gohelper.setActive(self._goNormal, false)

		self._animator.enabled = true

		self._animator:Play("switch")
	end
end

function V3a9RacingCarRecordView:_btntalentOnClick()
	V3a9RacingCarController.instance:onOpenTalentView(V3a9RacingCarModel.instance:getActId())
end

function V3a9RacingCarRecordView:_btnexitOnClick()
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.V3a9RacingCarGameView)
	EnterActivityViewOnExitFightSceneHelper.enterRacingCar()
end

function V3a9RacingCarRecordView:_btnagainOnClick()
	self:closeThis()
	V3a9RacingCarController.instance:restartGame()

	self._animator.enabled = true

	self._animator:Play("again")
	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, self)
end

function V3a9RacingCarRecordView:_editableInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "root/result/normal")
	self._goNewRecord = gohelper.findChild(self.viewGO, "root/result/newRecord")

	gohelper.setActive(self._goNormal, true)
	gohelper.setActive(self._goNewRecord, false)
	gohelper.setActive(self._goBottom, false)
	NavigateMgr.instance:addEscape(self.viewName, self._onEscapeBtnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	self._animator = self.viewGO:GetComponent("Animator")
	self._rewardItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem, false)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._OnCloseView, self)
end

function V3a9RacingCarRecordView:_onOpenView(viewName)
	if viewName == ViewName.V3a9RacingTalentView then
		self._animator.enabled = true

		self._animator:Play("talent", 0, 0)
	end
end

function V3a9RacingCarRecordView:_OnCloseView(viewName)
	if viewName == ViewName.V3a9RacingTalentView then
		self._animator.enabled = true

		self._animator:Play("switch", 0, 0)
	end
end

function V3a9RacingCarRecordView:_onEscapeBtnClick()
	return
end

function V3a9RacingCarRecordView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		for i, item in ipairs(self._rewardItems) do
			gohelper.setActive(item.gocanget, false)
			gohelper.setActive(item.goreceive, true)
		end
	end
end

function V3a9RacingCarRecordView:onOpen()
	self:_calculateAndShowRank()

	self._playerFinishTime = V3a9RacingCarModel.instance:getPlayerFinishTime()

	local episodeConfig = V3a9RacingCarModel.instance:getEpisodeConfig()

	self._episodeConfig = episodeConfig
	self._episodeInfo = V3a9RacingCarEpisodeModel.instance:getEpisodeInfo(episodeConfig.episodeId)

	if not self._episodeInfo or self.viewParam.newBest then
		self._isNewBest = true

		gohelper.setActive(self._btnclick, true)
	end

	gohelper.setActive(self._goBottom, not self._isNewBest)
	self:_initSectionInfo()
end

function V3a9RacingCarRecordView:onOpenFinish()
	if not ActivityHelper.isOpen(VersionActivity3_9Enum.ActivityId.Racing) then
		logNormal("V3a9RacingCarRecordView:onOpenFinish() 活动未开启")

		return
	end

	self._oldClaimedStars = self.viewParam.oldClaimedStars
	self._newClaimedStars = self.viewParam.newClaimedStars
	self._curScore = self.viewParam.curScore or 0
	self._totalScore = self.viewParam.totalScore or self._curScore

	self:_initNewRecordView(self._totalScore)

	if self._oldClaimedStars and self._newClaimedStars and #self._oldClaimedStars ~= #self._newClaimedStars then
		local starList = {}

		for i = #self._oldClaimedStars + 1, #self._newClaimedStars do
			local starId = self._newClaimedStars[i]

			if starId then
				table.insert(starList, starId)
			end
		end

		self:_showReward(starList)
	else
		self:_showReward({})
	end
end

function V3a9RacingCarRecordView:_decomposeScore(score)
	local ones = score % 10
	local tens = math.floor(score / 10) % 10
	local hundreds = math.floor(score / 100) % 10

	return ones, tens, hundreds
end

function V3a9RacingCarRecordView:_initSectionInfo()
	local episodeConfig = self._episodeConfig

	self._txtname.text = episodeConfig.name
	self._txtindex.text = string.format("%02d", V3a9RacingCarSectionListModel.instance:getSelectedConfigIndex())
	self._txtdesc.text = episodeConfig.desc
end

function V3a9RacingCarRecordView:_getRewardItem(index)
	local item = self._rewardItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(item.go, true)

		item.itemParent = gohelper.findChild(item.go, "go_icon")
		item.gocanget = gohelper.findChild(item.go, "go_canget")
		item.goreceive = gohelper.findChild(item.go, "go_receive")
		item.starList = {}

		for i = 1, 4 do
			local star = gohelper.findChild(item.go, "go_rare/#go_rare" .. i)

			item.starList[i] = star

			gohelper.setActive(star, false)
		end

		item.iconItem = IconMgr.instance:getCommonItemIcon(item.itemParent)
		self._rewardItems[index] = item
	end

	return item
end

function V3a9RacingCarRecordView:_showReward(starList)
	local rewardList = {}
	local starIndexList = {}

	for i = #starList, 1, -1 do
		local id = starList[i]
		local rewardConfig = lua_racing_reward.configDict[self._episodeConfig.episodeId][id]

		if rewardConfig then
			local list = ItemConfig.instance:getRewardGroupRateInfoList(rewardConfig.bonus)

			tabletool.addValues(rewardList, list)
			table.insert(starIndexList, {
				starIndex = id,
				num = #list
			})
		else
			logError(tostring(self._episodeConfig.episodeId) .. " rewardConfig not found, id = ", id)
		end
	end

	local normalRewardList = ItemConfig.instance:getRewardGroupRateInfoList(self._episodeConfig.clearBonus)

	tabletool.addValues(rewardList, normalRewardList)
	table.insert(starIndexList, {
		starIndex = 0,
		num = #normalRewardList
	})

	self._showRewardList = {}

	for i, v in ipairs(rewardList) do
		local materialData = MaterialDataMO.New()
		local materialType = v.materialType
		local materialId = v.materialId
		local weight = v.weight

		materialData:initValue(materialType, materialId, weight)
		table.insert(self._showRewardList, materialData)
	end

	local num = 0

	for i, v in ipairs(self._showRewardList) do
		local item = self:_getRewardItem(i)

		item.iconItem:onUpdateMO(v)
		item.iconItem:setScale(0.6)
		item.iconItem:setCountFontSize(40)
		gohelper.setActive(item.gocanget, true)
		gohelper.setActive(item.goreceive, false)

		num = num + 1

		local starIndexInfo = starIndexList[1]

		if starIndexInfo and num >= starIndexInfo.num then
			num = 0

			table.remove(starIndexList, 1)
		end

		if starIndexInfo then
			gohelper.setActive(item.starList[starIndexInfo.starIndex + 1], true)
		end
	end

	local time = 0.5

	TaskDispatcher.runDelay(self._delayShopCommonPropView, self, time)
	UIBlockHelper.instance:startBlock("V3a9RacingCarRecordView _delayShopCommonPropView", time)
end

function V3a9RacingCarRecordView:_delayShopCommonPropView()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._showRewardList)
end

function V3a9RacingCarRecordView:_initNewRecordView(curScore)
	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()
	local racerConfig = playerCtrl:getRacerConfig()
	local playerInfo = PlayerModel.instance:getPlayinfo()
	local playerName = playerInfo and playerInfo.name

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageHeroHead)

	if playerInfo then
		self._liveHeadIcon:setLiveHead(playerInfo.portrait)
	end

	local racerIcon = "v3a9_racing_game_character_choose_" .. racerConfig.pic

	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagechess, racerIcon)

	self._txtHeroName.text = playerName
	self._txtnewRecord.text = string.format(luaLang("v3a9Racing_car_congratulations"), racerConfig.team)

	local curOnes, curTens, curHundreds = self:_decomposeScore(curScore)
	local starNum = 0

	if curOnes > 0 then
		starNum = starNum + 1
	end

	if curTens > 0 then
		starNum = starNum + 1
	end

	if curHundreds > 0 then
		starNum = starNum + 1
	end

	for i = 1, V3a9RacingCarEnum.RacingLevelStarMaxCount do
		local star = self["_imageicon" .. i]

		gohelper.setActive(star, i <= starNum)
	end
end

function V3a9RacingCarRecordView:_calculateAndShowRank()
	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()
	local playerDist = playerCtrl:getTotalTrackDistance()
	local aiRacers = V3a9RacingCarModel.instance:getAIRacers()
	local playerFinishTime = V3a9RacingCarModel.instance:getPlayerFinishTime()
	local racers = {}

	table.insert(racers, {
		isPlayer = true,
		distance = playerDist,
		time = playerFinishTime,
		racerConfig = playerCtrl:getRacerConfig()
	})

	for _, ai in ipairs(aiRacers) do
		if ai and ai.getTotalTrackDistance then
			if ai._aiConfig then
				local aiId = "ai_" .. tostring(ai._aiConfig.racerId or 0)
				local aiFinishTime = V3a9RacingCarModel.instance:getRacerFinishTime(aiId)

				table.insert(racers, {
					isPlayer = false,
					distance = ai:getTotalTrackDistance(),
					time = aiFinishTime,
					racerConfig = ai:getRacerConfig()
				})
			end
		end
	end

	table.sort(racers, function(a, b)
		if a.time then
			local aFinished = a.time > 0

			if b.time then
				local bFinished = b.time > 0

				if aFinished == bFinished then
					return a.time < b.time
				end

				return aFinished
			end
		end
	end)

	self._playerRank = 1

	for i, racer in ipairs(racers) do
		if racer.isPlayer then
			self._playerRank = i

			break
		end
	end

	if self._txtindex then
		self._txtindex.text = self._playerRank
	end

	if self._txtTime then
		self._txtTime.text = self:_formatTime(playerFinishTime)
	end

	self:_fillRecordList(racers)
end

function V3a9RacingCarRecordView:_fillRecordList(racers)
	local resPath = self.viewContainer:getSetting().otherRes.recorditem

	if not resPath then
		return
	end

	for i, racer in ipairs(racers) do
		local go = self.viewContainer:getResInst(resPath, self._goContent)

		if go then
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a9RacingCarRecordItem)

			if item then
				item:setRankData(i, racer)
			end
		end
	end
end

function V3a9RacingCarRecordView:_formatTime(seconds)
	local mins = math.floor(seconds / 60)
	local secs = math.floor(seconds % 60)
	local ms = math.floor(seconds % 1 * 100)

	return string.format("%02d:%02d:%02d", mins, secs, ms)
end

function V3a9RacingCarRecordView:onClose()
	gohelper.setActive(self._goNormal, self._isNewBest == nil)
	TaskDispatcher.cancelTask(self._delayShopCommonPropView, self)
end

function V3a9RacingCarRecordView:onDestroyView()
	return
end

return V3a9RacingCarRecordView
