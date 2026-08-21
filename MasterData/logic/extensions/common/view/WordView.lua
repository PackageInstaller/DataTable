-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/WordView.lua

module("logic.extensions.common.view.WordView", package.seeall)

local M = class("WordView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	self._passEvent = self:getUIComponent("0&empty_mask_tips_29887572", ComponentType.PassEvent)
	self._goScroll = self:getGo("word_tips_-1888517071")
	self._goContent = self:getGo("word_tips_-365526972")
	self._goItem = self:getGo("1&label_detail_item_-1126607035")

	goutil.setActive(self._goItem, false)
end

function M:onEnter()
	self._wordData = self:getFirstParam().wordData

	self:_refreshView()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_clearWords()
	for _, cell in ipairs(self._wordCell or {}) do
		goutil.destroy(cell.go)
	end

	self._wordCell = {}
end

function M:_buildWordCell(go)
	local data = {}

	data.go = go
	data.txtName = goutil.findChildComponent(go, "txtName", UIComponentType.TextMeshProUGUI)
	data.txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI)

	function data.updateData(wordElement)
		data.txtName.text = wordElement:getNameFormat()

		local wordData = WordUtil.parse(wordElement:getDesc())

		data.txtContent.text = wordData:getDesc()
	end

	return data
end

function M:_createWord(wordElement)
	local go = goutil.cloneAndSetParent(self._goItem, self._goContent.transform)

	goutil.setActive(go, true)

	local cell = self:_buildWordCell(go)

	cell.updateData(wordElement)
	table.insert(self._wordCell, cell)
end

function M:_refreshView()
	self:_clearWords()
	self._wordData:refreshOrder()

	for _, wordElement in pairs(self._wordData:getWords()) do
		self:_createWord(wordElement)
	end
end

return M
