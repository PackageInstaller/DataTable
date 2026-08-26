-- chunkname: @modules/logic/fight/view/FightCelebrityCard3_5View.lua

module("modules.logic.fight.view.FightCelebrityCard3_5View", package.seeall)

local FightCelebrityCard3_5View = class("FightCelebrityCard3_5View", FightBaseView)

function FightCelebrityCard3_5View:onInitView()
	self.btnShowTips = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/btn_click")
	self.go_tipsview = gohelper.findChild(self.viewGO, "go_tipsview")
	self.btnCloseTips = gohelper.findChildClickWithDefaultAudio(self.viewGO, "go_tipsview/#btn_close")
	self.tipsRoot = gohelper.findChild(self.viewGO, "go_tipsview/#go_tips")
	self.tipsTitle = gohelper.findChildText(self.viewGO, "go_tipsview/#go_tips/#txt_title")
	self.tipsDesc = gohelper.findChildText(self.viewGO, "go_tipsview/#go_tips/#txt_desc")
	self.cardObj = gohelper.findChild(self.viewGO, "root/card/go_celebritycarditem/season123celebritycarditem")
	self.levelRoot = {}
	self.sliderDic = {}
	self.sliderAnimatorDic = {}
	self.levelRoot.S = gohelper.findChild(self.viewGO, "root/level/s")
	self.levelRoot.A = gohelper.findChild(self.viewGO, "root/level/a")
	self.sliderDic.A = gohelper.findChildImage(self.viewGO, "root/level/a/image_progress")
	self.sliderAnimatorDic.A = gohelper.findChildComponent(self.viewGO, "root/level/a", typeof(UnityEngine.Animator))
	self.levelRoot.B = gohelper.findChild(self.viewGO, "root/level/b")
	self.sliderDic.B = gohelper.findChildImage(self.viewGO, "root/level/b/image_progress")
	self.sliderAnimatorDic.B = gohelper.findChildComponent(self.viewGO, "root/level/b", typeof(UnityEngine.Animator))
	self.levelRoot.C = gohelper.findChild(self.viewGO, "root/level/c")
	self.sliderDic.C = gohelper.findChildImage(self.viewGO, "root/level/c/image_progress")
	self.sliderAnimatorDic.C = gohelper.findChildComponent(self.viewGO, "root/level/c", typeof(UnityEngine.Animator))
	self.curScoreText = gohelper.findChildText(self.viewGO, "root/score/#txt_current")
	self.maxScoreText = gohelper.findChildText(self.viewGO, "root/score/#txt_total")

	gohelper.setActive(self.go_tipsview, false)

	self.levelAnimator = gohelper.findChildComponent(self.viewGO, "root/level", typeof(UnityEngine.Animator))
	self.cardRoot = gohelper.findChild(self.viewGO, "root/card/go_celebritycarditem")
end

function FightCelebrityCard3_5View:addEvents()
	self.tweenComp = self:addComponent(FightTweenComponent)

	self:com_registClick(self.btnCloseTips, self.onClickCloseTips)
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self._onTouchFightViewScreen)
	self:com_registClick(self.btnShowTips, self.onClickShowTips)
end

function FightCelebrityCard3_5View:onClickCloseTips()
	gohelper.setActive(self.go_tipsview, false)
end

function FightCelebrityCard3_5View:onClickShowTips()
	gohelper.setActive(self.go_tipsview, true)
end

function FightCelebrityCard3_5View:_onTouchFightViewScreen()
	gohelper.setActive(self.go_tipsview, false)
end

function FightCelebrityCard3_5View:onOpen()
	self.progressData = FightDataHelper.fieldMgr.progressDic:getDataByShowId(FightEnum.ProgressId.Progress_9)
	self.id = self.progressData.id

	self:com_registMsg(FightMsgId.NewProgressValueChange, self.onNewProgressValueChange)

	self.myVertin = FightDataHelper.entityMgr:getMyVertin()
	self.cardId = tonumber(self.myVertin.act104EquipUids[1])
	self.cardConfig = lua_activity123_equip.configDict[self.cardId]

	if string.nilorempty(self.cardConfig.scoreStage) then
		self:disposeSelf()

		return
	end

	local str = "C#0|" .. self.cardConfig.scoreStage
	local arr = string.split(str, "|")

	self.levelList = {}

	for _, v in ipairs(arr) do
		local tab = string.split(v, "#")
		local tempTab = {}

		tempTab.levelRoot = self.levelRoot[tab[1]]
		tempTab.score = tonumber(tab[2])
		tempTab.level = tab[1]

		table.insert(self.levelList, tempTab)
	end

	local curScore = self.progressData.value
	local hasShow = false

	for i = #self.levelList, 1, -1 do
		local v = self.levelList[i]

		if hasShow then
			gohelper.setActive(v.levelRoot, false)
		else
			local isShow = curScore >= v.score

			gohelper.setActive(v.levelRoot, isShow)

			if isShow then
				hasShow = true

				if i ~= #self.levelList then
					local slider = self.sliderDic[v.level]
					local nextV = self.levelList[i + 1]
					local nextScore = nextV.score
					local rate = 1 - (nextScore - curScore) / (nextScore - v.score)

					self.tweenComp:DOFillAmount(slider, rate, 1)
				end

				self.curLevel = v.level
				self.curIndex = i
			end
		end
	end

	self.curScoreText.text = curScore

	if not self.levelList[self.curIndex + 1] then
		self.maxScoreText.text = self.levelList[self.curIndex + 1].score

		self.levelAnimator:Play(self.curLevel .. "_idle")

		self.tipsTitle.text = self.cardConfig.scoreTitle

		local desArr = string.split(self.cardConfig.scoreStageTitle, "|")

		for i = 1, #desArr do
			((i > 1 or nil) and gohelper.onceAddComponent(gohelper.clone(self.tipsDesc.gameObject, self.tipsRoot), gohelper.Type_TextMesh)).text = desArr[i]
		end

		self.cardItem = Season123_3_5CelebrityCardItem.New()

		self.cardItem:init(self.cardRoot, self.cardId, {
			noClick = true
		})
	end
end

function FightCelebrityCard3_5View:onNewProgressValueChange(id)
	if id == self.id then
		local flow = self:com_registFlowSequence()
		local curScore = self.progressData.value
		local curData = self.levelList[self.curIndex]
		local nextData = self.levelList[self.curIndex + 1]
		local isNewStage = false

		if nextData then
			local nextScore = nextData.score

			if nextScore <= curScore then
				isNewStage = true

				local parallel = flow:registWork(FightWorkFlowParallel)

				parallel:registWork(FightTweenWork, {
					type = "DOFillAmount",
					to = 1,
					t = 0.5,
					img = self.sliderDic[self.curLevel]
				})
				parallel:registWork(FightWorkFunction, self.playAnimator, self, self.sliderAnimatorDic[self.curLevel], "levelup")
				flow:registWork(FightWorkFunction, gohelper.setActive, curData.levelRoot, false)
				flow:registWork(FightWorkFunction, gohelper.setActive, nextData.levelRoot, true)
				flow:registWork(FightWorkFunction, self.playAnimator, self, self.levelAnimator, self.curLevel .. "to" .. nextData.level)

				self.curLevel = nextData.level
				self.curIndex = self.curIndex + 1
				curData = nextData
				nextData = self.levelList[self.curIndex + 1]

				if self.levelList[self.curIndex + 1] then
					nextScore = nextData.score

					local rate = 1 - (nextData.score - curScore) / (nextData.score - curData.score)

					flow:registWork(FightWorkFunction, self.setSliderFillAmount, self, self.sliderDic[self.curLevel], 0)
					flow:registWork(FightTweenWork, {
						type = "DOFillAmount",
						t = 0.5,
						img = self.sliderDic[self.curLevel],
						to = rate
					})
				end
			else
				local parallel = flow:registWork(FightWorkFlowParallel)
				local rate = 1 - (nextScore - curScore) / (nextScore - curData.score)

				parallel:registWork(FightTweenWork, {
					type = "DOFillAmount",
					t = 1,
					img = self.sliderDic[self.curLevel],
					to = rate
				})
				parallel:registWork(FightWorkFunction, self.playAnimator, self, self.sliderAnimatorDic[self.curLevel], "levelup")
			end
		end

		flow:start()

		self.curScoreText.text = curScore
		nextData = nextData or curData
		self.maxScoreText.text = nextData.score

		AudioMgr.instance:trigger(AudioEnum.Season123.play_fight_ui_uttu_digital)

		if isNewStage then
			AudioMgr.instance:trigger(AudioEnum.Season123.play_fight_ui_uttu_card_lift)
		end
	end
end

function FightCelebrityCard3_5View:playAnimator(animator, name)
	animator:Play(name)
end

function FightCelebrityCard3_5View:setSliderFillAmount(slider, fillAmount)
	slider.fillAmount = fillAmount
end

function FightCelebrityCard3_5View:onDestroyView()
	return
end

return FightCelebrityCard3_5View
