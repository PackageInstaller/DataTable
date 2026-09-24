-- chunkname: @modules/logic/character/view/CharacterRank.lua

module("modules.logic.character.view.CharacterRank", package.seeall)

local CharacterRank = class("CharacterRank", RougeSimpleItemBase)

function CharacterRank:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRank:addEvents()
	return
end

function CharacterRank:removeEvents()
	return
end

function CharacterRank.s_create(Self, srcGo, baseViewContainer)
	local item = CharacterRank.New({
		parent = Self,
		baseViewContainer = baseViewContainer
	})

	item:init(srcGo)

	return item
end

function CharacterRank.s_createByView(Self, srcGo)
	return (CharacterRank.s_create(Self, srcGo, Self.viewContainer))
end

function CharacterRank.s_createByListScrollCellExtend(Self, srcGo)
	local scrollView = Self._view

	if scrollView then
		return (CharacterRank:s_create(srcGo, scrollView.viewContainer or Self.viewContainer))
	end
end

function CharacterRank:ctor(...)
	CharacterRank.super.ctor(self, ...)
end

function CharacterRank:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_imgList")
	GameUtil.onDestroyViewMember(self, "_rankObjEmpty")
	CharacterRank.super.onDestroyView(self)
end

function CharacterRank:_getUserDataTb_imgRank()
	local list = self:getUserDataTb_()
	local goPathFmt = "rank%s"
	local i = 0

	repeat
		i = i + 1

		local go = gohelper.findChild(self.viewGO, string.format(goPathFmt, i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			table.insert(list, go:GetComponent(gohelper.Type_Image))
			gohelper.setActive(go, false)
		end
	until isNil

	return list
end

function CharacterRank:_editableInitView()
	CharacterRank.super._editableInitView(self)

	self._imgList = self:_getUserDataTb_imgRank()
end

function CharacterRank:bindRankEmpty(optObjCharacterRank)
	self:_bindObjImpl(CharacterRank, "_rankObjEmpty", optObjCharacterRank)

	return self
end

function CharacterRank:setData(mo)
	CharacterRank.super.setData(self, mo)
	self:setActiveRank(mo.rank)

	return self
end

function CharacterRank:setActiveRank(targetRank)
	for i, cmp in ipairs(self._imgList) do
		gohelper.setActive(cmp, i == targetRank - 1)
	end

	if self._rankObjEmpty then
		self._rankObjEmpty:setActiveRank(targetRank)
	end
end

function CharacterRank:setColorRank(hexColor)
	for i, cmp in ipairs(self._imgList) do
		UIColorHelper.set(cmp, hexColor)
	end

	if self._rankObjEmpty then
		self._rankObjEmpty:setColorRank(hexColor)
	end
end

return CharacterRank
