-- chunkname: @modules/logic/survival/view/map/comp/SurvivalSimpleListPart.lua

module("modules.logic.survival.view.map.comp.SurvivalSimpleListPart", package.seeall)

local SurvivalSimpleListPart = class("SurvivalSimpleListPart", LuaCompBase)

function SurvivalSimpleListPart:ctor(param)
	param = param or {}
	self._minUpdate = param.minUpdate or 1
end

function SurvivalSimpleListPart:init(go)
	local gridLayout = go:GetComponentInChildren(typeof(UnityEngine.UI.GridLayoutGroup))
	local cellSize = gridLayout.cellSize
	local spacing = gridLayout.spacing
	local padding = gridLayout.padding

	gridLayout.enabled = false

	local width = recthelper.getWidth(gridLayout.transform) - padding.left - padding.right
	local count = math.floor(width / (cellSize.x + spacing.x))

	if width - count * (cellSize.x + spacing.x) > cellSize.x then
		count = count + 1
	end

	if count < 1 then
		count = 1
	end

	self._leftOffset = padding.left
	self._csListScroll = SLFramework.UGUI.ListScrollView.Get(go)

	self._csListScroll:Init(ScrollEnum.ScrollDirV, count, cellSize.x, cellSize.y, spacing.x, spacing.y, padding.top, padding.bottom, ScrollEnum.ScrollSortNone, 10, self._minUpdate, self._onUpdateCell, self.onUpdateFinish, self._onSelectCell, self)

	local trans = gridLayout.transform

	if trans.childCount > 0 then
		self.firstItem = trans:GetChild(0).gameObject
		self._instGo = self.firstItem

		gohelper.setActive(self.firstItem, false)
	end

	self._updateCallback = self.onCellUpdate
	self._updateCallobj = self
end

function SurvivalSimpleListPart:setList(list)
	self._allCellComps = {}
	self._allCellGos = {}
	self._list = list

	self._csListScroll:UpdateTotalCount(#list)
end

function SurvivalSimpleListPart:setOpenAnimation(interval, groupNum)
	self._animInterval = interval
	self._animationStartTime = Time.time
	self._groupNum = groupNum or 1
end

function SurvivalSimpleListPart:setCellUpdateCallBack(callback, callobj, cellCls, instGo)
	self._updateCallback = callback
	self._updateCallobj = callobj
	self._cellCls = cellCls
	self._instGo = instGo
end

function SurvivalSimpleListPart:setRecycleCallBack(recycleCallback, callobj)
	self._recycleCallback = recycleCallback
	self._recycleCallobj = callobj
end

function SurvivalSimpleListPart:setCellCls(cellCls)
	self._cellCls = cellCls
end

function SurvivalSimpleListPart:setCellParam(param)
	self._cellParam = param
end

function SurvivalSimpleListPart:onCellUpdate(obj, data, index)
	if self._cellCls and obj.updateMo then
		obj:updateMo(data, index)
	end
end

function SurvivalSimpleListPart:_onUpdateCell(cellGO, index)
	local go = gohelper.findChild(cellGO, "instGo")
	local comp

	if not go then
		go = gohelper.clone(self._instGo, cellGO, "instGo")

		gohelper.setActive(go, true)
		transformhelper.setLocalPos(go.transform, self._leftOffset, 0, 0)

		if self._cellCls then
			comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, self._cellCls, self._cellParam)
			self._allCellComps[comp] = index
		end
	elseif self._cellCls then
		comp = MonoHelper.getLuaComFromGo(go, self._cellCls)
		self._allCellComps[comp] = index
	end

	if self._allCellGos[go] and self._allCellGos[go] ~= index and self._recycleCallback then
		self._recycleCallback(self._recycleCallobj, go, self._allCellGos[go], index)
	end

	self._allCellGos[go] = index

	if self._updateCallback then
		if comp then
			self._updateCallback(self._updateCallobj, comp, self._list[index + 1], index + 1)
		else
			self._updateCallback(self._updateCallobj, go, self._list[index + 1], index + 1)
		end
	end

	if self._animationStartTime then
		local animators = comp:getItemAnimators()

		for i, animator in ipairs(animators) do
			animator:Play(UIAnimationName.Open, 0, 0)
			animator:Update(0)

			local num = math.floor(index / self._groupNum)
			local openAnimTime = self._animationStartTime + self._animInterval * num
			local currentAnimatorStateInfo = animator:GetCurrentAnimatorStateInfo(0)
			local length = currentAnimatorStateInfo.length
			local nor = (Time.time - openAnimTime) / length

			animator:Play(UIAnimationName.Open, 0, nor)
			animator:Update(0)
		end
	end
end

function SurvivalSimpleListPart:getAllComps()
	return self._allCellComps
end

function SurvivalSimpleListPart:getAllGos()
	return self._allCellGos
end

function SurvivalSimpleListPart:onUpdateFinish()
	return
end

function SurvivalSimpleListPart:_onSelectCell(cellGO, isSelect)
	return
end

return SurvivalSimpleListPart
