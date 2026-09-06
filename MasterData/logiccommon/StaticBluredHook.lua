-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/effect/StaticBluredHook.lua

module("logiccommon.common.effect.StaticBluredHook", package.seeall)

local StaticBluredHook = class("StaticBluredHook")
local invisible_z = 9999999

function StaticBluredHook:ctor()
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
end

function StaticBluredHook:start(go)
	self._isBluring = true
	self._blurGo = go

	local posx, posy, posz = Framework.TransformUtil.GetLocalPos(self._blurGo.transform, nil, nil, nil)

	self._saveX = posx
	self._saveY = posy
	self._saveZ = posz

	Framework.TransformUtil.SetLocalPos(self._blurGo.transform, posx, posx, invisible_z)

	self._canvas = UGUIToolHelper.FindCanvas(go)
	self._cahches = {}

	self:_hideGrayMaskAndWaiting()
end

function StaticBluredHook:stop()
	if self._blurGo then
		Framework.TransformUtil.SetLocalPos(self._blurGo.transform, self._saveX, self._saveY, self._saveZ)
	end

	self._saveX = nil
	self._saveY = nil
	self._saveZ = nil
	self._saveLayer = nil
	self._canvas = nil
	self._blurGo = nil
	self._isBluring = nil

	if self._cahches then
		for k, v in pairs(self._cahches) do
			Framework.TransformUtil.SetLocalPos(v.go.transform, v.x, v.y, v.z)
		end

		self._cahches = nil
	end
end

function StaticBluredHook:_onViewOpened(view)
	if not self._isBluring then
		return
	end

	self:_trySaveGameObject(view.mainGO)
	self:_hideGrayMaskAndWaiting()
end

function StaticBluredHook:_hideGrayMaskAndWaiting()
	local grayMaskGo = ViewMgr.instance._grayMaskGO

	if grayMaskGo then
		self:_trySaveGameObject(grayMaskGo, true)
	end

	local waitingGo = WaitingView.instance._go

	if waitingGo then
		self:_trySaveGameObject(waitingGo, true)
	end
end

function StaticBluredHook:_trySaveGameObject(go, force)
	if force or self:_isUppon(go) then
		local posx, posy, posz = Framework.TransformUtil.GetLocalPos(go.transform, nil, nil, nil)

		self._cahches[go] = {
			z = 0,
			go = go,
			x = posx,
			y = posy
		}

		Framework.TransformUtil.SetLocalPos(go.transform, posx, posx, invisible_z)
	end
end

function StaticBluredHook:_tryResumeGameObject(go)
	if not self._cahches then
		return
	end

	if self._cahches[go] then
		local cfg = self._cahches[go]

		Framework.TransformUtil.SetLocalPos(go.transform, cfg.x, cfg.y, cfg.z)

		self._cahches[go] = nil
	end
end

function StaticBluredHook:_isUppon(go)
	if not self._canvas then
		return true
	end

	local canvas = UGUIToolHelper.FindCanvas(go)

	if not canvas then
		return
	end

	if canvas == self._canvas then
		local sibIdx = go.transform:GetSiblingIndex()
		local blurGoSibIdx = self._blurGo.transform:GetSiblingIndex()

		return blurGoSibIdx < sibIdx
	end

	local cam = canvas.worldCamera
	local blurGoCam = self._canvas.worldCamera

	if cam == blurGoCam then
		return canvas.sortingOrder > self._canvas.sortingOrder
	end

	if not cam then
		return true
	end

	if not blurGoCam then
		return
	end

	return cam.depth > blurGoCam.depth
end

function StaticBluredHook:_onViewClosed(view)
	if not self._cahches then
		return
	end

	self:_tryResumeGameObject(view.mainGO)
end

StaticBluredHook.instance = StaticBluredHook.New()

return StaticBluredHook
