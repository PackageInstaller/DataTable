-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationCampTipsView.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationCampTipsView", package.seeall)

local M = class("HandbookRelationCampTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._imgCampIcon = self:getImage("handbook_relationship_camp_tips_-1452740336")
	self._txtName = self:getText("handbook_relationship_camp_tips_-672512767")
	self._txtInfluenceZone = self:getText("handbook_relationship_camp_tips_-1033331600")
	self._scroll = self:getUIComponent("handbook_relationship_camp_tips_-721828417", UIComponentType.ScrollRect)
	self._goItem = self:getGo("handbook_relationship_camp_tips_-1038875269")

	goutil.setActive(self._goItem, false)
end

function M:destroyUI()
	self._imgCampIcon = nil
	self._txtName = nil
	self._txtInfluenceZone = nil
	self._scroll = nil
	self._goItem = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	local info = self:getFirstParam()

	self._campId = info.camp

	self:refreshView()
end

function M:onExit()
	return
end

function M:_getCampName(camp)
	return CommEnum.CampType2Name[camp]
end

function M:refreshView()
	local camp = self._campId

	self._txtName.text = self:_getCampName(camp)

	IconLoader.setSprite(self._imgCampIcon, IconType.BigCamp, string.format("camp_logo_30%s", camp))

	local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCampInfo, camp)

	if cfg then
		self._txtInfluenceZone.text = string.format("%s:%s", lang("tip_handbook_camp_title_1"), cfg.influenceZone)

		local index = 1

		index = self:_setDescItem(index, lang("tip_handbook_camp_title_2"), cfg.desc)
		index = self:_setDescItem(index, lang("tip_handbook_camp_title_3"), cfg.aim)
		index = self:_setDescItem(index, lang("tip_handbook_camp_title_4"), cfg.industry)
		index = self:_setDescItem(index, lang("tip_handbook_camp_title_5"), self:_getCampRelationContent(cfg))
	end

	self._scroll.verticalNormalizedPosition = 1
end

function M:_setDescItem(index, title, content)
	local rootTr = self._scroll.content.transform

	while rootTr.childCount < index + 1 do
		goutil.cloneAndSetParent(self._goItem, rootTr)
	end

	local tmpGo = rootTr:GetChild(index).gameObject
	local _title = goutil.findChildTextComponent(tmpGo, "txtTitle")
	local _content = goutil.findChildTextComponent(tmpGo, "txtDesc")

	_title.text = title
	_content.text = content

	goutil.setActive(tmpGo, true)

	return index + 1
end

function M:_getCampRelationContent(cfg)
	local lst_amity = cfg.amity
	local lst_hostile = cfg.hostile
	local len_amity = lst_amity and #lst_amity or 0
	local len_hostile = lst_hostile and #lst_hostile or 0

	if len_amity == 0 and len_hostile == 0 then
		return string.format("【%s】", lang("tip_handbook_camp_relation_1"))
	else
		local t = {}
		local amity = {}
		local hostile = {}

		for _, _camp in ipairs(cfg.amity or {}) do
			table.insert(amity, self:_getCampName(_camp))
		end

		for _, _camp in ipairs(cfg.hostile or {}) do
			table.insert(hostile, self:_getCampName(_camp))
		end

		if #amity > 0 then
			table.insert(t, string.format("%s：", lang("tip_handbook_camp_relation_2")))
			table.insert(t, table.concat(amity, "、"))
			table.insert(t, "\n")
		end

		if #hostile > 0 then
			table.insert(t, string.format("%s：", lang("tip_handbook_camp_relation_3")))
			table.insert(t, table.concat(hostile, "、"))
		end

		return table.concat(t)
	end
end

return M
