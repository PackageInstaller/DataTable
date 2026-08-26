-- chunkname: @modules/logic/versionactivity3_3/arcade/view/develop/ArcadeDevelopView.lua

module("modules.logic.versionactivity3_3.arcade.view.develop.ArcadeDevelopView", package.seeall)

local ArcadeDevelopView = class("ArcadeDevelopView", BaseView)

function ArcadeDevelopView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gotab1 = gohelper.findChild(self.viewGO, "tab/#go_tab1")
	self._goselect1 = gohelper.findChild(self.viewGO, "tab/#go_tab1/#go_select")
	self._goreddot1 = gohelper.findChild(self.viewGO, "tab/#go_tab1/#go_reddot")
	self._btntab1 = gohelper.findChildButtonWithAudio(self.viewGO, "tab/#go_tab1/#btn_tab", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gotab2 = gohelper.findChild(self.viewGO, "tab/#go_tab2")
	self._goselect2 = gohelper.findChild(self.viewGO, "tab/#go_tab2/#go_select")
	self._goreddot2 = gohelper.findChild(self.viewGO, "tab/#go_tab2/#go_reddot")
	self._btntab2 = gohelper.findChildButtonWithAudio(self.viewGO, "tab/#go_tab2/#btn_tab", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._goview = gohelper.findChild(self.viewGO, "#go_view")
	self._gocurrency = gohelper.findChild(self.viewGO, "#go_currency")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeDevelopView:addEvents()
	self._btntab1:AddClickListener(self._btntab1OnClick, self)
	self._btntab2:AddClickListener(self._btntab2OnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:_editableAddEvents()
end

function ArcadeDevelopView:removeEvents()
	self._btntab1:RemoveClickListener()
	self._btntab2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self:_editableRemoveEvents()
end

function ArcadeDevelopView:_btncloseOnClick()
	self:closeThis()
end

function ArcadeDevelopView:onClickModalMask()
	self:_btncloseOnClick()
end

function ArcadeDevelopView:_btntab1OnClick()
	self:_refreshTab(1)
end

function ArcadeDevelopView:_btntab2OnClick()
	self:_refreshTab(2)
end

function ArcadeDevelopView:_editableAddEvents()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHeroItem, self._onClickSelectItem, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.UpLevelTalent, self._refreshReddot, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnReceiveArcadeAttrChangePush, self._refreshReddot, self, LuaEventSystem.Low)
end

function ArcadeDevelopView:_editableRemoveEvents()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHeroItem, self._onClickSelectItem, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.UpLevelTalent, self._refreshReddot, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnReceiveArcadeAttrChangePush, self._refreshReddot, self, LuaEventSystem.Low)
end

function ArcadeDevelopView:_editableInitView()
	return
end

function ArcadeDevelopView:_onClickSelectItem()
	self:_refreshReddot()
end

function ArcadeDevelopView:onOpen()
	self._selectTab = nil

	self:_refreshTab(self.viewParam.defaultTabId)
	self:_refreshReddot()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeDevelopView:_refreshTab(index)
	if self._selectTab == index then
		return
	end

	self.viewContainer:selectActTab(index)

	self._selectTab = index

	gohelper.setActive(self._goselect1, index == 1)
	gohelper.setActive(self._goselect2, index == 2)
end

function ArcadeDevelopView:_refreshReddot()
	local hasReddotCharacter = ArcadeHeroModel.instance:hasReddotCharacter()
	local hasReddotTalent = ArcadeHeroModel.instance:hasReddotTalent()

	gohelper.setActive(self._goreddot1, hasReddotCharacter)
	gohelper.setActive(self._goreddot2, hasReddotTalent)
end

function ArcadeDevelopView:onClose()
	ArcadeHeroModel.instance:setSelectHeroId()
end

function ArcadeDevelopView:onDestroyView()
	return
end

return ArcadeDevelopView
