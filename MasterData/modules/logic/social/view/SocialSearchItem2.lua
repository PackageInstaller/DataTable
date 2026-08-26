-- chunkname: @modules/logic/social/view/SocialSearchItem2.lua

module("modules.logic.social.view.SocialSearchItem2", package.seeall)

local SocialSearchItem2 = class("SocialSearchItem2", SocialBaseItem)

function SocialSearchItem2:addEvents()
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
end

function SocialSearchItem2:removeEvents()
	self._btnadd:RemoveClickListener()
end

function SocialSearchItem2:_btnaddOnClick()
	SocialController.instance:AddFriend(self._mo.userId, self._addCallback, self)
end

function SocialSearchItem2:_addCallback(cmd, resultCode, msg)
	if resultCode == 0 or resultCode == -310 then
		self._mo:setAddedFriend()
		gohelper.setActive(self._btnadd.gameObject, false)
		gohelper.setActive(self._gosent, true)
	end
end

function SocialSearchItem2:updateBtnState()
	local isAdded = self._mo:isSendAddFriend()

	gohelper.setActive(self._btnadd.gameObject, not isAdded)
	gohelper.setActive(self._gosent, isAdded)
end

return SocialSearchItem2
