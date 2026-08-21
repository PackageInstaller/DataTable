-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/tips/HouseHeroTipsEffectItem.lua

module("logic.extensions.house.view.tips.HouseHeroTipsEffectItem", package.seeall)

local M = class("HouseHeroTipsEffectItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	return
end

function M:_buildUI()
	self._imgIcon = goutil.findChildImageComponent(self._mainGO, "imgBuffIcon")
	self._txtName = goutil.findChildTextComponent(self._mainGO, "txtBuffName")
	self._txtDesc = goutil.findChildTextComponent(self._mainGO, "txtDesc")
end

function M:getMainGO()
	return self._mainGO
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:setData(data)
	self:setVisible(true)

	self._txtName.text = data:getName()
	self._txtDesc.text = data:getDescriptionStr()

	data:setIcon(self._imgIcon)
end

return M
