-- chunkname: @modules/logic/gm/view/GM_LoginVideoView.lua

module("modules.logic.gm.view.GM_LoginVideoView", package.seeall)

local GM_LoginVideoView = class("GM_LoginVideoView", BaseView)

function GM_LoginVideoView:onOpenFinish()
	self:_startMGLoader()
end

function GM_LoginVideoView:onDestroyView()
	if self._dropDownComp then
		self._dropDownComp:RemoveOnValueChanged()

		self._dropDownComp = nil
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function GM_LoginVideoView:_startMGLoader()
	if not self._loader then
		self._loader = SequenceAbLoader.New()

		self._loader:addPath(GM_LoginVideoView.GMVideoTestPath)
		self._loader:startLoad(self._onLoadFinish, self)
	end
end

function GM_LoginVideoView:_onLoadFinish(loader)
	local prefabAssetItem = loader:getAssetItem(GM_LoginVideoView.GMVideoTestPath)

	if not prefabAssetItem then
		return
	end

	local prefab = prefabAssetItem:GetResource(GM_LoginVideoView.GMVideoTestPath)

	self._gologinvideotest = gohelper.clone(prefab, self.viewGO)

	self:_showTest()
end

function GM_LoginVideoView:_showTest()
	self._dropDownComp = gohelper.findChildDropdown(self._gologinvideotest, "Dropdown")
	self._videoNameList = {
		"19208003k",
		"19208001w",
		"256010803k",
		"256010801w"
	}

	self._dropDownComp:ClearOptions()
	self._dropDownComp:AddOptions(self._videoNameList)
	self._dropDownComp:AddOnValueChanged(self._onDropDownChanged, self)
end

function GM_LoginVideoView:_onDropDownChanged(index)
	local loginContainer = ViewMgr.instance:getContainer(ViewName.LoginView)

	if loginContainer then
		local videoName = self._videoNameList[index + 1]

		if videoName then
			loginContainer:dispatchEvent(LoginEvent.OnLoginVideoSwitch, string.format("videos/%s.mp4", videoName))
		end
	end
end

GM_LoginVideoView.GMVideoTestPath = "ui/viewres/gm/gmloginvideotest.prefab"

return GM_LoginVideoView
