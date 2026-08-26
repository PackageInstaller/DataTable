-- chunkname: @modules/logic/character/model/CharacterBackpackCardListModel.lua

module("modules.logic.character.model.CharacterBackpackCardListModel", package.seeall)

local CharacterBackpackCardListModel = class("CharacterBackpackCardListModel", ListScrollModel)

function CharacterBackpackCardListModel:ctor()
	CharacterBackpackCardListModel.super.ctor(self)

	self._characterFirstToShow = nil
end

function CharacterBackpackCardListModel:updateModel()
	self.moList = self.moList or {}

	self:setList(self.moList)
end

function CharacterBackpackCardListModel:setFirstShowCharacter(id)
	self._characterFirstToShow = id
end

function CharacterBackpackCardListModel:_doCharacterFirst(list)
	if not self._characterFirstToShow then
		return
	end

	for i, v in ipairs(list) do
		if v.heroId == self._characterFirstToShow then
			table.remove(list, i)
			table.insert(list, 1, v)

			break
		end
	end
end

function CharacterBackpackCardListModel:setCharacterCardList(Infos)
	self.moList = Infos or {}

	self:_doCharacterFirst(self.moList)
	self:setList(self.moList)
end

function CharacterBackpackCardListModel:getCharacterCardList()
	return self:getList()
end

function CharacterBackpackCardListModel:setCharacterViewDragMOList(moList)
	moList = moList or self.moList
	self.characterViewDragMOList = {}

	if not moList then
		return
	end

	for i, mo in ipairs(moList) do
		table.insert(self.characterViewDragMOList, mo)
	end
end

function CharacterBackpackCardListModel:getNextCharacterCard(id)
	local mo

	if self.characterViewDragMOList then
		for k, v in ipairs(self.characterViewDragMOList) do
			if v.heroId == id then
				return k ~= #self.characterViewDragMOList and self.characterViewDragMOList[k + 1] or self.characterViewDragMOList[1]
			end
		end
	end
end

function CharacterBackpackCardListModel:getLastCharacterCard(id)
	local mo

	if self.characterViewDragMOList then
		for k, v in pairs(self.characterViewDragMOList) do
			if v.heroId == id then
				return k ~= 1 and self.characterViewDragMOList[k - 1] or self.characterViewDragMOList[#self.characterViewDragMOList]
			end
		end
	end
end

function CharacterBackpackCardListModel:clearCardList()
	self.moList = nil

	self:clear()
end

CharacterBackpackCardListModel.instance = CharacterBackpackCardListModel.New()

return CharacterBackpackCardListModel
