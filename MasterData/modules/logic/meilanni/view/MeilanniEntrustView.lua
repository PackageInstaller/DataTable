-- chunkname: @modules/logic/meilanni/view/MeilanniEntrustView.lua

module("modules.logic.meilanni.view.MeilanniEntrustView", package.seeall)

local MeilanniEntrustView = class("MeilanniEntrustView", BaseView)

function MeilanniEntrustView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_bg1")
	self._txtexhibitsname = gohelper.findChildText(self.viewGO, "#go_bg/#txt_exhibitsname")
	self._txtexhibitsdesc = gohelper.findChildText(self.viewGO, "#go_bg/#txt_exhibitsdesc")
	self._txtactioninfo = gohelper.findChildText(self.viewGO, "#go_bg/#txt_actioninfo")
	self._simageexhibitsicon = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_exhibitsicon")
	self._txttrustee = gohelper.findChildText(self.viewGO, "#go_bg/#txt_trustee")
	self._txtdate = gohelper.findChildText(self.viewGO, "#go_bg/#txt_date")
	self._gonodetail = gohelper.findChild(self.viewGO, "#go_nodetail")
	self._btnaccept = gohelper.findChildButtonWithAudio(self.viewGO, "#go_nodetail/#btn_accept")
	self._btnacceptagain = gohelper.findChildButtonWithAudio(self.viewGO, "#go_nodetail/#btn_acceptagain")
	self._gobossdetail = gohelper.findChild(self.viewGO, "#go_bossdetail")
	self._btncloseboss = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bossdetail/#btn_closeboss")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#go_bossdetail/#simage_mask")
	self._txtbossname = gohelper.findChildText(self.viewGO, "#go_bossdetail/#txt_bossname")
	self._simagebossicon = gohelper.findChildSingleImage(self.viewGO, "#go_bossdetail/#simage_bossicon")
	self._scrollproperty = gohelper.findChildScrollRect(self.viewGO, "#go_bossdetail/#scroll_property")
	self._gopropertyitem = gohelper.findChild(self.viewGO, "#go_bossdetail/#scroll_property/Viewport/Content/#go_propertyitem")
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniEntrustView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnaccept:AddClickListener(self._btnacceptOnClick, self)
	self._btnacceptagain:AddClickListener(self._btnacceptagainOnClick, self)
	self._btncloseboss:AddClickListener(self._btnclosebossOnClick, self)
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
end

function MeilanniEntrustView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnaccept:RemoveClickListener()
	self._btnacceptagain:RemoveClickListener()
	self._btncloseboss:RemoveClickListener()
	self._btnclose1:RemoveClickListener()
end

function MeilanniEntrustView:_btnclose1OnClick()
	if self._showExcludeRules then
		return
	end

	self:closeThis()
end

function MeilanniEntrustView:_btnclosebossOnClick()
	if self._showExcludeRules then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
	gohelper.setActive(self._gobossdetail, false)
	gohelper.setActive(self._gonodetail, true)

	if self._showBoss then
		return
	end

	self._settlementAnimator:Play("appear")
	self._acceptAgainAnimator:Play("appear")
	self._acceptAnimator:Play("appear")
end

function MeilanniEntrustView:_btncloseOnClick()
	if self._showExcludeRules then
		return
	end

	self:closeThis()
end

function MeilanniEntrustView:_btnacceptOnClick()
	self:_onAccept()
end

function MeilanniEntrustView:_btnacceptagainOnClick()
	Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, self._mapId)
end

function MeilanniEntrustView:_onAccept()
	Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, self._mapId)
end

function MeilanniEntrustView:_checkEnterMapStory()
	gohelper.setActive(self.viewGO, false)

	local storyList = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.enterMap)

	for i, v in ipairs(storyList) do
		if v[2] == self._mapId then
			local config = v[1]
			local storyId = config.story

			if not StoryModel.instance:isStoryFinished(storyId) then
				local openDayAndFinishMapStoryId = MeilanniMainView.getOpenDayAndFinishMapStory()

				if openDayAndFinishMapStoryId then
					StoryController.instance:playStories({
						openDayAndFinishMapStoryId,
						storyId
					})
				else
					StoryController.instance:playStory(storyId)
				end

				return
			end
		end
	end

	gohelper.setActive(self.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function MeilanniEntrustView:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		gohelper.setActive(self.viewGO, true)
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
	end
end

function MeilanniEntrustView:_editableInitView()
	gohelper.addUIClickAudio(self._btnaccept.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	gohelper.addUIClickAudio(self._btnacceptagain.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	self._simagebg1:LoadImage(ResUrl.getMeilanniIcon("bg_beijing5"))
	self._simagemask:LoadImage(ResUrl.getMeilanniIcon("bg_yinying"))

	self._acceptAgainAnimator = gohelper.findChild(self._btnacceptagain.gameObject, "acceptagain"):GetComponent(typeof(UnityEngine.Animator))
	self._acceptAnimator = gohelper.findChild(self._btnaccept.gameObject, "accept"):GetComponent(typeof(UnityEngine.Animator))
	self._acceptClick = SLFramework.UGUI.UIClickListener.Get(self._btnaccept.gameObject)

	self._acceptClick:AddClickDownListener(self._acceptClickDown, self)
	self._acceptClick:AddClickUpListener(self._acceptClickUp, self)

	self._acceptAgainClick = SLFramework.UGUI.UIClickListener.Get(self._btnacceptagain.gameObject)

	self._acceptAgainClick:AddClickDownListener(self._acceptAgainClickDown, self)
	self._acceptAgainClick:AddClickUpListener(self._acceptAgainClickUp, self)
end

function MeilanniEntrustView:_acceptAgainClickDown()
	self._acceptAgainAnimator:Play("clickdown")
end

function MeilanniEntrustView:_acceptAgainClickUp()
	self._acceptAgainAnimator:Play("clickup")
end

function MeilanniEntrustView:_acceptClickDown()
	self._acceptAnimator:Play("clickdown")
end

function MeilanniEntrustView:_acceptClickUp()
	self._acceptAnimator:Play("clickup")
end

function MeilanniEntrustView:onUpdateParam()
	return
end

function MeilanniEntrustView:onOpen()
	self._mapId = self.viewParam.mapId
	self._showExhibits = self.viewParam.showExhibits

	self:_checkEnterMapStory()

	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)
	self._mapConfig = lua_activity108_map.configDict[self._mapId]
	self._ruleGoList = self:getUserDataTb_()
	self._txtexhibitsdesc.text = self._mapConfig.content
	self._txtexhibitsname.text = self._mapConfig.title
	self._txttrustee.text = self._mapConfig.consignor
	self._txtactioninfo.text = self._mapConfig.actContent

	local showAccept = not self._mapInfo or not self._mapInfo:checkFinish()

	gohelper.setActive(self._btnaccept.gameObject, showAccept)
	gohelper.setActive(self._btnacceptagain.gameObject, not showAccept)

	if self._showExhibits then
		gohelper.setActive(self._btnaccept.gameObject, false)
	end

	local lastConfig = MeilanniConfig.instance:getLastEpisode(self._mapId)

	self._txtdate.text = self._mapId <= 102 and formatLuaLang("meilanni_total_day", lastConfig.day) or formatLuaLang("meilanni_total_day2", lastConfig.day)

	self._simageexhibitsicon:LoadImage(ResUrl.getMeilanniIcon(self._mapConfig.exhibits))
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.resetMap, self._resetMap, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function MeilanniEntrustView:_resetMap()
	self:closeThis()
	MeilanniController.instance:openMeilanniView({
		mapId = self._mapId
	})
end

function MeilanniEntrustView:onClose()
	self._simageexhibitsicon:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function MeilanniEntrustView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._acceptClick:RemoveClickDownListener()
	self._acceptClick:RemoveClickUpListener()
	self._acceptAgainClick:RemoveClickDownListener()
	self._acceptAgainClick:RemoveClickUpListener()
end

return MeilanniEntrustView
