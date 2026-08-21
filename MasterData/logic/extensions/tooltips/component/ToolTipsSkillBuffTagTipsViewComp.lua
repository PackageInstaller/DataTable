-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsSkillBuffTagTipsViewComp.lua

module("logic.extensions.tooltips.component.ToolTipsSkillBuffTagTipsViewComp", package.seeall)

local M = class("ToolTipsSkillBuffTagTipsViewComp", ViewComponent)

function M:buildUI()
	local maskGo = self:getGoByPath("empty_raycast_mask")

	self._passEvent = maskGo:GetComponent(ComponentType.PassEvent)
	self._goBuffScroll = self:getGo("skill_buff_tag_tips_-1888517071")
	self._goBuffContent = self:getGo("skill_buff_tag_tips_-365526972")
	self._buffTipsItem = self:getGo("label_detail_item_-1126607035")

	goutil.setActive(self._buffTipsItem, false)
end

function M:destroyUI()
	self:_setEvent(false)
end

function M:onEnter()
	self:_setEvent(true)

	local info = self:getFirstParam()

	if info.skillEnhanceMO then
		self:_updateWordView(info.skillEnhanceMO)
	else
		self:_updateBuffViewWithLst(info.buffCodes, info.tagCodes)
	end

	if info.hasDispatch then
		GlobalDispatcher:dispatchEvent(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, true, self._viewPresentor:getViewName())
	end
end

function M:onExit()
	self:_setEvent(false)
end

function M:onExitFinished()
	GlobalDispatcher:dispatchEvent(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, false, self._viewPresentor:getViewName())
	self:_clearBuffItems()
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:_updateBuffView(skillEnhanceMO)
	local buffCodes = {}
	local tagCodes = {}

	skillEnhanceMO:buildDescription()
	skillEnhanceMO:fillTagIdList(tagCodes)
	skillEnhanceMO:fillBuffCodesList(buffCodes)
	self:_updateBuffViewWithLst(buffCodes, tagCodes)
end

function M:_updateBuffViewWithLst(buffCodes, tagCodes)
	self:_clearWords()

	buffCodes = buffCodes or {}
	tagCodes = tagCodes or {}

	BuffCOUtil.sortBuffCodes(buffCodes)

	local lst = {}

	for _, id in ipairs(buffCodes or {}) do
		table.insert(lst, {
			isTag = false,
			id = id
		})
	end

	for _, id in ipairs(tagCodes or {}) do
		table.insert(lst, {
			isTag = true,
			id = id
		})
	end

	self:_clearBuffItems()

	local len = #lst

	if len > 0 then
		for i = 1, len do
			self:_addBuffItem(#self._buffCell + 1)
		end
	end

	for index, data in ipairs(lst) do
		self._buffCell[index].updateData(index, data.id, data.isTag)
	end
end

function M:_addBuffItem(index)
	if self._buffCell[index] then
		printError("已有index:", index)
	else
		local go = goutil.cloneAndSetParent(self._buffTipsItem, self._goBuffContent.transform)
		local cell = self:_buildBuffCell(go, index)

		goutil.setActive(go, true)

		self._buffCell[index] = cell
	end
end

function M:_clearBuffItems()
	for index, cell in ipairs(self._buffCell or {}) do
		cell.destroyUI()
		goutil.destroy(cell.go)
	end

	self._buffCell = {}
end

function M:_buildBuffCell(go, index)
	local data = {}

	data.go = go
	data.index = index
	data.txtName = goutil.findChildComponent(go, "txtName", UIComponentType.TextMeshProUGUI)
	data.txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI)

	function data.destroyUI()
		return
	end

	function data.updateData(_index, id, isTag)
		data.index = _index
		data.id = id
		data.isTag = isTag

		local nameStr, contentStr

		if isTag then
			local tagCO = ActiveSkillConfig.instance:getSkillTagCO(id)

			if tagCO then
				contentStr = tagCO.desc

				local icon = ActiveSkillConfig.instance:getTagIconName(tagCO.typeName)

				nameStr = string.format("<sprite name=\"%s\">%s", icon, tagCO.name)
			elseif enableErrorLog then
				printError(string.format("找不到[%s]SkillTagCO", id))
			end
		else
			local buffCO = BuffConfig.instance:getBuffCO(id)

			if buffCO then
				contentStr = buffCO.desc
				nameStr = string.format("<sprite name=\"%s\">%s", buffCO.descIcon, buffCO.name)
			elseif enableErrorLog then
				printError("该技能描述找不到对应buff:", description)
			end
		end

		contentStr = ActiveSkillCOUtil.buildBuffAndTagDesc(contentStr)
		contentStr = ActiveSkillCOUtil.replaceDescriptionSpecialColor(contentStr)
		data.txtName.text = nameStr
		data.txtContent.text = contentStr
	end

	return data
end

function M:_buildWordCell(go, word)
	local data = {}

	data.go = go
	data.txtName = goutil.findChildComponent(go, "txtName", UIComponentType.TextMeshProUGUI)
	data.txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI)

	function data.updateData()
		data.txtName.text = word:getNameFormat()

		local wordData = WordUtil.parse(word:getDesc())

		data.txtContent.text = wordData:getDesc()
	end

	return data
end

function M:_clearWords()
	for _, cell in ipairs(self._wordCell or {}) do
		goutil.destroy(cell.go)
	end

	self._wordCell = {}
end

function M:_updateWordView(skillEnhanceMO)
	self:_clearWords()

	local description = skillEnhanceMO:getOriginDesc()
	local wordData = WordUtil.parse(description)

	if wordData and wordData:length() > 0 then
		wordData:refreshOrder()

		for index, word in pairs(wordData:getWords()) do
			local go = goutil.cloneAndSetParent(self._buffTipsItem, self._goBuffContent.transform)

			goutil.setActive(go, true)

			local cell = self:_buildWordCell(go, word)

			cell.updateData()

			self._wordCell[index] = cell
		end
	end
end

return M
