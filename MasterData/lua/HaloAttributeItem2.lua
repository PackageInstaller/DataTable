-- 光环属性
-- data={
-- cfg --用于显示的属性枚举
-- addtive --用于显示的属性加成
-- lockStr
-- lockName --isLock为true时的显示
--     isLock,--是否显示锁定
--     isUnLock,--是否显示未锁定
-- desc --用于只显示该描述时
--     val1Color, --不设置默认为FFFFFF
-- val2Color,--不设置默认为FFFFFF
-- isShort,--是否短名称
-- } 
function Refresh(_data)
    data = _data
    val1Color = _data and _data.val1Color or "FFFFFF"
    val2Color = _data and _data.val2Color or "FFFFFF"
    if not IsNil(icon) and data.cfg then
        CSAPI.SetGOActive(icon, true);
		CSAPI.SetScale(icon,1,1,1);
        ResUtil.AttributeIcon:Load(icon, data.cfg.icon2);
    elseif not IsNil(icon) then
		CSAPI.SetScale(icon,0,0,0);     CSAPI.SetScale(icon,1,1,1);
        CSAPI.SetGOActive(icon, false);
    end

    if data.cfg ~= nil and data.isLock ~= true then
        CSAPI.SetGOActive(txtNum, true)
    else
        CSAPI.SetGOActive(txtNum, false)
    end

    CSAPI.SetGOActive(txtLv, data.isLock)

    local str1 = ""
    local str2 = ""
    local str3 = ""
    -- val1
    if data.cfg then
        local s = data.cfg.sName;
        if data.isShort then
            s = data.cfg.sName2;
        end
        str1 = StringUtil:SetByColor(s, val1Color)
    elseif data.desc then
        str1 = StringUtil:SetByColor(data.desc, val1Color)
    elseif data.lockName then
        str1 = StringUtil:SetByColor(data.lockName, val1Color)
    end
    -- val2
    if (data.addtive) then
        str2 = StringUtil:SetByColor("+"..data.addtive, val2Color)
    elseif data.lockStr then
        str3 = StringUtil:SetByColor(data.lockStr, val2Color)
    end
    -- name
    SetName(str1);
    SetNum(str2);
    SetLv(str3);
    SetLock(data.isLock);
    SetUnLock(data.isUnLock);
end

function SetIndex(i)
    CSAPI.SetGOActive(img, i % 2 == 1);
end

function SetName(str)
    CSAPI.SetText(txt1, str == nil and "" or str)
end

function SetNum(str)
    CSAPI.SetText(txtNum, str == nil and "" or str)
end

function SetLv(str)
    CSAPI.SetText(txtLv, str == nil and "" or str)
end

function SetLock(isLock)
    CSAPI.SetGOActive(lockObj, isLock == true);
end

function SetUnLock(isUnLock)
    if not IsNil(unLockObj) then
        CSAPI.SetGOActive(unLockObj, isUnLock == true);
    end
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
    txtNum = nil;
    txtLv = nil;
    lockObj = nil;
    view = nil;
end
----#End#----
