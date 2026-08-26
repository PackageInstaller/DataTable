-- chunkname: @modules/logic/towercompose/view/TowerComposeEnvView.lua

module("modules.logic.towercompose.view.TowerComposeEnvView", package.seeall)

local TowerComposeEnvView = class("TowerComposeEnvView", BaseView)

function TowerComposeEnvView:onInitView()
	self._btncloseView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeView")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._simagescene = gohelper.findChildSingleImage(self.viewGO, "#simage_scene")
	self._imagebufficon = gohelper.findChildImage(self.viewGO, "#image_bufficon")
	self._txtdecstitle = gohelper.findChildText(self.viewGO, "#txt_decstitle")
	self._txtdesc = gohelper.findChildText(self.viewGO, "scroll_desc/viewprot/#txt_desc")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeEnvView:addEvents()
	self._btncloseView:AddClickListener(self._btncloseViewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function TowerComposeEnvView:removeEvents()
	self._btncloseView:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function TowerComposeEnvView:_btncloseViewOnClick()
	self:closeThis()
end

function TowerComposeEnvView:_btncloseOnClick()
	self:closeThis()
end

function TowerComposeEnvView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function TowerComposeEnvView:_editableInitView()
	self.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtdesc.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(self._txtdesc, self._onHyperLinkClick, self)
end

function TowerComposeEnvView:onUpdateParam()
	return
end

function TowerComposeEnvView:onOpen()
	self.themeId = self.viewParam.themeId
	self.planeId = self.viewParam.planeId or 0

	self:refreshUI()
end

function TowerComposeEnvView:refreshUI()
	self.themeInitEnv = TowerComposeConfig.instance:getThemeInitEnv(self.themeId)
	self.envModConfig = TowerComposeConfig.instance:getComposeModConfig(self.themeInitEnv)
	self.themeConfig = TowerComposeConfig.instance:getThemeConfig(self.themeId)
	self._txttitle.text = self.themeConfig.name
	self._txtdecstitle.text = self.envModConfig.name
	self._txtdesc.text = SkillHelper.buildDesc(self.themeConfig.themeDesc)

	self.descFixTmpBreakLine:refreshTmpContent(self.txtdesc)
	UISpriteSetMgr.instance:setTower2Sprite(self._imagebufficon, self.envModConfig.icon)
	self._simagescene:LoadImage(self.envModConfig.image)
end

function TowerComposeEnvView:onClose()
	return
end

function TowerComposeEnvView:onDestroyView()
	self._simagescene:UnLoadImage()
end

return TowerComposeEnvView
