-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapAttrUpdateController.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapAttrUpdateController", package.seeall)

local Rouge2_MapAttrUpdateController = class("Rouge2_MapAttrUpdateController", BaseController)

function Rouge2_MapAttrUpdateController:onInit()
	self._updateAttrMap = {}
end

function Rouge2_MapAttrUpdateController:reInit()
	self:onInit()
end

function Rouge2_MapAttrUpdateController:recordUpdateAttrInfoList(attrInfoList)
	if not attrInfoList then
		return
	end

	local curSceneType = GameSceneMgr.instance:getCurSceneType()
	local recordUpdate = curSceneType == SceneType.Rouge2 or curSceneType == SceneType.Fight

	for _, attrInfo in ipairs(attrInfoList) do
		local attrId = attrInfo:getId()
		local curValue = attrInfo:getValue()
		local originValue = self:_getAndSetOriginValue(attrId, curValue)
		local updateValue = curValue - originValue

		if recordUpdate then
			self._updateAttrMap = self._updateAttrMap or {}
			self._updateAttrMap[attrId] = self._updateAttrMap[attrId] or 0
			self._updateAttrMap[attrId] = self._updateAttrMap[attrId] + updateValue
		end
	end
end

function Rouge2_MapAttrUpdateController:_getAndSetOriginValue(attrId, newValue)
	newValue = newValue or 0

	if self._originValueMap then
		local originValue = self._originValueMap[attrId]

		if not originValue then
			originValue = newValue
			self._originValueMap = self._originValueMap or {}
			self._originValueMap[attrId] = originValue
		end

		self._originValueMap[attrId] = newValue

		return originValue
	end
end

function Rouge2_MapAttrUpdateController:getUpdateAttrMap()
	return self._updateAttrMap
end

function Rouge2_MapAttrUpdateController:clearUpdateAttrMap()
	self._updateAttrMap = {}
end

function Rouge2_MapAttrUpdateController:hasAnyCareerAttrUpdate()
	local updateAttrMap = self:getUpdateAttrMap()
	local curAttrList = Rouge2_Model.instance:getHeroAttrInfoList()

	if not curAttrList then
		return
	end

	for _, attrMo in ipairs(curAttrList) do
		local updateValue = updateAttrMap and updateAttrMap[attrMo.attrId]

		if updateValue and updateValue > 0 then
			return true
		end
	end
end

function Rouge2_MapAttrUpdateController:getAddAttrPoint()
	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()

	if curInteractive then
		if not curInteractive.addAttrPoint then
			local addAttrPoint = 0

			return addAttrPoint or 0
		end
	end
end

Rouge2_MapAttrUpdateController.instance = Rouge2_MapAttrUpdateController.New()

return Rouge2_MapAttrUpdateController
