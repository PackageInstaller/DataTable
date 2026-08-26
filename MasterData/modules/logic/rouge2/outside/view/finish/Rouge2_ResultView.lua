-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultView.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultView", package.seeall)

local Rouge2_ResultView = class("Rouge2_ResultView", BaseView)

Rouge2_ResultView.StartResultIndex = 1
Rouge2_ResultView.OnePageShowResultCount = 2

function Rouge2_ResultView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._txtdec = gohelper.findChildText(self.viewGO, "Content/#txt_dec")
	self._goevent = gohelper.findChild(self.viewGO, "Content/#go_event")
	self._goitem1 = gohelper.findChild(self.viewGO, "Content/#go_event/#go_item1")
	self._txtevent = gohelper.findChildText(self.viewGO, "Content/#go_event/#go_item1/#txt_event")
	self._goitem2 = gohelper.findChild(self.viewGO, "Content/#go_event/#go_item2")
	self._goitem3 = gohelper.findChild(self.viewGO, "Content/#go_event/#go_item3")
	self._goitem4 = gohelper.findChild(self.viewGO, "Content/#go_event/#go_item4")
	self._gofail = gohelper.findChild(self.viewGO, "Content/#go_fail")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "Content/#go_fail/#simage_mask")
	self._simagemask2 = gohelper.findChildSingleImage(self.viewGO, "Content/#go_fail/#simage_mask2")
	self._gosuccess = gohelper.findChild(self.viewGO, "Content/#go_success")
	self._goarrow = gohelper.findChild(self.viewGO, "Content/#go_arrow")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Content/Title/#txt_Title")
	self._simagerightmask = gohelper.findChildSingleImage(self.viewGO, "Content/img_dec/#simage_rightmask")
	self._simageleftmask = gohelper.findChildSingleImage(self.viewGO, "Content/img_dec/#simage_leftmask")
	self._simagerightmask2 = gohelper.findChildSingleImage(self.viewGO, "Content/img_dec/#simage_rightmask2")
	self._simageleftmask2 = gohelper.findChildSingleImage(self.viewGO, "Content/img_dec/#simage_leftmask2")
	self._simagepoint = gohelper.findChildSingleImage(self.viewGO, "Content/img_dec/#simage_point")
	self._simagepoint2 = gohelper.findChildSingleImage(self.viewGO, "Content/img_dec/#simage_point2")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "Content/#btn_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "Content/#btn_skip/#image_skip")
	self._btnnext = gohelper.findChildButton(self.viewGO, "Content/#btn_next")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function Rouge2_ResultView:removeEvents()
	self._btnskip:RemoveClickListener()
	self._btnnext:RemoveClickListener()
end

function Rouge2_ResultView:_btnskipOnClick()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	Rouge2_Controller.instance:onEndFlowDone()
	Rouge2_Controller.instance:clearFlow()
	ViewMgr.instance:closeView(ViewName.Rouge2_SettlementView)
	ViewMgr.instance:closeView(ViewName.Rouge2_SettlementUnlockView)

	if resultInfo then
		local reviewInfo = resultInfo.reviewInfo
		local params = {
			reviewInfo = reviewInfo,
			displayType = Rouge2_OutsideEnum.ResultFinalDisplayType.Result
		}

		Rouge2_OutsideController.instance:openRougeResultFinalView(params)
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinishCallBack, self)
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinishCallBack, self)
	else
		self:closeThis()
	end
end

function Rouge2_ResultView:_onOpenViewFinishCallBack(viewName)
	if viewName == ViewName.Rouge2_ResultFinalView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinishCallBack, self)
		self:closeThis()
	end
end

function Rouge2_ResultView:_btnnextOnClick()
	local startIndex = self._curEventEndIndex + 1
	local hasNeedShowResult = self:isHasNeedShowResultItem(startIndex)

	if hasNeedShowResult then
		self:try2ShowResult(startIndex)
		AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_featurette_2)
	else
		Rouge2_OutsideController.instance:openRougeSettlementView()
	end
end

function Rouge2_ResultView:onViewOpenFinish(viewName)
	if viewName == ViewName.Rouge2_SettlementView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenFinish, self)
		self:closeThis()
	end
end

function Rouge2_ResultView:_editableInitView()
	self._isSwitch2EndingView = false
	self._curEventEndIndex = 0
	self._configMap = self:buildConfigMap()
	self._descList = self:getTriggerConfigs()

	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
end

function Rouge2_ResultView:onOpen()
	return
end

function Rouge2_ResultView:onOpenFinish()
	self:onBeforeShowResultContent()
end

function Rouge2_ResultView:onUpdateParam()
	self:onBeforeShowResultContent()

	self._isSwitch2EndingView = false
	self._curEventEndIndex = 0
end

function Rouge2_ResultView:onBeforeShowResultContent()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_featurette_1)

	local descs = self:filterTypeGroupCfgs(Rouge2_OutsideEnum.BeginType)

	if descs then
		local connect = luaLang("p_rouge2_comma")

		if #descs > 2 then
			local endStr = table.concat(descs, connect, 2)

			endStr = descs[1] .. endStr
			self._txtdec.text = endStr
		else
			self._txtdec.text = table.concat(descs)
		end

		gohelper.setActive(self._txtdec.gameObject, true)
	end

	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._goarrow, false)
	gohelper.setActive(self._goevent, false)
end

function Rouge2_ResultView:showRougeResultList()
	self:try2ShowResult(Rouge2_ResultView.StartResultIndex)
	gohelper.setActive(self._goarrow, true)
	gohelper.setActive(self._txtdec.gameObject, false)
end

function Rouge2_ResultView:buildConfigMap()
	local resultCfgs = lua_rouge2_result.configList
	local configMap = {}

	if resultCfgs then
		for _, resultCfg in ipairs(resultCfgs) do
			local cfgType = resultCfg.type

			configMap[cfgType] = configMap[cfgType] or {}

			table.insert(configMap[cfgType], resultCfg)
		end
	end

	for _, cfgs in pairs(configMap) do
		table.sort(cfgs, Rouge2_SettlementTriggerHelper.configSortFunction)
	end

	return configMap
end

local TypeShowTriggerMaxNum = 3

function Rouge2_ResultView:getTriggerConfigs()
	local descList = {}

	for i = Rouge2_OutsideEnum.MinMiddleType, Rouge2_OutsideEnum.MaxMiddleType do
		local descs = self:filterTypeGroupCfgs(i)

		if descs and #descs > 0 then
			local result = {
				eventType = i,
				contents = descs
			}

			table.insert(descList, result)
		end
	end

	return descList
end

function Rouge2_ResultView:filterTypeGroupCfgs(resultType)
	if self._configMap then
		if not self._configMap then
			return
		end

		local descList = {}
		local count = 0

		for _, cfg in ipairs(self._configMap) do
			local desc = self:tryFilterTrigger(cfg)

			if not string.nilorempty(desc) then
				table.insert(descList, desc)

				count = count + 1

				if resultType ~= Rouge2_OutsideEnum.BeginType and count >= TypeShowTriggerMaxNum then
					break
				end
			end
		end

		return descList
	end
end

function Rouge2_ResultView:tryFilterTrigger(resultCfg)
	if not resultCfg then
		return nil
	end

	local values = {
		Rouge2_SettlementTriggerHelper.isResultTrigger(resultCfg.trigger, unpack((not string.nilorempty(resultCfg.triggerParam) or nil) and string.splitToNumber(resultCfg.triggerParam, "#")))
	}
	local isTrigger = values and values[1] ~= nil
	local isDefaultVisible = self:checkIsTriggerDefaultVisible(resultCfg)

	if isTrigger or isDefaultVisible then
		return (GameUtil.getSubPlaceholderLuaLang(resultCfg.desc, values))
	end

	return nil
end

function Rouge2_ResultView:checkIsTriggerDefaultVisible(triggerCfg)
	return triggerCfg and triggerCfg.priority == 0
end

function Rouge2_ResultView:try2ShowResult(startIndex)
	if not self._descList then
		return
	end

	local descCount = #self._descList

	if descCount < startIndex then
		return
	end

	local endIndex = startIndex + Rouge2_ResultView.OnePageShowResultCount - 1

	endIndex = descCount < endIndex and descCount or endIndex

	self:setAllResultItemVisible(false)

	for i = startIndex, endIndex do
		local descs = self._descList[i]
		local resultItem = self:getOrCreateResultItem(i)

		self:refreshResultContent(resultItem, descs)
	end

	self._curEventEndIndex = endIndex

	gohelper.setActive(self._goevent, true)
	gohelper.setActive(self._txtdec.gameObject, false)
end

function Rouge2_ResultView:getOrCreateResultItem(index)
	return self["_goitem" .. index]
end

function Rouge2_ResultView:setAllResultItemVisible(isVisible)
	local eventCount = self._goevent.transform.childCount

	for i = 1, eventCount do
		gohelper.setActive(self._goevent.transform:GetChild(i - 1), isVisible)
	end
end

local eventIconNameMap = {
	nil,
	"rouge_result_icon_box",
	"rouge_result_icon_beasts",
	"rouge_result_icon_party",
	"rouge_result_icon_location"
}

function Rouge2_ResultView:refreshResultContent(resultItem, descs)
	if not resultItem or not descs then
		return
	end

	local contents = descs.contents
	local descStr = table.concat(contents, "\n")
	local txtEvent = gohelper.findChildText(resultItem, "#txt_event")

	txtEvent.text = descStr

	local iconName = eventIconNameMap[descs.eventType]

	if iconName then
		local imageicon = gohelper.findChildImage(resultItem, "#imgae_icon")

		UISpriteSetMgr.instance:setRouge2Sprite(imageicon, iconName)
	end

	gohelper.setActive(resultItem, true)
end

function Rouge2_ResultView:isHasNeedShowResultItem(resultIndex)
	if self._descList then
		if not #self._descList then
			local resultCount = 0

			return resultIndex <= resultCount
		end
	end
end

function Rouge2_ResultView:switch2Ending()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_featurette_3)

	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local isSucc = resultInfo and resultInfo:isSucceed()

	gohelper.setActive(self._gofail, not isSucc)
	gohelper.setActive(self._gosuccess, isSucc)
	gohelper.setActive(self._goarrow, false)
	self:setAllResultItemVisible(false)

	self._isSwitch2EndingView = true

	local descList = self:filterTypeGroupCfgs(Rouge2_OutsideEnum.EndType)

	if descList then
		if not descList[1] then
			local desc = ""

			if isSucc then
				local txtsuccess = gohelper.findChildText(self._gosuccess, "txt_success")

				txtsuccess.text = desc
			else
				local txtfail = gohelper.findChildText(self._gofail, "txt_fail")

				txtfail.text = desc
			end
		end
	end
end

function Rouge2_ResultView:getRougeResultCfg(cfgType, season)
	local cfgs = self._configMap[cfgType]

	if cfgs then
		for _, cfg in ipairs(cfgs) do
			if cfg.season == season then
				return cfg
			end
		end
	end
end

function Rouge2_ResultView:onClose()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenFinish, self)
end

function Rouge2_ResultView:onDestroyView()
	return
end

return Rouge2_ResultView
