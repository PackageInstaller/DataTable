--防御部署item  CfgBAssault
--local colors = {"white", "blue", "yellow", "red"}  -- StringUtil:SetColor(str, colors[data.id])
local isLock = false
local colors = {"ffffff", "27b2ff", "FFC146", "ff0000"}
local iconNames = {"img_10_01", "img_10_02", "img_10_03", "img_10_04"}

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data, _curID)
	data = _data
	curID = _curID
	isSelect = not isLock and data.id == curID	
	isLock = data.plrLvl > PlayerClient:GetLv()
	
	--sel
	CSAPI.SetGOActive(sel, isSelect)
	CSAPI.SetImgColorByCode(sel, colors[data.id])
	--name
	CSAPI.SetText(txtName, StringUtil:SetByColor(data.sName, colors[data.id]))
	--desc
	CSAPI.SetText(txtDesc, data.sDesc and StringUtil:SetByColor(data.sDesc, colors[data.id]) or "")
	--lock
	CSAPI.SetGOActive(lock, isLock)
	if(isLock) then
		LanguageMgr:SetText(txtLock, 5003, data.plrLvl)
	end
	--icon
	CSAPI.LoadImg(icon, "UIs/Matrix/" .. iconNames[data.id] .. ".png", true, nil, true)
end

function OnClick()
	if(not isLock and data.id ~= curID and cb) then
		cb(data.id)
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
sel=nil;
txtName=nil;
txtDesc=nil;
icon=nil;
lock=nil;
txtLock=nil;
view=nil;
end
----#End#----