--Spine测试
local roleItem;
local roleItem2;
local spineList=null;
local currCfg=nil;
local options={};
local lCanvas=nil;
local rCanvas=nil;

function Awake()
    roleItem = RoleTool.AddRole(LeftPos, nil, nil, false)	
    roleItem2 = RoleTool.AddRole(RightPos, nil, nil, false)	
    spineList = ComUtil.GetCom(Dropdown, "Dropdown");
    lCanvas=ComUtil.GetCom(LeftPos, "CanvasGroup");
    rCanvas=ComUtil.GetCom(RightPos, "CanvasGroup");
    spineList:ClearOptions()
    CSAPI.AddDropdownOptions(Dropdown, GetOptions())
    CSAPI.AddDropdownCallBack(Dropdown, OnDropValChange);
    CSAPI.AddSliderCallBack(slider,OnSliderChange);
    CSAPI.AddSliderCallBack(slider2,OnSlider2Change);
end

function GetOptions()
    local list={};
    options={};
    for k, v in pairs(Cfgs.character:GetAll()) do
        if v.l2dName~=nil and v.l2dName~="" then
            table.insert(list,tostring(v.id).."-"..v.desc)
            table.insert(options,v);
        end
    end
    if #options>=1 then
        currCfg=options[1];
    end
    return list;
end

function OnDropValChange(index)
    if index+1<=#options then
        currCfg=options[index+1];
    end
end

function OnSliderChange(val)
    local realSize=1-val;
    CSAPI.SetScale(LeftPos,realSize,realSize,realSize);
    CSAPI.SetScale(RightPos,realSize,realSize,realSize);
end

function OnSlider2Change(val)
    lCanvas.alpha=1-val;
    rCanvas.alpha=1-val;
end

function OnClickLoad()--加载新spine动画
    -- 初始化立绘
    roleItem.Refresh(currCfg.id, LoadImgType.Main,nil,true)
    roleItem2.Refresh(currCfg.id, LoadImgType.Main,function()
        CS.CSAPI.SetSpineMaterial(roleItem2.live2DItemLua.l2dGo,false);
    end,true)
end
