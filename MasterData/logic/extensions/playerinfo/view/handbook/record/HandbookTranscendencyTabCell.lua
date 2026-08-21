-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookTranscendencyTabCell.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookTranscendencyTabCell", package.seeall)

local M = class("HandbookTranscendencyTabCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_record_transcendency_tab_-1279714816"))
	self._rectTrContent = registry:findUIElement("handbook_record_transcendency_tab_-1282963231", UIComponentType.RectTransform)
	self._imgIcon = registry:findUIElement("handbook_record_transcendency_tab_104697986", UIComponentType.ImageBigBG)
	self._txtName = registry:findUIElement("handbook_record_transcendency_tab_2103680655", UIComponentType.Text)
	self._defaultName = self._txtName.text
	self._goNewSignMark = registry:findUIElement("handbook_record_transcendency_tab_2036083325")
	self._goLock = registry:findUIElement("handbook_record_transcendency_tab_-1941758341")
	self._goSelect = registry:findUIElement("handbook_record_transcendency_tab_-923817930")
	self._tabPos = {}

	table.insert(self._tabPos, Astral.TransformUtil.GetLocalPosX(registry:findUIElement("handbook_record_transcendency_tab_-1238609574", UIComponentType.RectTransform)))
	table.insert(self._tabPos, Astral.TransformUtil.GetLocalPosX(registry:findUIElement("handbook_record_transcendency_tab_-21060956", UIComponentType.RectTransform)))
end

function M:destroyUI()
	self:setHandler(nil)

	self._btnClick = nil
	self._imgIcon = nil
	self._txtName = nil
	self._goNewSignMark = nil
	self._goLock = nil
	self._goSelect = nil
	self._tabPos = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	self._imgIcon:ClearImage()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getRegistry()
	return self._registry
end

function M:_onClickSelf()
	local handler = self:getHandler()

	if handler then
		handler:onCellClick(self)
	end
end

function M:setData(cfgData)
	self._id = cfgData.id

	local isLock = not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Event, self._id)

	self._txtName.text = isLock and self._defaultName or cfgData.name

	self:updateTabRes(cfgData.tabRes)
	self:setLock(isLock)
	self:setNewMark(GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Event, self._id))
end

function M:updateTabRes(tabRes)
	if not string.nilorempty(tabRes) then
		local path = string.format("ui/bigbg/%s.png", tabRes)

		self._imgIcon:SetImage(path)
	end
end

function M:setIsSelected(selected)
	goutil.setActive(self._goSelect, selected)

	local posX = selected and self._tabPos[2] or self._tabPos[1]

	if posX then
		RectTransformUtils.SetAnchoredPosition(self._rectTrContent, posX, 0)
	end

	if selected and self:getIsNew() then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.Event, self:getId(), true)
		self:setNewMark(false)
	end
end

function M:setLock(lock)
	self._isLock = lock

	goutil.setActive(self._goLock, lock)
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

return M
