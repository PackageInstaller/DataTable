-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/D6AttrFilterItem.lua

module("logic.extensions.backpack.view.filterview.D6AttrFilterItem", package.seeall)

local M = class("D6AttrFilterItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self._normalGo = goutil.findChild(self.mainGO, "normal")
	self._selectGo = goutil.findChild(self.mainGO, "select")
	self._btn = Astral.ButtonAdapter.Get(self.mainGO)

	self._btn:AddClickListener(self._onClick, self)

	self._txtNormal = goutil.findChildComponent(self.mainGO, "normal/Text", UIComponentType.TextMeshProUGUI)
	self._txtSelect = goutil.findChildComponent(self.mainGO, "select/Text", UIComponentType.TextMeshProUGUI)
	self._imgSelect = goutil.findChildImageComponent(self.mainGO, "select/icon")
	self._imgNormal = goutil.findChildImageComponent(self.mainGO, "normal/icon")
end

function M:OnDestroy()
	self.mainGO = nil

	self._btn:RemoveClickListener()
end

function M:_onClick()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_D6_ATTR_ITEM_CLICK, self._attrId, self._isSelect)
end

function M:setData(data)
	if not data then
		return
	end

	self._attrId = data.id
	self._txtNormal.text = data.name
	self._txtSelect.text = data.name

	IconLoader.setSprite(self._imgSelect, IconType.Skinlib, data.iconName)
	IconLoader.setSprite(self._imgNormal, IconType.Skinlib, data.iconName)
end

function M:setSelect(isSelect)
	self._isSelect = isSelect

	goutil.setActive(self._normalGo, not isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

return M
