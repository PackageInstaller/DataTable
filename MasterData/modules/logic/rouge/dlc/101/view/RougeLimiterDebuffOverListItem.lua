-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterDebuffOverListItem.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffOverListItem", package.seeall)

local RougeLimiterDebuffOverListItem = class("RougeLimiterDebuffOverListItem", ListScrollCellExtend)

function RougeLimiterDebuffOverListItem:onInitView()
	self._imagedebufficon = gohelper.findChildImage(self.viewGO, "#image_debufficon")
	self._txtbufflevel = gohelper.findChildText(self.viewGO, "#txt_bufflevel")
	self._txtdec = gohelper.findChildText(self.viewGO, "#txt_dec")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
end

function RougeLimiterDebuffOverListItem:addEvents()
	return
end

function RougeLimiterDebuffOverListItem:removeEvents()
	return
end

function RougeLimiterDebuffOverListItem:onUpdateMO(mo)
	self._config = mo
	self._txtbufflevel.text = GameUtil.getRomanNums(self._config.level)
	self._txtname.text = self._config and self._config.title
	self._txtdec.text = self._config and self._config.desc

	local limiterGroupCo = RougeDLCConfig101.instance:getLimiterGroupCo(self._config.group)
	local icon = limiterGroupCo and limiterGroupCo.icon

	UISpriteSetMgr.instance:setRouge4Sprite(self._imagedebufficon, icon)
end

function RougeLimiterDebuffOverListItem:onDestroyView()
	return
end

return RougeLimiterDebuffOverListItem
