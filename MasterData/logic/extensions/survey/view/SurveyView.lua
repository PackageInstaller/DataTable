-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/view/SurveyView.lua

module("logic.extensions.survey.view.SurveyView", package.seeall)

local M = class("SurveyView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("survey_tips_677860802")
	self._startPanel = self:getGo("survey_tips_1862069936")
	self._btnStart = self:getBtn("survey_tips_1320530120")
	self._txtStart = self:getText("survey_tips_834047278")
	self._txtTitle = self:getText("survey_tips_1040183118")
	self._startReward = self:getGo("survey_tips_1435874101")
	self._endPanel = self:getGo("survey_tips_963173803")
	self._txtEnd = self:getText("survey_tips_1775652593")
	self._endReward = self:getGo("survey_tips_5675814")
	self._queryPanel = self:getGo("survey_tips_1245615523")
	self._btnNext = self:getBtn("survey_tips_1143144813")
	self._txtNext = self:getText("survey_tips_120277510")
	self._btnPre = self:getBtn("survey_tips_314064644")
	self._txtPre = self:getText("survey_tips_-1405288854")
	self._txtQuery = self:getText("survey_tips_1527516929")
	self._slider = UIComponentType.SliderAdapter(goutil.findChild(self._queryPanel, "silder"))
	self._typeGo = {
		self:getGo("survey_tips_911994277"),
		self:getGo("survey_tips_463435766"),
		self:getGo("survey_tips_911994277"),
		self:getGo("survey_tips_2058882271"),
		self:getGo("survey_tips_505548876"),
		self:getGo("survey_tips_-1107729510")
	}
	self._choiceContent = self:getGo("survey_tips_1022495453")
	self._choiceToggleGroup = self._choiceContent:GetComponent(UIComponentType.SpaceXToggleGroup)
	self._gridLayout = self._choiceContent:GetComponent(UIComponentType.GridLayoutGroup)
	self._matrixChoiceTitle = self:getGo("survey_tips_442783301")
	self._matrixChoiceContent = self:getGo("survey_tips_1393885389")
	self._starContent = self:getGo("survey_tips_-616003375")
	self._dropdownConfig = self:getGo("survey_tips_1045356822"):GetComponent(UIComponentType.DropdownApapter)
	self._inputAnswer = self:getUIComponent("survey_tips_707196451", UIComponentType.InputFieldAdapter)
	self._bindInput = {}
	self._bindBtn = {}
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._dropdownConfig:AddListener(self._dealDropdown, self)
	self._inputAnswer:AddOnEndEdit(self._dealInput, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._dropdownConfig:RemoveClickListener()
	self._inputAnswer:RemoveOnEndEdit()

	for i, v in pairs(self._bindInput) do
		self._bindInput[i]:RemoveOnEndEdit()
	end

	for i, v in pairs(self._bindBtn) do
		self._bindBtn[i]:RemoveClickListener()
	end
end

function M:onEnter()
	local id = self:getOpenParam()[1]

	self._actId = self:getOpenParam()[2]
	self._trspos = self._matrixChoiceContent.transform.position
	self._trsposStar = self._starContent.transform.position
	self._pos = 0
	self._surveyCfg = SurveyConfig.instance:getSurveyCO(id)
	self._subjectCfg = SurveyConfig.instance:getSubjectCfgById(id)
	self._txtTitle.text = self._surveyCfg.title
	self._txtStart.text = self._surveyCfg.desc

	self._startPanel:SetActive(true)
	self._queryPanel:SetActive(false)
	self._endPanel:SetActive(false)
	goutil.clearChildren(self._startReward)

	local templete = goutil.findChild(self._startPanel, "item")
	local config = MailConfig.instance:getMailConfig(self._surveyCfg.rewardMail)

	self._rewardCO = RewardConfig.instance:getRewardCfgByCode(config.attachment)

	if self._rewardCO and self._rewardCO.reward then
		for i = 1, #self._rewardCO.reward do
			local itemCell = goutil.cloneAndSetParent(templete, self._startReward.transform)

			goutil.setActive(itemCell, true)

			local itemImg = goutil.findChildImageComponent(itemCell, "icon")
			local itemTxt = goutil.findChildTextComponent(itemCell, "txtNum")
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._rewardCO.reward[i].code)

			IconLoader.setSprite(itemImg, IconType.ItemIcon, itemCo.icon)

			itemTxt.text = string.format("*%d", self._rewardCO.reward[i].num)
		end
	end

	self._map = {
		function(desc)
			return self:_choiceProcess(desc, false)
		end,
		function(desc, range)
			return self:_dropdownProcess(desc, range)
		end,
		function(desc)
			return self:_choiceProcess(desc, true)
		end,
		function(desc)
			return self:_matrixProcess(desc)
		end,
		function()
			return self:_answerProcess()
		end,
		function(desc)
			return self:_starProcess(desc)
		end
	}
end

function M:_refreshQuery()
	local text = self._pos < #self._subjectCfg and lang("tip_survey_next") or lang("tip_finish")

	self._txtNext.text = text
	text = self._pos == 1 and lang("tip_survey_backhome") or lang("tip_survey_pre")
	self._txtPre.text = text

	local rate = self._pos / #self._subjectCfg

	self._slider:SetValue(rate)

	local cfg = self._subjectCfg[self._pos]
	local desc = SurveyType:getContent(cfg.desc)

	self._txtQuery.text = cfg.query

	self:_setQueryActive(cfg.type)
	SurveyType:setPos(self._pos)
	self._map[cfg.type](desc, cfg.selectRange)
end

function M:_setQueryActive(id)
	for i = 1, #self._typeGo do
		goutil.setActive(self._typeGo[i], false)
	end

	goutil.setActive(self._typeGo[id], true)
end

function M:_choiceProcess(content, isMulti)
	for i, v in pairs(self._bindInput) do
		self._bindInput[i]:RemoveOnEndEdit()
	end

	self._bindInput = {}

	for i, v in pairs(self._bindBtn) do
		self._bindBtn[i]:RemoveClickListener()
	end

	self._bindBtn = {}

	goutil.clearChildren(self._choiceContent)

	local hasImg = false

	for i, v in pairs(content) do
		local txtName = v[1]
		local imgName = false
		local txtElse = false

		if v[2] and v[2] ~= "" then
			imgName = v[2]
			hasImg = true
		end

		if v[#v] == "" then
			txtElse = true
		end

		local itemCell = goutil.cloneAndSetParent(self._viewPresentor:getPrefab(ResName.Survey_survey_question_type1_item), self._choiceContent.transform)

		if not isMulti then
			local tog = goutil.findChildComponent(itemCell, "singleTog", UIComponentType.SpaceXToggle)

			tog.ToggleGroup = self._choiceToggleGroup
		end

		SurveyType:setChoice(itemCell, txtName, isMulti, imgName, txtElse, i, self._bindInput, self._bindBtn)
	end

	if hasImg then
		self._gridLayout.cellSize = UnityEngine.Vector2.New(380, 80)
	else
		self._gridLayout.cellSize = UnityEngine.Vector2.New(380, 40)
	end
end

function M:_dealDropdown()
	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	ans = ans or {
		selection = {}
	}

	local index = self._dropdownConfig.dropdown.value
	local desc = SurveyType:getContent(self._subjectCfg[self._pos].desc)[1]
	local range = self._subjectCfg[self._pos].selectRange
	local res = 0

	if range[1] == tonumber(desc[1]) and range[2] == tonumber(desc[2]) then
		res = tonumber(desc[1])
	end

	ans.selection = {
		index + res + 1
	}
	ans.index = index

	SurveyModel.instance:setSubAnswer(self._pos, ans)
end

function M:_dealInput()
	local text = self._inputAnswer:GetText()
	local ans = {
		selection = {}
	}

	ans.textContent = text

	SurveyModel.instance:setSubAnswer(self._pos, ans)
end

function M:_dropdownProcess(content, range)
	self._dropdownConfig.dropdown:ClearOptions()

	local num = content[1]
	local beginIdx = tonumber(num[1])
	local endIdx = tonumber(num[2])
	local default = UnityEngine.UI.Dropdown.OptionData.New(lang("tip_survey_none"))

	self._dropdownConfig.dropdown.options:Add(default)

	if range[1] == beginIdx and range[2] == endIdx then
		for idx = beginIdx, endIdx do
			local temp = UnityEngine.UI.Dropdown.OptionData.New(tostring(idx))

			self._dropdownConfig.dropdown.options:Add(temp)
		end
	else
		for idx = 1, #num do
			local temp = UnityEngine.UI.Dropdown.OptionData.New(num[idx])

			self._dropdownConfig.dropdown.options:Add(temp)
		end
	end

	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	if ans and ans.index then
		local opt = ans.index

		if opt == 0 then
			opt = -1
		end

		self._dropdownConfig.dropdown.value = opt
	else
		self._dropdownConfig.dropdown.value = -1
	end
end

function M:_matrixProcess(content)
	local vertical = content[1]
	local horizontal = content[2]

	for i = 1, 6 do
		local title = goutil.findChildTextComponent(self._matrixChoiceTitle, "Text" .. i)

		if i <= #horizontal then
			goutil.setActive(title.gameObject, true)

			title.text = horizontal[i]
		else
			goutil.setActive(title.gameObject, false)
		end
	end

	goutil.clearChildren(self._matrixChoiceContent)

	self._matrixChoiceContent.transform.position = self._trspos

	for i, v in pairs(vertical) do
		local name = v
		local imgName = false

		if string.find(name, "%$") then
			local item = string.split(name, "$")

			name = (item[1] ~= "" or false) and item[1]
			imgName = item[2]
		end

		local itemCell = goutil.cloneAndSetParent(self._viewPresentor:getPrefab(ResName.Survey_survey_question_type2_item), self._matrixChoiceContent.transform)

		SurveyType:setMatrixChoice(itemCell, name, imgName, #horizontal, i)
	end
end

function M:_starProcess(content)
	for i, v in pairs(self._bindBtn) do
		self._bindBtn[i]:RemoveClickListener()
	end

	self._bindBtn = {}

	goutil.clearChildren(self._starContent)

	self._starContent.transform.position = self._trsposStar

	local hasImg = false

	for i, v in pairs(content[1]) do
		local name = v
		local imgName = false

		if string.find(name, "%$") then
			local item = string.split(name, "$")

			name = (item[1] ~= "" or false) and item[1]
			imgName = item[2]
		end

		local itemCell = goutil.cloneAndSetParent(self._viewPresentor:getPrefab(ResName.Survey_survey_question_type3_item), self._starContent.transform)

		SurveyType:setStar(itemCell, name, imgName, i, self._bindBtn)
	end
end

function M:_answerProcess()
	local ans = SurveyModel.instance:getSubAnswer(self._pos)
	local text = ans and ans.textContent or ""

	self._inputAnswer:SetText(text)
end

function M:_onClickStart()
	self._pos = 1

	goutil.setActive(self._startPanel, false)
	goutil.setActive(self._queryPanel, true)

	self._starttime = os.clock()

	self:_refreshQuery()
end

function M:_checkVisible()
	local pre = self._subjectCfg[self._pos].preSelection

	if not pre then
		return true
	end

	local ans = SurveyModel.instance:getSubAnswer(pre[1])

	if not ans then
		return true
	end

	for i = 2, #pre do
		if pre[i] == ans.selection[1] - 1 then
			return true
		end
	end

	return false
end

function M:_isAnswered()
	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	if not ans then
		return false
	end

	local typeIdx = self._subjectCfg[self._pos].type

	if typeIdx == 4 or typeIdx == 6 then
		local maxCount = self._subjectCfg[self._pos].selectRange[1]

		return maxCount == TableUtil.getLen(ans.selection)
	elseif typeIdx == 5 then
		return ans.textContent ~= ""
	elseif typeIdx == 3 then
		local answered = false

		for i, v in pairs(ans.selection) do
			if v then
				answered = true
			end
		end

		return answered
	elseif typeIdx == 2 then
		return ans.index and ans.index > 0
	else
		return #ans.selection > 0
	end
end

function M:_onClickNext(skip)
	if not skip and not self:_isAnswered() then
		FloatWordMgr.instance:show(lang("tip_survey_hint"))

		return
	end

	self._pos = self._pos + 1

	if self._pos <= #self._subjectCfg then
		if not self:_checkVisible() then
			self:_onClickNext(true)
		end

		self:_refreshQuery()
	else
		goutil.setActive(self._queryPanel, false)
		goutil.setActive(self._endPanel, true)

		self._endtime = os.clock()

		goutil.clearChildren(self._endReward)

		local rewardList = Astral.GameObjectUtil.GetChildren(self._startReward)

		for index = 0, rewardList.Length - 1 do
			goutil.cloneAndSetParent(rewardList[index], self._endReward.transform)
		end

		self:_commitAnswer()
		GlobalDispatcher:dispatchEvent(EventType.ACTIVITY_REFRESH + ActivityEnum.LogicType.SURVEY)
	end
end

function M:_commitAnswer()
	local data = {}

	data.actId = self._actId
	data.finishSeconds = self._endtime - self._starttime
	data.answer = {}

	for id = 1, #self._subjectCfg do
		local ans = SurveyModel.instance:getSubAnswer(id)

		if ans then
			if self._subjectCfg[id].type == 3 then
				local trueSelect = {}

				for i, v in pairs(ans.selection) do
					if v then
						table.insert(trueSelect, i)
					end
				end

				ans.selection = trueSelect
			elseif self._subjectCfg[id].type == 2 then
				ans.selection[1] = ans.selection[1] - 1
				ans.index = nil
			end

			table.insert(data.answer, ans)
		end
	end

	SurveyAgent.instance:sendCommitSurveyRequest(data)
end

function M:_onClickPre()
	self._pos = self._pos - 1

	if self._pos > 0 then
		if not self:_checkVisible() then
			self:_onClickPre()
		end

		self:_refreshQuery()
	else
		goutil.setActive(self._startPanel, true)
		goutil.setActive(self._queryPanel, false)
	end
end

function M:_onClickClose()
	self._pos = 1

	self:_onClickPre()
	SurveyModel.instance:clearAnswer()
	self:close()
end

return M
