-- chunkname: @modules/logic/versionactivity1_3/buff/view/VersionActivity1_3BuffTipView.lua

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffTipView", package.seeall)

local VersionActivity1_3BuffTipView = class("VersionActivity1_3BuffTipView", BaseView)

function VersionActivity1_3BuffTipView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._simageTipsBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_TipsBG")
	self._simageBuffIcon = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_BuffIcon")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_Title")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_Desc")
	self._gounlockcardtip = gohelper.findChild(self.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/Effect/#go_unlockcardtip")
	self._txtEffectDesc = gohelper.findChildText(self.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_EffectDesc")
	self._goLockTips = gohelper.findChild(self.viewGO, "Root/Info/#go_LockTips")
	self._txtLockTips = gohelper.findChildText(self.viewGO, "Root/Info/#go_LockTips/#txt_LockTips")
	self._btnUnLock = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Info/#btn_UnLock")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Info/#btn_lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3BuffTipView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnUnLock:AddClickListener(self._btnUnLockOnClick, self)
	self._btnlock:AddClickListener(self._btnlockOnClick, self)
end

function VersionActivity1_3BuffTipView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnUnLock:RemoveClickListener()
	self._btnlock:RemoveClickListener()
end

function VersionActivity1_3BuffTipView:_btnlockOnClick()
	return
end

function VersionActivity1_3BuffTipView:_btnCloseOnClick()
	self:closeThis()
end

function VersionActivity1_3BuffTipView:_btnUnLockOnClick()
	Activity126Rpc.instance:sendUnlockBuffRequest(VersionActivity1_3Enum.ActivityId.Act310, self._config.id)
end

function VersionActivity1_3BuffTipView:_editableInitView()
	self._simageclosebtn = gohelper.findChildSingleImage(self.viewGO, "#btn_Close")

	self._simageclosebtn:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	self._simageTipsBG:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_tipsbg"))
	gohelper.setActive(self._gounlockcardtip, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_seek_open)
end

function VersionActivity1_3BuffTipView:onUpdateParam()
	return
end

function VersionActivity1_3BuffTipView:onOpen()
	self._config = self.viewParam[1]
	self._isLock = self.viewParam[2]
	self._canGet = self.viewParam[3]
	self._buffItem = self.viewParam[4]
	self._txtTitle.text = self._config.name
	self._txtDesc.text = self._config.desc

	local icon = string.format("singlebg/v1a3_bigbufficon_singlebg/%s.png", self._config.bigIcon)

	self._simageBuffIcon:LoadImage(icon)

	self._txtEffectDesc.text = ""

	local skillId = self._config.skillId

	if self._config.dreamlandCard > 0 then
		local dreamlandConfig = lua_activity126_dreamland_card.configDict[self._config.dreamlandCard]

		skillId = dreamlandConfig.skillId

		gohelper.setActive(self._gounlockcardtip, true)
	end

	if skillId > 0 then
		local effectConfig = lua_skill_effect.configDict[skillId]

		self._txtEffectDesc.text = FightConfig.instance:getSkillEffectDesc("", effectConfig)
	end

	gohelper.setActive(self._btnlock, false)
	gohelper.setActive(self._btnUnLock, self._isLock and self._canGet)

	if not self._canGet then
		if self._config.taskId > 0 then
			gohelper.setActive(self._btnUnLock, false)

			do
				local taskConfig = lua_activity113_task.configDict[self._config.taskId]

				self._txtLockTips.text = string.format("%s%s", taskConfig.desc, luaLang("dungeon_unlock"))
			end
		else
			self._txtLockTips.text = self._buffItem:showLockToast()
		end
	end

	gohelper.setActive(self._txtLockTips, self._isLock and not self._canGet)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onUnlockBuffReply, self._onUnlockBuffReply, self)
end

function VersionActivity1_3BuffTipView:_onUnlockBuffReply()
	self:closeThis()
end

function VersionActivity1_3BuffTipView:onClose()
	return
end

function VersionActivity1_3BuffTipView:onDestroyView()
	self._simageclosebtn:UnLoadImage()
	self._simageTipsBG:UnLoadImage()
end

return VersionActivity1_3BuffTipView
