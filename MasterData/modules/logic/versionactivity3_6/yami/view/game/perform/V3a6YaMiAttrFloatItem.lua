-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiAttrFloatItem.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiAttrFloatItem", package.seeall)

local V3a6YaMiAttrFloatItem = class("V3a6YaMiAttrFloatItem", V3a6YaMiFloatItem)

function V3a6YaMiAttrFloatItem:init(go)
	V3a6YaMiAttrFloatItem.super.init(self, go)

	self._txtnum = gohelper.findChildText(self.go, "#txt_num")
	self._imgIcon = gohelper.findChildImage(self.go, "#txt_num/image_icon")
end

function V3a6YaMiAttrFloatItem:addEventListeners()
	return
end

function V3a6YaMiAttrFloatItem:removeEventListeners()
	return
end

function V3a6YaMiAttrFloatItem:_editableInitView()
	self._showTime = V3a6YaMiEnum.ShowAttrFloatTime
end

function V3a6YaMiAttrFloatItem:showAttrFloat(type, value, delayTime, callback, callbackObj)
	self.isShow = true

	local info = V3a6YaMiEnum.AttrInfo[type]

	UISpriteSetMgr.instance:setV3a6YaMiSprite(self._imgIcon, info.Icon)

	local lang = luaLang("v3a6_yami_add_value")

	self._txtnum.text = value > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(lang, value) or value

	self:setActive(false)

	self._callback = callback
	self._callbackObj = callbackObj

	TaskDispatcher.runDelay(self._delayShow, self, delayTime)
end

function V3a6YaMiAttrFloatItem:_delayShow()
	self:show()
	gohelper.setAsLastSibling(self.go)
	TaskDispatcher.runDelay(self._callback, self._callbackObj, 0.2)
end

function V3a6YaMiAttrFloatItem:onDestroy()
	V3a6YaMiAttrFloatItem.super.onDestroy(self)
	TaskDispatcher.cancelTask(self._delayShow, self)
	TaskDispatcher.cancelTask(self._callback, self._callbackObj)
end

return V3a6YaMiAttrFloatItem
