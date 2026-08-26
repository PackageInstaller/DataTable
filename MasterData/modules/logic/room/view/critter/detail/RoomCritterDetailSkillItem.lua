-- chunkname: @modules/logic/room/view/critter/detail/RoomCritterDetailSkillItem.lua

module("modules.logic.room.view.critter.detail.RoomCritterDetailSkillItem", package.seeall)

local RoomCritterDetailSkillItem = class("RoomCritterDetailSkillItem", LuaCompBase)

function RoomCritterDetailSkillItem:onInitView()
	self._txtskillname = gohelper.findChildText(self.viewGO, "title/#txt_skillname")
	self._imageicon = gohelper.findChildImage(self.viewGO, "title/#txt_skillname/#image_icon")
	self._txtskilldec = gohelper.findChildText(self.viewGO, "#txt_skilldec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterDetailSkillItem:addEvents()
	return
end

function RoomCritterDetailSkillItem:removeEvents()
	return
end

function RoomCritterDetailSkillItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function RoomCritterDetailSkillItem:addEventListeners()
	self:addEvents()
end

function RoomCritterDetailSkillItem:removeEventListeners()
	self:removeEvents()
end

function RoomCritterDetailSkillItem:_editableInitView()
	return
end

function RoomCritterDetailSkillItem:onUpdateParam()
	return
end

function RoomCritterDetailSkillItem:onOpen()
	return
end

function RoomCritterDetailSkillItem:onClose()
	return
end

function RoomCritterDetailSkillItem:onDestroyView()
	return
end

function RoomCritterDetailSkillItem:onRefreshMo(tagCo)
	self._txtskillname.text = tagCo and tagCo.name
	self._txtskilldec.text = tagCo and tagCo.desc

	if self._imageicon and not string.nilorempty(tagCo.skillIcon) then
		UISpriteSetMgr.instance:setCritterSprite(self._imageicon, tagCo.skillIcon)
	end
end

return RoomCritterDetailSkillItem
