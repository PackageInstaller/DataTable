-- chunkname: @modules/logic/store/view/DecorateMainUIView.lua

module("modules.logic.store.view.DecorateMainUIView", package.seeall)

local DecorateMainUIView = class("DecorateMainUIView", LuaCompBase)

function DecorateMainUIView:init(go)
	self.go = go
end

function DecorateMainUIView:_loadMainUI()
	if self._mainUILoader then
		self._mainUILoader:dispose()

		self._mainUILoader = nil
	end

	self._mainUILoader = MultiAbLoader.New()

	self._mainUILoader:addPath(MainUISwitchEnum.MainUIPath)
	self._mainUILoader:startLoad(self._loadFinishMainUI, self)
end

function DecorateMainUIView:_loadFinishMainUI()
	local assetItem = self._mainUILoader:getAssetItem(MainUISwitchEnum.MainUIPath)
	local viewPrefab = assetItem:GetResource(MainUISwitchEnum.MainUIPath)

	self._mainUIViewGO = gohelper.clone(viewPrefab, self.go)
	self._mainUIViewCls = {}

	local anim = self._mainUIViewGO:GetComponent(typeof(UnityEngine.Animator))

	anim.enabled = false

	for viewType, comp in pairs(MainUISwitchEnum.ChildViewComp) do
		if not comp.UIId or self._showUIId and self._showUIId == comp.UIId then
			self:_addChildView(viewType, comp)
		end
	end

	self:_showMainUI()

	if self._loadFinishCB then
		self._loadFinishCB(self._loadFinishCBObj)
	end
end

function DecorateMainUIView:_addChildView(viewType, comp)
	local _cls = comp.cls.New()

	_cls.viewGO = self._mainUIViewGO
	_cls.viewName = self.viewName
	_cls.viewParam = {
		SkinId = self._showUIId
	}

	_cls:__onInit()
	_cls:onInitView()
	_cls:onOpen()

	self._mainUIViewCls[viewType] = _cls
end

function DecorateMainUIView:showMainUI(uiid, scale, hideExtraDisPlay, cb, cbobj)
	self._showUIId = uiid
	self._showScale = scale
	self._hideExtraDisPlay = hideExtraDisPlay

	if self._mainUIViewGO then
		self:_showMainUI()
	else
		self._loadFinishCB = cb
		self._loadFinishCBObj = cbobj

		self:_loadMainUI()
	end
end

function DecorateMainUIView:_showMainUI()
	gohelper.setActive(self.go, true)

	local cls1 = self._mainUIViewCls[MainUISwitchEnum.ChildViewType.MainUIPartView]

	if cls1 then
		cls1:refreshMainUI(self._showUIId)
	end

	if self._showScale then
		self:refreshScale(self._showScale)
	end

	local cls2 = self._mainUIViewCls[MainUISwitchEnum.ChildViewType.SwitchMainActExtraDisplay]

	if cls2 then
		cls2:hideExtraDisPlay(self._hideExtraDisPlay)
	end
end

function DecorateMainUIView:hideMainUI()
	gohelper.setActive(self.go, false)
end

function DecorateMainUIView:refreshScale(scale)
	if self._mainUIViewCls then
		if self._mainUIViewCls then
			self._mainUIViewCls:_refreshScale(scale)
		end
	end
end

function DecorateMainUIView:refreshOffest(isFull)
	if self._mainUIViewCls then
		if self._mainUIViewCls then
			self._mainUIViewCls:_refreshOffest(isFull)
		end
	end
end

function DecorateMainUIView:onDestroy()
	if self._mainUIViewCls then
		for _, cls in pairs(self._mainUIViewCls) do
			if cls.onClose then
				cls:onClose()
			end

			if cls.onDestroyView then
				cls:onDestroyView()
			end
		end
	end
end

return DecorateMainUIView
