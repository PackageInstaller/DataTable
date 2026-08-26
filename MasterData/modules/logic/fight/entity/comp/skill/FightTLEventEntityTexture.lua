-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventEntityTexture.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventEntityTexture", package.seeall)

local FightTLEventEntityTexture = class("FightTLEventEntityTexture", FightTimelineTrackItem)

function FightTLEventEntityTexture:onTrackStart(fightStepData, duration, paramsArr)
	local targetType = paramsArr[1]

	self._targetEntitys = nil

	if targetType == "1" then
		self._targetEntitys = {}

		table.insert(self._targetEntitys, FightHelper.getEntity(fightStepData.fromId))
	elseif targetType == "2" then
		self._targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)
	elseif not string.nilorempty(targetType) then
		local entityMgr = FightGameMgr.entityMgr
		local entityId = fightStepData.stepUid .. "_" .. targetType
		local tempEntity = entityMgr:getEntity(entityId)

		if tempEntity then
			self._targetEntitys = {}

			table.insert(self._targetEntitys, tempEntity)
		else
			logError("找不到实体, id: " .. tostring(targetType))

			return
		end
	end

	self._texVariable = paramsArr[3]

	local texturePath = paramsArr[2]

	if not string.nilorempty(texturePath) then
		self._texturePath = ResUrl.getRoleSpineMatTex(texturePath)
		self._loader = MultiAbLoader.New()

		self._loader:addPath(self._texturePath)
		self._loader:startLoad(self._onLoaded, self)
	end
end

function FightTLEventEntityTexture:_onLoaded(multiAbLoader)
	local texAssetItem = multiAbLoader:getFirstAssetItem()
	local texture = texAssetItem and texAssetItem:GetResource(self._texturePath)

	for _, entity in ipairs(self._targetEntitys) do
		local mat = entity.spineRenderer:getReplaceMat()

		mat:SetTexture(self._texVariable, texture)
	end
end

function FightTLEventEntityTexture:_clear()
	if not self._loader then
		return
	end

	self._loader:dispose()

	self._loader = nil

	for _, entity in ipairs(self._targetEntitys) do
		local mat = entity.spineRenderer:getReplaceMat()

		mat:SetTexture(self._texVariable, nil)
	end
end

function FightTLEventEntityTexture:onDestructor()
	self:_clear()
end

return FightTLEventEntityTexture
