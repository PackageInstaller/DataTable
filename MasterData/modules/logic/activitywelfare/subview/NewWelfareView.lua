-- chunkname: @modules/logic/activitywelfare/subview/NewWelfareView.lua

module("modules.logic.activitywelfare.subview.NewWelfareView", package.seeall)

local NewWelfareView = class("NewWelfareView", BaseView)

NewWelfareView.FirstProgress = 0.18
NewWelfareView.SecondProgress = 0.58

function NewWelfareView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/#txt_Descr")
	self._imgfill = gohelper.findChildImage(self.viewGO, "Root/Progress/go_fillbg/go_fill")
	self._rewardItemList = {}
	self._progressItemList = {}
	self._isfirstopen = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NewWelfareView:addEvents()
	return
end

function NewWelfareView:removeEvents()
	return
end

function NewWelfareView:_btnClaimOnClick(id)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(self.actId, id)
end

function NewWelfareView:_jumpToTargetDungeon(episodeId)
	local episodeId = episodeId

	if episodeId ~= 0 then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local jumpParam = {}
		local chapterId = episodeConfig.chapterId
		local chapterConfig = lua_chapter.configDict[chapterId]

		jumpParam.chapterType = chapterConfig.type
		jumpParam.chapterId = chapterId
		jumpParam.episodeId = episodeConfig.id

		ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
		DungeonController.instance:jumpDungeon(jumpParam)
	end
end

function NewWelfareView:_editableInitView()
	self.actId = ActivityEnum.Activity.NewWelfare
	self.missionCO = Activity160Config.instance:getActivityMissions(self.actId)

	self:_initRewardItem()
	self:_initProgress()
end

function NewWelfareView:_initRewardItem()
	if not self.missionCO then
		return
	end

	for index, itemco in ipairs(self.missionCO) do
		local item = self:getUserDataTb_()
		local go = gohelper.findChild(self.viewGO, "Root/Card" .. index)

		item.go = go
		item.co = itemco
		item.id = itemco.id
		item.gocomplete = gohelper.findChild(go, "#go_Complete")
		item.gonormal = gohelper.findChild(go, "#go_Normal")
		item.txttitle = gohelper.findChildText(go, "#txt_Title")
		item.txtnum = gohelper.findChildText(go, "#txt_Num")
		item.goClaim = gohelper.findChild(item.gonormal, "#btn_Claim")
		item.btnClaim = gohelper.findChildButton(item.gonormal, "#btn_Claim")

		item.btnClaim:AddClickListener(self._btnClaimOnClick, self, itemco.id)

		item.gogo = gohelper.findChild(item.gonormal, "#btn_Go")
		item.btnGo = gohelper.findChildButton(item.gonormal, "#btn_Go")

		item.btnGo:AddClickListener(self._jumpToTargetDungeon, self, itemco.episodeId)
		table.insert(self._rewardItemList, item)
	end
end

function NewWelfareView:_initProgress()
	if not self.missionCO then
		return
	end

	local count = #self.missionCO

	for i = 1, count do
		local item = self:getUserDataTb_()
		local go = gohelper.findChild(self.viewGO, "Root/Progress/go_point" .. i)

		item.id = self.missionCO[i].id
		item.go = go
		item.godark = gohelper.findChild(go, "dark")
		item.golight = gohelper.findChild(go, "light")

		table.insert(self._progressItemList, item)
	end
end

function NewWelfareView:onUpdateParam()
	return
end

function NewWelfareView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self.addEventCb(self, Activity160Controller.instance, Activity160Event.InfoUpdate, self._onInfoUpdate, self)
	self:refreshView()
end

function NewWelfareView:refreshView()
	local actCO = ActivityConfig.instance:getActivityCo(self.actId)

	self._txtDescr.text = actCO.actDesc
	self._txtLimitTime.text = luaLang("activityshow_unlimittime")

	self:refreshUI()
end

function NewWelfareView:refreshUI()
	self:refreshItem()
	self:refreshProgress()
end

function NewWelfareView:_onInfoUpdate(actId)
	if actId == self.actId then
		self:refreshUI()
	end
end

function NewWelfareView:_jumpFinishCallBack()
	ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
end

function NewWelfareView:refreshItem()
	for _, rewardItem in ipairs(self._rewardItemList) do
		local isFinish = Activity160Model.instance:isMissionFinish(self.actId, rewardItem.id)
		local canGet = Activity160Model.instance:isMissionCanGet(self.actId, rewardItem.id)

		gohelper.setActive(rewardItem.gocomplete, isFinish)
		gohelper.setActive(rewardItem.gonormal, not isFinish)
		gohelper.setActive(rewardItem.goClaim, canGet)
		gohelper.setActive(rewardItem.gogo, not canGet)
	end
end

function NewWelfareView:refreshProgress()
	local finishCount = 0

	self._progress = 0

	for _, item in ipairs(self._progressItemList) do
		local isFinish = Activity160Model.instance:isMissionFinish(self.actId, item.id)
		local canGet = Activity160Model.instance:isMissionCanGet(self.actId, item.id)
		local show = isFinish or canGet

		if show then
			finishCount = finishCount + 1
		end

		gohelper.setActive(item.godark, not show)
		gohelper.setActive(item.golight, show)
	end

	if finishCount == 1 then
		self._progress = NewWelfareView.FirstProgress
	elseif finishCount == 2 then
		self._progress = NewWelfareView.SecondProgress
	elseif finishCount == 3 then
		self._progress = 1
	end

	if not self._isfirstopen then
		self._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, self._progress, 0.5, self._setFaithPercent, self._setFaithValue, self, nil, EaseType.Linear)
		self._isfirstopen = true
	end
end

function NewWelfareView:_setFaithPercent(percent)
	self._imgfill.fillAmount = percent
end

function NewWelfareView:_setFaithValue()
	self:_setFaithPercent(self._progress)

	if self._faithTweenId then
		ZProj.TweenHelper.KillById(self._faithTweenId)

		self._faithTweenId = nil
	end
end

function NewWelfareView:onClose()
	for index, item in ipairs(self._rewardItemList) do
		item.btnClaim:RemoveClickListener()
		item.btnGo:RemoveClickListener()
	end

	GameUtil.onDestroyViewMember_TweenId(self, "_faithTweenId")
end

return NewWelfareView
