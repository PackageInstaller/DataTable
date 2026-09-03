-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceRegistRankCell.lua

PetRaceRegistRankCell = class("PetRaceRegistRankCell", DmBaseUI)

local kBtnHandlers = {
	Image_bg = "onShowRoleInfo"
}

function PetRaceRegistRankCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceRegistRankCell:update(data, index, clickCallBack)
	self._clickCallBack = clickCallBack

	self._text_name:setString(data.name or "")
	self._text_club:setString(data.clubName or "")
	self._node_icon:removeAllChildren()

	if data.headId then
		local headIcon = IconFactory:createPlayerIcon({
			clipType = 4,
			id = data.headId,
			size = self._node_icon:getContentSize()
		})

		headIcon:addTo(self._node_icon):center(self._node_icon:getContentSize())
	end
end

function PetRaceRegistRankCell:intiView()
	self._text_name = self:getView():getChildByName("Text_name")
	self._text_club = self:getView():getChildByName("Text_club")
	self._node_icon = self:getView():getChildByName("Node_icon")

	local image_bg = self:getView():getChildByName("Image_bg")

	image_bg:setSwallowTouches(false)
end

function PetRaceRegistRankCell:onShowRoleInfo()
	if self._clickCallBack then
		self._clickCallBack()
	end
end
