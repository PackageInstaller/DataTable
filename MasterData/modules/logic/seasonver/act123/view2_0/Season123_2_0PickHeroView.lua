-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0PickHeroView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0PickHeroView", package.seeall)

local Season123_2_0PickHeroView = class("Season123_2_0PickHeroView", BaseView)

function Season123_2_0PickHeroView:onInitView()
	self._txtcount = gohelper.findChildText(self.viewGO, "#go_count/#txt_count")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_cancel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0PickHeroView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function Season123_2_0PickHeroView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function Season123_2_0PickHeroView:_btnconfirmOnClick()
	Season123PickHeroController.instance:pickOver()
	self:closeThis()
end

function Season123_2_0PickHeroView:_btncancelOnClick()
	self:closeThis()
end

function Season123_2_0PickHeroView:_editableInitView()
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")
	self._simageredlight = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_redlight")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	self._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))
end

function Season123_2_0PickHeroView:onDestroyView()
	self._imgBg:UnLoadImage()
	self._simageredlight:UnLoadImage()
	Season123PickHeroController.instance:onCloseView()
end

function Season123_2_0PickHeroView:onOpen()
	local actId = self.viewParam.actId
	local stage = self.viewParam.stage

	Season123PickHeroController.instance:onOpenView(actId, stage, self.viewParam.finishCall, self.viewParam.finishCallObj, self.viewParam.entryMOList, self.viewParam.selectHeroUid)

	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self.addEventCb(self, Season123Controller.instance, Season123Event.PickViewRefresh, self.refreshUI, self)
	self:refreshUI()
end

function Season123_2_0PickHeroView:onClose()
	return
end

function Season123_2_0PickHeroView:refreshUI()
	local selectCount = Season123PickHeroModel.instance:getSelectCount()
	local maxCount = Season123PickHeroModel.instance:getLimitCount()

	self._txtcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_custompick_selectnum"), {
		selectCount,
		maxCount
	})
end

return Season123_2_0PickHeroView
