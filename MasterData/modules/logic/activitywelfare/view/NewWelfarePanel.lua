-- chunkname: @modules/logic/activitywelfare/view/NewWelfarePanel.lua

module("modules.logic.activitywelfare.view.NewWelfarePanel", package.seeall)

local NewWelfarePanel = class("NewWelfarePanel", BaseView)

function NewWelfarePanel:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/#txt_Descr")
	self._btnClose = gohelper.findChildButton(self.viewGO, "Root/#btn_Close")
	self._rewardItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NewWelfarePanel:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
end

function NewWelfarePanel:removeEvents()
	self._btnClose:RemoveClickListener()
end

function NewWelfarePanel:_btnClaimOnClick(id)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(self.actId, id)
end

function NewWelfarePanel:_jumpToTargetDungeon(episodeId)
	local episodeId = episodeId

	if episodeId ~= 0 then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local jumpParam = {}
		local chapterId = episodeConfig.chapterId
		local chapterConfig = lua_chapter.configDict[chapterId]

		jumpParam.chapterType = chapterConfig.type
		jumpParam.chapterId = chapterId
		jumpParam.episodeId = episodeConfig.id

		ViewMgr.instance:closeView(ViewName.NewWelfarePanel)
		DungeonController.instance:jumpDungeon(jumpParam)
	end
end

function NewWelfarePanel:_editableInitView()
	self.actId = ActivityEnum.Activity.NewWelfare
	self.missionCO = Activity160Config.instance:getActivityMissions(self.actId)

	self:_initRewardItem()
end

function NewWelfarePanel:_initRewardItem()
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

function NewWelfarePanel:onOpen()
	self.addEventCb(self, Activity160Controller.instance, Activity160Event.InfoUpdate, self._onInfoUpdate, self)
	self:refreshView()
end

function NewWelfarePanel:refreshView()
	local actCO = ActivityConfig.instance:getActivityCo(self.actId)

	self._txtDescr.text = actCO.actDesc
	self._txtLimitTime.text = luaLang("activityshow_unlimittime")

	self:refreshUI()
end

function NewWelfarePanel:refreshUI()
	self:refreshItem()
end

function NewWelfarePanel:_onInfoUpdate(actId)
	if actId == self.actId then
		self:refreshUI()
	end
end

function NewWelfarePanel:_jumpFinishCallBack()
	ViewMgr.instance:closeView(ViewName.NewWelfarePanel)
end

function NewWelfarePanel:refreshItem()
	for _, rewardItem in ipairs(self._rewardItemList) do
		local isFinish = Activity160Model.instance:isMissionFinish(self.actId, rewardItem.id)
		local canGet = Activity160Model.instance:isMissionCanGet(self.actId, rewardItem.id)

		gohelper.setActive(rewardItem.gocomplete, isFinish)
		gohelper.setActive(rewardItem.goClaim, canGet)
	end
end

function NewWelfarePanel:onClose()
	for index, item in ipairs(self._rewardItemList) do
		item.btnClaim:RemoveClickListener()
		item.btnGo:RemoveClickListener()
	end
end

return NewWelfarePanel
