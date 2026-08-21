-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUIActBannerItemCell.lua

module("logic.extensions.mainui.view.MainUIActBannerItemCell", package.seeall)

local M = class("MainUIActBannerItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local imageGo = goutil.findChild(mainGO.gameObject, "Image")

	self._imageBig = UIComponentType.ImageBigBG(imageGo.gameObject)
	self._button = UIComponentType.ButtonAdapter(mainGO.gameObject)
end

function M:bindEvents()
	self._button:AddClickListener(self._onClickJump, self)
end

function M:unbindEvents()
	self._button:RemoveClickListener()
end

function M:getMainGo()
	return self.mainGO
end

function M:updateData(banmo)
	self._id = banmo:getId()
	self._jumpId = banmo:getJumpId()
	self._image = banmo:getImage()

	self._imageBig:SetImage(GameUrl.getBigBgUrlMainBanner(self._image))
end

function M:_onClickJump()
	if self._jumpId <= 0 then
		printWarn("没有设置跳转ID")

		return
	end

	if not SystemJumpController.instance:canJump(self._jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._jumpId)
end

return M
