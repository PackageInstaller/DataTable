-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/YearCardChangeRole.lua

module("logic.extensions.yearcard.view.yearcard2026.YearCardChangeRole", package.seeall)

local YearCardChangeRole = class("YearCardChangeRole")

function YearCardChangeRole:ctor()
	self._cacheColor = Color.New(1, 1, 1, 1)
end

function YearCardChangeRole:setData(roleList)
	self._roleList = roleList
end

function YearCardChangeRole:setTxtName(txtName)
	self._txtName = txtName
end

function YearCardChangeRole:setView(view)
	self._view = view
end

function YearCardChangeRole:onEnter(defaultIndex)
	settimer(5, self._tickChangeSkinId, self)

	self._tickCount = defaultIndex or 1

	self:_changePetShow(true)
end

function YearCardChangeRole:onExit()
	removetimer(self._tickChangeSkinId, self)
	removetimer(self._updateChangeAlpha, self)
end

function YearCardChangeRole:setTickCount(index)
	self._tickCount = index
end

function YearCardChangeRole:_tickChangeSkinId()
	self._tickCount = self._tickCount + 1

	self:_changePetShow()
end

function YearCardChangeRole:_changePetShow(force)
	self._roleIdx = self._tickCount % 2
	self._view.skinId = self._roleList[self._roleIdx].skinId
	self._txtName.text = PetSkinConfig.instance:getPetSkinName(self._view.skinId)
	self._totalTime = 1

	if force then
		self._totalTime = 0
	end

	self._currTime = 0
	self._percent = 0

	settimer(0, self._updateChangeAlpha, self)
end

function YearCardChangeRole:_updateChangeAlpha()
	self._currTime = self._currTime + Time.deltaTime
	self._percent = self._totalTime <= 0 and 1 or self._currTime / self._totalTime

	for k, v in pairs(self._roleList) do
		local isHit = k == self._roleIdx

		for _, img in ipairs(v.rawImgs) do
			self._cacheColor.a = isHit and self._percent or 1 - self._percent
			img.color = self._cacheColor
		end
	end

	if self._percent >= 1 then
		removetimer(self._updateChangeAlpha, self)
	end
end

return YearCardChangeRole
