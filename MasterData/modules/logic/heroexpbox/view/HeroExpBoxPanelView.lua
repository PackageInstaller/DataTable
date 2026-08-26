-- chunkname: @modules/logic/heroexpbox/view/HeroExpBoxPanelView.lua

module("modules.logic.heroexpbox.view.HeroExpBoxPanelView", package.seeall)

local HeroExpBoxPanelView = class("HeroExpBoxPanelView", BaseView)

function HeroExpBoxPanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Bg")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_role")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._goreward1 = gohelper.findChild(self.viewGO, "Root/reward/#go_reward1")
	self._btnreward1 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/#go_reward1/#btn_reward1")
	self._txtitem1 = gohelper.findChildText(self.viewGO, "Root/reward/#go_reward1/txt_bg1/#txt_item1")
	self._goreward2 = gohelper.findChild(self.viewGO, "Root/reward/#go_reward2")
	self._btnreward2 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/#go_reward2/#btn_reward2")
	self._txtitem2 = gohelper.findChildText(self.viewGO, "Root/reward/#go_reward2/txt_bg2/#txt_item2")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/reward/#go_hasget")
	self._txtreward1 = gohelper.findChildText(self.viewGO, "Root/txt_imgBg2/#txt_reward1")
	self._txtreward2 = gohelper.findChildText(self.viewGO, "Root/txt_imgBg2/#txt_reward2")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Btn/#btn_get")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Btn/#btn_goto")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroExpBoxPanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreward1:AddClickListener(self._btnreward1OnClick, self)
	self._btnreward2:AddClickListener(self._btnreward2OnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
end

function HeroExpBoxPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreward1:RemoveClickListener()
	self._btnreward2:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btngoto:RemoveClickListener()
end

function HeroExpBoxPanelView:_btnreward1OnClick()
	MaterialTipController.instance:showMaterialInfo(self._bouns[1][1], self._bouns[1][2])
end

function HeroExpBoxPanelView:_btnreward2OnClick()
	MaterialTipController.instance:showMaterialInfo(self._bouns[2][1], self._bouns[2][2])
end

function HeroExpBoxPanelView:_btngotoOnClick()
	return
end

function HeroExpBoxPanelView:_btncloseOnClick()
	self:closeThis()
end

function HeroExpBoxPanelView:_btngetOnClick()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1, self._refreshBtn, self)
	end
end

function HeroExpBoxPanelView:_editableInitView()
	self._actId = ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.HeroExpBoxAct, ActivityEnum.Activity.V3a4_HeroExpBox)

	self:_refreshContent()
end

function HeroExpBoxPanelView:onUpdateParam()
	return
end

function HeroExpBoxPanelView:onOpen()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId, self._refreshBtn, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
end

function HeroExpBoxPanelView:_refreshBtn()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	gohelper.setActive(self._btnget.gameObject, couldGet)
	gohelper.setActive(self._btngoto.gameObject, not couldGet)
	gohelper.setActive(self._gohasget.gameObject, not couldGet)
end

function HeroExpBoxPanelView:_refreshContent()
	self._bouns = self:_getBouns()

	local itemCo1 = ItemModel.instance:getItemConfig(self._bouns[1][1], self._bouns[1][2])
	local itemCo2 = ItemModel.instance:getItemConfig(self._bouns[2][1], self._bouns[2][2])
	local lang = luaLang("v3a4_destiny_panelsview_item")

	self._txtitem1.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, itemCo1.name, self._bouns[1][3])
	self._txtitem2.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, itemCo2.name, self._bouns[2][3])

	local lang1 = luaLang("v3a4_destiny_panelsview_rewarddesc1")

	self._txtreward1.text = GameUtil.getSubPlaceholderLuaLang(lang1, {
		itemCo1.name,
		self._bouns[1][3],
		itemCo2.name,
		self._bouns[2][3]
	})

	local lang2 = luaLang("v3a4_destiny_panelsview_rewarddesc2")

	self._txtreward2.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang2, itemCo1.name)
end

function HeroExpBoxPanelView:_getBouns()
	if not self._bouns then
		local co = ActivityConfig.instance:getNorSignActivityCo(self._actId, 1)

		if not string.nilorempty(co.bonus) then
			self._bouns = GameUtil.splitString2(co.bonus)
		end
	end

	return self._bouns
end

function HeroExpBoxPanelView:onClose()
	return
end

function HeroExpBoxPanelView:onDestroyView()
	return
end

return HeroExpBoxPanelView
