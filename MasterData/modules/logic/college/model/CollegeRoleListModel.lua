-- chunkname: @modules/logic/college/model/CollegeRoleListModel.lua

module("modules.logic.college.model.CollegeRoleListModel", package.seeall)

local CollegeRoleListModel = class("CollegeRoleListModel", ListScrollModel)
local DefaultSelectIndex = 1

function CollegeRoleListModel:initList(selectMo)
	local characterBox = CollegeModel.instance:getSceneMo().characterBox
	local characters = {}

	tabletool.addValues(characters, characterBox and characterBox.characters)
	table.sort(characters, self._characterSortFunc)
	self:setList(characters)

	local selectIndex = self:getIndex(selectMo) or DefaultSelectIndex

	self:selectCell(selectIndex, true)
end

function CollegeRoleListModel:refreshList()
	local selectMo = self:getByIndex(self._selectIndex) or self:getByIndex(DefaultSelectIndex)

	self:initList(selectMo)
	self:onModelUpdate()
end

function CollegeRoleListModel._characterSortFunc(aRoleMo, bRoleMo)
	local aCo = aRoleMo.co
	local bCo = bRoleMo.co

	if aCo then
		if not aCo.rarity then
			local aRarity = 0

			if bCo then
				if not bCo.rarity then
					local bRarity = 0

					if aRarity ~= bRarity then
						return bRarity < aRarity
					end

					local aLevel = aRoleMo.level
					local bLevel = bRoleMo.level

					if aLevel ~= bLevel then
						return bLevel < aLevel
					end

					if aCo then
						if not aCo.id then
							local aId = 0

							if bCo then
								if not bCo.id then
									local bId = 0

									if aId ~= bId then
										return aId < bId
									end

									return aRoleMo.uid < bRoleMo.uid
								end
							end
						end
					end
				end
			end
		end
	end
end

function CollegeRoleListModel:addList(list)
	tabletool.addValues(self._list, list)
end

function CollegeRoleListModel:getById(id)
	logError("废弃方法，不可使用！！！")
end

function CollegeRoleListModel:selectCell(index, isSelect)
	self._selectIndex = isSelect and index or nil

	CollegeRoleListModel.super.selectCell(self, index, isSelect)
end

CollegeRoleListModel.instance = CollegeRoleListModel.New()

return CollegeRoleListModel
