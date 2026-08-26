-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2DeepLayerNoticeView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2DeepLayerNoticeView", package.seeall)

local WeekWalk_2DeepLayerNoticeView = class("WeekWalk_2DeepLayerNoticeView", BaseView)

function WeekWalk_2DeepLayerNoticeView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._txtlastprogress = gohelper.findChildText(self.viewGO, "rule/#txt_lastprogress")
	self._txtlastprogress2 = gohelper.findChildText(self.viewGO, "rule/#txt_lastprogress2")
	self._imageruleicon = gohelper.findChildImage(self.viewGO, "rule/ruleinfo/#image_ruleicon")
	self._imageruletag = gohelper.findChildImage(self.viewGO, "rule/ruleinfo/#image_ruletag")
	self._txtruledesc = gohelper.findChildText(self.viewGO, "rule/ruleinfo/#txt_ruledesc")
	self._simageruledescicon = gohelper.findChildSingleImage(self.viewGO, "rule/ruleinfo/mask/#simage_ruledescicon")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "rewards/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "rewards/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._goruleitem = gohelper.findChild(self.viewGO, "rule/ruleinfo/ScrollView/Viewport/Content/#go_ruleitem")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "rewards/#btn_start")
	self._btnruledetail = gohelper.findChildButtonWithAudio(self.viewGO, "rule/ruleinfo/#btn_ruledetail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2DeepLayerNoticeView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnruledetail:AddClickListener(self._btnruledetailOnClick, self)
end

function WeekWalk_2DeepLayerNoticeView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnruledetail:RemoveClickListener()
end

function WeekWalk_2DeepLayerNoticeView:_btncloseOnClick()
	self:closeThis()
end

function WeekWalk_2DeepLayerNoticeView:_btnstartOnClick()
	self:openWeekWalkView()
end

function WeekWalk_2DeepLayerNoticeView:_btnruledetailOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
end

function WeekWalk_2DeepLayerNoticeView:openWeekWalkView()
	module_views_preloader.WeekWalk_2HeartLayerViewPreload(function()
		self:delayOpenWeekWalkView()
	end)
end

function WeekWalk_2DeepLayerNoticeView:delayOpenWeekWalkView()
	self:closeThis()
	WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView()
end

function WeekWalk_2DeepLayerNoticeView:_editableInitView()
	self._info = WeekWalk_2Model.instance:getInfo()

	if self._info.isPopSettle then
		self._info.isPopSettle = false

		Weekwalk_2Rpc.instance:sendWeekwalkVer2MarkPreSettleRequest()
	end

	self._simagebg1:LoadImage(ResUrl.getWeekWalkBg("full/beijing_shen.jpg"))
	self._simagemask:LoadImage(ResUrl.getWeekWalkBg("zhezhao.png"))
	self._simagebg2:LoadImage(ResUrl.getWeekWalkBg("shenmian_tcdi.png"))
end

function WeekWalk_2DeepLayerNoticeView:onUpdateParam()
	return
end

function WeekWalk_2DeepLayerNoticeView._getRewardList()
	local rewardSet = {}

	for _, v in ipairs(lua_task_weekwalk_ver2.configList) do
		if v.minTypeId == WeekWalk_2Enum.TaskType.Season and WeekWalk_2TaskListModel.instance:checkPeriods(v) then
			local rewardList = GameUtil.splitString2(v.bonus, true, "|", "#")

			for i, reward in ipairs(rewardList) do
				local type, id, num = reward[1], reward[2], reward[3]
				local key = string.format("%s_%s", type, id)
				local existReward = rewardSet[key]

				if not existReward then
					rewardSet[key] = reward
				else
					existReward[3] = existReward[3] + num
					rewardSet[key] = existReward
				end
			end
		end
	end

	local list = {}

	for i, reward in pairs(rewardSet) do
		table.insert(list, reward)
	end

	table.sort(list, DungeonWeekWalkView._sort)

	return list
end

function WeekWalk_2DeepLayerNoticeView:_showRewardList()
	local list = WeekWalk_2DeepLayerNoticeView._getRewardList()

	for i, reward in ipairs(list) do
		local go = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(go, true)

		local item = IconMgr.instance:getCommonItemIcon(gohelper.findChild(go, "go_item"))

		item:setMOValue(reward[1], reward[2], reward[3])
		item:isShowCount(true)
		item:setCountFontSize(31)
	end
end

function WeekWalk_2DeepLayerNoticeView:onOpen()
	if self.viewParam then
		if self.viewParam then
			local txt = gohelper.findChildText(self.viewGO, "rule/resettip")

			txt.text = luaLang("p_weekwalkdeeplayernoticeview_title_open")

			local rewards = gohelper.findChild(self.viewGO, "rewards")

			recthelper.setAnchorY(rewards.transform, -208)
			gohelper.setActive(self._txtlastprogress, false)
		end

		local prevSettle = self._info.prevSettle
		local layerId = prevSettle and prevSettle.maxLayerId
		local battleIndex = prevSettle and prevSettle.maxBattleIndex
		local layerConfig = layerId and lua_weekwalk_ver2.configDict[layerId]

		if layerConfig and battleIndex then
			local sceneConfig = lua_weekwalk_ver2_scene.configDict[layerConfig.sceneId]
			local tag = {
				sceneConfig.name,
				"0" .. (battleIndex or 1)
			}

			self._txtlastprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkdeeplayernoticeview_lastprogress"), tag)
		else
			self._txtlastprogress.text = luaLang("weekwalkdeeplayernoticeview_noprogress")
		end

		local platinumCupNum = prevSettle and prevSettle:getTotalPlatinumCupNum() or 0

		self._txtlastprogress2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("weekwalk_2resulttxt1"), platinumCupNum)

		self:_showRewardList()

		local issueId = self._info.issueId
		local ruleConfig = lua_weekwalk_ver2_time.configDict[issueId]
		local isIncludeCn = ruleConfig.isCn == 1
		local icon

		self._simageruledescicon:LoadImage(isIncludeCn and ResUrl.getWeekWalkIconLangPath(ruleConfig.ruleIcon) or ResUrl.getWeekWalkBg("rule/" .. ruleConfig.ruleIcon .. ".png"))

		local ruleList = {}

		if not string.nilorempty(ruleConfig.ruleFront) then
			tabletool.addValues(ruleList, GameUtil.splitString2(ruleConfig.ruleFront, true, "|", "#"))
		end

		if not string.nilorempty(ruleConfig.ruleRear) then
			tabletool.addValues(ruleList, GameUtil.splitString2(ruleConfig.ruleRear, true, "|", "#"))
		end

		self._ruleList = ruleList

		for i, v in ipairs(ruleList) do
			local targetId = v[1]
			local ruleId = v[2]
			local ruleCo = lua_rule.configDict[ruleId]

			self:_setRuleDescItem(ruleCo, targetId)
		end

		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_installation_open)
		NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
	end
end

function WeekWalk_2DeepLayerNoticeView:_setRuleDescItem(ruleCo, targetId)
	local tagColor = {
		"#6384E5",
		"#D05B4C",
		"#C7b376"
	}
	local go = gohelper.cloneInPlace(self._goruleitem)

	gohelper.setActive(go, true)

	local icon = gohelper.findChildImage(go, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)

	local line = gohelper.findChild(go, "line")
	local tag = gohelper.findChildImage(go, "tag")

	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)

	local desc = gohelper.findChildText(go, "desc")
	local descContent = string.gsub(ruleCo.desc, "%【(.-)%】", "<color=#FF906A>[%1]</color>")
	local wordContent = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(ruleCo.desc, tagColor[1])
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	desc.text = string.format("<color=%s>[%s]</color>%s%s", color, side, descContent, wordContent)
end

function WeekWalk_2DeepLayerNoticeView:onClose()
	self._simageruledescicon:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_close)
end

function WeekWalk_2DeepLayerNoticeView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return WeekWalk_2DeepLayerNoticeView
