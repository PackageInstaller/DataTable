--公会战房间信息
local this={};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:SetData(proto,currGFID)
    self.data=proto;
    if self.data then
        self:SetCfgID(currGFID,self.data.cfg_id);
    end
end

function this:SetCfgID(cfgId,index)    
    if cfgId then
        local cfg=Cfgs.CfgGuildFightRoom:GetByID(cfgId);
        if cfg then
            self.cfg=cfg.infos[index];
        else
            LogError("未找到公会战房间配置信息！");
        end
    end
end

function this:GetCfgID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetCfg()
    return self.cfg;
end

function this:GetID()
    return self.data and self.data.id or nil;
end

--是否开启
function this:IsOpen()
    if self.data and ((CSAPI.GetServerTime()>=self.data.end_time) or self.data.cur_hp<=0) then
        return false;
    end
    return true;
end

--返回创建消耗
function this:GetCreateCost()
    local cfg=nil;
    if self.cfg then
        local costCfg=Cfgs.CfgGuildFightItemTb:GetByID(self.cfg.openCostId);
        cfg=costCfg.rewards[1]
    end
    return cfg
end

--返回参与消耗
function this:GetJoinCost()
    local cfg=nil;
    if self.cfg then
        local costCfg=Cfgs.CfgGuildFightItemTb:GetByID(self.cfg.entryCostId);
        cfg=costCfg.rewards[1]
    end
    return cfg
end

--返回创建者ID
function this:GetCreaterID()
    return self.data and self.data.c_id or nil
end

--返回创建者名称
function this:GetCreaterName()
    return self.data and self.data.c_name or nil;
end

--返回当前敌人血量
function this:GetCurrHP()
    return self.data and self.data.cur_hp or 0;
end

function this:GetHP()
    return self.data and self.data.hp or 0;
end

--返回房间类型
function this:GetRoomType()
    return self.data and self.data.type or nil;
end

--返回结束时间
function this:GetEndTime()
    return self.data and self.data.end_time or nil;
end

--推荐等级
function this:GetLv()
    return self.cfg and self.cfg.lv or 0;
end

--推荐战力
function this:GetFightVal()
    return self.cfg and self.cfg.fightVal or 0;
end

--可否多人参与
function this:MultJoin()
    return self.cfg and self.cfg.multiJoin or false;
end

--可否单人参与
function this:SingleJoin()
    return self.cfg and self.cfg.singleJoin or false;
end

--返回房间名称
function this:GetName()
    return self.cfg and self.cfg.name or "";
end

--返回房间下标
function this:GetIndex()
    return self.cfg and self.cfg.index or 0;
end

--返回难度
function this:GetDifficulty()
    return self.cfg and self.cfg.difficulty or 1;
end

--返回难度描述
function this:GetDiffStr()
    local diff=self:GetDifficulty();
    local arr={LanguageMgr:GetByID(27030),LanguageMgr:GetByID(27031),LanguageMgr:GetByID(27032),LanguageMgr:GetByID(27033),LanguageMgr:GetByID(27034),LanguageMgr:GetByID(27035),LanguageMgr:GetByID(27036)}
    return arr[diff];
end

function this:GetModel()
    return self.cfg and self.cfg.model or nil;
end

--预览敌人等级
function this:GetPreviewLv()
    return self.cfg and self.cfg.previewLv or 1;
end

--预览敌人信息
function this:GetEnemyPreview()
    return self.cfg and self.cfg.enemyPreview or nil;
end

--预览的道具信息
function this:GetItemPreview()
    return self.cfg and self.cfg.itemPreview or nil;
end

--根据怪物组信息读取boss名称
function this:GetBossName()
    local name="";
    if self.cfg and self.cfg.attackGoupId then
        local mGroupCfg=Cfgs.MonsterGroup:GetByID(self.cfg.attackGoupId);
        if mGroupCfg then
            for k,v in ipairs(mGroupCfg.stage) do
                for _,val in ipairs(v.monsters) do
                    local monster=Cfgs.MonsterData:GetByID(val);
                    if monster and monster.isboss then
                        name=monster.name;
                        break;
                    end
                end
            end
        end
    end
    return name;
end

return this;