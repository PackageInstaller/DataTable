-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114FinishEventView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114FinishEventView", package.seeall)

local Activity114FinishEventView = class("Activity114FinishEventView", BaseView)
local addColor = "#9EE091"
local subColor = "#e55151"
local maxContainerHeight = 714

function Activity114FinishEventView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageblackbg = gohelper.findChildSingleImage(self.viewGO, "#go_container/blackbgmask/#simage_blackbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content")
	self._goattention = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention")
	self._attentionimg0 = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention")
	self._attentionimg1 = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention1")
	self._attentionimg2 = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention2")
	self._attentionadd = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#txt_attentionadd")
	self._goattr = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attr/#go_attritem")
	self._gofeature = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_feature")
	self._gofeatureitem = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_feature/#go_featureitem")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_unlock")
	self._gounlockitem = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_unlock/#go_unlockitem")
	self._goscore = gohelper.findChild(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score")
	self._txtscoretype = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score/#go_scoreitem/#txt_scoretype")
	self._txtscorenum = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score/#go_scoreitem/#txt_scorenum")

	gohelper.setActive(self._goattritem, false)
	gohelper.setActive(self._gofeatureitem, false)
	gohelper.setActive(self._gounlockitem, false)
end

function Activity114FinishEventView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function Activity114FinishEventView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity114FinishEventView:onOpen()
	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	self._simagebg:LoadImage(ResUrl.getAct114Icon("bg1"))
	self._simageblackbg:LoadImage(ResUrl.getAct114Icon("img_bg1"))

	local resultBonus = self.viewParam.resultBonus
	local addAttr = resultBonus.addAttr
	local featuresList = resultBonus.featuresList

	self:updateAttention(addAttr)
	self:updateAttr(addAttr)
	self:updateFeature(featuresList)
	self:updateUnLock(addAttr)
	self:updateScore(addAttr)
	self:refreshContainerHeight()
end

function Activity114FinishEventView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_CloseHouse)
end

function Activity114FinishEventView:updateAttention(addAttr)
	local addAttention = addAttr[Activity114Enum.AddAttrType.Attention]

	if addAttention then
		gohelper.setActive(self._goattention, true)

		local nowAttention = Activity114Model.instance.serverData.attention
		local add = nowAttention - self.viewParam.preAttention

		self._attentionadd.text = string.format("<%s>%+d</color>", (addAttention >= 0 or nil) and (addColor or subColor), add)

		gohelper.setActive(self._attentionimg1, addAttention >= 0)
		gohelper.setActive(self._attentionimg0, addAttention < 0)

		self._attentionimg0.fillAmount = math.max(nowAttention, self.viewParam.preAttention) / 100
		self._attentionimg1.fillAmount = math.max(nowAttention, self.viewParam.preAttention) / 100
		self._attentionimg2.fillAmount = math.min(nowAttention, self.viewParam.preAttention) / 100
	else
		gohelper.setActive(self._goattention, false)
	end
end

function Activity114FinishEventView:updateAttr(addAttr)
	local haveAttr = false

	for i = 1, Activity114Enum.Attr.End - 1 do
		if addAttr[i] then
			local go = gohelper.cloneInPlace(self._goattritem)

			gohelper.setActive(go, true)

			local attrName = Activity114Config.instance:getAttrName(Activity114Model.instance.id, i)
			local attrId = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, i).attribute
			local add = addAttr[i]

			if self.viewParam.type == Activity114Enum.EventType.Edu and Activity114Model.instance.attrAddPermillage[i] then
				add = Mathf.Round(add * (1 + Activity114Model.instance.attrAddPermillage[i]))
			end

			local nowAttr = self.viewParam.preAttrs[i] + add

			nowAttr = Mathf.Clamp(nowAttr, 0, Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, i))
			add = nowAttr - self.viewParam.preAttrs[i]

			if nowAttr - self.viewParam.preAttrs[i] >= 0 then
				local value = string.format("<%s>%d  (%+d)</color>", addColor or subColor, nowAttr, add)

				gohelper.findChildTextMesh(go, "#txt_attrName").text = attrName
				gohelper.findChildTextMesh(go, "#txt_attrName/#txt_value").text = value

				UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(go, "#image_icon"), "icons_" .. attrId)

				local nowLv = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, i, self.viewParam.preAttrs[i])
				local addLv = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, i, nowAttr)

				gohelper.setActive(gohelper.findChild(go, "#txt_attrlv/#go_uplv"), nowLv < addLv)
				gohelper.setActive(gohelper.findChild(go, "#txt_attrlv/#go_downlv"), addLv < nowLv)

				gohelper.findChildTextMesh(go, "#txt_attrlv").text = string.format("<%s>%s</color>", (addAttr[i] >= 0 or nil) and (addColor or subColor), "Lv." .. addLv)
				haveAttr = true
			end
		end
	end

	if not haveAttr then
		gohelper.setActive(self._goattr, false)
	else
		gohelper.setActive(self._goattr, true)
	end
end

function Activity114FinishEventView:updateFeature(featuresList)
	for i = 1, #featuresList do
		local go = gohelper.cloneInPlace(self._gofeatureitem)

		gohelper.setActive(go, true)

		local featureCo = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, featuresList[i])

		UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(go, "title/#image_titlebg"), featureCo.inheritable == 1 and "img_shuxing1" or "img_shuxing2")

		gohelper.findChildTextMesh(go, "title/#txt_name").text = featureCo.features
		gohelper.findChildTextMesh(go, "#txt_des").text = featureCo.desc
	end

	if not next(featuresList) then
		gohelper.setActive(self._gofeature, false)
	else
		gohelper.setActive(self._gofeature, true)
	end
end

function Activity114FinishEventView:updateUnLock(addAttr)
	local haveUnLock = false

	if addAttr[Activity114Enum.AddAttrType.UnLockMeet] then
		for _, id in ipairs(addAttr[Activity114Enum.AddAttrType.UnLockMeet]) do
			local meetCo = Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id)[id]
			local go = gohelper.cloneInPlace(self._gounlockitem)

			gohelper.setActive(go, true)

			gohelper.findChildTextMesh(go, "#txt_unlocktype").text = luaLang("versionactivity_1_2_114unlockmeet")
			gohelper.findChildTextMesh(go, "#txt_unlockname").text = meetCo.name
			haveUnLock = true
		end
	end

	if addAttr[Activity114Enum.AddAttrType.UnLockTravel] then
		for _, id in ipairs(addAttr[Activity114Enum.AddAttrType.UnLockTravel]) do
			local travelCo = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[id]
			local go = gohelper.cloneInPlace(self._gounlockitem)

			gohelper.setActive(go, true)

			gohelper.findChildTextMesh(go, "#txt_unlocktype").text = luaLang("versionactivity_1_2_114unlocktravel")
			gohelper.findChildTextMesh(go, "#txt_unlockname").text = travelCo.place
			haveUnLock = true
		end
	end

	if not haveUnLock then
		gohelper.setActive(self._gounlock, false)
	else
		gohelper.setActive(self._gounlock, true)
	end
end

function Activity114FinishEventView:updateScore(addAttr)
	local keyDayScore = addAttr[Activity114Enum.AddAttrType.KeyDayScore]
	local lastKeyDayScore = addAttr[Activity114Enum.AddAttrType.LastKeyDayScore]
	local showScore = keyDayScore or lastKeyDayScore

	if keyDayScore then
		self._txtscorenum.text = keyDayScore
		self._txtscoretype.text = luaLang("v1a2_114finisheventview_keydayscore")
	end

	if lastKeyDayScore then
		self._txtscorenum.text = lastKeyDayScore
		self._txtscoretype.text = luaLang("v1a2_114finisheventview_lastkeydayscore")
	end

	gohelper.setActive(self._goscore, showScore)
end

function Activity114FinishEventView:refreshContainerHeight()
	ZProj.UGUIHelper.RebuildLayout(self._gocontent.transform)

	local addHeight = recthelper.getHeight(self._gocontent.transform)
	local curContainerHeight = recthelper.getHeight(self._gocontainer.transform)

	recthelper.setHeight(self._gocontainer.transform, math.min(maxContainerHeight, curContainerHeight + addHeight))
end

function Activity114FinishEventView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageblackbg:UnLoadImage()
end

return Activity114FinishEventView
