-- chunkname: @modules/logic/season/view1_6/Season1_6SumView.lua

module("modules.logic.season.view1_6.Season1_6SumView", package.seeall)

local Season1_6SumView = class("Season1_6SumView", BaseView)

function Season1_6SumView:onInitView()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_CloseMask")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")
	self.simagePanelBg1 = gohelper.findChildSingleImage(self.viewGO, "Root/BG/#simage_PanelBG1")
	self.simagePanelBg2 = gohelper.findChildSingleImage(self.viewGO, "Root/BG/#simage_PanelBG2")
	self.simagePanelBg3 = gohelper.findChildSingleImage(self.viewGO, "Root/BG/#simage_PanelBG3")
	self.mailRoot = gohelper.findChild(self.viewGO, "Root/1")
	self.mailTipsTxt = gohelper.findChildTextMesh(self.mailRoot, "Right/txt_Tips")
	self.mailDescTxt = gohelper.findChildTextMesh(self.mailRoot, "Right/Scroll View/Viewport/#txt_Descr")
	self.mailChapterTxt = gohelper.findChildTextMesh(self.mailRoot, "Right/Chapter/#txt_ChapterName")
	self.mailChapterEnTxt = gohelper.findChildTextMesh(self.mailRoot, "Right/Chapter/#txt_ChapterNameEn")
	self.mailChapterBg = gohelper.findChildImage(self.mailRoot, "Right/Chapter/image_ChapterPic")
	self.reviewRoot = gohelper.findChild(self.viewGO, "Root/2")
	self.reviewTitleTxt = gohelper.findChildTextMesh(self.reviewRoot, "Right/#txt_TitleName")
	self.reviewChapterGrid = gohelper.findChild(self.reviewRoot, "Right/Chapter/Grid")
	self.goChapterItem = gohelper.findChild(self.reviewChapterGrid, "goChapterItem")
	self.reviewCardGrid = gohelper.findChild(self.reviewRoot, "Right/Card/Grid")
	self.goCardItem = gohelper.findChild(self.reviewCardGrid, "goCardItem")
	self.cardItems = {}
	self.chapterItems = {}
	self.inMail = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6SumView:addEvents()
	self.addClickCb(self, self._btnClose, self._onClickClose, self)
	self.addClickCb(self, self._btnClose2, self._onClickClose, self)
end

function Season1_6SumView:removeEvents()
	self.removeClickCb(self, self._btnClose, self._onClickClose, self)
	self.removeClickCb(self, self._btnClose2, self._onClickClose, self)
end

function Season1_6SumView:_editableInitView()
	self.simagePanelBg1:LoadImage(SeasonViewHelper.getSeasonIcon("sum_bg.png"))
	self.simagePanelBg2:LoadImage(SeasonViewHelper.getSeasonIcon("sum_bg.png"))
	self.simagePanelBg3:LoadImage(SeasonViewHelper.getSeasonIcon("sum_frame.png"))
end

function Season1_6SumView:_onClickClose()
	if self.inMail then
		self:showReviewView(true)

		return
	end

	self:closeThis()
end

function Season1_6SumView:onOpen()
	Activity104Rpc.instance:sendMarkPopSummaryRequest(Activity104Model.instance:getCurSeasonId())
	self:showMailView()
end

function Season1_6SumView:showMailView()
	self.inMail = true

	gohelper.setActive(self.mailRoot, true)
	gohelper.setActive(self.reviewRoot, false)
	gohelper.setActive(self._btnClose2, false)

	local actId = Activity104Model.instance:getCurSeasonId()
	local lastMaxLayer = Activity104Model.instance:getLastMaxLayer(actId)

	if not lastMaxLayer or lastMaxLayer <= 0 then
		self:showReviewView()

		return
	end

	local constCo1 = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.LastSeasonId)
	local lastActId = constCo1 and constCo1.value1
	local actCo = ActivityConfig.instance:getActivityCo(lastActId)

	if actCo then
		if not actCo.name then
			local actName = ""

			self.mailTipsTxt.text = formatLuaLang("season_review_mail_tips", actName)

			local constCo2 = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SumMailLangKey)
			local langKey = constCo2 and constCo2.value2

			self.mailDescTxt.text = langKey and luaLang(langKey) or ""

			local layerCo = SeasonConfig.instance:getSeasonEpisodeCo(lastActId, lastMaxLayer)

			self.mailChapterTxt.text = string.format("%s-%s", formatLuaLang("title_chapter", lastMaxLayer), layerCo.stageName)
			self.mailChapterEnTxt.text = layerCo.stageNameEn

			UISpriteSetMgr.instance:setV1a6SeasonSumSprite(self.mailChapterBg, string.format("v1a6_season_sum_chapterpic%s", layerCo.stage))
		end
	end
end

function Season1_6SumView:showReviewView(isSwitch)
	self.inMail = false

	gohelper.setActive(self.reviewRoot, true)
	gohelper.setActive(self._btnClose2, true)

	if isSwitch then
		self.anim:Play("switch")
		TaskDispatcher.runDelay(self.hideMail, self, 0.84)
	else
		gohelper.setActive(self.mailRoot, false)
	end

	local actId = Activity104Model.instance:getCurSeasonId()
	local constCo1 = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.LastSeasonId)
	local lastActId = constCo1 and constCo1.value1
	local actCo = ActivityConfig.instance:getActivityCo(lastActId)

	if actCo then
		if not actCo.name then
			local actName = ""
			local first = GameUtil.utf8sub(actName, 1, 1)
			local nameLen = GameUtil.utf8len(actName)
			local tag = {
				first,
				(nameLen >= 2 or nil) and GameUtil.utf8sub(actName, 2, nameLen - 1)
			}

			self.reviewTitleTxt.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season_review"), tag)

			local constCo1 = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SumReviewChapter)

			if constCo1 then
				if not constCo1.value2 then
					local chapterConstValue = ""
					local chapterList = GameUtil.splitString2(chapterConstValue, true) or {}

					for i = 1, math.max(#chapterList, #self.chapterItems) do
						self:refreshChapter(i, chapterList[i], #chapterList)
					end

					local constCo2 = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SumReviewCard)

					if constCo2 then
						if not constCo2.value2 then
							local cardConstValue = ""
							local cardList = string.splitToNumber(cardConstValue, "#")

							for i = 1, math.max(#cardList, #self.chapterItems) do
								self:refreshCard(i, cardList[i])
							end
						end
					end
				end
			end
		end
	end
end

function Season1_6SumView:refreshChapter(index, data, dataCount)
	local item = self.chapterItems[index]

	if not item then
		item = self:getUserDataTb_()
		self.chapterItems[index] = item
		item.go = gohelper.cloneInPlace(self.goChapterItem, tostring(index))
		item.txtChapter = gohelper.findChildTextMesh(item.go, "#txt_ChapterNum")
		item.txtPer = gohelper.findChildTextMesh(item.go, "#txt_per")
		item.slider = gohelper.findChildSlider(item.go, "Slider")
		item.line1 = gohelper.findChild(item.go, "image_Line1")
		item.line2 = gohelper.findChild(item.go, "image_Line2")

		function item._setFaithPercent(targetItem, percent)
			targetItem.txtPer.text = string.format("%d%%", percent)

			targetItem.slider:SetValue(percent * 0.01)
		end

		function item._setFaithValue(targetItem)
			targetItem:_setFaithPercent(targetItem.data[2] or 0)

			if targetItem._faithTweenId then
				ZProj.TweenHelper.KillById(targetItem._faithTweenId)

				targetItem._faithTweenId = nil
			end
		end
	end

	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	item.txtChapter.text = formatLuaLang("chapter", data[1])

	if not data[2] then
		local per = 0

		gohelper.setActive(item.line1, index ~= 1)
		gohelper.setActive(item.line2, index ~= 1)

		item._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, per, 1.2, item._setFaithPercent, item._setFaithValue, item, nil, EaseType.Linear)
	end
end

function Season1_6SumView:refreshCard(index, equipId)
	local item = self.cardItems[index]

	if not item then
		item = self:getUserDataTb_()
		self.cardItems[index] = item
		item.go = gohelper.cloneInPlace(self.goCardItem, tostring(index))
		item.goCard = gohelper.findChild(item.go, "#go_seasoncelebritycarditem")
		item.txtIndex = gohelper.findChildTextMesh(item.go, "image_NumBG/txt_Num")
	end

	if not equipId then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	item.txtIndex.text = tostring(index)

	if not item.cardItem then
		item.cardItem = Season1_6CelebrityCardItem.New()

		item.cardItem:init(item.goCard, equipId, {
			noClick = true
		})
	else
		item.cardItem:reset(equipId)
	end
end

function Season1_6SumView:hideMail()
	gohelper.setActive(self.mailRoot, false)
end

function Season1_6SumView:onDestroyView()
	for k, targetItem in pairs(self.chapterItems) do
		if targetItem._faithTweenId then
			ZProj.TweenHelper.KillById(targetItem._faithTweenId)

			targetItem._faithTweenId = nil
		end
	end

	self.simagePanelBg1:UnLoadImage()
	self.simagePanelBg2:UnLoadImage()
	self.simagePanelBg3:UnLoadImage()
	TaskDispatcher.cancelTask(self.hideMail, self)
	Activity104Controller.instance:dispatchEvent(Activity104Event.EnterSeasonMainView)
end

return Season1_6SumView
