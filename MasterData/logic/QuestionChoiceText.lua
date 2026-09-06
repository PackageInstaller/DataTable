-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/questionnaire/view/QuestionChoiceText.lua

module("logic.extensions.questionnaire.view.QuestionChoiceText", package.seeall)

local QuestionChoiceText = class("QuestionChoiceText", QuestionBase)

function QuestionChoiceText:buildUI()
	return
end

function QuestionChoiceText:onSetMo(cfg)
	QuestionChoiceText.super.onSetMo(self, cfg)

	local optionId = self._planCfg.optionId

	self._optionCfgs = QuestionnaireConfig.instance:getOptionCfgsById(optionId)
	self._chooseMax = self._questionCfg.chooseMax

	self:_updateUI()
end

function QuestionChoiceText:onSetMiniMo(planCfg, chooseMax)
	self._planCfg = planCfg

	local optionId = self._planCfg.optionId

	self._optionCfgs = QuestionnaireConfig.instance:getOptionCfgsById(optionId)
	self._chooseMax = chooseMax

	self:_updateUI()
end

function QuestionChoiceText:onSetScoreMo(chooseMax)
	self._optionCfgs = {}

	for i = 1, 10 do
		local temp = {}

		temp.id = i
		temp.typeId = i

		table.insert(self._optionCfgs, temp)
	end

	self._chooseMax = chooseMax

	self:_updateUI()
end

function QuestionChoiceText:_updateUI()
	self._activeOptionIds = {}
	self._activeNum = 0

	self:_updateChoices()
end

function QuestionChoiceText:_updateChoices()
	GameUtil.updateCellsWithCreate(self.mainGO, self._optionCfgs, self._updateOneChoiceText, self)
end

function QuestionChoiceText:_updateOneChoiceText(cell, data)
	local txtContent = goutil.findChildTextComponent(cell, "txtContent")
	local btnToggle = Framework.ButtonAdapter.GetFrom(cell, "btnToggle")
	local selected = goutil.findChild(btnToggle.gameObject, "Checkmark")

	txtContent.text = data.typeId

	btnToggle:AddClickListener(function()
		self:_onClickToggle(data.id)
	end)
	goutil.setActive(selected, self._activeOptionIds[data.id] == true)
end

function QuestionChoiceText:_onClickToggle(id)
	local isActive = self._activeOptionIds[id] == true

	isActive = not isActive

	if self._chooseMax == 1 and isActive then
		self._activeNum = 1
		self._activeOptionIds = {}
		self._activeOptionIds[id] = isActive

		self:_updateChoices()

		return
	end

	if self._activeNum >= self._chooseMax and isActive then
		FloatWordMgr.instance:show(string.format("最多只能选%s项", self._chooseMax))
	else
		if isActive then
			self._activeNum = self._activeNum + 1 or self._activeNum - 1
		end

		self._activeOptionIds[id] = isActive

		self:_updateChoices()
	end
end

function QuestionChoiceText:getResultStr()
	local resultStr = ""

	for k, v in pairs(self._activeOptionIds) do
		if v == true then
			resultStr = string.nilorempty(resultStr) and k or resultStr .. ":" .. k
		end
	end

	if string.nilorempty(resultStr) then
		return "请至少选择一项", false
	else
		return resultStr, true
	end
end

function QuestionChoiceText:clear()
	self._activeOptionIds = {}
	self._activeNum = 0
end

return QuestionChoiceText
