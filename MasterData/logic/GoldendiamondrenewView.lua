-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/view/GoldendiamondrenewView.lua

module("logic.extensions.goldendiamondcard.view.GoldendiamondrenewView", package.seeall)

local GoldendiamondrenewView = class("GoldendiamondrenewView", ViewComponent)

function GoldendiamondrenewView:buildUI()
	GoldendiamondrenewView.super.buildUI(self)

	self.btnClose = self:getBtn("btnClose")
	self.btnGo = self:getBtn("btnGo")
	self.change = self:getGo("imgShow"):GetComponent("UIImageSpriteChange")
end

function GoldendiamondrenewView:bindEvents()
	GoldendiamondrenewView.super.bindEvents(self)
	self.btnGo:AddClickListener(self.onClickGo, self)
	self.btnClose:AddClickListener(self.close, self)
end

function GoldendiamondrenewView:unbindEvents()
	GoldendiamondrenewView.super.unbindEvents(self)
	self.btnGo:RemoveClickListener()
	self.btnClose:RemoveClickListener()
end

function GoldendiamondrenewView:onEnter()
	GoldendiamondrenewView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self.refreshView, self)
	self:refreshView()

	local useId = RoleModel.instance:getUserId()

	GameUtil.saveUserDayData((useId or "") .. "Goldendiamondrenew", 1)
end

function GoldendiamondrenewView:onExit()
	GoldendiamondrenewView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self.refreshView, self)
end

function GoldendiamondrenewView:onClickGo()
	self:close()
	PayShopController.instance:openView(GameEnum.PayShopEasyJump.GoldenDiamondCard)
	SurveyController.instance:reportBehavior(200464, 2)
end

function GoldendiamondrenewView:refreshView()
	if not GoldenDiamondCardModel.instance:getIsShowRenewView() then
		self.change:SetState(0)

		return
	end

	if GoldenDiamondCardModel.instance.isUser then
		self.change:SetState(1)
	else
		self.change:SetState(2)
	end
end

return GoldendiamondrenewView
