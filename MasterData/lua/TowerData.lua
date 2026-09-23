local this = {};
local MonsterInfo=require "MonsterInfo"

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

--设置配置
function this:Init(_info)
	self.info = _info
	if _info then
		self.monsterInfos = _info.monster_infos
		self.cfg = Cfgs.MainLine:GetByID(_info.id)
	end
end

function this:GetCfg()
	return self.cfg
end

function this:GetID()
	return self.info and self.info.id
end

function this:IsOpen()
	if self.cfg then
		return DungeonMgr:IsDungeonOpen(self.cfg.id)
	end
	return false,""
end

--怪物信息
function this:GetMonsterInfos()
	local datas = {}
	if self.monsterInfos then
		for i, v in pairs(self.monsterInfos) do
			local cardCfg = Cfgs.CardData:GetByID(v.monster_id)
			table.insert(datas,{
				cfg = cardCfg,
				hp = v.tower_hp / 100,
				sp= v.tower_sp / 100,
				index = v.configIndex
			})
		end
		if #datas > 0 then
			table.sort(datas,function (a,b)
				return a.index < b.index
			end)
		end
	else
		local stage = self:GetMonsterStage()
        if stage and stage.monsters and #stage.monsters > 0 then
			for i, v in ipairs(stage.monsters) do
				local info = MonsterInfo.New()
				info:Init(v)
				local properties = info:GetProperties()
				if info:GetCardCfg() == nil then
					LogError(string.format("获取不到卡牌配置表数据！！！怪物id：%s，卡牌配置表id：%s",v,info:GetCfg().card_id))
				end
				table.insert(datas,{
					cfg = info:GetCardCfg(),
					hp = 1,
					sp = properties.sp / 100
				})
			end
        end
	end
	return datas
end

function this:GetDirllMonsterInfos()
	local infos = {}
	local datas = {}
	if self.monsterInfos then
		for i, v in pairs(self.monsterInfos) do
			table.insert(infos,{
				hp = v.tower_hp,
				sp= v.tower_sp,
				index = v.configIndex
			})
		end
		if #infos > 0 then
			table.sort(infos,function (a,b)
				return a.index < b.index
			end)
		end
	end
	local cfgStage = self:GetMonsterStage()
	if cfgStage and cfgStage.monsters then
		for i, v in ipairs(cfgStage.monsters) do
			local cfgMonster = Cfgs.MonsterData:GetByID(v)
			if cfgMonster and cfgMonster.maxhp then
				table.insert(datas,math.ceil((infos[i] and infos[i].hp or 100) / 100 * cfgMonster.maxhp))
			end
		end
	end
	return datas
end

function this:GetMonsterPos()
	local stage = self:GetMonsterStage()
	if stage and stage.formation then
		local cfg = Cfgs.MonsterFormation:GetByID(stage.formation)
		return cfg and cfg.coordinate
	end
end

function this:GetMonsterStage()
	local cfgGroup = Cfgs.MonsterGroup:GetByID(self.cfg.nGroupID)
	return cfgGroup and cfgGroup.stage and cfgGroup.stage[1]
end

function this:IsPass()
	local data = DungeonMgr:GetDungeonData(self.cfg.id)	
	return data and data:IsPass()
end

function this:GetPreView()
	return self.cfg and self.cfg.enemyPreview
end

function this:IsHard()
	return self.cfg and self.cfg.difficulty
end

return this;