-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationGiftView.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftView", package.seeall)

local VersionActivity2_3NewCultivationGiftView = class("VersionActivity2_3NewCultivationGiftView", BaseView)

function VersionActivity2_3NewCultivationGiftView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG/#simage_Title")
	self._simageTitle2 = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG/#simage_Title2")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG/#simage_role")
	self._simagedec1 = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG/#simage_dec1")
	self._simagedec2 = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG/#simage_dec2")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/#btn_reward")
	self._btnstone = gohelper.findChildButtonWithAudio(self.viewGO, "Root/stone/txt_dec/#btn_stone")
	self._gokeyword = gohelper.findChild(self.viewGO, "Root/stone/#go_keyword")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Btn/#btn_get")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/Btn/hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationGiftView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnstone:AddClickListener(self._btnstoneOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
end

function VersionActivity2_3NewCultivationGiftView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnstone:RemoveClickListener()
	self._btnget:RemoveClickListener()
end

function VersionActivity2_3NewCultivationGiftView:ctor(...)
	VersionActivity2_3NewCultivationGiftView.super.ctor(self, ...)

	self._itemList = {}
end

function VersionActivity2_3NewCultivationGiftView:_actId()
	return self.viewContainer:actId()
end

function VersionActivity2_3NewCultivationGiftView:_btnrewardOnClick()
	local param = {
		actId = self:_actId(),
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Reward
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, param)
end

function VersionActivity2_3NewCultivationGiftView:_btnstoneOnClick()
	local param = {
		actId = self:_actId(),
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		destinyId = self.viewContainer:getDestinyStoneById()
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, param)
end

function VersionActivity2_3NewCultivationGiftView:_btngetOnClick()
	if not self.viewContainer:isActivityOpen(self:_actId()) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local isClaimed = self.viewContainer:isClaimed()

	if isClaimed then
		return
	end

	self.viewContainer:sendFinishAct125EpisodeRequest()
end

function VersionActivity2_3NewCultivationGiftView:_onDataUpdate()
	self:onUpdateParam()
end

function VersionActivity2_3NewCultivationGiftView:_editableInitView()
	self._txtLimitTime.text = ""

	local parentTran = self._gokeyword.transform
	local childCount = parentTran.childCount

	for i = 1, childCount do
		local t = parentTran:GetChild(i - 1)
		local item = self:_create_VersionActivity2_3NewCultivationKeywordItem(t.gameObject, i)

		table.insert(self._itemList, item)
	end
end

function VersionActivity2_3NewCultivationGiftView:onUpdateParam()
	self:_refresh()
end

function VersionActivity2_3NewCultivationGiftView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:onStart()
end

function VersionActivity2_3NewCultivationGiftView:onStart()
	self.viewContainer:setCurSelectEpisodeIdSlient(self.viewContainer:episodeId())
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, self._onDataUpdate, self)
	self:onUpdateParam()
end

function VersionActivity2_3NewCultivationGiftView:_refresh()
	local isClaimed = self.viewContainer:isClaimed()

	gohelper.setActive(self._btnget, not isClaimed)
	gohelper.setActive(self._gohasget, isClaimed)
	self:_refreshRemainTime()
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)
	TaskDispatcher.runRepeat(self._refreshRemainTime, self, 1)
	self:_refreshList()
end

function VersionActivity2_3NewCultivationGiftView:_refreshList()
	local stoneIds = self.viewContainer:getDestinyStoneById()
	local keywordCount = #stoneIds
	local isEmpty = keywordCount == 0

	gohelper.setActive(self._gokeyword, not isEmpty)

	if isEmpty then
		return
	end

	local goCount = #self._itemList

	for index, stoneId in ipairs(stoneIds) do
		local item = self._itemList[index]

		if not item then
			logError("error 狂想预热数量超过prefab node超过上限: 配置需要" .. tostring(keywordCount) .. "个, 但资源只有" .. tostring(goCount) .. "个")

			break
		end

		local destinyFacetConsumeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(stoneId)

		item:refreshKeyword(destinyFacetConsumeCo.keyword)
	end

	for i = keywordCount + 1, goCount do
		local item = self._itemList[i]

		item:refreshKeyword(nil)
	end
end

function VersionActivity2_3NewCultivationGiftView:_refreshRemainTime()
	local actInfo = self.viewContainer:ActivityInfoMo()
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	self._txtLimitTime.text = endTime <= nowTime and luaLang("ended") or TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function VersionActivity2_3NewCultivationGiftView:_create_VersionActivity2_3NewCultivationKeywordItem(go, index)
	local item = VersionActivity2_3NewCultivationKeywordItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function VersionActivity2_3NewCultivationGiftView:onClose()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, self._onDataUpdate, self)
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)
end

function VersionActivity2_3NewCultivationGiftView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

return VersionActivity2_3NewCultivationGiftView
