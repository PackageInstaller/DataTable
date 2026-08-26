-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartView", package.seeall)

local WeekWalk_2HeartView = class("WeekWalk_2HeartView", BaseView)

function WeekWalk_2HeartView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._scrollnull = gohelper.findChildScrollRect(self.viewGO, "#go_finish/weekwalkending/#scroll_null")
	self._gostartemplate = gohelper.findChild(self.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")
	self._simagefinishbg = gohelper.findChildSingleImage(self.viewGO, "#go_finish/#simage_finishbg")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "GameObject/#btn_reward")
	self._gorewardredpoint = gohelper.findChild(self.viewGO, "GameObject/#btn_reward/#go_rewardredpoint")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "GameObject/#btn_detail")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "GameObject/#btn_reset")
	self._simagebgimgnext = gohelper.findChildSingleImage(self.viewGO, "transition/ani/#simage_bgimg_next")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_info/title/#txt_index")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_info/title/#txt_nameen")
	self._simagestage = gohelper.findChildSingleImage(self.viewGO, "#go_info/title/#simage_stage")
	self._txtbattlename = gohelper.findChildText(self.viewGO, "#go_info/title/#txt_battlename")
	self._btndetail2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/title/#txt_battlename/#btn_detail2")
	self._txtnameen2 = gohelper.findChildText(self.viewGO, "#go_info/title/#txt_nameen2")
	self._gochapter1 = gohelper.findChild(self.viewGO, "#go_info/#go_chapter1")
	self._imageIcon11 = gohelper.findChildImage(self.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon11")
	self._imageIcon12 = gohelper.findChildImage(self.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon12")
	self._imageIcon13 = gohelper.findChildImage(self.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon13")
	self._txtchapternum1 = gohelper.findChildText(self.viewGO, "#go_info/#go_chapter1/#txt_chapternum1")
	self._btnchapter1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#go_chapter1/#btn_chapter1")
	self._gochapter2 = gohelper.findChild(self.viewGO, "#go_info/#go_chapter2")
	self._imageIcon21 = gohelper.findChildImage(self.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon21")
	self._imageIcon22 = gohelper.findChildImage(self.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon22")
	self._imageIcon23 = gohelper.findChildImage(self.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon23")
	self._txtchapternum2 = gohelper.findChildText(self.viewGO, "#go_info/#go_chapter2/#txt_chapternum2")
	self._btnchapter2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#go_chapter2/#btn_chapter2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2HeartView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btndetail2:AddClickListener(self._btndetail2OnClick, self)
	self._btnchapter1:AddClickListener(self._btnchapter1OnClick, self)
	self._btnchapter2:AddClickListener(self._btnchapter2OnClick, self)
end

function WeekWalk_2HeartView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btndetail2:RemoveClickListener()
	self._btnchapter1:RemoveClickListener()
	self._btnchapter2:RemoveClickListener()
end

function WeekWalk_2HeartView:_btnchapter1OnClick()
	if self._battle1Finished then
		return
	end

	self:enterWeekwalk_2Fight(WeekWalk_2Enum.BattleIndex.First)
end

function WeekWalk_2HeartView:_btnchapter2OnClick()
	if not self._battle1Finished or self._battle2Finished then
		return
	end

	self:enterWeekwalk_2Fight(WeekWalk_2Enum.BattleIndex.Second)
end

function WeekWalk_2HeartView:enterWeekwalk_2Fight(index)
	local battleInfo = self._layerInfo:getBattleInfo(index)
	local battleId = battleInfo.battleId
	local elementId = battleInfo.elementId

	WeekWalk_2Controller.instance:enterWeekwalk_2Fight(elementId, battleId)
end

function WeekWalk_2HeartView:_btndetail2OnClick()
	return
end

function WeekWalk_2HeartView:_btnrewardOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = self._layerInfo.id
	})
end

function WeekWalk_2HeartView:_btndetailOnClick()
	EnemyInfoController.instance:openWeekWalk_2EnemyInfoView(self._layerInfo.id)
end

function WeekWalk_2HeartView:_btnresetOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2ResetView()
end

function WeekWalk_2HeartView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkResetLayer, self._onWeekwalkResetLayer, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
end

function WeekWalk_2HeartView:_updateChess(battle1Finished, battle2Finished)
	self._chess1 = self._chess1 or gohelper.findChildImage(self._gochapter1, "chess")
	self._chess2 = self._chess2 or gohelper.findChildImage(self._gochapter2, "chess")

	local ruleConfig = lua_weekwalk_ver2.configDict[self._mapId]
	local firstResId = ruleConfig.resIdFront
	local secondResId = ruleConfig.resIdRear
	local firstResConfig = lua_weekwalk_ver2_element_res.configDict[firstResId]
	local secondResConfig = lua_weekwalk_ver2_element_res.configDict[secondResId]

	if firstResConfig then
		UISpriteSetMgr.instance:setWeekWalkSprite(self._chess1, firstResConfig.res .. (not battle1Finished and "_1" or "_0"))
	end

	if secondResConfig then
		UISpriteSetMgr.instance:setWeekWalkSprite(self._chess2, secondResConfig.res .. (not battle2Finished and "_1" or "_0"))
	end
end

function WeekWalk_2HeartView:_onWeekwalkTaskUpdate()
	self:_updateReward()
end

function WeekWalk_2HeartView:_onWeekwalkResetLayer()
	self._mapInfo = WeekWalk_2Model.instance:getLayerInfo(self._mapId)
	self._viewAnim.enabled = true

	self._viewAnim:Play("transition", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_mist)
	self:_updateBattleStatus()
end

function WeekWalk_2HeartView:onOpen()
	self._mapId = self.viewParam.mapId
	self._layerInfo = WeekWalk_2Model.instance:getLayerInfo(self._mapId)
	self._layerSceneConfig = self._layerInfo.sceneConfig
	self._index = self._layerInfo:getLayer()
	self._txtindex.text = tostring(self._index)
	self._txtbattlename.text = self._layerSceneConfig.battleName
	self._txtnameen.text = self._layerSceneConfig.name_en

	local iconPath = string.format("weekwalkheart_stage%s", self._layerInfo.config.layer)

	self._simagestage:LoadImage(ResUrl.getWeekWalkLayerIcon(iconPath))
	self:_updateBattleStatus()
	self:_updateReward()
end

function WeekWalk_2HeartView:_updateReward()
	local mapId = self._mapId
	local taskType = WeekWalk_2Enum.TaskType.Season
	local canGetNum, unFinishNum = WeekWalk_2TaskListModel.instance:canGetRewardNum(taskType, mapId)
	local canGetReward = canGetNum > 0

	gohelper.setActive(self._gorewardredpoint, canGetReward)
end

function WeekWalk_2HeartView:_updateBattleStatus()
	local battleInfo1 = self._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First)
	local battleInfo2 = self._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)

	self._battle1Finished = battleInfo1.status == WeekWalk_2Enum.BattleStatus.Finished
	self._battle2Finished = battleInfo2.status == WeekWalk_2Enum.BattleStatus.Finished

	local battle1FinishedGo = gohelper.findChild(self._gochapter1, "finished")
	local battle2FinishedGo = gohelper.findChild(self._gochapter2, "finished")

	gohelper.setActive(battle1FinishedGo, not self._battle1Finished)
	gohelper.setActive(battle2FinishedGo, not self._battle2Finished)
	gohelper.setActive(self._gochapter2, self._battle1Finished)
	self:_updateStarList(WeekWalk_2Enum.BattleIndex.First)

	if self._battle1Finished then
		self:_updateStarList(WeekWalk_2Enum.BattleIndex.Second)
	end

	self:_updateChess(self._battle1Finished, self._battle2Finished)
end

function WeekWalk_2HeartView:_updateStarList(index)
	self._iconEffectStatus = self._iconEffectStatus or self:getUserDataTb_()

	local battleInfo = self._layerInfo:getBattleInfo(index)

	for i = 1, WeekWalk_2Enum.MaxStar do
		local icon = self["_imageIcon" .. index .. i]

		if not self._iconEffectStatus[icon] then
			icon.enabled = false
			self._iconEffectStatus[icon] = self:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon.gameObject)
		end

		local cupInfo = battleInfo:getCupInfo(i)

		if cupInfo then
			if not cupInfo.result then
				local star = 0

				WeekWalk_2Helper.setCupEffectByResult(self._iconEffectStatus[icon], star)
			end
		end
	end
end

function WeekWalk_2HeartView:onClose()
	return
end

function WeekWalk_2HeartView:onDestroyView()
	return
end

return WeekWalk_2HeartView
