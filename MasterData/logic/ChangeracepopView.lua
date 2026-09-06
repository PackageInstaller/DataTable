-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/ChangeracepopView.lua

module("logic.extensions.formation.view.ChangeracepopView", package.seeall)

local ChangeracepopView = class("ChangeracepopView", ViewComponent)

function ChangeracepopView:ctor()
	ChangeracepopView.super.ctor(self)
end

function ChangeracepopView:unbindEvents()
	ChangeracepopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeButton)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)

	for i, cell in ipairs(self._cellList) do
		GameUtil.rmClickHandler(cell)
	end
end

function ChangeracepopView:bindEvents()
	ChangeracepopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeButton, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	for i, cell in ipairs(self._cellList) do
		GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, i))
	end
end

function ChangeracepopView:buildUI()
	ChangeracepopView.super.buildUI(self)

	self._closeButton = self:getGo("btnClose")
	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")

	local RaceFilterGo = self:getGo("right/RaceFilter")

	self._cellList = {}

	for i = 1, 7 do
		local cell = self:getGo("right/RaceFilter/Cell" .. i)

		table.insert(self._cellList, cell)
	end
end

function ChangeracepopView:onExit()
	ChangeracepopView.super.onExit(self)

	self._formationMo = nil

	GlobalDispatcher:dispatch(GlobalNotify.FormationHeroSkillChanged)
end

function ChangeracepopView:onEnter()
	ChangeracepopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._formationMo = params[1]
	self._petMo = params[2]

	if not self._formationMo or not self._petMo then
		self:close()

		return
	end

	self._selectIdx = GameEnum.RaceType.Yuan

	local type = BagModel.instance:getYuanRaceTypeChange(self._petMo.petId)

	if not string.nilorempty(type) then
		self._selectIdx = GameEnum.Races[type]
	end

	local map = self._formationMo:getCurElementRelationMap() or {}
	local idx = checknumber(map[self._petMo.petId])

	if idx > 0 then
		self._selectIdx = idx
	else
		local changeRaceTypes = self._formationMo:GetChangeRaceTypes() or {}

		for i, v in pairs(changeRaceTypes) do
			if v.petId == self._petMo.petId then
				self._selectIdx = GameEnum.Races[v.raceType]

				break
			end
		end
	end

	self:_updateSelect()
end

function ChangeracepopView:_onClickCell(i)
	self._selectIdx = self._selectIdx == i and GameEnum.RaceType.Yuan or i

	self:_updateSelect()
end

function ChangeracepopView:_updateSelect()
	for i, cell in ipairs(self._cellList) do
		local mark = goutil.findChild(cell, "Mark")

		GameUtil.SetActive(mark, i == self._selectIdx)
	end
end

function ChangeracepopView:_onClickSure()
	local raceType = ""

	for k, v in pairs(GameEnum.Races) do
		if v == self._selectIdx then
			raceType = k

			break
		end
	end

	self._formationMo:updateChangeRaceTypes(self._petMo.petId, raceType)

	if self._petMo.isMyPackPet then
		BagModel.instance:setYuanRaceTypeChange(self._petMo.petId, raceType)
	end

	self:close()
end

return ChangeracepopView
