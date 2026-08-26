-- chunkname: @modules/logic/balanceumbrella/view/BalanceUmbrellaClueView.lua

module("modules.logic.balanceumbrella.view.BalanceUmbrellaClueView", package.seeall)

local BalanceUmbrellaClueView = class("BalanceUmbrellaClueView", BaseView)

function BalanceUmbrellaClueView:onInitView()
	self._goget = gohelper.findChild(self.viewGO, "#go_get")
	self._godetail = gohelper.findChild(self.viewGO, "#go_detail")
	self._animget = self._goget:GetComponent(typeof(UnityEngine.Animator))
	self._animdetail = self._godetail:GetComponent(typeof(UnityEngine.Animator))
	self._btngetClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_get/#btn_close")
	self._simagegetclue = gohelper.findChildSingleImage(self.viewGO, "#go_get/#simage_clue")
	self._btndetailclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_detail/#btn_close")
	self._simagedetailclue = gohelper.findChildSingleImage(self.viewGO, "#go_detail/Left/#simage_clue")
	self._txtroledesc = gohelper.findChildTextMesh(self.viewGO, "#go_detail/Right/#scroll_desc/viewport/content/#txt_dec")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "#go_detail/Right/#scroll_desc/viewport/content/#txt_cluedec")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "#go_detail/Right/titlebg/#txt_cluename")
end

function BalanceUmbrellaClueView:addEvents()
	self._btngetClose:AddClickListener(self.closeThis, self)
	self._btndetailclose:AddClickListener(self.closeThis, self)
end

function BalanceUmbrellaClueView:removeEvents()
	self._btngetClose:RemoveClickListener()
	self._btndetailclose:RemoveClickListener()
end

function BalanceUmbrellaClueView:onOpen()
	gohelper.setActive(self._goget, self.viewParam.isGet)
	gohelper.setActive(self._godetail, not self.viewParam.isGet)
	self._simagegetclue:LoadImage(string.format("singlebg/balance_singlebg/item/balance_bigitem_%02d.png", self.viewParam.id))
	self._simagedetailclue:LoadImage(string.format("singlebg/balance_singlebg/item/balance_bigitem_%02d.png", self.viewParam.id))

	local co = lua_balance_umbrella.configDict[self.viewParam.id]

	if not co then
		return
	end

	self._txtname.text = co.name
	self._txtdesc.text = co.desc
	self._txtroledesc.text = co.players

	if self.viewParam.isGet then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
		UIBlockHelper.instance:startBlock("BalanceUmbrellaClueView_Get", 1, self.viewName)
		TaskDispatcher.runDelay(self._showDetail, self, 1)
		self._animget:Play("open", 0, 0)
	else
		self._animdetail:Play("open", 0, 0)
	end
end

function BalanceUmbrellaClueView:_showDetail()
	gohelper.setActive(self._godetail, true)
	self._animget:Play("close", 0, 0)
	self._animdetail:Play("switch", 0, 0)
end

function BalanceUmbrellaClueView:onClickModalMask()
	self:closeThis()
end

function BalanceUmbrellaClueView:onClose()
	if self.viewParam.isGet then
		BalanceUmbrellaController.instance:dispatchEvent(BalanceUmbrellaEvent.ShowGetEffect)
	end
end

function BalanceUmbrellaClueView:onDestroyView()
	TaskDispatcher.cancelTask(self._showDetail, self)
	BalanceUmbrellaController.instance:dispatchEvent(BalanceUmbrellaEvent.GuideClueViewClose)
	self._simagegetclue:UnLoadImage()
	self._simagedetailclue:UnLoadImage()
end

return BalanceUmbrellaClueView
