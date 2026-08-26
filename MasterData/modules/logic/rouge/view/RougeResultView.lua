-- chunkname: @modules/logic/rouge/view/RougeResultView.lua

module("modules.logic.rouge.view.RougeResultView", package.seeall)

local RougeResultView = class("RougeResultView", BaseView)

RougeResultView.BeginType = 1
RougeResultView.MinMiddleType = 2
RougeResultView.MaxMiddleType = 5
RougeResultView.EndType = 6
RougeResultView.StartResultIndex = 1
RougeResultView.OnePageShowResultCount = 2

function RougeResultView:onInitView()
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

function RougeResultView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function RougeResultView:removeEvents()
	self._btnskip:RemoveClickListener()
	self._btnnext:RemoveClickListener()
end

function RougeResultView:_btnskipOnClick()
	RougeController.instance:openRougeSettlementView()
end

function RougeResultView:_btnnextOnClick()
	TaskDispatcher.cancelTask(self.playStartSettlementTxtAudio, self)

	if self._isSwitch2EndingView then
		RougeController.instance:openRougeSettlementView()
	else
		local startIndex = self._curEventEndIndex + 1
		local hasNeedShowResult = self:isHasNeedShowResultItem(startIndex)

		if hasNeedShowResult then
			self:try2ShowResult(startIndex)
			AudioMgr.instance:trigger(AudioEnum.UI.NextShowSettlementTxt)
		else
			self:switch2Ending()
			AudioMgr.instance:trigger(AudioEnum.UI.ShowEndingTxt)
		end
	end
end

function RougeResultView:_editableInitView()
	self._isSwitch2EndingView = false
	self._curEventEndIndex = 0
	self._configMap = self:buildConfigMap()
	self._descList = self:getTriggerConfigs()
end

function RougeResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.SettlementCloseWindow)
end

local delayTime2PlayStartAudio = 2

function RougeResultView:onOpenFinish()
	self:onBeforeShowResultContent()
	TaskDispatcher.cancelTask(self.playStartSettlementTxtAudio, self)
	TaskDispatcher.runDelay(self.playStartSettlementTxtAudio, self, delayTime2PlayStartAudio)
end

function RougeResultView:playStartSettlementTxtAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.StartShowSettlementTxt)
end

function RougeResultView:onUpdateParam()
	self:onBeforeShowResultContent()

	self._isSwitch2EndingView = false
	self._curEventEndIndex = 0
end

function RougeResultView:onBeforeShowResultContent()
	local descs = self:filterTypeGroupCfgs(RougeResultView.BeginType)

	if descs then
		self._txtdec.text = descs and descs[1]

		gohelper.setActive(self._txtdec.gameObject, true)
	end

	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._goarrow, false)
	gohelper.setActive(self._goevent, false)
end

function RougeResultView:showRougeResultList()
	self:try2ShowResult(RougeResultView.StartResultIndex)
	gohelper.setActive(self._goarrow, true)
	gohelper.setActive(self._txtdec.gameObject, false)
end

function RougeResultView:buildConfigMap()
	local resultInfo = RougeModel.instance:getRougeResult()
	local season = resultInfo and resultInfo.season
	local resultCfgs = lua_rouge_result.configDict[season]
	local configMap = {}

	if resultCfgs then
		for _, resultCfg in pairs(resultCfgs) do
			local cfgType = resultCfg.type

			configMap[cfgType] = configMap[cfgType] or {}

			table.insert(configMap[cfgType], resultCfg)
		end
	end

	for _, cfgs in pairs(configMap) do
		table.sort(cfgs, self.configSortFunction)
	end

	return configMap
end

function RougeResultView.configSortFunction(a, b)
	local aPriority = a.priority
	local bPriority = b.priority

	if aPriority ~= bPriority then
		return aPriority < bPriority
	end

	return a.id < b.id
end

local TypeShowTriggerMaxNum = 3

function RougeResultView:getTriggerConfigs()
	local descList = {}

	for i = RougeResultView.MinMiddleType, RougeResultView.MaxMiddleType do
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

function RougeResultView:filterTypeGroupCfgs(resultType)
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

				if count >= TypeShowTriggerMaxNum then
					break
				end
			end
		end

		return descList
	end
end

function RougeResultView:tryFilterTrigger(resultCfg)
	if not resultCfg then
		return
	end

	local values = {
		RougeSettlementTriggerHelper.isResultTrigger(resultCfg.trigger, unpack((not string.nilorempty(resultCfg.triggerParam) or nil) and string.splitToNumber(resultCfg.triggerParam, "#")))
	}
	local isTrigger = values and values[1] ~= nil
	local isDefaultVisible = self:checkIsTriggerDefaultVisible(resultCfg)

	if isTrigger or isDefaultVisible then
		return (GameUtil.getSubPlaceholderLuaLang(resultCfg.desc, values))
	end
end

function RougeResultView:checkIsTriggerDefaultVisible(triggerCfg)
	return triggerCfg and triggerCfg.priority == 0
end

function RougeResultView:try2ShowResult(startIndex)
	if not self._descList then
		return
	end

	local descCount = #self._descList

	if descCount < startIndex then
		return
	end

	local endIndex = startIndex + RougeResultView.OnePageShowResultCount - 1

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

function RougeResultView:getOrCreateResultItem(index)
	return self["_goitem" .. index]
end

function RougeResultView:setAllResultItemVisible(isVisible)
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

function RougeResultView:refreshResultContent(resultItem, descs)
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

function RougeResultView:isHasNeedShowResultItem(resultIndex)
	if self._descList then
		if not #self._descList then
			local resultCount = 0

			return resultIndex <= resultCount
		end
	end
end

function RougeResultView:switch2Ending()
	local resultInfo = RougeModel.instance:getRougeResult()
	local isSucc = resultInfo and resultInfo:isSucceed()

	gohelper.setActive(self._gofail, not isSucc)
	gohelper.setActive(self._gosuccess, isSucc)
	gohelper.setActive(self._goarrow, false)
	self:setAllResultItemVisible(false)

	self._isSwitch2EndingView = true

	local descList = self:filterTypeGroupCfgs(RougeResultView.EndType)

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

function RougeResultView:getRougeResultCfg(cfgType, season)
	local cfgs = self._configMap[cfgType]

	if cfgs then
		for _, cfg in ipairs(cfgs) do
			if cfg.season == season then
				return cfg
			end
		end
	end
end

function RougeResultView:onClose()
	TaskDispatcher.cancelTask(self.playStartSettlementTxtAudio, self)
end

function RougeResultView:onDestroyView()
	return
end

return RougeResultView
