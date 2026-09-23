function Refresh(_data)
	data = _data
	if(data[2] == 0) then
		SetNil()
	elseif(data[2] == 1) then
		SetNormal()
	elseif(data[2] == 2) then
		SetCool()
	elseif(data[2] == 3) then
		SetLow()
	end
end

function SetNil()
	CSAPI.LoadImg(imgBg, "UIs/Menu/btn_6_7.png", true, nil, true)
	CSAPI.SetText(txtIndex, "")
end

function SetNormal()
	CSAPI.LoadImg(imgBg, "UIs/Menu/btn_6_4.png", true, nil, true)
	CSAPI.SetText(txtIndex, data[1] .. "")
	CSAPI.SetTextColorByCode(txtIndex, "0f0f19")
end 

function SetCool()
	CSAPI.LoadImg(imgBg, "UIs/Menu/btn_6_5.png", true, nil, true)
	CSAPI.SetText(txtIndex, data[1] .. "")
	CSAPI.SetTextColorByCode(txtIndex, "FFFFFF")
end 

function SetLow()
	CSAPI.LoadImg(imgBg, "UIs/Menu/btn_6_6.png", true, nil, true)
	CSAPI.SetText(txtIndex, data[1] .. "")
	CSAPI.SetTextColorByCode(txtIndex, "ff4574")
end 


-- function SetNil()
-- 	CSAPI.LoadImg(imgBg, "UIs/Menu/btn_6_3.png", true, nil, true)
-- 	CSAPI.SetImgColor(imgBg, 255, 255, 255, 75)
-- 	CSAPI.SetGOActive(imgLight, false)
-- 	CSAPI.SetText(txtIndex, "")
-- end

-- function SetNormal()
-- 	CSAPI.LoadImg(imgBg, "UIs/Menu/btn_6_4.png", true, nil, true)
-- 	CSAPI.SetImgColor(imgBg, 255, 255, 255, 255)
-- 	CSAPI.SetGOActive(imgLight, true)
-- 	CSAPI.SetImgColor(imgLight, 255, 193, 70, 255)
-- 	CSAPI.SetText(txtIndex, data[1] .. "")
-- 	CSAPI.SetTextColor(txtIndex, 0, 0, 0, 255)
-- end

-- function SetCool()
-- 	CSAPI.LoadImg(imgBg, "UIs/Menu/btn_6_1.png", true, nil, true)
-- 	CSAPI.SetImgColor(imgBg, 255, 255, 255, 255)
-- 	CSAPI.SetGOActive(imgLight, true)
-- 	CSAPI.SetImgColor(imgLight, 255, 255, 255, 255)
-- 	CSAPI.SetText(txtIndex, data[1] .. "")
-- 	CSAPI.SetTextColor(txtIndex, 255, 255, 255, 255)
-- end

-- function SetLow()
-- 	CSAPI.LoadImg(imgBg, "UIs/Menu/btn_6_1.png", true, nil, true)
-- 	CSAPI.SetImgColor(imgBg, 255, 78, 122, 255)
-- 	CSAPI.SetGOActive(imgLight, true)
-- 	CSAPI.SetImgColor(imgLight, 255, 78, 122, 255)
-- 	CSAPI.SetText(txtIndex, data[1] .. "")
-- 	CSAPI.SetTextColor(txtIndex, 255, 78, 122, 255)
-- end


function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
imgBg=nil;
txtIndex=nil;
view=nil;
end
----#End#----