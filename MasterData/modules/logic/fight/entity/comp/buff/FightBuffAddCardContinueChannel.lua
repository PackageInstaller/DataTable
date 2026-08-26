-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffAddCardContinueChannel.lua

module("modules.logic.fight.entity.comp.buff.FightBuffAddCardContinueChannel", package.seeall)

local FightBuffAddCardContinueChannel = class("FightBuffAddCardContinueChannel")

FightBuffAddCardContinueChannel.Count2BuffEffectName = {
	nil,
	"effect2",
	"effect3",
	"effect4"
}

function FightBuffAddCardContinueChannel:onBuffStart(entity, buffMo)
	self.entity = entity
	self.buffUid = buffMo.uid

	FightController.instance:registerCallback(FightEvent.ALF_AddRecordCardUI, self.onUpdateRecordCard, self)

	self.effectRes, self.recordCount = self:getEffectRes(buffMo)
	self.loader = MultiAbLoader.New()

	self.loader:addPath(FightHelper.getEffectUrlWithLod(self.effectRes))
	self.loader:startLoad(self.createEffect, self)
end

function FightBuffAddCardContinueChannel:getEffectRes(buffMo)
	local buffCo = buffMo:getCO()
	local featureList = FightStrUtil.instance:getSplitString2Cache(buffCo.features, true)
	local count = 0

	for _, feature in ipairs(featureList) do
		if feature[1] == 923 then
			count = feature[3]

			break
		end
	end

	local entityMo = self.entity:getMO()
	local skinId = entityMo.skin
	local co = lua_fight_sp_effect_alf_record_buff_effect.configDict[skinId]

	co = co or lua_fight_sp_effect_alf_record_buff_effect.configList[1]

	local effectRes = co[FightBuffAddCardContinueChannel.Count2BuffEffectName[count]]

	return effectRes, count
end

function FightBuffAddCardContinueChannel:createEffect(loader)
	self.effectWrap = self.entity.effect:addHangEffect(self.effectRes, ModuleEnum.SpineHangPointRoot)

	self.effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entity.id, self.effectWrap)
	self.entity.buff:addLoopBuff(self.effectWrap)
	self:refreshEffect()
end

function FightBuffAddCardContinueChannel:onBuffEnd()
	self:clear()
end

function FightBuffAddCardContinueChannel:clear()
	self:resetMat()
	self:clearTextureLoader()

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.effectWrap then
		self.entity.buff:removeLoopBuff(self.effectWrap)
		self.entity.effect:removeEffect(self.effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, self.effectWrap)

		self.effectWrap = nil
	end

	FightController.instance:unregisterCallback(FightEvent.ALF_AddRecordCardUI, self.onUpdateRecordCard, self)
end

function FightBuffAddCardContinueChannel:dispose()
	self:clear()
end

function FightBuffAddCardContinueChannel:onUpdateRecordCard()
	self:refreshEffect()
end

FightBuffAddCardContinueChannel.PreFix = "root/l_boli"
FightBuffAddCardContinueChannel.RecordCountNameDict = {
	[2] = {
		"l_boli01_di",
		"l_boli01_di03"
	},
	[3] = {
		"l_boli01_di",
		"l_boli01_di02",
		"l_boli01_di03"
	},
	[4] = {
		"l_boli01_di",
		"l_boli01_di02",
		"l_boli01_di03",
		"l_boli01_di04"
	}
}

function FightBuffAddCardContinueChannel:clearTextureLoader()
	if self.textureLoader then
		self.textureLoader:dispose()

		self.textureLoader = nil
	end
end

function FightBuffAddCardContinueChannel:getAlfCacheSkillList()
	if self.entity.heroCustomComp then
		local alfCustomComp = self.entity.heroCustomComp:getCustomComp()

		if self.entity.heroCustomComp then
			return self.entity.heroCustomComp:getCacheSkillList()
		end
	end
end

function FightBuffAddCardContinueChannel:refreshEffect()
	if not self.effectWrap then
		return
	end

	self:clearTextureLoader()

	self.skillResList = self.skillResList or {}

	tabletool.clear(self.skillResList)

	local cacheSkillList = self:getAlfCacheSkillList()

	if not cacheSkillList then
		self:resetMat()

		return
	end

	if #cacheSkillList < 2 then
		self:resetMat()

		return
	end

	self.textureLoader = MultiAbLoader.New()

	for i = 2, #cacheSkillList do
		local skillCo = lua_skill.configDict[cacheSkillList[i]]
		local icon = skillCo and skillCo.icon

		if not string.nilorempty(icon) then
			local fullRes = ResUrl.getSkillIcon(icon)

			self.textureLoader:addPath(fullRes)
			table.insert(self.skillResList, fullRes)
		else
			table.insert(self.skillResList, nil)
		end
	end

	self.textureLoader:startLoad(self._refreshEffect, self)
end

function FightBuffAddCardContinueChannel:_refreshEffect()
	local pathList = FightBuffAddCardContinueChannel.RecordCountNameDict[self.recordCount]
	local go = self.effectWrap.effectGO

	for i = 1, self.recordCount do
		local path = pathList[i]
		local fullPath = string.format("%s/%s/mask", FightBuffAddCardContinueChannel.PreFix, path)
		local matGo = gohelper.findChild(go, fullPath)
		local skillRes = self.skillResList[i]

		if skillRes then
			::label_11_0::

			local assetItem = self.textureLoader:getAssetItem(skillRes)
			local texture = assetItem and assetItem:GetResource()

			if matGo then
				local render = matGo:GetComponent(gohelper.Type_Render)
				local mat = render and render.material

				if mat then
					mat:SetTexture("_MainTex", texture)
				end
			end
		end
	end
end

function FightBuffAddCardContinueChannel:resetMat()
	if not self.effectWrap then
		return
	end

	local pathList = FightBuffAddCardContinueChannel.RecordCountNameDict[self.recordCount]
	local go = self.effectWrap.effectGO

	for i = 1, self.recordCount do
		local path = pathList[i]
		local fullPath = string.format("%s/%s/mask", FightBuffAddCardContinueChannel.PreFix, path)
		local matGo = gohelper.findChild(go, fullPath)

		if matGo then
			local render = matGo:GetComponent(gohelper.Type_Render)
			local mat = render and render.material

			if mat then
				mat:SetTexture("_MainTex", nil)
			end
		end
	end
end

return FightBuffAddCardContinueChannel
