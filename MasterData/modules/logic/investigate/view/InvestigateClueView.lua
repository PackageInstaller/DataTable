-- chunkname: @modules/logic/investigate/view/InvestigateClueView.lua

module("modules.logic.investigate.view.InvestigateClueView", package.seeall)

local InvestigateClueView = class("InvestigateClueView", BaseView)

function InvestigateClueView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "#simage_role")
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_role1")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_role1/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_role1/#simage_role2")
	self._simagerole3 = gohelper.findChildSingleImage(self.viewGO, "#go_role1/#simage_role3")
	self._txtrole = gohelper.findChildText(self.viewGO, "#txt_role")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateClueView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function InvestigateClueView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function InvestigateClueView:_btncloseOnClick()
	self:closeThis()
end

function InvestigateClueView:onOpen()
	local co = lua_investigate_info.configDict[self.viewParam.id]

	if not co then
		return
	end

	self._txtrole.text = co.unlockDesc

	local isFirstEntrance = co.entrance == 1

	gohelper.setActive(self._simagerole, not isFirstEntrance)
	gohelper.setActive(self._gorole1, isFirstEntrance)

	if isFirstEntrance then
		for i, v in ipairs(lua_investigate_info.configList) do
			if v.group == co.group then
				local simage = self["_simagerole" .. i]

				if simage then
					simage:LoadImage(v.icon)
				end
			end
		end
	else
		self._simagerole:LoadImage(co.icon)
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_leimi_celebrity_get)
end

function InvestigateClueView:onClose()
	if self.viewParam.isGet then
		InvestigateController.instance:dispatchEvent(InvestigateEvent.ShowGetEffect)
	end
end

function InvestigateClueView:onDestroyView()
	self._simagerole:UnLoadImage()
end

return InvestigateClueView
