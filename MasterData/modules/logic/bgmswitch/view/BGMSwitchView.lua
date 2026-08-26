-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchView.lua

module("modules.logic.bgmswitch.view.BGMSwitchView", package.seeall)

local BGMSwitchView = class("BGMSwitchView", BaseView)
local bg = {
	"singlebg/bgmtoggle_singlebg/bg_beijing.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingyintian.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingxiyang.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingwanshang.png"
}

function BGMSwitchView:onInitView()
	self._gomechine = gohelper.findChild(self.viewGO, "#go_mechine")
	self._gomusics = gohelper.findChild(self.viewGO, "#go_musics")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BGMSwitchView:addEvents()
	self.addEventCb(self, WeatherController.instance, WeatherEvent.WeatherChanged, self._updateBg, self)
end

function BGMSwitchView:removeEvents()
	self.removeEventCb(self, WeatherController.instance, WeatherEvent.WeatherChanged, self._updateBg, self)
end

function BGMSwitchView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_updateBg()
end

function BGMSwitchView:_updateBg()
	local curReport, _ = WeatherController.instance:getCurrReport()

	if curReport then
		if not curReport.lightMode then
			local lightMode = 1

			if lightMode <= #bg then
				self._simagebg:LoadImage(bg[lightMode])
			else
				logError("天气光照索引大于背景图数量")
			end
		end
	end
end

function BGMSwitchView:onUpdateParam()
	return
end

function BGMSwitchView:onOpen()
	local viewParam = self.viewParam

	if self.viewParam then
		if self.viewParam == true then
			self._viewAnim:Play("thumbnail", 0, 0)
		elseif viewParam.isGuide then
			self:_initCamera()
			MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
			gohelper.setActive(self._viewGO, false)
		end
	else
		self:_initCamera()
	end

	BGMSwitchAudioTrigger.play_ui_replay_open()
end

function BGMSwitchView:_initCamera()
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._cameraAnimator.enabled = true
	self._cameraTrace = CameraMgr.instance:getCameraTrace()
	self._cameraTrace.enabled = true

	local path = self.viewContainer:getSetting().otherRes[1]

	self._cameraAnimator.runtimeAnimatorController = self.viewContainer._abLoader:getAssetItem(path):GetResource()

	self._cameraAnimator:Play("bgm_open", 0, 0)
	self._viewAnim:Play("open", 0, 0)
end

function BGMSwitchView:onClose()
	self._viewAnim:Play("close", 0, 0)

	if not self.viewParam then
		self._cameraAnimator:Play("bgm_close")
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end

	BGMSwitchAudioTrigger.play_ui_replay_close()
end

function BGMSwitchView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return BGMSwitchView
