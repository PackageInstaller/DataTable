-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_IllustrationDetailAttributeItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_IllustrationDetailAttributeItem", package.seeall)

local Rouge2_IllustrationDetailAttributeItem = class("Rouge2_IllustrationDetailAttributeItem", LuaCompBase)

function Rouge2_IllustrationDetailAttributeItem:init(go)
	self.go = go
	self._gounlock = gohelper.findChild(self.go, "#go_unlock")
	self._txtunlock = gohelper.findChildText(self.go, "#go_unlock/#txt_unlock")
	self._imageeventIcon = gohelper.findChildImage(self.go, "#go_unlock/#txt_unlock/#image_eventIcon")
	self._golock = gohelper.findChild(self.go, "#go_lock")
	self._txtlock = gohelper.findChildText(self.go, "#go_lock/#txt_lock")
	self._imageicon = gohelper.findChildImage(self.go, "#go_lock/#txt_lock/#image_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_IllustrationDetailAttributeItem:_editableInitView()
	return
end

function Rouge2_IllustrationDetailAttributeItem:setActive(active)
	gohelper.setActive(self.go, active)
end

function Rouge2_IllustrationDetailAttributeItem:setInfo(param)
	self.param = param
	self.attributeId = param[1]
	self.attributeNum = param[2]

	local attributeConfig = lua_rouge2_attribute.configDict[self.attributeId]

	if attributeConfig == nil then
		logError("attributeConfig is nil id: " .. self.attributeId)
		self:setActive(false)

		return
	end

	local isUnlock = true

	gohelper.setActive(self._golock, not isUnlock)
	gohelper.setActive(self._gounlock, isUnlock)

	if isUnlock then
		Rouge2_IconHelper.setAttributeIcon(self.attributeId, self._imageeventIcon)

		self._txtunlock.text = tostring(self.attributeNum)
	else
		Rouge2_IconHelper.setAttributeIcon(self.attributeId, self._imageicon)

		self._txtunlock.text = luaLang("rouge2_illustration_choice_unlock")
	end
end

function Rouge2_IllustrationDetailAttributeItem:onDestroy()
	return
end

return Rouge2_IllustrationDetailAttributeItem
