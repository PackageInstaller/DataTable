-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkbuypetView.lua

module("logic.extensions.elementspark.view.ElementsparkbuypetView", package.seeall)

local ElementsparkbuypetView = class("ElementsparkbuypetView", ViewComponent)

function ElementsparkbuypetView:ctor()
	ElementsparkbuypetView.super.ctor(self)
end

function ElementsparkbuypetView:unbindEvents()
	ElementsparkbuypetView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function ElementsparkbuypetView:bindEvents()
	ElementsparkbuypetView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function ElementsparkbuypetView:buildUI()
	ElementsparkbuypetView.super.buildUI(self)

	self._txtDesc_1 = self:getTxt("root/desc/txtDesc_1")
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("root/btnSure")
end

function ElementsparkbuypetView:onExit()
	ElementsparkbuypetView.super.onExit(self)
end

function ElementsparkbuypetView:onEnter()
	ElementsparkbuypetView.super.onEnter(self)

	self._activityId = ElementSparkController.instance:getActivityId()

	local params = self:getOpenParam()

	self._shopId = params[1]
	self._shopItemId = params[2]
	self._shopCfg = ElementSparkConfig.instance:getPetShopCfgById(self._shopId, self._shopItemId)

	self:_updateUI()
end

function ElementsparkbuypetView:_updateUI()
	local petCfg = ElementSparkConfig.instance:getSupportPetCfg(self._shopCfg.supportPetId)
	local name = MaterialMgr.getMaterialsName(MatType.Pet, petCfg.raceId)

	self._txtDesc_1.text = langPara("elementspark_9", self._shopCfg.price, name)
end

function ElementsparkbuypetView:_onClickbtnClose()
	self:close()
end

function ElementsparkbuypetView:_onClickbtnSure()
	ElementSparkController.instance:sendPM_EleSparkBuyPetReq(self._shopItemId)
	self:close()
end

return ElementsparkbuypetView
