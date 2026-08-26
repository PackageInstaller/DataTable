-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114EventSelectView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114EventSelectView", package.seeall)

local Activity114EventSelectView = class("Activity114EventSelectView", BaseView)

function Activity114EventSelectView:onInitView()
	self._gotips = gohelper.findChild(self.viewGO, "right/#go_tips")
	self._txtbasevalue = gohelper.findChildTextMesh(self.viewGO, "right/#go_tips/base/#txt_basevalue")
	self._txtrealvalue = gohelper.findChildTextMesh(self.viewGO, "right/#go_tips/need/#txt_realvalue")
	self._goattrcontent = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_contentattr")
	self._goattritem = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_contentattr/#go_attritem")
	self._goattrempty = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_attrEmpty")
	self._goattrtotal = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_total")
	self._txtattrtotalnum = gohelper.findChildTextMesh(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_total/#txt_attrtotalnum")
	self._gofeaturecontent = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featurecontent")
	self._gofeatureitem = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featurecontent/#go_featureitem")
	self._gofeatureempty = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featureEmpty")
	self._gofeaturetotal = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_total")
	self._txtfeaturetotalnum = gohelper.findChildTextMesh(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_total/#txt_featuretotalnum")
	self._goanswercontent = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answercontent")
	self._goansweritem = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answercontent/#go_answeritem")
	self._goanswerempty = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answerEmpty")
	self._goanswertotal = gohelper.findChild(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_total")
	self._txtanswertotalnum = gohelper.findChildTextMesh(self.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_total/#txt_answertotalnum")
	self._gooption = gohelper.findChild(self.viewGO, "right/#go_options")
	self._gooptionitem = gohelper.findChild(self.viewGO, "right/#go_options/#go_optionitem")
	self._btnskipDialog = gohelper.findChildButton(self.viewGO, "#btn_skipDialog")
	self._btncloseTip = gohelper.findChildButton(self.viewGO, "#btn_closeTip")
	self._gocontentroot = gohelper.findChild(self.viewGO, "#go_contentroot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114EventSelectView:addEvents()
	self._btnskipDialog:AddClickListener(self.skipDialog, self)
	self._btncloseTip:AddClickListener(self.closeOptionTip, self)
end

function Activity114EventSelectView:removeEvents()
	self._btnskipDialog:RemoveClickListener()
	self._btncloseTip:RemoveClickListener()
end

function Activity114EventSelectView:_editableInitView()
	gohelper.setActive(self._gofeatureitem, false)
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._btncloseTip.gameObject, false)
	gohelper.setActive(self._gooptionitem, false)

	self.attrtotalnum = 0
	self.featuretotalnum = 0
	self.answertotalnum = 0
end

function Activity114EventSelectView:onUpdateParam()
	for _, v in pairs(self.items) do
		v:destory()
	end

	self:_refreshView()
end

function Activity114EventSelectView:onOpen()
	self:_refreshView()
end

function Activity114EventSelectView:_refreshView()
	gohelper.setActive(self._gooption, true)
	self:_initDialog()

	self.items = {}

	local eventCo = self.viewParam.eventCo

	if Activity114Model.instance.serverData.testEventId > 0 then
		for i = 1, 3 do
			self.items[i] = self:_createItem(i)
		end

		self:updateAnswerItems()
	elseif Activity114Model.instance.serverData.checkEventId > 0 or eventCo.config.eventType == Activity114Enum.EventType.KeyDay then
		if eventCo.config.isCheckEvent == 1 or eventCo.config.testId > 0 then
			local guideId = Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.FirstCheckEventGuideId)

			Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(guideId))

			self.items[1] = self:_createItem(1)

			self:updateCheckItems()
		else
			logError("????!")
			self:closeThis()
		end
	else
		logError("????")
		self:closeThis()
	end
end

function Activity114EventSelectView:_initDialog()
	if not self._dialogItem then
		self._dialogItem = Activity114DialogItem.New()

		self._dialogItem:init(self._gocontentroot)
		self._dialogItem:hideDialog()
	end

	gohelper.setActive(self._gocontentroot, false)
end

function Activity114EventSelectView:updateAnswerItems()
	local info = Activity114Model.instance.serverData
	local ids = info.testIds
	local index = info.currentTest
	local co = Activity114Config.instance:getAnswerCo(Activity114Model.instance.id, ids[index])

	if not co then
		logError("答题选项配置不存在" .. tostring(ids[index]))
		self:closeThis()

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)
	gohelper.setActive(self._gocontentroot, true)
	gohelper.setActive(self._gooption, false)
	self._dialogItem:showTxt(co.topic, self.showOptions, self)

	for i = 1, 3 do
		local str = co["choice" .. i]

		self.items[i]:updateData(Activity114Enum.EventContentType.Normal, str, self.onAnswer, self)
	end
end

function Activity114EventSelectView:skipDialog()
	self:onSelectIndex(-1)

	if self._gooption.activeSelf then
		return
	end

	self._dialogItem:skipDialog()
end

function Activity114EventSelectView:closeOptionTip()
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._btncloseTip.gameObject, false)
end

function Activity114EventSelectView:showOptions()
	gohelper.setActive(self._gooption, true)
end

function Activity114EventSelectView:updateCheckItems()
	local eventCo = self.viewParam.eventCo

	if eventCo.config.isCheckEvent ~= 1 then
		self.items[1]:updateData(Activity114Enum.EventContentType.Normal, eventCo.config.checkOptionText, self.checkEvent, self)
	end

	if eventCo.config.disposable == 1 then
		if not Activity114Enum.EventContentType.Check_Once then
			do
				local type = Activity114Enum.EventContentType.Check
				local data = self:getCheckData(eventCo)

				self.items[1]:updateData(type, data, self.checkEvent, self)
			end

			if not string.nilorempty(eventCo.config.nonOptionText) then
				self.items[2] = self:_createItem(2)

				self.items[2]:updateData(Activity114Enum.EventContentType.Normal, eventCo.config.nonOptionText, self.noCheckEvent, self)
			end
		end
	end
end

function Activity114EventSelectView:_createItem(index)
	local go = gohelper.cloneInPlace(self._gooptionitem, "Option")

	gohelper.setActive(go, true)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity114EventSelectItem, {
		parent = self,
		index = index
	})
end

function Activity114EventSelectView:getCheckData(eventCo)
	local data = {}

	data.desc = eventCo.config.checkOptionText

	local featureSubs = {}

	data.featureSubs = featureSubs

	local attrSubs = {}

	data.attrSubs = attrSubs

	local totalSub = 0
	local checkAttributes = string.splitToNumber(eventCo.config.checkAttribute, "#")

	if #checkAttributes > 0 then
		for i = 1, #checkAttributes do
			local checkAttribute = checkAttributes[i]
			local nowAttr = 0

			if checkAttribute >= Activity114Enum.Attr.End then
				local rawAttr = lua_activity114_attribute.configDict[Activity114Model.instance.id][checkAttribute].attribute

				nowAttr = Activity114Model.instance.attrDict[rawAttr]
			else
				nowAttr = Activity114Model.instance.attrDict[checkAttribute]
			end

			local attrSub = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, checkAttribute, nowAttr)
			local name = Activity114Config.instance:getAttrName(Activity114Model.instance.id, checkAttribute)
			local attrId = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, checkAttribute).attribute

			table.insert(attrSubs, {
				name = name,
				value = attrSub,
				attrId = attrId
			})

			totalSub = totalSub + attrSub
		end
	end

	self.attrtotalnum = totalSub

	local checkFeatures = string.splitToNumber(eventCo.config.checkfeatures, "#")

	for _, v in pairs(checkFeatures) do
		if Activity114Model.instance.featuresDict[v] then
			local featureCo = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, v)

			totalSub = totalSub + featureCo.verifyNum

			table.insert(featureSubs, {
				name = featureCo.features,
				value = featureCo.verifyNum,
				inheritable = featureCo.inheritable
			})
		end
	end

	self.featuretotalnum = totalSub - self.attrtotalnum

	if self.viewParam.type == Activity114Enum.EventType.KeyDay and self.viewParam.eventCo.config.testId > 0 then
		local scores = Activity114Model.instance.serverData.testScores

		for i = 1, #scores do
			totalSub = totalSub + scores[i]
		end

		data.testScore = scores
	end

	self.answertotalnum = totalSub - self.featuretotalnum - self.attrtotalnum

	local realVerify = math.max(0, eventCo.config.threshold - totalSub)
	local rate = Activity114Config.instance:getDiceRate(realVerify)
	local rateDes, level = Activity114Config.instance:getRateDes(rate)
	local rateColor = Activity114Enum.RateColor[level]

	data.rateDes = string.format("<%s>%s(%d%%)</color>", rateColor, rateDes, rate)
	data.level = level
	data.realVerify = realVerify
	data.threshold = eventCo.config.threshold

	Activity114Model.instance:setEventParams("realVerify", realVerify)

	return data
end

function Activity114EventSelectView:onSelectIndex(index)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	for i = 1, #self.items do
		if i ~= index then
			self.items[i]:setSelect(false)
		end
	end

	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._btncloseTip.gameObject, false)
end

function Activity114EventSelectView:showTips(data, pos)
	if self._gotips.activeSelf then
		gohelper.setActive(self._gotips, false)
		gohelper.setActive(self._btncloseTip.gameObject, false)
	else
		gohelper.setActive(self._gotips, true)
		gohelper.setActive(self._btncloseTip.gameObject, true)

		self._gotips.transform.position = pos
		self._txtbasevalue.text = data.threshold

		local attrtotalstr = self.attrtotalnum > 0 and self:_getNumShowTxt(self.attrtotalnum) or ""
		local featuretotalstr = self.featuretotalnum > 0 and self:_getNumShowTxt(self.featuretotalnum) or ""
		local answertotalstr = self.answertotalnum > 0 and self:_getNumShowTxt(self.answertotalnum) or ""
		local finaltotalstr = data.threshold ~= data.realVerify and string.format(" = <color=#E19C60>%s</color>", data.realVerify) or ""

		self._txtrealvalue.text = string.format("%s%s%s%s%s", data.threshold, attrtotalstr, featuretotalstr, answertotalstr, finaltotalstr)
		self._txtattrtotalnum.text = self:_getNumShowTxt(self.attrtotalnum)
		self._txtfeaturetotalnum.text = self:_getNumShowTxt(self.featuretotalnum)
		self._txtanswertotalnum.text = self:_getNumShowTxt(self.answertotalnum)

		gohelper.setActive(self._goattrempty, GameUtil.getTabLen(data.attrSubs) == 0)
		gohelper.setActive(self._goattrtotal, GameUtil.getTabLen(data.attrSubs) > 0)
		gohelper.setActive(self._goattrcontent, GameUtil.getTabLen(data.attrSubs) > 0)
		gohelper.setActive(self._gofeatureempty, GameUtil.getTabLen(data.featureSubs) == 0)
		gohelper.setActive(self._gofeaturetotal, GameUtil.getTabLen(data.featureSubs) > 0)
		gohelper.setActive(self._gofeaturecontent, GameUtil.getTabLen(data.featureSubs) > 0)
		gohelper.setActive(self._goanswerempty, GameUtil.getTabLen(data.testScore) == 0)
		gohelper.setActive(self._goanswertotal, GameUtil.getTabLen(data.testScore) > 0)
		gohelper.CreateObjList(self, self.setAttrItem, data.attrSubs, self._goattrcontent, self._goattritem)
		gohelper.CreateObjList(self, self.setFeatureItem, data.featureSubs, self._gofeaturecontent, self._gofeatureitem)
		gohelper.setActive(self._goanswercontent, data.testScore)

		if data.testScore then
			gohelper.CreateObjList(self, self.setAnswerItem, data.testScore, self._goanswercontent, self._goansweritem)
		end
	end
end

function Activity114EventSelectView:setAttrItem(obj, data, index)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(obj, "#image_icon"), "icons_" .. data.attrId)

	gohelper.findChildTextMesh(obj, "#txt_name").text = data.name
	gohelper.findChildTextMesh(obj, "#txt_value").text = self:_getNumShowTxt(data.value)
end

function Activity114EventSelectView:setFeatureItem(obj, data, index)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(obj, "#image_bg"), data.inheritable == 1 and "img_shuxing1" or "img_shuxing2")

	gohelper.findChildTextMesh(obj, "#txt_name").text = data.name
	gohelper.findChildTextMesh(obj, "#txt_value").text = self:_getNumShowTxt(data.value)
end

function Activity114EventSelectView:setAnswerItem(obj, data, index)
	gohelper.findChildTextMesh(obj, "#txt_name").text = string.format(luaLang("v1a2_114eventselectview_question"), GameUtil.getNum2Chinese(index))
	gohelper.findChildTextMesh(obj, "#txt_value").text = self:_getNumShowTxt(data)
end

function Activity114EventSelectView:_getNumShowTxt(value)
	if value == 0 then
		return "-0"
	end

	return string.format("%+d", -value)
end

function Activity114EventSelectView:onAnswer(index)
	Activity114Rpc.instance:answerRequest(Activity114Model.instance.id, index, self.onAnswerReply, self)
end

function Activity114EventSelectView:onAnswerReply(cmd, resultCode, msg)
	if resultCode == 0 and msg.successStatus == Activity114Enum.Result.NoFinish then
		self:onSelectIndex(-1)
		self:updateAnswerItems()
	end
end

function Activity114EventSelectView:checkEvent()
	Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, true)
end

function Activity114EventSelectView:noCheckEvent()
	if self.viewParam.type == Activity114Enum.EventType.KeyDay then
		logError("关键天还能不检定？？？？？")

		return
	end

	Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, false)
end

function Activity114EventSelectView:showHideDiceTips()
	gohelper.setActive(self._gotips, not self._gotips.activeSelf)
	gohelper.setActive(self._btncloseTip.gameObject, not self._gotips.activeSelf)
end

function Activity114EventSelectView:onClose()
	if self.items then
		for _, v in pairs(self.items) do
			v:destory()
		end
	end

	if self._dialogItem then
		self._dialogItem:destroy()

		self._dialogItem = nil
	end
end

return Activity114EventSelectView
