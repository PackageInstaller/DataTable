--战斗中的人物信息
local pos={-10.6,23};
local pos2={-10.6,40};
function Awake()
    slider=ComUtil.GetCom(hpSlider,"Slider");
end

function Init(charData)
    if charData then
        if charData.data.type==eDungeonCharType.Prop then
            --道具、buff
            local nameID = charData.cfg.name_id;
            if(nameID and nameID > 0)then
                CSAPI.SetText(txt_name,LanguageMgr:GetTips(nameID));
            else
                CSAPI.SetText(txt_name,charData.cfg.name);
            end            
            local descID = charData.cfg.desc_id;
            if(descID and descID > 0)then
                CSAPI.SetText(txt_fullDesc,LanguageMgr:GetTips(descID));
            else
                CSAPI.SetText(txt_fullDesc,charData.cfg.desc);
            end
            CSAPI.SetGOActive(hpBar,false);
            CSAPI.SetGOActive(txt_lv,false);
            CSAPI.SetGOActive(fightingObj,false);
            if charData.cfg.icon then
                ResUtil.RoleCard:Load(icon,charData.cfg.icon);
            end
            --读取icon
        elseif charData.data.type==eDungeonCharType.MyCard then
            --我方队伍
        else
            --敌方队伍
            CSAPI.SetGOActive(txt_lv,true);
            CSAPI.SetGOActive(hpBar,true);
            CSAPI.SetGOActive(fightingObj,true);
            local lvStr=string.format(LanguageMgr:GetTips(1009),charData.showLv)
            CSAPI.SetText(txt_lv,lvStr);
            CSAPI.SetText(txt_name,charData.cfg.name);
            CSAPI.SetText(txt_fullDesc,charData.cfg.desc);
            slider.value=charData.data.damage and 1-charData.data.damage or 1;
            CSAPI.SetGOActive(fightingObj,false);
            local modelCfg=Cfgs.character:GetByID(charData.cfgModel.id);
            ResUtil.RoleCard:Load(icon,modelCfg.icon);
        end
    end
end

function SetPos()

end

function OnClickMask()
    if closeFunc then
        closeFunc();
    end
    CSAPI.SetGOActive(gameObject,false);
end

function AddCloseCB(cb)
    closeFunc=cb;
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
txt_fullDesc=nil;
icon=nil;
txt_lv=nil;
txt_name=nil;
hpSlider=nil;
view=nil;
end
----#End#----