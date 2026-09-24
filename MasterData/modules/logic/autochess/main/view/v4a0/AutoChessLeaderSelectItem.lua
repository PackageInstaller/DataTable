-- chunkname: @modules/logic/autochess/main/view/v4a0/AutoChessLeaderSelectItem.lua

module("modules.logic.autochess.main.view.v4a0.AutoChessLeaderSelectItem", package.seeall)

local AutoChessLeaderSelectItem = class("AutoChessLeaderSelectItem", LuaCompBase)

function AutoChessLeaderSelectItem:init(go)
	self.go = go
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self.goSelect = gohelper.findChild(go, "go_Select")

	local goMesh = gohelper.findChild(go, "Leader/Mesh")

	self.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(goMesh, AutoChessMeshComp)
	self.txtHp = gohelper.findChildText(go, "Leader/hp/txt_Hp")
	self.btnCheck = gohelper.findChildButtonWithAudio(go, "Leader/btn_Check")
	self.goUdimo = gohelper.findChild(go, "Udimo")
	self.imageQuality = gohelper.findChildImage(go, "Udimo/image_Quality")

	local goUdimoMesh = gohelper.findChild(go, "Udimo/Mesh")

	self.udimoMeshComp = MonoHelper.addNoUpdateLuaComOnceToGo(goUdimoMesh, AutoChessMeshComp)
	self.simageCardpack = gohelper.findChildSingleImage(go, "Cardpack/simage_Cardpack")
	self.btnCardpack = gohelper.findChildButtonWithAudio(go, "Cardpack/btn_Cardpack")
end

function AutoChessLeaderSelectItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._btnOnClick, self)
	self.addClickCb(self, self.btnCheck, self._btnOnCheckClick, self)
	self.addClickCb(self, self.btnCardpack, self._btnOnCardpackClick, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.ClickLeaderSelectItem, self._onClickItem, self)
end

function AutoChessLeaderSelectItem:setData(leaderId, cardpackId)
	self.id = leaderId
	self.cardpackId = cardpackId
	self.config = AutoChessConfig.instance:getLeaderCfg(self.id)
	self.txtHp.text = self.config.hp

	self.meshComp:setData(self.config.image, false, true)

	local hasUdimo = self.config.spUdimo ~= 0

	if hasUdimo then
		local udimoCfg = AutoChessConfig.instance:getChessCfgAnyway(self.config.spUdimo)
		local imageName = AutoChessHelper.getChessQualityBg(udimoCfg.type, udimoCfg.levelFromMall)

		UISpriteSetMgr.instance:setAutoChessSprite(self.imageQuality, imageName)
		self.udimoMeshComp:setData(udimoCfg.image)
	end

	gohelper.setActive(self.goUdimo, hasUdimo)

	local cardpackCfg = AutoChessConfig.instance:getCardpackCfg(self.cardpackId)

	self.simageCardpack:LoadImage(ResUrl.getMovingChessIcon(cardpackCfg.icon, "handbook"))
end

function AutoChessLeaderSelectItem:_btnOnClick()
	if not self.isSelect then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ClickLeaderSelectItem, self.id)
	end
end

function AutoChessLeaderSelectItem:_btnOnCheckClick()
	ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
		leaderId = self.id
	})
end

function AutoChessLeaderSelectItem:_btnOnCardpackClick()
	ViewMgr.instance:openView(ViewName.AutoChessCardpackInfoView, self.cardpackId)
end

function AutoChessLeaderSelectItem:_onClickItem(id)
	self.isSelect = id == self.id

	gohelper.setActive(self.goSelect, self.isSelect)
end

return AutoChessLeaderSelectItem
