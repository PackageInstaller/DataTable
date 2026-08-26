-- chunkname: @modules/logic/teach/view/TeachNoteView.lua

module("modules.logic.teach.view.TeachNoteView", package.seeall)

local TeachNoteView = class("TeachNoteView", BaseView)

function TeachNoteView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagefyleft = gohelper.findChildSingleImage(self.viewGO, "#simage_fy/#simage_fyleft")
	self._simagefyright = gohelper.findChildSingleImage(self.viewGO, "#simage_fy/#simage_fyright")
	self._gotopic = gohelper.findChild(self.viewGO, "#go_topic")
	self._gotopicitem = gohelper.findChild(self.viewGO, "#go_topic/#go_topicitem")
	self._goreward = gohelper.findChild(self.viewGO, "#go_reward")
	self._scrollrewarditem = gohelper.findChildScrollRect(self.viewGO, "#go_reward/#scroll_rewarditem")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_reward/#go_finish")
	self._simagerewardbg1 = gohelper.findChildSingleImage(self.viewGO, "#go_reward/#go_finish/#simage_rewardbg1")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_reward/#go_finish/#btn_getall")
	self._gorewarddetail = gohelper.findChild(self.viewGO, "#go_reward/#go_rewarddetail")
	self._btnrewarddetailclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_reward/#go_rewarddetail/#btn_rewarddetailclose")
	self._gocontentSize = gohelper.findChild(self.viewGO, "#go_reward/#go_rewarddetail/#go_contentSize")
	self._goitems = gohelper.findChild(self.viewGO, "#go_reward/#go_rewarddetail/#go_items")
	self._gorewarddetailItem = gohelper.findChild(self.viewGO, "#go_reward/#go_rewarddetail/#go_items/#go_rewarddetailItem")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_reward/#go_rewarddetail/#go_items/Viewport/Content/#go_rewardContent")
	self._goclickarea = gohelper.findChild(self.viewGO, "#go_reward/#go_rewarddetail/#go_items/Viewport/Content/#go_rewardContent/#go_clickarea")
	self._goitemex = gohelper.findChild(self.viewGO, "#go_reward/#go_rewarddetail/#go_itemex")
	self._goitem = gohelper.findChild(self.viewGO, "#go_reward/#go_rewarddetail/#go_itemex/#go_item")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self._gorewardredpoint = gohelper.findChild(self.viewGO, "#btn_reward/#go_rewardredpoint")
	self._golevel = gohelper.findChild(self.viewGO, "#go_level")
	self._goleft = gohelper.findChild(self.viewGO, "#go_level/#go_left")
	self._simagelefunlock = gohelper.findChildSingleImage(self.viewGO, "#go_level/#go_left/#simage_unlock")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "#go_level/#go_left/#simage_lefticon")
	self._txtleftname = gohelper.findChildText(self.viewGO, "#go_level/#go_left/#txt_leftname")
	self._goleftpass = gohelper.findChild(self.viewGO, "#go_level/#go_left/#txt_leftname/#go_leftpass")
	self._goleftpassdone = gohelper.findChild(self.viewGO, "#go_level/#go_left/#txt_leftname/#go_leftpassdone")
	self._txtleftnameen = gohelper.findChildText(self.viewGO, "#go_level/#go_left/#txt_leftnameen")
	self._imageleftindex = gohelper.findChildImage(self.viewGO, "#go_level/#go_left/#image_leftindex")
	self._goleftnotetip = gohelper.findChild(self.viewGO, "#go_level/#go_left/#go_leftnotetip")
	self._txtleftnotedesc = gohelper.findChildText(self.viewGO, "#go_level/#go_left/#go_leftnotetip/#txt_leftnotedesc")
	self._goleftdescitem = gohelper.findChild(self.viewGO, "#go_level/#go_left/leftitemdescs/#go_leftdescitem")
	self._goleftunlock = gohelper.findChild(self.viewGO, "#go_level/#go_left/#go_leftunlock")
	self._btnleftlearn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn")
	self._goleftlock = gohelper.findChild(self.viewGO, "#go_level/#go_left/#go_leftlock")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#go_left/#btn_leftarrow")
	self._goright = gohelper.findChild(self.viewGO, "#go_level/#go_right")
	self._simagerightunlock = gohelper.findChildSingleImage(self.viewGO, "#go_level/#go_right/#simage_unlock")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "#go_level/#go_right/#simage_righticon")
	self._txtrightname = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#txt_rightname")
	self._gorightpass = gohelper.findChild(self.viewGO, "#go_level/#go_right/#txt_rightname/#go_leftpass")
	self._gorightpassdone = gohelper.findChild(self.viewGO, "#go_level/#go_right/#txt_rightname/#go_leftpassdone")
	self._txtrightnameen = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#txt_rightnameen")
	self._imagerightindex = gohelper.findChildImage(self.viewGO, "#go_level/#go_right/#image_rightindex")
	self._gorightnotetip = gohelper.findChild(self.viewGO, "#go_level/#go_right/#go_rightnotetip")
	self._txtrightnotedesc = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#go_rightnotetip/#txt_rightnotedesc")
	self._gorightdescitem = gohelper.findChild(self.viewGO, "#go_level/#go_right/rightitemdescs/#go_rightdescitem")
	self._gorightunlock = gohelper.findChild(self.viewGO, "#go_level/#go_right/#go_rightunlock")
	self._btnrightlearn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn")
	self._gorightlock = gohelper.findChild(self.viewGO, "#go_level/#go_right/#go_rightlock")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#go_right/#btn_rightarrow")
	self._goend = gohelper.findChild(self.viewGO, "#go_level/#go_end")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._txtleftstartcn = gohelper.findChildText(self.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn/#txt_leftstartcn")
	self._txtleftstarten = gohelper.findChildText(self.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn/#txt_leftstarten")
	self._txtrightstartcn = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn/#txt_rightstartcn")
	self._txtrightstarten = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn/#txt_rightstarten")
	self._simageleftlockmask = gohelper.findChildSingleImage(self.viewGO, "#go_level/#go_left/#go_leftlock/#simage_leftlockmask")
	self._simagerightlockmask = gohelper.findChildSingleImage(self.viewGO, "#go_level/#go_right/#go_rightlock/#simage_rightlockmask")
	self._goreceivetip = gohelper.findChild(self.viewGO, "#go_reward/#go_finish/#go_receivetip")
	self._btnreward1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_reward/#go_finish/#go_reward1/click")
	self._btnreward2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_reward/#go_finish/#go_reward2/click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TeachNoteView:addEvents()
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	self._btnrewarddetailclose:AddClickListener(self._btnrewarddetailcloseOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnleftlearn:AddClickListener(self._btnleftlearnOnClick, self)
	self._btnleftarrow:AddClickListener(self._btnleftarrowOnClick, self)
	self._btnrightlearn:AddClickListener(self._btnrightlearnOnClick, self)
	self._btnrightarrow:AddClickListener(self._btnrightarrowOnClick, self)
	self._btnreward1:AddClickListener(self._btnreward1OnClick, self)
	self._btnreward2:AddClickListener(self._btnreward2OnClick, self)
end

function TeachNoteView:removeEvents()
	self._btngetall:RemoveClickListener()
	self._btnrewarddetailclose:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnleftlearn:RemoveClickListener()
	self._btnleftarrow:RemoveClickListener()
	self._btnrightlearn:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
	self._btnreward1:RemoveClickListener()
	self._btnreward2:RemoveClickListener()
end

function TeachNoteView:_btnleftarrowOnClick()
	self:_changeRight()
end

function TeachNoteView:_btnrightarrowOnClick()
	self:_changeLeft()
end

function TeachNoteView:_btnreward1OnClick()
	MaterialTipController.instance:showMaterialInfo(7, 2)
end

function TeachNoteView:_btnreward2OnClick()
	MaterialTipController.instance:showMaterialInfo(1, 133023)
end

function TeachNoteView:_btngetallOnClick()
	if not TeachNoteModel.instance:isTeachNoteFinalRewardCouldGet() then
		gohelper.setActive(self._gorewarddetail, true)
	else
		DungeonRpc.instance:sendInstructionDungeonFinalRewardRequest()
	end
end

function TeachNoteView:_btnrewarddetailcloseOnClick()
	gohelper.setActive(self._gorewarddetail, false)
end

function TeachNoteView:_btnrightlearnOnClick()
	self:checkOpenView()

	local id = TeachNoteModel.instance:getTeachNoticeTopicId()
	local cos = TeachNoteModel.instance:getTopicLevelCos(id)
	local rightLevelCo = cos[2 * self._tag + 2]

	if self.viewParam.isJump then
		TeachNoteModel.instance:setJumpEpisodeId(rightLevelCo.episodeId)

		local chapterId = DungeonConfig.instance:getEpisodeCO(rightLevelCo.episodeId).chapterId

		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(chapterId, rightLevelCo.episodeId)
	else
		DungeonModel.instance.curLookEpisodeId = rightLevelCo.episodeId

		local isFinished = TeachNoteModel.instance:isTeachNoteLevelPass(rightLevelCo.id)

		TeachNoteModel.instance:setLevelEnterFightState(isFinished)

		local chapterId = DungeonConfig.instance:getEpisodeCO(rightLevelCo.episodeId).chapterId

		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(chapterId, rightLevelCo.episodeId)
	end
end

function TeachNoteView:_btnleftlearnOnClick()
	self:checkOpenView()

	local id = TeachNoteModel.instance:getTeachNoticeTopicId()
	local cos = TeachNoteModel.instance:getTopicLevelCos(id)
	local leftLevelCo = cos[2 * self._tag + 1]

	if self.viewParam.isJump then
		TeachNoteModel.instance:setJumpEpisodeId(leftLevelCo.episodeId)

		local chapterId = DungeonConfig.instance:getEpisodeCO(leftLevelCo.episodeId).chapterId

		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(chapterId, leftLevelCo.episodeId)
	else
		DungeonModel.instance.curLookEpisodeId = leftLevelCo.episodeId

		local isFinished = TeachNoteModel.instance:isTeachNoteLevelPass(leftLevelCo.id)

		TeachNoteModel.instance:setLevelEnterFightState(isFinished)

		local chapterId = DungeonConfig.instance:getEpisodeCO(leftLevelCo.episodeId).chapterId

		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(chapterId, leftLevelCo.episodeId)
	end
end

function TeachNoteView:checkOpenView()
	if ViewMgr.instance:isOpen(ViewName.TeachingEnterView) then
		TeachingModel.instance:setNeedOpenView(ViewName.TeachNoteView)
	end
end

function TeachNoteView:_btnrewardOnClick()
	if self._showReward then
		return
	end

	TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)

	self._showReward = true

	self:_refreshItem()
end

function TeachNoteView:_editableInitView()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._simagebg.gameObject)
	self._gorewardBeSelected = gohelper.findChild(self.viewGO, "#btn_reward/beselected")
	self._gorewardUnselected = gohelper.findChild(self.viewGO, "#btn_reward/unselected")
	self._imageleftlearn = gohelper.findChildImage(self.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn")
	self._imagerightlearn = gohelper.findChildImage(self.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn")
	self._leftlockCanvas = self._goleftlock:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._rightlockCanvas = self._gorightlock:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(self._btnreward.gameObject, AudioEnum.TeachNote.play_ui_activity_switch)
	gohelper.addUIClickAudio(self._btngetall.gameObject, AudioEnum.TeachNote.play_ui_activity_act)
	gohelper.addUIClickAudio(self._btnleftlearn.gameObject, AudioEnum.TeachNote.play_ui_activity_jump)
	gohelper.addUIClickAudio(self._btnrightlearn.gameObject, AudioEnum.TeachNote.play_ui_activity_jump)
	gohelper.removeUIClickAudio(self._btnleftarrow.gameObject)
	gohelper.removeUIClickAudio(self._btnrightarrow.gameObject)
	self._simagebg:LoadImage(ResUrl.getTeachNoteImage("full/bg_jiaoxuebiji_beijingtu.jpg"))
	self._simagerewardbg1:LoadImage(ResUrl.getTeachNoteImage("bg_jianglixuanchuan.png"))
	self._simagelefunlock:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_kongdi.png"))
	self._simagerightunlock:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_kongdi.png"))
	self._simageleftlockmask:LoadImage(ResUrl.getTeachNoteImage("btn_zhezhao_1.png"))
	self._simagerightlockmask:LoadImage(ResUrl.getTeachNoteImage("btn_zhezhao.png"))

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._leftpassAni = self._txtleftname.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._rightpassAni = self._txtrightname.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._leftunlockAni = self._goleft:GetComponent(typeof(UnityEngine.Animation))
	self._rightunlockAni = self._goright:GetComponent(typeof(UnityEngine.Animation))
	self._meshswitch1fyleft = gohelper.findChildComponent(self.viewGO, "#swich1/fayeleft", typeof(UIMesh))
	self._meshswitch1fyright = gohelper.findChildComponent(self.viewGO, "#swich1/fayeright", typeof(UIMesh))
	self._meshswitch2fyleft = gohelper.findChildComponent(self.viewGO, "#swich2/fayeleft", typeof(UIMesh))
	self._meshswitch2fyright = gohelper.findChildComponent(self.viewGO, "#swich2/fayeright", typeof(UIMesh))

	if not self._textureLoader then
		self._textureLoader = MultiAbLoader.New()

		self._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png"))
		self._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png"))
		self._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))
		self._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png"))
		self._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))
		self._textureLoader:startLoad(self._textureBgLoaded, self)
	end

	self._topicItems = {}
	self._rewardIcons = {}
	self._rewardItems = {}
	self._leftDescItems = {}
	self._rightDescItems = {}
	self._showFinished = false
end

function TeachNoteView:_textureBgLoaded()
	local nrasset = self._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))

	self._normalBgRight = nrasset:GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))

	local idlessset = self._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png"))

	self._idlebg = idlessset:GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png"))

	local nlasset = self._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))

	self._normalBgLeft = nlasset:GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))

	local crasset = self._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png"))

	self._challengeBgRight = crasset:GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png"))

	local classet = self._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png"))

	self._challengeBgLeft = classet:GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png"))
end

function TeachNoteView:onUpdateParam()
	return
end

function TeachNoteView:_refreshFinishItem()
	self._simagefyright:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))

	self._meshswitch1fyright.texture = self._normalBgRight
	self._meshswitch2fyright.texture = self._normalBgRight

	self._simagefyleft:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))

	self._meshswitch1fyleft.texture = self._normalBgLeft
	self._meshswitch2fyleft.texture = self._normalBgLeft

	gohelper.setActive(self._gorewarddetail, false)

	local couldGet = TeachNoteModel.instance:isTeachNoteFinalRewardCouldGet()

	gohelper.setActive(self._btngetall.gameObject, couldGet)
	gohelper.setActive(self._goreceivetip, not couldGet)

	local rewardCos = string.split(CommonConfig.instance:getConstStr(ConstEnum.TeachBounds), "|")

	for _, v in pairs(self._rewardIcons) do
		gohelper.setActive(v.go, false)
	end

	for i = 1, #rewardCos do
		local item = self._rewardIcons[i]

		if not item then
			local o = {}

			o.go = gohelper.clone(self._gorewarddetailItem, self._gorewardContent, "item" .. i)

			local icon = gohelper.findChild(o.go, "icon")

			o.icon = IconMgr.instance:getCommonItemIcon(icon)

			table.insert(self._rewardIcons, o)
		end

		gohelper.setActive(self._rewardIcons[i].go, true)

		local splitCo = string.splitToNumber(rewardCos[i], "#")
		local config, icon = ItemModel.instance:getItemConfigAndIcon(splitCo[1], splitCo[2])

		self._rewardIcons[i].icon:setMOValue(splitCo[1], splitCo[2], splitCo[3], nil, true)
		self._rewardIcons[i].icon:setScale(0.6)
		self._rewardIcons[i].icon:isShowQuality(false)
		self._rewardIcons[i].icon:isShowCount(false)

		gohelper.findChildText(self._rewardIcons[i].go, "name").text = config.name
		gohelper.findChildText(self._rewardIcons[i].go, "name/quantity").text = luaLang("multiple") .. splitCo[3]
	end
end

function TeachNoteView:onOpen()
	self.addEventCb(self, TeachNoteController.instance, TeachNoteEvent.ClickTopicItem, self._onTopicItemClicked, self)
	self.addEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, self._refreshItem, self)
	self.addEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTopicReward, self._refreshReward, self)
	self.addEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTeachNoteFinalReward, self.closeThis, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.DelayCloseLoading, self._onLoadingStartClose, self)

	if ViewMgr.instance:isOpen(ViewName.LoadingView) then
		self.viewContainer._viewSetting.anim = nil

		gohelper.setActive(self.viewGO, false)

		return
	end

	self:showViewIn()
end

function TeachNoteView:endBlock()
	UIBlockMgr.instance:endBlock("teachnote")
end

function TeachNoteView:showViewIn()
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._delayTime = 1.2

	UIBlockMgr.instance:endAll()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("teachnote")
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)

	self._topicId, self._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	if self.viewParam.episodeId then
		self._showReward = false

		local newLvs = TeachNoteModel.instance:getNewOpenTopicLevels(self._topicId)

		if #newLvs > 0 then
			local id = newLvs[#newLvs]
			local lvIds = TeachNoteModel.instance:getTopicLevelCos(self._topicId)

			for k, v in ipairs(lvIds) do
				if v.id == id then
					self._topicIndex = math.floor(0.5 * (k - 1))
				end
			end

			TeachNoteModel.instance:setTeachNoticeTopicId(self._topicId, self._topicIndex)
		else
			local lvIds = TeachNoteModel.instance:getTopicLevelCos(self._topicId)

			self._topicIndex = 0

			for k, v in ipairs(lvIds) do
				if v.episodeId == self.viewParam.episodeId then
					self._topicIndex = math.floor(0.5 * (k - 1))
				end
			end

			TeachNoteModel.instance:setTeachNoticeTopicId(self._topicId, self._topicIndex)
		end

		if not TeachNoteModel.instance:isFinishLevelEnterFight() then
			local lvIds = TeachNoteModel.instance:getTopicLevelCos(self._topicId)
			local allFinished = true

			for _, v in ipairs(lvIds) do
				if not DungeonModel.instance:hasPassLevel(v.episodeId) then
					allFinished = false
				end
			end

			if allFinished then
				self._showReward = true

				TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)
			end
		end

		if self._topicId == 0 then
			TeachNoteModel.instance:setTeachNoticeTopicId(1, 0)
		end
	else
		self._showReward = true

		TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)
	end

	self:_refreshItem()
end

function TeachNoteView:onOpenFinish()
	HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.TeachNote)
end

function TeachNoteView:_onLoadingStartClose()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self._playBackTeachNote, self, 0.6)
end

function TeachNoteView:_playBackTeachNote()
	gohelper.setActive(self.viewGO, true)
	self:showViewIn()

	self._viewAnim.enabled = true
	self.viewContainer._viewSetting.anim = ViewAnim.Internal

	self._viewAnim:Play(UIAnimationName.Open, 0, 0)
end

function TeachNoteView:_onDragBegin(param, pointerEventData)
	if self._showReward then
		return
	end

	self._startPos = pointerEventData.position.x
end

function TeachNoteView:_onDragEnd(param, pointerEventData)
	if self._showReward then
		return
	end

	local endPos = pointerEventData.position.x

	if endPos > self._startPos and endPos - self._startPos >= 100 then
		self:_changeRight()
	elseif endPos < self._startPos and self._startPos - endPos >= 100 then
		self:_changeLeft()
	end
end

function TeachNoteView:onClose()
	self._viewAnim.enabled = true

	self._viewAnim:Play(UIAnimationName.Close, 0, 0)
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self.removeEventCb(self, TeachNoteController.instance, TeachNoteEvent.ClickTopicItem, self._onTopicItemClicked, self)
	self.removeEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, self._refreshItem, self)
	self.removeEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTopicReward, self._refreshReward, self)
	self.removeEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTeachNoteFinalReward, self.closeThis, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.DelayCloseLoading, self._onLoadingStartClose, self)
end

function TeachNoteView:_onTopicItemClicked(id)
	self.viewParam.episodeId = nil

	TeachNoteModel.instance:setLevelEnterFightState(false)

	self._showReward = false
	self._delayTime = 0
	self._topicId = id

	local lvCos = TeachNoteModel.instance:getTopicLevelCos(self._topicId)
	local tag = math.floor(0.5 * (#lvCos - 1))

	for i = #lvCos, 1, -1 do
		if not TeachNoteModel.instance:isTeachNoteLevelPass(lvCos[i].id) then
			tag = math.floor(0.5 * (i - 1))
		end
	end

	TeachNoteModel.instance:setTeachNoticeTopicId(self._topicId, tag)
	self:_refreshItem()
end

function TeachNoteView:_refreshItem()
	if self._showReward then
		self:_refreshReward()
	else
		self:_refreshLevel()
	end

	self:_refreshTopic()
end

function TeachNoteView:_refreshTopicFinishState(id)
	local total = TeachNoteModel.instance:getTeachNoteTopicLevelCount(id)
	local finishCount = TeachNoteModel.instance:getTeachNoteTopicFinishedLevelCount(id)

	return total == finishCount
end

function TeachNoteView:_refreshTopic()
	if self._topicItems then
		for _, v in pairs(self._topicItems) do
			v:onDestroyView()
		end
	end

	self._topicItems = {}

	local topicInfo = TeachNoteConfig.instance:getInstructionTopicCos()

	for i = 1, #topicInfo do
		local child = gohelper.cloneInPlace(self._gotopicitem)

		gohelper.setActive(child, true)

		local item = TeachNoteTopicListItem.New()

		item:init(child, topicInfo[i].id, i, self._showReward, self:_refreshTopicFinishState(topicInfo[i].id))
		table.insert(self._topicItems, item)
	end

	gohelper.setActive(self._gorewardredpoint, TeachNoteModel.instance:hasRewardCouldGet())
end

function TeachNoteView:_onPlayLeftFinishedIn()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_finish)
	self._leftpassAni:Play("in", 0, 0)
end

function TeachNoteView:_onPlayRightFinishedIn()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_finish)
	self._rightpassAni:Play("in", 0, 0)
end

function TeachNoteView:_refreshLevel()
	gohelper.setActive(self._golevel, true)
	gohelper.setActive(self._goreward, false)
	gohelper.setActive(self._gorewardBeSelected, false)
	gohelper.setActive(self._gorewardUnselected, true)

	self._topicId, self._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	local cos = TeachNoteModel.instance:getTopicLevelCos(self._topicId)
	local showLeftArrow = #cos > 2 and self._tag >= math.ceil(0.5 * #cos) - 1 or false

	gohelper.setActive(self._btnleftarrow.gameObject, showLeftArrow)

	local showRightArrow = #cos > 2 and self._tag <= 0 or false

	gohelper.setActive(self._btnrightarrow.gameObject, showRightArrow)

	local learnbgs = {
		"bg_jiaoxuebiji_anniudi",
		"bg_jiaoxuebiji_anniudi_1"
	}
	local learnColors = {
		"#F7F7F7",
		"#45413E"
	}
	local rightLevelCo = cos[2 * self._tag + 2]
	local leftLevelCo = cos[2 * self._tag + 1]

	if rightLevelCo then
		gohelper.setActive(self._goright, true)
		gohelper.setActive(self._goend, false)

		local isItemUnlock = TeachNoteModel.instance:isLevelUnlock(rightLevelCo.id)

		if isItemUnlock then
			if not (rightLevelCo.picRes .. ".png") then
				local rightIconName = "bg_jiaoxuebiji_kongdi.png"

				self._simagerighticon:LoadImage(ResUrl.getTeachNoteImage(rightIconName))

				local isRightChallenge = DungeonConfig.instance:getEpisodeCO(rightLevelCo.episodeId).chapterId == 1107
				local bgIcon = isRightChallenge and "bg_jiaoxuebiji_bijiben_3.png" or "bg_jiaoxuebiji_bijiben_2.png"

				self._simagefyright:LoadImage(ResUrl.getTeachNoteImage(bgIcon))

				if isRightChallenge then
					if not self._challengeBgRight then
						local iconTexture = self._idlebg

						self._meshswitch1fyright.texture = iconTexture
						self._meshswitch2fyright.texture = iconTexture

						gohelper.setActive(self._gorightunlock, isItemUnlock)
						gohelper.setActive(self._gorightlock, not isItemUnlock)
						gohelper.setActive(self._gorightnotetip, isItemUnlock)

						local pageIndexIconName = "bg_jiaoxuebiji_shuzi_" .. 2 * self._tag + 2

						UISpriteSetMgr.instance:setTeachNoteSprite(self._imagerightindex, pageIndexIconName)

						local episodeId = TeachNoteConfig.instance:getInstructionLevelCO(rightLevelCo.id).episodeId
						local rightepisodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

						self._txtrightname.text = rightepisodeCo.name
						self._txtrightnameen.text = rightepisodeCo.name_En
						self._txtrightnotedesc.text = rightLevelCo.instructionDesc

						local isRightNewFinished = self:_isLevelNewFinished(rightLevelCo.id)
						local rightpass = TeachNoteModel.instance:isTeachNoteLevelPass(rightLevelCo.id)

						if rightpass then
							self._rightpassAni.enabled = true

							if isRightNewFinished then
								self._rightunlockAni.enabled = false

								TaskDispatcher.cancelTask(self._onPlayRightFinishedIn, self)
								TaskDispatcher.runDelay(self._onPlayRightFinishedIn, self, 0.5)
							else
								self._rightpassAni:Play("done", 0, 0)
							end

							local openIds = {}

							if episodeId > 0 and not TeachNoteModel.instance:isEpisodeOpen(episodeId) then
								table.insert(openIds, episodeId)
							end

							DungeonRpc.instance:sendInstructionDungeonOpenRequest(openIds)

							self._txtrightstartcn.text = luaLang("teachnoteview_restart")
						else
							self._rightpassAni.enabled = false

							gohelper.setActive(self._gorightpass, false)
							gohelper.setActive(self._gorightpassdone, false)

							self._rightlockCanvas.alpha = 1
							self._txtrightstartcn.text = luaLang("teachnoteview_start")
						end

						local isRightNewUnlock = TeachNoteModel.instance:isLevelNewUnlock(rightLevelCo.id)

						if isRightNewUnlock and not isRightNewFinished and not rightpass then
							AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_unlock)

							local openIds = {}

							if episodeId > 0 and not TeachNoteModel.instance:isEpisodeOpen(episodeId) then
								table.insert(openIds, episodeId)
							end

							DungeonRpc.instance:sendInstructionDungeonOpenRequest(openIds)

							self._delayTime = self._delayTime + 1
							self._leftunlockAni.enabled = false
							self._rightunlockAni.enabled = true

							self._rightunlockAni:Play()
						end

						if rightpass then
							if not learnbgs[2] then
								local rightLearnBg = learnbgs[1]

								UISpriteSetMgr.instance:setTeachNoteSprite(self._imagerightlearn, rightLearnBg)
								SLFramework.UGUI.GuiHelper.SetColor(self._txtrightstartcn, (rightpass or nil) and (learnColors[2] or learnColors[1]))
								SLFramework.UGUI.GuiHelper.SetColor(self._txtrightstarten, (rightpass or nil) and (learnColors[2] or learnColors[1]))
								ZProj.UGUIHelper.SetColorAlpha(self._txtrightstarten, 0.5)

								if self._rightDescItems then
									for _, v in pairs(self._rightDescItems) do
										v:onDestroyView()
									end
								end

								self._rightDescItems = {}

								local descCos = string.split(TeachNoteConfig.instance:getInstructionLevelCO(rightLevelCo.id).desc, "#")
								local item

								for i = 1, #descCos do
									local child = gohelper.cloneInPlace(self._gorightdescitem)

									gohelper.setActive(child, true)

									item = TeachNoteDescItem.New()

									item:init(child, i, rightLevelCo.id)
									table.insert(self._rightDescItems, item)
								end
							end
						end
					end
				end
			end
		end
	else
		local isLeftChallenge = DungeonConfig.instance:getEpisodeCO(leftLevelCo.episodeId).chapterId == 1107
		local bgIcon = isLeftChallenge and "bg_jiaoxuebiji_bijiben_3.png" or "bg_jiaoxuebiji_bijiben_2.png"

		self._simagefyright:LoadImage(ResUrl.getTeachNoteImage(bgIcon))

		if isLeftChallenge then
			if not self._challengeBgRight then
				local iconTexture = self._idlebg

				self._meshswitch1fyright.texture = iconTexture
				self._meshswitch2fyright.texture = iconTexture

				gohelper.setActive(self._goright, false)
				gohelper.setActive(self._goend, true)
			end
		end
	end

	if leftLevelCo then
		gohelper.setActive(self._goleft, true)

		local isItemUnlock = TeachNoteModel.instance:isLevelUnlock(leftLevelCo.id)

		if isItemUnlock then
			if not (leftLevelCo.picRes .. ".png") then
				local leftIconName = "bg_jiaoxuebiji_kongdi.png"

				self._simagelefticon:LoadImage(ResUrl.getTeachNoteImage(leftIconName))

				local isLeftChallenge = DungeonConfig.instance:getEpisodeCO(leftLevelCo.episodeId).chapterId == 1107
				local bgIcon = isLeftChallenge and "bg_jiaoxuebiji_bijiben_4.png" or "bg_jiaoxuebiji_bijiben_2_1.png"

				self._simagefyleft:LoadImage(ResUrl.getTeachNoteImage(bgIcon))

				if isLeftChallenge then
					if not self._challengeBgLeft then
						local iconTexture = self._normalBgLeft

						self._meshswitch1fyleft.texture = iconTexture
						self._meshswitch2fyleft.texture = iconTexture

						gohelper.setActive(self._goleftunlock, isItemUnlock)
						gohelper.setActive(self._goleftlock, not isItemUnlock)
						gohelper.setActive(self._goleftnotetip, isItemUnlock)

						local pageIndexIconName = "bg_jiaoxuebiji_shuzi_" .. 2 * self._tag + 1

						UISpriteSetMgr.instance:setTeachNoteSprite(self._imageleftindex, pageIndexIconName)

						local episodeId = TeachNoteConfig.instance:getInstructionLevelCO(leftLevelCo.id).episodeId
						local leftepisodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

						self._txtleftname.text = leftepisodeCo.name
						self._txtleftnameen.text = leftepisodeCo.name_En
						self._txtleftnotedesc.text = leftLevelCo.instructionDesc

						local isLeftNewFinished = self:_isLevelNewFinished(leftLevelCo.id)
						local leftPass = TeachNoteModel.instance:isTeachNoteLevelPass(leftLevelCo.id)

						if leftPass then
							self._leftpassAni.enabled = true

							if isLeftNewFinished then
								TaskDispatcher.cancelTask(self._onPlayLeftFinishedIn, self)
								TaskDispatcher.runDelay(self._onPlayLeftFinishedIn, self, 0.5)
							else
								self._leftpassAni:Play("done", 0, 0)
							end

							local openIds = {}

							if episodeId > 0 and not TeachNoteModel.instance:isEpisodeOpen(episodeId) then
								table.insert(openIds, episodeId)
							end

							DungeonRpc.instance:sendInstructionDungeonOpenRequest(openIds)

							self._txtleftstartcn.text = luaLang("teachnoteview_restart")
						else
							self._leftpassAni.enabled = false

							gohelper.setActive(self._goleftpass, false)
							gohelper.setActive(self._goleftpassdone, false)

							self._leftlockCanvas.alpha = 1
							self._txtleftstartcn.text = luaLang("teachnoteview_start")
						end

						local isLeftNewUnlock = TeachNoteModel.instance:isLevelNewUnlock(leftLevelCo.id)

						if isLeftNewUnlock and not isLeftNewFinished and not self._rightunlockAni.isPlaying and not leftPass then
							AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_unlock)

							local openIds = {}

							if episodeId > 0 and not TeachNoteModel.instance:isEpisodeOpen(episodeId) then
								table.insert(openIds, episodeId)
							end

							self._delayTime = self._delayTime + 1

							DungeonRpc.instance:sendInstructionDungeonOpenRequest(openIds)

							self._leftunlockAni.enabled = true
							self._rightunlockAni.enabled = false

							self._leftunlockAni:Play()
						end

						if leftPass then
							if not learnbgs[2] then
								local leftLearnBg = learnbgs[1]

								UISpriteSetMgr.instance:setTeachNoteSprite(self._imageleftlearn, leftLearnBg)
								SLFramework.UGUI.GuiHelper.SetColor(self._txtleftstartcn, (leftPass or nil) and (learnColors[2] or learnColors[1]))
								SLFramework.UGUI.GuiHelper.SetColor(self._txtleftstarten, (leftPass or nil) and (learnColors[2] or learnColors[1]))
								ZProj.UGUIHelper.SetColorAlpha(self._txtleftstarten, 0.5)

								if self._leftDescItems then
									for _, v in pairs(self._leftDescItems) do
										v:onDestroyView()
									end
								end

								self._leftDescItems = {}

								local item
								local descCos = string.split(TeachNoteConfig.instance:getInstructionLevelCO(leftLevelCo.id).desc, "#")

								for i = 1, #descCos do
									local child = gohelper.cloneInPlace(self._goleftdescitem)

									gohelper.setActive(child, true)

									item = TeachNoteDescItem.New()

									item:init(child, i, leftLevelCo.id)
									table.insert(self._leftDescItems, item)
								end
							end
						end
					end
				end
			end
		end
	else
		self._simagefyleft:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))

		self._meshswitch1fyleft.texture = self._normalBgLeft
		self._meshswitch2fyleft.texture = self._normalBgLeft

		gohelper.setActive(self._goleft, false)
	end

	TaskDispatcher.cancelTask(self.endBlock, self)
	TaskDispatcher.runDelay(self.endBlock, self, self._delayTime)
end

function TeachNoteView:_setLearnBtnColor(graphic, isPass)
	local graphicColor = isPass and "#45413E" or "#F7F7F7"

	SLFramework.UGUI.GuiHelper.SetColor(graphic, graphicColor)
end

function TeachNoteView:_isLevelNewFinished(levelId)
	if TeachNoteModel.instance:isFinishLevelEnterFight() then
		return false
	end

	if not self.viewParam.episodeId then
		return false
	end

	local episodeId = TeachNoteConfig.instance:getInstructionLevelCO(levelId).episodeId

	if self.viewParam.episodeId == episodeId and not TeachNoteModel.instance:isTeachNoteLevelPass(levelId) and not self._showFinished then
		self._showFinished = true

		return true
	end

	return false
end

function TeachNoteView:_refreshReward()
	self:endBlock()
	gohelper.setActive(self._golevel, false)
	gohelper.setActive(self._goreward, true)
	gohelper.setActive(self._gorewardBeSelected, true)
	gohelper.setActive(self._gorewardUnselected, false)

	local topicInfo = TeachNoteConfig.instance:getInstructionTopicCos()

	TeachNoteRewardListModel.instance:setRewardList(topicInfo)
	self:_refreshFinishItem()
end

function TeachNoteView:_changeLeft()
	self._topicId, self._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	local cos = TeachNoteModel.instance:getTopicLevelCos(self._topicId)

	if self._tag >= math.ceil(0.5 * #cos) - 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	self._viewAnim.enabled = true

	self._viewAnim:Play("fanye02", 0, 0)

	self._tag = self._tag + 1

	TeachNoteModel.instance:setTeachNoticeTopicId(self._topicId, self._tag)
	TaskDispatcher.cancelTask(self._refreshLevel, self)
	TaskDispatcher.runDelay(self._refreshLevel, self, 0.3)
end

function TeachNoteView:_changeRight()
	if self._tag < 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	self._viewAnim.enabled = true

	self._viewAnim:Play("fanye01", 0, 0)

	self._tag = self._tag - 1

	TeachNoteModel.instance:setTeachNoticeTopicId(self._topicId, self._tag)
	TaskDispatcher.cancelTask(self._refreshLevel, self)
	TaskDispatcher.runDelay(self._refreshLevel, self, 0.3)
end

function TeachNoteView:onDestroyView()
	TaskDispatcher.cancelTask(self._onPlayLeftFinishedIn, self)
	TaskDispatcher.cancelTask(self._onPlayRightFinishedIn, self)
	TaskDispatcher.cancelTask(self._refreshLevel, self)
	TaskDispatcher.cancelTask(self.endBlock, self)
	TaskDispatcher.cancelTask(self._playBackTeachNote, self)

	if self._textureLoader then
		self._textureLoader:dispose()

		self._textureLoader = nil
	end

	self._simagebg:UnLoadImage()
	self._simagefyright:UnLoadImage()
	self._simagefyleft:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerewardbg1:UnLoadImage()
	self._simagelefunlock:UnLoadImage()
	self._simagerightunlock:UnLoadImage()
	self._simageleftlockmask:UnLoadImage()
	self._simagerightlockmask:UnLoadImage()

	if self._topicItems then
		for _, v in pairs(self._topicItems) do
			v:onDestroyView()
		end

		self._topicItems = nil
	end

	if self._leftDescItems then
		for _, v in pairs(self._leftDescItems) do
			v:onDestroyView()
		end

		self._leftDescItems = nil
	end

	if self._rightDescItems then
		for _, v in pairs(self._rightDescItems) do
			v:onDestroyView()
		end

		self._rightDescItems = nil
	end

	if self._rewardIcons then
		for _, v in pairs(self._rewardIcons) do
			gohelper.destroy(v.go)
			v.icon:onDestroy()
		end

		self._rewardIcons = nil
	end
end

return TeachNoteView
