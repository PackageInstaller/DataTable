-- chunkname: @modules/logic/sodache/view/common/SodacheMixScrollPart.lua

module("modules.logic.sodache.view.common.SodacheMixScrollPart", package.seeall)

local SodacheMixScrollPart = class("SodacheMixScrollPart", LuaCompBase)

function SodacheMixScrollPart:init(go)
	self._scroll = go:GetComponent(typeof(ZProj.LimitedScrollRect))
	self._csMixScroll = SLFramework.UGUI.MixScrollView.Get(go)

	local startSpace = 0
	local endSpace = 0

	if self._scroll then
		local content = self._scroll.content
		local layoutGroup = content and content:GetComponent(typeof(UnityEngine.UI.LayoutGroup))

		if layoutGroup then
			local padding = layoutGroup.padding

			startSpace = padding.top
			endSpace = padding.bottom
		end

		self._csMixScroll:Init(ScrollEnum.ScrollDirV, startSpace, endSpace, {}, self._onUpdateCell, self)
	end
end

function SodacheMixScrollPart:setCellUpdateCallback(callback, callobj)
	self._updateCall = callback
	self._updateCallObj = callobj
end

function SodacheMixScrollPart:setData(datas)
	self._csMixScroll:UpdateInfo(datas, true, false)
end

function SodacheMixScrollPart:_onUpdateCell(cellGO, index, type, param)
	local instGo = gohelper.findChild(cellGO, "inst")

	if not instGo then
		instGo = gohelper.clone(param.go, cellGO)
		instGo.name = "inst"

		gohelper.setActive(instGo, true)
	end

	if self._updateCall then
		self._updateCall(self._updateCallObj, instGo, type, param.data)
	end
end

function SodacheMixScrollPart:clear()
	if self._csMixScroll then
		self._csMixScroll:Clear()
	end
end

return SodacheMixScrollPart
