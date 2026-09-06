-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/waiting/WaitingView.lua

module(..., package.seeall)

local WaitingView = class("WaitingView")

WaitingView.Flag_BlockMsg = 1
WaitingView.Flag_Default = 2

function WaitingView:ctor()
	self._go = nil
	self._goImg = nil
	self._content = nil
	self._txtTips = nil
	self._timing = 0
	self._flags = {}
	self._tipsKeys = {}
end

function WaitingView:init(prefab)
	local container = ViewMgr.instance:getRoot(ViewRootType.Top)

	self._go = goutil.cloneAndSetParent(prefab, container.transform)
	self._txtTips = goutil.findChildTextComponent(self._go, "content/tips")
	self._goImg = self._go:GetComponent(goutil.Type_UIImage)
	self._content = goutil.findChild(self._go, "content")
	self._alpha = GoUtil.GetImageAlpha(self._goImg)

	self._go:SetActive(false)
end

function WaitingView:setTips(key)
	if key then
		self._txtTips.text = lang(key)
	end
end

function WaitingView:setParent(parent)
	if self._go then
		local transform

		if parent then
			transform = parent.transform
			layer = parent.layer
		end

		if not parent then
			transform = ViewMgr.instance:getRoot(ViewRootType.Top).transform
		end

		local layer = transform.gameObject.layer

		self._go.transform:SetParent(transform)
		Framework.TransformUtil.SetLocalScale(self._go.transform, 1, 1, 1)

		if self._go.layer ~= layer then
			Framework.GameObjectUtil.SetLayerRecursively(self._go, layer)
		end
	end
end

function WaitingView:show(key, openFlag)
	if openFlag == nil then
		openFlag = WaitingView.Flag_Default
	end

	self._flags[openFlag] = true
	self._tipsKeys[openFlag] = key

	self:_judgeTips()

	if not self._go.activeSelf then
		if self._timing == 0 then
			self._timing = 1

			self._go:SetActive(true)
			self._content:SetActive(false)
			GoUtil.SetImageAlpha(self._goImg, 0)

			local timeDelay = openFlag == WaitingView.Flag_BlockMsg and 1 or 0.3

			settimer(timeDelay, self._delayShow, self, false)
		end
	else
		self._go:SetActive(true)
		self._content:SetActive(true)
		GoUtil.SetImageAlpha(self._goImg, self._alpha)
	end

	self._go.transform:SetAsLastSibling()
end

function WaitingView:_delayShow()
	self._timing = 2

	local num = table.nums(self._flags)

	if num > 0 then
		self._content:SetActive(true)
		GoUtil.SetImageAlpha(self._goImg, self._alpha)
	end
end

function WaitingView:isShow()
	return self._go.activeSelf
end

function WaitingView:hide(openFlag)
	if openFlag == nil then
		openFlag = WaitingView.Flag_Default
	end

	self._flags[openFlag] = nil
	self._tipsKeys[openFlag] = nil

	self:_judgeTips()

	local num = table.nums(self._flags)

	if num == 0 then
		self._go:SetActive(false)

		self._timing = 0

		removetimer(self._delayShow, self)
	end
end

function WaitingView:hideAll()
	table.clear(self._flags)
	table.clear(self._tipsKeys)
	self._go:SetActive(false)

	self._timing = 0

	removetimer(self._delayShow, self)
end

function WaitingView:_judgeTips()
	local maxFlag = 0

	for flag, tipsKey in pairs(self._tipsKeys) do
		if maxFlag < flag and tipsKey ~= nil then
			maxFlag = flag
		end
	end

	self:setTips(self._tipsKeys[maxFlag])
end

WaitingView.instance = WaitingView.New()

return WaitingView
