-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaInfoItem.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaInfoItem", package.seeall)

local NuoDiKaInfoItem = class("NuoDiKaInfoItem", LuaCompBase)

function NuoDiKaInfoItem:init(go, itemType)
	self.go = go
	self._txtname = gohelper.findChildText(go, "txt_namecn")
	self._txtdesc = gohelper.findChildText(go, "txt_desc")
	self._goicon = gohelper.findChild(go, "go_icon")
	self._simageicon = gohelper.findChildSingleImage(go, "go_icon/image_icon")
	self._gonew = gohelper.findChild(go, "go_icon/go_new")
	self._type = itemType

	gohelper.setActive(self._gonew, false)
end

function NuoDiKaInfoItem:setItem(co)
	gohelper.setActive(self.go, true)

	self._config = co
	self._txtname.text = self._config.name
	self._txtdesc.text = self._config.desc

	if self._type == NuoDiKaEnum.EventType.Enemy then
		self._simageicon:LoadImage(ResUrl.getNuoDiKaMonsterIcon(self._config.picture))
	elseif self._type == NuoDiKaEnum.EventType.Item then
		self._simageicon:LoadImage(ResUrl.getNuoDiKaItemIcon(self._config.picture))
	end
end

function NuoDiKaInfoItem:hide()
	gohelper.setActive(self.go, false)
end

function NuoDiKaInfoItem:destory()
	self._simageicon:UnLoadImage()
end

return NuoDiKaInfoItem
