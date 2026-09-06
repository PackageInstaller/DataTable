-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itemget/view/ItemGetFlyItem.lua

module("logic.extensions.itemget.view.ItemGetFlyItem", package.seeall)

local ItemGetFlyItem = class("ItemGetFlyItem")

function ItemGetFlyItem:ctor(go)
	self.mainGO = go.gameObject

	self:buildUI()
end

function ItemGetFlyItem:OnDestroy()
	self:onExit()
end

function ItemGetFlyItem:buildUI()
	self._sequence = self.mainGO:GetComponent(UnityTweensType.TweenSequence)
	self._delayTween = self.mainGO:GetComponent(UnityTweensType.TweenEmpty)
	self._icon = self:getGo("icon")
	self._name = self:getGo("name"):GetComponent(goutil.Type_UIText)
	self._canvasGroup = self.mainGO:GetComponent(ComponentType.CanvasGroup)
end

function ItemGetFlyItem:getGo(path)
	return goutil.findChild(self.mainGO, path)
end

function ItemGetFlyItem:onExit()
	self._delayTween:RemoveListener()
	self._sequence:RemoveListener()
	self._sequence:Stop()
	self._delayTween:Stop()
	MaterialMgr.resetAll(self._icon)
	GameUtil.setAnchoredPos(self.mainGO, -1000, 0)
end

function ItemGetFlyItem:initCallBack(onStartCallBack, onEndCallBack, object)
	self._onStartCallBack = onStartCallBack
	self._onEndCallBack = onEndCallBack
	self._object = object
end

function ItemGetFlyItem:begin(obj)
	self._delayTween:AddListener(self._onStartFly, self)
	self._sequence:AddListener(self._onEndFly, self)

	self._canvasGroup.alpha = 1

	self._sequence:Begin()

	local mo = obj.mo

	self._name.text = GameUtil.HtmlColorTxt(obj.name, obj.color) .. " x" .. mo.num

	local proxy = MaterialMgr.setCellByGId(mo.materialType, mo.id, self._icon)

	goutil.setActive(self.mainGO, false)
	goutil.setActive(self.mainGO, true)

	if proxy and proxy.view then
		proxy:setAutoTips(false)
		proxy.binder:setNum(0)
		Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.36, 0.36, 0.36)
	end
end

function ItemGetFlyItem:_onStartFly()
	self._onStartCallBack(self._object)
end

function ItemGetFlyItem:_onEndFly()
	self._canvasGroup.alpha = 0

	self._onEndCallBack(self._object, self)
end

return ItemGetFlyItem
