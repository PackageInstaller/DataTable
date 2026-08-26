-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationGiftFullView.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftFullView", package.seeall)

local VersionActivity2_3NewCultivationGiftFullView = class("VersionActivity2_3NewCultivationGiftFullView", VersionActivity2_3NewCultivationGiftView)

function VersionActivity2_3NewCultivationGiftFullView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_bg")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._simagedec = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_dec")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/#btn_reward")
	self._simageTitle2 = gohelper.findChildSingleImage(self.viewGO, "Root/reward/#simage_Title2")
	self._btnstone = gohelper.findChildButtonWithAudio(self.viewGO, "Root/stone/txt_dec/#btn_stone")
	self._gokeyword = gohelper.findChild(self.viewGO, "Root/stone/#go_keyword")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Btn/#btn_get")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/Btn/hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationGiftFullView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnstone:AddClickListener(self._btnstoneOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
end

function VersionActivity2_3NewCultivationGiftFullView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnstone:RemoveClickListener()
	self._btnget:RemoveClickListener()
end

function VersionActivity2_3NewCultivationGiftFullView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity2_3NewCultivationGiftFullView:onOpen()
	self:onStart()
end

return VersionActivity2_3NewCultivationGiftFullView
