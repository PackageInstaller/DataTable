-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationKeywordItem.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationKeywordItem", package.seeall)

local VersionActivity2_3NewCultivationKeywordItem = class("VersionActivity2_3NewCultivationKeywordItem", RougeSimpleItemBase)

function VersionActivity2_3NewCultivationKeywordItem:ctor(ctorParam)
	self:__onInit()
	VersionActivity2_3NewCultivationKeywordItem.super.ctor(self, ctorParam)

	self._keywordTxtItemList = self:getUserDataTb_()
	self._keywordParentGoList = self:getUserDataTb_()
end

function VersionActivity2_3NewCultivationKeywordItem:onInitView()
	self._goKeyword = gohelper.findChild(self.viewGO, "#go_keyword")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationKeywordItem:_editableInitView()
	self:addKeyWordItem(self._goKeyword)
end

function VersionActivity2_3NewCultivationKeywordItem:addKeyWordItem(parentGo)
	table.insert(self._keywordParentGoList, parentGo)

	local txtKeyword = gohelper.findChildText(parentGo, "#txt_tag")

	table.insert(self._keywordTxtItemList, txtKeyword)
end

function VersionActivity2_3NewCultivationKeywordItem:refreshKeyword(keywordParam)
	local isEmpty = string.nilorempty(keywordParam)

	gohelper.setActive(self.viewGO, not isEmpty)

	if isEmpty then
		return
	end

	local keywords = string.split(keywordParam, "#")

	for index, keyword in ipairs(keywords) do
		local parentGo

		if not self._keywordParentGoList[index] then
			parentGo = gohelper.clone(self._goKeyword, self.viewGO, tostring(index))

			self:addKeyWordItem(parentGo)
		else
			parentGo = self._keywordParentGoList[index]
		end

		gohelper.setActive(parentGo, true)

		local txtItem = self._keywordTxtItemList[index]

		txtItem.text = keyword
	end

	local goCount = #self._keywordParentGoList
	local keywordCount = #keywords

	if keywordCount < goCount then
		for i = keywordCount + 1, goCount do
			gohelper.setActive(self._keywordParentGoList[i], false)
		end
	end
end

function VersionActivity2_3NewCultivationKeywordItem:onDestroyView()
	VersionActivity2_3NewCultivationKeywordItem.super.onDestroyView(self)
	self:__onDispose()
end

return VersionActivity2_3NewCultivationKeywordItem
