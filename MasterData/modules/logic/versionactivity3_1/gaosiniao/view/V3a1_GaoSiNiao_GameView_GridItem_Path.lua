-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_Path.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Path", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_Path = class("V3a1_GaoSiNiao_GameView_GridItem_Path", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function V3a1_GaoSiNiao_GameView_GridItem_Path:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:removeEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_Path.super.ctor(self, ctorParam)

	self._selectedPathType = nil
	self._selectedPathSpriteId = nil
	self._isFixedPath = nil
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:setIsFixedPath(isFixedPath)
	if self._isFixedPath == isFixedPath then
		return
	end

	self._isFixedPath = isFixedPath

	if isFixedPath then
		for _, bloodItem in pairs(self._ePathSpriteId2BloodItem) do
			bloodItem:setActive(false)
		end
	else
		for _, bloodItem in pairs(self._ePathSpriteId2DisableBloodItem) do
			bloodItem:setActive(false)
		end
	end

	local _selectedPathType = self._selectedPathType

	self._selectedPathType = nil
	self._selectedPathSpriteId = nil

	self:selectPathType(_selectedPathType)
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_Path.super._editableInitView(self)

	self._ePathSpriteId2BloodItem = {}
	self._ePathSpriteId2DisableBloodItem = {}

	local t = self:transform()

	if isDebugBuild then
		local n = t.childCount

		assert(n == 8)
	end

	local i = 0

	for ePathSpriteId = GaoSiNiaoEnum.PathSpriteId.None + 1, GaoSiNiaoEnum.PathSpriteId.__End - 1 do
		local childTran = t:GetChild(i)
		local bloodItem = self:newObject(V3a1_GaoSiNiao_GameView_GridItem_Blood)

		bloodItem:init(childTran.gameObject)
		bloodItem:setActive(false)

		self._ePathSpriteId2BloodItem[ePathSpriteId] = bloodItem
		i = i + 1
	end

	for ePathSpriteId = GaoSiNiaoEnum.PathSpriteId.None + 1, GaoSiNiaoEnum.PathSpriteId.__End - 1 do
		local childTran = t:GetChild(i)
		local bloodItem = self:newObject(V3a1_GaoSiNiao_GameView_GridItem_Blood)

		bloodItem:init(childTran.gameObject)
		bloodItem:setActive(false)

		self._ePathSpriteId2DisableBloodItem[ePathSpriteId] = bloodItem
		i = i + 1
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:_getBloodItem(ePathType)
	if self._isFixedPath then
		return self._ePathSpriteId2DisableBloodItem[ePathType]
	else
		return self._ePathSpriteId2BloodItem[ePathType]
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:getPieceSprite()
	if not self._selectedPathType then
		return nil
	end

	local bloodItem = self:_getBloodItem(self._selectedPathType)

	if not bloodItem then
		return nil
	end

	return bloodItem:getPieceSprite()
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:selectPathType(ePathType)
	if self._selectedPathType == ePathType then
		return
	end

	self._selectedPathType = ePathType

	local pathInfo = ePathType and GaoSiNiaoEnum.PathInfo[ePathType]
	local ePathSpriteId
	local zRot = 0

	if pathInfo then
		ePathSpriteId = pathInfo.spriteId
		zRot = pathInfo.zRot
	end

	self:_selectPathType(ePathSpriteId)
	self:localRotateZ(zRot)
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:_selectPathType(ePathSpriteId)
	local last = self._selectedPathSpriteId

	if last == ePathSpriteId then
		return
	end

	self._selectedPathSpriteId = ePathSpriteId

	if last then
		self:_getBloodItem(last):setActive(false)
	end

	if ePathSpriteId then
		self:_getBloodItem(ePathSpriteId):setActive(true)
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:setGray_Blood(isGrey)
	if not self._selectedPathSpriteId then
		self:_setGray_Blood(isGrey)
	else
		local bloodItem = self:_getBloodItem(self._selectedPathSpriteId)

		if not bloodItem then
			self:_setGray_Blood(isGrey)

			return nil
		end

		bloodItem:setGray_Blood(isGrey)
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:hideBlood()
	if not self._selectedPathSpriteId then
		self:_hideBlood()
	else
		local bloodItem = self:_getBloodItem(self._selectedPathSpriteId)

		if not bloodItem then
			self:_hideBlood()

			return nil
		end

		bloodItem:hideBlood()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:_hideBlood()
	for _, bloodItem in pairs(self._ePathSpriteId2BloodItem) do
		bloodItem:hideBlood()
	end

	for _, bloodItem in pairs(self._ePathSpriteId2DisableBloodItem) do
		bloodItem:hideBlood()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Path:_setGray_Blood(isGrey)
	for _, bloodItem in pairs(self._ePathSpriteId2BloodItem) do
		bloodItem:setGray_Blood(isGrey)
	end

	for _, bloodItem in pairs(self._ePathSpriteId2DisableBloodItem) do
		bloodItem:setGray_Blood(isGrey)
	end
end

return V3a1_GaoSiNiao_GameView_GridItem_Path
