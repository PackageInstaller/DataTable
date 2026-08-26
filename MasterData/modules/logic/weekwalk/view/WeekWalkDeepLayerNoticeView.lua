-- chunkname: @modules/logic/weekwalk/view/WeekWalkDeepLayerNoticeView.lua

module("modules.logic.weekwalk.view.WeekWalkDeepLayerNoticeView", package.seeall)

local WeekWalkDeepLayerNoticeView = class("WeekWalkDeepLayerNoticeView", BaseView)

function WeekWalkDeepLayerNoticeView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._txtlastprogress = gohelper.findChildText(self.viewGO, "rule/#txt_lastprogress")
	self._imageruleicon = gohelper.findChildImage(self.viewGO, "rule/ruleinfo/#image_ruleicon")
	self._imageruletag = gohelper.findChildImage(self.viewGO, "rule/ruleinfo/#image_ruletag")
	self._txtruledesc = gohelper.findChildText(self.viewGO, "rule/ruleinfo/#txt_ruledesc")
	self._simageruledescicon = gohelper.findChildSingleImage(self.viewGO, "rule/ruleinfo/mask/#simage_ruledescicon")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "rewards/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "rewards/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "rewards/#btn_start")
	self._btnruledetail = gohelper.findChildButtonWithAudio(self.viewGO, "rule/ruleinfo/#btn_ruledetail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkDeepLayerNoticeView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnruledetail:AddClickListener(self._btnruledetailOnClick, self)
end

function WeekWalkDeepLayerNoticeView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnruledetail:RemoveClickListener()
end

function WeekWalkDeepLayerNoticeView:_btncloseOnClick()
	self:closeThis()
end

function WeekWalkDeepLayerNoticeView:_btnstartOnClick()
	self._clickStart = true

	self:openWeekWalkView()
end

function WeekWalkDeepLayerNoticeView:_btnruledetailOnClick()
	WeekWalkController.instance:openWeekWalkRuleView()
end

function WeekWalkDeepLayerNoticeView:openWeekWalkView()
	module_views_preloader.WeekWalkLayerViewPreload(function()
		self:delayOpenWeekWalkView()
	end)
end

function WeekWalkDeepLayerNoticeView:delayOpenWeekWalkView()
	self:closeThis()
	WeekWalkController.instance:openWeekWalkLayerView()
end

function WeekWalkDeepLayerNoticeView:_editableInitView()
	self._info = WeekWalkModel.instance:getInfo()

	if self._info.isPopDeepSettle then
		self._info.isPopDeepSettle = false

		WeekwalkRpc.instance:sendMarkPopDeepSettleRequest()
	end

	self._simagebg1:LoadImage(ResUrl.getWeekWalkBg("full/beijing_shen.jpg"))
	self._simagemask:LoadImage(ResUrl.getWeekWalkBg("zhezhao.png"))
	self._simagebg2:LoadImage(ResUrl.getWeekWalkBg("shenmian_tcdi.png"))
end

function WeekWalkDeepLayerNoticeView:onUpdateParam()
	return
end

function WeekWalkDeepLayerNoticeView._getRewardList()
	local rewardSet = {}

	for _, v in ipairs(lua_task_weekwalk.configList) do
		if v.minTypeId == 4 and WeekWalkTaskListModel.instance:checkPeriods(v) then
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

function WeekWalkDeepLayerNoticeView:_showRewardList()
	local list = WeekWalkDeepLayerNoticeView._getRewardList()

	for i, reward in ipairs(list) do
		local go = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(go, true)

		local item = IconMgr.instance:getCommonItemIcon(gohelper.findChild(go, "go_item"))

		item:setMOValue(reward[1], reward[2], reward[3])
		item:isShowCount(true)
		item:setCountFontSize(31)
	end
end

function WeekWalkDeepLayerNoticeView:onOpen()
	if self.viewParam then
		if self.viewParam then
			local txt = gohelper.findChildText(self.viewGO, "rule/resettip")

			txt.text = luaLang("p_weekwalkdeeplayernoticeview_title_open")

			local rewards = gohelper.findChild(self.viewGO, "rewards")

			recthelper.setAnchorY(rewards.transform, -208)
			gohelper.setActive(self._txtlastprogress, false)
		end

		local deepProgress = self._info.deepProgress
		local progressParamList = string.splitToNumber(deepProgress, "#")
		local layerId = progressParamList[1]
		local battleIndex = progressParamList[2]

		if layerId and battleIndex then
			local layerConfig = lua_weekwalk.configDict[layerId]
			local sceneConfig = lua_weekwalk_scene.configDict[layerConfig.sceneId]
			local tag = {
				sceneConfig.name,
				"0" .. (battleIndex or 1)
			}

			self._txtlastprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkdeeplayernoticeview_lastprogress"), tag)
		else
			self._txtlastprogress.text = luaLang("weekwalkdeeplayernoticeview_noprogress")
		end

		self:_showRewardList()

		local issueId = self._info.issueId
		local ruleConfig = lua_weekwalk_rule.configDict[issueId]
		local isIncludeCn = ruleConfig.isCn == 1
		local icon

		self._simageruledescicon:LoadImage(isIncludeCn and ResUrl.getWeekWalkIconLangPath(ruleConfig.icon) or ResUrl.getWeekWalkBg("rule/" .. ruleConfig.icon .. ".png"))

		local additionRule = ruleConfig.additionRule

		if string.nilorempty(additionRule) then
			return
		end

		local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

		self._ruleList = ruleList

		for i, v in ipairs(ruleList) do
			local targetId = v[1]
			local ruleId = v[2]
			local ruleCo = lua_rule.configDict[ruleId]

			self:_setRuleDescItem(ruleCo, targetId)

			break
		end

		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_installation_open)
		NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
	end
end

function WeekWalkDeepLayerNoticeView:_setRuleDescItem(ruleCo, targetId)
	local tagColor = {
		"#6384E5",
		"#D05B4C",
		"#C7b376"
	}

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(self._imageruleicon, ruleCo.icon)
	UISpriteSetMgr.instance:setCommonSprite(self._imageruletag, "wz_" .. targetId)

	local descContent = string.gsub(ruleCo.desc, "%【(.-)%】", "<color=#FF906A>[%1]</color>")
	local wordContent = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(ruleCo.desc, tagColor[1])
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	descContent = descContent .. wordContent
	self._txtruledesc.text = formatLuaLang("fight_rule_desc", color, side, descContent)
end

function WeekWalkDeepLayerNoticeView:onClose()
	self._simageruledescicon:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_close)
end

function WeekWalkDeepLayerNoticeView:onCloseFinish()
	if not self._clickStart then
		WeekWalk_2Controller.instance:checkOpenWeekWalk_2DeepLayerNoticeView()
	end
end

function WeekWalkDeepLayerNoticeView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return WeekWalkDeepLayerNoticeView
