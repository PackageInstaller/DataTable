-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/headitem/view/HeadalertView.lua

module("logic.extensions.headitem.view.HeadalertView", package.seeall)

local HeadalertView = class("HeadalertView", ViewComponent)

function HeadalertView:ctor()
	HeadalertView.super.ctor(self)
end

function HeadalertView:buildUI()
	HeadalertView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")
	self.imgState = self:getGo("imgState")
	self.icon = self:getGo("headIcon/icon")
	self.txtName = self:getTxt("txtName")
	self.txtDesc = self:getTxt("txtDesc")
	self.txtTitle = self:getTxt("txtTitle")
	self.txtSure = self:getTxt("btnSure/Text")
end

function HeadalertView:bindEvents()
	HeadalertView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self.onOkClick, self)
end

function HeadalertView:unbindEvents()
	HeadalertView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
end

function HeadalertView:destroyUI()
	HeadalertView.super.destroyUI(self)
end

function HeadalertView:onEnter()
	HeadalertView.super.onEnter(self)

	local params = self:getOpenParam()
	local matType = params[1]
	local cfg = params[2]

	self.type = matType
	self.cfg = cfg

	local proxy = matType ~= MatType.Bubble and MaterialMgr.setCell(matType, cfg.id, self.icon) or MaterialMgr.setCell(matType, cfg.bubbleId, self.icon)

	if proxy then
		proxy.binder:setBgActive(false)
	end

	self.txtName.text = cfg.name or cfg.bubbleName
	self.txtDesc.text = cfg.desc

	GameUtil.SetActive(self.imgState, false)

	local info

	if self.type == MatType.HeadIcon then
		self.txtTitle.text = lang("头像")
		info = HeadItemModel.instance:getHeadIconInfo(cfg.id)
	elseif self.type == MatType.HeadFrame then
		self.txtTitle.text = lang("头像框")
		info = HeadItemModel.instance:getHeadFrameInfo(cfg.id)
	else
		self.txtTitle.text = self.type == MatType.NameFrame and lang("名字框") or lang("聊天框")
	end

	if self.type == MatType.Bubble then
		if cfg.bubbleId == 1 then
			GameUtil.SetActive(self.btnSure, NewChatModel.instance:getChatBubbleId() ~= 1)
			GameUtil.SetActive(self.imgState, NewChatModel.instance:getChatBubbleId() == 1)
			GameUtil.setUIImageSpriteIdx(self.imgState, 1)
		elseif cfg.defaultByVip then
			local vipLv = RoleModel.instance:getVipLvl()

			GameUtil.SetActive(self.btnSure, vipLv >= cfg.vipLevel and NewChatModel.instance:getChatBubbleId() ~= cfg.bubbleId)
			GameUtil.SetActive(self.imgState, vipLv < cfg.vipLevel or NewChatModel.instance:getChatBubbleId() == cfg.bubbleId)
			GameUtil.setUIImageSpriteIdx(self.imgState, vipLv >= cfg.vipLevel and 1 or 0)
		else
			local num = MaterialModel.instance:getMaterialsNumber(MatType.Bubble, cfg.bubbleId)

			GameUtil.SetActive(self.btnSure, num > 0 and NewChatModel.instance:getChatBubbleId() ~= cfg.bubbleId)
			GameUtil.SetActive(self.imgState, num == 0 or NewChatModel.instance:getChatBubbleId() == cfg.bubbleId)
			GameUtil.setUIImageSpriteIdx(self.imgState, num > 0 and 1 or 0)
		end
	elseif info then
		if info.isWear then
			GameUtil.SetActive(self.btnSure, false)
			GameUtil.SetActive(self.imgState, true)
			GameUtil.setUIImageSpriteIdx(self.imgState, 1)
		else
			GameUtil.SetActive(self.btnSure, true)
		end
	else
		GameUtil.SetActive(self.btnSure, false)
		GameUtil.SetActive(self.imgState, true)
		GameUtil.setUIImageSpriteIdx(self.imgState, 0)
	end
end

function HeadalertView:onEnterFinished()
	HeadalertView.super.onEnterFinished(self)
end

function HeadalertView:onExit()
	HeadalertView.super.onExit(self)
	MaterialMgr.resetAll(self.icon)
end

function HeadalertView:onExitFinished()
	HeadalertView.super.onExitFinished(self)
end

function HeadalertView:onOkClick()
	if self.type ~= MatType.Bubble then
		HeadItemController.instance:sendWearItem(self.type, self.cfg)
	else
		NewChatController.instance:sendPM_SelectChatBubbleReq(self.cfg.bubbleId)
	end

	self:close()
end

return HeadalertView
