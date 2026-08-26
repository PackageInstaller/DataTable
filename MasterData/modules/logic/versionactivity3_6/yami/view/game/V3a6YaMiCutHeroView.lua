-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiCutHeroView.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiCutHeroView", package.seeall)

local V3a6YaMiCutHeroView = class("V3a6YaMiCutHeroView", BaseView)

function V3a6YaMiCutHeroView:onInitView()
	self._btnarrow1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_arrow1")
	self._gopanel = gohelper.findChild(self.viewGO, "root/#go_panel")
	self._gomask = gohelper.findChild(self.viewGO, "root/mask")
	self._btnarrow2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_arrow2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiCutHeroView:addEvents()
	self._btnarrow1:AddClickListener(self._btnarrow1OnClick, self)
	self._btnarrow2:AddClickListener(self._btnarrow2OnClick, self)
	self._btnMask:AddClickListener(self._btnCloseOnClick, self)
end

function V3a6YaMiCutHeroView:removeEvents()
	self._btnarrow1:RemoveClickListener()
	self._btnarrow2:RemoveClickListener()
	self._btnMask:RemoveClickListener()
end

function V3a6YaMiCutHeroView:_btnarrow1OnClick()
	if self._heroIndex <= 1 then
		return
	end

	self._heroIndex = self._heroIndex - 1

	self:_switchHero()
end

function V3a6YaMiCutHeroView:_btnarrow2OnClick()
	if self._heroIndex >= self._heroCount then
		return
	end

	self._heroIndex = self._heroIndex + 1

	self:_switchHero()
end

function V3a6YaMiCutHeroView:_btnCloseOnClick()
	self:closeThis()
end

function V3a6YaMiCutHeroView:_editableInitView()
	self._listModel = V3a6YaMiHeroHandbookListModel.instance
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btnMask = gohelper.getClick(self._gomask)
end

function V3a6YaMiCutHeroView:onOpen()
	self.detailView = self.viewContainer:getDetailView()
	self._heroIndex = self._listModel:getIndex(self.viewParam)
	self._heroCount = self._listModel:getCount()
end

function V3a6YaMiCutHeroView:onOpenFinish()
	self:_refreshHero()
end

function V3a6YaMiCutHeroView:_refreshHero()
	local mo = self._listModel:getByIndex(self._heroIndex)

	self.detailView:refreshDetail(mo)
	ZProj.UGUIHelper.SetGrayscale(self._btnarrow1.gameObject, self._heroIndex <= 1)
	ZProj.UGUIHelper.SetGrayscale(self._btnarrow2.gameObject, self._heroIndex >= self._heroCount)
end

function V3a6YaMiCutHeroView:_switchHero()
	TaskDispatcher.cancelTask(self._refreshHero, self)
	TaskDispatcher.runDelay(self._refreshHero, self, 0.16)
	self._anim:Play("switch", 0, 0)
end

function V3a6YaMiCutHeroView:onClose()
	TaskDispatcher.cancelTask(self._refreshHero, self)
end

function V3a6YaMiCutHeroView:onDestroyView()
	return
end

return V3a6YaMiCutHeroView
