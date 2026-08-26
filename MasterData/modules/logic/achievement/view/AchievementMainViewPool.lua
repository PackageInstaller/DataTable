-- chunkname: @modules/logic/achievement/view/AchievementMainViewPool.lua

module("modules.logic.achievement.view.AchievementMainViewPool", package.seeall)

local AchievementMainViewPool = class("AchievementMainViewPool", BaseView)

function AchievementMainViewPool:ctor(resPath)
	self._resPath = resPath or ""
end

function AchievementMainViewPool:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementMainViewPool:addEvents()
	return
end

function AchievementMainViewPool:removeEvents()
	return
end

function AchievementMainViewPool:_editableInitView()
	self:initPool()
end

function AchievementMainViewPool:initPool()
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

function AchievementMainViewPool:onOpen()
	return
end

function AchievementMainViewPool:onClose()
	return
end

function AchievementMainViewPool:getIcon(parentGO)
	if string.nilorempty(self._resPath) then
		logError("resPath is nil")

		return
	end

	local icon = self:getOrCreateIconInternal()

	icon.viewGO.transform:SetParent(parentGO.transform, false)
	recthelper.setAnchor(icon.viewGO.transform, 0, 0)
	transformhelper.setLocalScale(icon.viewGO.transform, 1, 1, 1)

	return icon
end

function AchievementMainViewPool:getOrCreateIconInternal()
	local icon

	if self._freeIconList then
		if not #self._freeIconList then
			local freeIconCount = 0

			return freeIconCount <= 0 and self:createIconInternal() or table.remove(self._freeIconList, freeIconCount)
		end
	end
end

function AchievementMainViewPool:createIconInternal()
	local icon = AchievementMainIcon.New()
	local go = self:getResInst(self._resPath, self._gopool, "icon" .. tostring(self._iconIndex))

	self._iconIndex = self._iconIndex + 1

	icon:init(go)

	return icon
end

function AchievementMainViewPool:recycleIcon(icon)
	if self._releaseDone then
		icon:dispose()

		return
	end

	if not gohelper.isNil(icon.viewGO) then
		icon.viewGO.transform:SetParent(self._tfpool)
	end

	if self._freeIconList then
		table.insert(self._freeIconList, icon)
	end
end

function AchievementMainViewPool:onDestroyView()
	self:release()
end

function AchievementMainViewPool:release()
	if self._freeIconList then
		for _, icon in pairs(self._freeIconList) do
			icon:dispose()
		end

		self._freeIconList = nil
	end

	self._releaseDone = true
end

return AchievementMainViewPool
