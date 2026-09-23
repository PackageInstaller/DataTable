--皮肤合集子物体
local list=nil;
local elseData=nil;
local items={}; --子物体
local delay=0;
local index=0;
local tweens=nil;

function Awake()
    tweens=ComUtil.GetComsInChildren(tweenObj,"ActionBase");
end

function Refresh(_d,_elseData)
    list=_d or {};
    elseData=_elseData;
    ItemUtil.AddItems("ShopSkinPage/SkinInfoItem", items, list, layout,OnClickItem,1,{flag=elseData.flag},function()
        SetDelay(index);
    end)
    if #list>=1 then
        local cfg=list[1]:GetSeasonCfg();
        CSAPI.SetGOActive(txt_tips,true);
        CSAPI.SetGOActive(txt_sort,true);
        CSAPI.SetGOActive(txt_desc,false)
            --设置标题
        CSAPI.SetText(txt_title,LanguageMgr:GetByID(cfg.LanguageID));
        CSAPI.SetText(txt_tips,LanguageMgr:GetByType(cfg.LanguageID,4));
        CSAPI.SetText(txt_sort,cfg.id>=10 and tostring(cfg.id) or "0"..cfg.id);
    end
end

function OnClickItem(tab)
    --打开详情界面
    if tab then
        local modelCfg=tab.data:GetModelCfg();
        local commodity=ShopCommFunc.GetSkinCommodity(modelCfg.id);
        local isShowImg=false;
        if commodity~=nil then
            isShowImg=commodity:IsShowImg();
        end
        CSAPI.OpenView("RoleInfoAmplification", {modelCfg.id, false,isShowImg},LoadImgType.Main)
    end
end

function SetDelay(idx)
    if tweens then
        for i=0,tweens.Length-1 do 
            local v=tweens[i]
            v.delay=(idx-1)*100;
            v:Play();
        end
    end
end

function SetIndex(idx)
    index=idx;
end