-- chunkname: @modules/logic/autochess/main/view/game/AutoChessMallLevelUpView.lua

module("modules.logic.autochess.main.view.game.AutoChessMallLevelUpView", package.seeall)

local AutoChessMallLevelUpView = class("AutoChessMallLevelUpView", BaseView)

function AutoChessMallLevelUpView:onInitView()
	self._imageLevel1 = gohelper.findChildImage(self.viewGO, "icon/#image_Level1")
	self._txtMallLv1 = gohelper.findChildText(self.viewGO, "icon/#image_Level1/#txt_MallLv1")
	self._imageLevel2 = gohelper.findChildImage(self.viewGO, "icon/#image_Level2")
	self._txtMallLv2 = gohelper.findChildText(self.viewGO, "icon/#image_Level2/#txt_MallLv2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessMallLevelUpView:addEvents()
	return
end

function AutoChessMallLevelUpView:removeEvents()
	return
end

function AutoChessMallLevelUpView:onClickModalMask()
	self:closeThis()
end

function AutoChessMallLevelUpView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_store_upgrade)

	local chessMo = AutoChessModel.instance:getChessMo()
	local region = AutoChessHelper.getMallRegionByType(chessMo.svrMall.regions, AutoChessEnum.MallType.Normal)
	local mallCo = lua_auto_chess_mall.configDict[region.mallId]
	local nowLevel = mallCo.showLevel
	local lastLevel = nowLevel - 1

	UISpriteSetMgr.instance:setAutoChessSprite(self._imageLevel1, "v2a5_autochess_quality3_" .. lastLevel)
	UISpriteSetMgr.instance:setAutoChessSprite(self._imageLevel2, "v2a5_autochess_quality3_" .. nowLevel)

	local txt = luaLang("autochess_malllevelupview_level")

	self._txtMallLv1.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, lastLevel)
	self._txtMallLv2.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, nowLevel)

	TaskDispatcher.runDelay(self.onClickModalMask, self, 2)
end

return AutoChessMallLevelUpView
