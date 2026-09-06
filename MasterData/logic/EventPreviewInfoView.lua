-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/view/EventPreviewInfoView.lua

module("logic.extensions.eventpreview.view.EventPreviewInfoView", package.seeall)

local EventPreviewInfoView = class("EventPreviewInfoView", ViewComponent)

function EventPreviewInfoView:ctor()
	EventPreviewInfoView.super.ctor(self)
end

function EventPreviewInfoView:unbindEvents()
	EventPreviewInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function EventPreviewInfoView:bindEvents()
	EventPreviewInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EventPreviewInfoView:buildUI()
	EventPreviewInfoView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._btnClose = self:getGo("btnClose")
	self._txt_Copy = self:getTxt("txt_Copy")
	self._textCom = self:getGo("textCom")
	self._recordText = self._textCom:GetComponent(typeof(TestRecordPos))
	self._item_Copy = self:getGo("item_Copy")
	self._itemCom = self:getGo("itemCom")
	self._recordItem = self._itemCom:GetComponent(typeof(TestRecordPos))
	self._itemList = {}
	self._txtList = {}
	self._txt_Copy.text = ""
end

function EventPreviewInfoView:onExit()
	EventPreviewInfoView.super.onExit(self)
	self:resetAll()
end

function EventPreviewInfoView:onEnter()
	EventPreviewInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curShowId = checknumber(params[2])

	local cfgs = EventPreviewConfig.instance:getUnlockShowCfgs(self._activityId) or {}

	self._curCfg = cfgs[self._curShowId]

	if self._curCfg then
		self:showInfo()
	end
end

function EventPreviewInfoView:showInfo()
	self:resetAll()

	local function localFunc()
		local image = self._bg:GetComponent(goutil.Type_UIImage)

		if image then
			image:SetNativeSize()
		end
	end

	local path = self._curCfg.bgPath
	local bgUrl = string.format("ui/bigbg/eventpreview/%s.png", path)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, bgUrl, localFunc)

	if not self._curCfg.showPrizes then
		local prizeStrArr = string.split(self._curCfg.showPrizes, "#") or {}

		for i, str in ipairs(prizeStrArr) do
			local itemPath = "cell_" .. i
			local item = goutil.findChild(self._itemCom, itemPath) or goutil.cloneAndSetParent(self._item_Copy, self._itemCom.transform, itemPath)

			MaterialMgr.setCellByCfg(str, item)

			self._itemList[i] = item
		end

		self._recordItem:LoadPlan(self._curCfg.showPrizePlan)

		if not self._curCfg.showDescs then
			for i, str in ipairs(self._curCfg.showDescs) do
				local txtPath = "txt_" .. i
				local txtGo = goutil.findChild(self._textCom, txtPath) or goutil.cloneAndSetParent(self._txt_Copy.gameObject, self._textCom.transform, txtPath)
				local txt = txtGo:GetComponent(goutil.Type_UIText)

				txt.text = str
				self._txtList[i] = txt
			end

			self._recordText:LoadPlan(self._curCfg.showDescPlan)
		end
	end
end

function EventPreviewInfoView:resetAll()
	for _, item in ipairs(self._itemList) do
		MaterialMgr.resetAll(item)
	end

	for _, txt in ipairs(self._txtList) do
		txt.text = ""
	end

	uGuiUtil.clearImage(self._bg)
end

return EventPreviewInfoView
