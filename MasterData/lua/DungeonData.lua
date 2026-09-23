--副本数据

local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

--设置数据
function this:SetData(targetData)
    self.data = targetData;
    self:Init(self.data.id);
end
--设置配置
function this:Init(cfgId)
    self.cfg = Cfgs.MainLine:GetByID(cfgId);
end
--获取配置
function this:GetCfg()
    return self.cfg;
end

function this:GetType()
    return self.cfg and self.cfg.type
end

function this:GetID()
    return self.cfg and self.cfg.id or -1;
end

function this:GetGroup()
     return self.cfg and self.cfg.group
end

--是否开启
function this:IsOpen()
    return DungeonMgr:IsDungeonOpen(self:GetID());
end
--是否通关
function this:IsPass()
    return self.data and self.data.isPass or false;
end
--获取难度
function this:GetHardLv()
    return self.cfg and self.cfg.type;
end

--返回通关星级
function this:GetStar()
    return self.data and self.data.star or 0;
end

--获取条件
function this:GetNGrade()
    return self.data and self.data.data or nil;
end

--剧情关卡
function this:IsStory()
    return self.cfg and self.cfg.sub_type == DungeonFlagType.Story;
end

--图鉴怪物检测开启
function this:IsHisPass()
    return self.data and self.data.isHisPass
end

--返回行动次数上限
function this:GetActionNum()
    local num=0;
    if self.cfg then
        local winNum=10000
        local type = self.cfg.jWinCon[1];
		if type == 3 then
            winNum = tonumber(self.cfg.jWinCon[2]);
        end
        local loseNum=10000;
        for k,v in ipairs(self.cfg.jLostCon) do
            if v[1]==3 then
                loseNum=tonumber(v[2]);
                break;
            end
        end
        num=winNum<loseNum and winNum or loseNum;
    end
    return num;
end

--返回助战NPC列表
function this:GetAssistNPCList()
    local list=nil;
    if self.cfg and self.cfg.arrNPC then
        list=self.cfg.arrNPC;
    end
    return list;
end

function this:GetPassDesc()
    return self.cfg and self.cfg.passDesc
end

function this:GetLastChapterId()
    return self.cfg and self.cfg.lasChapterID
end

function this:GetLastChapterCfg()
    return Cfgs.MainLine:GetByID(self:GetLastChapterId())
end

function this:GetNextOpenDesc()
    return self.cfg and self.cfg.nextOpenDesc
end

function this:GetJumpId()
    return self.cfg and self.cfg.jumpId
end

return this;