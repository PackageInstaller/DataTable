-- chunkname: @modules/logic/rouge/view/RougeTalentTreeBranchPool.lua

module("modules.logic.rouge.view.RougeTalentTreeBranchPool", package.seeall)

local RougeTalentTreeBranchPool = class("RougeTalentTreeBranchPool", BaseView)

function RougeTalentTreeBranchPool:ctor(resPath)
	self._resPath = resPath or ""
end

function RougeTalentTreeBranchPool:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentTreeBranchPool:addEvents()
	return
end

function RougeTalentTreeBranchPool:removeEvents()
	return
end

function RougeTalentTreeBranchPool:_editableInitView()
	self:initPool()
end

function RougeTalentTreeBranchPool:initPool()
	self._gopool = gohelper.findChild(self.viewGO, "#go_pool")

	if not self._gopool then
		self._gopool = gohelper.create2d(self.viewGO, "#go_pool")

		local canvasGroup = gohelper.onceAddComponent(self._gopool, gohelper.Type_CanvasGroup)

		canvasGroup.alpha = 0
		canvasGroup.interactable = false
		canvasGroup.blocksRaycasts = false

		recthelper.setAnchorX(self._gopool.transform, 10000)
	end

	self._tfpool = self._gopool.transform
	self._iconIndex = 1
	self._freeIconList = {}
end

function RougeTalentTreeBranchPool:onOpen()
	return
end

function RougeTalentTreeBranchPool:onClose()
	return
end

function RougeTalentTreeBranchPool:getIcon(parentGO)
	if string.nilorempty(self._resPath) then
		logError("resPath is nil")

		return
	end

	local icon = self:getOrCreateIconInternal()

	if parentGO then
		icon.viewGO.transform:SetParent(parentGO.transform, false)
	end

	recthelper.setAnchor(icon.viewGO.transform, 0, 0)
	transformhelper.setLocalScale(icon.viewGO.transform, 1, 1, 1)

	return icon
end

function RougeTalentTreeBranchPool:getOrCreateIconInternal()
	local icon

	if self._freeIconList then
		if not #self._freeIconList then
			local freeIconCount = 0

			return freeIconCount <= 0 and self:createIconInternal() or table.remove(self._freeIconList, freeIconCount)
		end
	end
end

function RougeTalentTreeBranchPool:createIconInternal()
	local icon = RougeTalentTreeBranchItem.New()
	local go = self:getResInst(self._resPath, self._gopool, "branchitem" .. tostring(self._iconIndex))

	self._iconIndex = self._iconIndex + 1

	icon:init(go)

	return icon
end

function RougeTalentTreeBranchPool:recycleIcon(icon)
	if not gohelper.isNil(icon.viewGO) then
		icon.viewGO.transform:SetParent(self._tfpool)
	end

	if self._freeIconList then
		table.insert(self._freeIconList, icon)
	end
end

function RougeTalentTreeBranchPool:onDestroyView()
	self:release()
end

function RougeTalentTreeBranchPool:release()
	if self._freeIconList then
		for _, icon in pairs(self._freeIconList) do
			icon:dispose()
		end

		self._freeIconList = nil
	end
end

return RougeTalentTreeBranchPool
