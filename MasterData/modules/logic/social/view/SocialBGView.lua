-- chunkname: @modules/logic/social/view/SocialBGView.lua

module("modules.logic.social.view.SocialBGView", package.seeall)

local SocialBGView = class("SocialBGView", BaseView)

function SocialBGView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialBGView:addEvents()
	return
end

function SocialBGView:removeEvents()
	return
end

function SocialBGView:_editableInitView()
	return
end

function SocialBGView:onUpdateParam()
	return
end

function SocialBGView:onOpen()
	return
end

function SocialBGView:onClose()
	return
end

function SocialBGView:onDestroyView()
	return
end

return SocialBGView
