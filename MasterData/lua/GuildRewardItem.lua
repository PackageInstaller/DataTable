--公会战奖励
local data 
local curIndex = 0

function Refresh(_data,_elseData)
    data = _data
    curIndex = _elseData
    items = items or {}
    
    if data then
        local rewardId = data.rewardId
        --预赛或决赛
        if curIndex == 1 or curIndex == 3 then
            local cfg = Cfgs.CfgGuildFightItemTb:GetByID(rewardId)
            local starIx = data.starIx
            local endIx = data.endIx or 0   

            --标题
            if endIx > 0 then
                CSAPI.SetText(txtTitle, starIx .. "~" .. endIx .. "名")
            else
                CSAPI.SetText(txtTitle, starIx - 1 .."名以下")
            end
            CSAPI.SetTextColor(txtTitle, 255, 255, 255, 255)

            --奖励
            if cfg and cfg.rewards then
                CSAPI.SetGOActive(svContent, true)
                GridAddRewards(items, cfg.rewards, svContent, 0.75, #cfg.rewards)
            else
                CSAPI.SetGOActive(svContent, false)
            end
        else
            local cfg = Cfgs.CfgMail:GetByID(rewardId)
            local rankGroup = data.rankGroup
            local isWin = data.isWin

            --标题
            local title = isWin and rankGroup .. "组胜方奖励" or rankGroup .. "组负方奖励"
            CSAPI.SetText(txtTitle, title .. "")
            if isWin then
                CSAPI.SetTextColor(txtTitle, 228, 187, 0, 255)
            else
                CSAPI.SetTextColor(txtTitle, 224, 92, 0, 255)
            end
            
            --奖励
            if cfg and cfg.rewards then
                CSAPI.SetGOActive(svContent, true)
                GridAddRewards(items, cfg.rewards, svContent, 0.75, #cfg.rewards)
            else
                CSAPI.SetGOActive(svContent, false)
            end
        end
    end
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
txtTitle=nil;
svContent=nil;
view=nil;
end
----#End#----