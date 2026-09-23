function Awake()
    tween = ComUtil.GetCom(val1, "ActionBase")
end

-- data={
--     id,  --属性的id，对应CfgCardPropertyEnum表中的id
--     val1, --显示的第一个数字
--     val2, --显示的第二个数字
--     val3，--显示的第二个中文 （val2 数字，val3 中文）
--     val1Color, --不设置默认为FFFFFF
--     val2Color, --不设置默认为1CFF7C
--     nobg,      --默认为false 
--	   nobg2,--默认为false，当存在背景图时，设置背景图是否显示
-- } 
function Refresh(_data)
    data = _data
    val1Color = data.val1Color and data.val1Color or "FFFFFF"
    val2Color = data.val2Color and data.val2Color or "00ffbf"
    val3Color = data.val3Color and data.val3Color or "00ffbf"

    CSAPI.SetGOActive(val1, data.val1 ~= nil)
    CSAPI.SetGOActive(val2, data.val2 ~= nil)
    CSAPI.SetGOActive(val3, data.val3 ~= nil)

    local cfg = Cfgs.CfgCardPropertyEnum:GetByID(data.id)

    -- icon
    --local iconName = data.nobg and string.format("%s_1", data.id) or
                         string.format("%s", data.id)
    local iconName = data.nobg and cfg.icon2 or cfg.icon                     
    if bg then -- 存在背景图片时
        CSAPI.SetGOActive(bg, not data.nobg2);
    end
    ResUtil.AttributeIcon:Load(icon,iconName);
    -- CSAPI.LoadImg(icon, iconName, true, nil, true)

    -- name
    SetName(cfg.sName);

    local str1 = ""
    local str2 = ""
    local str3 = ""
    -- val1
    if (cfg.sFieldName == "career") then
        if (data.val1) then
            str3 = StringUtil:SetByColor(data.val1, val1Color)
        end
    else
        if (data.val1) then
            str1 = StringUtil:SetByColor(data.val1, val1Color)
        end
    end
    -- val2
    if (data.val2) then
        str2 = StringUtil:SetByColor(data.val2, val2Color)
    end
    -- val3
    -- if(data.val3) then
    -- 	str2_2 = StringUtil:SetByColor(data.val3, val3Color)
    -- end
    SetVal1(str1);
    SetVal2(str2);
    SetVal2_2(data.val3);
    SetValStr(str3);

    -- arrow
    if (arrow) then
        CSAPI.SetGOActive(arrow, str3 == "" and str2 ~= "")
    end
end

function SetName(str)
    CSAPI.SetText(txtName, str == nil and "" or str)
end

function SetVal1(str)
    local num = StringUtil:GetStrNum(data.val1)
    if (data.val2 ~= nil and type(num) == "number") then
        tween.currentNum = num
        tween.targetNum = num + StringUtil:GetStrNum(data.val2)
        tween:Play()
    else
        if (type(num) == "number") then
            tween.currentNum = num
            tween.targetNum = num
        end
        CSAPI.SetText(val1, str == nil and "" or str)
    end
end

function SetVal2(str)
    CSAPI.SetText(val2, str == nil and "" or str)
end
function SetVal2_2(str)
    local b = StringUtil:IsEmpty(str)
    CSAPI.SetGOActive(val3, not b)
    if (not b) then
        local s = StringUtil:SetByColor(str, val3Color)
        CSAPI.SetText(val3, s)
    end
end

function SetValStr(str)
    CSAPI.SetText(valStr, str == nil and "" or str)
end
function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    icon = nil;
    txtName = nil;
    val1 = nil;
    val2 = nil;
    val3 = nil;
    valStr = nil;
    view = nil;
end
----#End#----
