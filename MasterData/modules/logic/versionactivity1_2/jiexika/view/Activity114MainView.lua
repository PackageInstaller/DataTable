-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114MainView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114MainView", package.seeall)

local Activity114MainView = class("Activity114MainView", BaseView)

function Activity114MainView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")
	self._sliderAttentionNow = gohelper.findChildImage(self.viewGO, "#go_time/attentionBar/#image_attention")
	self._sliderAttention = gohelper.findChildImage(self.viewGO, "#go_time/attentionBar/#image_attention2")
	self._btnattrtips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_attr/#go_attrdetail/attrtitle/#btn_attrtips")
	self._goattrtips = gohelper.findChild(self.viewGO, "#go_attrtips")
	self._btncloseattrtips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_attrtips/#btn_closeTips")
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114MainView:addEvents()
	self._btnattrtips:AddClickListener(self._openTips, self)
	self._btncloseattrtips:AddClickListener(self._closeTips, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttentionUpdate, self.updateAttention, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, self.onEventEnd, self)
	self.viewContainer:registerCallback(Activity114Event.EduSelectAttrChange, self.updateAttention, self)
end

function Activity114MainView:removeEvents()
	self._btnattrtips:RemoveClickListener()
	self._btncloseattrtips:RemoveClickListener()
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttentionUpdate, self.updateAttention, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessEnd, self.onEventEnd, self)
	self.viewContainer:unregisterCallback(Activity114Event.EduSelectAttrChange, self.updateAttention, self)
end

function Activity114MainView:_openTips()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
	gohelper.setActive(self._goattrtips, true)
end

function Activity114MainView:_closeTips()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_close)
	gohelper.setActive(self._goattrtips, false)
end

function Activity114MainView:_editableInitView()
	return
end

function Activity114MainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	self._viewAnim:Play("open", 0, 0)
	self:addChildView(Activity114TimeView.New())
	self:addChildView(Activity114AttrView.New("#go_attr"))
	self:addChildView(Activity114OperView.New("#go_oper"))
	self:addChildView(Activity114EduOperView.New("#go_eduSelect"))
	gohelper.setActive(self._goattrtips, false)
	self._simagerightbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_youce.png"))

	if not Activity114Model.instance.serverData.isEnterSchool then
		Activity114Model.instance.serverData.isEnterSchool = true

		Activity114Rpc.instance:enterSchool(Activity114Model.instance.id)
	end

	self:updateAttention()
	self:onEventEnd(true)
end

function Activity114MainView:onOpenFinish()
	self._viewAnim.enabled = true
end

function Activity114MainView:onEventEnd(isFirst)
	local preEventType = Activity114Model.instance.preEventType
	local preResult = Activity114Model.instance.preResult

	Activity114Model.instance.preEventType = nil
	Activity114Model.instance.preResult = nil

	if not Activity114Model.instance.serverData.isEnterSchool then
		self.viewContainer:switchTab(Activity114Enum.TabIndex.EnterView)

		local guideId = Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.WeekEndGuideId)

		Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(guideId))

		return
	end

	if Activity114Model.instance.serverData.checkEventId > 0 then
		local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.checkEventId)
		local context = {
			type = eventCo.config.eventType,
			eventId = eventCo.config.id
		}

		Activity114Model.instance:buildFlowAndSkipWork(context)

		return
	end

	if Activity114Model.instance.serverData.testEventId > 0 then
		local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.testEventId)
		local context = {
			type = eventCo.config.eventType,
			eventId = eventCo.config.id
		}

		Activity114Model.instance:buildFlowAndSkipWork(context)

		return
	end

	local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round)

	if not roundCo then
		logError(string.format("没有回合天数配置？？？day:%d round:%d", Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round))

		return
	end

	if not Activity114Model.instance.serverData.isReadRoundStory then
		local week = Activity114Model.instance.serverData.week

		if week == 1 and not string.nilorempty(roundCo.preStoryId) then
			Activity114Model.instance:beginStoryFlow()

			return
		end
	end

	if roundCo.type == Activity114Enum.RoundType.KeyDay then
		if string.nilorempty(roundCo.eventId) then
			logError("关键天事件没配？？" .. Activity114Model.instance.serverData.day .. "#" .. Activity114Model.instance.serverData.round)

			return
		end

		local eventIds = string.splitToNumber(roundCo.eventId, "#")

		if not eventIds[Activity114Model.instance.serverData.week] then
			local eventId = eventIds[1]
			local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, eventId)
			local context = {
				type = eventCo.config.eventType,
				eventId = eventCo.config.id
			}

			Activity114Model.instance:beginEvent(context)

			return
		end
	end

	if not isFirst then
		self:_playOpenAnim()
	end

	Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventEndWithResult, preEventType, preResult)
end

function Activity114MainView:updateAttention()
	local fillAmount1, fillAmount2

	fillAmount1 = Activity114Model.instance.serverData.attention / 100
	fillAmount2 = Activity114Model.instance.serverData.attention / 100

	if Activity114Model.instance.eduSelectAttr then
		local eduEventCo = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, Activity114Model.instance.eduSelectAttr)

		if eduEventCo then
			if not eduEventCo.successVerify[Activity114Enum.AddAttrType.Attention] then
				local subAttention = 0

				fillAmount2 = (Activity114Model.instance.serverData.attention + subAttention) / 100
			end
		end
	end

	if fillAmount2 < fillAmount1 then
		fillAmount1 = fillAmount2
		fillAmount2 = fillAmount1
	end

	self._sliderAttentionNow.fillAmount = fillAmount2
	self._sliderAttention.fillAmount = fillAmount1
end

function Activity114MainView:_playOpenAnim()
	Activity114Model.instance.isPlayingOpenAnim = true

	self.viewContainer:dispatchEvent(Activity114Event.MainViewAnimBegin)
	self._viewAnim:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(function()
		Activity114Model.instance.isPlayingOpenAnim = false

		self.viewContainer:dispatchEvent(Activity114Event.MainViewAnimEnd)
	end, nil, 0.833)
end

function Activity114MainView:onClose()
	Activity114Model.instance.isPlayingOpenAnim = false

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
	self._viewAnim:Play(UIAnimationName.Close, 0, 0)
end

function Activity114MainView:onDestroyView()
	self._simagerightbg:UnLoadImage()
end

return Activity114MainView
