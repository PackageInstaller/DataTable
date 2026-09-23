
local pList={};
local isDetails=true;
local layout
local detailsItems={};
function Awake()
    pList=ComUtil.GetComsInChildren(points,"Image");
    layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/SkillEffectPopup/SkillEffectPopup",LayoutCallBack,true)
end

function OnOpen()
    if data then
        SetDeatilsInfo();
        CSAPI.SetText(txt_name,data.sSkillType);
        CSAPI.SetImgColorByCode(light,EquipMgr:GetQualityColor(data.nQuality));
        local skillLevelInfo = Cfgs.CfgEquipSkill:GetGroup(data.group);
        local maxNum=skillLevelInfo==nil and 0 or #skillLevelInfo;
        CSAPI.SetText(txt_lv,string.format(LanguageMgr:GetByID(1033)..data.nLv).."/"..maxNum);
        -- CSAPI.SetText(txt_pointVal,tostring(data.nNeedVal).."PT");
        ResUtil.EquipSkillIcon:Load(icon,data.group);
        CSAPI.SetScale(icon,1,1,1);
        local skillLevelInfo = Cfgs.CfgEquipSkill:GetGroup(data.group);
        ItemUtil.AddItems("RoleEquip/EquipDescItem",detailsItems,skillLevelInfo,content,nil,1,{lv=data.nLv});
        -- CSAPI.SetText(txt_lvInfo,EquipCommon.GetDescFormat(data));
        CSAPI.SetText(simpleDesc,data.sShort);
        local cfgs=Cfgs.CfgEquipSkill:GetGroup(data.group);
        ResUtil.IconGoods:Load(grid,GridFrame[cfgs[1].nQuality]);
        for i=0,pList.Length-1 do
            local go=pList[i].gameObject;
            CSAPI.SetGOActive(go,i+1<=#cfgs);
            if i<=data.nLv-1 then
                CSAPI.SetImgColor(go,255,193,70,255);
            else
                CSAPI.SetImgColor(go,255,255,255,75);
            end
        end
       
    end
end

function LayoutCallBack(index)
    local item=layout:GetItemLua(index);
    local _data = skillEffs[index]
    item.Refresh(_data.sName,_data.color,_data.sDesc);
end


function OnClickSVType()
    isDetails=not isDetails;
    --切换描述节点
    SetDeatilsInfo();
end

function SetDeatilsInfo()
    CSAPI.SetGOActive(svOnObj,isDetails);
    CSAPI.SetGOActive(svOffObj,not isDetails);
    CSAPI.SetGOActive(simpleDesc,not isDetails);
    CSAPI.SetGOActive(detailsObj,isDetails);
    -- local c1=isDetails==true and {0,0,0,255} or {255,255,255,128};
    -- local c2=isDetails~=true and {0,0,0,255} or {255,255,255,128};
    -- CSAPI.SetTextColor(txt_detail,c1[1],c1[2],c1[3],c1[4]);
    -- CSAPI.SetTextColor(txt_simple,c2[1],c2[2],c2[3],c2[4]);
    local desc,cfgs=StringUtil:SkillDescFormat(data.sDesc);
    CSAPI.SetText(txt_desc,desc);
    if cfgs and isDetails then--生成额外的技能说明
        CSAPI.SetGOActive(child2,#cfgs>0);
        skillEffs=cfgs;
        if #skillEffs>0 then
            layout:IEShowList(#skillEffs);
        end
    else
        skillEffs=nil;
        CSAPI.SetGOActive(child2,false);
    end
end

function OnClickAnyway()
    view:Close();
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
bg_b1=nil;
root=nil;
top=nil;
icon=nil;
txt_name=nil;
txt_lvVal=nil;
points=nil;
detailsObj=nil;
txt_desc=nil;
txt_lvInfo=nil;
simpleDesc=nil;
svOnObj=nil;
svOffObj=nil;
txt_detail=nil;
txt_simple=nil;
child2=nil;
vsv=nil;
view=nil;
end
----#End#----