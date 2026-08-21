-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberEntryItem.lua

module("logic.extensions.chamber.view.ChamberEntryItem", package.seeall)

local M = class("ChamberEntryItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._txtPositiveName = goutil.findChildTextComponent(self._mainGO, "txtPositiveName")
	self._txtPositiveContent = goutil.findChildTextComponent(self._mainGO, "txtPositiveContent")
	self._txtNegativeName = goutil.findChildTextComponent(self._mainGO, "txtNegativeName")
	self._txtNegativeContent = goutil.findChildTextComponent(self._mainGO, "txtNegativeContent")
	self._goProgress = goutil.findChild(self._mainGO, "objProgress")
	self._imgProgress = goutil.findChildImageComponent(self._goProgress, "imgProgress")
	self._txtProgress = goutil.findChildTextComponent(self._goProgress, "txtProgress")
end

function M:OnDestroy()
	return
end

function M:setEntryCO(CO, showProgress)
	goutil.setActive(self._txtPositiveName.gameObject, CO:isPositive())
	goutil.setActive(self._txtPositiveContent.gameObject, CO:isPositive())
	goutil.setActive(self._txtNegativeName.gameObject, not CO:isPositive())
	goutil.setActive(self._txtNegativeContent.gameObject, not CO:isPositive())

	self._txtPositiveName.text = CO:getName()
	self._txtPositiveContent.text = CO:getDesc()
	self._txtNegativeName.text = CO:getName()
	self._txtNegativeContent.text = CO:getDesc()

	if showProgress and CO:getProgress() > 0 then
		goutil.setActive(self._goProgress, true)

		self._imgProgress.fillAmount = CO:getCount() / CO:getProgress()
		self._txtProgress.text = string.format("(%s/%s)", CO:getCount(), CO:getProgress())
	else
		goutil.setActive(self._goProgress, false)
	end
end

return M
