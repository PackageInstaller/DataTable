-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapter3View.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapter3View", package.seeall)

local DreamTeamChapter3View = class("DreamTeamChapter3View", ViewComponent)

function DreamTeamChapter3View:ctor()
	DreamTeamChapter3View.super.ctor(self)
end

function DreamTeamChapter3View:unbindEvents()
	DreamTeamChapter3View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnWorld)
	GameUtil.rmClickHandler(self._worldMask)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnRank)
end

function DreamTeamChapter3View:bindEvents()
	DreamTeamChapter3View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnWorld, self._onClickBtnWorld, self)
	GameUtil.addClickHandler(self._worldMask, self._onClickBtnWorld, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function DreamTeamChapter3View:buildUI()
	DreamTeamChapter3View.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnRank = self:getGo("btnRank")
	self._txtClgTimeDesc = self:getTxt("progressCol/btnStart/desc/txt")
	self._txtTopDamage = self:getTxt("topDamage/txtTopDamage")
	self._btnStart = self:getGo("progressCol/btnStart/btn")
	self._scrCell = self:getGo("progressCol/scrCell")
	self._scrView = self:getGo("progressCol/scrView")
	self._rewardViewport = self:getGo("progressCol/scrView/Viewport")
	self._txtNum = self:getTxt("progressCol/total/txtNum")
	self._progressBar = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._scrollList = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnWorld = self:getGo("worldRectTrans/root/btn")
	self._btnWorldRp = self:getGo("worldRectTrans/root/btn/redpoint")
	self._arrowWorld = self:getGo("worldRectTrans/root/btn/arrow")
	self._worldRoot = self:getGo("worldRectTrans/root")
	self._worldMask = self:getGo("worldMask")
	self._worldContent = self:getGo("worldRectTrans/root/content")
	self._worldProgText = self:getGo("worldRectTrans/root/content/progress/prog"):GetComponent(typeof(UnityEngine.UI.Text))
	self._worldProgBar = self:getSlider("worldRectTrans/root/content/tableview/viewport/content/progBar")
	self._worldCell = self:getGo("worldRectTrans/root/content/tableview/cell")
	self._worldTableview = self:getGo("worldRectTrans/root/content/tableview")
	self._worldRectTrans = self:getGo("worldRectTrans"):GetComponent(typeof(UnityEngine.RectTransform))
	self._clipWorldEff = self:getGo("clipWorldEff")
	self._scrollListWorld = ScrollerList.create(self._worldTableview, self._worldCell, GameUtil.handler(self._updateCellWorld, self), GameUtil.handler(self._clearCellWorld, self))
end

function DreamTeamChapter3View:onExit()
	DreamTeamChapter3View.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._btnWorldRp)
	MaterialMgr.resetAll(self._role)

	if self._scrollList then
		self._scrollList:dispose()
	end

	if self._scrollListWorld then
		self._scrollListWorld:dispose()
	end
end

function DreamTeamChapter3View:onEnter()
	DreamTeamChapter3View.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterOneClickGainProgressPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterNotifyBossClgRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WorldProgressPrizeGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_WorldProgressOneClickGainPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 595001
	end

	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._activityId)

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._offestX = 0
	self._offestY = 0
	self._progressIdWorld = 1
	self._progressWorldActCfg = WorldProgressPrizeConfig.instance:getActData(self._activityId) or {}

	if checknumber(self._progressWorldActCfg.redPointId) > 0 then
		self._progressWorldRedPointId = self._progressWorldActCfg.redPointId or 738
	end

	local storyId = self._actCfg.chap3StoryId

	if checknumber(storyId) > 0 then
		local key = string.format("DreamTeamChapter3View%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	self:_onSetUI()
	RedPointController.instance:regRedPoint(self._btnWorldRp, self._progressWorldRedPointId)
	WorldProgressPrizeAgent.instance:sendPM_WorldProgressPrizeGetInfoReq(self._activityId)
	DreamTeamChapterController.instance:sendPM_DreamTeamChapterGetInfoReq(self._activityId)
end

function DreamTeamChapter3View:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.chap3SkinId
	local petName
	local petData = CharacterConfig.instance:getPetCo(skinId)

	if petData then
		self._txtName.text = petData.name
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._isShowWorld = false

	self:_closeWorldSl(self._offestX, self._offestY)
end

function DreamTeamChapter3View:_onUpdate()
	self._info = DreamTeamChapterModel.instance:getInfo(self._activityId) or {}
	self._progressInfoMap = DreamTeamChapterModel.instance:getProgressInfoMap(self._activityId)
	self._maxProgress = self._progressInfoMap[DreamTeamChapterController.progressTypeEnum.BossDamage]
	self._worldProgressPrizeMo = WorldProgressPrizeController.instance:getWorldProgressPrizeMo(self._activityId)

	local winfo = self._worldProgressPrizeMo:getProgressInfo(self._progressIdWorld) or {}

	self._stageProgress = checknumber(winfo.progress)
	self._gainProgressPrizeId = winfo.gainPrizeIds or {}

	local prizeList = WorldProgressPrizeConfig.instance:getPrizeCfg(self._activityId, self._progressIdWorld) or {}

	if self._actCfg then
		if not self._actCfg.dailyBossChallengeTimes then
			local dailyBossChallengeTimes = 0

			if self._info then
				if not self._info.todayBossClgTimes then
					local maxSingleBossDamage = self._info and checknumber(self._info.maxSingleBossDamage) or 0
					local curProgress = checknumber(self._info.totalBossDamage)
					local scoreList = {}
					local progressCfgs = DreamTeamChapterConfig.instance:getProgressPlanCfgs(self._activityId, DreamTeamChapterController.progressTypeEnum.BossDamage)
					local rewardIdx = 0

					for _, cfg in ipairs(progressCfgs) do
						table.insert(scoreList, checknumber(cfg.progress))

						if checknumber(self._info.totalBossDamage) >= checknumber(cfg.progress) then
							rewardIdx = cfg.progressId
						end
					end

					self._txtNum.text = curProgress

					self._scrollList:updateUnderSlider(self._progressBar, curProgress, scoreList)
					self._scrollList:reloadData(progressCfgs)
					self._scrollList:MoveCellToCenter(rewardIdx)

					local idx = -1
					local scoreArr = {}

					for i, v in ipairs(prizeList) do
						table.insert(scoreArr, checknumber(v.needProgress))

						local isCanGet = self._stageProgress >= checknumber(v.needProgress)
						local isGainPrize = table.indexof(self._gainProgressPrizeId, v.prizeId) ~= false

						if isCanGet and not isGainPrize and idx == -1 then
							idx = i - 1
						end
					end

					self._scrollListWorld:reloadData(prizeList)
					self._scrollListWorld:updateUnderSlider(self._worldProgBar, self._stageProgress, scoreArr)
					self._scrollListWorld:MoveCellToCenter(idx == -1 and 0 or idx)

					local progress = self._worldProgressPrizeMo:getProgress(self._progressIdWorld)

					self._worldProgText.text = string.format(lang("累计：<color=#FFE2B0>%s</color>"), MmUtil.formatNumber(progress, MmUtil.Units_CN, 2))
					self._txtTopDamage.text = maxSingleBossDamage
					self._txtClgTimeDesc.text = string.format(lang("今日已挑战次数：<color=#63B9F9>%s</color>/%s"), checknumber(self._info.todayBossClgTimes), dailyBossChallengeTimes)

					self:_checkFirstCatchDamage()
				end
			end
		end
	end
end

function DreamTeamChapter3View:_checkFirstCatchDamage()
	local key = string.format("DreamTeamChapter3View_%s", self._activityId)
	local hasData = GameUtil.getUserData(key)

	if not hasData and self._info and self._actCfg and checknumber(self._info.totalBossDamage) >= checknumber(self._actCfg.worldProgressDamage) then
		GameUtil.saveUserData(key, true)
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._actCfg.chap3EndStoryId, StoryModel.StoryType.SCCopy)
	end
end

function DreamTeamChapter3View:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effectRoot = goutil.findChild(cell, "effectRoot")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local totalBossDamage = self._info and checknumber(self._info.totalBossDamage) or 0

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = MmUtil.formatNumber(data.progress, MmUtil.Units_CN, 0)

	local isCanGet = totalBossDamage >= checknumber(data.progress)
	local isGainPrize = data.progressId <= self._maxProgress

	GameUtil.SetActive(btnGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effectRoot)

	if isCanGet and not isGainPrize then
		self:_playEffect(effectRoot, self._rewardViewport.transform)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function DreamTeamChapter3View:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effectRoot = goutil.findChild(cell, "effectRoot")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effectRoot)
	GameUtil.rmClickHandler(btnGet)
end

function DreamTeamChapter3View:_updateCellWorld(view, cell, data)
	self:_clearCellWorld(cell)

	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local got = goutil.findChild(cell, "got")
	local progress = goutil.findChildTextComponent(cell, "progress")
	local prizes = string.split(data.prize, "#")
	local proxy = MaterialMgr.setCellByCfg(prizes[1], item)
	local isGot = self._worldProgressPrizeMo:isHasGainPrize(self._progressIdWorld, data.prizeId)
	local canGet = self._worldProgressPrizeMo:isCanGetPrize(self._progressIdWorld, data.prizeId)
	local btn = goutil.findChild(cell, "btn")

	if canGet then
		self:_playEffect(effect, self._clipWorldEff.transform)
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnPrize, self, data.prizeId))
	end

	progress.text = MmUtil.formatNumber(data.needProgress, MmUtil.Units_CN, 0)

	goutil.setActive(got, isGot)
	goutil.setActive(btn, canGet)
end

function DreamTeamChapter3View:_clearCellWorld(cell)
	local btn = goutil.findChild(cell, "btn")
	local got = goutil.findChild(cell, "got")
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	goutil.setActive(got, false)
	self:_clearEffect(effect)
	GameUtil.rmClickHandler(btn)
	goutil.setActive(btn, false)
	MaterialMgr.resetAll(item)
end

function DreamTeamChapter3View:_playEffect(effGo, clipRect)
	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	self:playViewEffectUniGo(effPath, effGo, clipRect, true)
end

function DreamTeamChapter3View:_clearEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

function DreamTeamChapter3View:_onClickGetPrize(data)
	local totalBossDamage = self._info and checknumber(self._info.totalBossDamage) or 0
	local isCanGet = totalBossDamage >= checknumber(data.progress)
	local isGainPrize = data.progressId <= self._maxProgress

	if isGainPrize then
		FloatWordMgr.instance:show(lang("已领取过，无法重复领取"))

		return
	end

	if not isCanGet then
		FloatWordMgr.instance:show(lang("暂未达到目标伤害，无法领取"))

		return
	end

	DreamTeamChapterController.instance:sendPM_DreamTeamChapterOneClickGainProgressPrizeReq(self._activityId, DreamTeamChapterController.progressTypeEnum.BossDamage)
end

function DreamTeamChapter3View:_onClickBtnTip()
	if self._actCfg then
		TipsFacade.instance:openRulesView(self._actCfg)
	end
end

function DreamTeamChapter3View:_onBtnSkillClg()
	local skinId = self._actCfg.chap3SkinId

	PetbookController.instance:previewBattle(skinId)
end

function DreamTeamChapter3View:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function DreamTeamChapter3View:_onClickBtnStart()
	if self._actCfg then
		if not self._actCfg.dailyBossChallengeTimes then
			local dailyBossChallengeTimes = 0
			local todayBossClgTimes = self._info and checknumber(self._info.todayBossClgTimes) or 0
			local chapterCfg = DreamTeamChapterConfig.instance:getChapterCfg(self._activityId, 3)
			local openTime = chapterCfg and chapterCfg.openTime

			if openTime then
				local openTimeStamp = GameUtil.string2time(openTime)

				if openTimeStamp > ServerTime.now() then
					local timeStr = GameUtil.formatTimeStamp("%Y-%m-%d %H: %M:%S", openTimeStamp)

					FloatWordMgr.instance:show(lang("%s后可挑战"), timeStr)

					return
				end
			end

			if dailyBossChallengeTimes <= todayBossClgTimes then
				FloatWordMgr.instance:show(lang("已超过今日可挑战次数，请明日再来挑战"))

				return
			end

			DreamTeamChapterController.instance:enterChap3BattleClg(self._activityId)
		end
	end
end

function DreamTeamChapter3View:_onClickBtnWorld()
	if self._isShowWorld then
		self._isShowWorld = false

		self:_closeWorldSl(self._offestX, self._offestY)
	else
		self._isShowWorld = true

		self:_openWorldSl(self._offestX, self._offestY)
	end
end

function DreamTeamChapter3View:_onClickBtnPrize(prizeId)
	WorldProgressPrizeController.instance:sendPM_WorldProgressOneClickGainPrizeReq(self._activityId, self._progressIdWorld)
end

function DreamTeamChapter3View:_openWorldSl(offestX, offestY)
	GameUtil.SetActive(self._worldContent, true)
	GameUtil.SetActive(self._worldMask, true)
	GameUtil.setAnchoredPos(self._worldRoot, -2.46 + offestX, -267.3 + offestY)
	GameUtil.setLocalRotation(self._arrowWorld, 0, 0, 0)
end

function DreamTeamChapter3View:_closeWorldSl(offestX, offestY)
	GameUtil.SetActive(self._worldContent, false)
	GameUtil.SetActive(self._worldMask, false)
	GameUtil.setAnchoredPos(self._worldRoot, 184.2 + offestX, -267.3 + offestY)
	GameUtil.setLocalRotation(self._arrowWorld, 0, 0, 180)
end

function DreamTeamChapter3View:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.DreamTeamChapter3RankView, self._activityId)
end

return DreamTeamChapter3View
