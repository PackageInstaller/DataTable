-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingView.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingView", package.seeall)

local WeakPathFindingView = class("WeakPathFindingView", ViewComponent)

function WeakPathFindingView:buildUI()
	WeakPathFindingView.super.buildUI(self)

	self._goSuc = self:getGo("success")
	self._txtDistance = self:getTxt("distance/txt")
	self._arrow = self:getGo("distance/arrow")
end

function WeakPathFindingView:onEnter()
	WeakPathFindingView.super.onEnter(self)
	goutil.setActive(self._goSuc, true)

	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	self._posX, self._posY = WeakPathFindingController.instance:getNpcPosXAndY()

	if self._posX and self._posY then
		self:_showDistance()
	end

	GlobalDispatcher:addListener(GlobalNotify.LeaveCityDone, self._onEnterScene, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onOpenView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnNpcCreated, self._onNpcCreat, self)
	settimer(0.2, self._showDistance, self)
	settimer(3, self._onStartFind, self, false)
end

function WeakPathFindingView:onExit()
	WeakPathFindingView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LeaveCityDone, self._onEnterScene, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onOpenView, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnNpcCreated, self._onNpcCreat, self)
	removetimer(self._onStartFind, self)
	removetimer(self._showDistance, self)
end

function WeakPathFindingView:_onStartFind()
	goutil.setActive(self._goSuc, false)
	FloatWordMgr.instance:show(lang("快根据箭头指示，找到虚弱精灵吧~"))
end

function WeakPathFindingView:_showDistance()
	if self._posX and self._posY then
		local dist = self._mainPlayer.transform:dist(self._posX, self._posY)

		self._txtDistance.text = langPara("%.2f", dist)

		local formX, formY = self._mainPlayer.transform:getPos()
		local angle = Vector2.Angle(Vector2.New(self._posX - formX, self._posY - formY), Vector2.up)

		if self._posX - formX > 0 then
			angle = -angle
		end

		Framework.TransformUtil.SetLocalRotation(self._arrow.transform, 0, 0, angle)
	end
end

function WeakPathFindingView:_onOpenView(view)
	if view.viewName ~= self._viewPresentor.viewName and view.viewName ~= ViewName.MainUI and view.viewName ~= ViewName.ItemFly and view.viewName ~= ViewName.VirtualJoystick and view.viewName ~= ViewName.HorseLanternView and view.viewName ~= ViewName.GMView then
		self:close()
	end
end

function WeakPathFindingView:_onEnterScene()
	self:close()
end

function WeakPathFindingView:_onNpcCreat()
	if self._posX and self._posY then
		self:_showDistance()
	else
		self._posX, self._posY = WeakPathFindingController.instance:getNpcPosXAndY()
	end
end

return WeakPathFindingView
