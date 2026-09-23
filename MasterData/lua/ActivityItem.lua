
function SetIndex(_index)
	index = _index
end
function SetClickCB(_cb)
	cb = _cb
end

function Refresh(data, b)
	local code = b and "0f0f19" or "929296"
	CSAPI.SetText(txtTitle, StringUtil:SetByColor(data:GetTitle(), code))
	CSAPI.SetText(txtSubTitle, StringUtil:SetByColor(data:GetSubTitle(), code))
	--local alpha = b and 255 or 51
	--CSAPI.SetImgColor(clickNode, 255, 255, 255, alpha, false)
	--local imgName = b and "btn_1_01.png" or "btn_1_02.png"
	--CSAPI.LoadImg(bg, "UIs/Activity/" .. imgName, true, nil, true)
	
	CSAPI.SetGOActive(bg1, b)
	CSAPI.SetGOActive(bg2, not b)
end

function OnClick()
	cb(index)
end
function OnDestroy()	
	ReleaseCSComRefs()
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	clickNode = nil;
	bg1 = nil;
	bg2 = nil;
	txtTitle = nil;
	txtSubTitle = nil;
	view = nil;
end
----#End#----
