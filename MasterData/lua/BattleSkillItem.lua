--技能
local grid=nil;
local clickCB=nil;
function Refresh(cfg,idx,isSelect)
    this.cfg=cfg;
    this.index=idx;
    if grid==nil then
        ResUtil:CreateUIGOAsync("Skill/SkillItem",itemNode,function(go)
			grid = ComUtil.GetLuaTable(go)
            grid.InitItem(cfg);
            grid.AddClickCallBack(OnClickThis);
            CSAPI.SetGOActive(go, true)
		end)
    else
        grid.InitItem(cfg);
        grid.AddClickCallBack(OnClickThis);
    end
    SetSelect(isSelect);
end

function SetSelect(isSelect)
    CSAPI.SetGOActive(selObj,isSelect==true);
end

function SetCB(cb)
    clickCB=cb;
end

function OnClickThis()
    if clickCB then
        clickCB(this);
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
itemNode=nil;
selObj=nil;
view=nil;
end
----#End#----