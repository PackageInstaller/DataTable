
function Awake()
    txtName = ComUtil.GetCom(name,"Text");
    txtDesc = ComUtil.GetCom(desc,"Text");
    txtCD = ComUtil.GetCom(cdText,"Text");


    goSkillItem = ResUtil:CreateSkillItem(skillNode.transform);
    skillItem = ComUtil.GetLuaTable(goSkillItem);
    --skillItem.AddClickCallBack(OnClickSkillItem);
end

function InitItem(cfgSkill,skillData)


    CSAPI.SetGOActive(node,cfgSkill ~= nil);

    if(cfgSkill)then
        if(skillItem)then
            skillItem.InitItem(cfgSkill,skillData);
            skillItem.InitForPlayerSkill();
        end
    end
    
    local useState = skillItem and skillItem:Usable() == 1;

    CSAPI.SetGOActive(name,useState);
    CSAPI.SetGOActive(cdMask,not useState);
    if(skillData and skillData.cd)then
        txtCD.text = skillData.cd .. (LanguageMgr:GetByID(25045) or "");
    else
        txtCD.text = "";
    end
    

    local cfgSkillDesc = cfgSkill and Cfgs.CfgSkillDesc:GetByID(cfgSkill.id);
    txtName.text = cfgSkillDesc and cfgSkillDesc.name or "";
    txtDesc.text = cfgSkillDesc and cfgSkillDesc.desc or "";
end

function SetColorIndex(index)
    if(index == 1)then
        CSAPI.SetImgColor(itemBg,142,228,255,100);
    elseif(index == 2)then
        CSAPI.SetImgColor(itemBg,255,172,172,100);
    elseif(index == 3)then
        CSAPI.SetImgColor(itemBg,253,255,141,100);
    end
end

function AddClickCallBack(callBack)
    clickCallBack = callBack;    
end

function OnClickSkillItem(item)
    if(clickCallBack)then
        clickCallBack(item);
    end
    item.SetSelect(false);
end

function OnClick()
    OnClickSkillItem(skillItem)
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
node=nil;
itemBg=nil;
skillNode=nil;
num=nil;
name=nil;
desc=nil;
clickRange=nil;
cdText=nil;
cdMask=nil;
view=nil;
end
----#End#----