-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/save/AirWorkSaveItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.save.AirWorkSaveItem", package.seeall)

local M = class("AirWorkSaveItem")

function M:ctor(container)
	self._go = container.gameObject
	self._normalGo = goutil.findChild(self._go, "stateNormal")
	self._noneGo = goutil.findChild(self._go, "stateNull")
	self._lockGo = goutil.findChild(self._go, "stateLock")
	self._selectGo = goutil.findChild(self._go, "imgSelect")
	self._passTestGo = goutil.findChild(self._go, "stateNormal/imgPass")
	self._putOnGo = goutil.findChild(self._go, "stateNormal/imgPut")
	self._img = goutil.findChildImageComponent(self._go, "stateNormal/imgLevel")
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnClick"))
	self._idTxt = goutil.findChildTextComponent(self._go, "stateNormal/txtID")

	self:_bindEvents()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	self._clickFunc = false
	self._clickHandler = false

	self:_unbindEvents()
end

function M:updateData(mo)
	self._mo = mo

	goutil.setActive(self._normalGo, self._mo.created)
	goutil.setActive(self._noneGo, not self._mo.created and self._mo.unLock)
	goutil.setActive(self._lockGo, not self._mo.unLock)

	if self._mo.created then
		goutil.setActive(self._passTestGo, self._mo.data:getPassTest())
		goutil.setActive(self._putOnGo, self._mo.data:getOnlineStatus())

		self._cover = self._mo.data:getCover()

		self:_updateSceneImage(self._cover)

		self._idTxt.text = self._mo.data:getId()
	end
end

function M:_onSceneImageUpdate(_, cover)
	if self._cover == cover then
		self:_updateSceneImage(cover)
	end
end

function M:_updateSceneImage(cover)
	AirWorkShopUtil.loadSceneImage(self._img, cover, true)
end

function M:setSeleted(isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

function M:setClickCallBack(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClick()
	if self._clickFunc then
		self._clickFunc(self._clickHandler, self._mo)
	end
end

return M
