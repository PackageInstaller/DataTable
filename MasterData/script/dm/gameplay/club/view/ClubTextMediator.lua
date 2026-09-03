-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubTextMediator.lua

ClubTextMediator = class("ClubTextMediator", DmAreaViewMediator, _M)

ClubTextMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubTextMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

function ClubTextMediator:initialize()
	super.initialize(self)
end

function ClubTextMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function ClubTextMediator:disposeView()
	self._viewCache = nil
end

function ClubTextMediator:userInject()
	return
end

function ClubTextMediator:onRegister()
	super.onRegister(self)
end

function ClubTextMediator:enterWithData(data)
	self:initNodes()
	self:createData()
	self:refreshData(data)
	self:refreshView()
end

function ClubTextMediator:createData()
	self._player = self._developSystem:getPlayer()
	self._clubSystem = self._developSystem:getClubSystem()
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
end

function ClubTextMediator:refreshData(data)
	return
end

function ClubTextMediator:refreshView()
	return
end

function ClubTextMediator:initNodes()
	return
end

function ClubTextMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
		cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
	end
end
