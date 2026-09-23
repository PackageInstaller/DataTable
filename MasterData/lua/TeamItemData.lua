-- 队员信息
local this = {};
function this.New()
    this.__index = this.__index or this;
    local tab = {};
    setmetatable(tab, this);
    return tab
end
-- data:{
-- cid=,--当前卡牌的cid
-- row,--站位值
-- col,--站位值
-- fuid,--卡牌持有者uID(好友助战卡牌才有，其它没有)
-- card_info,--是否有卡牌数据（PVP附带，其它没有）
-- bIsNpc,--当前卡牌类型是卡牌还是NPC，不传默认为卡牌(这个主要用来区分NPC和卡牌)
-- index,--下标位置,没有就不传
-- }
function this:SetData(data)
    self.cid = data.cid;
    self.row = data.row;
    self.col = data.col;
    self.fuid = data.fuid;
    self.card_info = data.card_info;
    self.index = data.index;
    self.isLeader = data.isLeader;
    self.nStrategyIndex = data.nStrategyIndex or 1;
    if data.isForce then
        self.isForce = data.isForce;
    else
        self.isForce = false;
    end
    if data.bIsNpc then
        self.bIsNpc = data.bIsNpc;
    else
        self.bIsNpc = false;
    end
    self:LoadCfg();
end

function this:LoadCfg()
    if self.card_info ~= nil then
        local card = CharacterCardsData(self.card_info);
        self.cfgId = card:GetCfgID();
        self.cfg = card:GetCfg();
        self.cardCfgId = card:GetCfgID();
        self.card = card;
    else
        if self.cid ~= nil then
            if self.bIsNpc == false then
                local card = FormationUtil.FindTeamCard(self.cid);
                if card then
                    self.cfgId = card:GetCfgID();
                    self.cfg = card:GetCfg();
                    self.cardCfgId = card:GetCfgID();
                    self.card = card; -- 卡牌数据
                end
            else
                local card = FormationUtil.FindTeamCard(self.cid);
                if card then
                    self.cfgId = card:GetCfgID();
                    self.card = card;
                    self.cfg = Cfgs.MonsterData:GetByID(self:GetCfgID());
                    self.cardCfgId = self.cfg.card_id;
                else
                    LogError("读取NPC配置出错！" .. tostring(self.cid));
                end
            end
        end
    end
end

function this:Getfuid()
    return self.fuid or nil;
end

-- 返回卡牌的CfgID（NPC的表中读取的是card_id）
function this:GetCardCfgID()
    if self.cardCfgId == nil then
        self:LoadCfg();
    end
    return self.cardCfgId;
end

function this:GetCfgID()
    if self.cfgId == nil then
        self:LoadCfg();
    end
    return self.cfgId;
end

function this:GetCfg()
    if self.cfg == nil then
        self:LoadCfg();
    end
    return self.cfg;
end

-- 返回卡牌数据，如果当前数据为NPC时则返回nil
function this:GetCard()
    if self.card == nil then
        self:LoadCfg();
    end
    return self.card;
end

function this:GetFitDirection()
    local fit = -1;
    if self.bIsNpc == false then
        local card = self:GetCard();
        if card then
            fit = card:GetFitDirection();
        end
    end
    return fit;
end

-- itemData:TeamItemData
function this:IsUnite(cfgId)
    local isUnite = false;
    if self.bIsNpc == false then
        local card = self:GetCard();
        if card then
            isUnite = card:IsInUnite(cfgId);
        end
    end
    return isUnite;
end

function this:GetGrids()
    local cfg = self:GetCfg();
    return cfg and cfg.grids or nil;
end

function this:GetCost()
    local card = self:GetCard();
    return card and card:GetCost() or nil;
end

function this:GetNP()
    local card = self:GetCard();
    return card and card:GetCurDataByKey("np") or nil;
end

function this:GetProperty()
    local card = self:GetCard();
    if self:IsAssist() and not self:IsNPC() then
        local num = 0
        if card then
            num = card:GetData().performance or 0;
        end
        return num;
    else
        return card and card:GetProperty() or nil;
    end
end

function this:GetRoleTag()
    local card = self:GetCard();
    return card and card:GetRoleTag() or nil;
end

function this:GetName()
    local card = self:GetCard();
    return card and card:GetName() or nil;
end

function this:GetMainType()
    local coreType = nil;
    if self.bIsNpc == false then
        local card = self:GetCard();
        if card then
            coreType = card:GetCfg().main_type -- card:GetMainType();
        end
    else
        local card = self:GetCard();
        if card then
            coreType = card.cardCfg and card.cardCfg.main_type or nil;
        end
    end
    return coreType;
end

function this:GetTeamIcon()
    local teamIcon = nil;
    local _nClass = nil;
    if self.bIsNpc == false then
        local card = self:GetCard();
        if card then
            _nClass = card:GetCfg().nClass -- card:GetMainType();
        end
    else
        local card = self:GetCard();
        if card then
            _nClass = card.cardCfg and card.cardCfg.nClass or nil;
        end
    end
    teamIcon = _nClass and Cfgs.CfgTeamEnum:GetByID(_nClass).icon or nil
    return teamIcon;
end

function this:GetID()
    return self.cid;
end

function this:GetIcon()
    local card = self:GetCard();
    return card and card:GetIcon() or nil;
end

function this:GetSmallImg()
    local card = self:GetCard();
    return card and card:GetSmallImg() or nil;
end

function this:GetStrategyIndex()
    return self.nStrategyIndex and self.nStrategyIndex or nil;
end

function this:SetStrategyIndex(index)
    self.nStrategyIndex = index;
end

-- 返回技能列表 普通技能、被动技能、特殊技能，不会返回OVERLOAD
-- function this:GetSkillsList()
--     local list=nil;
--     if self.card_info~=nil then --卡牌
--         list={};
--         local card=self:GetCard();
--         local _f={SkillMainType.CardNormal,SkillMainType.CardSpecial};
--         for k,v in ipairs(_f) do
--             local l=card:GetSkills(v);
--             for _,val in ipairs(l) do
--                 if val.type~=9 then --OverLoad不返回
--                     table.insert(list,val.upgrade_type,val);
--                 end
--             end
--         end
--     elseif self.cfg and self.cfg.jcSkills then --NPC 怪物
--         list={};
--         for k,v in ipairs(self.cfg.jcSkills) do
--             local cfg = Cfgs.skill:GetByID(v)
--             if cfg.type~=9 then
--                 table.insert(list,cfg);
--             end
--         end
--     end
--     return list;
-- end

function this:GetLv()
    local card = self:GetCard();
    if self.bIsNpc then
        return card and card:GetCfg().level or 0;
    else
        return card and card:GetLv() or 0;
    end
end

function this:GetBreakLv()
    local card = self:GetCard();
    return card and card:GetBreakLevel() or 1;
end

function this:GetQuality()
    local card = self:GetCard();
    return card and card:GetQuality() or 1;
end

function this:GetIndex()
    return self.index or 0;
end

-- 是否强制上阵
function this:IsForce()
    return self.isForce;
end

-- 返回模型id
function this:GetModelID()
    local card = self:GetCard();
    return card and self:GetCard():GetSkinID() or nil;
end

function this:GetModelCfg()
    local card = self:GetCard();
    return card and self:GetCard():GetModelCfg() or nil;
end

function this:GetHot()
    local card = self:GetCard();
    return card and self:GetCard():GetHot() or nil;
end

function this:IsNPC()
    return self.bIsNpc;
end

function this:IsAssist()
    return self.index == 6;
end

-- 返回队员类型描述
function this:GetItemTypeDesc()
    local str = nil
    if self:IsForce() then
        str = LanguageMgr:GetTips(14031);
    elseif self:IsAssist() then
        str = LanguageMgr:GetTips(14030);
    elseif self:IsNPC() then
        str = LanguageMgr:GetTips(14032);
    end
    return str;
end

function this:IsLeader()
    return self.isLeader == true;
end

function this:GetHolderInfo()
    return FormationUtil.GetPlaceHolderInfo(self:GetGrids());
end

function this:GetFormationType()
    return FormationUtil.GetFormationType(self:GetGrids())
end

function this:GetHaloCfg()
    if self.card then -- 有卡牌数据则以卡牌数据为准
        return self.card:GetHaloCfg()
    elseif self.cfg and self.cfg.halo then -- 否则以配置表数据为准
        return Cfgs.cfgHalo:GetByID(self.cfg.halo[1])
    end
end

function this:GetHaloInfo()
    if self.card then -- 有卡牌数据则以卡牌数据为准
        return self.card:GetHaloInfo()
    elseif self.cfg and self.cfg.halo then -- 否则以配置表数据为准
        local info=HaloData.New();
        info:SetData( {
            cfgid=self.cfg.halo[1],
            cid=self:GetID(),
            level=1,
            exp=0,
            equips={},
        });
        return info
    end
    return nil;
end

function this:GetCurCoordPos()
    local curHalo=self:GetHaloInfo();
    return curHalo and curHalo:GetCurCoordPos() or nil;
end

-- 返回培养信息
function this:GetRaisingInfo()
    local infos = nil;
    if not self:IsNPC() and not self:IsAssist() and self.card then -- 有卡牌数据则以卡牌数据为准
        infos = {};
        -- 计算天赋等级、技能等级、芯片品质、芯片等级、角色等级的培育度
        local giftLv = 0;
        local skillLv = 0;
        local skills = self.card:GetSkillByType(SkillMainType.CardNormal);
        local subTalents = self.card:GetDeputyTalent().use or {}
        if skills then
            for k, v in ipairs(skills) do
                local cfg = Cfgs.skill:GetByID(v.id)
                if cfg then
                    skillLv = cfg.lv + skillLv;
                else
                    LogError("未在skill表中找到对应id：" .. tostring(v.id) .. "的配置数据");
                end
            end
        end
        for k, v in ipairs(subTalents) do
            if v~=0 then
                local cfg = Cfgs.CfgSubTalentSkill:GetByID(v)
                if cfg then
                    giftLv =cfg.lv + giftLv
                else
                    LogError("未在CfgSubTalentSkill表中找到对应id：" .. tostring(v) .. "的配置数据");
                end
            end
        end
        local equipQuality = 0;
        local equipLv = 0;
        local equips = self.card:GetEquips();
        if equips then
            for k, v in ipairs(equips) do
                equipQuality = equipQuality + v:GetQuality();
                equipLv = equipLv + v:GetLv();
            end
        end
        infos.numGift = giftLv;
        infos.numSkill = skillLv;
        infos.numChipQuality = equipQuality;
        infos.numChipLevel = equipLv;
        infos.numCardLevel = self:GetLv();
    end
    return infos;
end

-- 返回用于格子显示的数据
--[[
function this:GetGridObjData()
    local oData=GridObjectData();
    oData:Init({
        id=self.cid,
        cfg=self:GetCfg();
    	icon=self:GetIcon(),
    	quality=self:GetQuality(),
    	iconScale=1,
    	iconLoader=ResUtil.RoleCard,
    	lv=self:GetLv(),
    	count=0,
    	stars=0,
    	isNew=false,
    	isLock=false,
        desc="",
    });
    return oData;
end]]

function this:GetFormatData()
    if self.cid and self.row and self.col then
        return {
            cid = self.cid,
            row = self.row,
            col = self.col,
            fuid = self.fuid,
            card_info = self.card_info,
            type = self.type,
            index = self.index,
            bIsNpc = self.bIsNpc,
            isForce = self.isForce,
            isLeader = self.isLeader,
            nStrategyIndex = self:GetStrategyIndex()
        };
    end
    return nil;
end

function this:GetSaveData()
    if self.cid and self.row and self.col then
        local cid = self.cid;
        local isNpc, s1, s2 = FormationUtil.CheckNPCID(cid);
        if isNpc and s2 then
            cid = tonumber(s2);
        end
        return {
            cid = cid,
            row = self.row,
            col = self.col,
            fuid = self.fuid,
            card_info = self.card_info,
            type = self.type,
            index = self.index,
            bIsNpc = self.bIsNpc,
            isForce = self.isForce,
            isLeader = self.isLeader,
            nStrategyIndex = self:GetStrategyIndex()
        };
    end
    return nil;
end

function this:GetFightCardData()
    local card = self:GetCard();
    if card then
        local data = card:GetTotalProperty();
        data.isLeader = self.isLeader;
        data.hp = data.maxhp;
        data.nClass = card:GetCamp();
        data.real_cid = card:GetCfgID();
        data.cuid = card:GetCfgID();
        data.break_level = card:GetBreakLevel();
        data.intensify_level = card:GetIntensifyLevel();
        data.hp_percent = 1;
        data.col = self.col;
        data.row = self.row;
        data.level = card:GetLv();
        data.model = card:GetSkinIDBase();
        data.modelA = RoleTool.GetElseSkin(card);
        data.haloInfo=card:GetHaloInfo():GetData();
        local cid = card:GetID();
        local strs = StringUtil:split(cid, "_");
        if self:IsAssist() and not self:IsNPC() and strs then
            cid = tonumber(strs[2]);
        end
        local tab = {
            cid = cid,
            -- uid=self.fuid or PlayerClient:GetUid(),
            fuid = self.fuid,
            uid = PlayerClient:GetUid(),
            row = self.row,
            col = self.col,
            maxhp = data.maxhp,
            data = data
        }
        return tab;
    end
    return nil;
end

return this;
