local cfg = nil
local data = nil
local sectionData = nil
local bossData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        bossData = GlobalBossMgr:GetData()
        SetRank()
    end
end

function SetRank()
    if GlobalBossMgr:GetRankIdx() > 0 then
        if (GlobalBossMgr.joinNum == nil or GlobalBossMgr.joinNum == 0) then
            if GlobalBossMgr:GetRankIdx() > 50 then
                 LanguageMgr:SetText(txtRank,70026)
            else
                LanguageMgr:SetText(txtRank,70021,GlobalBossMgr:GetRankIdx())
            end
        elseif GlobalBossMgr:GetRankIdx() < 4 then
            LanguageMgr:SetText(txtRank,70021,GlobalBossMgr:GetRankIdx())
        else
            LanguageMgr:SetText(txtRank,70021,GlobalBossMgr:GetRankStr(GlobalBossMgr:GetRankIdx()))
        end
    else
        LanguageMgr:SetText(txtRank,70017)
    end
end

function OnClickReward()
    if bossData then
        UIUtil:OpenRankView(bossData:GetRankView(),bossData:GetRankListInfo(),2)
        -- CSAPI.OpenView("GlobalBossList",{id = bossData:GetID()})
    end
end

function OnClickRank()
    if bossData then
        UIUtil:OpenRankView(bossData:GetRankView(),bossData:GetRankListInfo())
        -- CSAPI.OpenView("GlobalBossList",{id = bossData:GetID()},2)
    end
end