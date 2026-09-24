-- chunkname: @modules/logic/autochess/main/view/v4a0/AutoChessCardpackInfoView.lua

module("modules.logic.autochess.main.view.v4a0.AutoChessCardpackInfoView", package.seeall)

local AutoChessCardpackInfoView = class("AutoChessCardpackInfoView", BaseView)

function AutoChessCardpackInfoView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._simageCardpack = gohelper.findChildSingleImage(self.viewGO, "cardpack/#simage_Cardpack")
	self._txtCardPackName = gohelper.findChildText(self.viewGO, "cardpack/#txt_CardPackName")
	self._scrollCardpack = gohelper.findChildScrollRect(self.viewGO, "#scroll_Cardpack")
	self._goGroupItem = gohelper.findChild(self.viewGO, "#scroll_Cardpack/Viewport/Content/#go_GroupItem")
	self._goChessInfo = gohelper.findChild(self.viewGO, "#go_ChessInfo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCardpackInfoView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function AutoChessCardpackInfoView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function AutoChessCardpackInfoView:onClickModalMask()
	self:closeThis()
end

function AutoChessCardpackInfoView:_btnCloseOnClick()
	self:closeThis()
end

function AutoChessCardpackInfoView:_editableInitView()
	return
end

function AutoChessCardpackInfoView:onOpen()
	self.cardpackId = self.viewParam

	if self.cardpackId then
		self:refreshUI()
	end
end

function AutoChessCardpackInfoView:refreshUI()
	self.config = AutoChessConfig.instance:getCardpackCfg(self.cardpackId)

	if not self.config then
		return
	end

	self._txtCardPackName.text = self.config.name

	self._simageCardpack:LoadImage(ResUrl.getMovingChessIcon(self.config.icon, "handbook"))

	local chessCfgGroupMap = {}
	local chessIds = string.splitToNumber(self.config.chessPool, "#")

	for _, chessId in ipairs(chessIds) do
		local chessCfg = AutoChessConfig.instance:getChessCfgAnyway(chessId)

		if chessCfg then
			chessCfgGroupMap[chessCfg.race] = chessCfgGroupMap[chessCfg.race] or {}

			table.insert(chessCfgGroupMap[chessCfg.race], chessCfg)
		end
	end

	for _, campCo in ipairs(lua_auto_chess_translate.configList) do
		local raceChessCfgs = chessCfgGroupMap[campCo.id]

		if raceChessCfgs then
			local goGroup = gohelper.cloneInPlace(self._goGroupItem)
			local imageType = gohelper.findChildImage(goGroup, "Tag/image_Type")
			local txtType = gohelper.findChildText(goGroup, "Tag/txt_Type")

			if campCo then
				SLFramework.UGUI.GuiHelper.SetColor(imageType, campCo.color)

				txtType.text = campCo.name
			end

			local goChess = gohelper.findChild(goGroup, "Chess")

			for _, chessCfg in ipairs(raceChessCfgs) do
				local go = gohelper.cloneInPlace(goChess)
				local imageQulity = gohelper.findChildImage(go, "image_Quality")
				local imageName = AutoChessHelper.getChessQualityBg(chessCfg.type, chessCfg.levelFromMall)

				UISpriteSetMgr.instance:setAutoChessSprite(imageQulity, imageName)

				local goMesh = gohelper.findChild(go, "Mesh")
				local meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(goMesh, AutoChessMeshComp)

				meshComp:setData(chessCfg.image)

				local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

				self.addClickCb(self, btnClick, self._onChessItemClick, self, chessCfg.id)
			end

			gohelper.setActive(goChess, false)
		end
	end

	gohelper.setActive(self._goGroupItem, false)
end

function AutoChessCardpackInfoView:_onChessItemClick(id)
	AutoChessController.instance:openHandbookPreviewView({
		chessId = id
	})
end

return AutoChessCardpackInfoView
