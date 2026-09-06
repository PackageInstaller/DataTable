-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/data/GdcCardMo.lua

module("logic.extensions.goddesscontest.data.GdcCardMo", package.seeall)

local GdcCardMo = class("GdcCardMo")

function GdcCardMo:ctor()
	self.cardId = -1
	self._cardType = GdcCardEnum.CardType_Empty
	self._isWith = false
	self._value = 0
	self._isShowValue = false
	self._posId = 0
end

function GdcCardMo:onReset()
	self._cardType = GdcCardEnum.CardType_Empty
	self._isWith = false
	self._value = 0
	self._isShowValue = false
	self._posId = 0
end

function GdcCardMo:getCardType()
	return self._cardType
end

function GdcCardMo:setCardType(value)
	self._cardType = value
end

function GdcCardMo:isWith()
	return self._isWith
end

function GdcCardMo:setIsWith(value)
	self._isWith = value
end

function GdcCardMo:getValue()
	return self._value
end

function GdcCardMo:setValue(value)
	self._value = value
end

function GdcCardMo:isShowValue()
	return self._isShowValue
end

function GdcCardMo:setIsShowValue(value)
	self._isShowValue = value
end

function GdcCardMo:getPosId()
	return self._posId
end

function GdcCardMo:setPosId(value)
	self._posId = value
end

return GdcCardMo
