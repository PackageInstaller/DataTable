-- chunkname: @modules/logic/commonbufftip/CommonBuffTipController.lua

module("modules.logic.commonbufftip.CommonBuffTipController", package.seeall)

local CommonBuffTipController = class("CommonBuffTipController")

function CommonBuffTipController:initViewParam()
	self.viewParam = self.viewParam or {}

	tabletool.clear(self.viewParam)
end

function CommonBuffTipController:openCommonTipView(effectId, clickPosition, monsterName)
	self:initViewParam()

	self.viewParam.effectId = effectId
	self.viewParam.clickPosition = clickPosition
	self.viewParam.monsterName = monsterName

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, self.viewParam)
end

function CommonBuffTipController:openCommonTipViewWithCustomPos(effectId, anchorPos, pivot, monsterName, defaultVNP)
	self:initViewParam()

	self.viewParam.effectId = effectId
	self.viewParam.scrollAnchorPos = anchorPos
	self.viewParam.pivot = pivot or CommonBuffTipEnum.Pivot.Left
	self.viewParam.monsterName = monsterName
	self.viewParam.defaultVNP = defaultVNP or 0

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, self.viewParam)
end

function CommonBuffTipController:openCommonTipViewWithCustomPosCallback(effectId, setScrollPosCallback, setScrollPosCallbackObj, monsterName, defaultVNP)
	self:initViewParam()

	self.viewParam.effectId = effectId
	self.viewParam.setScrollPosCallback = setScrollPosCallback
	self.viewParam.setScrollPosCallbackObj = setScrollPosCallbackObj
	self.viewParam.monsterName = monsterName
	self.viewParam.defaultVNP = defaultVNP or 0

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, self.viewParam)
end

function CommonBuffTipController:getBuffTagName(buffName)
	local buffId = string.match(buffName, "<id:(%d+)>")

	buffId = tonumber(buffId)

	if buffId then
		return self:getBuffTagNameByBuffId(buffId, buffName)
	end

	return self:getBuffTagNameByBuffName(buffName)
end

function CommonBuffTipController:getBuffTagNameByBuffId(buffId, buffName)
	local buffCo = buffId and lua_skill_buff.configDict[buffId]
	local plainBuffName = SkillHelper.removeRichTag(buffName)

	if buffCo and buffCo.name == plainBuffName then
		return self:getBuffTagNameByTypeId(buffCo.typeId)
	end

	return self:getBuffTagNameByBuffName(buffName)
end

function CommonBuffTipController:getBuffTagNameByBuffName(buffName)
	buffName = SkillHelper.removeRichTag(buffName)

	if string.nilorempty(buffName) then
		return ""
	end

	for _, buffCo in ipairs(lua_skill_buff.configList) do
		if buffCo.name == buffName then
			return self:getBuffTagNameByTypeId(buffCo.typeId)
		end
	end

	return ""
end

function CommonBuffTipController:getBuffTagNameByTypeId(typeId)
	local buffTypeCo = typeId and lua_skill_bufftype.configDict[typeId]
	local buffTagCO = buffTypeCo and lua_skill_buff_desc.configDict[buffTypeCo.type]

	if buffTagCO and buffTagCO.id ~= 9 then
		return buffTagCO.name
	end

	return ""
end

CommonBuffTipController.instance = CommonBuffTipController.New()

return CommonBuffTipController
