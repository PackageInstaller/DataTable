-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpAllPetView.lua

module("logic.extensions.expedition.view.ExpAllPetView", package.seeall)

local ExpAllPetView = class("ExpAllPetView", FormationRightView)

function ExpAllPetView:ctor()
	ExpAllPetView.super.ctor(self)

	self._disableDrag = true
end

function ExpAllPetView:destroyUI()
	ExpAllPetView.super.destroyUI(self)
end

function ExpAllPetView:onExitFinished()
	ExpAllPetView.super.onExitFinished(self)
end

function ExpAllPetView:onEnterFinished()
	ExpAllPetView.super.onEnterFinished(self)
end

function ExpAllPetView:unbindEvents()
	self:_unbindUIEvents()
	self._closeButton:RemoveClickListener()
	self._bgMaskButton:RemoveClickListener()
end

function ExpAllPetView:bindEvents()
	self:_bindUIEvents()
	self._bgMaskButton:AddClickListener(self._onClickClose, self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ExpAllPetView:onExit()
	ExpAllPetView.super.onExit(self)
	self._tableview:Travel(function(cell)
		ItemPet.Remove(cell.gameObject)
	end, nil)
end

function ExpAllPetView:buildUI()
	ExpAllPetView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._bgMaskButton = self:getBtn("bgMask")
end

function ExpAllPetView:onEnter()
	ExpeditionFmtModel.instance:checkPetsDead()
	ExpAllPetView.super.onEnter(self)
	self._tableview:ReloadData()
end

function ExpAllPetView:_onClickClose()
	self:close()
end

function ExpAllPetView:_updateCell(view, cell, data)
	data.isDead = ExpeditionModel.instance:isPetDead(data.petId)

	local component = ItemPet.AddOnce(cell.gameObject)

	self:updateForbit(data)
	component:Init(data)
	component:setSelected(false)

	local inTeamId = ExpeditionFmtModel.instance:getPetIdInTeamByRaceId(data.raceId)

	component:SetInTeam(inTeamId == data.petId)
	component:removeAllListener(ItemPet.Events.Click)
	component:addListener(ItemPet.Events.Click, function(data)
		self:_onClickPet(data, cell)
	end)
end

function ExpAllPetView:updateForbit(data)
	local inTeamId = ExpeditionFmtModel.instance:getPetIdInTeamByRaceId(data.raceId)
	local petStateData = ExpeditionModel.instance:getPetState(data.petId)

	data:setPetForbit(checknumber(inTeamId) > 0 and inTeamId ~= data.petId or (petStateData or nil) and petStateData.hpRate <= 0)
end

function ExpAllPetView:_RefreshPetList()
	self._curViewDatas = {}

	local pets = ExpeditionFmtModel.instance:getAllPets()

	table.walk(pets, function(v, k)
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end)
	self:rankNow()
end

function ExpAllPetView:rankNow()
	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = ExpeditionController.instance:getExpedSortParams()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function ExpAllPetView:_onClickPet(data)
	CommonTipsMgr.instance:showPetTips(data)
end

return ExpAllPetView
