-- chunkname: @modules/logic/versionactivity3_0/karong/view/KaRongRoleTagView.lua

module("modules.logic.versionactivity3_0.karong.view.KaRongRoleTagView", package.seeall)

local KaRongRoleTagView = class("KaRongRoleTagView", BaseView)

function KaRongRoleTagView:onInitView()
	self._goPage1 = gohelper.findChild(self.viewGO, "Root/#go_Page1")
	self._txtName1 = gohelper.findChildText(self.viewGO, "Root/#go_Page1/Data/txt_Name/#txt_Name1")
	self._txtNum1 = gohelper.findChildText(self.viewGO, "Root/#go_Page1/Data/txt_Num/#txt_Num1")
	self._txtDate1 = gohelper.findChildText(self.viewGO, "Root/#go_Page1/Data/txt_Date/#txt_Date1")
	self._txtBlood1 = gohelper.findChildText(self.viewGO, "Root/#go_Page1/Data/txt_Blood/#txt_Blood1")
	self._goPage2 = gohelper.findChild(self.viewGO, "Root/#go_Page2")
	self._txtName2 = gohelper.findChildText(self.viewGO, "Root/#go_Page2/Data/txt_Name/#txt_Name2")
	self._txtNum2 = gohelper.findChildText(self.viewGO, "Root/#go_Page2/Data/txt_Num/#txt_Num2")
	self._txtDate2 = gohelper.findChildText(self.viewGO, "Root/#go_Page2/Data/txt_Date/#txt_Date2")
	self._txtBlood2 = gohelper.findChildText(self.viewGO, "Root/#go_Page2/Data/txt_Blood/#txt_Blood2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function KaRongRoleTagView:onClickModalMask()
	self:closeThis()
end

function KaRongRoleTagView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_role_culture_open)

	if self.viewParam then
		local actId = VersionActivity3_0Enum.ActivityId.KaRong
		local tagCfg = Activity176Config.instance:getDogTagCfg(actId, self.viewParam)

		if tagCfg then
			self._txtName1.text = tagCfg.content1
			self._txtDate1.text = tagCfg.content2
			self._txtNum1.text = tagCfg.content3
			self._txtBlood1.text = tagCfg.content4
		end
	end
end

return KaRongRoleTagView
