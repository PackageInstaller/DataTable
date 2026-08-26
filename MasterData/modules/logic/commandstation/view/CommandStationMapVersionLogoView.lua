-- chunkname: @modules/logic/commandstation/view/CommandStationMapVersionLogoView.lua

module("modules.logic.commandstation.view.CommandStationMapVersionLogoView", package.seeall)

local CommandStationMapVersionLogoView = class("CommandStationMapVersionLogoView", BaseView)

function CommandStationMapVersionLogoView:onInitView()
	self._goVersion = gohelper.findChild(self.viewGO, "#go_Version")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapVersionLogoView:_editableInitView()
	self._loader = PrefabInstantiate.Create(self._goVersion)
	self._versionLogoAnimator = nil
end

function CommandStationMapVersionLogoView:onOpen()
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.ChangeVersionId, self._onChangeVersionId, self)
	self:_onChangeVersionId()
end

function CommandStationMapVersionLogoView:_onChangeVersionId()
	if self._versionLogoAnimator then
		self._versionLogoAnimator:Play("close", self._closeAnimDone, self)

		return
	end

	self:_loadVersionLogo()
end

function CommandStationMapVersionLogoView:_loadVersionLogo()
	local hasVersionLogo = CommandStationMapModel.instance:getVersionId() ~= CommandStationEnum.AllVersion

	if not hasVersionLogo then
		return
	end

	self._loader:dispose()

	local versionId = CommandStationMapModel.instance:getVersionId()
	local path = string.format("ui/viewres/commandstation/commandstation_versionitem_%s.prefab", versionId)

	self._loader:startLoad(path, self._onLoadedDone, self)

	self._versionId = versionId
end

function CommandStationMapVersionLogoView:_onLoadedDone()
	local go = self._loader:getInstGO()

	self._versionLogoAnimator = go and SLFramework.AnimatorPlayer.Get(go)

	if self._versionLogoAnimator then
		self._versionLogoAnimator:Play("open", self._openAnimDone, self)
	end
end

function CommandStationMapVersionLogoView:_closeAnimDone()
	self._loader:dispose()

	self._versionLogoAnimator = nil

	self:_loadVersionLogo()
end

function CommandStationMapVersionLogoView:_openAnimDone()
	return
end

function CommandStationMapVersionLogoView:onClose()
	return
end

return CommandStationMapVersionLogoView
