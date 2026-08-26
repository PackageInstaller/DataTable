-- chunkname: @modules/logic/versionactivity1_6/act152/view/NewYearEveActivityView.lua

module("modules.logic.versionactivity1_6.act152.view.NewYearEveActivityView", package.seeall)

local NewYearEveActivityView = class("NewYearEveActivityView", BaseView)

function NewYearEveActivityView:onInitView()
	self._simageFullBG1 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG1")
	self._simageFullBG2 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG2")
	self._simageLogo = gohelper.findChildSingleImage(self.viewGO, "#simage_Logo")
	self._gorole3 = gohelper.findChild(self.viewGO, "Role/#go_role3")
	self._simageRole3 = gohelper.findChildSingleImage(self.viewGO, "Role/#go_role3/#simage_Role3")
	self._goBG3 = gohelper.findChild(self.viewGO, "Role/#go_role3/Prop/#go_BG3")
	self._gorole5 = gohelper.findChild(self.viewGO, "Role/#go_role5")
	self._simageRole5 = gohelper.findChildSingleImage(self.viewGO, "Role/#go_role5/#simage_Role5")
	self._goBG5 = gohelper.findChild(self.viewGO, "Role/#go_role5/Prop/#go_BG5")
	self._gorole1 = gohelper.findChild(self.viewGO, "Role/#go_role1")
	self._simageRole1 = gohelper.findChildSingleImage(self.viewGO, "Role/#go_role1/#simage_Role1")
	self._goBG1 = gohelper.findChild(self.viewGO, "Role/#go_role1/Prop/#go_BG1")
	self._gorole4 = gohelper.findChild(self.viewGO, "Role/#go_role4")
	self._simageRole4 = gohelper.findChildSingleImage(self.viewGO, "Role/#go_role4/#simage_Role4")
	self._goBG4 = gohelper.findChild(self.viewGO, "Role/#go_role4/Prop/#go_BG4")
	self._gorole2 = gohelper.findChild(self.viewGO, "Role/#go_role2")
	self._simageRole2 = gohelper.findChildSingleImage(self.viewGO, "Role/#go_role2/#simage_Role2")
	self._goBG2 = gohelper.findChild(self.viewGO, "Role/#go_role2/Prop/#go_BG2")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_enter")
	self._imagereddot = gohelper.findChildImage(self.viewGO, "Right/#btn_enter/#image_reddot")
	self._simageFullBG3 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NewYearEveActivityView:addEvents()
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
end

function NewYearEveActivityView:removeEvents()
	self._btnenter:RemoveClickListener()
end

function NewYearEveActivityView:_btnenterOnClick()
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.Antique)
end

local antiqueShowSort = {
	2,
	1,
	5,
	3,
	4
}

function NewYearEveActivityView:_editableInitView()
	return
end

function NewYearEveActivityView:onUpdateParam()
	return
end

function NewYearEveActivityView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._roleItems = {}

	for i, v in ipairs(antiqueShowSort) do
		local item = {}

		item.gorole = self["_gorole" .. i]
		item.simgrole = self["_simageRole" .. i]
		item.gobg = self["_goBG" .. i]
		item.id = v
		item.click = gohelper.findChildButtonWithAudio(item.gorole, "Click")

		item.click:AddClickListener(self._giftClick, self, item.id)
		table.insert(self._roleItems, item)
	end

	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_open)
	self:_refreshItems()
	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function NewYearEveActivityView:_giftClick(id)
	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_click)
	Activity152Controller.instance:openNewYearGiftView(id)
end

function NewYearEveActivityView:_refreshItems()
	for _, v in pairs(self._roleItems) do
		local get = Activity152Model.instance:isPresentAccepted(v.id)

		gohelper.setActive(v.gorole, get)
		gohelper.setActive(v.gobg, get)
		gohelper.setActive(v.simgrole.gameObject, get)
	end

	local show = Activity152Model.instance:hasPresentAccepted()

	gohelper.setActive(self._btnenter.gameObject, show)

	local actCo = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NewYearEve)

	self._txtDescr.text = actCo.actDesc
end

function NewYearEveActivityView:_refreshTimeTick()
	local actId = ActivityEnum.Activity.NewYearEve

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(actId)
end

function NewYearEveActivityView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function NewYearEveActivityView:onDestroyView()
	if self._roleItems then
		for _, v in pairs(self._roleItems) do
			v.click:RemoveClickListener()
		end

		self._roleItems = nil
	end
end

return NewYearEveActivityView
