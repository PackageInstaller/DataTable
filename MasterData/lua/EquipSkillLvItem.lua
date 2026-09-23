local group=nil;
-- local textMove=nil;
function Awake()
    group=ComUtil.GetCom(gameObject,"CanvasGroup");
    -- textMove=ComUtil.GetCom(descObj,"TextMove");
    CSAPI.SetGOActive(lvObj,false);
end

function Refresh(_data,_elseData)
    if _data then
        -- CSAPI.SetText(txt_lv,LanguageMgr:GetByID(1033));
        -- CSAPI.SetText(txt_lvVal,tostring(_data.nLv));
        CSAPI.SetText(txt_desc,_data.sDetailed);
        if _elseData then
            --当前激活的技能id
            SetLight(_elseData.isLight);
        else
            SetLight(false);
        end
    end
end

function SetClickCB(cb)

end


function ShowLine(isShow)
    CSAPI.SetGOActive(line,isShow);
end

function SetLight(isLight)
    local color=isLight and {255,193,70,255} or {255,255,255,255}
    CSAPI.SetTextColor(txt_desc,color[1],color[2],color[3],color[4]);
    CSAPI.SetTextColor(txt_lv,color[1],color[2],color[3],color[4]);
    CSAPI.SetTextColor(txt_lvVal,color[1],color[2],color[3],color[4]);
    -- if isLight then
    --     group.alpha=1;
    -- else
    --     group.alpha=0.5;
    -- end
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
descObj=nil;
txt_desc=nil;
lvObj=nil;
txt_lv=nil;
txt_lvVal=nil;
line=nil;
view=nil;
end
----#End#----