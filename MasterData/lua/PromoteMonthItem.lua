--月卡推荐
local monthId=40007;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Shop_MemberCard_Ret,OnMemberCardRet)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnMemberCardRet()
    local info=ShopMgr:GetMonthCardInfoByID(ITEM_ID.MonthCard);
    if info then
        LanguageMgr:SetText(txt_day,18035,tostring(info.l_cnt));
    end
end

function Refresh(_data)
    if _data then
        this.data=_data;
        if not this.data:GetImg() then
            ResUtil.StoreAd:Load(bg,"img_18_01");
        end
        --获取月卡状态
        local commodity=ShopMgr:GetFixedCommodity(monthId);
        if commodity and commodity:GetResetTime()>0 then
            local info=ShopMgr:GetMonthCardInfoByID(ITEM_ID.MonthCard);
            --显示购买按钮状态
            if info and info.l_cnt>0 then
                LanguageMgr:SetText(txt_day,18035,tostring(info.l_cnt));
                if info.l_cnt<=5 then--提前续费
                    CSAPI.SetGOActive(overObj,false);
                    CSAPI.SetGOActive(timeObj,true);
                    CSAPI.SetGOActive(btn_go,true);
                else
                    CSAPI.SetGOActive(overObj,true);
                    CSAPI.SetGOActive(timeObj,true);
                    CSAPI.SetGOActive(btn_go,false);
                end
            else
                CSAPI.SetGOActive(overObj,false);
                CSAPI.SetGOActive(timeObj,false);
                CSAPI.SetGOActive(btn_go,true);
            end
        else
            CSAPI.SetGOActive(overObj,false);
            CSAPI.SetGOActive(timeObj,false);
            CSAPI.SetGOActive(btn_go,true);
        end
    end
end

function OnClickGO()
    if this.data and this.data:GetJumpID() then
        JumpMgr:Jump(this.data:GetJumpID())
    end
end