local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(info)
    self.info = info
end

function this:GetRank()
    return self.info and self.info.rank
end

function this:GetRankStr()
    return self.info and self.info.erank
end

function this:GetName()
    return self.info and self.info.name
end

function this:GetLevel()
    return self.info and self.info.level
end

function this:GetScore()
    return self.info and self.info.score or ""
end

function this:GetDamage()
    return self.info and self.info.nDamage or ""
end

function this:GetTurnNum()
    return self.info and self.info.turn_num or ""
end

function this:GetIconID()
    return self.info and self.info.icon_id
end

function this:GetFrameId()
    return self.info and self.info.icon_frame
end

function this:GetSex()
    return self.info and self.info.sel_card_ix or 1
end

function this:GetPassName()
    if self.info and self.info.dupId and self.info.dupId > 0 then
        local cfg = Cfgs.MainLine:GetByID(self.info.dupId)
        return cfg and cfg.chapterID or ""
    end
    return ""
end

function this:GetTitle()
    return self.info and self.info.icon_title
end

function this:GetCardList()
    return self.info and self.info.cardInfos
end

--难度（RogueT）
function this:GetHard()
    local dupId = self.info and self.info.dupId or nil 
    if(dupId)then 
        local cfg = Cfgs.DungeonGroup:GetByID(self.info.dupId)
        if(cfg and cfg.hard)then 
            return LanguageMgr:GetByID(54049,cfg.hard)
        end 
    end 
    return ""
end

function this:GetIconCard()
    return self.info and self.info.icon_card or 1
end

function this:GetUID()
    return self.info and self.info.uid or ""
end

return this