-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampFindingView.lua

module("logic.extensions.funcamp.view.FuncampFindingView", package.seeall)

local FuncampFindingView = class("FuncampFindingView", ViewComponent)

function FuncampFindingView:buildUI()
	FuncampFindingView.super.buildUI(self)

	self._goSuc = self:getGo("success")
	self._txtDistance = self:getTxt("distance/txt")
	self._arrow = self:getGo("distance/arrow")
end

function FuncampFindingView:onEnter()
	FuncampFindingView.super.onEnter(self)
	goutil.setActive(self._goSuc, true)

	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	print("lbc=======================", self._posX, self._posY)
	GlobalDispatcher:addListener(GlobalNotify.LeaveCityDone, self._onEnterScene, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onOpenView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnNpcCreated, self._onNpcCreat, self)
	settimer(0, self._onNpcCreat, self)
	settimer(3, self._onStartFind, self, false)
end

function FuncampFindingView:onExit()
	FuncampFindingView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LeaveCityDone, self._onEnterScene, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onOpenView, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnNpcCreated, self._onNpcCreat, self)
	removetimer(self._onStartFind, self)
	removetimer(self._onNpcCreat, self)
end

function FuncampFindingView:_onStartFind()
	goutil.setActive(self._goSuc, false)
	FloatWordMgr.instance:show("快根据箭头指示，找到入侵者吧~")
end

function FuncampFindingView:_showDistance()
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

function FuncampFindingView:_onOpenView(view)
	if view.viewName ~= self._viewPresentor.viewName and view.viewName ~= ViewName.MainUI and view.viewName ~= ViewName.ItemFly and view.viewName ~= ViewName.VirtualJoystick and view.viewName ~= ViewName.HorseLanternView and view.viewName ~= ViewName.GMView then
		self:close()
	end
end

function FuncampFindingView:_onEnterScene()
	self:close()
end

function FuncampFindingView:_onNpcCreat()
	if self._posX and self._posY then
		self:_showDistance()
	else
		self._posX, self._posY = FunCampController.instance:getNpcPosXAndY()
	end
end

return FuncampFindingView
