
function Refresh(data)
	LanguageMgr:SetText(txtInfo1, data[1].."")
	CSAPI.SetText(txtInfo2, data[2].."")
	--local code = data[3] < data[2] and "FF0040" or "ffffff"  
	StringUtil:SetColorByName(txtInfo3, data[3], "ffffff")
end

