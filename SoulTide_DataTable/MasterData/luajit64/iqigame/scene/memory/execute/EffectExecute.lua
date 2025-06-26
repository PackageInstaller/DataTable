-- chunkname: @IQIGame\\Scene\\Memory\\Execute\\EffectExecute.lua

local EffectExecute = {
	entityID = 0
}

function EffectExecute.New(element)
	local obj = Clone(EffectExecute)

	obj:Init(element)

	return obj
end

function EffectExecute:Init(element)
	self.mapRoot = element.scene.View
end

function EffectExecute:Execute(args)
	local effectID = tonumber(args[1])
	local pointID = tonumber(args[2])
	local parentPath = args[3]

	self:StopEffect()

	self.entityID = GameEntry.Effect:PlayMountPointEffect(effectID, pointID, 0, self.mapRoot.transform:Find(parentPath).gameObject)
end

function EffectExecute:OnDestroy()
	self:StopEffect()
end

function EffectExecute:StopEffect()
	if self.entityID ~= 0 then
		GameEntry.Effect:StopEffect(self.entityID)

		self.entityID = 0
	end
end

return EffectExecute
