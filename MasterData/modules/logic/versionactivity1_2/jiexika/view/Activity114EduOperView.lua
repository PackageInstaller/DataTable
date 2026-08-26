-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114EduOperView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114EduOperView", package.seeall)

local Activity114EduOperView = class("Activity114EduOperView", BaseView)

function Activity114EduOperView:ctor(path)
	self._path = path
end

function Activity114EduOperView:onInitView()
	self.go = gohelper.findChild(self.viewGO, self._path)
	self._btnclose = gohelper.findChildButtonWithAudio(self.go, "#btn_close")
	self._btneduoper = gohelper.findChildButtonWithAudio(self.go, "title/#btn_eduoper")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114EduOperView:addEvents()
	self._btnclose:AddClickListener(self._hideGo, self)
	self._btneduoper:AddClickListener(self.onLearn, self)
	self.viewContainer:registerCallback(Activity114Event.ShowHideEduOper, self.changeGoShow, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, self.updateLock, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttentionUpdate, self.updateFailRate, self)
end

function Activity114EduOperView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btneduoper:RemoveClickListener()
	self.viewContainer:unregisterCallback(Activity114Event.ShowHideEduOper, self.changeGoShow, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, self.updateLock, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttentionUpdate, self.updateFailRate, self)
end

function Activity114EduOperView:_editableInitView()
	Activity114Model.instance.eduSelectAttr = nil
	self.attrTb = {}

	for i = 1, Activity114Enum.Attr.End - 1 do
		local attrCom = self:getUserDataTb_()

		attrCom.btn = gohelper.findChildButtonWithAudio(self.go, "#btn_attr" .. i)
		attrCom.normal = gohelper.findChild(self.go, "#btn_attr" .. i .. "/normal")
		attrCom.select = gohelper.findChild(self.go, "#btn_attr" .. i .. "/select")
		attrCom.txtFailRate = gohelper.findChildTextMesh(self.go, "#btn_attr" .. i .. "/select/#txt_failRate")

		self.addClickCb(self, attrCom.btn, self.selectLearnAttr, self, i)

		self.attrTb[i] = attrCom
	end

	self:updateFailRate()
	self:_hideGo()
end

function Activity114EduOperView:changeGoShow(isShow)
	if self.go.activeSelf == isShow then
		return
	end

	if isShow then
		gohelper.setActive(self.go, true)

		local lastSelectNum = PlayerPrefsHelper.getNumber(PlayerPrefsKey.JieXiKaLastEduSelect, 0)

		self:selectLearnAttr(lastSelectNum > 0 and lastSelectNum or nil, true)
	end
end

function Activity114EduOperView:updateFailRate()
	for i = 1, Activity114Enum.Attr.End - 1 do
		local eventCo = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, i)
		local rate = Activity114Config.instance:getEduSuccessRate(Activity114Model.instance.id, i, Activity114Model.instance.serverData.attention + ((eventCo and eventCo.successVerify[Activity114Enum.AddAttrType.Attention] or nil) and eventCo.successVerify[Activity114Enum.AddAttrType.Attention]))

		self.attrTb[i].txtFailRate.text = formatLuaLang("versionactivity_1_2_114success_rate", rate)
	end
end

function Activity114EduOperView:selectLearnAttr(attrType, isFirst)
	if Activity114Model.instance.eduSelectAttr ~= attrType then
		if not isFirst then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_subject_choose)
		end

		Activity114Model.instance.eduSelectAttr = attrType

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.JieXiKaLastEduSelect, attrType)
		self.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
	end

	for i = 1, Activity114Enum.Attr.End - 1 do
		gohelper.setActive(self.attrTb[i].select, i == attrType)
		gohelper.setActive(self.attrTb[i].normal, i ~= attrType)
	end
end

function Activity114EduOperView:onLearn()
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	if not Activity114Model.instance.eduSelectAttr then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)

	local eventCo = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, Activity114Model.instance.eduSelectAttr)
	local context = {
		type = Activity114Enum.EventType.Edu,
		eventId = eventCo.config.id
	}

	Activity114Model.instance:beginEvent(context)
	self:_hideGo()
end

function Activity114EduOperView:updateLock()
	if not self.go.activeSelf then
		return
	end

	local week = Activity114Model.instance.serverData.week
	local nowDay = Activity114Model.instance.serverData.day
	local nowRound = Activity114Model.instance.serverData.round
	local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, nowDay, nowRound)

	if not roundCo["banButton" .. week] then
		return
	end

	local banTypes = string.splitToNumber(roundCo["banButton" .. week], "#")

	for _, v in pairs(banTypes) do
		if v == Activity114Enum.EventType.Edu then
			self:_hideGo()

			return
		end
	end
end

function Activity114EduOperView:_hideGo()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	gohelper.setActive(self.go, false)
	self.viewContainer:dispatchEvent(Activity114Event.ShowHideEduOper, false)

	if Activity114Model.instance.eduSelectAttr then
		Activity114Model.instance.eduSelectAttr = nil

		self.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
	end
end

function Activity114EduOperView:onClose()
	Activity114Model.instance.eduSelectAttr = nil

	self.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
end

return Activity114EduOperView
