-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceCostCell.lua

PetRaceCostCell = class("PetRaceCostCell", DmBaseUI)

local kBtnHandlers = {}

function PetRaceCostCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceCostCell:update(data, index)
	self._title:setString(data.desStr or "")

	self._data = data

	if data._selectRaceType == data.cellType then
		self._image_bg_1:setVisible(false)
		self._image_bg_2:setVisible(true)
	else
		self._image_bg_1:setVisible(true)
		self._image_bg_2:setVisible(false)
	end
end

function PetRaceCostCell:intiView()
	self._title = self:getView():getChildByName("Text_des")
	self._text_cost = self:getView():getChildByName("Text_cost")
	self._image_bg_1 = self:getView():getChildByName("Image_bg_1")
	self._image_bg_2 = self:getView():getChildByName("Image_bg_2")
	self._panel_touch = self:getView():getChildByName("Panel_touch")

	self._panel_touch:setTouchEnabled(true)
	self._panel_touch:setSwallowTouches(false)
	self._panel_touch:addClickEventListener(function()
		if self._data and self._data.touchCallBack then
			self._data:touchCallBack()
		end
	end)
end
