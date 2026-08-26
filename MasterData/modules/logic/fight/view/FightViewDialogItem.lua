-- chunkname: @modules/logic/fight/view/FightViewDialogItem.lua

module("modules.logic.fight.view.FightViewDialogItem", package.seeall)

local FightViewDialogItem = class("FightViewDialogItem", LuaCompBase)

function FightViewDialogItem:ctor(fightViewDialog)
	FightViewDialogItem.super.ctor(self)

	self._fightViewDialog = fightViewDialog
end

function FightViewDialogItem:init(go)
	self.go = go
	self._gocontainer = gohelper.findChild(go, "container")
	self._simageicon = gohelper.findChildSingleImage(go, "container/headframe/headicon")
	self._goframe = gohelper.findChild(go, "container/headframe")
	self._goNormalContent = gohelper.findChild(go, "container/go_normalcontent")
	self._txtdialog = gohelper.findChildText(go, "container/go_normalcontent/txt_contentcn")
	self._simagebg = gohelper.findChildSingleImage(go, "container/simagebg")
	self._canvasGroup = self._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function FightViewDialogItem:showDialogContent(icon, config)
	gohelper.setActive(self._goframe, icon ~= nil)
	gohelper.setActive(self._simageicon.gameObject, icon ~= nil)

	if icon then
		if self._simageicon.curImageUrl ~= icon then
			self._simageicon:UnLoadImage()
		end

		self._simageicon:LoadImage(icon)
	end

	self._txtdialog.text = config.text

	self._simagebg:LoadImage(ResUrl.getFightBattleDialogBg("duihuak_002"))

	self._tmpFadeIn = self._tmpFadeIn or MonoHelper.addLuaComOnceToGo(self._gocontainer, TMPFadeIn)

	self._tmpFadeIn:playNormalText(config.text)
	recthelper.setAnchorX(self._goframe.transform, config.tipsDir == 2 and 920 or 0)
	recthelper.setAnchorX(self._goNormalContent.transform, config.tipsDir == 2 and 382 or 529.2)

	local anchor = config.tipsDir == 2 and Vector2(1, 1) or Vector2(0, 1)

	self.go.transform.anchorMin = anchor
	self.go.transform.anchorMax = anchor

	recthelper.setAnchorX(self.go.transform, config.tipsDir == 2 and -1100 or 208.6)
end

function FightViewDialogItem:onDestroy()
	if self._tmpFadeIn then
		self._tmpFadeIn:hideDialog()

		self._tmpFadeIn = nil
	end

	self._simageicon:UnLoadImage()
	self._simagebg:UnLoadImage()
end

return FightViewDialogItem
