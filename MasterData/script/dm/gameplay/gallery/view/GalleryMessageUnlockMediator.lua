-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryMessageUnlockMediator.lua

GalleryMessageUnlockMediator = class("GalleryMessageUnlockMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {
	touchLayer = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickClose"
	}
}

function GalleryMessageUnlockMediator:initialize()
	super.initialize(self)
end

function GalleryMessageUnlockMediator:dispose()
	super.dispose(self)
end

function GalleryMessageUnlockMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function GalleryMessageUnlockMediator:enterWithData(data)
	self._id = data.unlockId

	self:setupView()
end

function GalleryMessageUnlockMediator:setupView()
	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setVisible(true)

	self._main = self:getView():getChildByFullName("main")

	local bgHero = self._main:getChildByFullName("bgHero")
	local messageConfig = ConfigReader:getRecordById("InfoBase", self._id)
	local path = "asset/scene/galleryMessage/" .. messageConfig.SmallPic .. ".jpg"

	bgHero:loadTexture(path)

	local Desc = messageConfig.Desc
	local messageInfo = self._main:getChildByFullName("messageInfo")

	messageInfo:setString(Strings:get(Desc))
end

function GalleryMessageUnlockMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
