-- chunkname: @modules/logic/survival/view/shelter/ShelterNpcManagerView.lua

module("modules.logic.survival.view.shelter.ShelterNpcManagerView", package.seeall)

local ShelterNpcManagerView = class("ShelterNpcManagerView", BaseView)

function ShelterNpcManagerView:onInitView()
	self.goItem = gohelper.findChild(self.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_Item")
	self.goSmallItem = gohelper.findChild(self.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_SmallItem")

	gohelper.setActive(self.goItem, false)
	gohelper.setActive(self.goSmallItem, false)

	self.goFilter = gohelper.findChild(self.viewGO, "Panel/Left/#btn_filter")
end

function ShelterNpcManagerView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, self.onNpcPostionChange, self)
end

function ShelterNpcManagerView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, self.onNpcPostionChange, self)
end

function ShelterNpcManagerView:onNpcPostionChange()
	self:refreshView()
end

function ShelterNpcManagerView:onOpen()
	self:refreshFilter()
	self:refreshView()
end

function ShelterNpcManagerView:refreshView()
	self:refreshList()
	self:refreshInfoView()
end

function ShelterNpcManagerView:refreshList()
	SurvivalShelterNpcListModel.instance:refreshList(self._filterList)
end

function ShelterNpcManagerView:refreshFilter()
	local filterComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goFilter, SurvivalFilterPart)
	local filterOptions = {}
	local list = lua_survival_tag_type.configList

	for i, v in ipairs(list) do
		table.insert(filterOptions, {
			desc = v.name,
			type = v.id
		})
	end

	filterComp:setOptionChangeCallback(self._onFilterChange, self)
	filterComp:setOptions(filterOptions)
end

function ShelterNpcManagerView:_onFilterChange(filterList)
	self._filterList = filterList

	self:refreshView()
end

function ShelterNpcManagerView:refreshInfoView()
	if not self.infoView then
		local prefabRes = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes.infoView)
		local parentGO = gohelper.findChild(self.viewGO, "Panel/Right/go_manageinfo")

		self.infoView = ShelterManagerInfoView.getView(prefabRes, parentGO, "infoView")
	end

	local param = {}

	param.showType = SurvivalEnum.InfoShowType.Npc
	param.showId = SurvivalShelterNpcListModel.instance:getSelectNpc()

	self.infoView:refreshParam(param)
end

function ShelterNpcManagerView:onClose()
	return
end

return ShelterNpcManagerView
