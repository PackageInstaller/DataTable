-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionLvLimitView.lua

module("logic.extensions.controlaction.view.ControlActionLvLimitView", package.seeall)

local M = class("ControlActionLvLimitView", ViewComponent)

function M:buildUI()
	self._textTitle = self:getText("regulatory_lv_suppress_tips_-717339426")
	self._textDesc = self:getText("regulatory_lv_suppress_tips_-956525651")
	self._btnBg = self:getBtn("0&empty_mask_tips_29887572")
end

function M:bindEvents()
	self._btnBg:AddClickListener(self._onClickBg, self)
end

function M:unbindEvents()
	self._btnBg:RemoveClickListener()
end

function M:onEnter()
	local info = self:getOpenParam()
	local kLabelKey = info.wordKey
	local lvLimited = info.lvLimited

	wordCo = WordConfig.instance:getWordCO(kLabelKey)

	if wordCo == nil then
		return
	end

	self._textTitle.text = wordCo.name
	self._textDesc.text = string.format(wordCo.desc, lvLimited)
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_onClickBg()
	self:close()
end

return M
