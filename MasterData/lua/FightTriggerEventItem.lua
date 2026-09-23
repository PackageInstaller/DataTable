
--设置数据
function SetData(data)    
    --CSAPI.PlayUISound("ui_battle_interface_in");
    --CSAPI.MoveTo(bg,"move_attack_focus",0,0,0);
    isRemoved = false;
    FuncUtil:Call(Remove,nil,1500);
    if(data)then
        --local colorImgs = { "green","red","blue","purple","yellow" };
        --local fontImgs = { "w_cooperating","w_chase","w_counterattack","w_cover",nil };
        
        local character = data.character;
        if(character)then
            local cfg = character.GetCfgModel();  

            --ResUtil.RoleCard:Load(icon,cfg.icon );
            ResUtil.RoleCard:Load(icon, cfg.icon);
            CSAPI.LoadImg(tf, "UIs/Fight/tf" .. (character.IsEnemy() and 2 or 1)  .. ".png",true,nil,true);

            --local fontRes = fontImgs[data.typeIndex];

--            CSAPI.SetGOActive(fontImg,fontRes and true or false);

--            if(fontRes)then
--                CSAPI.LoadImg(fontImg, "UIs/Fight/" .. fontRes .. ".png",true,nil,true);                
--            end
            local events = StringUtil:split(LanguageMgr:GetByID(1079), ",") or {}
            local desc = data.desc or (data.typeIndex and events[data.typeIndex]);
            CSAPI.SetGOActive(fontTxt,desc ~= nil);

            if(desc)then
                CSAPI.SetText(fontTxt,desc);
            end
        end
    end
end

--function ApplyRemove()
--    --CSAPI.MoveTo(bg,"move_attack_focus",-200,0,0);
--    FuncUtil:Call(Remove,nil,500,gameObject);
--end

function Remove()
    if(isRemoved)then
        return;
    end
    CSAPI.RemoveGO(gameObject);
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
fontTxt=nil;
tf=nil;
icon=nil;
end
----#End#----