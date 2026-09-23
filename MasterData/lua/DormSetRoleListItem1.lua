--角色技能
function Refresh(_data)
	cfg = _data[1]
	isUse = _data[2]
	isLock = _data[3]
	local colorName = isUse and "FFC146" or "929296"
	--skill lv
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	local lv = string.format(lvStr.."<color=#ffc146>%s</color>", cfg.index)
	StringUtil:SetColorByName(txtLv, lv, "ffffff")
	--openLv
	local openLv = string.format("%s", cfg.roleLvMin)
	StringUtil:SetColorByName(txtFavo, openLv, "ffffff")
	--desc
	StringUtil:SetColorByName(txtDesc, cfg.desc, colorName)
	--lock
	--CSAPI.SetGOActive(lock, isLock)
	--alpha 

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
txtFavo=nil;
txtLv=nil;
txtDesc=nil;
view=nil;
end
----#End#----