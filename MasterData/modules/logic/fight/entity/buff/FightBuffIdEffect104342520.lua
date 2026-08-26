-- chunkname: @modules/logic/fight/entity/buff/FightBuffIdEffect104342520.lua

module("modules.logic.fight.entity.buff.FightBuffIdEffect104342520", package.seeall)

local FightBuffIdEffect104342520 = class("FightBuffIdEffect104342520", FightBaseClass)
local layer2Bone = {
	{},
	{
		"rxz_hua_zg_01",
		"rxz_hua_zg_02",
		"rxz_hua_zg_03"
	},
	{
		"rxz_hua_zg_04",
		"rxz_hua_zg_05",
		"rxz_hua_zg_06",
		"rxz_hua_zg_07"
	},
	{
		"rxz_hua_zg_08",
		"rxz_hua_zg_10",
		"rxz_hua_zg_11",
		"rxz_hua_zg_12",
		"rxz_hua_zg_13",
		"rxz_hua_zg_14",
		"rxz_hua_zg_15",
		"rxz_hua_zg_16",
		"rxz_hua_zg_18",
		"rxz_hua_zg_19",
		"rxz_hua_zg_20",
		"rxz_hua_zg_21"
	},
	{
		"rxz_hua_zg_31",
		"rxz_zhugan08",
		"rxz_zhugan11"
	},
	{
		"rxz_hua_zg_24",
		"rxz_hua_zg_25",
		"rxz_hua_zg_17"
	},
	{
		"rxz_zhugan09",
		"rxz_zhugan20"
	}
}
local addEffect = {
	{},
	{
		{
			hang = "special4",
			name = "v3a4_rxz/rxz_innate1_start_s04",
			time = 2
		}
	},
	{
		{
			hang = "special5",
			name = "v3a4_rxz/rxz_innate1_start_s05",
			time = 2
		}
	},
	{
		{
			hang = "special6",
			name = "v3a4_rxz/rxz_innate1_start_s06",
			time = 2
		}
	},
	{
		{
			hang = "special12",
			name = "v3a4_rxz/rxz_innate1_start_s012",
			time = 2
		}
	},
	{
		{
			hang = "special10",
			name = "v3a4_rxz/rxz_innate1_start_s010",
			time = 2
		}
	},
	{
		{
			hang = "special15",
			name = "v3a4_rxz/rxz_innate1_start_s015",
			time = 2
		}
	}
}
local removeEffect = {
	{},
	{
		{
			hang = "special4",
			name = "v3a4_rxz/rxz_innate1_end_s04",
			time = 2
		}
	},
	{
		{
			hang = "special5",
			name = "v3a4_rxz/rxz_innate1_end_s05",
			time = 2
		}
	},
	{
		{
			hang = "special6",
			name = "v3a4_rxz/rxz_innate1_end_s06",
			time = 2
		}
	},
	{
		{
			hang = "special12",
			name = "v3a4_rxz/rxz_innate1_end_s012",
			time = 2
		}
	},
	{
		{
			hang = "special10",
			name = "v3a4_rxz/rxz_innate1_end_s010",
			time = 2
		}
	},
	{
		{
			hang = "special15",
			name = "v3a4_rxz/rxz_innate1_end_s015",
			time = 2
		}
	}
}

function FightBuffIdEffect104342520:onConstructor(buffData)
	self.buffData = buffData
	self.lasetLayer = 1
	self.entity = FightGameMgr.entityMgr:getById(buffData.entityId)
	self.uniqueId2Effect = {}

	self:com_registMsg(FightMsgId.OnAddBuff, self.onAddBuff)
	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
	self:com_registMsg(FightMsgId.OnUpdateBuff, self.onUpdateBuff)
end

function FightBuffIdEffect104342520:onAddBuff(buffData)
	if buffData.uid ~= self.buffData.uid then
		return
	end

	self.lasetLayer = 7

	self:showRemoveEffect()
	self:refreshBone()

	self.lasetLayer = self.buffData.layer
end

function FightBuffIdEffect104342520:onRemoveBuff(buffData)
	if buffData.uid ~= self.buffData.uid then
		return
	end
end

function FightBuffIdEffect104342520:onUpdateBuff(buffData)
	if buffData.uid ~= self.buffData.uid then
		return
	end

	if not self.lasetLayer then
		local lastLayer = 1

		if lastLayer > self.buffData.layer then
			self:showRemoveEffect()
		else
			self:showAddEffect()
		end

		self.lasetLayer = self.buffData.layer

		self:refreshBone()
	end
end

function FightBuffIdEffect104342520:showAddEffect()
	for i = self.lasetLayer + 1, self.buffData.layer do
		local addEffect = addEffect[i]

		if not addEffect then
			return
		end

		for k, v in pairs(addEffect) do
			local name = v.name
			local hang = v.hang
			local time = v.time

			self:playEffect(name, hang, time)
			AudioMgr.instance:trigger(462040954)
		end
	end
end

function FightBuffIdEffect104342520:showRemoveEffect()
	for i = self.buffData.layer + 1, self.lasetLayer do
		local removeEffect = removeEffect[i]

		if not removeEffect then
			return
		end

		for k, v in pairs(removeEffect) do
			local name = v.name
			local hang = v.hang
			local time = v.time

			self:playEffect(name, hang, time)
			AudioMgr.instance:trigger(462040955)
		end
	end
end

function FightBuffIdEffect104342520:playEffect(name, hang, time)
	local effectWrap = self.entity.effect:addHangEffect(name, hang)

	if effectWrap then
		effectWrap:setLocalPos(0, 0, 0)

		self.uniqueId2Effect[effectWrap.uniqueId] = effectWrap

		self:com_registTimer(self.releaseEffect, time, effectWrap)
	end
end

function FightBuffIdEffect104342520:releaseEffect(effectWrap)
	self.entity.effect:removeEffect(effectWrap)
end

function FightBuffIdEffect104342520:refreshBone()
	local layer = self.buffData.layer
	local Skeleton = self.entity.spine._skeletonAnim.Skeleton

	if layer == 1 then
		for k, v in pairs(layer2Bone) do
			for k2, boneName in pairs(v) do
				local bone = Skeleton:FindBone(boneName)

				if bone then
					bone.Active = false
				end
			end
		end

		return
	end

	for k, v in pairs(layer2Bone) do
		local state = k <= layer

		for k2, boneName in pairs(v) do
			local bone = Skeleton:FindBone(boneName)

			if bone then
				bone.Active = state
			end
		end
	end
end

function FightBuffIdEffect104342520:onDestructor()
	for k, effectWrap in pairs(self.uniqueId2Effect) do
		self.entity.effect:removeEffect(effectWrap)
	end
end

return FightBuffIdEffect104342520
