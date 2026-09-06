-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSaprkCampDetailView.lua

module("logic.extensions.elementspark.view.ElementSaprkCampDetailView", package.seeall)

local ElementSaprkCampDetailView = class("ElementSaprkCampDetailView", ViewComponent)

function ElementSaprkCampDetailView:ctor()
	ElementSaprkCampDetailView.super.ctor(self)
end

function ElementSaprkCampDetailView:unbindEvents()
	ElementSaprkCampDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ElementSaprkCampDetailView:bindEvents()
	ElementSaprkCampDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ElementSaprkCampDetailView:buildUI()
	ElementSaprkCampDetailView.super.buildUI(self)

	self._img = self:getGo("camp/img")
	self._txtName = self:getTxt("txtName")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnClose = self:getBtn("btnClose")
end

function ElementSaprkCampDetailView:onExit()
	ElementSaprkCampDetailView.super.onExit(self)
	uGuiUtil.clearImage(self._img)
end

function ElementSaprkCampDetailView:onEnter()
	ElementSaprkCampDetailView.super.onEnter(self)

	self._campId = checknumber(self:getFirstParam())
	self._activityId = ElementSparkController.instance:getActivityId()
	self._campCfg = ElementSparkConfig.instance:getCampCfgById(self._activityId, self._campId)

	uGuiUtil.setSpriteToImage(self._img, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(self._campCfg.path))

	self._txtName.text = self._campCfg.name
	self._txtDesc.text = self._campCfg.campDesc
end

return ElementSaprkCampDetailView
