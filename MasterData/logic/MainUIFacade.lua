-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/facade/MainUIFacade.lua

module("logic.extensions.mainui.facade.MainUIFacade", package.seeall)

local MainUIFacade = class("MainUIFacade", BaseFacade)

function MainUIFacade:ctor()
	self._isActivityHided = false
	self._isFuncPushLocked = false
	self._showDropEffFuncIds = {}
	self._needCheckFunc = true
	self._needShowPetGuide = false
end

function MainUIFacade:setNeedShowPetGuide(isGuide)
	self._needShowPetGuide = isGuide
end

function MainUIFacade:getNeedShowPetGuide()
	return self._needShowPetGuide
end

function MainUIFacade:SetActivity(activity)
	self._isActivityHided = activity
end

function MainUIFacade:GetActivity()
	return self._isActivityHided
end

function MainUIFacade:getNeedCheckFunc()
	return self._needCheckFunc
end

function MainUIFacade:setNeedCheckFunc(val)
	self._needCheckFunc = val
end

MainUIFacade.instance = MainUIFacade.New()

return MainUIFacade
