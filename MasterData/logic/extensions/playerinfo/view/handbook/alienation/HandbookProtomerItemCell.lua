-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/alienation/HandbookProtomerItemCell.lua

module("logic.extensions.playerinfo.view.handbook.alienation.HandbookProtomerItemCell", package.seeall)

local M = class("HandbookProtomerItemCell", UIReusableLuaBehavior)

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "holding_icon")
	self._goEmptyMark = goutil.findChild(self.mainGO, "empty").gameObject
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._goNewSignMark = goutil.findChild(self.mainGO, "newSign").gameObject
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "click").gameObject)
end

function M:destroyUI()
	self:setHandler(nil)

	self._imgIcon = nil
	self._goEmptyMark = nil
	self._txtName = nil
	self._goNewSignMark = nil
	self._btnClick = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self:setHandler(nil)
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:_onClickSelf()
	local handler = self:getHandler()

	if handler then
		handler:onCellClick(self)
	end

	if self:getIsNew() then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.Protomer, self._id, true)
		self:setNewMark(false)
	end
end

function M:setData(cfgData)
	local isLock = not GalleryModel.instance:getIsUnLock(self:getGalleryTypeEnum(), cfgData.id)

	if self:getId() ~= cfgData.id then
		if not isLock then
			self:_updateShow(cfgData.id)
		end

		self._txtName.text = ContainmentUtil.getProtomerName(cfgData.id)
	elseif not isLock and self:getIsLock() ~= isLock then
		self:_updateShow(cfgData.id)
	end

	self:setLock(isLock)

	if isLock then
		self:_updateShow(nil)
	end

	self._id = cfgData.id

	self:setNewMark(GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Protomer, self._id))
end

function M:_updateShow(protomerId)
	ContainmentUtil.setProtomerDynIcon(self._imgIcon, protomerId)
end

function M:setLock(lock)
	self._isLock = lock

	goutil.setActive(self._goEmptyMark, lock)
end

function M:getIsLock()
	return self._isLock
end

function M:setNewMark(show)
	self._isNew = show

	goutil.setActive(self._goNewSignMark, show)
end

function M:getIsNew()
	return self._isNew
end

function M:getId()
	return self._id or -1
end

function M:getGalleryTypeEnum()
	return GameEnum.UnlockTypeEnum.Protomer
end

return M
