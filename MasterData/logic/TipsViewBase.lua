-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/TipsViewBase.lua

module("logic.extensions.tips.view.TipsViewBase", package.seeall)

local TipsViewBase = class("TipsViewBase", ViewComponent)

TipsViewBase.tipsPosition = nil

function TipsViewBase:buildUI()
	self._customInput = UICustomInput.Get(self.mainGO)
end

function TipsViewBase:destroyUI()
	self._customInput = nil
end

function TipsViewBase:onEnter()
	self._customInput:AddListener(self._onCustomInputCallback, self)

	if TipsViewBase.tipsPosition then
		self.mainGO.transform.localPosition = TipsViewBase.tipsPosition
		TipsViewBase.tipsPosition = nil
	end
end

function TipsViewBase:onExit()
	self._customInput:RemoveListener()
end

function TipsViewBase:_onCustomInputCallback(hover)
	if GuideModel.instance:isGuiding() then
		return nil
	end

	if not hover and self:_isOnTop() then
		self:close()
	end
end

function TipsViewBase:_isOnTop()
	local tf = self.mainGO.transform
	local parent = tf.parent

	if not parent then
		return true
	end

	local idx = tf:GetSiblingIndex()
	local count = parent.childCount - 1

	if idx == count then
		return true
	end

	for i = idx, count do
		local sibling = parent:GetChild(i)

		if sibling.gameObject.activeSelf then
			return nil
		end
	end

	return true
end

return TipsViewBase
