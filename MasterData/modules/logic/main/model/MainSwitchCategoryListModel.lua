-- chunkname: @modules/logic/main/model/MainSwitchCategoryListModel.lua

module("modules.logic.main.model.MainSwitchCategoryListModel", package.seeall)

local MainSwitchCategoryListModel = class("MainSwitchCategoryListModel", ListScrollModel)

function MainSwitchCategoryListModel:setCategoryId(id)
	self.categoryId = id

	self:onModelUpdate()
end

function MainSwitchCategoryListModel:getCategoryId()
	return self.categoryId
end

function MainSwitchCategoryListModel:initCategoryList(id)
	self.categoryId = id or MainEnum.SwitchType.Character

	local list = {
		{
			id = MainEnum.SwitchType.Character
		},
		{
			id = MainEnum.SwitchType.Scene
		}
	}

	if FightUISwitchModel.instance:isOpenFightUISwitchSystem() then
		table.insert(list, {
			id = MainEnum.SwitchType.FightUI
		})
	end

	self:setList(list)
end

MainSwitchCategoryListModel.instance = MainSwitchCategoryListModel.New()

return MainSwitchCategoryListModel
