-- chunkname: @modules/logic/login/view/LoginBgView.lua

module("modules.logic.login.view.LoginBgView", package.seeall)

local LoginBgView = class("LoginBgView", BaseView)

function LoginBgView:ctor(containerPath)
	LoginBgView.super.ctor(self)

	self._containerPath = containerPath
end

function LoginBgView:onInitView()
	self._goBgRoot = gohelper.findChild(self.viewGO, self._containerPath)
end

function LoginBgView:onOpen()
	self._curCfg = LoginPageController.instance:getCurPageCfg()
	self._goSpine = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.LoginView).viewGO, "spine")

	self:_showBgType()
end

function LoginBgView:_showBgType()
	if self._curCfg and self._curCfg.audioId and self._curCfg.audioId ~= 0 then
		AudioMgr.instance:trigger(self._curCfg.audioId)
	end

	gohelper.setActive(self._goSpine, false)

	if not self._goBg then
		self._goBg = self.viewContainer:getResInst(self.viewContainer._viewSetting.otherRes[1], self._goBgRoot, "bgview2")
		self._imgBg = gohelper.findChildSingleImage(self._goBg, "background")
	end

	local delay = 0.1

	if self._imgBg and self.viewContainer._viewSetting.otherRes[2] then
		delay = 2

		self._imgBg:LoadImage(self.viewContainer._viewSetting.otherRes[2], self._bgHasLoaded, self)
	end

	TaskDispatcher.runDelay(self._bgHasLoaded, self, delay)
end

function LoginBgView:_bgHasLoaded()
	TaskDispatcher.cancelTask(self._bgHasLoaded, self)
	LoginController.instance:dispatchEvent(LoginEvent.OnLoginBgLoaded)
end

function LoginBgView:onClose()
	AudioMgr.instance:trigger(AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	TaskDispatcher.cancelTask(self._bgHasLoaded, self)

	if self._curCfg and self._curCfg.stopAudioId and self._curCfg.stopAudioId ~= 0 then
		AudioMgr.instance:trigger(self._curCfg.stopAudioId)
	end
end

function LoginBgView:onDestroyView()
	if self._imgBg then
		self._imgBg:UnLoadImage()
	end
end

return LoginBgView
