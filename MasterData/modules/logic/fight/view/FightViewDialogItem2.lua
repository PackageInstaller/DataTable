-- chunkname: @modules/logic/fight/view/FightViewDialogItem2.lua

module("modules.logic.fight.view.FightViewDialogItem2", package.seeall)

local FightViewDialogItem2 = class("FightViewDialogItem2", LuaCompBase)

function FightViewDialogItem2:ctor(fightViewDialog)
	FightViewDialogItem2.super.ctor(self)

	self._fightViewDialog = fightViewDialog
end

function FightViewDialogItem2:init(go)
	self.go = go
	self._gocontainer = gohelper.findChild(go, "container")
	self._simageicon = gohelper.findChildSingleImage(go, "container/headframe/headicon")
	self._goframe = gohelper.findChild(go, "container/headframe")
	self._goNormalContent = gohelper.findChild(go, "container/go_normalcontent")
	self._txtdialog = gohelper.findChildText(go, "container/go_normalcontent/txt_contentcn")
	self._simagebg = gohelper.findChildSingleImage(go, "container/simagebg")
	self._canvasGroup = self._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function FightViewDialogItem2:showDialogContent(icon, config)
	gohelper.setActive(self._goframe, icon ~= nil)
	gohelper.setActive(self._simageicon.gameObject, icon ~= nil)

	if icon then
		if self._simageicon.curImageUrl ~= icon then
			self._simageicon:UnLoadImage()
		end

		self._simageicon:LoadImage(icon)
	end

	self._txtdialog.text = config.text
	self._tmpFadeIn = self._tmpFadeIn or MonoHelper.addLuaComOnceToGo(self._gocontainer, TMPFadeIn)

	self._tmpFadeIn:playNormalText(config.text)
end

function FightViewDialogItem2:onDestroy()
	if self._tmpFadeIn then
		self._tmpFadeIn:hideDialog()

		self._tmpFadeIn = nil
	end

	self._simageicon:UnLoadImage()
	self._simagebg:UnLoadImage()
end

return FightViewDialogItem2
