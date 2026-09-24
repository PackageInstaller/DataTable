-- chunkname: @modules/logic/college/view/role/CollegeRoleDispatchListItem.lua

module("modules.logic.college.view.role.CollegeRoleDispatchListItem", package.seeall)

local CollegeRoleDispatchListItem = class("CollegeRoleDispatchListItem", CollegeRoleBaseListItem)

function CollegeRoleDispatchListItem:onInitView()
	CollegeRoleDispatchListItem.super.onInitView(self)

	self._txtTeamNum = gohelper.findChildText(self.viewGO, "#go_TeamNum/#txt_TeamNum")
end

function CollegeRoleDispatchListItem:addEvents()
	CollegeRoleDispatchListItem.super.addEvents(self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.SelectCharacter, self._onSelectCharacter, self)
end

function CollegeRoleDispatchListItem:removeEvents()
	CollegeRoleDispatchListItem.super.removeEvents(self)
end

function CollegeRoleDispatchListItem:_btnClickOnClick()
	local isSelect = not self._isSelect

	if self._model:selectCell(self._index, isSelect) then
		CollegeController.instance:dispatchEvent(CollegeEvent.SelectCharacter, self._mo, isSelect)
	end
end

function CollegeRoleDispatchListItem:updateData(mo)
	CollegeRoleDispatchListItem.super.updateData(self, mo)

	self._inLocationMo = self._mo.inLocationStatus
	self._locationMo = self._view.viewParam.locationMo
	self._buildingId = self._locationMo and self._locationMo.id
	self._isDispatch = self._inLocationMo ~= nil
	self._isTendency = CollegeConfig.instance:isAnyEntryTendencyBuilding(self._mo.entries, self._buildingId)
	self._isLocation = self._isDispatch and self._inLocationMo == self._locationMo
end

function CollegeRoleDispatchListItem:refreshOtherUI()
	gohelper.setActive(self._goDispatch, self._isDispatch and not self._isLocation)
	gohelper.setActive(self._goLike, self._isTendency)
	gohelper.setActive(self._goInTeam, self._isLocation)
	self:refreshTeamNum()
end

function CollegeRoleDispatchListItem:refreshTeamNum()
	gohelper.setActive(self._goTeamNum, false)

	local isBatch = self._model:isInBatch()

	if isBatch then
		local selectList = self._view:getSelectList()
		local selectIndex = tabletool.indexOf(selectList, self._mo)
		local showTeamIndex = selectIndex and selectIndex ~= 0

		if showTeamIndex then
			self._txtTeamNum.text = selectIndex

			gohelper.setActive(self._goTeamNum, true)
		end
	end
end

function CollegeRoleDispatchListItem:_onSelectCharacter()
	self:refreshTeamNum()
end

return CollegeRoleDispatchListItem
